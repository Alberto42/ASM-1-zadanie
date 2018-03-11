for (( i=0; i < 100000; i++ ))
do
	echo -n "Test numer "
	echo "$i"
	./gen $i file
	./main file
	let main_result=$?
	./main_cpp file
	let main_cpp_result=$?
	echo $main_result
	echo $main_cpp_result
	if [ $main_result == 0 ]; then
			echo "WOW Trafilismy na zero"
			cat file > zero_examples/$i.in
	fi
	if [ "$main_result" != "$main_cpp_result" ]; then
		break;
	fi
done
