Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F7C07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 23:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF12661964
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 23:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhGEX2s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 19:28:48 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:33913 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhGEX2r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 19:28:47 -0400
Received: (Authenticated sender: edwin@etorok.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6AA45200003;
        Mon,  5 Jul 2021 23:26:04 +0000 (UTC)
From:   =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edwin@etorok.net>
To:     linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edwin@etorok.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Fabian Hemmer <copy@copy.sh>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Remi Bernon <rbernon@codeweavers.com>,
        Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] RISC-V: make perf record --call-graph=dwarf work
Date:   Tue,  6 Jul 2021 00:25:20 +0100
Message-Id: <20210705232524.4024832-1-edwin@etorok.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently perf on RISC-V cannot gather callgraphs when built without frame pointers.
After this series is applied, and using a trunk version of OCaml (which emits DWARF CFI)
I can successfully get callgraphs from an OCaml program.

Note that the default cpu-cycles event doesn't work, but that is unrelated.

Tested on HiFive Unmatched:
```
 # perf record --user-regs=?
available registers: pc ra sp gp tp t0 t1 t2 s0 s1 a0 a1 a2 a3 a4 a5 a6 a7
 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 t3 t4 t5 t6

 # sed -e 's/(\*\*//' -e 's/\*\*)//' \
testsuite/tests/misc-unsafe/almabench.ml >almabench_benchmark.ml
 # ocamlopt almabench_benchmark.ml -unsafe -o almabench_benchmark
 # perf record -e cpu-clock -v --call-graph=dwarf -F 99 \
./almabench_benchmark

callchain: type DWARF
callchain: stack dump size 8192
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
mmap size 528384B
mmap size 528384B
Control descriptor is not initialized
0 17.00 -26.06
1 12.34 1.29
2 6.83 22.95
3 0.04 -1.26
4 2.30 12.54
5 2.93 14.35
6 21.27 -16.57
7 20.41 -19.04
[ perf record: Woken up 65 times to write data ]
Looking at the vmlinux_path (8 entries long)
Failed to open /proc/kcore.
Note /proc/kcore requires CAP_SYS_RAWIO capability to access.
Using /proc/kallsyms for symbols
failed to write feature CPUDESC
failed to write feature CPUID
failed to write feature NUMA_TOPOLOGY
failed to write feature MEM_TOPOLOGY
[ perf record: Captured and wrote 16.265 MB perf.data (1997 samples) ]

 # perf script
...
almabench_bench  1193 14816.399235:   10101010 cpu-clock:
 3fbbd63d54 reduce_sincos+0x268 (inlined)
 3fbbd63d54 __cos+0x268 (/lib/libm-2.33.so)
 2aac4b261b Almabench_benchmark.planetpv+0x25f
    (/home/root/ocaml/almabench_benchmark)
 2aac4b3e03 Almabench_benchmark.entry+0x12bb
    (/home/root/ocaml/almabench_benchmark)
 2aac4b0097 caml_program+0x143
    (/home/root/ocaml/almabench_benchmark)
 2aac4e4e3d caml_start_program+0x71
    (/home/root/ocaml/almabench_benchmark)
 2aac4e5409 caml_startup_common+0x18f
    (/home/root/ocaml/almabench_benchmark)
 2aac4e5465 caml_startup_exn+0x9 (inlined)
 2aac4e5465 caml_startup+0x9 (inlined)
 2aac4e5465 caml_main+0x9
    (/home/root/ocaml/almabench_benchmark)
 2aac4afe89 main+0x9
    (/home/root/ocaml/almabench_benchmark)
 3fbbc47b0b __libc_start_main+0x85 (/lib/libc-2.33.so)
 2aac4afebb _start+0x2b (/home/root/ocaml/almabench_benchmark)
```

Edwin Török (4):
  tools/perf/arch/riscv: record registers needed for --call-graph=dwarf
  tools/perf: add riscv perf_regs.h to check_headers.sh
  MAINTAINERS: add tools/perf/arch/riscv
  tools/perf/arch/riscv: add libdw unwind test

 MAINTAINERS                                |  1 +
 tools/perf/arch/riscv/Build                |  1 +
 tools/perf/arch/riscv/include/arch-tests.h | 12 +++++
 tools/perf/arch/riscv/include/perf_regs.h  |  2 +
 tools/perf/arch/riscv/tests/Build          |  4 ++
 tools/perf/arch/riscv/tests/arch-tests.c   | 16 ++++++
 tools/perf/arch/riscv/tests/dwarf-unwind.c | 63 ++++++++++++++++++++++
 tools/perf/arch/riscv/tests/regs_load.S    | 45 ++++++++++++++++
 tools/perf/arch/riscv/util/perf_regs.c     | 32 +++++++++++
 tools/perf/check-headers.sh                |  1 +
 tools/perf/tests/Build                     |  2 +-
 11 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/riscv/include/arch-tests.h
 create mode 100644 tools/perf/arch/riscv/tests/Build
 create mode 100644 tools/perf/arch/riscv/tests/arch-tests.c
 create mode 100644 tools/perf/arch/riscv/tests/dwarf-unwind.c
 create mode 100644 tools/perf/arch/riscv/tests/regs_load.S

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Fabian Hemmer <copy@copy.sh>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Remi Bernon <rbernon@codeweavers.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
base-commit: c76826a65f50038f050424365dbf3f97203f8710
prerequisite-patch-id: 7144f880f49c60cdec11fcbae019e764ba37a73d
-- 
2.31.1

