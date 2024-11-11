Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036F1494BB;
	Mon, 11 Nov 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338290; cv=none; b=sPrmSyJ0a+YIq47R6YbClQ7zRjFmWFxGi+SVCiJ8+Pgu/AbVADCQ1dM0MCMJa4dUYSff5SukOYVK+Z7pftfNaYwTUBZuqFxRKdnzfrEUta4JgshSqLIujWP//UfUL7nlDHo6icqi6uBpaErgn3L3bPquGU+4yrL/WoOxrXJMI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338290; c=relaxed/simple;
	bh=MHF5Vv8F3/QBbWu7HpNpjeJfgl9O8zj//WncFSQ9bhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG/gu8GGh3Z3Psgn23Utp/DI1kona9lCugxsJVIsfZN3hmNXzMoOX/ruEgfgOvcMmyEkLLLDhU5PA1q2cH4vXa2fIF1xZ+QH52aURySPeAAFoVHj52aUfSkBQ0luZ0IlwW3kNvALykLNr/wd1W1pK5fJWmAJPRM+efJ98GEc6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0+JvYQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0+JvYQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFA3C4CECF;
	Mon, 11 Nov 2024 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338289;
	bh=MHF5Vv8F3/QBbWu7HpNpjeJfgl9O8zj//WncFSQ9bhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0+JvYQQTUQC1hz4Asnaid3GC0gr8Ve9Dgqt/t9BBAT4l9uGyDtoSkp9ZfTUwAh8L
	 i3rIHVXXwrpw3HbEq5eTlnYJm1vRsKPn55OXXcpnbbTJNA4bAZnN6K0qAfwbFm83f2
	 8n5gNgITM1yMMwhRS3SWDXMgaUaBagI5t5vq+7NbDG+BGKTzXOvmB8wj8s/KRw2kEk
	 IdoT0a0GSYPSRL79zOuSzKolCUeUlqNh94wWwRfvMZzKilKduNRUb/ZJT0sNLZTBgZ
	 jHB1B3NEIJVdIyntfp0VGU/K69RMBEG7gz7FvA7qYx3i92dILaFbkyPnAvymNP2CSo
	 Aa/ALSfvIEMRg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>
Subject: [PATCH 3/3] perf disasm: Allow configuring what disassemblers to use
Date: Mon, 11 Nov 2024 12:17:34 -0300
Message-ID: <20241111151734.1018476-4-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111151734.1018476-1-acme@kernel.org>
References: <20241111151734.1018476-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The perf tools annotation code used for a long time parsing the output
of binutils's objdump (or its reimplementations, like llvm's) to then
parse and augment it with samples, allow navigation, etc.

More recently disassemblers from the capstone and llvm (libraries, not
parsing the output of tools using those libraries to mimic binutils's
objdump output) were introduced.

So when all those methods are available, there is a static preference
for a series of attempts of disassembling a binary, with the 'llvm,
capstone, objdump' sequence being hard coded.

This patch allows users to change that sequence, specifying via a 'perf
config' 'annotate.disassemblers' entry which and in what order
disassemblers should be attempted.

