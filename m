Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7193DB626;
	Wed, 22 Apr 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864386; cv=none; b=K4yp7tE5Hmm9IMZD5qU3OroeBXGhAUhB92E6Gt2vV7ifFExDF0RLzp8lsQ2PyEN33AHrDkZVhtPbUS6HfedaTPGiv+r4DOVY/uSjkI5PH7qMP17gip1lLwqqUmockMIbM6bDVxy8iF2UDRgpdeesp87k6xafrGkGE2zcdpLi5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864386; c=relaxed/simple;
	bh=WkAcuksjMl22QCJBa4R9hCIO2L/2KAGeLXa5d8LCHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UlyVxZ2HYA6331KOdS+vmONWt7bbultQWOL3mxVvRmmi7PD20wtJSeM5jkPqtxuD/L3am1zor56UeYvAhgpa2w5eyU7NdBZH1WSSeDgH+WldedwPVqLe3pv6FzoGf/ZuIt2bpBJ4vwPlgBg+N2ydnkM76TgE88DJ0SFg3PQFhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9EF76341F68;
	Wed, 22 Apr 2026 13:26:22 +0000 (UTC)
Date: Wed, 22 Apr 2026 15:26:18 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, libunwind-devel@nongnu.org
Subject: perf performance with libdw vs libunwind
Message-ID: <aejMem8Pt3iCxaka@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Dear Ian,

Now that linux-7.0 is out, I've updated perf in Gentoo and moved it
to use libdw, as libunwind has been deprecated. However, when I tried
to use perf, I noticed a substantial performance regression and some
other problems, which I report below.

I use here an example which is my own "standard candle"¹ for checking
that stack unwinding is working properly: the startup of ROOT², which
is a C++ interpreter heavily used in high energy physics data analysis.
I simply run 'root -l -q' which is the equivalent of 'python -c ""' for
ROOT. It takes less than a second to run, but since it runs a full
initialization of Clang/LLVM as part of the interpreter, it produces a
rich flamegraph that I know ahead of time how it should look like, so
I use it to check that stack unwinding and symbol resolution are working.

1. https://en.wikipedia.org/wiki/Cosmic_distance_ladder#Standard_candles
2. https://root.cern

Below I show a comparison of the timings of perf record/report for this.

First, I run it with perf-6.19.12 which is configured to use libunwind:

$ perf config
call-graph.record-mode=fp
$ perf -vv
perf version 6.19.12
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
        libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libLLVM: [ on  ]  # HAVE_LIBLLVM_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
$ time perf record -g -F max -e cycles:uk -- root.exe -l -q
info: Using a maximum frequency rate of 79800 Hz

[ perf record: Woken up 23 times to write data ]
[ perf record: Captured and wrote 5.688 MB perf.data (19693 samples) ]
1.25
$ time perf report -q --stdio -g none --children --percent-limit 75
    92.63%     0.00%  root.exe  libc.so.6             [.] __libc_start_call_main
    92.63%     0.00%  root.exe  libc.so.6             [.] __libc_start_main@@GLIBC_2.34
    92.63%     0.00%  root.exe  root.exe              [.] _start
    92.63%     0.00%  root.exe  root.exe              [.] main
    91.53%     0.01%  root.exe  libCore.so.6.38.04    [.] ROOT::GetROOT()
    89.36%     0.00%  root.exe  libRint.so.6.38.04    [.] TRint::TRint(char const*, int*, char**, void*, int, bool, bool)
    88.18%     0.00%  root.exe  libCore.so.6.38.04    [.] TApplication::TApplication(char const*, int*, char**, void*, int)
    88.10%     0.01%  root.exe  libCore.so.6.38.04    [.] ROOT::Internal::GetROOT2()
    88.08%     0.00%  root.exe  libCore.so.6.38.04    [.] TROOT::InitInterpreter()
    75.62%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpreter
    75.62%     0.00%  root.exe  libCling.so.6.38.04   [.] TCling::TCling(char const*, char const*, char const* const*, void*)

1.86
$ time perf script -c root.exe | ~/bin/stackcollapse.pl --all >| root-perf-6.19-libunwind.stacks
4.08
$ flamegraph.pl -w 2560 --title 'Flame Graph: ROOT Startup' --subtitle 'Created with perf-6.19.12 using libunwind' < root-perf-6.19-libunwind.stacks >| root-perf-6.19-libunwind.svg

So, as you can see above, a simple perf-report took 1.86 seconds, and
perf-script took 4.08 seconds with libunwind. Now with perf upgraded to
perf-7.0 with libdw, this is what I see:

