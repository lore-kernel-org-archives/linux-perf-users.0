Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10191C678D5
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Mar 2023 21:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCGV4i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCGV4i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Mar 2023 16:56:38 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13DAD02F
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Mar 2023 13:56:36 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id k9so8876628ilu.13
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Mar 2023 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678226196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rveWX4XJg/Qkkxcd1WRDIn4qMcZV5+mal9JHsCcmPA=;
        b=Ycpi8aInEeo+ROGI7MjpD9OtCtnGtlPbndL3ZgmKs0c1oc2CLdSp26mSoxg+LxO4nm
         XMlHl+t2dPgYq3toxoO5KLHK6lE4u36r3Cf0SxkSUtJmGKTQO12v5t8oa3G91thPgfQH
         Cx2ROVOnQn13ahFpIdgG1XpdQSyBQ4TQjRu9KotCg1N1EbJkfLv2dk8IN5zcqW+5AOQJ
         KE9oZQGuPtcMgEoruZ84GO0O441+l3b3ImvIR2Zu1yqJO2PdSRYQ5Zz5P6kYVBP/9iil
         K/loiZ+llFSj4A2P2Y7yPyOUe/6MrT84pfEMPYlrv1q/bnCbjcTWDWQ2sq49lpjb/neN
         4U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rveWX4XJg/Qkkxcd1WRDIn4qMcZV5+mal9JHsCcmPA=;
        b=Z1c6ydC0Ns/EIsCPcMBGPFIVXrOfAcU1MRqcgRyEJL25j5m9uG/jw0hKsWngy7wDcC
         pRLUhTz8TdpeqDmutoz40Y75ljLG0A0jqSQ497HNZ6+gsfOoJ5VDBe0ntWtvDR2s+zyB
         itQ38fyivghStWzrkqtQ4l+emzB8LNvSUNDUVQyNWfs83ELQiToouCAlNZR+TBZc49m3
         w17sIZANn05EW9XF+X0PAItKFTs30VG7MX6Kimw3tZMbEUW9uwpnFxid1c6gJrZLjcpN
         EpA2RLHxYxhZ4+daaJ9Lkm85e4RJNyji+vSdPjfsIyL3upaDIm7Z7XBTVk1qFU0gX7dh
         eRdw==
X-Gm-Message-State: AO0yUKXTuR85l8iuU9fn/DibviGOPeUExfrePIio9cuWSHl7iaSHblF8
        xLNvuncBJAqyXfQbC16AqlYonJ+pz0/y7UaTAup9vA==
X-Google-Smtp-Source: AK7set+O5UV0TH3KmBsgerMuRszBBa2nk9DVamEE4clRFiRb7I0l8i3kNoI2TdobI63w/fcPONGWetgE0jOwwyDx4lo=
X-Received: by 2002:a05:6e02:13f4:b0:310:9fc1:a92b with SMTP id
 w20-20020a056e0213f400b003109fc1a92bmr8161924ilj.0.1678226195774; Tue, 07 Mar
 2023 13:56:35 -0800 (PST)
MIME-Version: 1.0
References: <CANRdyn9kXT623Pbu9hc+c4YrDu_h06a2Ch9fJpt=O0S7yKXDEg@mail.gmail.com>
 <CAP-5=fU30f1j5o7c05ohaygpgV4=Hx7yS7f8i3vZ1j1Gk=HgcA@mail.gmail.com>
 <CANRdyn9H7kzBXUxpvTJ_93G5Tc=51vCRs9ucHbSyVRO_rQf5vA@mail.gmail.com>
 <CAP-5=fUr18kZVDDymDB6kJWa7Ptf9XkDMKxorZx2O2UjPusn1w@mail.gmail.com> <CANRdyn9MU1N5xH8MfMbpmxPhRTCqi9J_NWsVOPKXodE97H97rQ@mail.gmail.com>