As alluded to in the comments in the source code of this series, this
flexibility is useful for users and developers alike, elliminating the
requirement to rebuild the tool with some specific set of libraries to
see how the output of disassembling would be for one of these methods.

  root@x1:~# rm -f ~/.perfconfig
  root@x1:~# perf annotate -v --stdio2 update_load_avg
  <SNIP>
  symbol__disassemble:
    filename=/usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux,
    sym=update_load_avg, start=0xffffffffb6148fe0, en>
  annotating [0x6ff7170]
    /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux :
    [0x7407ca0] update_load_avg
  Disassembled with llvm
  annotate.disassemblers=llvm,capstone,objdump
  Samples: 66  of event 'cpu_atom/cycles/P', 10000 Hz,
	Event count (approx.): 5185444, [percent: local period]
  update_load_avg()
    /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux
  Percent       0xffffffff81148fe0 <update_load_avg>:
     1.61         pushq   %r15
                  pushq   %r14
     1.00         pushq   %r13
                  movl    %edx,%r13d
     1.90         pushq   %r12
                  pushq   %rbp
                  movq    %rsi,%rbp
                  pushq   %rbx
                  movq    %rdi,%rbx
                  subq    $0x18,%rsp
    15.14         movl    0x1a4(%rdi),%eax

  root@x1:~# perf config annotate.disassemblers=capstone
  root@x1:~# cat ~/.perfconfig
  # this file is auto-generated.
  [annotate]
	  disassemblers = capstone
  root@x1:~#
  root@x1:~# perf annotate -v --stdio2 update_load_avg
  <SNIP>
  Disassembled with capstone
  annotate.disassemblers=capstone
  Samples: 66  of event 'cpu_atom/cycles/P', 10000 Hz,
  Event count (approx.): 5185444, [percent: local period]
  update_load_avg()
  /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux
  Percent       0xffffffff81148fe0 <update_load_avg>:
     1.61         pushq   %r15
                  pushq   %r14
     1.00         pushq   %r13
                  movl    %edx,%r13d
     1.90         pushq   %r12
                  pushq   %rbp
                  movq    %rsi,%rbp
                  pushq   %rbx
                  movq    %rdi,%rbx
                  subq    $0x18,%rsp
    15.14         movl    0x1a4(%rdi),%eax
  root@x1:~# perf config annotate.disassemblers=objdump,capstone
  root@x1:~# perf config annotate.disassemblers
  annotate.disassemblers=objdump,capstone
  root@x1:~# cat ~/.perfconfig
  # this file is auto-generated.
  [annotate]
	  disassemblers = objdump,capstone
  root@x1:~# perf annotate -v --stdio2 update_load_avg
  Executing: objdump  --start-address=0xffffffff81148fe0 \
		      --stop-address=0xffffffff811497aa  \
		      -d --no-show-raw-insn -S -C "$1"
  Disassembled with objdump
  annotate.disassemblers=objdump,capstone
  Samples: 66  of event 'cpu_atom/cycles/P', 10000 Hz,
  Event count (approx.): 5185444, [percent: local period]
  update_load_avg()
  /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux
  Percent

                Disassembly of section .text:

                ffffffff81148fe0 <update_load_avg>:
                #define DO_ATTACH       0x4

                ffffffff81148fe0 <update_load_avg>:
                #define DO_ATTACH       0x4
                #define DO_DETACH       0x8

                /* Update task and its cfs_rq load average */
                static inline void update_load_avg(struct cfs_rq *cfs_rq,
						   struct sched_entity *se,
						   int flags)
                {
     1.61         push   %r15
                  push   %r14
     1.00         push   %r13
                  mov    %edx,%r13d
     1.90         push   %r12
                  push   %rbp
                  mov    %rsi,%rbp
                  push   %rbx
                  mov    %rdi,%rbx
                  sub    $0x18,%rsp
                }

                /* rq->task_clock normalized against any time
		   this cfs_rq has spent throttled */
                static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
                {
                if (unlikely(cfs_rq->throttle_count))
    15.14         mov    0x1a4(%rdi),%eax
  root@x1:~#

After adding a way to select the disassembler from the command line a
'perf test' comparing the output of the various diassemblers should be
introduced, to test these codebases.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steinar H. Gunderson <sesse@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 13 ++++
 tools/perf/util/annotate.c               |  6 ++
 tools/perf/util/annotate.h               |  6 ++
 tools/perf/util/disasm.c                 | 77 ++++++++++++++++++++++--
 4 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 379f9d7a8ab11a02..1f668d4724e3749a 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -247,6 +247,19 @@ annotate.*::
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
 
+	annotate.disassemblers::
+		Choose the disassembler to use: "objdump", "llvm",  "capstone",
+		if not specified it will first try, if available, the "llvm" one,
+		then, if it fails, "capstone", and finally the original "objdump"
+		based one.
+
+		Choosing a different one is useful when handling some feature that
+		is known to be best support at some point by one of the options,
+		to compare the output when in doubt about some bug, etc.
+
+		This can be a list, in order of preference, the first one that works
+		finishes the process.
+
 	annotate.addr2line::
 		addr2line binary to use for file names and line numbers.
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b1d98da79be8b2b0..32e15c9f53f3c0a3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2116,6 +2116,12 @@ static int annotation__config(const char *var, const char *value, void *data)
 			opt->offset_level = ANNOTATION__MAX_OFFSET_LEVEL;
 		else if (opt->offset_level < ANNOTATION__MIN_OFFSET_LEVEL)
 			opt->offset_level = ANNOTATION__MIN_OFFSET_LEVEL;
+	} else if (!strcmp(var, "annotate.disassemblers")) {
+		opt->disassemblers_str = strdup(value);
+		if (!opt->disassemblers_str) {
+			pr_err("Not enough memory for annotate.disassemblers\n");
+			return -1;
+		}
 	} else if (!strcmp(var, "annotate.hide_src_code")) {
 		opt->hide_src_code = perf_config_bool("hide_src_code", value);
 	} else if (!strcmp(var, "annotate.jump_arrows")) {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 8b9e05a1932f2f9e..194a05cbc506e4da 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -34,6 +34,9 @@ struct annotated_data_type;
 #define ANNOTATION__BR_CNTR_WIDTH 30
 #define ANNOTATION_DUMMY_LEN	256
 
+// llvm, capstone, objdump
+#define MAX_DISASSEMBLERS 3
+
 struct annotation_options {
 	bool hide_src_code,
 	     use_offset,
@@ -49,11 +52,14 @@ struct annotation_options {
 	     annotate_src,
 	     full_addr;
 	u8   offset_level;
+	u8   nr_disassemblers;
 	int  min_pcnt;
 	int  max_lines;
 	int  context;
 	char *objdump_path;
 	char *disassembler_style;
+	const char *disassemblers_str;
+	const char *disassemblers[MAX_DISASSEMBLERS];
 	const char *prefix;
 	const char *prefix_strip;
 	unsigned int percent_type;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 83df1da20a7b16cd..df6c172c9c7f86d9 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -2210,13 +2210,65 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	return err;
 }
 
+static int annotation_options__init_disassemblers(struct annotation_options *options)
+{
+	char *disassembler;
+
+	if (options->disassemblers_str == NULL) {
+		const char *default_disassemblers_str =
+#ifdef HAVE_LIBLLVM_SUPPORT
+				"llvm,"
+#endif
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+				"capstone,"
+#endif
+				"objdump";
+
+		options->disassemblers_str = strdup(default_disassemblers_str);
+		if (!options->disassemblers_str)
+			goto out_enomem;
+	}
+
+	disassembler = strdup(options->disassemblers_str);
+	if (disassembler == NULL)
+		goto out_enomem;
+
+	while (1) {
+		char *comma = strchr(disassembler, ',');
+
+		if (comma != NULL)
+			*comma = '\0';
+
+		options->disassemblers[options->nr_disassemblers++] = strim(disassembler);
+
+		if (comma == NULL)
+			break;
+
+		disassembler = comma + 1;
+
+		if (options->nr_disassemblers >= MAX_DISASSEMBLERS) {
+			pr_debug("annotate.disassemblers can have at most %d entries, ignoring \"%s\"\n",
+				 MAX_DISASSEMBLERS, disassembler);
+			break;
+		}
+	}
+
+	return 0;
+
+out_enomem:
+	pr_err("Not enough memory for annotate.disassemblers\n");
+	return -1;
+}
+
 int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
+	struct annotation_options *options = args->options;
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
 	char symfs_filename[PATH_MAX];
 	bool delete_extract = false;
 	struct kcore_extract kce;
+	const char *disassembler;
 	bool decomp = false;
 	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
 
@@ -2276,16 +2328,29 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		}
 	}
 
