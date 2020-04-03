From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/31] perf test x86: Add CET instructions to the new instructions test
Date: Fri,  3 Apr 2020 11:54:17 -0300
Message-ID: <20200403145443.24774-6-acme@kernel.org>
References: <20200403145443.24774-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Ravi v . Shankar" <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add to the "x86 instruction decoder - new instructions" test the
following instructions:

	incsspd
	incsspq
	rdsspd
	rdsspq
	saveprevssp
	rstorssp
	wrssd
	wrssq
	wrussd
	wrussq
	setssbsy
	clrssbsy
	endbr32
	endbr64

And the "notrack" prefix for indirect calls and jumps.

For information about the instructions, refer Intel Control-flow
Enforcement Technology Specification May 2019 (334525-003).

Committer testing:

  $ perf test instr
  67: x86 instruction decoder - new instructions            : Ok
  $

Then use verbose mode and check one of those new instructions:

  $ perf test -v instr |& grep saveprevssp
  Decoded ok: f3 0f 01 ea          	saveprevssp
  Decoded ok: f3 0f 01 ea          	saveprevssp
  $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi v. Shankar <ravi.v.shankar@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/20200204171425.28073-3-yu-cheng.yu@intel.com
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 112 +++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 196 +++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 236 +++++++++++++++++++
 3 files changed, 544 insertions(+)

diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-32.c b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
index e6461abc9e7b..9708ae892061 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-32.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
@@ -2085,6 +2085,118 @@
 "67 f3 0f 38 f8 1c    \tenqcmds (%si),%bx",},
 {{0x67, 0xf3, 0x0f, 0x38, 0xf8, 0x8c, 0x34, 0x12, }, 8, 0, "", "",
 "67 f3 0f 38 f8 8c 34 12 \tenqcmds 0x1234(%si),%cx",},
