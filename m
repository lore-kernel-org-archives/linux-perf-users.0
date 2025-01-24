Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B141D63D4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693541; cv=none; b=IGWXf2BUDNHO2En9cV5PmTPoaYsC0wSDx4FkLv4yOQkmEDL+fqfa3b6DgPRcavOrDHn+iT4dxgKdgTGGGaTokhNwC4POey30Q5o2+k62yclb2Pyp3bRPS91nBJ7XzaIXg0f1kiHaft64VpisjVu5iPzSYNUr3gl1FHxfJBfRmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693541; c=relaxed/simple;
	bh=Zb72lMbe4S6+kbLYAOQOr+7lj+nvekAbAHvrLoX90r4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fdSJQq/DGl96a3Hu71SBTkC9uaikVgDuBWd/EWomkkQEhXIe3DaVPNHny4nEKQFLESM0ZH0ZER5c4VgAR67QEJD/DC1TXM2KbIpcs8GbuVrbFa4AkA6L5e/MNlJzbVrO7F4pu8PG52yLeKrXNBThhWoqP4LQq7XO8obNOq3unVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQQyFq95; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQQyFq95"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5742f52896so4706701276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 20:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737693539; x=1738298339; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SpFCpBS37zKIhBhows1YsqYDYshq9kCjp6PCFAEHwqU=;
        b=uQQyFq95OfP63bRzG9I+iSpqTjJfMrCCm/pZf89JiHnI0TD57CElDCAthl3XhF08/P
         yykUrFRpp4hjYvf4ZuiZwD1nFGKBe/HtNmRKCMLOCAsE9sAOdyLyf7Rd8ezDGkAs8Ytj
         LLCFX5db9P86J+F7Cv9Snw5kmaTqAP4RgiM6WyRWj6tdFZkRAuYgEzJUoUJyiPep3Wyr
         Awye0iwc0138ZRYuRY0W91XOcvfELONyNF5ONSzS+U/jjfAscINHavmW5xiMMoDyPhtd
         m4JUN6jRsq26AxGtnRBdUEV1+6gbb6VodEPXqflg+Gp/6qsiA0n3CRU5rWtZlDX4fzE7
         gItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737693539; x=1738298339;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpFCpBS37zKIhBhows1YsqYDYshq9kCjp6PCFAEHwqU=;
        b=CqAnjcOfkazYnmTt+tVKoIPO59rRXGyR7FeeIgMAlditJ8iJmGU0FNHFJCfLyiI6U9
         PNpG/5SEKPWVmkzwRIIX08dIF2H2xuhXkib4ql05Yp2xNzgGXOyUAXGxHOXiOUXd2YSH
         3VyB3P1Mtng9K2JhkfA9j7ig55mDumk3CyBcYyXue6PUHAzYxXAdsCiKqqPbu16vt3Ug
         LhqLEI9xZiqaL4V94yiy2F5B2NNGhwbkgBS+SjY1Ch+tCde2snUWkDJOLsSq/pXhsaS5
         titfEbolNzLDRWuBPCK8KnSt+sMJD0hAgt7qUhpVpjNcx3iCmtF3HfSRlee+gJwHscNx
         VYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfagdTQxHRRi80eqmUKUMoodNyBsByMfMA3kWaLPqQJcSIcIZ8KbikajdSLMOnAH8HbnkMOWdhzSBIUlgZ/WPh@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrItzqx1Bl+KIzLV0ZQJTsawdow+Vx4pklTChCgcAS3fqklBh
	LTyxqQiBwt3EhyVKAu5eK1iVeq+xlDyGac7GmvjQpYXNmKCvr+qFBxx2EheKfdOxI6E0TGXyIeT
	A0fNBpg==
X-Google-Smtp-Source: AGHT+IESlAI6Opdgt2eFLdCRFJomXxVJurFs7wXWxxjzjhwdE4iILODFYebcSWp7IUMIqpIFtETex4CUWDpV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:37b6:cf70:1dbf:669c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f91:b0:6ee:4d97:9091 with SMTP
 id 00721157ae682-6f6eb94303emr827597b3.7.1737693539149; Thu, 23 Jan 2025
 20:38:59 -0800 (PST)
Date: Thu, 23 Jan 2025 20:38:56 -0800
Message-Id: <20250124043856.1177264-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v2] perf annotate: Use an array for the disassembler preference
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prior to this change a string was used which could cause issues with
an unrecognized disassembler in symbol__disassembler. Change to
initializing an array of perf_disassembler enum values. If a value
already exists then adding it a second time is ignored to avoid array
out of bounds problems present in the previous code, it also allows a
statically sized array and removes memory allocation needs. Errors in
the disassembler string are reported when the config is parsed during
perf annotate or perf top start up. If the array is uninitialized
after processing the config file the default llvm, capstone then
objdump values are added but without a need to parse a string.

