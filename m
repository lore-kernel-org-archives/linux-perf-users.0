Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10AEC61DA4
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Mar 2023 01:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCGB2S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Mar 2023 20:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCGB2R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Mar 2023 20:28:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A412ED6F
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Mar 2023 17:28:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oj5so11711067pjb.5
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Mar 2023 17:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678152495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7jFqUMIK4Bo9oSKOWLvUk2wpmnRkhFYIHTJi/l89QE=;
        b=obtVRZTJS9Ljj73OstScusHnJxVdxuiNuQV4TQnO4eSp5uFZtlOTFOtKGbnTsUx88M
         bBg6FP6Q0w3ToiKnt15e3b0HhhJBBwo1MAcoXOier75qRh6WtjXXqSfDTyGIg9kOLrO9
         13jCVBy5SGAb2rFrOEAL7EX4F5vC1iuKkGLNxXwRx5DUfM8no+ZWqE5LGSN01gqTF8vm
         9KRvK5wDBF93d/dq04Y4SZaFzKUxttXz2oYOCox+P88gCDwqSUFRt/RMJNYwghelGuXy
         i2BXp7gQmZKRzqSQPT1P8bIelcjD3rnLXCbCWk6K8a3/bBDqqx4UaduOJuqRZrGbUAnI
         s2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678152495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7jFqUMIK4Bo9oSKOWLvUk2wpmnRkhFYIHTJi/l89QE=;
        b=qVR/ZWCtU6tJCx4gf0LSARtZGR/xxE9gNhQpJ6hLurfUyKumymetXnIN8kI467fRW6
         atlH2Qhw0MOgrqg9ER0u3Muk4LpFxc2MPqjB/WtCs2BtXOtHRH379EG1bAl92aO5WSB2
         1g5xuy7JccvAtUrNcwDe/nUwyDsMfGYi7JLTOkWa2d/YmVnB+CIrBdE9IcuyAD9N+/b2
         ODwnh+cJYDXxkMlSfCU/2tgeQS38zk4ZP5EGXiSF0Sn1qJTHsnKvxg3kuzm4yGw+Mku/
         +CS5eSJyXLJYPSx6QPR7Uvyu6B8Lr+t6qqqL/+j9aBLn4wJ7ogXpCSl4LetlqirlVId7
         cyCA==
X-Gm-Message-State: AO0yUKVOEOWFeEuCrjSxZHYAy95bsIVB1U7z2eHKGXGJRI5PTml0JU3O
        DkiJlSanBItllxTtEf1UQ5lNuQ==
X-Google-Smtp-Source: AK7set8C4BssYYFqZRD65/9a+Ep17z+23HD9bYswcUdfP51iLk5NA/1RmmV0VeEGjeWYVyOwdHc6YQ==
X-Received: by 2002:a17:902:db01:b0:19b:c37:25e7 with SMTP id m1-20020a170902db0100b0019b0c3725e7mr16608294plx.66.1678152494576;
        Mon, 06 Mar 2023 17:28:14 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b0019a6e8ceb49sm7294366plg.259.2023.03.06.17.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:28:14 -0800 (PST)
Date:   Tue, 7 Mar 2023 09:28:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <James.Clark@arm.com>
Cc:     Lukas Molleman <lukas.molleman@gmail.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, rickyman7@gmail.com
Subject: Re: perf test results on ARM64. was Re: GSoC: perf Linux Profiling
 Scalability and speed
Message-ID: <20230307012808.GA2332936@leoy-yangtze.lan>
References: <CANRdyn9kXT623Pbu9hc+c4YrDu_h06a2Ch9fJpt=O0S7yKXDEg@mail.gmail.com>
 <CAP-5=fU30f1j5o7c05ohaygpgV4=Hx7yS7f8i3vZ1j1Gk=HgcA@mail.gmail.com>
 <CANRdyn9H7kzBXUxpvTJ_93G5Tc=51vCRs9ucHbSyVRO_rQf5vA@mail.gmail.com>
 <CAP-5=fUr18kZVDDymDB6kJWa7Ptf9XkDMKxorZx2O2UjPusn1w@mail.gmail.com>
 <CANRdyn9MU1N5xH8MfMbpmxPhRTCqi9J_NWsVOPKXodE97H97rQ@mail.gmail.com>
 <ZAZkvaVBcyM1I4ar@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAZkvaVBcyM1I4ar@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Lukas,

