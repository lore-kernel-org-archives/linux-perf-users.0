From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: "perf record --pid <pid>" not able to colect data on processes
 quickly spawning and destroying threads
Date: Thu, 29 Jun 2017 23:14:06 -0300
Message-ID: <20170630021406.GD12064@kernel.org>
References: <CAERM-PjZvoW_Tq3yeYnHbMXG8dKg-S_E_xD-8ZUyVLbstPoU5A@mail.gmail.com>
 <c43fed2c-0e9a-9c1e-ebc7-6913f3c4c7e3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbdF3COK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jun 2017 22:14:10 -0400
Content-Disposition: inline
In-Reply-To: <c43fed2c-0e9a-9c1e-ebc7-6913f3c4c7e3@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Thu, Jun 29, 2017 at 03:33:46PM -0400, William Cohen escreveu:
> Hi,
> 
> There was a problem that came up with oprofile not being able to collect data on a running process that quickly creates and destroys threads.  I noticed that a similar problem also exists with "perf record" and the oprofile reproducer.  Using the perf from fedora 25 (perf-4.11.6-201.fc25.x86_64).  The reproducer, oprofile_multithread_test.c is in the forwarded email.  In one window build and start the reproducer:
> 
> 
> $ gcc -o oprofile_multithread_test oprofile_multithread_test.c -lpthread
> $  ./oprofile_multithread_test 
> Usage: oprofile_multithread_test <number of spawns> <number of threads> <number of operations per thread>
> $ ./oprofile_multithread_test -1 16 100000
> 
> In another window attempt to collect data:
> 
> $ perf record --pid `pgrep oprofile_mult`
> Error:
> The sys_perf_event_open() syscall returned with 3 (No such process) for event (cycles).
> /bin/dmesg may provide additional information.
> No CONFIG_PERF_EVENTS=y kernel support configured?
> 
 
> Note that if the oprofile_multithread_test is paused with a cntl-z
> when "perf record" is attaching and then oprofile_multithread_test is
> allowed to continue executing  "perf record" is able to get data, so
> it looks like there is an issue with the initial setup rather than
> later data collection.

Yeah, synthesizing events using /proc/data and setting up the events for
threads that go away needs to be made a bit more resilient, i.e.  we'll
need to try and add events for the pid and its children, ignoring the
above cases (races) so that new children will be noticed via the
PERF_RECORD_{FORK,COMM,MMAP} while the pre-existing just by looking at
/proc.

- Arnaldo
 
> -Will
> 
> 
> 
> -------- Forwarded Message --------
> Subject: 	Re: Potential deadlock in operf when using --pid
> Date: 	Fri, 2 Oct 2015 10:10:21 -0500
> From: 	大平怜 <rei.odaira@gmail.com>
> To: 	William Cohen <wcohen@redhat.com>
> CC: 	oprofile-list@lists.sourceforge.net
> 
> 
> 
> Sorry, I sent wrong source code.  I am attaching the right one.
> 
> 
> Regards,
> Rei Odaira
> 
> 2015-10-01 18:32 GMT-05:00 大平怜 <rei.odaira@gmail.com <mailto:rei.odaira@gmail.com>>:
> 
>     Hi Will,
> 
>     How about the attached test program?  This almost always causes the problem in my environment.
> 
>     > gcc -o oprofile_multithread_test oprofile_multithread_test.c -lpthread
>     > ./oprofile_multithread_test 
>     Usage: oprofile_multithread_test <number of spawns> <number of threads> <number of operations per thread>
>     > ./oprofile_multithread_test -1 16 100000
> 
>     In this example, oprofile_multithread_test spawns threads infinitely but runs maximum 16 threads simultaneously.  Each thread performs addition 100000 times and then completes.  Please use ^C to end this program if you specify -1 to the number of spawns.
> 
>     If you profile this program with operf --pid, I expect you will not be able to finish operf by a single ^C.
> 
> 
>     Regards,
>     Rei Odaira
> 
>     2015-10-01 15:42 GMT-05:00 William Cohen <wcohen@redhat.com <mailto:wcohen@redhat.com>>:
> 
>         On 09/30/2015 06:07 PM, 大平怜 wrote:
>         > Hello again,
>         >
>         > When using --pid, I have occasionally seen operf does not end by hitting ^C once. By hitting ^C multiple times, operf ends with error messages:
> 
>         Hi,
> 
>         I tried to replicate this on my local machine, but haven't seen it occur yet.  How often does it happen?  Also does it make a difference when the event sampling rate is changed?  There is just one monitored process and it isn't spawning new processes?
> 
>         >
>         > -----
>         > operf --events=CPU_CLK_UNHALTED:100000000:0:1:1 --pid `pgrep -f CassandraDaemon`
>         > Kernel profiling is not possible with current system config.
>         > Set /proc/sys/kernel/kptr_restrict to 0 to collect kernel samples.
>         > operf: Press Ctl-c or 'kill -SIGINT 18042' to stop profiling
>         > operf: Profiler started
>         > ^C^Cwaitpid for operf-record process failed: Interrupted system call
>         > ^Cwaitpid for operf-read process failed: Interrupted system call
>         > Error running profiler
>         > -----
>         >
>         > I am using the master branch in the git repository.
>         >
>         > Here is what I found:
>         > The operf-read process was waiting for a read of a sample ID from the operf-record process to return:
>         > (gdb) bt
>         > #0  0x00007fd90e0fa480 in __read_nocancel ()
>         >     at ../sysdeps/unix/syscall-template.S:81
>         > #1  0x0000000000412999 in read (__nbytes=8, __buf=0x7ffddc82b620,
>         >     __fd=<optimized out>) at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
>         > #2  __handle_fork_event (event=0x98e860) at operf_utils.cpp:125
>         > #3  OP_perf_utils::op_write_event (event=event@entry=0x98e860,
>         >     sample_type=<optimized out>) at operf_utils.cpp:834
>         > #4  0x0000000000417250 in operf_read::convertPerfData (
>         >     this=this@entry=0x648000 <operfRead>) at operf_counter.cpp:1147
>         > #5  0x000000000040a4cb in convert_sample_data () at operf.cpp:947
>         > #6  0x0000000000407482 in _run () at operf.cpp:625
>         > #7  main (argc=4, argv=0x7ffddc82be48) at operf.cpp:1539
>         >
>         > The operf-record process was waiting for a write of sample data to the operf-read process to complete.  Why did the write of the sample data block?  My guess is that the sample_data_pipe was full:
>         > (gdb) bt
>         > #0  0x00007fbe0dc9f4e0 in __write_nocancel ()
>         >     at ../sysdeps/unix/syscall-template.S:81
>         > #1  0x000000000040cd0e in OP_perf_utils::op_write_output (output=6,
>         >     buf=0x7fbe0e4e5140, size=32) at operf_utils.cpp:989
>         > #2  0x000000000040d605 in OP_perf_utils::op_get_kernel_event_data (
>         >     md=0xd3c7f0, pr=pr@entry=0xd07900) at operf_utils.cpp:1443
>         > #3  0x000000000041bc12 in operf_record::recordPerfData (this=0xd07900)
>         >     at operf_counter.cpp:846
>         > #4  0x00000000004098b8 in start_profiling () at operf.cpp:402
>         > #5  0x0000000000406305 in _run () at operf.cpp:596
>         > #6  main (argc=4, argv=0x7ffdc6fcde58) at operf.cpp:1539
>         >
>         > As a result, when I hit ^C, the operf main process sent SIGUSR1 to the operf-record process, in which the write returned with EINTR and simply got retried. Since the operf-record process did not end, the operf main process waited at waitpid(2) forever.
>         >
>         > Do you think my guess makes sense?  What would be a fundamental solution?  Simply extending the pipe size would not be appropriate....
> 
>         I am wondering if there are any other nuggets of information that can be gathered by using "--verbose debug,misc" and other "--verbose" variations on the operf command line.  It would be worthwhile to take a close look at the code in operf.cpp and see how ctl-c is being handled.  There could be a problem with the order that things are shutdown, causing the problem.  I noticed around line 406 and  of operf.cpp there is the following code:
> 
>         catch (const runtime_error & re) {
>                                 /* If the user does ctl-c, the operf-record process may get interrupted
>                                  * in a system call, causing problems with writes to the sample data pipe.
>                                  * So we'll ignore such errors unless the user requests debug info.
>                                  */
>                                 if (!ctl_c || (cverb << vmisc)) {
>                                         cerr << "Caught runtime_error: " << re.what() << endl;
>                                         exit_code = EXIT_FAILURE;
>                                 }
>                                 goto fail_out;
>                         }
> 
>         -Will
> 
> 
> 
> 
> 