$ perf -vv
perf version 7.0
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
         libbabeltrace: [ on  ]  # HAVE_LIBBABELTRACE_SUPPORT
        libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libLLVM: [ on  ]  # HAVE_LIBLLVM_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
                  rust: [ on  ]  # HAVE_RUST_SUPPORT
$ time perf record -g -F max -e cycles:uk -- root.exe -l -q
info: Using a maximum frequency rate of 79800 Hz

[ perf record: Woken up 23 times to write data ]
[ perf record: Captured and wrote 5.766 MB perf.data (19922 samples) ]
1.28
$ /usr/bin/time -v perf report -q --stdio -g none --children --percent-limit 75
    92.44%     0.00%  root.exe  root.exe              [.] main
    92.44%     0.00%  root.exe  root.exe              [.] _start
    92.44%     0.00%  root.exe  libc.so.6             [.] __libc_start_call_main
    87.95%     0.00%  root.exe  libCore.so.6.38.04    [.] GetROOT2 (inlined)
    75.78%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpreter

	Command being timed: "perf report -q --stdio -g none --children --percent-limit 75"
	User time (seconds): 250.33
	System time (seconds): 21.18
	Percent of CPU this job got: 99%
**	Elapsed (wall clock) time (h:mm:ss or m:ss): 4:32.97
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
**	Maximum resident set size (kbytes): 4433000
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 7
	Minor (reclaiming a frame) page faults: 9850739
	Voluntary context switches: 226
	Involuntary context switches: 11388
	Swaps: 0
	File system inputs: 80776
	File system outputs: 232
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

After seeing how much memory perf was using, I decided to record that
too, so as you can see above, perf 7.0 with libdw took 4 minutes and 33
seconds for the same simple perf-report that took 1.86 seconds before,
and the names of the symbols are not as complete as with libunwind.
Stack unwinding itself also seems inconsistent with the previous run.
Here's the equivalent with perf-6.19.12:

$ /usr/bin/time -v perf report -q --stdio -g none --children --percent-limit 75
    92.46%     0.00%  root.exe  libc.so.6             [.] __libc_start_call_main
    92.46%     0.00%  root.exe  libc.so.6             [.] __libc_start_main@@GLIBC_2.34
    92.46%     0.00%  root.exe  root.exe              [.] _start
    92.46%     0.00%  root.exe  root.exe              [.] main
    91.38%     0.01%  root.exe  libCore.so.6.38.04    [.] ROOT::GetROOT()
    89.24%     0.00%  root.exe  libRint.so.6.38.04    [.] TRint::TRint(char const*, int*, char**, void*, int, bool, bool)
    88.05%     0.01%  root.exe  libCore.so.6.38.04    [.] TApplication::TApplication(char const*, int*, char**, void*, int)
    87.96%     0.01%  root.exe  libCore.so.6.38.04    [.] ROOT::Internal::GetROOT2()
    87.95%     0.01%  root.exe  libCore.so.6.38.04    [.] TROOT::InitInterpreter()
    75.50%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpreter
    75.50%     0.00%  root.exe  libCling.so.6.38.04   [.] TCling::TCling(char const*, char const*, char const* const*, void*)


	Command being timed: "perf report -q --stdio -g none --children --percent-limit 75"
	User time (seconds): 1.79
	System time (seconds): 0.08
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.87
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 265108
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 37887
	Voluntary context switches: 4
	Involuntary context switches: 77
	Swaps: 0
	File system inputs: 0
	File system outputs: 8
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

Then, this is perf-script:

$ time perf script -c root.exe | ~/bin/stackcollapse.pl --all >| root-perf-7.0-libdw.stacks
cmd__addr2line /home/amadio/.debug/.build-id/30/d45df71aac8ef054ca89646b179487af641c45/elf: could not read first record
... (line repeated many times)
cmd__addr2line /home/amadio/.debug/.build-id/30/d45df71aac8ef054ca89646b179487af641c45/elf: could not read first record
273.49

I see many of these cms__addr2line errors, and it takes 273.49 seconds
compared with 4.08 seconds with perf-6.19.12, and the flamegraph has
abbreviated function names like "operator()" instead of the full name,
which is also somewhat problematic as there's loss of information
relative to what libunwind used to provide. The flamegraphs for the two
runs above are available at https://cern.ch/amadio/perf  I didn't want to
attach the files here as I don't want to send big files to the lists.
For the record, I am using libunwind-1.8.3 and elfutils-0.195 in these tests.

If you'd like to perform the same kind of test, you can install ROOT
from EPEL on a RHEL-like distribution inside a container with a simple
"dnf install root", or just try the same record/report commands with a
clang++ compilation of a simple program as a decent replacement.

Best regards,
-Guilherme
