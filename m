Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AF1B3934
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625648; cv=none; b=W6nyOjskCGv3czLZ0kpsiFsBRraGUMZ6S/6M0H4KWD/JuPsGZsU/U+jmJbO1j19FPtDdkDC17FscLhSbpqKlVHVVTDy6ADmb1g9T/ky+ojlGHCrTKlKkW3pDTJyEjW1jyVx9RZCTXkT1HnVIqt+fXGrMaIhcfsRbrZ83rAnirLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625648; c=relaxed/simple;
	bh=LLEFK7NZuHwP503adj1d6CSpVzaLmth1dYdPOz7NtLs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HKpTUQKgC/I9GTAyrPnAZWvu4QzWsNtP8IjRFOSglwbKGRdf2x/0tTYFybmgi/AR6H+FnxhkgKoA1pk5gN8z5yiX9XlcoD7y1zMjGMVj8keAL/xhjNH+9lTsyNuEbmNR8PJMcguWNp1klC4XoQ9pwliGXPCO93Z4kCb8IlRwVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhT/UAQp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhT/UAQp"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so1424838276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 15:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731625646; x=1732230446; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoeFMjnBDbHZAr6lnCHUx3YoNMU6DqE2Glkf9cd6Lno=;
        b=GhT/UAQpuua3wX602UPd51/gnbyxTIJSm9bY8GX7p5dN+M8mgnBYkIVwARj3JafFxU
         v3OG34N2M0xJZwBzMwd8hVOqZqL8gLoEr5eR0lWTgBb242eX2HULBvGa4GVz1IYu+dYb
         sbABwZswo37xBn9grjMJSaINcxeR0ixR1CmJ25HXC76GFMn5Zf+JoEmyuJulLchY8Q0v
         G5DxnxFc+QLZuK+85uV/pzPRINkjVdYHQrtQVHwNyn5ejsNrM+ab/ENYZMBcwNYLftlf
         hOeqq0xK41T7zPS//n8FeIp434FoUkSmrij/VlpiuP09M5bZb+FFL92dXUQrTOykUH2J
         jqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625646; x=1732230446;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoeFMjnBDbHZAr6lnCHUx3YoNMU6DqE2Glkf9cd6Lno=;
        b=jxljcAV/fs+ctNcPn0moNr0bmr5VlzkOnxms9PYE84HXqyQjh27FD2iRZBu1wXPfJF
         mQE0N/UQaAGh0Xa+nOuM2JCSToJO34+VckFTZWoUSbHmZ1tT5pwKH+Wcbk7LakFWQ6F0
         R9i5wUglDVzlzO3fK1xfwwuT3eJbqB8P+x6/CPKZ7COOQLkoTxL8gabXnkGDrQEgczIp
         PseeMpMIFqJd8NjBGNYZ8buOw1lMoq1oQ5z1HyCyVpFIo5WghP/jJJSPXbdddhHILhbm
         fOm3U0QWZ/TnmNE8XTTPVMhSYXX0PvNdmD8l2NgVZayPYnk7Kag83miazkl3AYrsw9KA
         O3jA==
X-Forwarded-Encrypted: i=1; AJvYcCW+yF8/6+PalrSlEvR8WxGUbMf61jyrE9neV/6aMVEmRDp63T/T1cYh/tQbDnSjgzzjtq2f2TgL6CtmelJDHzcz@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsG6xy5tGhNPWSse76Bx9Ux9otb1IvOgo1VYNTdlm+TGg03ut
	egCHHrbduJEtVLuFl+eZMECoawrjysPNj/k4qY1bJlJW4sxegNqIxp7pwilJzw9lqYR6G30srHI
	402ZOkw==
