Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3381AD5
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708997; cv=none; b=MOkiFHk6OTRVoQ59CmRY1ErL0Z625PwVVD1V78KWIFOcGUr0aKdL05vLETAHUc1MzXnx/3aYzxKCD+g9LH3TiCQ1n3vPlbRcQR25U4wS1UAcaUniMhDjgfq30MSJHdNKqvM/x7fg+oJmRqVBh0LWUY/J7jpMw4wyPOODlqm1HdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708997; c=relaxed/simple;
	bh=YYa+Nj8QupDsrGP0rJ+e/R7X/4u9o5UtV/jMgIiLlcY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uy9Zk6EC/S56V7MZywpP/TYmzOmW3WugDdeERXQg/o6KZDGrqw0o8L/0a6ocbZftxyXsh3qVjxuZNN9q666T4mHPBuhWkmBZV/7jCmcLcovafg7jPYumqiBAiyXwRh/LP84FzONZ4lr0PjmVlQ5JsFQvwE/o55e9/ZK5nfVNvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpDjeqEk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpDjeqEk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff908a0247so77677177b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 05:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706708993; x=1707313793; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKt68spgIYibNwkUCCwXitmo+vBc98KzSc/IhrrswsU=;
        b=DpDjeqEkXKdtfKUkU8nxls2OkLtvKZ/pwqwkVrWRTmilt4uChR6rq7QLuf6ckuidJ7
         p8K0p7nJTJ2Z8ujRKZ4NvjSVKXr1ripBK7JjaESggVvx4DsIrEVK/8WoVLdG2DmPEwfu
         7m1pLD9boR+Z0PI2nd59gSHM2VpufRj9ulvgxOwTOOnfSCUlg1LY7JHD8DzgfoK5VjiY
         ZCLMlDt0O1jhYyjeE/9HFmDf507K/n2/G+8rybEfxyuqhe5dp/rOvMsU/ptQrbGTSxzT
         YiKl2J3e/kn5iFHOTXzB5iz0K8py4KZwNCDjFmXRKhYRYG0eIL44MozARvIbEFAMwOaz
         HDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708993; x=1707313793;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKt68spgIYibNwkUCCwXitmo+vBc98KzSc/IhrrswsU=;
        b=QudLpkeutiqAEAuon06+4G5ghmtfOHr5MpirkLX3+PxjiAKOQslO0fgI45h8vv3go2
         Z2qHmZA+qyiWeg+LXN4YVZKwBhWlCHuniOCflpIvUNFw/OipWfpr73X9IBWlsqbEFbmw
         DZB6LWHeoF8gEBVrVq0DF07Hql/XVpGILT7khTQwXhW/nxKJHRjE2lY2htuBub7ieJs9
         dSQdBi/Rp4hLi2RcRwE0YQjFMNnjA1ylPBRMsmRzSr79jmIUdTlVfvPBTV71zPHVYksH
         G2FlbENXpxD/lQ631U7oSnXoI7uxMxe0d1kapcIm4gkLJblHKVxSRxmi4RhZs3q9v9h5
         3pSw==
X-Gm-Message-State: AOJu0YyJ5KPgd+BP59GYYtHFTQLLauQad54iVkUH4QJtSas/guNs0IAr
	Vqz9RaZGknMgHpM4qnHd5GsUXxfe/mNnImXeAHyFMhLW57zPOnakyARXni/gE+RG84P8nwgwnZH
	KXPKgQw==
X-Google-Smtp-Source: AGHT+IGcPvTcuBgccfjnu+QUYO9mM1IcPsCQr4yciw1sx++mmGoHgKMO2dXMWdUr4q6buMpGFQcDmcatR0as
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d0ab:43c6:7969:62ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:110f:b0:dc6:c9ff:58b7 with SMTP
 id o15-20020a056902110f00b00dc6c9ff58b7mr25000ybu.7.1706708993295; Wed, 31
 Jan 2024 05:49:53 -0800 (PST)
Date: Wed, 31 Jan 2024 05:49:40 -0800
In-Reply-To: <20240131134940.593788-1-irogers@google.com>
Message-Id: <20240131134940.593788-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240131134940.593788-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 3/3] perf parse-events: Print all errors
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tchen168@asu.edu, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Prior to this patch the first and the last error encountered during
parsing are printed. To see other errors verbose needs
enabling. Unfortunately this can drop useful errors, in particular on
terms. This patch changes the errors so that instead of the first and
last all errors are recorded and printed, the underlying data
structure is changed to a list.

