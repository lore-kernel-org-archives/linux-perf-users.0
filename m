Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32A12C489
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430698; cv=none; b=Iz2akzGKnv68Aw9G4EhEukfkc/ZUvEsO2CHOGYoJ+mAo0NgxF5S35If9+ydEFirs8dYnMpJ7IFiIqS8KQKm9PO80xS7PPm1r3jIn0B+8zwJoauxMJJ45CnzAGB1gV1OrSnOQoNPzXqLQ1WNP1skEz+gfzc8fAmsS0iDoeW32zxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430698; c=relaxed/simple;
	bh=YYRYh0L7L2u0ykGvVkbOc477dRhohUwy8OxZ5sv2NTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rHU8st/W4zeGExGKAnX4MUyJKttmcaG7vvGXnvGAY90HDizY6SQY5KMYGk4aUXbsEJCqexJ/ZJPw0ZpuXkh3JZciOwcsGY1+bjRGy4yGELWmsvMabbJytBXwd6SRkTr/OkNUeHSsrYhZTPrNCkblayhPdcw96tm0Jg2GNxFKKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O6qxh1HT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O6qxh1HT"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7177a85d092so295580b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 23:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725430696; x=1726035496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu647T7nNMWRP/YHN3BoLN2SM/MBw6d4xuLVFykFWxM=;
        b=O6qxh1HTvX1cFa68o1d06SF3aHyS6SdA3zRioHGcGQsN0wpRIPXGna8ndB0YkrguEM
         R8kUIKCcjlwftEdPh/GosBPgwXMshjwNcm/7IexRpkD7unv+Q0T+lONaeV2DYgFKLaQD
         +AAPpIvsBB11AfLwgAVR6toFp3DAAtM+IwCeYNSksODrioZsKF9oodhSauJtRh40W/Pb
         TYYY2c9U0/+ZFPmrX7xwOsRgKVj9odaR112FGOaXgI75Ru2fqcZ6+qc0W+5EHmSUS9HZ
         9rrN+5TnjlxQtHzRHbx6r/v2vq4disSduV4PaxaOiADgdLIU+rQm+dN7wOmKoUE+QV4/
         pxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430696; x=1726035496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eu647T7nNMWRP/YHN3BoLN2SM/MBw6d4xuLVFykFWxM=;
        b=mHxE2C/aDXbKhs/TjRu/owj/gYpu3CSo5WlSOsQd1Gk3F3j9JfE1BkUu5FRGy62CVD
         F+y5taQmd69ZHme0S4Jz1KgAh3bpuX9gNkZBPYkiY/2gnw26G+c/AT8rv/6qLIbNV5hP
         p1pR7T4jtTXoi0SN3iCKxfMF7POJCZiPTz+xGZ91y5LPHABtc/adtkLaIxaa/Lj2nlhD
         4etijrPEGaRad5OZYWi1nRt3Ai1Y7K/dFle31UB3ScKT4J/D5NnPChcFSzvSmccB2n24
         COwfiD3KKvbx2T5ALfS9R/Ent1OPVJDnYlk53WnAtiI2URS08aKT3519FV++oLp5QHbF
         +DzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU69mElImcjNY3k0/yHnrEXBd4ZBGcHwJT5Nym7aHIiNSph8sR3nAzI1Tkq2W804vwurLgfC1D8ci5sKGxghL3z@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxQy+Iaobi6WKTHc4kOIMQVS4xjinImqtJdi7iiTmKLc6f841
	8THOx9JSe5+Sy+4YQDcnneKp1EYQ2+Odso3/8O1rg/gszViEmuSrR/39e20/l4E=
X-Google-Smtp-Source: AGHT+IEUmQuEekOshj2U2ghDUo5ouB6mubhPNYM+/lWg1dvcZFBG+usrvWqHmoYnac2bue2ObG55+w==
X-Received: by 2002:a05:6a00:2283:b0:714:2922:7c6c with SMTP id d2e1a72fcca58-715dfccb426mr23504536b3a.19.1725430695900;
        Tue, 03 Sep 2024 23:18:15 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778532e32sm878585b3a.78.2024.09.03.23.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:18:15 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2] tools lib subcmd: Use array data to save built usage string
Date: Wed,  4 Sep 2024 14:17:55 +0800
Message-Id: <20240904061755.1467832-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
free built usage string to solve the memory leak problem,
which causes perf tool to not print subcommands when outputting usage help,
reducing the friendliness of the information.

If use original method of dynamically allocating memory, caller needs to
free the memory in appropriate place. In order to avoid it, use an array
to save built usage string.
Currently, only perf tool uses this function, 128 bytes are enough.

