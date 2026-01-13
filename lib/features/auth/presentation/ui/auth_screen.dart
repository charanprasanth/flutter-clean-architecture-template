////sample bloc
// BlocBuilder<AuthBloc, BaseState<void>>(
//   builder: (context, state) {
//     if (state is LoadingState) {
//       return const CircularProgressIndicator();
//     }

//     if (state is ErrorState) {
//       return Text(state.exception.message);
//     }

//     return ElevatedButton(
//       onPressed: () {
//         context.read<AuthBloc>().add(
//               LoginRequested(
//                 email: 'test@test.com',
//                 password: '123456',
//               ),
//             );
//       },
//       child: const Text('Login'),
//     );
//   },
// )