Before:
```
$ perf stat -e 'slots/edge=2/' true
event syntax error: 'slots/edge=2/'
                                \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'slots'

Initial error:
event syntax error: 'slots/edge=2/'
                     \___ Cannot find PMU `slots'. Missing kernel support?
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

After:
```
$ perf stat -e 'slots/edge=2/' true
event syntax error: 'slots/edge=2/'
                     \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'slots'

event syntax error: 'slots/edge=2/'
                                \___ value too big for format (edge), maximum is 1

event syntax error: 'slots/edge=2/'
                     \___ Cannot find PMU `slots'. Missing kernel support?
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
Prompted by discussion:
https://lore.kernel.org/linux-perf-users/9dd303cb-0455-d8ac-ce0c-f4a8320b787b@arm.com/
---
 tools/perf/arch/x86/tests/hybrid.c |  5 +-
 tools/perf/tests/expand-cgroup.c   |  3 +-
 tools/perf/tests/parse-events.c    |  9 ++-
 tools/perf/util/parse-events.c     | 92 ++++++++++++++++++------------
 tools/perf/util/parse-events.h     | 14 ++---
 tools/perf/util/parse-events.y     |  2 -
 6 files changed, 67 insertions(+), 58 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index 40f5d17fedab..e221ea104174 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -259,11 +259,10 @@ static int test_event(const struct evlist_test *e)
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, e->name, &err);
 	if (ret) {
-		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
-			 e->name, ret, err.str);
+		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
 		parse_events_error__print(&err, e->name);
 		ret = TEST_FAIL;
-		if (strstr(err.str, "can't access trace events"))
+		if (parse_events_error__contains(&err, "can't access trace events"))
 			ret = TEST_SKIP;
 	} else {
 		ret = e->check(evlist);
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 9c1a1f18db75..31966ff856f8 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -127,8 +127,7 @@ static int expand_group_events(void)
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, event_str, &err);
 	if (ret < 0) {
-		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
-			 event_str, ret, err.str);
+		pr_debug("failed to parse event '%s', err %d\n", event_str, ret);
 		parse_events_error__print(&err, event_str);
 		goto out;
 	}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index fbdf710d5eea..feb5727584d1 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2506,11 +2506,10 @@ static int test_event(const struct evlist_test *e)
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, e->name, &err);
 	if (ret) {
-		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
-			 e->name, ret, err.str);
+		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
 		parse_events_error__print(&err, e->name);
 		ret = TEST_FAIL;
-		if (err.str && strstr(err.str, "can't access trace events"))
+		if (parse_events_error__contains(&err, "can't access trace events"))
 			ret = TEST_SKIP;
 	} else {
 		ret = e->check(evlist);
@@ -2535,8 +2534,8 @@ static int test_event_fake_pmu(const char *str)
 	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
 			     &perf_pmu__fake, /*warn_if_reordered=*/true);
 	if (ret) {
-		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
-			 str, ret, err.str);
+		pr_debug("failed to parse event '%s', err %d\n",
+			 str, ret);
 		parse_events_error__print(&err, str);
 	}
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 66eabcea4242..6f8b0fa17689 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2181,50 +2181,53 @@ int parse_event(struct evlist *evlist, const char *str)
 	return ret;
 }
 