X-Google-Smtp-Source: AGHT+IH9D+lYyuoj3q2tuIRgrssticmiMq310mlYBNoxXkrhCnEnZmlHd1QE9PfvOXZH5YA0DLmsyCbtKHhF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7595:be86:b969:ac41])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c1:b0:e30:b89f:e3d with SMTP id
 3f1490d57ef6-e380e030963mr158951276.1.1731625645926; Thu, 14 Nov 2024
 15:07:25 -0800 (PST)
Date: Thu, 14 Nov 2024 15:07:12 -0800
In-Reply-To: <20241114230713.330701-1-irogers@google.com>
Message-Id: <20241114230713.330701-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114230713.330701-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 2/3] perf values: Use evsel rather than evsel->idx
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

An evsel idx may not be stable due to sorting, evlist removal,
etc. Avoid use of the idx where the evsel itself can be used to avoid
these problems. This removed 1 values array and duplicated evsel name
strings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c |   4 +-
 tools/perf/util/values.c    | 106 +++++++++++++++---------------------
 tools/perf/util/values.h    |   9 +--
 3 files changed, 51 insertions(+), 68 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 048c91960ba9..e5478082845c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -348,11 +348,9 @@ static int process_read_event(const struct perf_tool *tool,
 	struct report *rep = container_of(tool, struct report, tool);
 
 	if (rep->show_threads) {
-		const char *name = evsel__name(evsel);
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
-					   evsel->core.idx,
-					   name,
+					   evsel,
 					   event->read.value);
 
 		if (err)
diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index b9823f414f10..ec72d29f3d58 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -8,6 +8,7 @@
 
 #include "values.h"
 #include "debug.h"
+#include "evsel.h"
 
 int perf_read_values_init(struct perf_read_values *values)
 {
@@ -22,21 +23,17 @@ int perf_read_values_init(struct perf_read_values *values)
 	values->threads = 0;
 
 	values->counters_max = 16;
-	values->counterrawid = malloc(values->counters_max
-				      * sizeof(*values->counterrawid));
-	values->countername = malloc(values->counters_max
-				     * sizeof(*values->countername));
-	if (!values->counterrawid || !values->countername) {
-		pr_debug("failed to allocate read_values counters arrays");
+	values->counters = malloc(values->counters_max * sizeof(*values->counters));
+	if (!values->counters) {
+		pr_debug("failed to allocate read_values counters array");
 		goto out_free_counter;
 	}
-	values->counters = 0;
+	values->num_counters = 0;
 
 	return 0;
 
 out_free_counter:
-	zfree(&values->counterrawid);
-	zfree(&values->countername);
+	zfree(&values->counters);
 out_free_pid:
 	zfree(&values->pid);
 	zfree(&values->tid);
@@ -56,10 +53,7 @@ void perf_read_values_destroy(struct perf_read_values *values)
 	zfree(&values->value);
 	zfree(&values->pid);
 	zfree(&values->tid);
-	zfree(&values->counterrawid);
-	for (i = 0; i < values->counters; i++)
-		zfree(&values->countername[i]);
-	zfree(&values->countername);
+	zfree(&values->counters);
 }
 
 static int perf_read_values__enlarge_threads(struct perf_read_values *values)
@@ -116,81 +110,71 @@ static int perf_read_values__findnew_thread(struct perf_read_values *values,
 
 static int perf_read_values__enlarge_counters(struct perf_read_values *values)
 {
-	char **countername;
-	int i, counters_max = values->counters_max * 2;
-	u64 *counterrawid = realloc(values->counterrawid, counters_max * sizeof(*values->counterrawid));
+	int counters_max = values->counters_max * 2;
+	struct evsel **new_counters = realloc(values->counters,
+					     counters_max * sizeof(*values->counters));
 
-	if (!counterrawid) {
-		pr_debug("failed to enlarge read_values rawid array");
+	if (!new_counters) {
+		pr_debug("failed to enlarge read_values counters array");
 		goto out_enomem;
 	}
 
-	countername = realloc(values->countername, counters_max * sizeof(*values->countername));
-	if (!countername) {
-		pr_debug("failed to enlarge read_values rawid array");
-		goto out_free_rawid;
-	}
-
-	for (i = 0; i < values->threads; i++) {
+	for (int i = 0; i < values->threads; i++) {
 		u64 *value = realloc(values->value[i], counters_max * sizeof(**values->value));
-		int j;
 
 		if (!value) {
 			pr_debug("failed to enlarge read_values ->values array");
-			goto out_free_name;
+			goto out_free_counters;
 		}
 
-		for (j = values->counters_max; j < counters_max; j++)
+		for (int j = values->counters_max; j < counters_max; j++)
 			value[j] = 0;
 
 		values->value[i] = value;
 	}
 
 	values->counters_max = counters_max;
-	values->counterrawid = counterrawid;
-	values->countername  = countername;
+	values->counters = new_counters;
 
 	return 0;
-out_free_name:
-	free(countername);
-out_free_rawid:
-	free(counterrawid);
+out_free_counters:
+	free(new_counters);
 out_enomem:
 	return -ENOMEM;
 }
 
 static int perf_read_values__findnew_counter(struct perf_read_values *values,
-					     u64 rawid, const char *name)
+					     struct evsel *evsel)
 {
 	int i;
 
-	for (i = 0; i < values->counters; i++)
-		if (values->counterrawid[i] == rawid)
+	for (i = 0; i < values->num_counters; i++)
+		if (values->counters[i] == evsel)
 			return i;
 
-	if (values->counters == values->counters_max) {
-		i = perf_read_values__enlarge_counters(values);
-		if (i)
-			return i;
+	if (values->num_counters == values->counters_max) {
+		int err = perf_read_values__enlarge_counters(values);
+
+		if (err)
+			return err;
 	}
 
-	i = values->counters++;
-	values->counterrawid[i] = rawid;
-	values->countername[i] = strdup(name);
+	i = values->num_counters++;
+	values->counters[i] = evsel;
 
 	return i;
 }
 
 int perf_read_values_add_value(struct perf_read_values *values,
 				u32 pid, u32 tid,
-				u64 rawid, const char *name, u64 value)
+				struct evsel *evsel, u64 value)
 {
 	int tindex, cindex;
 
 	tindex = perf_read_values__findnew_thread(values, pid, tid);
 	if (tindex < 0)
 		return tindex;
-	cindex = perf_read_values__findnew_counter(values, rawid, name);
+	cindex = perf_read_values__findnew_counter(values, evsel);
 	if (cindex < 0)
 		return cindex;
 
@@ -205,15 +189,15 @@ static void perf_read_values__display_pretty(FILE *fp,
 	int pidwidth, tidwidth;
 	int *counterwidth;
 
-	counterwidth = malloc(values->counters * sizeof(*counterwidth));
+	counterwidth = malloc(values->num_counters * sizeof(*counterwidth));
 	if (!counterwidth) {
 		fprintf(fp, "INTERNAL ERROR: Failed to allocate counterwidth array\n");
 		return;
 	}
 	tidwidth = 3;
 	pidwidth = 3;
-	for (j = 0; j < values->counters; j++)
-		counterwidth[j] = strlen(values->countername[j]);
+	for (j = 0; j < values->num_counters; j++)
+		counterwidth[j] = strlen(evsel__name(values->counters[j]));
 	for (i = 0; i < values->threads; i++) {
 		int width;
 
@@ -223,7 +207,7 @@ static void perf_read_values__display_pretty(FILE *fp,
 		width = snprintf(NULL, 0, "%d", values->tid[i]);
 		if (width > tidwidth)
 			tidwidth = width;
-		for (j = 0; j < values->counters; j++) {
+		for (j = 0; j < values->num_counters; j++) {
 			width = snprintf(NULL, 0, "%" PRIu64, values->value[i][j]);
 			if (width > counterwidth[j])
 				counterwidth[j] = width;
@@ -231,14 +215,14 @@ static void perf_read_values__display_pretty(FILE *fp,
 	}
 
 	fprintf(fp, "# %*s  %*s", pidwidth, "PID", tidwidth, "TID");
-	for (j = 0; j < values->counters; j++)
-		fprintf(fp, "  %*s", counterwidth[j], values->countername[j]);
+	for (j = 0; j < values->num_counters; j++)
+		fprintf(fp, "  %*s", counterwidth[j], evsel__name(values->counters[j]));
 	fprintf(fp, "\n");
 
 	for (i = 0; i < values->threads; i++) {
 		fprintf(fp, "  %*d  %*d", pidwidth, values->pid[i],
 			tidwidth, values->tid[i]);
-		for (j = 0; j < values->counters; j++)
+		for (j = 0; j < values->num_counters; j++)
 			fprintf(fp, "  %*" PRIu64,
 				counterwidth[j], values->value[i][j]);
 		fprintf(fp, "\n");
@@ -266,16 +250,16 @@ static void perf_read_values__display_raw(FILE *fp,
 		if (width > tidwidth)
 			tidwidth = width;
 	}
-	for (j = 0; j < values->counters; j++) {
-		width = strlen(values->countername[j]);
+	for (j = 0; j < values->num_counters; j++) {
+		width = strlen(evsel__name(values->counters[j]));
 		if (width > namewidth)
 			namewidth = width;
-		width = snprintf(NULL, 0, "%" PRIx64, values->counterrawid[j]);
+		width = snprintf(NULL, 0, "%x", values->counters[j]->core.idx);
 		if (width > rawwidth)
 			rawwidth = width;
 	}
 	for (i = 0; i < values->threads; i++) {
-		for (j = 0; j < values->counters; j++) {
+		for (j = 0; j < values->num_counters; j++) {
 			width = snprintf(NULL, 0, "%" PRIu64, values->value[i][j]);
 			if (width > countwidth)
 				countwidth = width;
@@ -287,12 +271,12 @@ static void perf_read_values__display_raw(FILE *fp,
 		namewidth, "Name", rawwidth, "Raw",
 		countwidth, "Count");
 	for (i = 0; i < values->threads; i++)
-		for (j = 0; j < values->counters; j++)
-			fprintf(fp, "  %*d  %*d  %*s  %*" PRIx64 "  %*" PRIu64,
+		for (j = 0; j < values->num_counters; j++)
+			fprintf(fp, "  %*d  %*d  %*s  %*x  %*" PRIu64,
 				pidwidth, values->pid[i],
 				tidwidth, values->tid[i],
-				namewidth, values->countername[j],
-				rawwidth, values->counterrawid[j],
+				namewidth, evsel__name(values->counters[j]),
+				rawwidth, values->counters[j]->core.idx,
 				countwidth, values->value[i][j]);
 }
 
diff --git a/tools/perf/util/values.h b/tools/perf/util/values.h
index 791c1ad606c2..bbca33daca19 100644
--- a/tools/perf/util/values.h
+++ b/tools/perf/util/values.h
@@ -5,14 +5,15 @@
 #include <stdio.h>
 #include <linux/types.h>
 
+struct evsel;
+
 struct perf_read_values {
 	int threads;
 	int threads_max;
 	u32 *pid, *tid;
-	int counters;
+	int num_counters;
 	int counters_max;
-	u64 *counterrawid;
-	char **countername;
+	struct evsel **counters;
 	u64 **value;
 };
 
@@ -21,7 +22,7 @@ void perf_read_values_destroy(struct perf_read_values *values);
 
 int perf_read_values_add_value(struct perf_read_values *values,
 				u32 pid, u32 tid,
-				u64 rawid, const char *name, u64 value);
+				struct evsel *evsel, u64 value);
 
 void perf_read_values_display(FILE *fp, struct perf_read_values *values,
 			      int raw);
-- 
2.47.0.338.g60cca15819-goog

