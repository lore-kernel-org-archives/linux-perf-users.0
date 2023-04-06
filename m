Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD4EC76196
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Apr 2023 14:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbjDFOmC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbjDFOlt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Apr 2023 10:41:49 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8AAF3C
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Apr 2023 07:39:55 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d8so23869844pgm.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Apr 2023 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680791994;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J09CXnboPgPKUhmaX4S4zbUDe519CmuX/QkDkM2CV2U=;
        b=ONxGGyBMkxTVRMQI4MvfcCYskmpnoH0K+Vp5HnWAVqNSmhchcDK1IHqkJzeL/takgZ
         sxQMepq6zs0p5ocZLApWIAzhQrM9qkIbW7ZBPGhMiUB3z6qfTdulS4Fiv5aST2JOM9vd
         Zjbmig90oNtsrXzQOcMhfxD/7nvtXS92De/Eirs+j8i6L7A+FRLB4W1iVfz7kg2pASqi
         dG47PLAD6G3txnycJpJXVY/2kJN8jry2RmzzMuJNPD9Pn27fO5TS+bSfKozQEw+kBZXV
         wiK/UPq6Td2UoQ5fV1iVi104tmi1w42FPU3J34AmKEZ409w1QIguBGBYxZfU2SRyoIWC
         3Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680791994;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J09CXnboPgPKUhmaX4S4zbUDe519CmuX/QkDkM2CV2U=;
        b=uqNxke7UW6lPQEtCUfeEWIZTjbAD+bNUvz0gq9ANMKpH7pAXMu1WKaymb22mGyk7Tz
         jfCNi56If3fgQj7gw0pefpr/+kjp9lvlD83Xfd2iouCn0/97gGpHE/IpKGgYLgQ39Bz9
         XxoRsTNbeMh/bgdoSmdo5cggFq6NRwIXXrBszmDUTKOxSjJX/XOoLVTev4d4hfrfqpFh
         pcpMq/J2uVbYhGBwetHQH5q3qzcc2H+58jo7fMLDxUjiOnmUXBq9zUvur2qoUX8ZfTpc
         2cj2OFqGT78uvqy/5E94oFeUxPW0OtyEXhiAbPIPc+peqGAtS0TWhXLnFiXAw8tRxehS
         HZjg==
X-Gm-Message-State: AAQBX9dib9ASOfeH5MkWmqcoOpvIL0EmOZM1wzEo94VdErAEKRYFN0gS
        HbQ8WNXENzvpBmft8Dl2TNiH+gym/QqMTQ==
X-Google-Smtp-Source: AKy350bg9MYY47YCX8E15cfDXzg7GSZz7R8aYNEKusCjEMuwyhZRgWv1O2WSaUNMz9m4Aq969WngGA==
X-Received: by 2002:a62:4e54:0:b0:5a8:aca5:817d with SMTP id c81-20020a624e54000000b005a8aca5817dmr9414873pfb.5.1680791994309;
        Thu, 06 Apr 2023 07:39:54 -0700 (PDT)
Received: from [192.168.50.71] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b0062d7b360eafsm1470795pfd.62.2023.04.06.07.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:39:53 -0700 (PDT)
Message-ID: <ceef5f31-ac35-d4a0-8cb2-80787aad7e1d@gmail.com>
Date:   Thu, 6 Apr 2023 23:39:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
From:   Paran Lee <p4ranlee@gmail.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: How to check RISC-V CPU sscofpmf extension in runtime?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello, Atish.
I have tested perf on Starfive Visionfive2 board.

I want to know how to check sscofpmf extension support in user program
or tools.

user@starfive:~/CppTest$ ~/starfive-visionfive2-linux/tools/perf/perf
record -g ./main.o
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cycles:u).
/bin/dmesg | grep -i perf may provide additional information.

[    2.356857] riscv-pmu-sbi: SBI PMU extension is available
[    2.362841] riscv-pmu-sbi: 16 firmware and 4 hardware counters
[    2.369302] riscv-pmu-sbi: Perf sampling/filtering is not supported
as sscof extension is not available

user@starfive:$ grep PERF_EVENT /boot/config-5.15.0-dirty
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_EVENTS=y

So, I find "sscof extension is not available" position of the code