In-Reply-To: <CANRdyn9MU1N5xH8MfMbpmxPhRTCqi9J_NWsVOPKXodE97H97rQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Mar 2023 13:56:24 -0800
Message-ID: <CAP-5=fX5nUbhrWENd3=ZcEXPdpFk_3yGo2wWtpwoy8nqvqPgog@mail.gmail.com>
Subject: Re: GSoC: perf Linux Profiling Scalability and speed
To:     Lukas Molleman <lukas.molleman@gmail.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        rickyman7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 6, 2023 at 3:18=E2=80=AFAM Lukas Molleman <lukas.molleman@gmail=
.com> wrote:
>
> > Perhaps if you share what the errors are then we can talk about how to
> > fix them. There are also tests that currently say skip but don't give
> > a reason, it'd be nice to improve this.
>
>  1: vmlinux symtab matches kallsyms            : FAILED!
>  2: Detect openat syscall event                : FAILED!
>  3: Detect openat syscall event on all cpus    : FAILED!
>  4: Read samples using the mmap interface      : FAILED!
>  5: Test data source output                    : Ok
>  6: Parse event definition strings             : FAILED!
>  7: Simple expression parser                   : Ok
>  8: PERF_RECORD_* events & perf_sample fields  : FAILED!
>  9: Parse perf pmu format                      : Ok
> 10: PMU events                                 :
> 10.1: PMU event table sanity                           : Ok
> 10.2: PMU event map aliases                            : Ok
> 10.3: Parsing of PMU event table metrics               : Ok
> 10.4: Parsing of PMU event table metrics with fake PMUs: Ok
> 11: DSO data read                              : Ok
> 12: DSO data cache                             : Ok
> 13: DSO data reopen                            : Ok
> 14: Roundtrip evsel->name                      : Ok
> 15: Parse sched tracepoints fields             : FAILED!
> 16: syscalls:sys_enter_openat event fields     : FAILED!
> 17: Setup struct perf_event_attr               : Skip
> 18: Match and link multiple hists              : Ok
> 19: 'import perf' in python                    : Ok
> 22: Breakpoint accounting                      : Skip
> 23: Watchpoint                                 :
> 23.1: Read Only Watchpoint                     : FAILED!
> 23.2: Write Only Watchpoint                    : FAILED!
> 23.3: Read / Write Watchpoint                  : FAILED!
> 23.4: Modify Watchpoint                        : FAILED!
> 24: Number of exit events of a simple workload : FAILED!
> 25: Software clock events period values        : FAILED!
> 26: Object code reading                        : FAILED!
> 27: Sample parsing                             : Ok
> 28: Use a dummy software event to keep tracking: Skip
> 29: Parse with no sample_id_all bit set        : Ok
> 30: Filter hist entries                        : Ok
> 31: Lookup mmap thread                         : Ok
> 32: Share thread maps                          : Ok
> 33: Sort output of hist entries                : Ok
> 34: Cumulate child hist entries                : Ok
> 35: Track with sched_switch                    : Ok
> 36: Filter fds with revents mask in a fdarray  : Ok
> 37: Add fd to a fdarray, making it autogrow    : Ok
> 38: kmod_path__parse                           : Ok
> 39: Thread map                                 : Ok
> 40: LLVM search and compile                    :
> 40.1: Basic BPF llvm compile                    : Skip
> 40.2: kbuild searching                          : Skip
> 40.3: Compile source for BPF prologue generation: Skip
> 40.4: Compile source for BPF relocation         : Skip
> 41: Session topology                           : Ok
> 42: BPF filter                                 :
> 42.1: Basic BPF filtering                      : Skip
> 42.2: BPF pinning                              : Skip
> 42.3: BPF prologue generation                  : Skip
> 43: Synthesize thread map                      : Ok
> 44: Remove thread map                          : Ok
> 45: Synthesize cpu map                         : Ok
> 46: Synthesize stat config                     : Ok
> 47: Synthesize stat                            : Ok
> 48: Synthesize stat round                      : Ok
> 49: Synthesize attr update                     : Ok
> 50: Event times                                : FAILED!
> 51: Read backward ring buffer                  : Skip
> 52: Print cpu map                              : Ok
> 53: Merge cpu map                              : Ok
> 54: Probe SDT events                           : Skip
> 55: is_printable_array                         : Ok
> 56: Print bitmap                               : Ok
> 57: perf hooks                                 : Ok
> 58: builtin clang support                      : Skip (not compiled in)
> 59: unit_number__scnprintf                     : Ok
> 60: mem2node                                   : Ok
> 61: time utils                                 : Ok
> 62: Test jit_write_elf                         : Ok
> 63: Test libpfm4 support                       : Skip (not compiled in)
> 64: Test api io                                : Ok
> 65: maps__merge_in                             : Ok
> 66: Demangle Java                              : Ok
> 67: Demangle OCaml                             : Ok
> 68: Parse and process metrics                  : Ok
> 69: PE file support                            : Skip
> 70: Event expansion for cgroups                : Ok
> 71: Convert perf time to TSC                   : FAILED!
> 72: dlfilter C API                             : Skip
> 73: DWARF unwind                               : Ok
> failed to open shell test directory: /usr/libexec/perf-core/tests/shell
>
> I'm using Ubuntu 22.04 kernel 5.15.0-60-generic ARM64.
> perf version 5.15.78

Thanks for checking this Lukas. With `perf test` you can run
individual tests by putting the test number after `perf test`, you can
add the verbose flags (-v, -vv, -vvv) to see what the issue is. The -F
flag will let you run the test without forking, which simplifies
debugging with say gdb. I would also suggest using the latest version
of the perf tool from the maintainer's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
as you may be seeing issues that are already fixed.

Thanks,
Ian


> > So the perf tool is written in somewhat low-level C code, in fact we
> > try to adopt the Linux kernel's conventions so that code between the
> > tool and the kernel can easily be shared. Frameworks for different
> > kinds of parallelism would need to be added. In the past Riccardo
> > Mancini looked at adding workqueues;
> > https://lore.kernel.org/lkml/3c4f8dd64d07373d876990ceb16e469b4029363f.c=
amel@gmail.com/
> > We'd like to merge this work but it needs rebasing on to the current
> > perf development tree. One problem encountered by Riccardo was issues
> > with reference counts. To this end I wrote a reference count checker:
> > https://lore.kernel.org/lkml/20220211103415.2737789-1-irogers@google.co=
m/
> > Which has a number of fixes now merged into the tree but not the
> > actual checking framework itself. A first task may be to work on the
> > reference count checker and then to bring in Riccardo's work. I
> > started a rebase on the checker and I should work to send it out again
> > soon.
>
> Interesting. I edited my planning to this:
>
> Now - start date: Research
>
> Get a deeper understanding of workqueue by reading the books "Linux kerne=
l development: chapter 6" and "Linux device drivers" chapter 7.
> Understand necessary modules, libraries and tools.
> Understand the code that I need to know to succeed.
> Work on fixing the issues with reference counts and rebase workqueues pat=
ch. This task can be worked on between 3 April and 16 April.
>
> Week 2 - 3: Code
>
> Implement workqueue for processing smaller/easier data structures. Workin=
g further on previous contributions.
>
> week 4: Evaluating
>
> Evaluate the effectiveness of the working queues on a smaller scale and d=
evise strategies to implement this on a bigger scale.
>
> Week 5 - 6: Code
>
> Implement workqueue for processing bigger/more complex data structures.
