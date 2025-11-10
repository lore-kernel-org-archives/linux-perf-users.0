Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A659329368
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792721; cv=none; b=D2cNR4Cn2XaXsSnASE65uOqoM1sx9k/Hv1u1J7vtGE5rh/ueDG2x8KhzPK2I5LYFlBblTi0Bz+dL2VqWId88M+ntctw+Pe1PuCz9GB/EqE5o45Fe43KgvoBsna+f82cqyG2k/NpwVtEeIYOG7X48X0jqDCtzbPMNz7UYdReCSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792721; c=relaxed/simple;
	bh=VDsZenUzfnE+W8QkR96oGT8so3wbc7gpK/KHvs4jUIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hj/7gN2mwwJoDHsY0007m4BGzlVuJrNCCnuf0g9VO/DG7YaLzjPZZMi00vXAEgZjb6BOEQDaJ+r7Z0n+5m/etWSjyZFtQTq5NAKRPFM2EZWm9BUPvElfS3S+p4SyFvmY9L8IyGvAh3htAuQiSGZjcl9WQW5yBuLIOmh1CRNu2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baFq+VWt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baFq+VWt"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ba599137cf7so2456679a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 08:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792718; x=1763397518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OccL0Sq4R/RA62B7XB61l1HOYHt90e9E66Mfl8uInY=;
        b=baFq+VWt0QzdbLhjDWftOXoIiJQ9KySs/iIb+ZkmSofkOAKwv3nB74M82lQ8pXbPGb
         36yATHxiixrSJJY4i5FTdAr7a6xJxAChhgc36ESDDNm8xlBkIBofSgyc6C8KaEu6wh3c
         Vq5pQv/jdJ9RpUGpbW10RI/RdRmduIooHXfXLhwNDlz/c21lt6LGRT/Sw+ArywO0rEdA
         tnQDQoj2GTwaZr9NYXvRpz5g07N/7F9fr8E7r4nXyE7PpryI4hc6s0ZnczjpsgyCQ9f+
         07z1y/kvSpaz1NvgwOiHMpkASVk281dSBw5TGk/4pTp8v7b9BLi6p/AEwa2LCHzCRnuM
         4YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792718; x=1763397518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1OccL0Sq4R/RA62B7XB61l1HOYHt90e9E66Mfl8uInY=;
        b=uPjDqTjjnB/5Cp2bRm0UWjzeiVFPhrjY7fa8rKORrNQJwJvQjqL72+giw8gh8QMVgr
         rGtkCtFmk5KcN4O268hN4dWv0F9FS8NzXXzQ4+pp+Tnkp8A0ayWQBWZ1CFFQ89aVnNt1
         mH4G/LBOlWfOfYC80hYTF09y8hmrj7YbjiS354ooCNzaNMUET+a5xJPJMsQZiOi4iDgt
         fH4dlQU8uSUuaALd+vZP6MdQVEvgy0CPDPmNa5WuWXnWfhYuwcXO0UbS5aTLP8yRfZgT
         G05RBS4Z4pcptNbhgNHAjSwqGNnu7tGyv+sBCN4sRuMXeiBeC2qK43/5ouH2SgAWzB4M
         nPgA==
X-Forwarded-Encrypted: i=1; AJvYcCXTNBTlUaPO/7+3S+4TCLKcYDkRXtfI2rgAKyhqHYkQs/BDhzLU8HS3txNmj/I9esSdpK58I2lVkNXTpNcSTd4Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjv3M1ecU+R5sTeI43EnbqKWTGZm5jVpWs5z/kEq2GDStFo7n
	TfU+BIDPfxYdJ1EyZ1XpjrFd6IA3/eM+uUFNCSlpVsDggORRxDpNiFVx
