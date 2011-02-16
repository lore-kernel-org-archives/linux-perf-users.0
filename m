From: Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf: make perf stat print user provided full event names
Date: Wed, 16 Feb 2011 15:10:01 +0200
Message-ID: <4d5bdc64.98a1df0a.7aa3.06c2@mx.google.com>
Reply-To: eranian@google.com
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:8018 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab1BPORQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Feb 2011 09:17:16 -0500
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p1GEHDIO024023
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Feb 2011 06:17:13 -0800
Received: from fxm2 (fxm2.prod.google.com [10.184.13.2])
	by hpaq12.eem.corp.google.com with ESMTP id p1GEHCmI024857
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Feb 2011 06:17:12 -0800
Received: by fxm2 with SMTP id 2so1428217fxm.35
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Feb 2011 06:17:12 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@elte.hu, paulus@samba.org, davem@davemloft.net, fweisbec@gmail.com, perfmon2-devel@lists.sf.net, eranian@gmail.com, eranian@google.com, robert.richter@amd.com, acme@redhat.com, arun@sharma-home.net, linux-perf-users@vger.kernel.org

This patch changes the way perf stat prints event names at the end
of a run. Until now, it was trying to reconstruct the event name
from its encoding. The problem is that it would only print generic
events without their modifiers (u, k, pp).

This patch saves the event name as passed by the user in the evsel
struct and uses it to print the final event name.

This would also work in case perf is linked with a library (such as
libpfm4) which provides full PMU event tables.

$ perf stat -e cycles:u,cycles:k date
Wed Feb 16 14:58:52 CET 2011

 Performance counter stats for 'date':

            568600 cycles:u                
           2779715 cycles:k                

        0.001908182  seconds time elapsed

Signed-off-by: Stephane Eranian <eranian@google.com>
---

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 211063e..5f1f364 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -85,6 +85,7 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 void perf_evsel__delete(struct perf_evsel *evsel)
 {
 	perf_evsel__exit(evsel);
+	free(evsel->name);
 	free(evsel);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index eecdc3a..c32b348 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -45,6 +45,7 @@ struct perf_evsel {
 	struct perf_counts	*counts;
 	int			idx;
 	void			*priv;
+	char			*name;
 };
 
 struct cpu_map;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cf082da..80a3dd5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -268,6 +268,9 @@ const char *event_name(struct perf_evsel *evsel)
 	u64 config = evsel->attr.config;
 	int type = evsel->attr.type;
 
+	if (evsel->name)
+		return evsel->name;
+
 	return __event_name(type, config);
 }
 
@@ -782,8 +785,10 @@ int parse_events(const struct option *opt, const char *str, int unset __used)
 	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
 	struct perf_event_attr attr;
 	enum event_result ret;
+	const char *ostr;
 
 	for (;;) {
+		ostr = str;
 		memset(&attr, 0, sizeof(attr));
 		ret = parse_event_symbols(opt, &str, &attr);
 		if (ret == EVT_FAILED)
@@ -798,6 +803,11 @@ int parse_events(const struct option *opt, const char *str, int unset __used)
 			if (evsel == NULL)
 				return -1;
 			perf_evlist__add(evlist, evsel);
+
+			evsel->name = calloc(str - ostr + 1, 1);
+			if (!evsel->name)
+				return -1;
+			strncpy(evsel->name, ostr, str - ostr);
 		}
 
 		if (*str == 0)