Fixes: a6e8a58de629 ("perf disasm: Allow configuring what disassemblers to use")
Closes: https://lore.kernel.org/lkml/CAP-5=fUdfCyxmEiTpzS2uumUp3-SyQOseX2xZo81-dQtWXj6vA@mail.gmail.com/
---
v2: Remove unused annotation_options nr_disassemblers variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 76 +++++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h | 15 ++++---
 tools/perf/util/disasm.c   | 83 +++++++-------------------------------
 3 files changed, 96 insertions(+), 78 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0d2ea22bd9e4..31bb326b07a6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2100,6 +2100,57 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	return 0;
 }
 
+const char * const perf_disassembler__strs[] = {
+	[PERF_DISASM_UNKNOWN]  = "unknown",
+	[PERF_DISASM_LLVM]     = "llvm",
+	[PERF_DISASM_CAPSTONE] = "capstone",
+	[PERF_DISASM_OBJDUMP]  = "objdump",
+};
+
+
+static void annotation_options__add_disassembler(struct annotation_options *options,
+						 enum perf_disassembler dis)
+{
+	for (u8 i = 0; i < ARRAY_SIZE(options->disassemblers); i++) {
+		if (options->disassemblers[i] == dis) {
+			/* Disassembler is already present then don't add again. */
+			return;
+		}
+		if (options->disassemblers[i] == PERF_DISASM_UNKNOWN) {
+			/* Found a free slot. */
+			options->disassemblers[i] = dis;
+			return;
+		}
+	}
+	pr_err("Failed to add disassembler %d\n", dis);
+}
+
+static int annotation_options__add_disassemblers_str(struct annotation_options *options,
+						const char *str)
+{
+	while (str && *str != '\0') {
+		const char *comma = strchr(str, ',');
+		int len = comma ? comma - str : (int)strlen(str);
+		bool match = false;
+
+		for (u8 i = 0; i < ARRAY_SIZE(perf_disassembler__strs); i++) {
+			const char *dis_str = perf_disassembler__strs[i];
+
+			if (len == (int)strlen(dis_str) && !strncmp(str, dis_str, len)) {
+				annotation_options__add_disassembler(options, i);
+				match = true;
+				break;
+			}
+		}
+		if (!match) {
+			pr_err("Invalid disassembler '%.*s'\n", len, str);
+			return -1;
+		}
+		str = comma ? comma + 1 : NULL;
+	}
+	return 0;
+}
+
 static int annotation__config(const char *var, const char *value, void *data)
 {
 	struct annotation_options *opt = data;
@@ -2115,11 +2166,10 @@ static int annotation__config(const char *var, const char *value, void *data)
 		else if (opt->offset_level < ANNOTATION__MIN_OFFSET_LEVEL)
 			opt->offset_level = ANNOTATION__MIN_OFFSET_LEVEL;
 	} else if (!strcmp(var, "annotate.disassemblers")) {
-		opt->disassemblers_str = strdup(value);
-		if (!opt->disassemblers_str) {
-			pr_err("Not enough memory for annotate.disassemblers\n");
-			return -1;
-		}
+		int err = annotation_options__add_disassemblers_str(opt, value);
+
+		if (err)
+			return err;
 	} else if (!strcmp(var, "annotate.hide_src_code")) {
 		opt->hide_src_code = perf_config_bool("hide_src_code", value);
 	} else if (!strcmp(var, "annotate.jump_arrows")) {
@@ -2185,9 +2235,25 @@ void annotation_options__exit(void)
 	zfree(&annotate_opts.objdump_path);
 }
 
+static void annotation_options__default_init_disassemblers(struct annotation_options *options)
+{
+	if (options->disassemblers[0] != PERF_DISASM_UNKNOWN) {
+		/* Already initialized. */
+		return;
+	}
+#ifdef HAVE_LIBLLVM_SUPPORT
+	annotation_options__add_disassembler(options, PERF_DISASM_LLVM);
+#endif
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	annotation_options__add_disassembler(options, PERF_DISASM_CAPSTONE);
+#endif
+	annotation_options__add_disassembler(options, PERF_DISASM_OBJDUMP);
+}
+
 void annotation_config__init(void)
 {
 	perf_config(annotation__config, &annotate_opts);
+	annotation_options__default_init_disassemblers(&annotate_opts);
 }
 
 static unsigned int parse_percent_type(char *str1, char *str2)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0ba5846dad4d..98db1b88daf4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -34,8 +34,13 @@ struct annotated_data_type;
 #define ANNOTATION__BR_CNTR_WIDTH 30
 #define ANNOTATION_DUMMY_LEN	256
 