X-Gm-Gg: ASbGncvR1Nr8p7TU71G+qJBV/UjxkNCLQ/q+z6ctnEsIKO1AcJ72Egns/PTw2vWb7Wt
	X32Enjs5k+95nLJe15q148dsJlczphQP3uRduNmENwuW5S4SnlgNejDIvLV7rbqF/eXrkEWpskL
	t0jryW0gtvzyq62p5miijBbTbUt49tUjMTomjxeRuna5SJNkl1fMgFlMZdvi1JEvxYeTy6JO8XF
	pfOY+zi0oVbsNRwxOJkXSd0h6qAbCxYrqT7u8YgW7+2YSFGw7mIc+NC8EL/chmulAV3NubO4RCk
	nlO9CHM396GyJR3FIQ/1Mb5c09m7mis+DaRWiZkb/fWniACU9H2t5KcfeBpxwJJUG7gnEul180g
	B3Cj4kgjnRNctRivQBL4Hy72SPPYzcPJRJlVK+Xz07hnvMl4uy72+b4cBeQOGxGjr03rERMPSCF
	sCm+zk7naedCU=
X-Google-Smtp-Source: AGHT+IExIQBwxVCTQRLrox7JMc34uETHKbl/Z36VlnkqJ0Z8ANoAeswbWItT/aZ29+cnLxMDYj5a3A==
X-Received: by 2002:a17:902:cec7:b0:295:9db1:ff32 with SMTP id d9443c01a7336-297e56dc7b2mr114908455ad.48.1762792718180;
        Mon, 10 Nov 2025 08:38:38 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e5bdsm150563255ad.39.2025.11.10.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:37 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 26/27] docs: add KStackWatch document
Date: Tue, 11 Nov 2025 00:36:21 +0800
Message-ID: <20251110163634.3686676-27-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation for KStackWatch under Documentation/.

It provides an overview, main features, usage details, configuration
parameters, and example scenarios with test cases. The document also
explains how to locate function offsets and interpret logs.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 Documentation/dev-tools/index.rst       |   1 +
 Documentation/dev-tools/kstackwatch.rst | 377 ++++++++++++++++++++++++
 2 files changed, 378 insertions(+)
 create mode 100644 Documentation/dev-tools/kstackwatch.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 4b8425e348ab..272ae9b76863 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -32,6 +32,7 @@ Documentation/process/debugging/index.rst
    lkmm/index
    kfence
    kselftest
+   kstackwatch
    kunit/index
    ktap
    checkuapi
