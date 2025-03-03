Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4292222A5;
	Mon,  3 Mar 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023488; cv=none; b=EZ16k1qddj4mOLDaDFOMBgeU3+rozigphIf2CePeqMc2Quau13yb7X3ExoCqczZxdVSyHj6jEZ1R/X85qes4UnJHlRqiaiH/c57Z83H7sJEEaJp8XFjL/WQc4SOsakQIk4o8E1Io8KD515hScCnTRAm9VoA83SGHWVStYv/IvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023488; c=relaxed/simple;
	bh=/uZ1vyZcbGkHg8U1+Qya92Gm+x1msqE71uAh4MvNP5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzsOkPGFl8INMLaPHgisXqRD/bu83dwM7OaI0Jt9tfANRXURLM0f4mvB8Degimjek0L1MCMdE8/qU+8LmdVAu1QnlAKYuChBUmsOqoFlWRFa7hK7cpw8HxfAzYb5g/GaBzpuO4YwInZ2yMRRuyby/lEPcIwv4efCGU+ceFD5ixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J29zA2yb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J29zA2yb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C7C4CED6;
	Mon,  3 Mar 2025 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023488;
	bh=/uZ1vyZcbGkHg8U1+Qya92Gm+x1msqE71uAh4MvNP5I=;
	h=From:To:Cc:Subject:Date:From;
	b=J29zA2ybXqy+SHwNIvznlLXYreMsURt0KgGc/Tk7RWJcwrAks+zyaaJAlqC+oXVRH
	 Gd1k4rCqAGG6ZuW74xuSmQlQBFfp7ukc2v9UZcOm6eryBam7UeZymsGVoGHpXuq1uL
	 yxZ7EF3HuB8Plxvu1Vx5e1YR0pfSSHlfCZhknZW7hIifoG0wjTbu64x5GCWhF/wsj0
	 iM5JySIB89MbVIpisqNx2EnYSutJF/9tShnsutP/f4Da0GNQI+WGK90Z6oNffm4Oqh
	 9NfxR0kYLCrB/QN8BBtEbwvrspxdfUUEhXf6/OIRbcbiyjx1W83CJRcb4uy4U6jDQJ
	 Gi7BHoZexbStQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCHSET 0/7] perf annotate: Add --code-with-type option
Date: Mon,  3 Mar 2025 09:38:00 -0800
Message-ID: <20250303173807.1765098-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

There are roughly two modes in the perf annotate.  One is normal code
anootation and the other is data type annotation.  I'm proposing a new
way to combine the code and data annotation together.

With this option, "# data-type: <name> [offset (field)]" part will be
adeded when it found a data type for the given instruction.  This is
for every instruction in the function regardless whether it has a
sample or not.

This will be useful to understand function level data access patterns.
Currently it only works with --stdio, but I can add it to TUI later.

