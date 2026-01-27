Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4D35FF58;
	Tue, 27 Jan 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533213; cv=none; b=Ua8BM8WhE3OTXC2Iq3qGdYnc4aPNJI2isdF+idx1I5j5QFy+8IdaZ0hdRvhcY9xLqV5uSmSlVXiWWPUdcTFTdyFUu4fuzCvsOHSa63QN6QZvMtXFA0Z/TzRO06E+dC6kBFBnlCWADvxbaij4Kg5sgbIEPlIvvlixpxkTBnEut8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533213; c=relaxed/simple;
	bh=tfX05SI2kFswNjgccICbl8aXow5v7scVJgUrnyfDZWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWJmyFZj65XfWAMzD2IXDekkjRSIps1ONJqbJnBx1ytOTCdrR//6y0fKTewIrFZBfGa8FGsZswMIUHlMITnX3rdL1sKCWcRydAzyFstwMYw+I/DCy0WwdyYcCKF09taED9KCEX5uuVj4uiT5DSDpXxU/6HP0uNnc7DZuy9L98nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqQSBRFP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqQSBRFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B3FC16AAE;
	Tue, 27 Jan 2026 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769533212;
	bh=tfX05SI2kFswNjgccICbl8aXow5v7scVJgUrnyfDZWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqQSBRFPpJMfLRzvok9kAOCOTij5EAiSvs1DGlsU9Dn5HIpYDuV53mzqeutwrcMG9
	 Q+j3z8Gc9hL+YQklDngn9zGrQ5G1/ga/ILogupHPkxpZvxiJ+9AtWVCyL6Em/VkbWd
	 QPPb5Hynpe/FtYyGi9qpbcdrAVOqmK2owSbLKiEZDbNYM40kLmsyumFW0yAoFgayKv
	 e+KDiHThRs1DqZRFXv2RtUT3MnzEEzU+71g+dUOeaULmjXg1mlRMa24ZtObmZDu4i0
	 nywAm7oK1m/fVEL7cER805q0IU6fjChvM9hCHgwgzYTHhOQW6YiG6Ag2OxlXTXopYQ
	 Vv1Muw6gupHMA==
Date: Tue, 27 Jan 2026 14:00:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] perf tests: Test annotate with data type
 profiling and rust
Message-ID: <aXjvF3N5ZGJlZzFi@x1>
References: <20260127083030.5909-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127083030.5909-1-9erthalion6@gmail.com>

On Tue, Jan 27, 2026 at 09:30:27AM +0100, Dmitrii Dolgov wrote:
> Exercise the annotate command with data type profiling feature on the
> rust runtime:
 
> * Add a new type of workload code_with_type, which has a dummy rust
>   library linked with it. It's recommended that for such scenarios rust
>   library is statically linked [1].
 
> * Add a new shell test, which will profile the new workload, then
>   annotate the result expecting to see some data structures from the
>   rust code.

I think this should be split into at least two patchs, one introducing
the new workload and then the new perf test.

Trying it now it is failing for me on both an AMD 9950X3D with Fedora 43
and on a Gen Intel(R) Core(TM) i7-1365U Lenovo X1 Carbon notebook also
with Fedora 43, both with:

⬢ [acme@toolbx perf-tools-next]$ rustc --version
rustc 1.92.0 (ded5c06cf 2025-12-08) (Fedora 1.92.0-1.fc43)
⬢ [acme@toolbx perf-tools-next]$


Isn't that 'perf record' just using cycles? Wouldn't it be better to use
'perf mem record'?

Like:

acme@x1:~/git/perf-tools-next$ tools/perf/perf mem record perf test -w code_with_type
Error:
Failure to open event 'cpu_core/mem-loads,ldlat=30/u' on PMU 'cpu_core' which will be removed.
No fallback found for 'cpu_core/mem-loads,ldlat=30/u' for error 61
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.351 MB perf.data (4672 samples) ]
acme@x1:~/git/perf-tools-next$ perf evlist -v
cpu_atom/mem-loads,ldlat=30/Pu: type: 10 (cpu_atom), size: 144, config: 0x5d0 (mem_uops_retired.load_latency_gt_16), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
cpu_atom/mem-stores/Pu: type: 10 (cpu_atom), size: 144, config: 0x6d0 (mem_uops_retired.store_latency), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
cpu_core/mem-loads-aux/u: type: 4 (cpu_core), size: 144, config: 0x8203 (mem-loads-aux), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
cpu_core/mem-stores/Pu: type: 4 (cpu_core), size: 144, config: 0x2cd (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
dummy:u: type: 1 (PERF_TYPE_SOFTWARE), size: 144, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, build_id: 1
# Tip: use 'perf evlist -g' to show group information
acme@x1:~/git/perf-tools-next$

Then:

perf annotate --code-with-type 

And one of the functions on the TUI is:

Samples: 4K of events 'anon group { cpu_core/mem-loads-aux/u, cpu_core/mem-stores/Pu }', 4000 Hz, Event count (approx.): 2746033426
alloc::raw_vec::RawVecInner<A>::with_capacity_in  /home/acme/git/perf-tools-next/tools/perf/perf [Percent: local period] [Type]


[Type] is there, matching --code-with-type, but I see no types in the
annotation output., even with { cpu_core/mem-loads-aux/u, cpu_core/mem-stores/Pu }

Now on the 9950X3D, AMD, using IBS:

acme@number:~/git/perf-tools-next$ tools/perf/perf mem record perf test -w code_with_type
Error:
Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
No fallback found for 'ibs_op/ldlat=0/u' for error 22
Error:
Failure to open any events for recording.
acme@number:~/git/perf-tools-next$ sudo tools/perf/perf mem record perf test -w code_with_type
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.307 MB perf.data (4005 samples) ]
acme@number:~/git/perf-tools-next$ sudo tools/perf/perf annotate --code-with-type
File perf.data not owned by current user or root (use -f to override)
acme@number:~/git/perf-tools-next$ sudo tools/perf/perf annotate -f --code-with-type

Again, [Type] is there, but no types:

Samples: 4K of event 'ibs_op/ldlat=0/', 4000 Hz, Event count (approx.): 5414001952
test_rs  /home/acme/git/perf-tools-next/tools/perf/perf [Percent: local period] [Type]
   0.14 │       sub    $0x98,%rsp                                                                                                                                       ◆
        │       mov    %edi,0x2c(%rsp)                                                                                                                                  ▒
        │       mov    %edi,0x84(%rsp)                                                                                                                                  ▒
        │       lea    _IO_stdin_used+0x20,%rsi                                                                                                                         ▒
   0.07 │       lea    0x60(%rsp),%rdi                                                                                                                                  ▒
   0.07 │       mov    $0x4,%edx                                                                                                                                        ▒
        │     → call   <alloc::string::String as core::convert::From<&str>>::f

I'm not managing to reproduce your results, can you please elaborate
some more?

- Arnaldo

The tests with your patch as-is:


⬢ [acme@toolbx perf-tools-next]$ m
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                               libpython: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]
...                              libopenssl: [ on  ]

  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  INSTALL libapi_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  AR      /tmp/build/perf-tools-next/libpmu-events.a