-	err = symbol__disassemble_llvm(symfs_filename, sym, args);
-	if (err == 0)
+	err = annotation_options__init_disassemblers(options);
+	if (err)
 		goto out_remove_tmp;
 
-	err = symbol__disassemble_capstone(symfs_filename, sym, args);
-	if (err == 0)
-		goto out_remove_tmp;
+	err = -1;
 
-	err = symbol__disassemble_objdump(symfs_filename, sym, args);
+	for (int i = 0; i < options->nr_disassemblers && err != 0; ++i) {
+		disassembler = options->disassemblers[i];
 
+		if (!strcmp(disassembler, "llvm"))
+			err = symbol__disassemble_llvm(symfs_filename, sym, args);
+		else if (!strcmp(disassembler, "capstone"))
+			err = symbol__disassemble_capstone(symfs_filename, sym, args);
+		else if (!strcmp(disassembler, "objdump"))
+			err = symbol__disassemble_objdump(symfs_filename, sym, args);
+		else
+			pr_debug("Unknown disassembler %s, skipping...\n", disassembler);
+	}
+
+	if (err == 0) {
+		pr_debug("Disassembled with %s\nannotate.disassemblers=%s\n",
+			 disassembler, options->disassemblers_str);
+	}
 out_remove_tmp:
 	if (decomp)
 		unlink(symfs_filename);
-- 
2.47.0

