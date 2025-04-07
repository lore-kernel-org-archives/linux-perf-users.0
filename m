Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC0222571
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002078; cv=none; b=Z5O4zTN+l+DyZ9Q1sYeoiEwy0TOljK57EaRwjXi9nMKhQtbbUOfiDqr72tffF1J7pMBVXkmch9sIegWBZ0J5Fc0Hgvh7u1v5tUpHAmvJwD7FiWw3SEsnnxUUEPMrXLsyieCC9MabTcktZAIGJ+mV6fUZdi5F2EbhDsep5eGMEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002078; c=relaxed/simple;
	bh=JVanJEDpcMknG2x/X1wULUkE8JUqUZb8O7VIacDzqk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Zb2L5syhXXMWacbbtvKIOlcWsVN/IicGbuLNLRV1H3H99+Mq2gZdd2q7F7KlqO/FxqaLv99N7kFW1wGbadMPvGSL2vRenQTR5rHVOrueMy0H2F+V7I1A53D/TU36C3wXd5gk6dwhdH0Ja0pLHINUrafzGnb6hugBwI31hbrjGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jg8hfxpN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jg8hfxpN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso4096350a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002076; x=1744606876; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpNqTL2jhuFhMzQj4yTZFm6mW4YS6L/CEY0JlzRGbe8=;
        b=Jg8hfxpNE4CLi29SwpOwcqjlLKR8J/0dgPLAPdhnnRzB+WY1l/RJhZ2Al9V8Tof5C2
         Y42VfVVf3T0Jqv60mi2mgF8gIcDEPCSWsxd0lJx0pLfI1/pHT969synJO7noAtHti7Ra
         O8tsCPp5CXK0g/jToCi5jgt9GVU/ElxNWUUx5T+nC7CWdRrrGVKSX8OetBdSZIQVrA3C
         FWwnuJYM7VmNBGcFQdCoG6XJG28/w1dEVdL6CYCRDNX55MuPo75DrpvNaBH8OJCpAo3L
         QLXPKtDRUWMzuihylTT1FiHXrl1bfCos5DKstxbfWZVfTDPK0KWBOuWS0F0NvwLTIg1I
         0RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002076; x=1744606876;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpNqTL2jhuFhMzQj4yTZFm6mW4YS6L/CEY0JlzRGbe8=;
        b=F3Ut17Ohjng/4ScSPlYX4EklzPX6ryInoTzKOflaq27cGVN+siwdn8kNoWDhSV4kL7
         ZiIhC9gEs5GXWgwGWyzN7nRWMi33SOm7R942U8Avb44q5MvTJiG0L2YQ5bcZef9s1Hfe
         BUCL3g4q+kBROX8ZO0+bibw3IOXeNjGllet/akmyBuhUO6su0OSuDRL75FPqpepPDVGo
         0O4XR2LHHnWocSpS0x01d27s/50KlkoAhG9/eZuaweO2tOW2BQdg9h5L9ykmr4YaYY0k
         GAWzkyWe4wflMa1Q2r7WdJ72N58TmXP885swfivzNq+yXi5w72jIRSMc+5h4Ufjc6uu0
         eSLg==
X-Forwarded-Encrypted: i=1; AJvYcCXBV1hGn8bt1NboXUWuJHXdeA4K6Zr84PoGUkIvKijLpsKBc7xyK5xkEALzY7/ecX3V2vdleX3DYz9PYLwB2Nmy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85hOzc3rSnUqyIqbM2HIQdsWyQn0n4Sr2WaW6Eb2OvChx8Eyo
	5+N8QycNdIX3tR9h1F4pM7EVQNV9NzvSH6RZDeNORpw6rlE9CxyC9sQw0tHOR4A32KqtQ14Lx41
	fZ6l4qg==
X-Google-Smtp-Source: AGHT+IFVyCvW/Feca4p+3QkEEYUKy/g8V1QEEW2jH9+cPAXYC8KCcIe55abMoTfG5uAAP7CNk9mofbT8RVSJ
X-Received: from pjn3.prod.google.com ([2002:a17:90b:5703:b0:301:1bf5:2f07])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6d0:b0:2ee:e518:c1d8
 with SMTP id 98e67ed59e1d1-306a491f86amr16428164a91.30.1744002076510; Sun, 06
 Apr 2025 22:01:16 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:49 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-5-irogers@google.com>
Subject: [PATCH v2 04/16] perf intel-tpebs: Separate evsel__tpebs_prepare out
 of evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Separate the creation of the tpebs_retire_lat result out of the
