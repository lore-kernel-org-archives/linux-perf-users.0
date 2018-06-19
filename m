From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1]: perf tests: check that complex event name is parsed
 correctly
Date: Tue, 19 Jun 2018 10:54:28 -0300
Message-ID: <20180619135428.GE20477@kernel.org>
References: <ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jun 19, 2018 at 11:45:40AM +0300, Alexey Budankov escreveu:
> 
> Extend regression testing to cover case of complex event names enabled 
> by the patch "perf record: enable arbitrary event names thru name= modifier".
> 
> tools/perf/perf test
>  1: vmlinux symtab matches kallsyms                       : Skip
>  2: Detect openat syscall event                           : Ok
>  3: Detect openat syscall event on all cpus               : Ok
>  4: Read samples using the mmap interface                 : Ok
>  5: Test data source output                               : Ok
>  6: Parse event definition strings                        : Ok		<===!
>  7: Simple expression parser                              : Ok
> ...

Applied and added this to the commit log:

Committer testing:

  # perf test "event definition"
   6: Parse event definition strings                        : Ok
  # perf test -v 6 2> /tmp/before
  # perf test -v 6 2> /tmp/after
  # diff -u /tmp/before /tmp/after
  --- /tmp/before       2018-06-19 10:50:21.485572638 -0300
  +++ /tmp/after        2018-06-19 10:50:40.886572896 -0300
  @@ -1,6 +1,6 @@
    6: Parse event definition strings                        :
   --- start ---
  -test child forked, pid 24259
  +test child forked, pid 24904
   running test 0 'syscalls:sys_enter_openat'Using CPUID GenuineIntel-6-3D
   registering plugin: /root/.traceevent/plugins/plugin_kvm.so
   registering plugin: /root/.traceevent/plugins/plugin_hrtimer.so
  @@ -136,9 +136,11 @@
   running test 50 '4:0x6530160/name=numpmu/'
   running test 51 'L1-dcache-misses/name=cachepmu/'
   running test 52 'intel_pt//u'
  +running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
   running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
   running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
   running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
  +running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp'
   el-capacity -> cpu/event=0x54,umask=0x2/
   el-conflict -> cpu/event=0x54,umask=0x1/
   el-start -> cpu/event=0xc8,umask=0x1/
