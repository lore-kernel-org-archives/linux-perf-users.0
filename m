Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535A3BBCF
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324001; cv=none; b=gZIyYDm+3b5TZGCJH2b4bv05P4jh4j3JAASDLGeDOfJQ512tLBiYW3GxRByBhEIyUYmtI60qMB0FyARotZ3tcYzxAT16F/tzTPsTWOT5tX4/nPGiFe4AyfVreKjB/d7AMfLPqoV/uCgymt0k9ZWZ9lNwvjPQtOO277H3/6ucr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324001; c=relaxed/simple;
	bh=YQYej9/wbHDh4U0pOqtD+f9bdmuRw3dDIO6iC4Atlvs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=L1EHYwEV2ubfPcAoUt/OHqTeMewhokqE7rJJTQTz+6SOVEhs3yH2DU1PbNcPTJKYYLEd9egGkt6lXQYUfZfvFFCEUKdyPxHffpDIA5HGKgeiAXLb5TWuE01sA7H9Ptbr0ND0WR2/V8uZapHgs9YYuZreVOeOsI+yQm+wffR98TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emI3hcdx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emI3hcdx"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607a628209eso44441957b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 12:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709323998; x=1709928798; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qw7Tnae9oeOOLeAJfa9C2dxnvmn7Vxe3GYTFlwpmYPw=;
        b=emI3hcdxfGFfFcTe+qzezSQNmmMt4UCOFw/SeO10Oj89o7bwAeO6AAsxHHyA5p265Q
         syGlZyzPDrlLe3Ig+JndNlPIkcOY2vEt0Uma5PT2oGeCVt1jaDXvlpISo/xy2CESmhT8
         3OPmTqTPDvyfJMJI1WcKnMIk/R5ztuqZUVaGsjscoxO5p/olSmSqjKnquwXxcClMj6f5
         3jqi9MtvSSe4qZXeMndAJKT2dOcOjFoPCqLf4s9aD93Cv69Hzgfnh+Ds5nt4jg4BPyud
         6P0LTvQ2R3ho2qOBe1ceWyxWH371CB9BvgDjPDxRmnUcq0MOfGj6FCv800HrgVqy2aM5
         uPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709323998; x=1709928798;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qw7Tnae9oeOOLeAJfa9C2dxnvmn7Vxe3GYTFlwpmYPw=;
        b=fiFMHHIPWOlvFRsy8F6L/tz/AEd6fJgLoXTAvZDOWR2jgoaE6uUswOm9iEvjY5/EXZ
         5k4TPddg92DSZUHnfxVqV4C9E/s8oLZnA9c74pES74u2RNTzXEcvoo0mnViqe3YchieP
         jtVjfWdKsHqjD8zZh6vUEO7Kp26+TPc1suF6tkwSxlRlG1lbmsCl7k+JgZG+iWx8BI80
         H1HQ4epCRhzNvGsehtmOMviM6HojmPuzFccEb4N4GG9cmO0IWNf5HkiQk08hWPJ40p71
         IRF/jgqZuqGoKH5uQxRf/O4edq9pZWW6xXnDTZBH9b8Yd6+AS210U1sb/YVoRtrqsKL7
         qcFw==
X-Forwarded-Encrypted: i=1; AJvYcCVlua9yfyyZo+q3Ot3fONfXdjcQ5UnX22/8V6wm88HH0SYwdtvPAdOV+cRHX0ee83zPqKTHEcFMAdBc/MKLTVlCAFKoqieywnjkojt6AUcXHg==
X-Gm-Message-State: AOJu0YwG8wh2PfFLYZMgZqL2YrRaX7vYVhnhD2ClVErikHVTF57/ig3p
	LLYiEy67gHbJYZe/xq6ilAeKYPkEX8mwj/UhcL1ySuLg7gNgMIvrqoyRVIoBDiS1rqSmID9tNwW
	mq3GjOA==
X-Google-Smtp-Source: AGHT+IFAiiEJgfyfP/4TMJqA2jCE9PJIMevhMitsXprHpgx5kwn+O0qflgwRJlJ3yRQ9wBQLNVZB1dwUz9MP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:d21:b0:608:1b39:246b with SMTP id
 cn33-20020a05690c0d2100b006081b39246bmr717835ywb.3.1709323998427; Fri, 01 Mar
 2024 12:13:18 -0800 (PST)
Date: Fri,  1 Mar 2024 12:13:05 -0800
Message-Id: <20240301201306.2680986-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The existing unknown command code looks for perf scripts like
perf-archive.sh and perf-iostat.sh, however, inbuilt commands aren't
suggested. Add the inbuilt commands so they may be suggested too.

Before:
```
$ perf reccord
perf: 'reccord' is not a perf-command. See 'perf --help'.
```

