Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1632397AA;
	Mon,  3 Mar 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023492; cv=none; b=dI+HQkx/vycmTOJTHZGdQ27FMZfwTDKLswxtTPyn4nUtbp2LkoLicCV0SajTM9D6OShS2ZAY9YZazjyo19G2OU5zRKJ7NdaCUgY93tLNODtTfl/PcVkVmzcdclkjSUEK1sz3EjoZ7V+efOrt+UuJDMgWdSMUQSB0R+5DnmmNqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023492; c=relaxed/simple;
	bh=zvJuD9IQBZxuLiwJIKQJHoFj6naa/SXfsleK9VlqYZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1aWL7UAcLhikFdEB1j9L8+ToLr8JsHgqGaSdSLy74cWEzL5Ffi4dM7bB+KkWrxe4su8wnxm6GyxIb4bSE4Tzw22abZxSQ10PHgs3+G7O9twOnNLGui7ZEb545PC78DQFOLFKc4XoKt/5wF3LSYBCbFgQhuUpHEdMahbCVeCwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3imuJU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3imuJU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B017C4CEEA;
	Mon,  3 Mar 2025 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023491;
	bh=zvJuD9IQBZxuLiwJIKQJHoFj6naa/SXfsleK9VlqYZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3imuJU5lltIyd6z0maI7yQaoD2/qW0nDgyRmPIz7tHsWA/gaXxtZsmnC4fHWNqKg
	 Sg9D3QOZ0kDpMxV1ZbMJMqw2lwUAwaOasxhcOXwJdThL0Gt0BF+Jg+3g/Z2v9+9sHM
	 kjQLq8D0CmTBTnc4r9ftUhchr+hDJZiUmFvWXs10h23WRlpobdY/2uX1ldCoFlZwrT
	 dekCO96Cd2BYjteMWb5N/jVLynEt16DdmiFS4UVV1fyPape2900tPUevIgRYWz+wsD
	 zHRMk3vtwrvqMZSPJGGmwoybewCbpehe2beNuF+dL3RUNUrN00pVOdRDGDQaT0TqRi
	 8sw45kFaC4ovw==
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
Subject: [PATCH 7/7] perf annotate: Add --code-with-type option.
Date: Mon,  3 Mar 2025 09:38:07 -0800
Message-ID: <20250303173807.1765098-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303173807.1765098-1-namhyung@kernel.org>
References: <20250303173807.1765098-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is to show data type info in the regular (code) annotation.
It tries to find data type for each (memory) instruction in the
function.  It'd be useful to see function-level memory access pattern
and also to debug the data type profiling result.

The output would be added at the end of the line and have "# data-type:"
prefix.

For now, it only works with --stdio mode for simplicity.  I can work on
enabling it for TUI later.

  $ perf annotate --stdio --code-with-type
   Percent |      Source code & Disassembly of vmlinux for cpu/mem-loads/ppk (253 samples, percent: local period)
  ---------------------------------------------------------------------------------------------------------------
           : 0                0xffffffff81baa000 <check_preemption_disabled>:
      0.00 :   ffffffff81baa000:        pushq   %r12              # data-type: (stack operation)
      0.00 :   ffffffff81baa002:        pushq   %rbp              # data-type: (stack operation)
      0.00 :   ffffffff81baa003:        pushq   %rbx              # data-type: (stack operation)
      0.00 :   ffffffff81baa004:        subq    $0x8, %rsp
     18.00 :   ffffffff81baa008:        movl    %gs:0x7e48893d(%rip), %ebx  # 0x3294c <pcpu_hot+0xc>              # data-type: struct pcpu_hot +0xc (cpu_number)
     12.58 :   ffffffff81baa00f:        movl    %gs:0x7e488932(%rip), %eax  # 0x32948 <pcpu_hot+0x8>              # data-type: struct pcpu_hot +0x8 (preempt_count)
      0.00 :   ffffffff81baa016:        testl   $0x7fffffff, %eax
      0.00 :   ffffffff81baa01b:        je      0xffffffff81baa02c <check_preemption_disabled+0x2c>
      0.00 :   ffffffff81baa01d:        addq    $0x8, %rsp
      0.00 :   ffffffff81baa021:        movl    %ebx, %eax
     14.19 :   ffffffff81baa023:        popq    %rbx              # data-type: (stack operation)
     18.86 :   ffffffff81baa024:        popq    %rbp              # data-type: (stack operation)
     12.10 :   ffffffff81baa025:        popq    %r12              # data-type: (stack operation)
     17.78 :   ffffffff81baa027:        jmp     0xffffffff81bc1170 <__x86_return_thunk>
      6.49 :   ffffffff81baa02c:        callq   *0xc9139e(%rip)  # 0xffffffff8283b3d0 <pv_ops+0xf0>               # data-type: (stack operation)
      0.00 :   ffffffff81baa032:        testb   $0x2, %ah
      0.00 :   ffffffff81baa035:        je      0xffffffff81baa01d <check_preemption_disabled+0x1d>
      0.00 :   ffffffff81baa037:        movq    %rdi, %rbp
      0.00 :   ffffffff81baa03a:        movq    %gs:0x32940, %rax         # data-type: struct pcpu_hot +0 (current_task)
      0.00 :   ffffffff81baa043:        testb   $0x4, 0x2f(%rax)          # data-type: struct task_struct +0x2f (flags)
      0.00 :   ffffffff81baa047:        je      0xffffffff81baa052 <check_preemption_disabled+0x52>
      0.00 :   ffffffff81baa049:        cmpl    $0x1, 0x3d0(%rax)         # data-type: struct task_struct +0x3d0 (nr_cpus_allowed)
      0.00 :   ffffffff81baa050:        je      0xffffffff81baa01d <check_preemption_disabled+0x1d>
      0.00 :   ffffffff81baa052:        movq    %gs:0x32940, %r12         # data-type: struct pcpu_hot +0 (current_task)
      0.00 :   ffffffff81baa05b:        cmpw    $0x0, 0x7f0(%r12)         # data-type: struct task_struct +0x7f0 (migration_disabled)
      0.00 :   ffffffff81baa065:        movq    %rsi, (%rsp)
      0.00 :   ffffffff81baa069:        jne     0xffffffff81baa01d <check_preemption_disabled+0x1d>
      0.00 :   ffffffff81baa06b:        movl    0xe8dd13(%rip), %eax  # 0xffffffff82a37d84 <system_state>         # data-type: enum system_states +0
      0.00 :   ffffffff81baa071:        testl   %eax, %eax
      0.00 :   ffffffff81baa073:        je      0xffffffff81baa01d <check_preemption_disabled+0x1d>
      0.00 :   ffffffff81baa075:        incl    %gs:0x7e4888cc(%rip)  # 0x32948 <pcpu_hot+0x8>            # data-type: struct pcpu_hot +0x8 (preempt_count)
      0.00 :   ffffffff81baa07c:        movq    $-0x7e14a100, %rdi
      0.00 :   ffffffff81baa083:        callq   0xffffffff81148c40 <__printk_ratelimit>           # data-type: (stack operation)
      0.00 :   ffffffff81baa088:        testl   %eax, %eax
      0.00 :   ffffffff81baa08a:        je      0xffffffff81baa0d5 <check_preemption_disabled+0xd5>
      0.00 :   ffffffff81baa08c:        movl    0x958(%r12), %r9d         # data-type: struct task_struct +0x958 (pid)
      0.00 :   ffffffff81baa094:        movq    (%rsp), %rdx              # data-type: char* +0
      0.00 :   ffffffff81baa098:        movq    %rbp, %rsi
      0.00 :   ffffffff81baa09b:        leaq    0xb88(%r12), %r8          # data-type: struct task_struct +0xb88 (comm)
      0.00 :   ffffffff81baa0a3:        movl    %gs:0x7e48889e(%rip), %ecx  # 0x32948 <pcpu_hot+0x8>              # data-type: struct pcpu_hot +0x8 (preempt_count)
      0.00 :   ffffffff81baa0aa:        andl    $0x7fffffff, %ecx
      0.00 :   ffffffff81baa0b0:        movq    $-0x7dd3cdf0, %rdi
      0.00 :   ffffffff81baa0b7:        subl    $0x1, %ecx
      0.00 :   ffffffff81baa0ba:        callq   0xffffffff81149340 <_printk>              # data-type: (stack operation)
      0.00 :   ffffffff81baa0bf:        movq    0x20(%rsp), %rsi
      0.00 :   ffffffff81baa0c4:        movq    $-0x7ddb8c7e, %rdi
      0.00 :   ffffffff81baa0cb:        callq   0xffffffff81149340 <_printk>              # data-type: (stack operation)
      0.00 :   ffffffff81baa0d0:        callq   0xffffffff81b7ab60 <dump_stack>           # data-type: (stack operation)
      0.00 :   ffffffff81baa0d5:        decl    %gs:0x7e48886c(%rip)  # 0x32948 <pcpu_hot+0x8>            # data-type: struct pcpu_hot +0x8 (preempt_count)
      0.00 :   ffffffff81baa0dc:        jmp     0xffffffff81baa01d <check_preemption_disabled+0x1d>

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-annotate.txt | 4 ++++
 tools/perf/builtin-annotate.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 156c5f37b05141ca..46090c5b42b4762f 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -168,6 +168,10 @@ include::itrace.txt[]
 --skip-empty::
 	Do not display empty (or dummy) events.
 
+--code-with-type::
+	Show data type info in code annotation (for memory instructions only).
+	Currently it only works with --stdio option.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 966950c38306d6ea..9833c2c82a2fee46 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -788,6 +788,8 @@ int cmd_annotate(int argc, const char **argv)
 		    "Show instruction stats for the data type annotation"),
 	OPT_BOOLEAN(0, "skip-empty", &symbol_conf.skip_empty,
 		    "Do not display empty (or dummy) events in the output"),
+	OPT_BOOLEAN(0, "code-with-type", &annotate_opts.code_with_type,
+		    "Show data type info in code annotation (memory instructions only)"),
 	OPT_END()
 	};
 	int ret;
@@ -913,6 +915,13 @@ int cmd_annotate(int argc, const char **argv)
 		annotate_opts.annotate_src = false;
 		symbol_conf.annotate_data_member = true;
 		symbol_conf.annotate_data_sample = true;
+	} else if (annotate_opts.code_with_type) {
+		symbol_conf.annotate_data_member = true;
+
+		if (!annotate.use_stdio) {
+			pr_err("--code-with-type only works with --stdio.\n");
+			goto out_delete;
+		}
 	}
 
 	setup_browser(true);
-- 
2.48.1.711.g2feabab25a-goog

