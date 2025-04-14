Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AE28BA92
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652525; cv=none; b=ITQLrmNPS+TKdZftoiW4wvE9g1MM+CSTVLRS9NFwk154G0Gpn9dgl4zm+8b/8YVduQq4F4tiq3hREgigmmtWlUGJQCy6Eyzqbib6cbu/nJvNgJ2N71UB0cql9+Dg7MmFAJoEUhJHLv6VXbXhxxVaMhAb76Vg4wtyX8Ali6PTqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652525; c=relaxed/simple;
	bh=cldPljtNT7qHiWPUEEbz2VWvuqG4wWZhrYjwH64BME4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tqkBKlCzan9SqhJSz6ItesxpgSxCFF6sn0PigEKjPjEWiwRxNS2ZNqy+oHLpA26U4QFt4x8JQIW4wwVryYCT9gsHxxDWqy3G3YxeCtCGnVKJ7GqhGYgk88GaEQEx0OaejH5rdSwGnSoLRKbMgf4u0a/cU9HrgPqrltYH4cwDsrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PvXGM2M3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PvXGM2M3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso3424570a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652523; x=1745257323; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1iLUqminNY9h66ZOYZ2ICZcvhX324SmqH91RvhsK5HA=;
        b=PvXGM2M3CH6kn0coZsEasyQRZSXgh7E5ONVHNbpl9FygQt+Mz3Lm37OSGHzB8YhrCK
         CxUJUW5Ey3Xuua73RL+b8b/j72f+mhMzFbteUutCeiXvIB0r6WcAMdpLk6b/1AFNTcGI
         fS11angRIq+guEx3ULsSq6X9KvZ0fsmBQbgxUla9vHPZ7iujGHDjbSskV77RfMwxt1GT
         zR5cCqp+3Y6l7/DcJy8ojKu/MP5zYqqqWAkjdyDFn428mYr8sAIwo+ET53FYCpPRRJ3r
         su4S5QrpB5VCxHtXj6AR3TDy8jeaCOdrUMC9kqJpP6x2Hok/LhDGaz9d6RaWJw5ReKc4
         Fkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652523; x=1745257323;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iLUqminNY9h66ZOYZ2ICZcvhX324SmqH91RvhsK5HA=;
        b=nqxGA029rJyHFtm06hnz/HyEg0UY2PWFCBZhyjIaKto5vKrCLT3AI68RpWbCHniuzn
         t1N5eQa2ou+dmG12kEZy77RsmXPjzdop8gOV3U3leqEpb70RJYtIKkY8UQ4gTFndUfyS
         pLc+Pmg8WRoxt//q0puprmnWwLQy6+tXEvd91RI0zpKMcp0CCuihIpQvpGBRWC++VkfU
         yjT1heE7Qi4vbsWyaGKBXjsm13k5ZMabhUjWJjyfgvbvN363nqdfWMPDhb+vF4dBV/Vh
         nXywo7U51jbwO56QCRe6mDcdW3QDnm7dvPgcp/nATlpBXxpHLqg435t1siEEF/ERL1fM
         t26w==
X-Forwarded-Encrypted: i=1; AJvYcCXhrH4puujw1WmKQSdgeH+Ky2E3FDLMI9XYbtzCO79CjRU7oWq7YGeCyUEecHsHiDM1zqn27H+nNqwZ+HVFP/5z@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEhixCihwUMcZezW1OT8CbAhkJJUoCjMX/Yivi//AZUNOw6rf
	Nk1nrwRroHXJNMkBOKdKEHhWZn6PBKatfjsAiOn2Mu74G+NymuyMMdcjmjmgsiUWoF4brI2qJjJ
	PdoV+5g==
X-Google-Smtp-Source: AGHT+IHdmELhPxIFAiAZcNIPY0tCHWJxBvhCbZlFXjCC25dE912X35YAB3Gcl004AeJKAB/efk5XIPYPF2i4
X-Received: from pjxx16.prod.google.com ([2002:a17:90b:58d0:b0:2e5:5ffc:1c36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5848:b0:2fa:17e4:b1cf
 with SMTP id 98e67ed59e1d1-3084f306d88mr434225a91.2.1744652523505; Mon, 14
 Apr 2025 10:42:03 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:22 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-5-irogers@google.com>
Subject: [PATCH v5 04/16] perf intel-tpebs: Separate evsel__tpebs_prepare out
 of evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Separate the creation of the tpebs_retire_lat result out of the
opening step. This is in preparation for adding a prepare operation
for evlists.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.49.0.604.gff1f9ca942-goog

