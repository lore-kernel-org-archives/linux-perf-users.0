Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34287A140
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651003; cv=none; b=dI60DO38f6zVcJdWdFUq2LvQW9H43huIeSwh8FS8Cz2ooI7nBQzFUL+ny6kaT0ULjyRGz5pznVXhKx6KinlA7lzLau20U4+W+2LtF+8OBKJSk6bMOZFLxHEuXM1bUTkhkRo3Xmk9FwlErAWGRByJuHOESkczE3qaSkeMNXXxTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651003; c=relaxed/simple;
	bh=3I21YJLtt6e3c5sULT5fvIQ84OxV7DLMKCnQYsWdgDI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ClXQd+XDVSGzMGZqukVqGV7x/FXYNW4bylN3MsN9gkGHVVBzqfFdABQzQ+ZA/iNeHtWxwjYHv0cuiCx64BLnv/8XCCCw0iF3Tk+4RpZAi+rVA6Q9iRidQ8VHFfDb81Z16Pp9jQJkTZODM/w/mur1sHUma6oG9voACuIDI62mvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/5Nandb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/5Nandb"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627ec18b115so22604417b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716650999; x=1717255799; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pWtjA5RKLficyvRTTH7or1mGMjQs5mR1l7sIJY8crh8=;
        b=O/5Nandblp6Paysd97Zgv1gQqq6xRYIdVoUpSm0qcjmd/El4FQvHGQ8HynxjhZqam7
         rbr5lCS4da9W+2Z+ADSU5NSWVpv7qMwkxpO99DqKFxojn1AuBEu+F0otmR4duNI8og3h
         42PtLKcSapPSZ7NbuFIPRFg0ktWHu2jdSqTetYljSAUwHHqOrhE4L64GIG2Gnrk2wO3G
         GW7epGyzRl+bNv5VYLIWK5ylgMRBSuzL3l7QgaKAQLdPW3EOYjuKsXcBRR5ruFNsqfrV
         8IV2fQfL/kXlab7yamZwlTbKGmtsQFHrRiKbF7vkvw6w1FHGk7JNPGcLX0FyWSE+9+ZP
         DP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716650999; x=1717255799;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWtjA5RKLficyvRTTH7or1mGMjQs5mR1l7sIJY8crh8=;
        b=BSCEmc85Ax7q+MDjPH4qhE0PfPJV59NZJcwmryYHtKDZUNWVArKjj9ULxLTLAK1qaR
         xYEctlT/UEtjX70mPiefg77mlOgp6LcRFjNaroD2J3KoqGpI2Fk+CJ5BcFFUKXQ4FeuT
         v7+VE7TeGUUBu/oaTd0Cfv8+vABxZqpEkKn0xHyk1UEeW+9RAV5ve5avAYHCCUMUA5XH
         pAwmOtUuu5s5Jtf60gtXgXZ9Et451pjgT59jXGdcPAj2RyYXpCbJpMLR365B1wPQfeQV
         jRSknkvVDOOaZVQJ8n6P8u0Ht8eYu6A8/ELCiewiJjQeMs21leHK1vYUjD4VXXAWB658
         +bAA==
X-Forwarded-Encrypted: i=1; AJvYcCVHeMcz5EC3pcNqQx4bCc3JrrSjbO4g/0sAK8CUyw7ESQhMRAdIajXPh/t3lWGiXG7hm41LN8VDOEpgZl9sb1ernHo6y8QRNXtCKyt+383i8A==
X-Gm-Message-State: AOJu0Yyxf/QwG4uV7dScJK7l435E0KINGjOrvIPKiqAmeBelIW5MDeC4
	V80Qey3KVkyZ/mqeuiiuTwJg582Inkf1bJe/DlD0dFsA9Ji+sTefvO5yCE4drYKynLqmEAu7I8M
	p3i/Rgw==