-// llvm, capstone, objdump
-#define MAX_DISASSEMBLERS 3
+enum perf_disassembler {
+	PERF_DISASM_UNKNOWN = 0,
+	PERF_DISASM_LLVM,
+	PERF_DISASM_CAPSTONE,
+	PERF_DISASM_OBJDUMP,
+};
+#define MAX_DISASSEMBLERS (PERF_DISASM_OBJDUMP + 1)
 
 struct annotation_options {
 	bool hide_src_code,
@@ -52,14 +57,12 @@ struct annotation_options {
 	     annotate_src,
 	     full_addr;
 	u8   offset_level;
-	u8   nr_disassemblers;
+	u8   disassemblers[MAX_DISASSEMBLERS];
 	int  min_pcnt;
 	int  max_lines;
 	int  context;
 	char *objdump_path;
 	char *disassembler_style;
-	const char *disassemblers_str;
-	const char *disassemblers[MAX_DISASSEMBLERS];
 	const char *prefix;
 	const char *prefix_strip;
 	unsigned int percent_type;
@@ -134,6 +137,8 @@ struct disasm_line {
 	struct annotation_line	 al;
 };
 
+extern const char * const perf_disassembler__strs[];
+
 void annotation_line__add(struct annotation_line *al, struct list_head *head);
 
 static inline double annotation_data__percent(struct annotation_data *data,
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index b7de4d9fd004..50c5c206b70e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -2216,56 +2216,6 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	return err;
 }
 
-static int annotation_options__init_disassemblers(struct annotation_options *options)
-{
-	char *disassembler;
-
-	if (options->disassemblers_str == NULL) {
-		const char *default_disassemblers_str =
-#ifdef HAVE_LIBLLVM_SUPPORT
-				"llvm,"
-#endif
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-				"capstone,"
-#endif
-				"objdump";
-
-		options->disassemblers_str = strdup(default_disassemblers_str);
-		if (!options->disassemblers_str)
-			goto out_enomem;
-	}
-
-	disassembler = strdup(options->disassemblers_str);
-	if (disassembler == NULL)
-		goto out_enomem;
-
-	while (1) {
-		char *comma = strchr(disassembler, ',');
-
-		if (comma != NULL)
-			*comma = '\0';
-
-		options->disassemblers[options->nr_disassemblers++] = strim(disassembler);
-
-		if (comma == NULL)
-			break;
-
-		disassembler = comma + 1;
-
-		if (options->nr_disassemblers >= MAX_DISASSEMBLERS) {
-			pr_debug("annotate.disassemblers can have at most %d entries, ignoring \"%s\"\n",
-				 MAX_DISASSEMBLERS, disassembler);
-			break;
-		}
-	}
-
-	return 0;
-
-out_enomem:
-	pr_err("Not enough memory for annotate.disassemblers\n");
-	return -1;
-}
-
 int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *options = args->options;
@@ -2274,7 +2224,6 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	char symfs_filename[PATH_MAX];
 	bool delete_extract = false;
 	struct kcore_extract kce;
-	const char *disassembler;
 	bool decomp = false;
 	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
 
@@ -2334,28 +2283,26 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		}
 	}
 
-	err = annotation_options__init_disassemblers(options);
-	if (err)
-		goto out_remove_tmp;
-
 	err = -1;
+	for (u8 i = 0; i < ARRAY_SIZE(options->disassemblers) && err != 0; i++) {
+		enum perf_disassembler dis = options->disassemblers[i];
 
-	for (int i = 0; i < options->nr_disassemblers && err != 0; ++i) {
-		disassembler = options->disassemblers[i];
-
-		if (!strcmp(disassembler, "llvm"))
+		switch (dis) {
+		case PERF_DISASM_LLVM:
 			err = symbol__disassemble_llvm(symfs_filename, sym, args);
-		else if (!strcmp(disassembler, "capstone"))
+			break;
+		case PERF_DISASM_CAPSTONE:
 			err = symbol__disassemble_capstone(symfs_filename, sym, args);
-		else if (!strcmp(disassembler, "objdump"))
+			break;
+		case PERF_DISASM_OBJDUMP:
 			err = symbol__disassemble_objdump(symfs_filename, sym, args);
-		else
-			pr_debug("Unknown disassembler %s, skipping...\n", disassembler);
-	}
-
-	if (err == 0) {
-		pr_debug("Disassembled with %s\nannotate.disassemblers=%s\n",
-			 disassembler, options->disassemblers_str);
+			break;
+		case PERF_DISASM_UNKNOWN: /* End of disassemblers. */
+		default:
+			goto out_remove_tmp;
+		}
+		if (err == 0)
+			pr_debug("Disassembled with %s\n", perf_disassembler__strs[dis]);
 	}
 out_remove_tmp:
 	if (decomp)
-- 
2.48.1.262.g85cc9f2d1e-goog

