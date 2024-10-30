Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86FE76025;
	Wed, 30 Oct 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323308; cv=none; b=EgW+hiTeEYYf+2aakCnLiaKVZ4oslHBr1fZadvuvspE8p7U1bklWPb9yMs7wJPglPTJ1SB+t2Al1+Xr/DZ6h7hURr74uWnpdYhC7XQsEnfr9/fZHp+bFnEvNDuZAFefnWRnnk2RyWdZvUcWM5Ge415OHAt9UzoABk7zCcnylbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323308; c=relaxed/simple;
	bh=MZxBNuATrdicFwJ312aZnhtkn7PF8So7r48yLB6hMT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mntsKurzOx3mg/u7XeeNUFnpcOyNbRFIuUQ4S6mjzF5YheZnVD9qtCUv9U9koms4qzNBEk9VQD6yTe/9O0ktZLHDmYg1Yle4dJ5l+AedEh2dbqQ3Rqudu5pNvxDNvtUOcdgL1vER7LNuClWhAcH40ADBBDl6rhwtnxfzwHLmMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyhqoX//; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyhqoX//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FCCC4CECE;
	Wed, 30 Oct 2024 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730323308;
	bh=MZxBNuATrdicFwJ312aZnhtkn7PF8So7r48yLB6hMT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyhqoX//akNUUVxdh7xwlbBHw5LAlaljOlMPS7LHxqG5QZ82McPNhI4Y7lozFeQhc
	 moEz/eCUrd+Kjq69KGcsWvaktdP8JIuOn/94XWUf1sqoo3KzulOe6XPUIxFXye3ypa
	 uH1eZnvN3vsmZYzLdvmqr38nO69ZCZwUYua3LawHhSLSe0pZ0cmFBcaGUOelJLGtU+
	 oV3WZH+x0OgTymCzmJ2lyYSEC3dRwhsB4mqg9oEPOz+quBh7Z6qJ7da7vOx/LQ7sAW
	 w0RLM/KeE9srMa13Eu22PCkV/ymTAGnT8IGRAO+Q/Ae4iKcfFdf95PUuqR4MmVkW47
	 pMo7Tkm6vAPCA==
Date: Wed, 30 Oct 2024 18:21:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Python module cleanup
Message-ID: <ZyKjabJ9zHRcx-rl@x1>
References: <20241029224431.167623-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029224431.167623-1-irogers@google.com>

On Tue, Oct 29, 2024 at 03:44:12PM -0700, Ian Rogers wrote:
> This patch:
>  - removes workarounds for Python 2 module support due to long
>    deprecation and challenges in developing new code;
>  - constifies variables and parameters to functions;
>  - removes python.c stub code which existed due to missing functions
>    that are defined in the builtin-* files, in general the builtin-*
>    code is moved into util;
>  - remove bench and test perf C code from the python module;
>  - adds parse_events to the python perf module.
>  - improves upon some of the existing python perf module functins.

I'll review later or tomorrow, but it passes preliminary testing modulo
a build test, see below:

