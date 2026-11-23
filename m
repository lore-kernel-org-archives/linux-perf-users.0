Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418383;
	b=hQWOWvpSCzo5ZBkdPHOqj0B6Nt4q9lhFaYs0gxO/z5Fo0E+BCv2Ol6JRfsgB9d2m562V
	 I7i+e3erkqSyz5cl54Cc7rSGKrcrr5DRfz07QcmbEwPUCOw48pokRwLCn63G7vC6bWwPQ
	 b7zyaF710D7hGqTidhWc+7gp/hfDMSfpPhYGmhZZ18kcWDvSQpd6bmjAdbPJBQWJq/4hi
	 /vBxhqBcSo06MG+U2PmWtZYGlgv97nWDZXMloOexJXrQgris0YY/ggm60aVBQtg+VflZU
	 3LTQTlElHe6leV0EYtrgR3hOj4EUOrUzpEw9j/B8GoZzK6lmZVXh0LTHKkI10wEukvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Wmm3nvM1W3EMLy5l9NtCIiGzwg3XfDVkSr3+iewnx60=;
	b=m7dwmKdWFzZUCaM0RPNVpn7d68eTpcpkwIp+HM0kYOtsflZjXiBq2hoASzRGJPtoihQa
	 7yDTGWUEgdGVPjE9/KC6rCO9psONW+2An41okIgqOzNH4uYmqbH8wvJFHU636OhxvLvFN
	 4yw16g33k6qvzqpPAozzGdYslrAKVxHlXgHZ+3m/2106j+MONFCXJMN9Ja0AsDkeZkyQE
	 2/18Y+SWcX5y+2AuunHLd8lm1ha3JzmuIRUzESHbXHHBjbkp2k+zoDsCtMOmepCxjw6eC
	 5/l2peuRPrnV9A1u2chM1h2XYXzLizKG3rarVsrGxVwkULj4J9AKXGLe483q9Bc7YHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="lItsg/g/";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A7606A321
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B76A7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lItsg/g/
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3846d5f54c1so3804262eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418382; x=1796023182; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wmm3nvM1W3EMLy5l9NtCIiGzwg3XfDVkSr3+iewnx60=;
        b=lItsg/g/E08jN2UTKt+YFPM+kzBxLSvGGobTNPyM2XglbEq6nxtoOkj/kfehwu4iWn
         ZFkiL0q/zgvdgcQXqz50gJWMyxDxFdf1mXBuYmunFQGjoktoawwL96Y3HZ65S0kwWBBb
         XkHnsY4r7ZRUVANseyjXCXDGZ5bDXkvQFVwLlDS8HsjgWX5rHhdx7M61Cl1nDQGUGJoO
         /wjLqC4Uc/1lWYbzg2Sr3EtXop6IWFJJIdxbDZaWPVSPXyV3uradW61FwCNYMQpAwy89
         mJAdJRyJnECsVnBdonA58R/bD7peXwpyxAE2/6hA+nCVl63ndeyQv90chHBuuz46zdBI
         tc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418382; x=1796023182;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wmm3nvM1W3EMLy5l9NtCIiGzwg3XfDVkSr3+iewnx60=;
        b=e3T7iMNBbSHg772ddP/5yTZ9j67cWGKSr1eN9Q79JDc+S4oApbWY6ozrDythbMvOz7
         ac1jjDnHBLkV8Rb4fxN5hJ7fgAXxXnlLwIz1agTN70RKW0Rh5O9JNwVg56ZorMeIifHo
         eP1m/2bjNFnb9ijGTVpZ5btVSrQQfyuXzSrLZAGsfxMOXF+TVAovbz5hTPjC4Nz7rnEa
         jNm5Zu/OjMYUfk+HJ2WiZtOkfQuBahqeDG/LlvtYfmM8CUAP9dRGtnLobMKjFKbHegYs
         IIbmauXc9bke2/KzI01NWJ6xwi7BwDS6PZfVNLg7Nz0jOoZUABGcGE/nswqszH+JHwZ6
         ntnw==