Here's an example output.

  $ perf annotate --code-with-type --stdio
  ...
 Percent |      Source code & Disassembly of elf for cpu/mem-loads,ldlat=30/P (4 samples, percent: local period)
  ----------------------------------------------------------------------------------------------------------------
           : 0                0xffffffff81bb7060 <__schedule>:
      0.00 :   ffffffff81bb7060:        pushq   %rbp              # data-type: (stack operation)
      0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
      0.00 :   ffffffff81bb7064:        pushq   %r15              # data-type: (stack operation)
      0.00 :   ffffffff81bb7066:        pushq   %r14              # data-type: (stack operation)
      0.00 :   ffffffff81bb7068:        pushq   %r13              # data-type: (stack operation)
      0.00 :   ffffffff81bb706a:        pushq   %r12              # data-type: (stack operation)
      0.00 :   ffffffff81bb706c:        pushq   %rbx              # data-type: (stack operation)
      0.00 :   ffffffff81bb706d:        movq    $0x33180, %rbx
      0.00 :   ffffffff81bb7074:        movq    %rbx, %r12
      0.00 :   ffffffff81bb7077:        subq    $0x38, %rsp
      0.00 :   ffffffff81bb707b:        movl    %edi, -0x5c(%rbp)         # data-type: unsigned int +0
      0.00 :   ffffffff81bb707e:        movq    %gs:0x28, %rax            # data-type: (stack canary)
      0.00 :   ffffffff81bb7087:        movq    %rax, -0x30(%rbp)         # data-type: (stack canary)
      0.00 :   ffffffff81bb708b:        xorl    %eax, %eax
      0.00 :   ffffffff81bb708d:        movq    $0x0, -0x58(%rbp)         # data-type: struct rq_flags +0 (flags)
      0.00 :   ffffffff81bb7095:        movq    $0x0, -0x50(%rbp)         # data-type: struct rq_flags +0x8 (clock_update_flags)
      0.00 :   ffffffff81bb709d:        callq   0xffffffff81baa100 <debug_smp_processor_id>               # data-type: (stack operation)
      0.00 :   ffffffff81bb70a2:        cltq
      0.00 :   ffffffff81bb70a4:        addq    -0x7dcf0500(,%rax,8), %r12                # data-type: long unsigned int[] +0
      0.00 :   ffffffff81bb70ac:        movq    0x960(%r12), %r13         # data-type: struct rq +0x960 (curr)
      0.00 :   ffffffff81bb70b4:        movq    0x20(%r13), %rax          # data-type: struct task_struct +0x20 (stack)
      0.00 :   ffffffff81bb70b8:        cmpq    $0x57ac6e9d, (%rax)
      0.00 :   ffffffff81bb70bf:        jne     0xffffffff81bb7bca <__schedule+0xb6a>
      0.00 :   ffffffff81bb70c5:        movl    %gs:0x7e47b87c(%rip), %eax  # 0x32948 <pcpu_hot+0x8>              # data-type: struct pcpu_hot +0x8 (preempt_count)
      0.00 :   ffffffff81bb70cc:        andl    $0x7fffffff, %eax
      0.00 :   ffffffff81bb70d1:        cmpl    $0x1, %eax
      0.00 :   ffffffff81bb70d4:        jne     0xffffffff81bb79de <__schedule+0x97e>
      0.00 :   ffffffff81bb70da:        nopl    (%rax,%rax)
      0.00 :   ffffffff81bb70df:        cmpl    $0x2, 0xe86b3a(%rip)  # 0xffffffff82a3dc20 <prof_on>              # data-type: int +0
      0.00 :   ffffffff81bb70e6:        movq    0x8(%rbp), %rsi
      0.00 :   ffffffff81bb70ea:        je      0xffffffff81bb7a0b <__schedule+0x9ab>
      0.00 :   ffffffff81bb70f0:        nopl    (%rax,%rax)
      0.00 :   ffffffff81bb70f5:        nop
      ...

The code is also available at 'perf/annotate-code-data-v1' branch in
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (7):
  perf annotate-data: Add annotated_data_type__get_member_name()
  perf annotate: Remove unused len parameter from
    annotation_line__print()
  perf annotate: Pass annotation_options to annotation_line__print()
  perf annotate: Pass hist_entry to annotate functions
  perf annotate: Factor out __hist_entry__get_data_type()
  perf annotate: Implement code + data type annotation
  perf annotate: Add --code-with-type option.

 tools/perf/Documentation/perf-annotate.txt |   4 +
 tools/perf/builtin-annotate.c              |  19 +-
 tools/perf/builtin-top.c                   |   2 +-
 tools/perf/util/annotate-data.c            |  34 +++
 tools/perf/util/annotate-data.h            |   3 +
 tools/perf/util/annotate.c                 | 267 +++++++++++++--------
 tools/perf/util/annotate.h                 |   8 +-
 tools/perf/util/sort.c                     |  39 +--
 8 files changed, 236 insertions(+), 140 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog

