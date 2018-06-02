From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/4] perf tools intel-pt-decoder: Update insn.h from the kernel sources
Date: Sat,  2 Jun 2018 11:59:27 -0300
Message-ID: <20180602145927.23307-5-acme@kernel.org>
References: <20180602145927.23307-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180602145927.23307-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  ee6a7354a362 ("kprobes/x86: Prohibit probing on exception masking instructions")

That doesn't entail changes in tooling, but silences this perf build
warning:

  Warning: Intel PT: x86 instruction decoder header at 'tools/perf/util/intel-pt-decoder/insn.h' differs from latest version at 'arch/x86/include/asm/insn.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-o3wfwjnyh7r8l0gi9q3y9f44@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/insn.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/insn.h b/tools/perf/util/intel-pt-decoder/insn.h
index e23578c7b1be..2669c9f748e4 100644
--- a/tools/perf/util/intel-pt-decoder/insn.h
+++ b/tools/perf/util/intel-pt-decoder/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */
-- 
2.14.3