[ +James ]

On Mon, Mar 06, 2023 at 07:10:05PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > I'm using Ubuntu 22.04 kernel 5.15.0-60-generic ARM64.
> > perf version 5.15.78

Just remind, if you test perf on Arm64 platforms, you could refer to the
page [1], section "LKFT Integration with Perf testing on Arm64".  Please
confirm if kernel configurations (e.g. eBPF, Ftrace, etc) have been
enabled and make sure the setting up environment for eBPF & python,
especially if you are using self-built kernel image.

I have not checked the perf test for a long while, so I don't want to
mislead you that I have confirmed the cases can pass on Arm64 platforms.
In below Arnaldo's testing result, there still have some unexpected
failures, we need to look into it in details.

Thanks,
Leo

[1] https://lkft.linaro.org/tests/

> So, here, on a Libre Computer Firefly RK3399PC board and using what will
> soon be on the perf-tools branch to go to Linus:
> 
> root@roc-rk3399-pc:~# cat /etc/os-release
> PRETTY_NAME="Ubuntu 22.04.1 LTS"
> NAME="Ubuntu"
> VERSION_ID="22.04"
> VERSION="22.04.1 LTS (Jammy Jellyfish)"
> VERSION_CODENAME=jammy
> ID=ubuntu
> ID_LIKE=debian
> HOME_URL="https://www.ubuntu.com/"
> SUPPORT_URL="https://help.ubuntu.com/"
> BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
> PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
> UBUNTU_CODENAME=jammy
> root@roc-rk3399-pc:~# perf -v
> perf version 6.2.rc7.g5b201a82cd9d
> root@roc-rk3399-pc:~# perf -vv
> perf version 6.2.rc7.g5b201a82cd9d
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ OFF ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> root@roc-rk3399-pc:~#
> 
> acme@roc-rk3399-pc:~/git/perf-tools$ sudo su -
> [sudo] password for acme: 
> root@roc-rk3399-pc:~# set -o vi
> root@roc-rk3399-pc:~# export PATH=$PATH:~/bin
> root@roc-rk3399-pc:~# perf test
>   1: vmlinux symtab matches kallsyms                                 : Ok
>   2: Detect openat syscall event                                     : Ok
>   3: Detect openat syscall event on all cpus                         : Ok
>   4: mmap interface tests                                            :
>   4.1: Read samples using the mmap interface                         : Ok
>   4.2: User space counter reading of instructions                    : Skip (permissions)
>   4.3: User space counter reading of cycles                          : Skip (permissions)
>   5: Test data source output                                         : Ok
>   6: Parse event definition strings                                  :
>   6.1: Test event parsing                                            : Ok
>   6.2: Test parsing of "hybrid" CPU events                           : Skip (not hybrid)
>   6.3: Parsing of all PMU events from sysfs                          : Skip (permissions)
>   6.4: Parsing of given PMU events from sysfs                        : Skip (permissions)
>   6.5: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
>   6.6: Parsing of aliased events                                     : Ok
>   6.7: Parsing of terms (event modifiers)                            : Ok
>   7: Simple expression parser                                        : Ok
>   8: PERF_RECORD_* events & perf_sample fields                       : Ok
>   9: Parse perf pmu format                                           : Ok
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>  11: DSO data read                                                   : Ok
>  12: DSO data cache                                                  : Ok
>  13: DSO data reopen                                                 : Ok
>  14: Roundtrip evsel->name                                           : Ok
>  15: Parse sched tracepoints fields                                  : Ok
>  16: syscalls:sys_enter_openat event fields                          : Ok
>  17: Setup struct perf_event_attr                                    : FAILED!
>  18: Match and link multiple hists                                   : Ok
>  19: 'import perf' in python                                         : Ok
>  20: Breakpoint overflow signal handler                              : Skip
>  21: Breakpoint overflow sampling                                    : Skip
>  22: Breakpoint accounting                                           : Ok
>  23: Watchpoint                                                      :
>  23.1: Read Only Watchpoint                                          : Ok
>  23.2: Write Only Watchpoint                                         : Ok
>  23.3: Read / Write Watchpoint                                       : Ok
>  23.4: Modify Watchpoint                                             : Ok
>  24: Number of exit events of a simple workload                      : FAILED!
>  25: Software clock events period values                             : Ok
>  26: Object code reading                                             : Ok
>  27: Sample parsing                                                  : Ok
>  28: Use a dummy software event to keep tracking                     : Ok
>  29: Parse with no sample_id_all bit set                             : Ok
>  30: Filter hist entries                                             : Ok
>  31: Lookup mmap thread                                              : Ok
>  32: Share thread maps                                               : Ok
>  33: Sort output of hist entries                                     : Ok
>  34: Cumulate child hist entries                                     : Ok
>  35: Track with sched_switch                                         : Ok
>  36: Filter fds with revents mask in a fdarray                       : Ok
>  37: Add fd to a fdarray, making it autogrow                         : Ok
>  38: kmod_path__parse                                                : Ok
>  39: Thread map                                                      : Ok
>  40: LLVM search and compile                                         :
>  40.1: Basic BPF llvm compile                                        : Ok
>  40.2: kbuild searching                                              : FAILED!
>  40.3: Compile source for BPF prologue generation                    : FAILED!
>  40.4: Compile source for BPF relocation                             : Ok
>  41: Session topology                                                : Ok
>  42: BPF filter                                                      :
>  42.1: Basic BPF filtering                                           : Ok
>  42.2: BPF pinning                                                   : Ok
>  42.3: BPF prologue generation                                       : FAILED!
>  43: Synthesize thread map                                           : Ok
>  44: Remove thread map                                               : Ok
>  45: Synthesize cpu map                                              : Ok
>  46: Synthesize stat config                                          : Ok
>  47: Synthesize stat                                                 : Ok
>  48: Synthesize stat round                                           : Ok
>  49: Synthesize attr update                                          : Ok
>  50: Event times                                                     : Ok
>  51: Read backward ring buffer                                       : Ok
>  52: Print cpu map                                                   : Ok
>  53: Merge cpu map                                                   : Ok
>  54: Probe SDT events                                                : Ok
>  55: is_printable_array                                              : Ok
>  56: Print bitmap                                                    : Ok
>  57: perf hooks                                                      : Ok
>  58: builtin clang support                                           :
>  58.1: builtin clang compile C source to IR                          : Skip (not compiled in)
>  58.2: builtin clang compile C source to ELF object                  : Skip (not compiled in)
>  59: unit_number__scnprintf                                          : Ok
>  60: mem2node                                                        : Ok
>  61: time utils                                                      : Ok
>  62: Test jit_write_elf                                              : Ok
>  63: Test libpfm4 support                                            :
>  63.1: test of individual --pfm-events                               : Skip (not compiled in)
>  63.2: test groups of --pfm-events                                   : Skip (not compiled in)
>  64: Test api io                                                     : Ok
>  65: maps__merge_in                                                  : Ok
>  66: Demangle Java                                                   : Ok
>  67: Demangle OCaml                                                  : Ok
>  68: Parse and process metrics                                       : Ok
>  69: PE file support                                                 : FAILED!
>  70: Event expansion for cgroups                                     : Ok
>  71: Convert perf time to TSC                                        :
>  71.1: TSC support                                                   : Ok
>  71.2: Perf time to TSC                                              : Ok
>  72: dlfilter C API                                                  : Ok
>  73: Sigtrap                                                         : Skip
>  74: Event groups                                                    : Skip
>  75: Symbols                                                         : Ok
>  76: Test dwarf unwind                                               : Ok
>  77: build id cache operations                                       : FAILED!
>  78: CoreSight / ASM Pure Loop                                       : FAILED!
>  79: CoreSight / Memcpy 16k 10 Threads                               : FAILED!
>  80: CoreSight / Thread Loop 10 Threads - Check TID                  : FAILED!
>  81: CoreSight / Thread Loop 2 Threads - Check TID                   : FAILED!
>  82: CoreSight / Unroll Loop Thread 10                               : FAILED!
>  83: daemon operations                                               : Ok
>  84: kernel lock contention analysis test                            : Ok
>  85: perf pipe recording and injection test                          : Ok
>  86: Add vfs_getname probe to get syscall args filenames             : FAILED!
>  87: probe libc's inet_pton & backtrace it with ping                 : Ok
>  88: Use vfs_getname probe to get syscall args filenames             : FAILED!
>  89: Zstd perf.data compression/decompression                        : Ok
>  90: perf record tests                                               : FAILED!
>  91: perf record offcpu profiling tests                              : FAILED!
>  92: perf stat CSV output linter                                     : Ok
>  93: perf stat csv summary test                                      : Ok
>  94: perf stat JSON output linter                                    : FAILED!
>  95: perf stat metrics (shadow stat) test                            : Ok
>  96: perf stat tests                                                 : Ok
>  97: perf all metricgroups test                                      : Ok
>  98: perf all metrics test                                           : Ok
>  99: perf all PMU test                                               : Ok
> 100: perf stat --bpf-counters test                                   : FAILED!
> 101: perf stat --bpf-counters --for-each-cgroup test                 : FAILED!
> 102: Check Arm64 callgraphs are complete in fp mode                  : Ok
> 103: Check Arm CoreSight trace data recording and synthesized samples: FAILED!
> 104: Check Arm SPE trace data recording and synthesized samples      : Skip
> 105: Check Arm SPE doesn't hang when there are forks                 : Skip
> 106: Check branch stack sampling                                     : Skip
> 107: Test data symbol                                                : Skip
> 108: Miscellaneous Intel PT testing                                  : Skip
> 109: Test java symbol                                                : Ok
> 110: perf script task-analyzer tests                                 : Ok
> 111: Check open filename arg using perf trace + vfs_getname          : FAILED!
> root@roc-rk3399-pc:~# 
> 
> 
> 
>  
> > > So the perf tool is written in somewhat low-level C code, in fact we
> > > try to adopt the Linux kernel's conventions so that code between the
> > > tool and the kernel can easily be shared. Frameworks for different
> > > kinds of parallelism would need to be added. In the past Riccardo
> > > Mancini looked at adding workqueues;
> > >
> > https://lore.kernel.org/lkml/3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com/
> > > We'd like to merge this work but it needs rebasing on to the current
> > > perf development tree. One problem encountered by Riccardo was issues
> > > with reference counts. To this end I wrote a reference count checker:
> > > https://lore.kernel.org/lkml/20220211103415.2737789-1-irogers@google.com/
> > > Which has a number of fixes now merged into the tree but not the
> > > actual checking framework itself. A first task may be to work on the
> > > reference count checker and then to bring in Riccardo's work. I
> > > started a rebase on the checker and I should work to send it out again
> > > soon.
> > 
> > Interesting. I edited my planning to this:
> > 
> > Now - start date: Research
> > 
> >    - Get a deeper understanding of workqueue by reading the books "Linux
> >    kernel development: chapter 6" and "Linux device drivers" chapter 7.
> >    - Understand necessary modules, libraries and tools.
> >    - Understand the code that I need to know to succeed.
> >    - Work on fixing the issues with reference counts and rebase workqueues
> >    patch. This task can be worked on between 3 April and 16 April.
> > 
> > Week 2 - 3: Code
> > 
> > 
> >    - Implement workqueue for processing smaller/easier data structures.
> >    Working further on previous contributions.
> > 
> > week 4: Evaluating
> > 
> >    - Evaluate the effectiveness of the working queues on a smaller scale
> >    and devise strategies to implement this on a bigger scale.
> > 
> > Week 5 - 6: Code
> > 
> >    - Implement workqueue for processing bigger/more complex data structures.
> 
> -- 
> 
> - Arnaldo