root@number:/home/acme/git/perf-tools-next# export PYTHONPATH=/tmp/build/perf-tools-next/python/
root@number:/home/acme/git/perf-tools-next# strace -o /tmp/perf.openat.txt -e openat tools/perf/python/twatch.py 
<SNIP libperf debug messages>
cpu: 18, pid: 6023, tid: 6023 { type: fork, pid: 6023, ppid: 6023, tid: 707358, ptid: 6023, time: 94073002926291}
cpu: 21, pid: 6023, tid: 707358 { type: comm, pid: 6023, tid: 707358, comm: StreamT~s #1565 }
cpu: 21, pid: 6023, tid: 707358 { type: comm, pid: 6023, tid: 707358, comm: StreamT~s #1565 }
cpu: 9, pid: 624123, tid: 624123 { type: fork, pid: 624123, ppid: 624123, tid: 707359, ptid: 624123, time: 94073240462968}
cpu: 23, pid: 624123, tid: 707359 { type: comm, pid: 624123, tid: 707359, comm: StreamT~ns #509 }
cpu: 23, pid: 624123, tid: 707359 { type: comm, pid: 624123, tid: 707359, comm: StreamT~ns #509 }
cpu: 10, pid: 5800, tid: 707326 { type: exit, pid: 5800, ppid: 5554, tid: 707326, ptid: 5554, time: 94073371926048}
^CTraceback (most recent call last):
  File "/home/acme/git/perf-tools-next/tools/perf/python/twatch.py", line 61, in <module>
    main()
  File "/home/acme/git/perf-tools-next/tools/perf/python/twatch.py", line 33, in main
    evlist.poll(timeout = -1)
KeyboardInterrupt

root@number:/home/acme/git/perf-tools-next# 
root@number:/home/acme/git/perf-tools-next# grep perf.cpy /tmp/perf.openat.txt 
openat(AT_FDCWD, "/tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux-gnu.so", O_RDONLY|O_CLOEXEC) = 3
root@number:/home/acme/git/perf-tools-next# perf -v
perf version 6.12.rc3.g8f126aaf577f
root@number:/home/acme/git/perf-tools-next# 
logout
acme@number:~$ cd git/perf-tools-next/
acme@number:~/git/perf-tools-next$ 
acme@number:~/git/perf-tools-next$ git log --oneline -5
8f126aaf577fc14c (HEAD -> perf-tools-next) perf python: Correctly throw IndexError
c43f13fa5302c897 perf python: Add __str__ and __repr__ functions to evsel
ec01eeed20cae234 perf python: Add __str__ and __repr__ functions to evlist
33ba8db9526a525e perf python: Add parse_events function
e9d5ea61dd9ac48a perf build: Remove test library from python shared object
acme@number:~/git/perf-tools-next$

⬢ [acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
8f126aaf577fc14c (HEAD -> perf-tools-next) perf python: Correctly throw IndexError
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28  DESTDIR=/tmp/tmp.lNgk7LV5IW
              make_with_gtk2: cd . && make GTK2=1 -j28  DESTDIR=/tmp/tmp.l1z8oz3HTv
            make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.0rqszvPdKm DESTDIR=/tmp/tmp.wBzOcarpDh
cd . && make NO_LIBBPF=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.0rqszvPdKm DESTDIR=/tmp/tmp.wBzOcarpDh
  BUILD:   Doing 'make -j28' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h
  diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
  diff -u tools/include/linux/unaligned.h include/linux/unaligned.h
  diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
Makefile.config:687: Warning: Disabled BPF skeletons as libbpf is required
Makefile.config:979: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev
Makefile.config:1161: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

  GEN     /tmp/tmp.0rqszvPdKm/common-cmds.h
<SNIP>
 CC      /tmp/tmp.0rqszvPdKm/util/env.o
  CC      /tmp/tmp.0rqszvPdKm/tests/hists_link.o
  CC      /tmp/tmp.0rqszvPdKm/builtin-timechart.o
  CC      /tmp/tmp.0rqszvPdKm/tests/hists_filter.o
  CC      /tmp/tmp.0rqszvPdKm/bench/numa.o
util/env.c: In function ‘perf_env__arch_strerrno’:
util/env.c:479:38: error: implicit declaration of function ‘arch_syscalls__strerrno_function’ [-Wimplicit-function-declaration]
  479 |                 env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
      |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/env.c:479:36: error: assignment to ‘const char * (*)(int)’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  479 |                 env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
      |                                    ^
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/tmp.0rqszvPdKm/util/env.o] Error 1
make[6]: *** Waiting for unfinished jobs....


 
> v4. Rebase. Fix the parse events evsel to be embedded in a
>     pyrf_evsel. Add __str__/__repr__ functions to evlist and
>     evsel. Throw an exception for a bad evlist index.
> v3. Move is_directory_at to patch 6 rather than patch 7, respond to
>     review feedback on the list from Namhyung.
> v2. Add the bottom 4 bullet points - 13 more patches.
> 
> Ian Rogers (19):
>   perf python: Remove python 2 scripting support
>   perf python: Constify variables and parameters
>   perf python: Remove unused #include
>   perf script: Move scripting_max_stack out of builtin
>   perf kvm: Move functions used in util out of builtin
>   perf script: Move find_scripts to browser/scripts.c
>   perf stat: Move stat_config into config.c
>   perf script: Move script_spec code to trace-event-scripting.c
>   perf script: Move script_fetch_insn to trace-event-scripting.c
>   perf script: Move perf_sample__sprintf_flags to
>     trace-event-scripting.c
>   perf env: Move arch errno function to only use in env
>   perf lock: Move common lock contention code to new file
>   perf bench: Remove reference to cmd_inject
>   perf kwork: Make perf_kwork_add_work a callback
>   perf build: Remove test library from python shared object
>   perf python: Add parse_events function
>   perf python: Add __str__ and __repr__ functions to evlist
>   perf python: Add __str__ and __repr__ functions to evsel
>   perf python: Correctly throw IndexError
> 
>  tools/perf/Makefile.perf                      |   7 +-
>  tools/perf/bench/inject-buildid.c             |  13 +-
>  tools/perf/builtin-kvm.c                      |  61 ----
>  tools/perf/builtin-kwork.c                    |   3 +-
>  tools/perf/builtin-lock.c                     | 137 +------
>  tools/perf/builtin-script.c                   | 303 +---------------
>  tools/perf/builtin-stat.c                     |  27 --
>  tools/perf/builtin-trace.c                    |   1 -
>  tools/perf/builtin.h                          |   6 -
>  .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
>  tools/perf/tests/stat.c                       |  16 +-
>  tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
>  tools/perf/ui/browsers/scripts.c              | 177 ++++++++-
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/bpf_kwork.c                   |   2 +-
>  tools/perf/util/bpf_kwork_top.c               |   2 +-
>  tools/perf/util/bpf_lock_contention.c         |   2 +-
>  tools/perf/util/cgroup.c                      |   2 +-
>  tools/perf/util/config.c                      |  27 ++
>  tools/perf/util/dlfilter.c                    |   3 +-
>  tools/perf/util/env.c                         |   2 +
>  tools/perf/util/env.h                         |   2 -
>  tools/perf/util/evsel.c                       |  19 +-
>  tools/perf/util/evsel.h                       |   2 +-
>  tools/perf/util/kvm-stat.c                    |  70 ++++
>  tools/perf/util/kvm-stat.h                    |   3 +
>  tools/perf/util/kwork.h                       |   6 +-
>  tools/perf/util/lock-contention.c             | 170 +++++++++
>  tools/perf/util/lock-contention.h             |  37 +-
>  tools/perf/util/path.c                        |  10 +
>  tools/perf/util/path.h                        |   1 +
>  tools/perf/util/python.c                      | 338 ++++++++----------
>  .../scripting-engines/trace-event-python.c    |  63 +---
>  tools/perf/util/stat.h                        |   3 +-
>  tools/perf/util/trace-event-scripting.c       | 176 +++++++++
>  tools/perf/util/trace-event.h                 |   5 +-
>  36 files changed, 854 insertions(+), 867 deletions(-)
>  create mode 100644 tools/perf/util/kvm-stat.c
>  create mode 100644 tools/perf/util/lock-contention.c
> 
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