> #include <stdio.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <string.h>
> #include <pthread.h>
> 
> static int num_ops;
> static pthread_t *thr_array;
> 
> 
> static void *
> thr_main(void *arg)
> {
>   int i;
>   int sum = 0;
> 
>   for (i = 0; i < num_ops; i++) {
>     sum += i;
>   }
> 
>   return (void *)(intptr_t)sum;
> }
> 
> static void
> spawn_thread(int thr)
> {
>   int ret;
> 
>   ret = pthread_create(&thr_array[thr], NULL, thr_main, NULL);
>   if (ret != 0) {
>     fprintf(stderr, "pthread_create: %s\n", strerror(ret));
>     exit(1);
>   }
> }
> 
> static void
> join_thread(int thr)
> {
>   int ret;
> 
>   ret = pthread_join(thr_array[thr], NULL);
>   if (ret != 0) {
>     fprintf(stderr, "pthread_join: %s\n", strerror(ret));
>     exit(1);
>   }
> }
> 
> int
> main(int argc, char *argv[])
> {
>   int num_spawns;
>   int num_threads;
>   int thr;
>   int thr_saved;
>   int ret;
>   int spawn_count;
> 
>   if (argc != 4) {
>     fprintf(stderr, "Usage: oprofile_multithread_test <number of spawns> <number of threads> <number of operations per thread>\n");
>     exit(1);
>   }
> 
>   num_spawns = atoi(argv[1]);
>   num_threads = atoi(argv[2]);
>   num_ops = atoi(argv[3]);
>   if (num_threads < 1) {
>     fprintf(stderr, "Number of threads must be positive.\n");
>     exit(1);
>   }
> 
>   thr_array = malloc(sizeof(pthread_t) * num_threads);
>   if (thr_array == NULL) {
>     fprintf(stderr, "Cannot allocate thr_array\n");
>     exit(1);
>   }
> 
>   spawn_count = 0;
>   for (thr = 0; thr < num_threads; thr++) {
>     spawn_thread(thr);
>     spawn_count++;
>   }
> 
>   thr = 0;
>   while  (num_spawns < 0 ? 1 /* infinite loop */ : spawn_count < num_spawns) {
>     join_thread(thr);
>     spawn_thread(thr);
>     thr = (thr + 1) % num_threads;
>     spawn_count++;
>   }
> 
>   thr_saved = thr;
>   do {
>     join_thread(thr);
>     thr = (thr + 1) % num_threads;    
>   } while (thr != thr_saved);
> 
>   free(thr_array);
> }

> ------------------------------------------------------------------------------
> 

> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
> 