After:
```
$ perf reccord
perf: 'reccord' is not a perf-command. See 'perf --help'.

Did you mean this?
        record
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Drops a merged patch and rebases. No functional change. Arnaldo
    reported the patch not working for him, but I've not found a
    reproduction and it works for me:
    https://lore.kernel.org/lkml/ZZcdDyyADG8dP8LM@kernel.org/
---
 tools/perf/builtin.h               |  4 ++-
 tools/perf/perf.c                  | 21 +++++++++++---
 tools/perf/util/help-unknown-cmd.c | 45 ++++++++++++++----------------
 3 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index f2ab5bae2150..f4375deabfa3 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,8 +2,10 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
+struct cmdnames;
+
 void list_common_cmds_help(void);
-const char *help_unknown_cmd(const char *cmd);
+const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds);
 
 int cmd_annotate(int argc, const char **argv);
 int cmd_bench(int argc, const char **argv);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 921bee0a6437..c719e6ccd9e2 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -18,6 +18,7 @@
 #include <subcmd/run-command.h>
 #include "util/parse-events.h"
 #include <subcmd/parse-options.h>
+#include <subcmd/help.h>
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/util.h" // usage()
@@ -557,7 +558,7 @@ int main(int argc, const char **argv)
 	pthread__block_sigwinch();
 
 	while (1) {
-		static int done_help;
+		int done_help;
 
 		run_argv(&argc, &argv);
 
@@ -565,14 +566,26 @@ int main(int argc, const char **argv)
 			break;
 
 		if (!done_help) {
-			cmd = argv[0] = help_unknown_cmd(cmd);
+			struct cmdnames main_cmds;
+
+			for (unsigned int i = 0; i < ARRAY_SIZE(commands); i++) {
+				add_cmdname(&main_cmds,
+					    commands[i].cmd,
+					    strlen(commands[i].cmd));
+			}
+			cmd = argv[0] = help_unknown_cmd(cmd, &main_cmds);
+			clean_cmdnames(&main_cmds);
 			done_help = 1;
+			if (!cmd)
+				break;
 		} else
 			break;
 	}
 
-	fprintf(stderr, "Failed to run command '%s': %s\n",
-		cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
+	if (cmd) {
+		fprintf(stderr, "Failed to run command '%s': %s\n",
+			cmd, str_error_r(errno, sbuf, sizeof(sbuf)));
+	}
 out:
 	if (debug_fp)
 		fclose(debug_fp);
diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index eab99ea6ac01..2ba3369f1620 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -52,46 +52,44 @@ static int add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	return 0;
 }
 
-const char *help_unknown_cmd(const char *cmd)
+const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds)
 {
 	unsigned int i, n = 0, best_similarity = 0;
-	struct cmdnames main_cmds, other_cmds;
+	struct cmdnames other_cmds;
 
-	memset(&main_cmds, 0, sizeof(main_cmds));
-	memset(&other_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
 
 	perf_config(perf_unknown_cmd_config, NULL);
 
-	load_command_list("perf-", &main_cmds, &other_cmds);
+	load_command_list("perf-", main_cmds, &other_cmds);
 
-	if (add_cmd_list(&main_cmds, &other_cmds) < 0) {
+	if (add_cmd_list(main_cmds, &other_cmds) < 0) {
 		fprintf(stderr, "ERROR: Failed to allocate command list for unknown command.\n");
 		goto end;
 	}
-	qsort(main_cmds.names, main_cmds.cnt,
-	      sizeof(main_cmds.names), cmdname_compare);
-	uniq(&main_cmds);
+	qsort(main_cmds->names, main_cmds->cnt,
+	      sizeof(main_cmds->names), cmdname_compare);
+	uniq(main_cmds);
 
-	if (main_cmds.cnt) {
+	if (main_cmds->cnt) {
 		/* This reuses cmdname->len for similarity index */
-		for (i = 0; i < main_cmds.cnt; ++i)
-			main_cmds.names[i]->len =
-				levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
+		for (i = 0; i < main_cmds->cnt; ++i)
+			main_cmds->names[i]->len =
+				levenshtein(cmd, main_cmds->names[i]->name, 0, 2, 1, 4);
 
-		qsort(main_cmds.names, main_cmds.cnt,
-		      sizeof(*main_cmds.names), levenshtein_compare);
+		qsort(main_cmds->names, main_cmds->cnt,
+		      sizeof(*main_cmds->names), levenshtein_compare);
 
-		best_similarity = main_cmds.names[0]->len;
+		best_similarity = main_cmds->names[0]->len;
 		n = 1;
-		while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
+		while (n < main_cmds->cnt && best_similarity == main_cmds->names[n]->len)
 			++n;
 	}
 
 	if (autocorrect && n == 1) {
-		const char *assumed = main_cmds.names[0]->name;
+		const char *assumed = main_cmds->names[0]->name;
 
-		main_cmds.names[0] = NULL;
-		clean_cmdnames(&main_cmds);
+		main_cmds->names[0] = NULL;
 		clean_cmdnames(&other_cmds);
 		fprintf(stderr, "WARNING: You called a perf program named '%s', "
 			"which does not exist.\n"
@@ -107,15 +105,14 @@ const char *help_unknown_cmd(const char *cmd)
 
 	fprintf(stderr, "perf: '%s' is not a perf-command. See 'perf --help'.\n", cmd);
 
-	if (main_cmds.cnt && best_similarity < 6) {
+	if (main_cmds->cnt && best_similarity < 6) {
 		fprintf(stderr, "\nDid you mean %s?\n",
 			n < 2 ? "this": "one of these");
 
 		for (i = 0; i < n; i++)
-			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+			fprintf(stderr, "\t%s\n", main_cmds->names[i]->name);
 	}
 end:
-	clean_cmdnames(&main_cmds);
 	clean_cmdnames(&other_cmds);
-	exit(1);
+	return NULL;
 }
-- 
2.44.0.278.ge034bb2e1d-goog