+{{0xf3, 0x0f, 0xae, 0xe8, }, 4, 0, "", "",
+"f3 0f ae e8          \tincsspd %eax",},
+{{0x0f, 0xae, 0x28, }, 3, 0, "", "",
+"0f ae 28             \txrstor (%eax)",},
+{{0x0f, 0xae, 0x2d, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "", "",
+"0f ae 2d 78 56 34 12 \txrstor 0x12345678",},
+{{0x0f, 0xae, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"0f ae ac c8 78 56 34 12 \txrstor 0x12345678(%eax,%ecx,8)",},
+{{0x0f, 0xae, 0xe8, }, 3, 0, "", "",
+"0f ae e8             \tlfence ",},
+{{0xf3, 0x0f, 0x1e, 0xc8, }, 4, 0, "", "",
+"f3 0f 1e c8          \trdsspd %eax",},
+{{0xf3, 0x0f, 0x01, 0xea, }, 4, 0, "", "",
+"f3 0f 01 ea          \tsaveprevssp ",},
+{{0xf3, 0x0f, 0x01, 0x28, }, 4, 0, "", "",
+"f3 0f 01 28          \trstorssp (%eax)",},
+{{0xf3, 0x0f, 0x01, 0x2d, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"f3 0f 01 2d 78 56 34 12 \trstorssp 0x12345678",},
+{{0xf3, 0x0f, 0x01, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f3 0f 01 ac c8 78 56 34 12 \trstorssp 0x12345678(%eax,%ecx,8)",},
+{{0x0f, 0x38, 0xf6, 0x08, }, 4, 0, "", "",
+"0f 38 f6 08          \twrssd  %ecx,(%eax)",},
+{{0x0f, 0x38, 0xf6, 0x15, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"0f 38 f6 15 78 56 34 12 \twrssd  %edx,0x12345678",},
+{{0x0f, 0x38, 0xf6, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"0f 38 f6 94 c8 78 56 34 12 \twrssd  %edx,0x12345678(%eax,%ecx,8)",},
+{{0x66, 0x0f, 0x38, 0xf5, 0x08, }, 5, 0, "", "",
+"66 0f 38 f5 08       \twrussd %ecx,(%eax)",},
+{{0x66, 0x0f, 0x38, 0xf5, 0x15, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"66 0f 38 f5 15 78 56 34 12 \twrussd %edx,0x12345678",},
+{{0x66, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"66 0f 38 f5 94 c8 78 56 34 12 \twrussd %edx,0x12345678(%eax,%ecx,8)",},
+{{0xf3, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
+"f3 0f 01 e8          \tsetssbsy ",},
+{{0x0f, 0x01, 0xee, }, 3, 0, "", "",
+"0f 01 ee             \trdpkru ",},
+{{0x0f, 0x01, 0xef, }, 3, 0, "", "",
+"0f 01 ef             \twrpkru ",},
+{{0xf3, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
+"f3 0f ae 30          \tclrssbsy (%eax)",},
+{{0xf3, 0x0f, 0xae, 0x35, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"f3 0f ae 35 78 56 34 12 \tclrssbsy 0x12345678",},
+{{0xf3, 0x0f, 0xae, 0xb4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f3 0f ae b4 c8 78 56 34 12 \tclrssbsy 0x12345678(%eax,%ecx,8)",},
+{{0xf3, 0x0f, 0x1e, 0xfb, }, 4, 0, "", "",
+"f3 0f 1e fb          \tendbr32 ",},
+{{0xf3, 0x0f, 0x1e, 0xfa, }, 4, 0, "", "",
+"f3 0f 1e fa          \tendbr64 ",},
+{{0xff, 0xd0, }, 2, 0, "call", "indirect",
+"ff d0                \tcall   *%eax",},
+{{0xff, 0x10, }, 2, 0, "call", "indirect",
+"ff 10                \tcall   *(%eax)",},
+{{0xff, 0x15, 0x78, 0x56, 0x34, 0x12, }, 6, 0, "call", "indirect",
+"ff 15 78 56 34 12    \tcall   *0x12345678",},
+{{0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indirect",
+"ff 94 c8 78 56 34 12 \tcall   *0x12345678(%eax,%ecx,8)",},
+{{0xf2, 0xff, 0xd0, }, 3, 0, "call", "indirect",
+"f2 ff d0             \tbnd call *%eax",},
+{{0xf2, 0xff, 0x10, }, 3, 0, "call", "indirect",
+"f2 ff 10             \tbnd call *(%eax)",},
+{{0xf2, 0xff, 0x15, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indirect",
+"f2 ff 15 78 56 34 12 \tbnd call *0x12345678",},
+{{0xf2, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
+"f2 ff 94 c8 78 56 34 12 \tbnd call *0x12345678(%eax,%ecx,8)",},
+{{0x3e, 0xff, 0xd0, }, 3, 0, "call", "indirect",
+"3e ff d0             \tnotrack call *%eax",},
+{{0x3e, 0xff, 0x10, }, 3, 0, "call", "indirect",
+"3e ff 10             \tnotrack call *(%eax)",},
+{{0x3e, 0xff, 0x15, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indirect",
+"3e ff 15 78 56 34 12 \tnotrack call *0x12345678",},
+{{0x3e, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
+"3e ff 94 c8 78 56 34 12 \tnotrack call *0x12345678(%eax,%ecx,8)",},
+{{0x3e, 0xf2, 0xff, 0xd0, }, 4, 0, "call", "indirect",
+"3e f2 ff d0          \tnotrack bnd call *%eax",},
+{{0x3e, 0xf2, 0xff, 0x10, }, 4, 0, "call", "indirect",
+"3e f2 ff 10          \tnotrack bnd call *(%eax)",},
+{{0x3e, 0xf2, 0xff, 0x15, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
+"3e f2 ff 15 78 56 34 12 \tnotrack bnd call *0x12345678",},
+{{0x3e, 0xf2, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
+"3e f2 ff 94 c8 78 56 34 12 \tnotrack bnd call *0x12345678(%eax,%ecx,8)",},
+{{0xff, 0xe0, }, 2, 0, "jmp", "indirect",
+"ff e0                \tjmp    *%eax",},
+{{0xff, 0x20, }, 2, 0, "jmp", "indirect",
+"ff 20                \tjmp    *(%eax)",},
+{{0xff, 0x25, 0x78, 0x56, 0x34, 0x12, }, 6, 0, "jmp", "indirect",
+"ff 25 78 56 34 12    \tjmp    *0x12345678",},
+{{0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indirect",
+"ff a4 c8 78 56 34 12 \tjmp    *0x12345678(%eax,%ecx,8)",},
+{{0xf2, 0xff, 0xe0, }, 3, 0, "jmp", "indirect",
+"f2 ff e0             \tbnd jmp *%eax",},
+{{0xf2, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
+"f2 ff 20             \tbnd jmp *(%eax)",},
+{{0xf2, 0xff, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indirect",
+"f2 ff 25 78 56 34 12 \tbnd jmp *0x12345678",},
+{{0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
+"f2 ff a4 c8 78 56 34 12 \tbnd jmp *0x12345678(%eax,%ecx,8)",},
+{{0x3e, 0xff, 0xe0, }, 3, 0, "jmp", "indirect",
+"3e ff e0             \tnotrack jmp *%eax",},
+{{0x3e, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
+"3e ff 20             \tnotrack jmp *(%eax)",},
+{{0x3e, 0xff, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indirect",
+"3e ff 25 78 56 34 12 \tnotrack jmp *0x12345678",},
+{{0x3e, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
+"3e ff a4 c8 78 56 34 12 \tnotrack jmp *0x12345678(%eax,%ecx,8)",},
+{{0x3e, 0xf2, 0xff, 0xe0, }, 4, 0, "jmp", "indirect",
+"3e f2 ff e0          \tnotrack bnd jmp *%eax",},
+{{0x3e, 0xf2, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
+"3e f2 ff 20          \tnotrack bnd jmp *(%eax)",},
+{{0x3e, 0xf2, 0xff, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
+"3e f2 ff 25 78 56 34 12 \tnotrack bnd jmp *0x12345678",},
+{{0x3e, 0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
+"3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmp *0x12345678(%eax,%ecx,8)",},
 {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
 "0f 01 cf             \tencls  ",},
 {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-64.c b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
index 567ecccfad7c..5da17d41d302 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-64.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
@@ -2263,6 +2263,202 @@
 "67 f3 0f 38 f8 18    \tenqcmds (%eax),%ebx",},
 {{0x67, 0xf3, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
 "67 f3 0f 38 f8 88 78 56 34 12 \tenqcmds 0x12345678(%eax),%ecx",},
+{{0xf3, 0x0f, 0xae, 0xe8, }, 4, 0, "", "",
+"f3 0f ae e8          \tincsspd %eax",},
+{{0xf3, 0x41, 0x0f, 0xae, 0xe8, }, 5, 0, "", "",
+"f3 41 0f ae e8       \tincsspd %r8d",},
+{{0xf3, 0x48, 0x0f, 0xae, 0xe8, }, 5, 0, "", "",
+"f3 48 0f ae e8       \tincsspq %rax",},
+{{0xf3, 0x49, 0x0f, 0xae, 0xe8, }, 5, 0, "", "",
+"f3 49 0f ae e8       \tincsspq %r8",},
+{{0x0f, 0xae, 0x28, }, 3, 0, "", "",
+"0f ae 28             \txrstor (%rax)",},
+{{0x41, 0x0f, 0xae, 0x28, }, 4, 0, "", "",
+"41 0f ae 28          \txrstor (%r8)",},
+{{0x0f, 0xae, 0x2c, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"0f ae 2c 25 78 56 34 12 \txrstor 0x12345678",},
+{{0x0f, 0xae, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"0f ae ac c8 78 56 34 12 \txrstor 0x12345678(%rax,%rcx,8)",},
+{{0x41, 0x0f, 0xae, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"41 0f ae ac c8 78 56 34 12 \txrstor 0x12345678(%r8,%rcx,8)",},
+{{0x0f, 0xae, 0xe8, }, 3, 0, "", "",
+"0f ae e8             \tlfence ",},
+{{0xf3, 0x0f, 0x1e, 0xc8, }, 4, 0, "", "",
+"f3 0f 1e c8          \trdsspd %eax",},
+{{0xf3, 0x41, 0x0f, 0x1e, 0xc8, }, 5, 0, "", "",
+"f3 41 0f 1e c8       \trdsspd %r8d",},
+{{0xf3, 0x48, 0x0f, 0x1e, 0xc8, }, 5, 0, "", "",
+"f3 48 0f 1e c8       \trdsspq %rax",},
+{{0xf3, 0x49, 0x0f, 0x1e, 0xc8, }, 5, 0, "", "",
+"f3 49 0f 1e c8       \trdsspq %r8",},
+{{0xf3, 0x0f, 0x01, 0xea, }, 4, 0, "", "",
+"f3 0f 01 ea          \tsaveprevssp ",},
+{{0xf3, 0x0f, 0x01, 0x28, }, 4, 0, "", "",
+"f3 0f 01 28          \trstorssp (%rax)",},
+{{0xf3, 0x41, 0x0f, 0x01, 0x28, }, 5, 0, "", "",
+"f3 41 0f 01 28       \trstorssp (%r8)",},
+{{0xf3, 0x0f, 0x01, 0x2c, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f3 0f 01 2c 25 78 56 34 12 \trstorssp 0x12345678",},
+{{0xf3, 0x0f, 0x01, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f3 0f 01 ac c8 78 56 34 12 \trstorssp 0x12345678(%rax,%rcx,8)",},
+{{0xf3, 0x41, 0x0f, 0x01, 0xac, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"f3 41 0f 01 ac c8 78 56 34 12 \trstorssp 0x12345678(%r8,%rcx,8)",},
+{{0x0f, 0x38, 0xf6, 0x08, }, 4, 0, "", "",
+"0f 38 f6 08          \twrssd  %ecx,(%rax)",},
+{{0x41, 0x0f, 0x38, 0xf6, 0x10, }, 5, 0, "", "",
+"41 0f 38 f6 10       \twrssd  %edx,(%r8)",},
+{{0x0f, 0x38, 0xf6, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"0f 38 f6 14 25 78 56 34 12 \twrssd  %edx,0x12345678",},
+{{0x0f, 0x38, 0xf6, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"0f 38 f6 94 c8 78 56 34 12 \twrssd  %edx,0x12345678(%rax,%rcx,8)",},
+{{0x41, 0x0f, 0x38, 0xf6, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"41 0f 38 f6 94 c8 78 56 34 12 \twrssd  %edx,0x12345678(%r8,%rcx,8)",},
+{{0x48, 0x0f, 0x38, 0xf6, 0x08, }, 5, 0, "", "",
+"48 0f 38 f6 08       \twrssq  %rcx,(%rax)",},
+{{0x49, 0x0f, 0x38, 0xf6, 0x10, }, 5, 0, "", "",
+"49 0f 38 f6 10       \twrssq  %rdx,(%r8)",},
+{{0x48, 0x0f, 0x38, 0xf6, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"48 0f 38 f6 14 25 78 56 34 12 \twrssq  %rdx,0x12345678",},
+{{0x48, 0x0f, 0x38, 0xf6, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"48 0f 38 f6 94 c8 78 56 34 12 \twrssq  %rdx,0x12345678(%rax,%rcx,8)",},
+{{0x49, 0x0f, 0x38, 0xf6, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"49 0f 38 f6 94 c8 78 56 34 12 \twrssq  %rdx,0x12345678(%r8,%rcx,8)",},
+{{0x66, 0x0f, 0x38, 0xf5, 0x08, }, 5, 0, "", "",
+"66 0f 38 f5 08       \twrussd %ecx,(%rax)",},
+{{0x66, 0x41, 0x0f, 0x38, 0xf5, 0x10, }, 6, 0, "", "",
+"66 41 0f 38 f5 10    \twrussd %edx,(%r8)",},
+{{0x66, 0x0f, 0x38, 0xf5, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"66 0f 38 f5 14 25 78 56 34 12 \twrussd %edx,0x12345678",},
+{{0x66, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"66 0f 38 f5 94 c8 78 56 34 12 \twrussd %edx,0x12345678(%rax,%rcx,8)",},
+{{0x66, 0x41, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"66 41 0f 38 f5 94 c8 78 56 34 12 \twrussd %edx,0x12345678(%r8,%rcx,8)",},
+{{0x66, 0x48, 0x0f, 0x38, 0xf5, 0x08, }, 6, 0, "", "",
+"66 48 0f 38 f5 08    \twrussq %rcx,(%rax)",},
+{{0x66, 0x49, 0x0f, 0x38, 0xf5, 0x10, }, 6, 0, "", "",
+"66 49 0f 38 f5 10    \twrussq %rdx,(%r8)",},
+{{0x66, 0x48, 0x0f, 0x38, 0xf5, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"66 48 0f 38 f5 14 25 78 56 34 12 \twrussq %rdx,0x12345678",},
+{{0x66, 0x48, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"66 48 0f 38 f5 94 c8 78 56 34 12 \twrussq %rdx,0x12345678(%rax,%rcx,8)",},
+{{0x66, 0x49, 0x0f, 0x38, 0xf5, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"66 49 0f 38 f5 94 c8 78 56 34 12 \twrussq %rdx,0x12345678(%r8,%rcx,8)",},
+{{0xf3, 0x0f, 0x01, 0xe8, }, 4, 0, "", "",
+"f3 0f 01 e8          \tsetssbsy ",},
+{{0x0f, 0x01, 0xee, }, 3, 0, "", "",
+"0f 01 ee             \trdpkru ",},
+{{0x0f, 0x01, 0xef, }, 3, 0, "", "",
+"0f 01 ef             \twrpkru ",},
+{{0xf3, 0x0f, 0xae, 0x30, }, 4, 0, "", "",
+"f3 0f ae 30          \tclrssbsy (%rax)",},
+{{0xf3, 0x41, 0x0f, 0xae, 0x30, }, 5, 0, "", "",
+"f3 41 0f ae 30       \tclrssbsy (%r8)",},
+{{0xf3, 0x0f, 0xae, 0x34, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f3 0f ae 34 25 78 56 34 12 \tclrssbsy 0x12345678",},
+{{0xf3, 0x0f, 0xae, 0xb4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f3 0f ae b4 c8 78 56 34 12 \tclrssbsy 0x12345678(%rax,%rcx,8)",},
+{{0xf3, 0x41, 0x0f, 0xae, 0xb4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"f3 41 0f ae b4 c8 78 56 34 12 \tclrssbsy 0x12345678(%r8,%rcx,8)",},
+{{0xf3, 0x0f, 0x1e, 0xfb, }, 4, 0, "", "",
+"f3 0f 1e fb          \tendbr32 ",},
+{{0xf3, 0x0f, 0x1e, 0xfa, }, 4, 0, "", "",
+"f3 0f 1e fa          \tendbr64 ",},
+{{0xff, 0xd0, }, 2, 0, "call", "indirect",
+"ff d0                \tcallq  *%rax",},
+{{0xff, 0x10, }, 2, 0, "call", "indirect",
+"ff 10                \tcallq  *(%rax)",},
+{{0x41, 0xff, 0x10, }, 3, 0, "call", "indirect",
+"41 ff 10             \tcallq  *(%r8)",},
+{{0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indirect",
+"ff 14 25 78 56 34 12 \tcallq  *0x12345678",},
+{{0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "call", "indirect",
+"ff 94 c8 78 56 34 12 \tcallq  *0x12345678(%rax,%rcx,8)",},
+{{0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
+"41 ff 94 c8 78 56 34 12 \tcallq  *0x12345678(%r8,%rcx,8)",},
+{{0xf2, 0xff, 0xd0, }, 3, 0, "call", "indirect",
+"f2 ff d0             \tbnd callq *%rax",},
+{{0xf2, 0xff, 0x10, }, 3, 0, "call", "indirect",
+"f2 ff 10             \tbnd callq *(%rax)",},
+{{0xf2, 0x41, 0xff, 0x10, }, 4, 0, "call", "indirect",
+"f2 41 ff 10          \tbnd callq *(%r8)",},
+{{0xf2, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
+"f2 ff 14 25 78 56 34 12 \tbnd callq *0x12345678",},
+{{0xf2, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
+"f2 ff 94 c8 78 56 34 12 \tbnd callq *0x12345678(%rax,%rcx,8)",},
+{{0xf2, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
+"f2 41 ff 94 c8 78 56 34 12 \tbnd callq *0x12345678(%r8,%rcx,8)",},
+{{0x3e, 0xff, 0xd0, }, 3, 0, "call", "indirect",
+"3e ff d0             \tnotrack callq *%rax",},
+{{0x3e, 0xff, 0x10, }, 3, 0, "call", "indirect",
+"3e ff 10             \tnotrack callq *(%rax)",},
+{{0x3e, 0x41, 0xff, 0x10, }, 4, 0, "call", "indirect",
+"3e 41 ff 10          \tnotrack callq *(%r8)",},
+{{0x3e, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
+"3e ff 14 25 78 56 34 12 \tnotrack callq *0x12345678",},
+{{0x3e, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "call", "indirect",
+"3e ff 94 c8 78 56 34 12 \tnotrack callq *0x12345678(%rax,%rcx,8)",},
+{{0x3e, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
+"3e 41 ff 94 c8 78 56 34 12 \tnotrack callq *0x12345678(%r8,%rcx,8)",},
+{{0x3e, 0xf2, 0xff, 0xd0, }, 4, 0, "call", "indirect",
+"3e f2 ff d0          \tnotrack bnd callq *%rax",},
+{{0x3e, 0xf2, 0xff, 0x10, }, 4, 0, "call", "indirect",
+"3e f2 ff 10          \tnotrack bnd callq *(%rax)",},
+{{0x3e, 0xf2, 0x41, 0xff, 0x10, }, 5, 0, "call", "indirect",
+"3e f2 41 ff 10       \tnotrack bnd callq *(%r8)",},
+{{0x3e, 0xf2, 0xff, 0x14, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
+"3e f2 ff 14 25 78 56 34 12 \tnotrack bnd callq *0x12345678",},
+{{0x3e, 0xf2, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "call", "indirect",
+"3e f2 ff 94 c8 78 56 34 12 \tnotrack bnd callq *0x12345678(%rax,%rcx,8)",},
+{{0x3e, 0xf2, 0x41, 0xff, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "call", "indirect",
+"3e f2 41 ff 94 c8 78 56 34 12 \tnotrack bnd callq *0x12345678(%r8,%rcx,8)",},
+{{0xff, 0xe0, }, 2, 0, "jmp", "indirect",
+"ff e0                \tjmpq   *%rax",},
+{{0xff, 0x20, }, 2, 0, "jmp", "indirect",
+"ff 20                \tjmpq   *(%rax)",},
+{{0x41, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
+"41 ff 20             \tjmpq   *(%r8)",},
+{{0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indirect",
+"ff 24 25 78 56 34 12 \tjmpq   *0x12345678",},
+{{0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "jmp", "indirect",
+"ff a4 c8 78 56 34 12 \tjmpq   *0x12345678(%rax,%rcx,8)",},
+{{0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
+"41 ff a4 c8 78 56 34 12 \tjmpq   *0x12345678(%r8,%rcx,8)",},
+{{0xf2, 0xff, 0xe0, }, 3, 0, "jmp", "indirect",
+"f2 ff e0             \tbnd jmpq *%rax",},
+{{0xf2, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
+"f2 ff 20             \tbnd jmpq *(%rax)",},
+{{0xf2, 0x41, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
+"f2 41 ff 20          \tbnd jmpq *(%r8)",},
+{{0xf2, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
+"f2 ff 24 25 78 56 34 12 \tbnd jmpq *0x12345678",},
+{{0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
+"f2 ff a4 c8 78 56 34 12 \tbnd jmpq *0x12345678(%rax,%rcx,8)",},
+{{0xf2, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
+"f2 41 ff a4 c8 78 56 34 12 \tbnd jmpq *0x12345678(%r8,%rcx,8)",},
+{{0x3e, 0xff, 0xe0, }, 3, 0, "jmp", "indirect",
+"3e ff e0             \tnotrack jmpq *%rax",},
+{{0x3e, 0xff, 0x20, }, 3, 0, "jmp", "indirect",
+"3e ff 20             \tnotrack jmpq *(%rax)",},
+{{0x3e, 0x41, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
+"3e 41 ff 20          \tnotrack jmpq *(%r8)",},
+{{0x3e, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
+"3e ff 24 25 78 56 34 12 \tnotrack jmpq *0x12345678",},
+{{0x3e, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "jmp", "indirect",
+"3e ff a4 c8 78 56 34 12 \tnotrack jmpq *0x12345678(%rax,%rcx,8)",},
+{{0x3e, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
+"3e 41 ff a4 c8 78 56 34 12 \tnotrack jmpq *0x12345678(%r8,%rcx,8)",},
+{{0x3e, 0xf2, 0xff, 0xe0, }, 4, 0, "jmp", "indirect",
+"3e f2 ff e0          \tnotrack bnd jmpq *%rax",},
+{{0x3e, 0xf2, 0xff, 0x20, }, 4, 0, "jmp", "indirect",
+"3e f2 ff 20          \tnotrack bnd jmpq *(%rax)",},
+{{0x3e, 0xf2, 0x41, 0xff, 0x20, }, 5, 0, "jmp", "indirect",
+"3e f2 41 ff 20       \tnotrack bnd jmpq *(%r8)",},
+{{0x3e, 0xf2, 0xff, 0x24, 0x25, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
+"3e f2 ff 24 25 78 56 34 12 \tnotrack bnd jmpq *0x12345678",},
+{{0x3e, 0xf2, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "jmp", "indirect",
+"3e f2 ff a4 c8 78 56 34 12 \tnotrack bnd jmpq *0x12345678(%rax,%rcx,8)",},
+{{0x3e, 0xf2, 0x41, 0xff, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "jmp", "indirect",
+"3e f2 41 ff a4 c8 78 56 34 12 \tnotrack bnd jmpq *0x12345678(%r8,%rcx,8)",},
 {{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
 "0f 01 cf             \tencls  ",},
 {{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-src.c b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
index ddbf07c50bb8..c3808e94c46e 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-src.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
@@ -1771,6 +1771,145 @@ int main(void)
 	asm volatile("enqcmds (%eax),%ebx");
 	asm volatile("enqcmds 0x12345678(%eax),%ecx");
 
+	/* incsspd/q */
+
+	asm volatile("incsspd %eax");
+	asm volatile("incsspd %r8d");
+	asm volatile("incsspq %rax");
+	asm volatile("incsspq %r8");
+	/* Also check instructions in the same group encoding as incsspd/q */
+	asm volatile("xrstor (%rax)");
+	asm volatile("xrstor (%r8)");
+	asm volatile("xrstor (0x12345678)");
+	asm volatile("xrstor 0x12345678(%rax,%rcx,8)");
+	asm volatile("xrstor 0x12345678(%r8,%rcx,8)");
+	asm volatile("lfence");
+
+	/* rdsspd/q */
+
+	asm volatile("rdsspd %eax");
+	asm volatile("rdsspd %r8d");
+	asm volatile("rdsspq %rax");
+	asm volatile("rdsspq %r8");
+
+	/* saveprevssp */
+
+	asm volatile("saveprevssp");
+
+	/* rstorssp */
+
+	asm volatile("rstorssp (%rax)");
+	asm volatile("rstorssp (%r8)");
+	asm volatile("rstorssp (0x12345678)");
+	asm volatile("rstorssp 0x12345678(%rax,%rcx,8)");
+	asm volatile("rstorssp 0x12345678(%r8,%rcx,8)");
+
+	/* wrssd/q */
+
+	asm volatile("wrssd %ecx,(%rax)");
+	asm volatile("wrssd %edx,(%r8)");
+	asm volatile("wrssd %edx,(0x12345678)");
+	asm volatile("wrssd %edx,0x12345678(%rax,%rcx,8)");
+	asm volatile("wrssd %edx,0x12345678(%r8,%rcx,8)");
+	asm volatile("wrssq %rcx,(%rax)");
+	asm volatile("wrssq %rdx,(%r8)");
+	asm volatile("wrssq %rdx,(0x12345678)");
+	asm volatile("wrssq %rdx,0x12345678(%rax,%rcx,8)");
+	asm volatile("wrssq %rdx,0x12345678(%r8,%rcx,8)");
+
+	/* wrussd/q */
+
+	asm volatile("wrussd %ecx,(%rax)");
+	asm volatile("wrussd %edx,(%r8)");
+	asm volatile("wrussd %edx,(0x12345678)");
+	asm volatile("wrussd %edx,0x12345678(%rax,%rcx,8)");
+	asm volatile("wrussd %edx,0x12345678(%r8,%rcx,8)");
+	asm volatile("wrussq %rcx,(%rax)");
+	asm volatile("wrussq %rdx,(%r8)");
+	asm volatile("wrussq %rdx,(0x12345678)");
+	asm volatile("wrussq %rdx,0x12345678(%rax,%rcx,8)");
+	asm volatile("wrussq %rdx,0x12345678(%r8,%rcx,8)");
+
+	/* setssbsy */
+
+	asm volatile("setssbsy");
+	/* Also check instructions in the same group encoding as setssbsy */
+	asm volatile("rdpkru");
+	asm volatile("wrpkru");
+
+	/* clrssbsy */
+
+	asm volatile("clrssbsy (%rax)");
+	asm volatile("clrssbsy (%r8)");
+	asm volatile("clrssbsy (0x12345678)");
+	asm volatile("clrssbsy 0x12345678(%rax,%rcx,8)");
+	asm volatile("clrssbsy 0x12345678(%r8,%rcx,8)");
+
+	/* endbr32/64 */
+
+	asm volatile("endbr32");
+	asm volatile("endbr64");
+
+	/* call with/without notrack prefix */
+
+	asm volatile("callq *%rax");				/* Expecting: call indirect 0 */
+	asm volatile("callq *(%rax)");				/* Expecting: call indirect 0 */
+	asm volatile("callq *(%r8)");				/* Expecting: call indirect 0 */
+	asm volatile("callq *(0x12345678)");			/* Expecting: call indirect 0 */
+	asm volatile("callq *0x12345678(%rax,%rcx,8)");		/* Expecting: call indirect 0 */
+	asm volatile("callq *0x12345678(%r8,%rcx,8)");		/* Expecting: call indirect 0 */
+
+	asm volatile("bnd callq *%rax");			/* Expecting: call indirect 0 */
+	asm volatile("bnd callq *(%rax)");			/* Expecting: call indirect 0 */
+	asm volatile("bnd callq *(%r8)");			/* Expecting: call indirect 0 */
+	asm volatile("bnd callq *(0x12345678)");		/* Expecting: call indirect 0 */
+	asm volatile("bnd callq *0x12345678(%rax,%rcx,8)");	/* Expecting: call indirect 0 */
+	asm volatile("bnd callq *0x12345678(%r8,%rcx,8)");	/* Expecting: call indirect 0 */
+
+	asm volatile("notrack callq *%rax");			/* Expecting: call indirect 0 */
+	asm volatile("notrack callq *(%rax)");			/* Expecting: call indirect 0 */
+	asm volatile("notrack callq *(%r8)");			/* Expecting: call indirect 0 */
+	asm volatile("notrack callq *(0x12345678)");		/* Expecting: call indirect 0 */
+	asm volatile("notrack callq *0x12345678(%rax,%rcx,8)");	/* Expecting: call indirect 0 */
+	asm volatile("notrack callq *0x12345678(%r8,%rcx,8)");	/* Expecting: call indirect 0 */
+
+	asm volatile("notrack bnd callq *%rax");		/* Expecting: call indirect 0 */
+	asm volatile("notrack bnd callq *(%rax)");		/* Expecting: call indirect 0 */
+	asm volatile("notrack bnd callq *(%r8)");		/* Expecting: call indirect 0 */
+	asm volatile("notrack bnd callq *(0x12345678)");	/* Expecting: call indirect 0 */
+	asm volatile("notrack bnd callq *0x12345678(%rax,%rcx,8)");	/* Expecting: call indirect 0 */
+	asm volatile("notrack bnd callq *0x12345678(%r8,%rcx,8)");	/* Expecting: call indirect 0 */
+
+	/* jmp with/without notrack prefix */
+
+	asm volatile("jmpq *%rax");				/* Expecting: jmp indirect 0 */
+	asm volatile("jmpq *(%rax)");				/* Expecting: jmp indirect 0 */
+	asm volatile("jmpq *(%r8)");				/* Expecting: jmp indirect 0 */
+	asm volatile("jmpq *(0x12345678)");			/* Expecting: jmp indirect 0 */
+	asm volatile("jmpq *0x12345678(%rax,%rcx,8)");		/* Expecting: jmp indirect 0 */
+	asm volatile("jmpq *0x12345678(%r8,%rcx,8)");		/* Expecting: jmp indirect 0 */
+
+	asm volatile("bnd jmpq *%rax");				/* Expecting: jmp indirect 0 */
+	asm volatile("bnd jmpq *(%rax)");			/* Expecting: jmp indirect 0 */
+	asm volatile("bnd jmpq *(%r8)");			/* Expecting: jmp indirect 0 */
+	asm volatile("bnd jmpq *(0x12345678)");			/* Expecting: jmp indirect 0 */
+	asm volatile("bnd jmpq *0x12345678(%rax,%rcx,8)");	/* Expecting: jmp indirect 0 */
+	asm volatile("bnd jmpq *0x12345678(%r8,%rcx,8)");	/* Expecting: jmp indirect 0 */
+
+	asm volatile("notrack jmpq *%rax");			/* Expecting: jmp indirect 0 */
+	asm volatile("notrack jmpq *(%rax)");			/* Expecting: jmp indirect 0 */
+	asm volatile("notrack jmpq *(%r8)");			/* Expecting: jmp indirect 0 */
+	asm volatile("notrack jmpq *(0x12345678)");		/* Expecting: jmp indirect 0 */
+	asm volatile("notrack jmpq *0x12345678(%rax,%rcx,8)");	/* Expecting: jmp indirect 0 */
+	asm volatile("notrack jmpq *0x12345678(%r8,%rcx,8)");	/* Expecting: jmp indirect 0 */
+
+	asm volatile("notrack bnd jmpq *%rax");			/* Expecting: jmp indirect 0 */
+	asm volatile("notrack bnd jmpq *(%rax)");		/* Expecting: jmp indirect 0 */
+	asm volatile("notrack bnd jmpq *(%r8)");		/* Expecting: jmp indirect 0 */
+	asm volatile("notrack bnd jmpq *(0x12345678)");		/* Expecting: jmp indirect 0 */
+	asm volatile("notrack bnd jmpq *0x12345678(%rax,%rcx,8)");	/* Expecting: jmp indirect 0 */
+	asm volatile("notrack bnd jmpq *0x12345678(%r8,%rcx,8)");	/* Expecting: jmp indirect 0 */
+
 #else  /* #ifdef __x86_64__ */
 
 	/* bound r32, mem (same op code as EVEX prefix) */
@@ -3434,6 +3573,103 @@ int main(void)
 	asm volatile("enqcmds (%si),%bx");
 	asm volatile("enqcmds 0x1234(%si),%cx");
 
+	/* incsspd */
+
+	asm volatile("incsspd %eax");
+	/* Also check instructions in the same group encoding as incsspd */
+	asm volatile("xrstor (%eax)");
+	asm volatile("xrstor (0x12345678)");
+	asm volatile("xrstor 0x12345678(%eax,%ecx,8)");
+	asm volatile("lfence");
+
+	/* rdsspd */
+
+	asm volatile("rdsspd %eax");
+
+	/* saveprevssp */
+
+	asm volatile("saveprevssp");
+
+	/* rstorssp */
+
+	asm volatile("rstorssp (%eax)");
+	asm volatile("rstorssp (0x12345678)");
+	asm volatile("rstorssp 0x12345678(%eax,%ecx,8)");
+
+	/* wrssd */
+
+	asm volatile("wrssd %ecx,(%eax)");
+	asm volatile("wrssd %edx,(0x12345678)");
+	asm volatile("wrssd %edx,0x12345678(%eax,%ecx,8)");
+
+	/* wrussd */
+
+	asm volatile("wrussd %ecx,(%eax)");
+	asm volatile("wrussd %edx,(0x12345678)");
+	asm volatile("wrussd %edx,0x12345678(%eax,%ecx,8)");
+
+	/* setssbsy */
+
+	asm volatile("setssbsy");
+	/* Also check instructions in the same group encoding as setssbsy */
+	asm volatile("rdpkru");
+	asm volatile("wrpkru");
+
+	/* clrssbsy */
+
+	asm volatile("clrssbsy (%eax)");
+	asm volatile("clrssbsy (0x12345678)");
+	asm volatile("clrssbsy 0x12345678(%eax,%ecx,8)");
+
+	/* endbr32/64 */
+
+	asm volatile("endbr32");
+	asm volatile("endbr64");
+
+	/* call with/without notrack prefix */
+
+	asm volatile("call *%eax");				/* Expecting: call indirect 0 */
+	asm volatile("call *(%eax)");				/* Expecting: call indirect 0 */
+	asm volatile("call *(0x12345678)");			/* Expecting: call indirect 0 */
+	asm volatile("call *0x12345678(%eax,%ecx,8)");		/* Expecting: call indirect 0 */
+
+	asm volatile("bnd call *%eax");				/* Expecting: call indirect 0 */
+	asm volatile("bnd call *(%eax)");			/* Expecting: call indirect 0 */
+	asm volatile("bnd call *(0x12345678)");			/* Expecting: call indirect 0 */
+	asm volatile("bnd call *0x12345678(%eax,%ecx,8)");	/* Expecting: call indirect 0 */
+
+	asm volatile("notrack call *%eax");			/* Expecting: call indirect 0 */
+	asm volatile("notrack call *(%eax)");			/* Expecting: call indirect 0 */
+	asm volatile("notrack call *(0x12345678)");		/* Expecting: call indirect 0 */
+	asm volatile("notrack call *0x12345678(%eax,%ecx,8)");	/* Expecting: call indirect 0 */
+
+	asm volatile("notrack bnd call *%eax");			/* Expecting: call indirect 0 */
+	asm volatile("notrack bnd call *(%eax)");		/* Expecting: call indirect 0 */
+	asm volatile("notrack bnd call *(0x12345678)");		/* Expecting: call indirect 0 */
+	asm volatile("notrack bnd call *0x12345678(%eax,%ecx,8)"); /* Expecting: call indirect 0 */
+
+	/* jmp with/without notrack prefix */
+
+	asm volatile("jmp *%eax");				/* Expecting: jmp indirect 0 */
+	asm volatile("jmp *(%eax)");				/* Expecting: jmp indirect 0 */
+	asm volatile("jmp *(0x12345678)");			/* Expecting: jmp indirect 0 */
+	asm volatile("jmp *0x12345678(%eax,%ecx,8)");		/* Expecting: jmp indirect 0 */
+
+	asm volatile("bnd jmp *%eax");				/* Expecting: jmp indirect 0 */
+	asm volatile("bnd jmp *(%eax)");			/* Expecting: jmp indirect 0 */
+	asm volatile("bnd jmp *(0x12345678)");			/* Expecting: jmp indirect 0 */
+	asm volatile("bnd jmp *0x12345678(%eax,%ecx,8)");	/* Expecting: jmp indirect 0 */
+
+	asm volatile("notrack jmp *%eax");			/* Expecting: jmp indirect 0 */
+	asm volatile("notrack jmp *(%eax)");			/* Expecting: jmp indirect 0 */
+	asm volatile("notrack jmp *(0x12345678)");		/* Expecting: jmp indirect 0 */
+	asm volatile("notrack jmp *0x12345678(%eax,%ecx,8)");	/* Expecting: jmp indirect 0 */
+
+	asm volatile("notrack bnd jmp *%eax");			/* Expecting: jmp indirect 0 */
+	asm volatile("notrack bnd jmp *(%eax)");		/* Expecting: jmp indirect 0 */
+	asm volatile("notrack bnd jmp *(0x12345678)");		/* Expecting: jmp indirect 0 */
+	asm volatile("notrack bnd jmp *0x12345678(%eax,%ecx,8)"); /* Expecting: jmp indirect 0 */
+
 #endif /* #ifndef __x86_64__ */
 
 	/* SGX */
-- 
2.21.1
