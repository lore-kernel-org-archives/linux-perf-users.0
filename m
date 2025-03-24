Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57111F0E36
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855705; cv=none; b=Dhjb7+441QSj0b+9sj7xTJhLV642trARDNpwzTcq2Pv51Q4WRsaY4TA8dfogzW+WfjEa+o4Oq3Ecy00u9+zSsy2p1MEnLXN7yqKYcEVs3XqP4YCOIfXj+JiHAVTTZSDZ4N8XTuAI6gPEe6tyvOpCieAndf5WhredqAhbGu8nsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855705; c=relaxed/simple;
	bh=/B7cAvSrRfNXbB5b3SzCIR4ejZKLzspf1N2+U2b5jiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Ii2EzI/hbo9rEeb2W5YosFdr/05Ma8oXZN+03/xdFTMqc53oLw2g0ayRYdvjRpPfU253HDpeZmOIHAioKGFZLrCbcudqt7O6aLp7//mVK+bDBDds08fSpfopXVNpRA8mo9a5CUfVS5y4KlDNAZqlpM9G6GiMOxUWgTEb6YGhk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOUuK1Up; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOUuK1Up"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c2fc98f199so4159112fac.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855702; x=1743460502; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22SmbJgPWD6WV+8wjcChVtc8LFfVPThDvnKhbyYVaoQ=;
        b=IOUuK1Up9/FB/KKlL/hGxjRX9JLZzFyQ8pOO1cFU5hpwCgxogKqYuQKwob2huvglGU
         Jb/kNnhvTMRgNMCDieWE5NgXVRCc2ZutzJpI9JR16aqE4A4vi6NNHcLEcDvf8QhxUEsW
         suNFQ88jSXW6+NKz0d+0oEeNA2e1ZfKaQYqpmuBxFpGtQyvp3F8iI8FCSVjhfmtHICUz
         tjI7RCK2MqNGun1xwbENZPyr7DY3HzpX9U6Vbw8LnHN1AIXIh82wBk0vPGNjFuL2xUMH
         A9eI8YgUlgpsdwLFhleZE0xqIVaGcLt8ifDKpMU3FJUYLNllh4bqO2w3BkXhU0JruJhL
         vHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855702; x=1743460502;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22SmbJgPWD6WV+8wjcChVtc8LFfVPThDvnKhbyYVaoQ=;
        b=RIbcnn6KIY4w94zZ/Ks2vgjQR2NISfV/U+tQ73WndZuEDKOs7pQaT4ZB2u8Q1P/5nf
         iJiaa3jqOJcyk8DTRGsmCbqBQrSGs/eRbp0itmaxE0+MyL29xoq6geUj7JLKdaWQdROD
         /CtJmzUhHDGDmPe8CCl7yJpgbThnZy0qSX4lB1ZGXm4diMS3Pkh72bD5OyDXq0atgLgc
         ao0YTCcSGA3wsaOjyN5A+ehto4OVAIau0j0cBN40ENE9t3IjS0CIXIpRFyUULx+djjSs
         SRmBFpRNofTdM4VeWMGx6DVfAl5ZQu5S+qQWWJLRRlZuQJYVtCOIS1ZRrsW6zImgE/jp
         wo4w==
X-Forwarded-Encrypted: i=1; AJvYcCW5WxtJ+QT8LdesXEN2pBz60DIuB99AeQpgL0B92F06N/Z/FFx7j7kdjppMMPUVkb1HKksEuFUelwa5Gra8JsgK@vger.kernel.org
X-Gm-Message-State: AOJu0YzZPU32/jSyJJvkXEc7TXDJi1QzJ2YJmnDgWua2PCXGoUE0iuag
	UdsOdK2ElUY05N5qEz/b12p54hwg/pBi5zZkwtAsFp2VIkAl/M0+Dllpb7PE/3GPLLY9rng1sNL
	JyWyuew==
X-Google-Smtp-Source: AGHT+IFOVJXVRtCGs0SgsEjxtHiADU1/akT31/WAh+aLJp4gwRJS1cn3i/NzT/QM8DFuam9wWbBlVfvwjFds
X-Received: from oabpu4.prod.google.com ([2002:a05:6870:9e84:b0:2b8:1fa:4ac5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:2313:b0:2c1:ade0:26a0
 with SMTP id 586e51a60fabf-2c7802cfa69mr9471444fac.10.1742855702718; Mon, 24
 Mar 2025 15:35:02 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:41 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-4-irogers@google.com>
Subject: [PATCH v1 03/14] perf intel-tpebs: Separate evsel__tpebs_prepare out
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
index 2b2f4b28e8ef..e218e435c1d7 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -36,7 +36,7 @@ static struct child_process tpebs_cmd;
 struct tpebs_retire_lat {
 	struct list_head nd;
 	/* Event name */
-	const char *name;
+	char *name;
 	/* Event name with the TPEBS modifier R */
 	const char *tpebs_name;
 	/* Count of retire_latency values found in sample data */
@@ -189,6 +189,82 @@ static int tpebs_stop(void)
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
@@ -196,10 +272,7 @@ static int tpebs_stop(void)
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
@@ -208,49 +281,13 @@ int evsel__tpebs_open(struct evsel *evsel)
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
@@ -267,6 +304,9 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 		}
 
+		cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf,
+				 sizeof(cpumap_buf));
+
 		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
 		if (ret)
 			goto out;
@@ -320,7 +360,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 		close(ack_fd[0]);
 		close(ack_fd[1]);
 	}
-err:
 	if (ret)
 		tpebs_delete();
 	return ret;
-- 
2.49.0.395.g12beb8f557-goog