X-Google-Smtp-Source: AGHT+IHomf9k4qEtEp5uSNOIWc4+Fo2SHI5y+wprt4/uD94vK9OAomaNWRNJBtUjyHkfZektanNCSgWTVhR0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8ae2:c404:aad0:5c4d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1509:b0:dc6:cd85:bcd7 with SMTP
 id 3f1490d57ef6-df7721c1a47mr1364616276.3.1716650999571; Sat, 25 May 2024
 08:29:59 -0700 (PDT)
Date: Sat, 25 May 2024 08:29:27 -0700
Message-Id: <20240525152927.665498-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v1] perf evlist: Force adding default events only to core PMUs
From: Ian Rogers <irogers@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PMUs other than core PMUs may have a 'cycles' event. Default opening a
non-core cycles event with perf record can lead to perf_event_open
failure. Avoid this by only opening the default 'cycles' event on core
PMUs.

Closes: https://lore.kernel.org/lkml/CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com/
Fixes: 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware events over legacy")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  6 ++----
 tools/perf/builtin-top.c    |  3 +--
 tools/perf/util/evlist.c    | 43 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac661..b968c3c2def6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3198,7 +3198,7 @@ static int switch_output_setup(struct record *rec)
 	unsigned long val;
 
 	/*
-	 * If we're using --switch-output-events, then we imply its 
+	 * If we're using --switch-output-events, then we imply its
 	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
 	 *  thread to its parent.
 	 */
@@ -4154,9 +4154,7 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-
-		err = parse_event(rec->evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		err = evlist__add_default_events(rec->evlist);
 		if (err)
 			goto out;
 	}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1d6aef51c122..90b97fc24edb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1665,8 +1665,7 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		int err = evlist__add_default_events(top.evlist);
 
 		if (err)
 			goto out_delete_evlist;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3a719edafc7a..ddca50cb049f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -32,6 +32,7 @@
 #include "util/sample.h"
 #include "util/bpf-filter.h"
 #include "util/stat.h"
+#include "util/strbuf.h"
 #include "util/util.h"
 #include <signal.h>
 #include <unistd.h>
@@ -93,14 +94,12 @@ struct evlist *evlist__new(void)
 struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
-	bool can_profile_kernel;
 	int err;
 
 	if (!evlist)
 		return NULL;
 
-	can_profile_kernel = perf_event_paranoid_check(1);
-	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+	err = evlist__add_default_events(evlist);
 	if (err) {
 		evlist__delete(evlist);
 		return NULL;
@@ -187,6 +186,44 @@ void evlist__delete(struct evlist *evlist)
 	free(evlist);
 }
 
+int evlist__add_default_events(struct evlist *evlist)
+{
+	struct perf_pmu *pmu = NULL;
+	bool can_profile_kernel = perf_event_paranoid_check(1);
+	struct strbuf events;
+	bool first = true;
+	int err;
+
+	err = strbuf_init(&events, /*hint=*/32);
+	if (err)
+		return err;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (!first) {
+			err = strbuf_addch(&events, ',');
+			if (err)
+				goto err_out;
+		}
+		err = strbuf_addstr(&events, pmu->name);
+		if (err < 0)
+			goto err_out;
+
+		if (can_profile_kernel)
+			err = strbuf_addstr(&events, "/cycles/P");
+		else
+			err = strbuf_addstr(&events, "/cycles/Pu");
+
+		if (err < 0)
+			goto err_out;
+
+		first = false;
+	}
+	err = parse_event(evlist, events.buf);
+err_out:
+	strbuf_release(&events);
+	return err;
+}
+
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	perf_evlist__add(&evlist->core, &entry->core);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index cb91dc9117a2..269db02f7b45 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -97,6 +97,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 void evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
+int evlist__add_default_events(struct evlist *evlist);
 void evlist__add(struct evlist *evlist, struct evsel *entry);
 void evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
-- 
2.45.1.288.g0e0cd299f1-goog