X-Forwarded-Encrypted: i=1; AL+hErEEIyVprIkaCDPeBwbhp6vJrC/EwfL2nm65/+F+n4nt/H6+YpgXZtsaMhypXkuR0cwKnpYsM0H9R4DoqsHHA2s6@vger.kernel.org
X-Gm-Message-State: APuU4Z9jroME5XagXRNJgtGrrMl4LNf2K59KiztBXRKOvKJ5c+J2AkCZ
	HQJc2kUzmTtiBiyeLV4VENNBFgeWVQEqxpy8igtF58B/TxSa6qnWR3Sbqbd77zOuwcVZcNzhv6w
	gJuNlIcMo3g==
X-Received: from dybna20.prod.google.com ([2002:a05:7300:cc14:b0:386:95bc:ec27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2202:b0:36a:1e9e:ae61
 with SMTP id 5a478bee46e88-3857170afa1mr16311717eec.38.1795418381412; Sun, 22
 Nov 2026 23:19:41 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:04 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-5-irogers@google.com>
Subject: [PATCH v1 04/13] perf stat: Give non-perf_event_open events unique
 IDs for stat record
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

store_evsel_ids() skips tool, hwmon, DRM and retire latency events as
there is no perf event file descriptor to read an ID from. Their
perf_sample_id entries are left with an ID of 0, so the stat events
written by perf stat record all have an ID of 0. When reading the file,
evlist__id2evsel() maps an ID of 0 to the first evsel, so the counts of
all such events are attributed to the first evsel and the other events
are reported as not counted. For example:

  $ perf stat record -e duration_time,num_cpus,task-clock true
  $ perf stat report
                28      duration_time
     <not counted>      num_cpus
              0.84 msec task-clock

Give each CPU and thread of these events a unique synthetic ID. Kernel
IDs count up from 1, so the synthetic IDs count down from the largest
ID to be as far from them as possible; reaching them would need ~2^63
perf events to have been created. As a further guard, skip any ID that
is already in use by the evlist.

Fixes: d53b4996584b ("perf evsel: Skip store_evsel_ids for non-perf-event PMUs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 42 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 737a8680aaae..1f96c170d277 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4727,15 +4727,51 @@ struct perf_env *evsel__env(struct evsel *evsel)
 	return session ? perf_session__env(session) : NULL;
 }
 
+/*
+ * Get an ID for an event not opened with perf_event_open, such as a tool PMU
+ * event. Kernel assigned IDs count up from 1, so count down from the largest
+ * ID to keep as far away from them as possible. Reaching the kernel's IDs
+ * would need ~2^63 perf events to have been created, but also skip any ID
+ * already in use by the evlist.
+ */
+static u64 evlist__next_synthetic_id(struct evlist *evlist)
+{
+	static u64 next_synthetic_id = ~0ULL;
+	u64 id;
+
+	do {
+		id = next_synthetic_id--;
+	} while (evlist__id2sid(evlist, id));
+
+	return id;
+}
+
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	int cpu_map_idx, thread;
 
-	if (evsel__is_retire_lat(evsel))
-		return 0;
+	if (evsel__is_retire_lat(evsel) ||
+	    perf_pmu__kind(evsel->pmu) != PERF_PMU_KIND_PE) {
+		struct xyarray *sample_id = evsel->core.sample_id;
 
-	if (perf_pmu__kind(evsel->pmu) != PERF_PMU_KIND_PE)
+		if (!sample_id)
+			return 0;
+
+		/*
+		 * There's no perf event to read an ID from. Give each
+		 * CPU/thread a unique synthetic ID, otherwise all such events
+		 * have ID 0 and stat events written by perf stat record are
+		 * attributed to the first evsel.
+		 */
+		for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(sample_id); cpu_map_idx++) {
+			for (thread = 0; thread < xyarray__max_y(sample_id); thread++) {
+				perf_evlist__id_add(evlist__core(evlist), &evsel->core,
+						    cpu_map_idx, thread,
+						    evlist__next_synthetic_id(evlist));
+			}
+		}
 		return 0;
+	}
 
 	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd); cpu_map_idx++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
-- 
2.56.1.750.gf70dc682cf-goog