opening step. This is in preparation for adding a prepare operation
for evlists.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 133 ++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 566e0ddcad88..2186818b2c9b 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -37,7 +37,7 @@ static struct child_process tpebs_cmd;
 struct tpebs_retire_lat {
 	struct list_head nd;
 	/* Event name */
-	const char *name;
+	char *name;
 	/* Event name with the TPEBS modifier R */
 	const char *tpebs_name;
 	/* Count of retire_latency values found in sample data */
@@ -190,6 +190,82 @@ static int tpebs_stop(void)
 	return ret;
 }
 
+static char *evsel__tpebs_name(struct evsel *evsel)
+{
+	char *name, *modifier;
+
+	name = strdup(evsel->name);
+	if (!name)
+		return NULL;
+
+	modifier = strrchr(name, 'R');
+	if (!modifier) {
+		pr_err("Tpebs event missing modifier '%s'\n", name);
+		free(name);
+		return NULL;
+	}
+
+	*modifier = 'p';
+	return name;
+}
+
+static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
+{
+	struct tpebs_retire_lat *result = zalloc(sizeof(*result));
+
+	if (!result)
+		return NULL;
+
+	result->tpebs_name = evsel->name;
+	result->name = evsel__tpebs_name(evsel);
+	if (!result->name) {
+		free(result);
+		return NULL;
+	}
+	list_add_tail(&result->nd, &tpebs_results);
+	tpebs_event_size++;
+	return result;
+}
+
+/**
+ * evsel__tpebs_prepare - create tpebs data structures ready for opening.
+ * @evsel: retire_latency evsel, all evsels on its list will be prepared.
+ */
+static int evsel__tpebs_prepare(struct evsel *evsel)
+{
+	struct evsel *pos;
+	struct tpebs_retire_lat *tpebs_event;
+
+	list_for_each_entry(tpebs_event, &tpebs_results, nd) {
+		if (!strcmp(tpebs_event->tpebs_name, evsel->name)) {
+			/*
+			 * evsel, or an identically named one, was already
+			 * prepared.
+			 */
+			return 0;
+		}
+	}
+	tpebs_event = tpebs_retire_lat__new(evsel);
+	if (!tpebs_event)
+		return -ENOMEM;
+
+	/*
+	 * Eagerly prepare all other evsels on the list to try to ensure that by
+	 * open they are all known.
+	 */
+	evlist__for_each_entry(evsel->evlist, pos) {
+		int ret;
+
+		if (pos == evsel || !pos->retire_lat)
+			continue;
+
+		ret = evsel__tpebs_prepare(pos);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * evsel__tpebs_open - starts tpebs execution.
  * @evsel: retire_latency evsel, all evsels on its list will be selected. Each
@@ -197,10 +273,7 @@ static int tpebs_stop(void)
  */
 int evsel__tpebs_open(struct evsel *evsel)
 {
-	int ret = 0;
-	struct evsel *pos;
-	struct evlist *evsel_list = evsel->evlist;
-	char cpumap_buf[50];
+	int ret;
 
 	/*
 	 * We should only run tpebs_start when tpebs_recording is enabled.
@@ -209,49 +282,13 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (tpebs_cmd.pid != 0 || !tpebs_recording)
 		return 0;
 
-	cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf, sizeof(cpumap_buf));
-	/*
-	 * Prepare perf record for sampling event retire_latency before fork and
-	 * prepare workload
-	 */
-	evlist__for_each_entry(evsel_list, pos) {
-		int i;
-		char *name;
-		struct tpebs_retire_lat *new;
-
-		if (!pos->retire_lat)
-			continue;
-
-		pr_debug("tpebs: Retire_latency of event %s is required\n", pos->name);
-		for (i = strlen(pos->name) - 1; i > 0; i--) {
-			if (pos->name[i] == 'R')
-				break;
-		}
-		if (i <= 0 || pos->name[i] != 'R') {
-			ret = -1;
-			goto err;
-		}
-
-		name = strdup(pos->name);
-		if (!name) {
-			ret = -ENOMEM;
-			goto err;
-		}
-		name[i] = 'p';
-
-		new = zalloc(sizeof(*new));
-		if (!new) {
-			ret = -1;
-			zfree(&name);
-			goto err;
-		}
-		new->name = name;
-		new->tpebs_name = pos->name;
-		list_add_tail(&new->nd, &tpebs_results);
-		tpebs_event_size += 1;
-	}
+	ret = evsel__tpebs_prepare(evsel);
+	if (ret)
+		return ret;
 
 	if (tpebs_event_size > 0) {
+		struct evlist *evsel_list = evsel->evlist;
+		char cpumap_buf[50];
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
@@ -268,6 +305,9 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 		}
 
+		cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf,
+				 sizeof(cpumap_buf));
+
 		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
 		if (ret)
 			goto out;
@@ -321,7 +361,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 		close(ack_fd[0]);
 		close(ack_fd[1]);
 	}
-err:
 	if (ret)
 		tpebs_delete();
 	return ret;
-- 
2.49.0.504.g3bcea36a83-goog