make[5]: *** No rule to make target '/tmp/build/perf-tools-next/tests/workloads/libcode_with_type.a', needed by '/tmp/build/perf-tools-next/tests/workloads/perf-test-in.o'.  Stop.
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:156: workloads] Error 2
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:156: tests] Error 2
make[2]: *** [Makefile.perf:784: /tmp/build/perf-tools-next/perf-test-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:288: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$

I don't have rust installed in this container, in this case we need some
sort of capability query to tell the user that rust is needed for this
feature to be present in perf.

Lemme try installing it:

$ sudo dnf install rust

Not enough.

I see, it doesn't work if I use 'make O=/some/directory/ -C tools/perf'

Worked when I did:

make -C tools/perf

Where it ended up doing:

  CC      util/namespaces.o
  CC      util/comm.o
  CC      util/thread.o
  CC      util/threads.o
  CC      util/thread_map.o
  rustc  tests/workloads/libcode_with_type.a
  CC      util/parse-events-bison.o
  BISON   util/pmu-bison.c


⬢ [acme@toolbx perf-tools-next]$ tools/perf/perf test "data type profiling"
 83: perf data type profiling tests                                  : FAILED!
⬢ [acme@toolbx perf-tools-next]$ tools/perf/perf test -v "data type profiling"
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
--- start ---
test child forked, pid 1455079
Basic perf annotate test
Basic annotate [Failed: missing target data type]
 Percent |	Source code & Disassembly of perf for cpu/cycles/Pu (1718 samples, percent: local period)
---------------------------------------------------------------------------------------------------------
         : 0      0x55bcb0 <test_rs>:
    0.00 :   55bcb0:        subq    $0x98, %rsp
    0.24 :   55bcb7:        movl    %edi, 0x2c(%rsp)
    0.12 :   55bcbb:        movl    %edi, 0x84(%rsp)
    0.00 :   55bcc2:        leaq    0x22b557(%rip), %rsi  # 0x787220
    0.00 :   55bcc9:        leaq    0x60(%rsp), %rdi
    0.00 :   55bcce:        movl    $0x4, %edx
    0.00 :   55bcd3:        callq   0x55baf0 <<alloc::string::String as core::convert::From<&str>>::from>
    0.06 :   55bcd8:        jmp     0x55bce0 <test_rs+0x30>
    0.00 :   55bcda:        callq   *0xa493b0(%rip)  # 0xfa5090 <_DYNAMIC+0x650>
    0.00 :   55bce0:        movl    0x2c(%rsp), %esi
    0.00 :   55bce4:        movq    $0x0, 0x48(%rsp)
    0.00 :   55bced:        movq    0x70(%rsp), %rax
    0.06 :   55bcf2:        movq    %rax, 0x40(%rsp)
    0.00 :   55bcf7:        movups  0x60(%rsp), %xmm0
    8.01 :   55bcfc:        movaps  %xmm0, 0x30(%rsp)
    0.00 :   55bd01:        movq    $0x0, 0x50(%rsp)
    0.00 :   55bd0a:        movl    $0x1, %edi
    0.00 :   55bd0f:        callq   0x55bae0 <<I as core::iter::traits::collect::IntoIterator>::into_iter>
    0.00 :   55bd14:        movl    %edx, 0x24(%rsp)
    0.00 :   55bd18:        movl    %eax, 0x28(%rsp)
    0.00 :   55bd1c:        jmp     0x55bd40 <test_rs+0x90>
    0.00 :   55bd1e:        leaq    0x30(%rsp), %rdi
    0.00 :   55bd23:        callq   0x55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.00 :   55bd28:        jmp     0x55bd95 <test_rs+0xe5>
    0.00 :   55bd2a:        movq    %rax, %rcx
    0.00 :   55bd2d:        movl    %edx, %eax
    0.00 :   55bd2f:        movq    %rcx, 0x88(%rsp)
    0.00 :   55bd37:        movl    %eax, 0x90(%rsp)
    0.00 :   55bd3e:        jmp     0x55bd1e <test_rs+0x6e>
    0.00 :   55bd40:        movl    0x24(%rsp), %eax
    0.00 :   55bd44:        movl    0x28(%rsp), %ecx
    0.00 :   55bd48:        movl    %ecx, 0x7c(%rsp)
    0.00 :   55bd4c:        movl    %eax, 0x80(%rsp)
    0.22 :   55bd53:        leaq    0x7c(%rsp), %rdi
   70.17 :   55bd58:        callq   0x55b820 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
    0.00 :   55bd5d:        movl    %eax, 0x20(%rsp)
   19.94 :   55bd61:        jmp     0x55bd63 <test_rs+0xb3>
    0.00 :   55bd63:        movl    0x20(%rsp), %eax
    0.62 :   55bd67:        movl    %eax, %eax
    0.00 :   55bd69:        testq   $0x1, %rax
    0.00 :   55bd6f:        je      0x55bd89 <test_rs+0xd9>
    0.00 :   55bd71:        movq    0x48(%rsp), %rcx
    0.00 :   55bd76:        movq    %rcx, %rax
    0.12 :   55bd79:        addq    $0x1, %rax
    0.00 :   55bd7d:        movq    %rax, 0x18(%rsp)
    0.00 :   55bd82:        cmpq    %rcx, %rax
    0.00 :   55bd85:        jb      0x55bdcd <test_rs+0x11d>
    0.00 :   55bd87:        jmp     0x55bdb9 <test_rs+0x109>
    0.00 :   55bd89:        leaq    0x30(%rsp), %rdi
    0.06 :   55bd8e:        callq   0x55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.06 :   55bd93:        jmp     0x55bdb1 <test_rs+0x101>
    0.00 :   55bd95:        callq   *0xa492f5(%rip)  # 0xfa5090 <_DYNAMIC+0x650>
    0.00 :   55bd9b:        movq    %rax, %rcx
    0.00 :   55bd9e:        movl    %edx, %eax
    0.00 :   55bda0:        movq    %rcx, 0x88(%rsp)
    0.00 :   55bda8:        movl    %eax, 0x90(%rsp)
    0.00 :   55bdaf:        jmp     0x55bd95 <test_rs+0xe5>
    0.00 :   55bdb1:        addq    $0x98, %rsp
    0.00 :   55bdb8:        retq
    0.00 :   55bdb9:        movq    0x18(%rsp), %rax
    0.00 :   55bdbe:        movq    %rax, 0x48(%rsp)
    0.00 :   55bdc3:        cmpq    $0x7b, 0x48(%rsp)
    0.05 :   55bdc9:        je      0x55bde1 <test_rs+0x131>
    0.00 :   55bdcb:        jmp     0x55bdf9 <test_rs+0x149>
    0.00 :   55bdcd:        leaq    0xa3fc44(%rip), %rdi  # 0xf9ba18
    0.00 :   55bdd4:        leaq    -0x150ffb(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55bddb:        callq   *%rax
    0.00 :   55bddd:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55bddf:        ud2
    0.00 :   55bde1:        movq    0x48(%rsp), %rcx
    0.00 :   55bde6:        movq    %rcx, %rax
    0.00 :   55bde9:        addq    $0x1, %rax
    0.00 :   55bded:        movq    %rax, 0x10(%rsp)
    0.00 :   55bdf2:        cmpq    %rcx, %rax
    0.00 :   55bdf5:        jb      0x55be21 <test_rs+0x171>
    0.00 :   55bdf7:        jmp     0x55be15 <test_rs+0x165>
    0.00 :   55bdf9:        movq    0x48(%rsp), %rdx
    0.06 :   55bdfe:        movq    0x50(%rsp), %rcx
    0.00 :   55be03:        movq    %rcx, %rax
    0.00 :   55be06:        addq    %rdx, %rax
    0.00 :   55be09:        movq    %rax, 0x8(%rsp)
    0.06 :   55be0e:        cmpq    %rcx, %rax
    0.00 :   55be11:        jb      0x55be42 <test_rs+0x192>
    0.00 :   55be13:        jmp     0x55be33 <test_rs+0x183>
    0.00 :   55be15:        movq    0x10(%rsp), %rax
    0.00 :   55be1a:        movq    %rax, 0x48(%rsp)
    0.00 :   55be1f:        jmp     0x55bdf9 <test_rs+0x149>
    0.00 :   55be21:        leaq    0xa3fc08(%rip), %rdi  # 0xf9ba30
    0.00 :   55be28:        leaq    -0x15104f(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be2f:        callq   *%rax
    0.00 :   55be31:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55be33:        movq    0x8(%rsp), %rax
    0.16 :   55be38:        movq    %rax, 0x50(%rsp)
    0.00 :   55be3d:        jmp     0x55bd53 <test_rs+0xa3>
    0.00 :   55be42:        leaq    0xa3fbff(%rip), %rdi  # 0xf9ba48
    0.00 :   55be49:        leaq    -0x151070(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be50:        callq   *%rax
    0.00 :   55be52:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55be54:        callq   *0xa49c2e(%rip)  # 0xfa5a88 <_DYNAMIC+0x1048>
 Percent |	Source code & Disassembly of perf for cpu/cycles/Pu (1050 samples, percent: local period)
---------------------------------------------------------------------------------------------------------
         : 0      0x55bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>:
    0.00 :   55bc40:        subq    $0x38, %rsp
   17.94 :   55bc44:        movq    %rdi, 0x8(%rsp)
    0.00 :   55bc49:        movq    %rdi, 0x18(%rsp)
    3.18 :   55bc4e:        movq    %rdi, %rax
    0.00 :   55bc51:        addq    $0x4, %rax
    0.00 :   55bc55:        movq    %rdi, 0x28(%rsp)
    0.00 :   55bc5a:        movq    %rax, 0x30(%rsp)
    0.08 :   55bc5f:        movl    (%rdi), %eax
    0.92 :   55bc61:        cmpl    0x4(%rdi), %eax
    0.00 :   55bc64:        jb      0x55bc70 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x30>
    0.00 :   55bc66:        movl    $0x0, 0x10(%rsp)
    0.00 :   55bc6e:        jmp     0x55bca2 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x62>
    0.00 :   55bc70:        movq    0x8(%rsp), %rax
    1.82 :   55bc75:        movl    (%rax), %edi
    0.08 :   55bc77:        movl    %edi, 0x4(%rsp)
    0.00 :   55bc7b:        movl    %edi, 0x24(%rsp)
    0.00 :   55bc7f:        movl    $0x1, %esi
    0.00 :   55bc84:        callq   0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>
    0.08 :   55bc89:        movq    0x8(%rsp), %rcx
   73.65 :   55bc8e:        movl    %eax, %edx
    0.00 :   55bc90:        movl    0x4(%rsp), %eax
    0.00 :   55bc94:        movl    %edx, (%rcx)
    0.27 :   55bc96:        movl    %eax, 0x14(%rsp)
    1.58 :   55bc9a:        movl    $0x1, 0x10(%rsp)
    0.00 :   55bca2:        movl    0x10(%rsp), %eax
    0.08 :   55bca6:        movl    0x14(%rsp), %edx
    0.33 :   55bcaa:        addq    $0x38, %rsp
    0.00 :   55bcae:        retq
 Percent |	Source code & Disassembly of perf for cpu/cycles/Pu (708 samples, percent: local period)
--------------------------------------------------------------------------------------------------------
         : 0      0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>:
   25.56 :   55b140:        subq    $0x28, %rsp
   64.05 :   55b144:        movl    %edi, 0xc(%rsp)
    0.12 :   55b148:        movl    %edi, 0x14(%rsp)
    0.00 :   55b14c:        movq    %rsi, 0x18(%rsp)
    0.00 :   55b151:        movl    %esi, %eax
    0.00 :   55b153:        movl    %eax, 0x10(%rsp)
    0.43 :   55b157:        movl    %eax, 0x24(%rsp)
    0.00 :   55b15b:        movl    0x10(%rsp), %esi
    0.52 :   55b15f:        movl    0xc(%rsp), %edi
    0.00 :   55b163:        leaq    0xa40826(%rip), %rdx  # 0xf9b990
    0.00 :   55b16a:        callq   0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>
    0.00 :   55b16f:        movl    0x10(%rsp), %ecx
    0.00 :   55b173:        movl    0xc(%rsp), %eax
    0.00 :   55b177:        addl    %ecx, %eax
    0.00 :   55b179:        addq    $0x28, %rsp
    9.32 :   55b17d:        retq
Pipe perf annotate test
Pipe annotate [Failed: missing target data type]
 Percent |	Source code & Disassembly of perf for cpu/cycles/Pu (1824 samples, percent: local period)
---------------------------------------------------------------------------------------------------------
         : 0      0x55bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>:
    0.00 :   55bc40:        subq    $0x38, %rsp
   15.47 :   55bc44:        movq    %rdi, 0x8(%rsp)
    0.00 :   55bc49:        movq    %rdi, 0x18(%rsp)
    3.89 :   55bc4e:        movq    %rdi, %rax
    0.00 :   55bc51:        addq    $0x4, %rax
    0.00 :   55bc55:        movq    %rdi, 0x28(%rsp)
    0.00 :   55bc5a:        movq    %rax, 0x30(%rsp)
    0.00 :   55bc5f:        movl    (%rdi), %eax
    7.62 :   55bc61:        cmpl    0x4(%rdi), %eax
    0.00 :   55bc64:        jb      0x55bc70 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x30>
    0.00 :   55bc66:        movl    $0x0, 0x10(%rsp)
    0.00 :   55bc6e:        jmp     0x55bca2 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x62>
    0.00 :   55bc70:        movq    0x8(%rsp), %rax
   28.40 :   55bc75:        movl    (%rax), %edi
    0.00 :   55bc77:        movl    %edi, 0x4(%rsp)
    0.00 :   55bc7b:        movl    %edi, 0x24(%rsp)
    0.00 :   55bc7f:        movl    $0x1, %esi
    0.00 :   55bc84:        callq   0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>
    0.05 :   55bc89:        movq    0x8(%rsp), %rcx
   40.94 :   55bc8e:        movl    %eax, %edx
    0.00 :   55bc90:        movl    0x4(%rsp), %eax
    0.00 :   55bc94:        movl    %edx, (%rcx)
    0.00 :   55bc96:        movl    %eax, 0x14(%rsp)
    3.62 :   55bc9a:        movl    $0x1, 0x10(%rsp)
    0.00 :   55bca2:        movl    0x10(%rsp), %eax
    0.00 :   55bca6:        movl    0x14(%rsp), %edx
    0.00 :   55bcaa:        addq    $0x38, %rsp
    0.00 :   55bcae:        retq
 Percent |	Source code & Disassembly of perf for cpu/cycles/Pu (871 samples, percent: local period)
--------------------------------------------------------------------------------------------------------
         : 0      0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>:
    0.00 :   55b190:        subq    $0x68, %rsp
   21.36 :   55b194:        movl    %edi, %eax
   78.52 :   55b196:        movq    %rdx, (%rsp)
    0.00 :   55b19a:        movl    %eax, 0x48(%rsp)
    0.00 :   55b19e:        movl    %esi, 0x4c(%rsp)
    0.00 :   55b1a2:        leaq    0x2922af(%rip), %rcx  # 0x7ed458
    0.00 :   55b1a9:        movq    %rcx, 0x50(%rsp)
    0.00 :   55b1ae:        movq    $0xb8, 0x58(%rsp)
    0.00 :   55b1b7:        movl    %eax, %edi
    0.00 :   55b1b9:        addl    %esi, %edi
    0.00 :   55b1bb:        cmpl    %eax, %edi
    0.00 :   55b1bd:        jb      0x55b1c4 <core::num::<impl u32>::unchecked_add::precondition_check+0x34>
    0.00 :   55b1bf:        addq    $0x68, %rsp
    0.11 :   55b1c3:        retq
    0.00 :   55b1c4:        movq    (%rsp), %rdx
    0.00 :   55b1c8:        leaq    0x292289(%rip), %rax  # 0x7ed458
    0.00 :   55b1cf:        movq    %rax, 0x38(%rsp)
    0.00 :   55b1d4:        movq    $0xb8, 0x40(%rsp)
    0.00 :   55b1dd:        leaq    0x38(%rsp), %rax
    0.00 :   55b1e2:        movq    %rax, 0x60(%rsp)
    0.00 :   55b1e7:        leaq    0x38(%rsp), %rax
    0.00 :   55b1ec:        movq    %rax, 0x8(%rsp)
    0.00 :   55b1f1:        movq    $0x1, 0x10(%rsp)
    0.00 :   55b1fa:        movq    0x27efdf(%rip), %rcx  # 0x7da1e0
    0.00 :   55b201:        movq    0x27efe0(%rip), %rax  # 0x7da1e8
    0.00 :   55b208:        movq    %rcx, 0x28(%rsp)
    0.00 :   55b20d:        movq    %rax, 0x30(%rsp)
    0.00 :   55b212:        movl    $0x8, %eax
    0.00 :   55b217:        movq    %rax, 0x18(%rsp)
    0.00 :   55b21c:        movq    $0x0, 0x20(%rsp)
    0.00 :   55b225:        leaq    0x8(%rsp), %rdi
    0.00 :   55b22a:        xorl    %esi, %esi
    0.00 :   55b22c:        callq   *0xa4ad96(%rip)  # 0xfa5fc8 <_DYNAMIC+0x1588>
 Percent |	Source code & Disassembly of perf for cpu/cycles/Pu (708 samples, percent: local period)
--------------------------------------------------------------------------------------------------------
         : 0      0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>:
   18.36 :   55b140:        subq    $0x28, %rsp
   78.53 :   55b144:        movl    %edi, 0xc(%rsp)
    0.00 :   55b148:        movl    %edi, 0x14(%rsp)
    0.00 :   55b14c:        movq    %rsi, 0x18(%rsp)
    0.00 :   55b151:        movl    %esi, %eax
    0.00 :   55b153:        movl    %eax, 0x10(%rsp)
    3.11 :   55b157:        movl    %eax, 0x24(%rsp)
    0.00 :   55b15b:        movl    0x10(%rsp), %esi
    0.00 :   55b15f:        movl    0xc(%rsp), %edi
    0.00 :   55b163:        leaq    0xa40826(%rip), %rdx  # 0xf9b990
    0.00 :   55b16a:        callq   0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>
    0.00 :   55b16f:        movl    0x10(%rsp), %ecx
    0.00 :   55b173:        movl    0xc(%rsp), %eax
    0.00 :   55b177:        addl    %ecx, %eax
    0.00 :   55b179:        addq    $0x28, %rsp
    0.00 :   55b17d:        retq
---- end(-1) ----
 83: perf data type profiling tests                                  : FAILED!
⬢ [acme@toolbx perf-tools-next]$

Failed as root as well:

root@number:/home/acme/git/perf-tools-next# tools/perf/perf test 'data type profiling'
 83: perf data type profiling tests                                  : FAILED!
root@number:/home/acme/git/perf-tools-next# tools/perf/perf test -v 'data type profiling'
--- start ---
test child forked, pid 1455516
Basic perf annotate test
Basic annotate [Failed: missing target data type]
 Percent |	Source code & Disassembly of perf for cpu/cycles/P (1359 samples, percent: local period)
--------------------------------------------------------------------------------------------------------
         :
         :
         :
         : 3      Disassembly of section .text:
         :
         : 5      000000000055bcb0 <test_rs>:
         : 6      data2: String,
         : 7      data3: u64,
         : 8      }
         :
         : 10     #[no_mangle]
         : 11     pub extern "C" fn test_rs(count: u32) {
    0.07 :   55bcb0: sub    $0x98,%rsp
    0.07 :   55bcb7: mov    %edi,0x2c(%rsp)
    0.07 :   55bcbb: mov    %edi,0x84(%rsp)
         : 15     let mut b =  Buf { data1: 0, data2: String::from("data"), data3: 0};
    0.00 :   55bcc2: lea    0x22b557(%rip),%rsi        # 787220 <_IO_stdin_used+0x20>
    0.00 :   55bcc9: lea    0x60(%rsp),%rdi
    0.22 :   55bcce: mov    $0x4,%edx
    0.07 :   55bcd3: call   55baf0 <<alloc::string::String as core::convert::From<&str>>::from>
    0.07 :   55bcd8: jmp    55bce0 <test_rs+0x30>
         : 21     pub extern "C" fn test_rs(count: u32) {
    0.00 :   55bcda: call   *0xa493b0(%rip)        # fa5090 <_DYNAMIC+0x650>
    0.07 :   55bce0: mov    0x2c(%rsp),%esi
         : 24     let mut b =  Buf { data1: 0, data2: String::from("data"), data3: 0};
    0.29 :   55bce4: movq   $0x0,0x48(%rsp)
    0.15 :   55bced: mov    0x70(%rsp),%rax
    0.00 :   55bcf2: mov    %rax,0x40(%rsp)
    0.07 :   55bcf7: movups 0x60(%rsp),%xmm0
    0.00 :   55bcfc: movaps %xmm0,0x30(%rsp)
    0.07 :   55bd01: movq   $0x0,0x50(%rsp)
    0.00 :   55bd0a: mov    $0x1,%edi
         :
         : 33     for _ in 1..count {
    0.00 :   55bd0f: call   55bae0 <<I as core::iter::traits::collect::IntoIterator>::into_iter>
    0.07 :   55bd14: mov    %edx,0x24(%rsp)
    0.37 :   55bd18: mov    %eax,0x28(%rsp)
    0.00 :   55bd1c: jmp    55bd40 <test_rs+0x90>
    0.00 :   55bd1e: lea    0x30(%rsp),%rdi
         : 39     b.data1 += 1;
         : 40     }
         :
         : 42     b.data3 += b.data1;
         : 43     }
         : 44     }
    0.00 :   55bd23: call   55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.00 :   55bd28: jmp    55bd95 <test_rs+0xe5>
    0.00 :   55bd2a: mov    %rax,%rcx
    0.00 :   55bd2d: mov    %edx,%eax
    0.00 :   55bd2f: mov    %rcx,0x88(%rsp)
    0.00 :   55bd37: mov    %eax,0x90(%rsp)
    0.00 :   55bd3e: jmp    55bd1e <test_rs+0x6e>
    0.00 :   55bd40: mov    0x24(%rsp),%eax
    0.00 :   55bd44: mov    0x28(%rsp),%ecx
         : 54     for _ in 1..count {
    0.00 :   55bd48: mov    %ecx,0x7c(%rsp)
    0.07 :   55bd4c: mov    %eax,0x80(%rsp)
    2.08 :   55bd53: lea    0x7c(%rsp),%rdi
    4.92 :   55bd58: call   55b820 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
   19.10 :   55bd5d: mov    %eax,0x20(%rsp)
   17.78 :   55bd61: jmp    55bd63 <test_rs+0xb3>
    1.55 :   55bd63: mov    0x20(%rsp),%eax
    2.06 :   55bd67: mov    %eax,%eax
    1.99 :   55bd69: test   $0x1,%rax
    0.00 :   55bd6f: je     55bd89 <test_rs+0xd9>
         : 65     b.data1 += 1;
    1.83 :   55bd71: mov    0x48(%rsp),%rcx
    1.84 :   55bd76: mov    %rcx,%rax
    0.00 :   55bd79: add    $0x1,%rax
    1.91 :   55bd7d: mov    %rax,0x18(%rsp)
    2.72 :   55bd82: cmp    %rcx,%rax
    0.00 :   55bd85: jb     55bdcd <test_rs+0x11d>
    2.65 :   55bd87: jmp    55bdb9 <test_rs+0x109>
    0.15 :   55bd89: lea    0x30(%rsp),%rdi
         : 74     }
    0.00 :   55bd8e: call   55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.44 :   55bd93: jmp    55bdb1 <test_rs+0x101>
         : 77     pub extern "C" fn test_rs(count: u32) {
    0.00 :   55bd95: call   *0xa492f5(%rip)        # fa5090 <_DYNAMIC+0x650>
    0.00 :   55bd9b: mov    %rax,%rcx
    0.00 :   55bd9e: mov    %edx,%eax
    0.00 :   55bda0: mov    %rcx,0x88(%rsp)
    0.00 :   55bda8: mov    %eax,0x90(%rsp)
    0.00 :   55bdaf: jmp    55bd95 <test_rs+0xe5>
         : 84     }
    0.07 :   55bdb1: add    $0x98,%rsp
    0.07 :   55bdb8: ret
    1.32 :   55bdb9: mov    0x18(%rsp),%rax
         : 88     b.data1 += 1;
    4.28 :   55bdbe: mov    %rax,0x48(%rsp)
         : 90     if b.data1 == 123 {
    4.50 :   55bdc3: cmpq   $0x7b,0x48(%rsp)
    0.00 :   55bdc9: je     55bde1 <test_rs+0x131>
    1.84 :   55bdcb: jmp    55bdf9 <test_rs+0x149>
         : 94     b.data1 += 1;
    0.00 :   55bdcd: lea    0xa3fc44(%rip),%rdi        # f9ba18 <workloads+0xd8>
    0.00 :   55bdd4: lea    -0x150ffb(%rip),%rax        # 40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55bddb: call   *%rax
    0.00 :   55bddd: jmp    55bddf <test_rs+0x12f>
    0.00 :   55bddf: ud2
         : 100    b.data1 += 1;
    0.00 :   55bde1: mov    0x48(%rsp),%rcx
    0.00 :   55bde6: mov    %rcx,%rax
    0.00 :   55bde9: add    $0x1,%rax
    0.00 :   55bded: mov    %rax,0x10(%rsp)
    0.00 :   55bdf2: cmp    %rcx,%rax
    0.00 :   55bdf5: jb     55be21 <test_rs+0x171>
    0.00 :   55bdf7: jmp    55be15 <test_rs+0x165>
         : 108    b.data3 += b.data1;
    1.40 :   55bdf9: mov    0x48(%rsp),%rdx
    1.25 :   55bdfe: mov    0x50(%rsp),%rcx
    1.17 :   55be03: mov    %rcx,%rax
    0.00 :   55be06: add    %rdx,%rax
    3.30 :   55be09: mov    %rax,0x8(%rsp)
    3.91 :   55be0e: cmp    %rcx,%rax
    0.00 :   55be11: jb     55be42 <test_rs+0x192>
    1.48 :   55be13: jmp    55be33 <test_rs+0x183>
    0.00 :   55be15: mov    0x10(%rsp),%rax
         : 118    b.data1 += 1;
    0.00 :   55be1a: mov    %rax,0x48(%rsp)
         : 120    if b.data1 == 123 {
    0.00 :   55be1f: jmp    55bdf9 <test_rs+0x149>
         : 122    b.data1 += 1;
    0.00 :   55be21: lea    0xa3fc08(%rip),%rdi        # f9ba30 <workloads+0xf0>
    0.00 :   55be28: lea    -0x15104f(%rip),%rax        # 40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be2f: call   *%rax
    0.00 :   55be31: jmp    55bddf <test_rs+0x12f>
    4.27 :   55be33: mov    0x8(%rsp),%rax
         : 128    b.data3 += b.data1;
    4.87 :   55be38: mov    %rax,0x50(%rsp)
         : 130    for _ in 1..count {
    3.47 :   55be3d: jmp    55bd53 <test_rs+0xa3>
         : 132    b.data3 += b.data1;
    0.00 :   55be42: lea    0xa3fbff(%rip),%rdi        # f9ba48 <workloads+0x108>
    0.00 :   55be49: lea    -0x151070(%rip),%rax        # 40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be50: call   *%rax
    0.00 :   55be52: jmp    55bddf <test_rs+0x12f>
         : 137    pub extern "C" fn test_rs(count: u32) {
    0.00 :   55be54: call   *0xa49c2e(%rip)        # fa5a88 <_DYNAMIC+0x1048>
 Percent |	Source code & Disassembly of perf for cpu/cycles/P (1145 samples, percent: local period)
--------------------------------------------------------------------------------------------------------
         :
         :
         :
         : 3      Disassembly of section .text:
         :
         : 5      000000000055bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>:
    5.22 :   55bc40: sub    $0x38,%rsp
    1.83 :   55bc44: mov    %rdi,0x8(%rsp)
    2.01 :   55bc49: mov    %rdi,0x18(%rsp)
    1.92 :   55bc4e: mov    %rdi,%rax
    0.00 :   55bc51: add    $0x4,%rax
    4.17 :   55bc55: mov    %rdi,0x28(%rsp)
    2.54 :   55bc5a: mov    %rax,0x30(%rsp)
    6.28 :   55bc5f: mov    (%rdi),%eax
    5.77 :   55bc61: cmp    0x4(%rdi),%eax
    0.00 :   55bc64: jb     55bc70 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x30>
    0.96 :   55bc66: movl   $0x0,0x10(%rsp)
    1.03 :   55bc6e: jmp    55bca2 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x62>
    1.57 :   55bc70: mov    0x8(%rsp),%rax
    2.73 :   55bc75: mov    (%rax),%edi
    2.54 :   55bc77: mov    %edi,0x4(%rsp)
    2.01 :   55bc7b: mov    %edi,0x24(%rsp)
    1.75 :   55bc7f: mov    $0x1,%esi
    5.73 :   55bc84: call   55b140 <<u32 as core::iter::range::Step>::forward_unchecked>
    3.67 :   55bc89: mov    0x8(%rsp),%rcx
    3.41 :   55bc8e: mov    %eax,%edx
    3.57 :   55bc90: mov    0x4(%rsp),%eax
    3.78 :   55bc94: mov    %edx,(%rcx)
    2.27 :   55bc96: mov    %eax,0x14(%rsp)
    6.12 :   55bc9a: movl   $0x1,0x10(%rsp)
    2.79 :   55bca2: mov    0x10(%rsp),%eax
   12.41 :   55bca6: mov    0x14(%rsp),%edx
   10.04 :   55bcaa: add    $0x38,%rsp
    3.87 :   55bcae: ret
 Percent |	Source code & Disassembly of perf for cpu/cycles/P (636 samples, percent: local period)
-------------------------------------------------------------------------------------------------------
         :
         :
         :
         : 3      Disassembly of section .text:
         :
         : 5      000000000055b140 <<u32 as core::iter::range::Step>::forward_unchecked>:
    8.04 :   55b140: sub    $0x28,%rsp
    4.23 :   55b144: mov    %edi,0xc(%rsp)
    3.30 :   55b148: mov    %edi,0x14(%rsp)
    5.36 :   55b14c: mov    %rsi,0x18(%rsp)
    7.37 :   55b151: mov    %esi,%eax
    4.72 :   55b153: mov    %eax,0x10(%rsp)
    3.32 :   55b157: mov    %eax,0x24(%rsp)
    3.59 :   55b15b: mov    0x10(%rsp),%esi
    2.99 :   55b15f: mov    0xc(%rsp),%edi
    3.92 :   55b163: lea    0xa40826(%rip),%rdx        # f9b990 <workloads+0x50>
    8.49 :   55b16a: call   55b190 <core::num::<impl u32>::unchecked_add::precondition_check>
    4.84 :   55b16f: mov    0x10(%rsp),%ecx
    6.62 :   55b173: mov    0xc(%rsp),%eax
    5.65 :   55b177: add    %ecx,%eax
   21.09 :   55b179: add    $0x28,%rsp
    6.47 :   55b17d: ret
Pipe perf annotate test
Pipe annotate [Failed: missing target data type]
 Percent |	Source code & Disassembly of perf for cpu/cycles/P (1415 samples, percent: local period)
--------------------------------------------------------------------------------------------------------
         :
         :
         :
         : 3      Disassembly of section .text:
         :
         : 5      000000000055bcb0 <test_rs>:
         : 6      data2: String,
         : 7      data3: u64,
         : 8      }
         :
         : 10     #[no_mangle]
         : 11     pub extern "C" fn test_rs(count: u32) {
    0.07 :   55bcb0: sub    $0x98,%rsp
    0.00 :   55bcb7: mov    %edi,0x2c(%rsp)
    0.06 :   55bcbb: mov    %edi,0x84(%rsp)
         : 15     let mut b =  Buf { data1: 0, data2: String::from("data"), data3: 0};
    0.14 :   55bcc2: lea    0x22b557(%rip),%rsi        # 787220 <_IO_stdin_used+0x20>
    0.07 :   55bcc9: lea    0x60(%rsp),%rdi
    0.00 :   55bcce: mov    $0x4,%edx
    0.00 :   55bcd3: call   55baf0 <<alloc::string::String as core::convert::From<&str>>::from>
    0.00 :   55bcd8: jmp    55bce0 <test_rs+0x30>
         : 21     pub extern "C" fn test_rs(count: u32) {
    0.00 :   55bcda: call   *0xa493b0(%rip)        # fa5090 <_DYNAMIC+0x650>
    0.07 :   55bce0: mov    0x2c(%rsp),%esi
         : 24     let mut b =  Buf { data1: 0, data2: String::from("data"), data3: 0};
    0.07 :   55bce4: movq   $0x0,0x48(%rsp)
    0.21 :   55bced: mov    0x70(%rsp),%rax
    0.14 :   55bcf2: mov    %rax,0x40(%rsp)
    0.00 :   55bcf7: movups 0x60(%rsp),%xmm0
    0.00 :   55bcfc: movaps %xmm0,0x30(%rsp)
    0.00 :   55bd01: movq   $0x0,0x50(%rsp)
    0.00 :   55bd0a: mov    $0x1,%edi
         :
         : 33     for _ in 1..count {
    0.07 :   55bd0f: call   55bae0 <<I as core::iter::traits::collect::IntoIterator>::into_iter>
    0.42 :   55bd14: mov    %edx,0x24(%rsp)
    0.07 :   55bd18: mov    %eax,0x28(%rsp)
    0.07 :   55bd1c: jmp    55bd40 <test_rs+0x90>
    0.00 :   55bd1e: lea    0x30(%rsp),%rdi
         : 39     b.data1 += 1;
         : 40     }
         :
         : 42     b.data3 += b.data1;
         : 43     }
         : 44     }
    0.00 :   55bd23: call   55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.00 :   55bd28: jmp    55bd95 <test_rs+0xe5>
    0.00 :   55bd2a: mov    %rax,%rcx
    0.00 :   55bd2d: mov    %edx,%eax
    0.00 :   55bd2f: mov    %rcx,0x88(%rsp)
    0.00 :   55bd37: mov    %eax,0x90(%rsp)
    0.00 :   55bd3e: jmp    55bd1e <test_rs+0x6e>
    0.00 :   55bd40: mov    0x24(%rsp),%eax
    0.00 :   55bd44: mov    0x28(%rsp),%ecx
         : 54     for _ in 1..count {
    0.00 :   55bd48: mov    %ecx,0x7c(%rsp)
    0.00 :   55bd4c: mov    %eax,0x80(%rsp)
    3.18 :   55bd53: lea    0x7c(%rsp),%rdi
    3.46 :   55bd58: call   55b820 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
   18.28 :   55bd5d: mov    %eax,0x20(%rsp)
   18.43 :   55bd61: jmp    55bd63 <test_rs+0xb3>
    1.84 :   55bd63: mov    0x20(%rsp),%eax
    1.34 :   55bd67: mov    %eax,%eax
    1.55 :   55bd69: test   $0x1,%rax
    0.00 :   55bd6f: je     55bd89 <test_rs+0xd9>
         : 65     b.data1 += 1;
    2.62 :   55bd71: mov    0x48(%rsp),%rcx
    2.13 :   55bd76: mov    %rcx,%rax
    0.00 :   55bd79: add    $0x1,%rax
    1.64 :   55bd7d: mov    %rax,0x18(%rsp)
    3.11 :   55bd82: cmp    %rcx,%rax
    0.00 :   55bd85: jb     55bdcd <test_rs+0x11d>
    2.26 :   55bd87: jmp    55bdb9 <test_rs+0x109>
    0.00 :   55bd89: lea    0x30(%rsp),%rdi
         : 74     }
    0.21 :   55bd8e: call   55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.28 :   55bd93: jmp    55bdb1 <test_rs+0x101>
         : 77     pub extern "C" fn test_rs(count: u32) {
    0.00 :   55bd95: call   *0xa492f5(%rip)        # fa5090 <_DYNAMIC+0x650>
    0.00 :   55bd9b: mov    %rax,%rcx
    0.00 :   55bd9e: mov    %edx,%eax
    0.00 :   55bda0: mov    %rcx,0x88(%rsp)
    0.00 :   55bda8: mov    %eax,0x90(%rsp)
    0.00 :   55bdaf: jmp    55bd95 <test_rs+0xe5>
         : 84     }
    0.00 :   55bdb1: add    $0x98,%rsp
    0.00 :   55bdb8: ret
    1.90 :   55bdb9: mov    0x18(%rsp),%rax
         : 88     b.data1 += 1;
    4.70 :   55bdbe: mov    %rax,0x48(%rsp)
         : 90     if b.data1 == 123 {
    4.95 :   55bdc3: cmpq   $0x7b,0x48(%rsp)
    0.00 :   55bdc9: je     55bde1 <test_rs+0x131>
    1.63 :   55bdcb: jmp    55bdf9 <test_rs+0x149>
         : 94     b.data1 += 1;
    0.00 :   55bdcd: lea    0xa3fc44(%rip),%rdi        # f9ba18 <workloads+0xd8>
    0.00 :   55bdd4: lea    -0x150ffb(%rip),%rax        # 40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55bddb: call   *%rax
    0.00 :   55bddd: jmp    55bddf <test_rs+0x12f>
    0.00 :   55bddf: ud2
         : 100    b.data1 += 1;
    0.00 :   55bde1: mov    0x48(%rsp),%rcx
    0.00 :   55bde6: mov    %rcx,%rax
    0.00 :   55bde9: add    $0x1,%rax
    0.00 :   55bded: mov    %rax,0x10(%rsp)
    0.00 :   55bdf2: cmp    %rcx,%rax
    0.00 :   55bdf5: jb     55be21 <test_rs+0x171>
    0.00 :   55bdf7: jmp    55be15 <test_rs+0x165>
         : 108    b.data3 += b.data1;
    1.20 :   55bdf9: mov    0x48(%rsp),%rdx
    1.63 :   55bdfe: mov    0x50(%rsp),%rcx
    1.36 :   55be03: mov    %rcx,%rax
    0.00 :   55be06: add    %rdx,%rax
    3.11 :   55be09: mov    %rax,0x8(%rsp)
    2.89 :   55be0e: cmp    %rcx,%rax
    0.00 :   55be11: jb     55be42 <test_rs+0x192>
    1.90 :   55be13: jmp    55be33 <test_rs+0x183>
    0.00 :   55be15: mov    0x10(%rsp),%rax
         : 118    b.data1 += 1;
    0.00 :   55be1a: mov    %rax,0x48(%rsp)
         : 120    if b.data1 == 123 {
    0.00 :   55be1f: jmp    55bdf9 <test_rs+0x149>
         : 122    b.data1 += 1;
    0.00 :   55be21: lea    0xa3fc08(%rip),%rdi        # f9ba30 <workloads+0xf0>
    0.00 :   55be28: lea    -0x15104f(%rip),%rax        # 40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be2f: call   *%rax
    0.00 :   55be31: jmp    55bddf <test_rs+0x12f>
    4.86 :   55be33: mov    0x8(%rsp),%rax
         : 128    b.data3 += b.data1;
    4.60 :   55be38: mov    %rax,0x50(%rsp)
         : 130    for _ in 1..count {
    3.46 :   55be3d: jmp    55bd53 <test_rs+0xa3>
         : 132    b.data3 += b.data1;
    0.00 :   55be42: lea    0xa3fbff(%rip),%rdi        # f9ba48 <workloads+0x108>
    0.00 :   55be49: lea    -0x151070(%rip),%rax        # 40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be50: call   *%rax
    0.00 :   55be52: jmp    55bddf <test_rs+0x12f>
         : 137    pub extern "C" fn test_rs(count: u32) {
    0.00 :   55be54: call   *0xa49c2e(%rip)        # fa5a88 <_DYNAMIC+0x1048>
 Percent |	Source code & Disassembly of perf for cpu/cycles/P (1142 samples, percent: local period)
--------------------------------------------------------------------------------------------------------
         :
         :
         :
         : 3      Disassembly of section .text:
         :
         : 5      000000000055bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>:
    4.12 :   55bc40: sub    $0x38,%rsp
    2.04 :   55bc44: mov    %rdi,0x8(%rsp)
    2.11 :   55bc49: mov    %rdi,0x18(%rsp)
    2.80 :   55bc4e: mov    %rdi,%rax
    0.00 :   55bc51: add    $0x4,%rax
    3.95 :   55bc55: mov    %rdi,0x28(%rsp)
    2.28 :   55bc5a: mov    %rax,0x30(%rsp)
    6.73 :   55bc5f: mov    (%rdi),%eax
    5.17 :   55bc61: cmp    0x4(%rdi),%eax
    0.00 :   55bc64: jb     55bc70 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x30>
    1.14 :   55bc66: movl   $0x0,0x10(%rsp)
    0.70 :   55bc6e: jmp    55bca2 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x62>
    1.67 :   55bc70: mov    0x8(%rsp),%rax
    2.20 :   55bc75: mov    (%rax),%edi
    1.75 :   55bc77: mov    %edi,0x4(%rsp)
    2.63 :   55bc7b: mov    %edi,0x24(%rsp)
    2.18 :   55bc7f: mov    $0x1,%esi
    5.15 :   55bc84: call   55b140 <<u32 as core::iter::range::Step>::forward_unchecked>
    2.71 :   55bc89: mov    0x8(%rsp),%rcx
    3.43 :   55bc8e: mov    %eax,%edx
    2.89 :   55bc90: mov    0x4(%rsp),%eax
    2.56 :   55bc94: mov    %edx,(%rcx)
    2.44 :   55bc96: mov    %eax,0x14(%rsp)
    6.22 :   55bc9a: movl   $0x1,0x10(%rsp)
    3.06 :   55bca2: mov    0x10(%rsp),%eax
   14.55 :   55bca6: mov    0x14(%rsp),%edx
   11.64 :   55bcaa: add    $0x38,%rsp
    3.87 :   55bcae: ret
 Percent |	Source code & Disassembly of perf for cpu/cycles/P (590 samples, percent: local period)
-------------------------------------------------------------------------------------------------------
         :
         :
         :
         : 3      Disassembly of section .text:
         :
         : 5      000000000055b140 <<u32 as core::iter::range::Step>::forward_unchecked>:
    8.72 :   55b140: sub    $0x28,%rsp
    2.54 :   55b144: mov    %edi,0xc(%rsp)
    3.90 :   55b148: mov    %edi,0x14(%rsp)
    4.61 :   55b14c: mov    %rsi,0x18(%rsp)
    6.76 :   55b151: mov    %esi,%eax
    3.74 :   55b153: mov    %eax,0x10(%rsp)
    3.22 :   55b157: mov    %eax,0x24(%rsp)
    4.10 :   55b15b: mov    0x10(%rsp),%esi
    3.37 :   55b15f: mov    0xc(%rsp),%edi
    4.57 :   55b163: lea    0xa40826(%rip),%rdx        # f9b990 <workloads+0x50>
    8.30 :   55b16a: call   55b190 <core::num::<impl u32>::unchecked_add::precondition_check>
    6.43 :   55b16f: mov    0x10(%rsp),%ecx
    7.13 :   55b173: mov    0xc(%rsp),%eax
    3.85 :   55b177: add    %ecx,%eax
   21.24 :   55b179: add    $0x28,%rsp
    7.51 :   55b17d: ret
---- end(-1) ----
 83: perf data type profiling tests                                  : FAILED!
root@number:/home/acme/git/perf-tools-next#


Ok, this is on a:

root@five:~# grep "model name" -m1 /proc/cpuinfo
model name	: AMD Ryzen 9 5950X 16-Core Processor
root@five:~#

Now trying on a:

acme@x1:~/git/perf-tools-next$ grep -m1 "model name" /proc/cpuinfo 
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
acme@x1:~/git/perf-tools-next$ 

⬢ [acme@toolbx perf-tools-next]$ tools/perf/perf test "data type profiling"
 83: perf data type profiling tests                                  : FAILED!
⬢ [acme@toolbx perf-tools-next]$ tools/perf/perf test -v "data type profiling"
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
--- start ---
test child forked, pid 615260
Basic perf annotate test
Basic annotate [Failed: missing target data type]
 Percent |	Source code & Disassembly of perf for cpu_atom/cycles/Pu (108 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------
         : 0      0x55bcb0 <test_rs>:
    0.00 :   55bcb0:        subq    $0x98, %rsp
    0.00 :   55bcb7:        movl    %edi, 0x2c(%rsp)
    0.00 :   55bcbb:        movl    %edi, 0x84(%rsp)
    0.00 :   55bcc2:        leaq    0x22b557(%rip), %rsi  # 0x787220
    0.00 :   55bcc9:        leaq    0x60(%rsp), %rdi
    0.00 :   55bcce:        movl    $0x4, %edx
    0.00 :   55bcd3:        callq   0x55baf0 <<alloc::string::String as core::convert::From<&str>>::from>
    0.00 :   55bcd8:        jmp     0x55bce0 <test_rs+0x30>
    0.00 :   55bcda:        callq   *0xa493b0(%rip)  # 0xfa5090 <_DYNAMIC+0x650>
    0.00 :   55bce0:        movl    0x2c(%rsp), %esi
    0.00 :   55bce4:        movq    $0x0, 0x48(%rsp)
    0.00 :   55bced:        movq    0x70(%rsp), %rax
    0.00 :   55bcf2:        movq    %rax, 0x40(%rsp)
    1.92 :   55bcf7:        movups  0x60(%rsp), %xmm0
    0.00 :   55bcfc:        movaps  %xmm0, 0x30(%rsp)
    0.00 :   55bd01:        movq    $0x0, 0x50(%rsp)
    0.00 :   55bd0a:        movl    $0x1, %edi
    0.00 :   55bd0f:        callq   0x55bae0 <<I as core::iter::traits::collect::IntoIterator>::into_iter>
    0.00 :   55bd14:        movl    %edx, 0x24(%rsp)
    0.00 :   55bd18:        movl    %eax, 0x28(%rsp)
    0.00 :   55bd1c:        jmp     0x55bd40 <test_rs+0x90>
    0.00 :   55bd1e:        leaq    0x30(%rsp), %rdi
    0.00 :   55bd23:        callq   0x55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.00 :   55bd28:        jmp     0x55bd95 <test_rs+0xe5>
    0.00 :   55bd2a:        movq    %rax, %rcx
    0.00 :   55bd2d:        movl    %edx, %eax
    0.00 :   55bd2f:        movq    %rcx, 0x88(%rsp)
    0.00 :   55bd37:        movl    %eax, 0x90(%rsp)
    0.00 :   55bd3e:        jmp     0x55bd1e <test_rs+0x6e>
    0.96 :   55bd40:        movl    0x24(%rsp), %eax
    0.00 :   55bd44:        movl    0x28(%rsp), %ecx
    0.00 :   55bd48:        movl    %ecx, 0x7c(%rsp)
    0.00 :   55bd4c:        movl    %eax, 0x80(%rsp)
    1.92 :   55bd53:        leaq    0x7c(%rsp), %rdi
    0.96 :   55bd58:        callq   0x55b820 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
    7.56 :   55bd5d:        movl    %eax, 0x20(%rsp)
    4.10 :   55bd61:        jmp     0x55bd63 <test_rs+0xb3>
    3.83 :   55bd63:        movl    0x20(%rsp), %eax
    2.88 :   55bd67:        movl    %eax, %eax
    1.92 :   55bd69:        testq   $0x1, %rax
    1.92 :   55bd6f:        je      0x55bd89 <test_rs+0xd9>
    2.88 :   55bd71:        movq    0x48(%rsp), %rcx
    5.71 :   55bd76:        movq    %rcx, %rax
    3.84 :   55bd79:        addq    $0x1, %rax
    1.93 :   55bd7d:        movq    %rax, 0x18(%rsp)
    3.66 :   55bd82:        cmpq    %rcx, %rax
    1.48 :   55bd85:        jb      0x55bdcd <test_rs+0x11d>
    0.96 :   55bd87:        jmp     0x55bdb9 <test_rs+0x109>
    0.00 :   55bd89:        leaq    0x30(%rsp), %rdi
    0.00 :   55bd8e:        callq   0x55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.00 :   55bd93:        jmp     0x55bdb1 <test_rs+0x101>
    0.00 :   55bd95:        callq   *0xa492f5(%rip)  # 0xfa5090 <_DYNAMIC+0x650>
    0.00 :   55bd9b:        movq    %rax, %rcx
    0.00 :   55bd9e:        movl    %edx, %eax
    0.00 :   55bda0:        movq    %rcx, 0x88(%rsp)
    0.00 :   55bda8:        movl    %eax, 0x90(%rsp)
    0.00 :   55bdaf:        jmp     0x55bd95 <test_rs+0xe5>
    0.00 :   55bdb1:        addq    $0x98, %rsp
    0.00 :   55bdb8:        retq
    3.81 :   55bdb9:        movq    0x18(%rsp), %rax
    1.91 :   55bdbe:        movq    %rax, 0x48(%rsp)
    3.44 :   55bdc3:        cmpq    $0x7b, 0x48(%rsp)
    1.92 :   55bdc9:        je      0x55bde1 <test_rs+0x131>
    3.84 :   55bdcb:        jmp     0x55bdf9 <test_rs+0x149>
    0.00 :   55bdcd:        leaq    0xa3fc44(%rip), %rdi  # 0xf9ba18
    0.00 :   55bdd4:        leaq    -0x150ffb(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55bddb:        callq   *%rax
    0.00 :   55bddd:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55bddf:        ud2
    0.00 :   55bde1:        movq    0x48(%rsp), %rcx
    0.00 :   55bde6:        movq    %rcx, %rax
    0.00 :   55bde9:        addq    $0x1, %rax
    0.00 :   55bded:        movq    %rax, 0x10(%rsp)
    0.00 :   55bdf2:        cmpq    %rcx, %rax
    0.00 :   55bdf5:        jb      0x55be21 <test_rs+0x171>
    0.00 :   55bdf7:        jmp     0x55be15 <test_rs+0x165>
    1.92 :   55bdf9:        movq    0x48(%rsp), %rdx
    2.88 :   55bdfe:        movq    0x50(%rsp), %rcx
    5.76 :   55be03:        movq    %rcx, %rax
    0.96 :   55be06:        addq    %rdx, %rax
    4.80 :   55be09:        movq    %rax, 0x8(%rsp)
    1.92 :   55be0e:        cmpq    %rcx, %rax
    3.20 :   55be11:        jb      0x55be42 <test_rs+0x192>
    3.84 :   55be13:        jmp     0x55be33 <test_rs+0x183>
    0.00 :   55be15:        movq    0x10(%rsp), %rax
    0.00 :   55be1a:        movq    %rax, 0x48(%rsp)
    0.00 :   55be1f:        jmp     0x55bdf9 <test_rs+0x149>
    0.00 :   55be21:        leaq    0xa3fc08(%rip), %rdi  # 0xf9ba30
    0.00 :   55be28:        leaq    -0x15104f(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be2f:        callq   *%rax
    0.00 :   55be31:        jmp     0x55bddf <test_rs+0x12f>
    2.35 :   55be33:        movq    0x8(%rsp), %rax
    9.00 :   55be38:        movq    %rax, 0x50(%rsp)
    0.00 :   55be3d:        jmp     0x55bd53 <test_rs+0xa3>
    0.00 :   55be42:        leaq    0xa3fbff(%rip), %rdi  # 0xf9ba48
    0.00 :   55be49:        leaq    -0x151070(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be50:        callq   *%rax
    0.00 :   55be52:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55be54:        callq   *0xa49c2e(%rip)  # 0xfa5a88 <_DYNAMIC+0x1048>
 Percent |	Source code & Disassembly of perf for cpu_atom/cycles/Pu (99 samples, percent: local period)
------------------------------------------------------------------------------------------------------------
         : 0      0x55bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>:
    3.13 :   55bc40:        subq    $0x38, %rsp
    6.23 :   55bc44:        movq    %rdi, 0x8(%rsp)
    4.63 :   55bc49:        movq    %rdi, 0x18(%rsp)
    5.15 :   55bc4e:        movq    %rdi, %rax
    5.22 :   55bc51:        addq    $0x4, %rax
    1.04 :   55bc55:        movq    %rdi, 0x28(%rsp)
    3.13 :   55bc5a:        movq    %rax, 0x30(%rsp)
    2.09 :   55bc5f:        movl    (%rdi), %eax
    1.04 :   55bc61:        cmpl    0x4(%rdi), %eax
    1.04 :   55bc64:        jb      0x55bc70 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x30>
    3.13 :   55bc66:        movl    $0x0, 0x10(%rsp)
    0.00 :   55bc6e:        jmp     0x55bca2 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x62>
    4.01 :   55bc70:        movq    0x8(%rsp), %rax
    5.22 :   55bc75:        movl    (%rax), %edi
    4.98 :   55bc77:        movl    %edi, 0x4(%rsp)
    3.06 :   55bc7b:        movl    %edi, 0x24(%rsp)
    4.18 :   55bc7f:        movl    $0x1, %esi
    2.08 :   55bc84:        callq   0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>
    4.55 :   55bc89:        movq    0x8(%rsp), %rcx
    7.23 :   55bc8e:        movl    %eax, %edx
    3.61 :   55bc90:        movl    0x4(%rsp), %eax
    1.49 :   55bc94:        movl    %edx, (%rcx)
    4.14 :   55bc96:        movl    %eax, 0x14(%rsp)
    6.22 :   55bc9a:        movl    $0x1, 0x10(%rsp)
    4.04 :   55bca2:        movl    0x10(%rsp), %eax
    4.09 :   55bca6:        movl    0x14(%rsp), %edx
    3.13 :   55bcaa:        addq    $0x38, %rsp
    2.09 :   55bcae:        retq
 Percent |	Source code & Disassembly of perf for cpu_atom/cycles/Pu (69 samples, percent: local period)
------------------------------------------------------------------------------------------------------------
         : 0      0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>:
   12.97 :   55b140:        subq    $0x28, %rsp
    3.00 :   55b144:        movl    %edi, 0xc(%rsp)
    3.00 :   55b148:        movl    %edi, 0x14(%rsp)
   10.49 :   55b14c:        movq    %rsi, 0x18(%rsp)
    8.98 :   55b151:        movl    %esi, %eax
    7.11 :   55b153:        movl    %eax, 0x10(%rsp)
    5.99 :   55b157:        movl    %eax, 0x24(%rsp)
    8.67 :   55b15b:        movl    0x10(%rsp), %esi
    0.00 :   55b15f:        movl    0xc(%rsp), %edi
    1.50 :   55b163:        leaq    0xa40826(%rip), %rdx  # 0xf9b990
    4.50 :   55b16a:        callq   0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>
   21.79 :   55b16f:        movl    0x10(%rsp), %ecx
    4.49 :   55b173:        movl    0xc(%rsp), %eax
    3.00 :   55b177:        addl    %ecx, %eax
    1.50 :   55b179:        addq    $0x28, %rsp
    3.00 :   55b17d:        retq
 Percent |	Source code & Disassembly of perf for cpu_atom/cycles/Pu (65 samples, percent: local period)
------------------------------------------------------------------------------------------------------------
         : 0      0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>:
   12.87 :   55b190:        subq    $0x68, %rsp
    8.03 :   55b194:        movl    %edi, %eax
   17.01 :   55b196:        movq    %rdx, (%rsp)
    7.53 :   55b19a:        movl    %eax, 0x48(%rsp)
    2.92 :   55b19e:        movl    %esi, 0x4c(%rsp)
    6.44 :   55b1a2:        leaq    0x2922af(%rip), %rcx  # 0x7ed458
    1.60 :   55b1a9:        movq    %rcx, 0x50(%rsp)
    3.22 :   55b1ae:        movq    $0xb8, 0x58(%rsp)
    3.67 :   55b1b7:        movl    %eax, %edi
    9.65 :   55b1b9:        addl    %esi, %edi
    6.43 :   55b1bb:        cmpl    %eax, %edi
    9.63 :   55b1bd:        jb      0x55b1c4 <core::num::<impl u32>::unchecked_add::precondition_check+0x34>
    4.56 :   55b1bf:        addq    $0x68, %rsp
    6.44 :   55b1c3:        retq
    0.00 :   55b1c4:        movq    (%rsp), %rdx
    0.00 :   55b1c8:        leaq    0x292289(%rip), %rax  # 0x7ed458
    0.00 :   55b1cf:        movq    %rax, 0x38(%rsp)
    0.00 :   55b1d4:        movq    $0xb8, 0x40(%rsp)
    0.00 :   55b1dd:        leaq    0x38(%rsp), %rax
    0.00 :   55b1e2:        movq    %rax, 0x60(%rsp)
    0.00 :   55b1e7:        leaq    0x38(%rsp), %rax
    0.00 :   55b1ec:        movq    %rax, 0x8(%rsp)
    0.00 :   55b1f1:        movq    $0x1, 0x10(%rsp)
    0.00 :   55b1fa:        movq    0x27efdf(%rip), %rcx  # 0x7da1e0
    0.00 :   55b201:        movq    0x27efe0(%rip), %rax  # 0x7da1e8
    0.00 :   55b208:        movq    %rcx, 0x28(%rsp)
    0.00 :   55b20d:        movq    %rax, 0x30(%rsp)
    0.00 :   55b212:        movl    $0x8, %eax
    0.00 :   55b217:        movq    %rax, 0x18(%rsp)
    0.00 :   55b21c:        movq    $0x0, 0x20(%rsp)
    0.00 :   55b225:        leaq    0x8(%rsp), %rdi
    0.00 :   55b22a:        xorl    %esi, %esi
    0.00 :   55b22c:        callq   *0xa4ad96(%rip)  # 0xfa5fc8 <_DYNAMIC+0x1588>
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (1046 samples, percent: local period)
--------------------------------------------------------------------------------------------------------------
         : 0      0x55bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>:
    0.00 :   55bc40:        subq    $0x38, %rsp
    0.00 :   55bc44:        movq    %rdi, 0x8(%rsp)
    0.00 :   55bc49:        movq    %rdi, 0x18(%rsp)
   16.36 :   55bc4e:        movq    %rdi, %rax
    0.00 :   55bc51:        addq    $0x4, %rax
    0.00 :   55bc55:        movq    %rdi, 0x28(%rsp)
    0.00 :   55bc5a:        movq    %rax, 0x30(%rsp)
    7.25 :   55bc5f:        movl    (%rdi), %eax
    0.00 :   55bc61:        cmpl    0x4(%rdi), %eax
   15.21 :   55bc64:        jb      0x55bc70 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x30>
    0.00 :   55bc66:        movl    $0x0, 0x10(%rsp)
    0.10 :   55bc6e:        jmp     0x55bca2 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x62>
    0.00 :   55bc70:        movq    0x8(%rsp), %rax
    0.10 :   55bc75:        movl    (%rax), %edi
    0.00 :   55bc77:        movl    %edi, 0x4(%rsp)
   14.93 :   55bc7b:        movl    %edi, 0x24(%rsp)
    0.00 :   55bc7f:        movl    $0x1, %esi
    1.05 :   55bc84:        callq   0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>
    0.00 :   55bc89:        movq    0x8(%rsp), %rcx
    0.00 :   55bc8e:        movl    %eax, %edx
    0.00 :   55bc90:        movl    0x4(%rsp), %eax
   15.51 :   55bc94:        movl    %edx, (%rcx)
    0.00 :   55bc96:        movl    %eax, 0x14(%rsp)
    0.00 :   55bc9a:        movl    $0x1, 0x10(%rsp)
    0.00 :   55bca2:        movl    0x10(%rsp), %eax
   14.21 :   55bca6:        movl    0x14(%rsp), %edx
    0.00 :   55bcaa:        addq    $0x38, %rsp
   15.28 :   55bcae:        retq
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (954 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------
         : 0      0x55bcb0 <test_rs>:
    0.00 :   55bcb0:        subq    $0x98, %rsp
    0.00 :   55bcb7:        movl    %edi, 0x2c(%rsp)
    0.00 :   55bcbb:        movl    %edi, 0x84(%rsp)
    0.10 :   55bcc2:        leaq    0x22b557(%rip), %rsi  # 0x787220
    0.00 :   55bcc9:        leaq    0x60(%rsp), %rdi
    0.00 :   55bcce:        movl    $0x4, %edx
    0.00 :   55bcd3:        callq   0x55baf0 <<alloc::string::String as core::convert::From<&str>>::from>
    0.10 :   55bcd8:        jmp     0x55bce0 <test_rs+0x30>
    0.00 :   55bcda:        callq   *0xa493b0(%rip)  # 0xfa5090 <_DYNAMIC+0x650>
    0.00 :   55bce0:        movl    0x2c(%rsp), %esi
    0.00 :   55bce4:        movq    $0x0, 0x48(%rsp)
    0.11 :   55bced:        movq    0x70(%rsp), %rax
    0.21 :   55bcf2:        movq    %rax, 0x40(%rsp)
    2.20 :   55bcf7:        movups  0x60(%rsp), %xmm0
    0.73 :   55bcfc:        movaps  %xmm0, 0x30(%rsp)
    0.00 :   55bd01:        movq    $0x0, 0x50(%rsp)
    0.00 :   55bd0a:        movl    $0x1, %edi
    0.00 :   55bd0f:        callq   0x55bae0 <<I as core::iter::traits::collect::IntoIterator>::into_iter>
    0.00 :   55bd14:        movl    %edx, 0x24(%rsp)
    0.00 :   55bd18:        movl    %eax, 0x28(%rsp)
    0.10 :   55bd1c:        jmp     0x55bd40 <test_rs+0x90>
    0.00 :   55bd1e:        leaq    0x30(%rsp), %rdi
    0.00 :   55bd23:        callq   0x55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.00 :   55bd28:        jmp     0x55bd95 <test_rs+0xe5>
    0.00 :   55bd2a:        movq    %rax, %rcx
    0.00 :   55bd2d:        movl    %edx, %eax
    0.00 :   55bd2f:        movq    %rcx, 0x88(%rsp)
    0.00 :   55bd37:        movl    %eax, 0x90(%rsp)
    0.00 :   55bd3e:        jmp     0x55bd1e <test_rs+0x6e>
    0.00 :   55bd40:        movl    0x24(%rsp), %eax
    0.00 :   55bd44:        movl    0x28(%rsp), %ecx
    0.00 :   55bd48:        movl    %ecx, 0x7c(%rsp)
    0.21 :   55bd4c:        movl    %eax, 0x80(%rsp)
    0.00 :   55bd53:        leaq    0x7c(%rsp), %rdi
   11.96 :   55bd58:        callq   0x55b820 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
    0.00 :   55bd5d:        movl    %eax, 0x20(%rsp)
    1.36 :   55bd61:        jmp     0x55bd63 <test_rs+0xb3>
    0.00 :   55bd63:        movl    0x20(%rsp), %eax
    0.00 :   55bd67:        movl    %eax, %eax
    0.00 :   55bd69:        testq   $0x1, %rax
    0.10 :   55bd6f:        je      0x55bd89 <test_rs+0xd9>
   16.76 :   55bd71:        movq    0x48(%rsp), %rcx
    0.00 :   55bd76:        movq    %rcx, %rax
    0.00 :   55bd79:        addq    $0x1, %rax
    0.00 :   55bd7d:        movq    %rax, 0x18(%rsp)
    2.20 :   55bd82:        cmpq    %rcx, %rax
    0.00 :   55bd85:        jb      0x55bdcd <test_rs+0x11d>
    3.04 :   55bd87:        jmp     0x55bdb9 <test_rs+0x109>
    0.00 :   55bd89:        leaq    0x30(%rsp), %rdi
    0.00 :   55bd8e:        callq   0x55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.00 :   55bd93:        jmp     0x55bdb1 <test_rs+0x101>
    0.00 :   55bd95:        callq   *0xa492f5(%rip)  # 0xfa5090 <_DYNAMIC+0x650>
    0.00 :   55bd9b:        movq    %rax, %rcx
    0.00 :   55bd9e:        movl    %edx, %eax
    0.00 :   55bda0:        movq    %rcx, 0x88(%rsp)
    0.00 :   55bda8:        movl    %eax, 0x90(%rsp)
    0.00 :   55bdaf:        jmp     0x55bd95 <test_rs+0xe5>
    0.00 :   55bdb1:        addq    $0x98, %rsp
    0.21 :   55bdb8:        retq
    0.10 :   55bdb9:        movq    0x18(%rsp), %rax
    0.00 :   55bdbe:        movq    %rax, 0x48(%rsp)
    0.00 :   55bdc3:        cmpq    $0x7b, 0x48(%rsp)
   17.41 :   55bdc9:        je      0x55bde1 <test_rs+0x131>
    6.19 :   55bdcb:        jmp     0x55bdf9 <test_rs+0x149>
    0.00 :   55bdcd:        leaq    0xa3fc44(%rip), %rdi  # 0xf9ba18
    0.00 :   55bdd4:        leaq    -0x150ffb(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55bddb:        callq   *%rax
    0.00 :   55bddd:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55bddf:        ud2
    0.00 :   55bde1:        movq    0x48(%rsp), %rcx
    0.00 :   55bde6:        movq    %rcx, %rax
    0.00 :   55bde9:        addq    $0x1, %rax
    0.00 :   55bded:        movq    %rax, 0x10(%rsp)
    0.00 :   55bdf2:        cmpq    %rcx, %rax
    0.00 :   55bdf5:        jb      0x55be21 <test_rs+0x171>
    0.00 :   55bdf7:        jmp     0x55be15 <test_rs+0x165>
    0.00 :   55bdf9:        movq    0x48(%rsp), %rdx
    0.00 :   55bdfe:        movq    0x50(%rsp), %rcx
    0.00 :   55be03:        movq    %rcx, %rax
   16.66 :   55be06:        addq    %rdx, %rax
    0.00 :   55be09:        movq    %rax, 0x8(%rsp)
    0.00 :   55be0e:        cmpq    %rcx, %rax
    0.00 :   55be11:        jb      0x55be42 <test_rs+0x192>
   19.06 :   55be13:        jmp     0x55be33 <test_rs+0x183>
    0.00 :   55be15:        movq    0x10(%rsp), %rax
    0.00 :   55be1a:        movq    %rax, 0x48(%rsp)
    0.00 :   55be1f:        jmp     0x55bdf9 <test_rs+0x149>
    0.00 :   55be21:        leaq    0xa3fc08(%rip), %rdi  # 0xf9ba30
    0.00 :   55be28:        leaq    -0x15104f(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be2f:        callq   *%rax
    0.00 :   55be31:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55be33:        movq    0x8(%rsp), %rax
    0.00 :   55be38:        movq    %rax, 0x50(%rsp)
    1.15 :   55be3d:        jmp     0x55bd53 <test_rs+0xa3>
    0.00 :   55be42:        leaq    0xa3fbff(%rip), %rdi  # 0xf9ba48
    0.00 :   55be49:        leaq    -0x151070(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be50:        callq   *%rax
    0.00 :   55be52:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55be54:        callq   *0xa49c2e(%rip)  # 0xfa5a88 <_DYNAMIC+0x1048>
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (522 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------
         : 0      0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>:
    0.00 :   55b190:        subq    $0x68, %rsp
    0.00 :   55b194:        movl    %edi, %eax
    0.00 :   55b196:        movq    %rdx, (%rsp)
   33.53 :   55b19a:        movl    %eax, 0x48(%rsp)
    0.00 :   55b19e:        movl    %esi, 0x4c(%rsp)
    0.00 :   55b1a2:        leaq    0x2922af(%rip), %rcx  # 0x7ed458
    0.00 :   55b1a9:        movq    %rcx, 0x50(%rsp)
   33.92 :   55b1ae:        movq    $0xb8, 0x58(%rsp)
    0.00 :   55b1b7:        movl    %eax, %edi
    0.00 :   55b1b9:        addl    %esi, %edi
    0.00 :   55b1bb:        cmpl    %eax, %edi
    0.00 :   55b1bd:        jb      0x55b1c4 <core::num::<impl u32>::unchecked_add::precondition_check+0x34>
    3.43 :   55b1bf:        addq    $0x68, %rsp
   29.12 :   55b1c3:        retq
    0.00 :   55b1c4:        movq    (%rsp), %rdx
    0.00 :   55b1c8:        leaq    0x292289(%rip), %rax  # 0x7ed458
    0.00 :   55b1cf:        movq    %rax, 0x38(%rsp)
    0.00 :   55b1d4:        movq    $0xb8, 0x40(%rsp)
    0.00 :   55b1dd:        leaq    0x38(%rsp), %rax
    0.00 :   55b1e2:        movq    %rax, 0x60(%rsp)
    0.00 :   55b1e7:        leaq    0x38(%rsp), %rax
    0.00 :   55b1ec:        movq    %rax, 0x8(%rsp)
    0.00 :   55b1f1:        movq    $0x1, 0x10(%rsp)
    0.00 :   55b1fa:        movq    0x27efdf(%rip), %rcx  # 0x7da1e0
    0.00 :   55b201:        movq    0x27efe0(%rip), %rax  # 0x7da1e8
    0.00 :   55b208:        movq    %rcx, 0x28(%rsp)
    0.00 :   55b20d:        movq    %rax, 0x30(%rsp)
    0.00 :   55b212:        movl    $0x8, %eax
    0.00 :   55b217:        movq    %rax, 0x18(%rsp)
    0.00 :   55b21c:        movq    $0x0, 0x20(%rsp)
    0.00 :   55b225:        leaq    0x8(%rsp), %rdi
    0.00 :   55b22a:        xorl    %esi, %esi
    0.00 :   55b22c:        callq   *0xa4ad96(%rip)  # 0xfa5fc8 <_DYNAMIC+0x1588>
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (471 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------
         : 0      0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>:
    0.00 :   55b140:        subq    $0x28, %rsp
    0.00 :   55b144:        movl    %edi, 0xc(%rsp)
    0.00 :   55b148:        movl    %edi, 0x14(%rsp)
   24.00 :   55b14c:        movq    %rsi, 0x18(%rsp)
    0.00 :   55b151:        movl    %esi, %eax
    0.00 :   55b153:        movl    %eax, 0x10(%rsp)
    0.00 :   55b157:        movl    %eax, 0x24(%rsp)
   13.42 :   55b15b:        movl    0x10(%rsp), %esi
    0.00 :   55b15f:        movl    0xc(%rsp), %edi
    0.00 :   55b163:        leaq    0xa40826(%rip), %rdx  # 0xf9b990
    2.33 :   55b16a:        callq   0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>
    0.00 :   55b16f:        movl    0x10(%rsp), %ecx
    0.00 :   55b173:        movl    0xc(%rsp), %eax
    0.00 :   55b177:        addl    %ecx, %eax
   30.61 :   55b179:        addq    $0x28, %rsp
   29.63 :   55b17d:        retq
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (405 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------
         : 0      0x55b820 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>:
    0.00 :   55b820:        pushq   %rax
    0.00 :   55b821:        movq    %rdi, (%rsp)
   58.32 :   55b825:        callq   0x55bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>
    0.00 :   55b82a:        popq    %rcx
   41.68 :   55b82b:        retq
Pipe perf annotate test
Pipe annotate [Failed: missing target data type]
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (1159 samples, percent: local period)
--------------------------------------------------------------------------------------------------------------
         : 0      0x55bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>:
    0.00 :   55bc40:        subq    $0x38, %rsp
    0.00 :   55bc44:        movq    %rdi, 0x8(%rsp)
    0.00 :   55bc49:        movq    %rdi, 0x18(%rsp)
   13.73 :   55bc4e:        movq    %rdi, %rax
    0.00 :   55bc51:        addq    $0x4, %rax
    0.00 :   55bc55:        movq    %rdi, 0x28(%rsp)
    0.00 :   55bc5a:        movq    %rax, 0x30(%rsp)
    8.03 :   55bc5f:        movl    (%rdi), %eax
    0.00 :   55bc61:        cmpl    0x4(%rdi), %eax
   13.37 :   55bc64:        jb      0x55bc70 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x30>
    0.00 :   55bc66:        movl    $0x0, 0x10(%rsp)
    0.35 :   55bc6e:        jmp     0x55bca2 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next+0x62>
    0.00 :   55bc70:        movq    0x8(%rsp), %rax
    0.00 :   55bc75:        movl    (%rax), %edi
    0.00 :   55bc77:        movl    %edi, 0x4(%rsp)
   13.69 :   55bc7b:        movl    %edi, 0x24(%rsp)
    0.00 :   55bc7f:        movl    $0x1, %esi
    1.47 :   55bc84:        callq   0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>
    0.00 :   55bc89:        movq    0x8(%rsp), %rcx
    0.00 :   55bc8e:        movl    %eax, %edx
    0.00 :   55bc90:        movl    0x4(%rsp), %eax
   16.56 :   55bc94:        movl    %edx, (%rcx)
    0.00 :   55bc96:        movl    %eax, 0x14(%rsp)
    0.00 :   55bc9a:        movl    $0x1, 0x10(%rsp)
    0.00 :   55bca2:        movl    0x10(%rsp), %eax
   16.32 :   55bca6:        movl    0x14(%rsp), %edx
    0.00 :   55bcaa:        addq    $0x38, %rsp
   16.48 :   55bcae:        retq
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (1034 samples, percent: local period)
--------------------------------------------------------------------------------------------------------------
         : 0      0x55bcb0 <test_rs>:
    0.00 :   55bcb0:        subq    $0x98, %rsp
    0.00 :   55bcb7:        movl    %edi, 0x2c(%rsp)
    0.00 :   55bcbb:        movl    %edi, 0x84(%rsp)
    0.29 :   55bcc2:        leaq    0x22b557(%rip), %rsi  # 0x787220
    0.00 :   55bcc9:        leaq    0x60(%rsp), %rdi
    0.00 :   55bcce:        movl    $0x4, %edx
    0.29 :   55bcd3:        callq   0x55baf0 <<alloc::string::String as core::convert::From<&str>>::from>
    0.10 :   55bcd8:        jmp     0x55bce0 <test_rs+0x30>
    0.00 :   55bcda:        callq   *0xa493b0(%rip)  # 0xfa5090 <_DYNAMIC+0x650>
    0.00 :   55bce0:        movl    0x2c(%rsp), %esi
    0.00 :   55bce4:        movq    $0x0, 0x48(%rsp)
    0.00 :   55bced:        movq    0x70(%rsp), %rax
    0.00 :   55bcf2:        movq    %rax, 0x40(%rsp)
    2.23 :   55bcf7:        movups  0x60(%rsp), %xmm0
    0.58 :   55bcfc:        movaps  %xmm0, 0x30(%rsp)
    0.00 :   55bd01:        movq    $0x0, 0x50(%rsp)
    0.00 :   55bd0a:        movl    $0x1, %edi
    0.19 :   55bd0f:        callq   0x55bae0 <<I as core::iter::traits::collect::IntoIterator>::into_iter>
    0.00 :   55bd14:        movl    %edx, 0x24(%rsp)
    0.00 :   55bd18:        movl    %eax, 0x28(%rsp)
    0.10 :   55bd1c:        jmp     0x55bd40 <test_rs+0x90>
    0.00 :   55bd1e:        leaq    0x30(%rsp), %rdi
    0.00 :   55bd23:        callq   0x55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.00 :   55bd28:        jmp     0x55bd95 <test_rs+0xe5>
    0.00 :   55bd2a:        movq    %rax, %rcx
    0.00 :   55bd2d:        movl    %edx, %eax
    0.00 :   55bd2f:        movq    %rcx, 0x88(%rsp)
    0.00 :   55bd37:        movl    %eax, 0x90(%rsp)
    0.00 :   55bd3e:        jmp     0x55bd1e <test_rs+0x6e>
    0.00 :   55bd40:        movl    0x24(%rsp), %eax
    0.00 :   55bd44:        movl    0x28(%rsp), %ecx
    0.00 :   55bd48:        movl    %ecx, 0x7c(%rsp)
    0.10 :   55bd4c:        movl    %eax, 0x80(%rsp)
    0.00 :   55bd53:        leaq    0x7c(%rsp), %rdi
   11.89 :   55bd58:        callq   0x55b820 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>
    0.00 :   55bd5d:        movl    %eax, 0x20(%rsp)
    1.84 :   55bd61:        jmp     0x55bd63 <test_rs+0xb3>
    0.00 :   55bd63:        movl    0x20(%rsp), %eax
    0.00 :   55bd67:        movl    %eax, %eax
    0.00 :   55bd69:        testq   $0x1, %rax
    0.19 :   55bd6f:        je      0x55bd89 <test_rs+0xd9>
   16.73 :   55bd71:        movq    0x48(%rsp), %rcx
    0.00 :   55bd76:        movq    %rcx, %rax
    0.00 :   55bd79:        addq    $0x1, %rax
    0.00 :   55bd7d:        movq    %rax, 0x18(%rsp)
    2.03 :   55bd82:        cmpq    %rcx, %rax
    0.00 :   55bd85:        jb      0x55bdcd <test_rs+0x11d>
    3.48 :   55bd87:        jmp     0x55bdb9 <test_rs+0x109>
    0.00 :   55bd89:        leaq    0x30(%rsp), %rdi
    0.48 :   55bd8e:        callq   0x55b6f0 <core::ptr::drop_in_place<code_with_type::Buf>>
    0.10 :   55bd93:        jmp     0x55bdb1 <test_rs+0x101>
    0.00 :   55bd95:        callq   *0xa492f5(%rip)  # 0xfa5090 <_DYNAMIC+0x650>
    0.00 :   55bd9b:        movq    %rax, %rcx
    0.00 :   55bd9e:        movl    %edx, %eax
    0.00 :   55bda0:        movq    %rcx, 0x88(%rsp)
    0.00 :   55bda8:        movl    %eax, 0x90(%rsp)
    0.00 :   55bdaf:        jmp     0x55bd95 <test_rs+0xe5>
    0.00 :   55bdb1:        addq    $0x98, %rsp
    0.19 :   55bdb8:        retq
    0.00 :   55bdb9:        movq    0x18(%rsp), %rax
    0.00 :   55bdbe:        movq    %rax, 0x48(%rsp)
    0.00 :   55bdc3:        cmpq    $0x7b, 0x48(%rsp)
   14.19 :   55bdc9:        je      0x55bde1 <test_rs+0x131>
    6.68 :   55bdcb:        jmp     0x55bdf9 <test_rs+0x149>
    0.00 :   55bdcd:        leaq    0xa3fc44(%rip), %rdi  # 0xf9ba18
    0.00 :   55bdd4:        leaq    -0x150ffb(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55bddb:        callq   *%rax
    0.00 :   55bddd:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55bddf:        ud2
    0.00 :   55bde1:        movq    0x48(%rsp), %rcx
    0.00 :   55bde6:        movq    %rcx, %rax
    0.00 :   55bde9:        addq    $0x1, %rax
    0.00 :   55bded:        movq    %rax, 0x10(%rsp)
    0.00 :   55bdf2:        cmpq    %rcx, %rax
    0.00 :   55bdf5:        jb      0x55be21 <test_rs+0x171>
    0.00 :   55bdf7:        jmp     0x55be15 <test_rs+0x165>
    0.00 :   55bdf9:        movq    0x48(%rsp), %rdx
    0.00 :   55bdfe:        movq    0x50(%rsp), %rcx
    0.00 :   55be03:        movq    %rcx, %rax
   17.03 :   55be06:        addq    %rdx, %rax
    0.00 :   55be09:        movq    %rax, 0x8(%rsp)
    0.00 :   55be0e:        cmpq    %rcx, %rax
    0.00 :   55be11:        jb      0x55be42 <test_rs+0x192>
   19.93 :   55be13:        jmp     0x55be33 <test_rs+0x183>
    0.00 :   55be15:        movq    0x10(%rsp), %rax
    0.00 :   55be1a:        movq    %rax, 0x48(%rsp)
    0.00 :   55be1f:        jmp     0x55bdf9 <test_rs+0x149>
    0.00 :   55be21:        leaq    0xa3fc08(%rip), %rdi  # 0xf9ba30
    0.00 :   55be28:        leaq    -0x15104f(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be2f:        callq   *%rax
    0.00 :   55be31:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55be33:        movq    0x8(%rsp), %rax
    0.00 :   55be38:        movq    %rax, 0x50(%rsp)
    1.35 :   55be3d:        jmp     0x55bd53 <test_rs+0xa3>
    0.00 :   55be42:        leaq    0xa3fbff(%rip), %rdi  # 0xf9ba48
    0.00 :   55be49:        leaq    -0x151070(%rip), %rax  # 0x40ade0 <core::panicking::panic_const::panic_const_add_overflow>
    0.00 :   55be50:        callq   *%rax
    0.00 :   55be52:        jmp     0x55bddf <test_rs+0x12f>
    0.00 :   55be54:        callq   *0xa49c2e(%rip)  # 0xfa5a88 <_DYNAMIC+0x1048>
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (576 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------
         : 0      0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>:
    0.00 :   55b190:        subq    $0x68, %rsp
    0.00 :   55b194:        movl    %edi, %eax
    0.00 :   55b196:        movq    %rdx, (%rsp)
   34.20 :   55b19a:        movl    %eax, 0x48(%rsp)
    0.00 :   55b19e:        movl    %esi, 0x4c(%rsp)
    0.00 :   55b1a2:        leaq    0x2922af(%rip), %rcx  # 0x7ed458
    0.00 :   55b1a9:        movq    %rcx, 0x50(%rsp)
   31.25 :   55b1ae:        movq    $0xb8, 0x58(%rsp)
    0.00 :   55b1b7:        movl    %eax, %edi
    0.00 :   55b1b9:        addl    %esi, %edi
    0.00 :   55b1bb:        cmpl    %eax, %edi
    0.00 :   55b1bd:        jb      0x55b1c4 <core::num::<impl u32>::unchecked_add::precondition_check+0x34>
    3.82 :   55b1bf:        addq    $0x68, %rsp
   30.73 :   55b1c3:        retq
    0.00 :   55b1c4:        movq    (%rsp), %rdx
    0.00 :   55b1c8:        leaq    0x292289(%rip), %rax  # 0x7ed458
    0.00 :   55b1cf:        movq    %rax, 0x38(%rsp)
    0.00 :   55b1d4:        movq    $0xb8, 0x40(%rsp)
    0.00 :   55b1dd:        leaq    0x38(%rsp), %rax
    0.00 :   55b1e2:        movq    %rax, 0x60(%rsp)
    0.00 :   55b1e7:        leaq    0x38(%rsp), %rax
    0.00 :   55b1ec:        movq    %rax, 0x8(%rsp)
    0.00 :   55b1f1:        movq    $0x1, 0x10(%rsp)
    0.00 :   55b1fa:        movq    0x27efdf(%rip), %rcx  # 0x7da1e0
    0.00 :   55b201:        movq    0x27efe0(%rip), %rax  # 0x7da1e8
    0.00 :   55b208:        movq    %rcx, 0x28(%rsp)
    0.00 :   55b20d:        movq    %rax, 0x30(%rsp)
    0.00 :   55b212:        movl    $0x8, %eax
    0.00 :   55b217:        movq    %rax, 0x18(%rsp)
    0.00 :   55b21c:        movq    $0x0, 0x20(%rsp)
    0.00 :   55b225:        leaq    0x8(%rsp), %rdi
    0.00 :   55b22a:        xorl    %esi, %esi
    0.00 :   55b22c:        callq   *0xa4ad96(%rip)  # 0xfa5fc8 <_DYNAMIC+0x1588>
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (554 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------
         : 0      0x55b140 <<u32 as core::iter::range::Step>::forward_unchecked>:
    0.00 :   55b140:        subq    $0x28, %rsp
    0.00 :   55b144:        movl    %edi, 0xc(%rsp)
    0.00 :   55b148:        movl    %edi, 0x14(%rsp)
   22.19 :   55b14c:        movq    %rsi, 0x18(%rsp)
    0.00 :   55b151:        movl    %esi, %eax
    0.00 :   55b153:        movl    %eax, 0x10(%rsp)
    0.00 :   55b157:        movl    %eax, 0x24(%rsp)
   14.28 :   55b15b:        movl    0x10(%rsp), %esi
    0.00 :   55b15f:        movl    0xc(%rsp), %edi
    0.00 :   55b163:        leaq    0xa40826(%rip), %rdx  # 0xf9b990
    3.98 :   55b16a:        callq   0x55b190 <core::num::<impl u32>::unchecked_add::precondition_check>
    0.00 :   55b16f:        movl    0x10(%rsp), %ecx
    0.00 :   55b173:        movl    0xc(%rsp), %eax
    0.00 :   55b177:        addl    %ecx, %eax
   30.49 :   55b179:        addq    $0x28, %rsp
   29.07 :   55b17d:        retq
 Percent |	Source code & Disassembly of perf for cpu_core/cycles/Pu (429 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------
         : 0      0x55b820 <core::iter::range::<impl core::iter::traits::iterator::Iterator for core::ops::range::Range<A>>::next>:
    0.00 :   55b820:        pushq   %rax
    0.00 :   55b821:        movq    %rdi, (%rsp)
   60.17 :   55b825:        callq   0x55bc40 <<core::ops::range::Range<T> as core::iter::range::RangeIteratorImpl>::spec_next>
    0.23 :   55b82a:        popq    %rcx
   39.60 :   55b82b:        retq
---- end(-1) ----
 83: perf data type profiling tests                                  : FAILED!
⬢ [acme@toolbx perf-tools-next]$ 