+struct parse_events_error_entry {
+	/** @list: The list the error is part of. */
+	struct list_head list;
+	/** @idx: index in the parsed string */
+	int   idx;
+	/** @str: string to display at the index */
+	char *str;
+	/** @help: optional help string */
+	char *help;
+};
+
 void parse_events_error__init(struct parse_events_error *err)
 {
-	bzero(err, sizeof(*err));
+	INIT_LIST_HEAD(&err->list);
 }
 
 void parse_events_error__exit(struct parse_events_error *err)
 {
-	zfree(&err->str);
-	zfree(&err->help);
-	zfree(&err->first_str);
-	zfree(&err->first_help);
+	struct parse_events_error_entry *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &err->list, list) {
+		zfree(&pos->str);
+		zfree(&pos->help);
+		list_del_init(&pos->list);
+		free(pos);
+	}
 }
 
 void parse_events_error__handle(struct parse_events_error *err, int idx,
 				char *str, char *help)
 {
+	struct parse_events_error_entry *entry;
+
 	if (WARN(!str || !err, "WARNING: failed to provide error string or struct\n"))
 		goto out_free;
-	switch (err->num_errors) {
-	case 0:
-		err->idx = idx;
-		err->str = str;
-		err->help = help;
-		break;
-	case 1:
-		err->first_idx = err->idx;
-		err->idx = idx;
-		err->first_str = err->str;
-		err->str = str;
-		err->first_help = err->help;
-		err->help = help;
-		break;
-	default:
-		pr_debug("Multiple errors dropping message: %s (%s)\n",
-			err->str, err->help ?: "<no help>");
-		free(err->str);
-		err->str = str;
-		free(err->help);
-		err->help = help;
-		break;
+
+	entry = zalloc(sizeof(*entry));
+	if (!entry) {
+		pr_err("Failed to allocate memory for event parsing error: %s (%s)\n",
+			str, help ?: "<no help>");
+		goto out_free;
 	}
-	err->num_errors++;
+	entry->idx = idx;
+	entry->str = str;
+	entry->help = help;
+	list_add(&entry->list, &err->list);
 	return;
-
 out_free:
 	free(str);
 	free(help);
@@ -2294,19 +2297,34 @@ static void __parse_events_error__print(int err_idx, const char *err_str,
 	}
 }
 
-void parse_events_error__print(struct parse_events_error *err,
+void parse_events_error__print(const struct parse_events_error *err,
 			       const char *event)
 {
-	if (!err->num_errors)
-		return;
+	struct parse_events_error_entry *pos;
+	bool first = true;
+
+	list_for_each_entry(pos, &err->list, list) {
+		if (!first)
+			fputs("\n", stderr);
+		__parse_events_error__print(pos->idx, pos->str, pos->help, event);
+		first = false;
+	}
+}
 
-	__parse_events_error__print(err->idx, err->str, err->help, event);
+/*
+ * In the list of errors err, do any of the error strings (str) contain the
+ * given needle string?
+ */
+bool parse_events_error__contains(const struct parse_events_error *err,
+				  const char *needle)
+{
+	struct parse_events_error_entry *pos;
 
-	if (err->num_errors > 1) {
-		fputs("\nInitial error:\n", stderr);
-		__parse_events_error__print(err->first_idx, err->first_str,
-					err->first_help, event);
+	list_for_each_entry(pos, &err->list, list) {
+		if (strstr(pos->str, needle) != NULL)
+			return true;
 	}
+	return false;
 }
 
 #undef MAX_WIDTH
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 63c0a36a4bf1..809359e8544e 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -130,13 +130,8 @@ struct parse_events_term {
 };
 
 struct parse_events_error {
-	int   num_errors;       /* number of errors encountered */
-	int   idx;	/* index in the parsed string */
-	char *str;      /* string to display at the index */
-	char *help;	/* optional help string */
-	int   first_idx;/* as above, but for the first encountered error */
-	char *first_str;
-	char *first_help;
+	/** @list: The head of a list of errors. */
+	struct list_head list;
 };
 
 /* A wrapper around a list of terms for the sake of better type safety. */
@@ -247,9 +242,10 @@ void parse_events_error__init(struct parse_events_error *err);
 void parse_events_error__exit(struct parse_events_error *err);
 void parse_events_error__handle(struct parse_events_error *err, int idx,
 				char *str, char *help);
-void parse_events_error__print(struct parse_events_error *err,
+void parse_events_error__print(const struct parse_events_error *err,
 			       const char *event);
-
+bool parse_events_error__contains(const struct parse_events_error *err,
+				  const char *needle);
 #ifdef HAVE_LIBELF_SUPPORT
 /*
  * If the probe point starts with '%',
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index de098caf0c1c..d70f5d84af92 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -536,8 +536,6 @@ tracepoint_name opt_event_config
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	if (error)
-		error->idx = @1.first_column;
 
 	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
 					error, $2, &@1);
-- 
2.43.0.429.g432eaa2c6b-goog