libsubcmd calls scnprintf(), move the build dependency of vsprintf.o from
perf to libsubcmd. Otherwise objtool build will fail (because it indirectly
calls parse_options_subcommand()), see [1]

Before:
  # perf sched

   Usage: (null)

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -i, --input <file>    input file name
      -v, --verbose         be more verbose (show symbol address, etc)

After:
  # perf sched

   Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -i, --input <file>    input file name
      -v, --verbose         be more verbose (show symbol address, etc)

Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
Link: https://lore.kernel.org/oe-kbuild-all/202409040112.BKj8VlQT-lkp@intel.com/ # [1]
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---

Changes since v1:
 - Move the build dependency of vsprintf.o from perf to libsubcmd.

 tools/lib/subcmd/Build           |  5 +++++
 tools/lib/subcmd/parse-options.c | 27 +++++++++++++++------------
 tools/lib/subcmd/parse-options.h | 10 ++++++++++
 tools/perf/util/Build            |  5 -----
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/lib/subcmd/Build b/tools/lib/subcmd/Build
index ee31288788c1..af832dab00df 100644
--- a/tools/lib/subcmd/Build
+++ b/tools/lib/subcmd/Build
@@ -5,3 +5,8 @@ libsubcmd-y += parse-options.o
 libsubcmd-y += run-command.o
 libsubcmd-y += sigchain.o
 libsubcmd-y += subcmd-config.o
+libsubcmd-y += vsprintf.o
+
+$(OUTPUT)vsprintf.o: ../vsprintf.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 4b60ec03b0bb..1e41a204864a 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -633,20 +633,26 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			const char *const subcommands[], const char *usagestr[], int flags)
 {
 	struct parse_opt_ctx_t ctx;
-	char *buf = NULL;
 
 	/* build usage string if it's not provided */
 	if (subcommands && !usagestr[0]) {
-		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
+		int n;
+		static char buf[USAGESTR_BUF_SIZE];
+		int buf_size = sizeof(buf);
 
-		for (int i = 0; subcommands[i]; i++) {
-			if (i)
-				astrcat(&buf, "|");
-			astrcat(&buf, subcommands[i]);
+		n = scnprintf(buf, buf_size, "%s %s [<options>] {",
+			      subcmd_config.exec_name, argv[0]);
+
+		for (int i = 0; subcommands[i] && n < buf_size - 1; i++) {
+			n += scnprintf(buf + n, buf_size - n, "%s%s",
+				       i ? "|" : "", subcommands[i]);
 		}
-		astrcat(&buf, "}");
+		if (n < buf_size - 1)
+			n += scnprintf(buf + n, buf_size - n, "}");
 
-		usagestr[0] = buf;
+		/* only provided if a complete string is built */
+		if (n < buf_size - 1)
+			usagestr[0] = buf;
 	}
 
 	parse_options_start(&ctx, argc, argv, flags);
@@ -678,10 +684,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
 		usage_with_options(usagestr, options);
 	}
-	if (buf) {
-		usagestr[0] = NULL;
-		free(buf);
-	}
+
 	return parse_options_end(&ctx);
 }
 
diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 8e9147358a28..654ba0a2201c 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -174,6 +174,16 @@ extern int parse_options(int argc, const char **argv,
                          const struct option *options,
                          const char * const usagestr[], int flags);
 
+/* parse_options_subcommand() will filter out the processed options
+ * and subcommands, leave the non-option argments in argv[].
+ * If usagestr is empty, it will build usage string based on subcommands
+ * in format of "exec_name argv[0] [<options>] {subcommand1|subcomman2|...}".
+ *
+ * NOTE: In order to avoid the caller needing to free memory,
+ * use an 128-bytes array to store the built usage string.
+ * If need to expand the array size, please modify USAGESTR_BUF_SIZE macro.
+ */
+#define USAGESTR_BUF_SIZE 128
 extern int parse_options_subcommand(int argc, const char **argv,
 				const struct option *options,
 				const char *const subcommands[],
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 260cec2f6c0b..14b00a563ab7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -144,7 +144,6 @@ perf-util-y += help-unknown-cmd.o
 perf-util-y += dlfilter.o
 perf-util-y += mem-events.o
 perf-util-y += mem-info.o
-perf-util-y += vsprintf.o
 perf-util-y += units.o
 perf-util-y += time-utils.o
 perf-util-y += expr-flex.o
@@ -386,10 +385,6 @@ $(OUTPUT)util/hweight.o: ../lib/hweight.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-$(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
-
 $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-- 
2.25.1