drivers/perf/riscv_pmu_sbi.c
pmu_sbi_device_probe()

	ret = pmu_sbi_setup_irqs(pmu, pdev);

I think adding the result value to the logs will give us a mor detail.
I want to patch :)

I did perf test.

~/starfive-visionfive2-linux/tools/perf/perf test
 1: vmlinux symtab matches kallsyms            : FAILED!
 2: Detect openat syscall event                : FAILED!
 3: Detect openat syscall event on all cpus    : FAILED!
 4: Read samples using the mmap interface      : FAILED!
 5: Test data source output                    : Ok
 6: Parse event definition strings             : FAILED!
 7: Simple expression parser                   : Ok
 8: PERF_RECORD_* events & perf_sample fields  : FAILED!
 9: Parse perf pmu format                      : Ok
10: PMU events                                 :
10.1: PMU event table sanity                           : FAILED!
10.2: PMU event map aliases                            : FAILED!
10.3: Parsing of PMU event table metrics               : Ok
10.4: Parsing of PMU event table metrics with fake PMUs: Ok
11: DSO data read                              : Ok
12: DSO data cache                             : Ok
13: DSO data reopen                            : Ok
14: Roundtrip evsel->name                      : Ok
15: Parse sched tracepoints fields             : FAILED!
16: syscalls:sys_enter_openat event fields     : FAILED!
17: Setup struct perf_event_attr               : Skip
18: Match and link multiple hists              : Ok
19: 'import perf' in python                    : FAILED!
20: Breakpoint overflow signal handler         : FAILED!
21: Breakpoint overflow sampling               : FAILED!
22: Breakpoint accounting                      : Skip
23: Watchpoint                                 :
23.1: Read Only Watchpoint                     : FAILED!
23.2: Write Only Watchpoint                    : FAILED!
23.3: Read / Write Watchpoint                  : FAILED!
23.4: Modify Watchpoint                        : FAILED!
24: Number of exit events of a simple workload : FAILED!
25: Software clock events period values        : Ok
26: Object code reading                        : FAILED!
27: Sample parsing                             : Ok
28: Use a dummy software event to keep tracking: Skip
29: Parse with no sample_id_all bit set        : Ok
30: Filter hist entries                        : Ok
31: Lookup mmap thread                         : Ok
32: Share thread maps                          : Ok
33: Sort output of hist entries                : Ok
34: Cumulate child hist entries                : Ok
35: Track with sched_switch                    : Ok
36: Filter fds with revents mask in a fdarray  : Ok
37: Add fd to a fdarray, making it autogrow    : Ok
38: kmod_path__parse                           : Ok
39: Thread map                                 : Ok
40: LLVM search and compile                    :
40.1: Basic BPF llvm compile                    : Skip
40.2: kbuild searching                          : Skip
40.3: Compile source for BPF prologue generation: Skip
40.4: Compile source for BPF relocation         : Skip
41: Session topology                           : FAILED!
42: BPF filter                                 :
42.1: Basic BPF filtering                      : Skip
42.2: BPF pinning                              : Skip
43: Synthesize thread map                      : Ok
44: Remove thread map                          : Ok
45: Synthesize cpu map                         : Ok
46: Synthesize stat config                     : Ok
47: Synthesize stat                            : Ok
48: Synthesize stat round                      : Ok
49: Synthesize attr update                     : Ok
50: Event times                                : Skip
51: Read backward ring buffer                  : Skip
52: Print cpu map                              : Ok
53: Merge cpu map                              : Ok
54: Probe SDT events                           : Ok
55: is_printable_array                         : Ok
56: Print bitmap                               : Ok
57: perf hooks                                 : Ok
58: builtin clang support                      : Skip (not compiled in)
59: unit_number__scnprintf                     : Ok
60: mem2node                                   : Ok
61: time utils                                 : Ok
62: Test jit_write_elf                         : Skip
63: Test libpfm4 support                       : Skip (not compiled in)
64: Test api io                                : Ok
65: maps__merge_in                             : Ok
66: Demangle Java                              : Ok
67: Demangle OCaml                             : Ok
68: Parse and process metrics                  : Ok
69: PE file support                            : Skip
70: Event expansion for cgroups                : Ok
72: dlfilter C API                             : Ok
failed to open shell test directory:
/home/user/libexec/perf-core/tests/shell


BR
Paran Lee