diff --git a/Documentation/dev-tools/kstackwatch.rst b/Documentation/dev-tools/kstackwatch.rst
new file mode 100644
index 000000000000..9b710b90e512
--- /dev/null
+++ b/Documentation/dev-tools/kstackwatch.rst
@@ -0,0 +1,377 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+Kernel Stack Watch (KStackWatch)
+=================================
+
+Overview
+========
+
+KStackWatch is a lightweight debugging tool designed to detect kernel stack
+corruption in real time. It installs a hardware breakpoint (watchpoint) at a
+function's specified offset using *kprobe.post_handler* and removes it in
+*fprobe.exit_handler*. This covers the full execution window and reports
+corruption immediately with time, location, and call stack.
+
+Main features:
+
+* Immediate and precise stack corruption detection
+* Support for multiple concurrent watchpoints with configurable limits
+* Lockless design, usable in any context
+* Depth filter for recursive calls
+* Low overhead of memory and CPU
+* Flexible debugfs configuration with key=val syntax
+* Architecture support: x86_64 and arm64
+* Auto-canary detection to simplify configuration
+
+Performance Impact
+==================
+
+Runtime overhead was measured on Intel Core Ultra 5 125H @ 3 GHz running
+kernel 6.17, using test4:
+
++------------------------+-------------+---------+
+| Type                   | Time (ns)   | Cycles  |
++========================+=============+=========+
+| entry with watch       | 10892       | 32620   |
++------------------------+-------------+---------+
+| entry without watch    | 159         | 466     |
++------------------------+-------------+---------+
+| exit with watch        | 12541       | 37556   |
++------------------------+-------------+---------+
+| exit without watch     | 124         | 369     |
++------------------------+-------------+---------+
+
+From a broader perspective, the overall comparison is as follows:
+
++----------------------------+----------------------+-------------------------+
+| Mode                       | CPU Overhead (add)   | Memory Overhead (add)   |
++============================+======================+=========================+
+| Compiled but not enabled   | None                 | ~20 B per task          |
++----------------------------+----------------------+-------------------------+
+| Enabled, no function hit   | None                 | ~few hundred B          |
++----------------------------+----------------------+-------------------------+
+| Func hit, HWBP not toggled | ~140 ns per call     | None                    |
++----------------------------+----------------------+-------------------------+
+| Func hit, HWBP toggled     | ~11–12 µs per call   | None                    |
++----------------------------+----------------------+-------------------------+
+
+The overhead is minimal, making KStackWatch suitable for production
+environments where stack corruption is suspected but kernel rebuilds are not
+feasible.
+
+Kconfig Options
+===============
+
+The following configuration options control KStackWatch builds:
+
+- CONFIG_KSTACKWATCH
+
+  Builds the kernel with KStackWatch enabled.
+
+- CONFIG_KSTACKWATCH_PROFILING
+
+  Measures probe runtime overhead for performance analysis and tuning.
+
+- CONFIG_KSTACKWATCH_TEST
+
+  Builds a test module to validate KStackWatch functionality.
+
+Usage
+=====
+
+KStackWatch provides optional configurations for different use cases.
+CONFIG_KSTACKWATCH enables real-time stack corruption detection using hardware breakpoints and probes.
+CONFIG_KSTACKWATCH_PROFILING allows measurement of probe latency and overhead for performance analysis.
+CONFIG_KSTACKWATCH_TEST builds a test module for validating KStackWatch functionality under controlled conditions.
+
+KStackWatch is configured through */sys/kernel/debug/kstackwatch/config* using a
+key=value format. Both long and short forms are supported. Writing an empty
+string disables the watch.
+
+.. code-block:: bash
+
+	# long form
+	echo func_name=? func_offset=? ... > /sys/kernel/debug/kstackwatch/config
+
+	# short form
+	echo fn=? fo=? ... > /sys/kernel/debug/kstackwatch/config
+
+	# disable
+	echo > /sys/kernel/debug/kstackwatch/config
+
+The func_name and the func_offset where the watchpoint should be placed must be
+known. This information can be obtained from *objdump* or other tools.
+
+Required parameters
+--------------------
+
++--------------+--------+-----------------------------------------+
+| Parameter    | Short  | Description                             |
++==============+========+=========================================+
+| func_name    | fn     | Name of the target function             |
++--------------+--------+-----------------------------------------+
+| func_offset  | fo     | Instruction pointer offset              |
++--------------+--------+-----------------------------------------+
+
+Optional parameters
+--------------------
+
+Default 0 and can be omitted.
+Both decimal and hexadecimal are supported.
+
++--------------+--------+------------------------------------------------+
+| Parameter    | Short  | Description                                    |
++==============+========+================================================+
+| auto_canary  | ac     | Automatically calculated canary sp_offset      |
++--------------+--------+------------------------------------------------+
+| depth        | dp     | Recursion depth filter                         |
++--------------+--------+------------------------------------------------+
+|              |        | Maximum number of concurrent watchpoints       |
+| max_watch    | mw     | (default 0, capped by available hardware       |
+|              |        | breakpoints)                                   |
++--------------+--------+------------------------------------------------+
+| panic_hit    | ph     | Panic system on watchpoint hit (default 0)     |
++--------------+--------+------------------------------------------------+
+| sp_offset    | so     | Watching addr offset from stack pointer        |
++--------------+--------+------------------------------------------------+
+| watch_len    | wl     | Watch length in bytes (1, 2, 4, 8 onX86_64)    |
++--------------+--------+------------------------------------------------+
+
+
+Workflow Example
+================
+
+Silent corruption
+-----------------
+
+Consider *test3* in *kstackwatch_test.sh*. Run it directly:
+
+.. code-block:: bash
+
+	echo test3 >/sys/kernel/debug/kstackwatch/test
+
+Sometimes, *test_mthread_victim()* may report as unhappy:
+
+.. code-block:: bash
+
+	[    7.807082] kstackwatch_test: victim[0][11]: unhappy buf[8]=0xabcdabcd
+
+Its source code is:
+
+.. code-block:: c
+
+	static void test_mthread_victim(int thread_id, int seq_id, u64 start_ns)
+	{
+		ulong buf[BUFFER_SIZE];
+
+		for (int j = 0; j < BUFFER_SIZE; j++)
+			buf[j] = 0xdeadbeef + seq_id;
+
+		if (start_ns)
+			silent_wait_us(start_ns, VICTIM_MINIOR_WAIT_NS);
+
+		for (int j = 0; j < BUFFER_SIZE; j++) {
+			if (buf[j] != (0xdeadbeef + seq_id)) {
+				pr_warn("victim[%d][%d]: unhappy buf[%d]=0x%lx\n",
+					thread_id, seq_id, j, buf[j]);
+				return;
+			}
+		}
+
+		pr_info("victim[%d][%d]: happy\n", thread_id, seq_id);
+	}
+
+From the source code, the report indicates buf[8] was unexpectedly modified,
+a case of silent corruption.
+
+Configuration
+-------------
+
+Since buf[8] is the corrupted variable, the following configuration shows
+how to use KStackWatch to detect its corruption.
+
+func_name
+~~~~~~~~~~~
+
+As seen, buf[8] is initialized and modified in *test_mthread_victim*\(\) ,
+which sets *func_name*.
+
+func_offset & sp_offset
+~~~~~~~~~~~~~~~~~~~~~~~~~
+The watchpoint should be set after the assignment and as close as
+possible, which sets *func_offset*.
+
+The watchpoint should be set to watch buf[8], which sets *sp_offset*.
+
+Use the objdump output to disassemble the function:
+
+.. code-block:: bash
+
+	objdump -S --disassemble=test_mthread_victim vmlinux
+
+A shortened output is:
+
+.. code-block:: text
+
+	static void test_mthread_victim(int thread_id, int seq_id, u64 start_ns)
+	{
+	ffffffff815cb4e0:       e8 5b 9b ca ff          call   ffffffff81275040 <__fentry__>
+	ffffffff815cb4e5:       55                      push   %rbp
+	ffffffff815cb4e6:       53                      push   %rbx
+	ffffffff815cb4e7:       48 81 ec 08 01 00 00    sub    $0x108,%rsp
+	ffffffff815cb4ee:       89 fd                   mov    %edi,%ebp
+	ffffffff815cb4f0:       89 f3                   mov    %esi,%ebx
+	ffffffff815cb4f2:       49 89 d0                mov    %rdx,%r8
+	ffffffff815cb4f5:       65 48 8b 05 0b cb 80    mov    %gs:0x280cb0b(%rip),%rax        # ffffffff83dd8008 <__stack_chk_guard>
+	ffffffff815cb4fc:       02
+	ffffffff815cb4fd:       48 89 84 24 00 01 00    mov    %rax,0x100(%rsp)
+	ffffffff815cb504:       00
+	ffffffff815cb505:       31 c0                   xor    %eax,%eax
+		ulong buf[BUFFER_SIZE];
+	ffffffff815cb507:       48 89 e2                mov    %rsp,%rdx
+	ffffffff815cb50a:       b9 20 00 00 00          mov    $0x20,%ecx
+	ffffffff815cb50f:       48 89 d7                mov    %rdx,%rdi
+	ffffffff815cb512:       f3 48 ab                rep stos %rax,%es:(%rdi)
+
+		for (int j = 0; j < BUFFER_SIZE; j++)
+	ffffffff815cb515:       eb 10                   jmp    ffffffff815cb527 <test_mthread_victim+0x47>
+			buf[j] = 0xdeadbeef + seq_id;
+	ffffffff815cb517:       8d 93 ef be ad de       lea    -0x21524111(%rbx),%edx
+	ffffffff815cb51d:       48 63 c8                movslq %eax,%rcx
+	ffffffff815cb520:       48 89 14 cc             mov    %rdx,(%rsp,%rcx,8)
+	ffffffff815cb524:       83 c0 01                add    $0x1,%eax
+	ffffffff815cb527:       83 f8 1f                cmp    $0x1f,%eax
+	ffffffff815cb52a:       7e eb                   jle    ffffffff815cb517 <test_mthread_victim+0x37>
+		if (start_ns)
+	ffffffff815cb52c:       4d 85 c0                test   %r8,%r8
+	ffffffff815cb52f:       75 21                   jne    ffffffff815cb552 <test_mthread_victim+0x72>
+			silent_wait_us(start_ns, VICTIM_MINIOR_WAIT_NS);
+	...
+	ffffffff815cb571:       48 8b 84 24 00 01 00    mov    0x100(%rsp),%rax
+	ffffffff815cb579:       65 48 2b 05 87 ca 80    sub    %gs:0x280ca87(%rip),%rax        # ffffffff83dd8008 <__stack_chk_guard>
+	...
+	ffffffff815cb5a1:       eb ce                   jmp    ffffffff815cb571 <test_mthread_victim+0x91>
+	}
+	ffffffff815cb5a3:       e8 d8 86 f1 00          call   ffffffff824e3c80 <__stack_chk_fail>
+
+
+func_offset
+^^^^^^^^^^^
+
+The function begins at ffffffff815cb4e0. The *buf* array is initialized in a loop.
+The instruction storing values into the array is at ffffffff815cb520, and the
+first instruction after the loop is at ffffffff815cb52c.
+
+Because KStackWatch uses *kprobe.post_handler*, the watchpoint can be
+set right after ffffffff815cb520. However, this will cause false positive
+because the watchpoint is active before buf[8] is assigned.
+
+An alternative is to place the watchpoint at ffffffff815cb52c, right
+after the loop. This avoids false positives but leaves a small window
+for false negatives.
+
+In this document, ffffffff815cb52c is chosen for cleaner logs. If false
+negatives are suspected, repeat the test to catch the corruption.
+
+The required offset is calculated from the function start:
+
+*func_offset* is 0x4c (ffffffff815cb52c - ffffffff815cb4e0).
+
+sp_offset
+^^^^^^^^^^^
+
+From the disassembly, the buf array is at the top of the stack,
+meaning buf == rsp. Therefore, buf[8] sits at rsp + 8 * sizeof(ulong) =
+rsp + 64. Thus, *sp_offset* is 64.
+
+Other parameters
+~~~~~~~~~~~~~~~~~~
+
+* *depth* is 0, as test_mthread_victim is not recursive
+* *max_watch* is 0 to use all available hwbps
+* *watch_len* is 8, the size of a ulong on x86_64
+
+Parameters with a value of 0 can be omitted as defaults.
+
+Configure the watch:
+
+.. code-block:: bash
+
+	echo "fn=test_mthread_victim fo=0x4c so=64 wl=8" > /sys/kernel/debug/kstackwatch/config
+
+Now rerun the test:
+
+.. code-block:: bash
+
+	echo test3 >/sys/kernel/debug/kstackwatch/test
+
+The dmesg log shows:
+
+.. code-block:: text
+
+	[    7.607074] kstackwatch: ========== KStackWatch: Caught stack corruption =======
+	[    7.607077] kstackwatch: config fn=test_mthread_victim fo=0x4c so=64 wl=8
+	[    7.607080] CPU: 2 UID: 0 PID: 347 Comm: corrupting Not tainted 6.17.0-rc7-00022-g90270f3db80a-dirty #509 PREEMPT(voluntary)
+	[    7.607083] Call Trace:
+	[    7.607084]  <#DB>
+	[    7.607085]  dump_stack_lvl+0x66/0xa0
+	[    7.607091]  ksw_watch_handler.part.0+0x2b/0x60
+	[    7.607094]  ksw_watch_handler+0xba/0xd0
+	[    7.607095]  ? test_mthread_corrupting+0x48/0xd0
+	[    7.607097]  ? kthread+0x10d/0x210
+	[    7.607099]  ? ret_from_fork+0x187/0x1e0
+	[    7.607102]  ? ret_from_fork_asm+0x1a/0x30
+	[    7.607105]  __perf_event_overflow+0x154/0x570
+	[    7.607108]  perf_bp_event+0xb4/0xc0
+	[    7.607112]  ? look_up_lock_class+0x59/0x150
+	[    7.607115]  hw_breakpoint_exceptions_notify+0xf7/0x110
+	[    7.607117]  notifier_call_chain+0x44/0x110
+	[    7.607119]  atomic_notifier_call_chain+0x5f/0x110
+	[    7.607121]  notify_die+0x4c/0xb0
+	[    7.607123]  exc_debug_kernel+0xaf/0x170
+	[    7.607126]  asm_exc_debug+0x1e/0x40
+	[    7.607127] RIP: 0010:test_mthread_corrupting+0x48/0xd0
+	[    7.607129] Code: c7 80 0a 24 83 e8 48 f1 f1 00 48 85 c0 74 dd eb 30 bb 00 00 00 00 eb 59 48 63 c2 48 c1 e0 03 48 03 03 be cd ab cd ab 48 89 30 <83> c2 01 b8 20 00 00 00 29 c8 39 d0 7f e0 48 8d 7b 10 e8 d1 86 d4
+	[    7.607130] RSP: 0018:ffffc90000acfee0 EFLAGS: 00000286
+	[    7.607132] RAX: ffffc90000a13de8 RBX: ffff888102d57580 RCX: 0000000000000008
+	[    7.607132] RDX: 0000000000000008 RSI: 00000000abcdabcd RDI: ffffc90000acfe00
+	[    7.607133] RBP: ffff8881085bc800 R08: 0000000000000001 R09: 0000000000000000
+	[    7.607133] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888105398000
+	[    7.607134] R13: ffff8881085bc800 R14: ffffffff815cb660 R15: 0000000000000000
+	[    7.607134]  ? __pfx_test_mthread_corrupting+0x10/0x10
+	[    7.607137]  </#DB>
+	[    7.607138]  <TASK>
+	[    7.607138]  kthread+0x10d/0x210
+	[    7.607140]  ? __pfx_kthread+0x10/0x10
+	[    7.607141]  ret_from_fork+0x187/0x1e0
+	[    7.607143]  ? __pfx_kthread+0x10/0x10
+	[    7.607144]  ret_from_fork_asm+0x1a/0x30
+	[    7.607147]  </TASK>
+	[    7.607147] kstackwatch: =================== KStackWatch End ===================
+	[    7.807082] kstackwatch_test: victim[0][11]: unhappy buf[8]=0xabcdabcd
+
+The line ``RIP: 0010:test_mthread_corrupting+0x48/0xd0`` shows the exact
+location where the corruption occurred. Now that the ``corrupting()`` function has
+been identified, it is straightforward to trace back to ``buggy()`` and fix the bug.
+
+
+More usage examples and corruption scenarios are provided in
+``kstackwatch_test.sh`` and ``mm/kstackwatch/test.c``.
+
+Limitations
+===========
+
+* Limited by available hardware breakpoints
+* Only one function can be watched at a time
+* Canary search limited to 128 * sizeof(ulong) from the current stack
+  pointer. This is sufficient for most cases, but has three limitations:
+
+  - If the stack frame is larger, the search may fail.
+  - If the function does not have a canary, the search may fail.
+  - If stack memory occasionally contains the same value as the canary,
+    it may be incorrectly matched.
+
+  In these cases, the user can provide the canary location using
+  ``sp_offset``, or treat any memory in the function prologue
+  as the canary.
-- 
2.43.0

