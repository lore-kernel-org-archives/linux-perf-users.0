Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213610;
	b=nozIw6q8Qol9JawsHwk/6IMJUhQENOYqcZ8N9gpJg2N1ZrRCDe8XuwvzgYvSfOg4MYb2
	 fTTyr90p9yKrh+XyScjUIG22GP3HID8g7Wv2N0p6iSUU7Q/f/rgL6jDbI5uQv1erFlgZj
	 GqYbw4V8z4bTZHe3YT8bGygi1XT7n5N7CbCHXO2uq1dPZjgmkCWZ5/H1NHMddN9wwtNkF
	 OM/getEUgfi+k+GDxoMGa5gCaujS+G5RmKZQsRGmmjxe3vcmRbrjcBJPBu6shD3/Hx74G
	 P+ikkSkhKu+zu1xaCPiG+Ffxb7QLjBSlfLFjGEO57SM8EJw9a4OGJglsEkZB8+N0Fag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zoCOY8d84LUWk0NAgOOudXDsOloWKN7w7lXOGZbAXyM=;
	b=2LrpUxuBywGxKV2G341bdJCdozX03a5wYPbNy6m/o9lHVJgzkiQdyHRFJSg5CL6pddUJ
	 ONhgsuqb1KJPXHQZwmUx8b392jAwQAodV8M13QZhHSgrQzz2QTgnfqTrkjsqgkIFNuRAO
	 5j60D3+M9CwEB3te8BdhGEsBUTXqTRP+PNUJFEElIwIAUGC9PdDg8sty8JktF8NR7u81m
	 m5QjoLlLfjDzaGtOo4QwYhdQ14IVROa2IMoP0gcQt6KpCydBqvzFmZL447PrX9m8iCBca
	 iivBm61SfAdkuo9ILlpKAqYqAolOA19k8f+llaubh4eVwrx9HqZC2tQXqiC/YxSKHow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f6ZIsuze;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754E606A6AB
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A754E606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f6ZIsuze
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so2152960eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213609; x=1795818409; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zoCOY8d84LUWk0NAgOOudXDsOloWKN7w7lXOGZbAXyM=;
        b=f6ZIsuzek51qwjpixalVoBEUmvjC+tbF5eENhxegul03fEZ58UB8rJ/4znJU0ATioj
         tGZQNzy/HOO6NcsiHm2pKAgxlocB8Atq+rfm+bMq9XZn5DaONAAsRo4czjFXPvElLM6F
         mY2qIiRdjLxa5EgjLHZ9aqAG3zBIsNJRh31MYzhxCauXf/o7Cw5nsVT/QsIuJZnTT4EM
         4b2ZYPG4g2lDil5b9hxO0qHmsohWzISbtpgbS8sNDEf5RT5r2Nx8Oh2jhc1IkdU7E9L3
         S03c/+rnRji0sQODUKJOXGSakjTDD4rjF7gs5F6PBQ7v+ZOjDgRBMaU7mgUlwJKyaYP7
         YiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213609; x=1795818409;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zoCOY8d84LUWk0NAgOOudXDsOloWKN7w7lXOGZbAXyM=;
        b=XR5LWFbIGHntKa1Y4owTixzYILtm5EnCd5j5CYYixPeJnP3Ru/7X3LidKamBbsB77P
         yMXPquwR8BFxfUjuknO8ZgG79S1ndnUw01iibO2hW4O2lS+WxRjz1RBHDRmeJ6r/h4+E
         Ehk4BXnMtUEcZ8NTnl+Uz6EBOkTVzFNfu3GG03k7dSKYTqnH46DS6uOxmv40qriH1zeE
         Cur2NHhpNPvRC5ZVi0Poa1albWL0WgZ08T/qR0nKB/XjLL30nKh+7vriDVGCf7/uDNRS
         pwYRMq6Z2KYslW2GUdo36Yi70muPh6KRDz1Prxkbt3hfBHo3iKchUkLCjFMYdzcuBDZ3
         izZA==
X-Gm-Message-State: APuU4Z/8J1WL1h4SBgXKN4rgYt43Gqj5+mlRfpZ8Ll8rGA+OnGu6qAjf
	od41q9hQ2jNJjdpthGQPSMnyQwA7iV+i587QiJq2X/kQk5Pf7rbgoFL5fNl6+JLmJ4kjtVJw00M
	yWVi5r/a/hQ==
X-Received: from dyx8.prod.google.com ([2002:a05:693c:8208:b0:36c:a092:ca28])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8083:b0:375:e4de:96d3
 with SMTP id 5a478bee46e88-3857083f7d3mr4393077eec.31.1795213605628; Fri, 20
 Nov 2026 14:26:45 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:04 -0800
In-Reply-To: <20261120222615.2291168-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120222615.2291168-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120222615.2291168-6-irogers@google.com>
Subject: [PATCH v3 05/16] perf pmu: Probe precise_ip levels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() to probe supported precise_ip levels (1..3) and
populate probed.precise_mask and probed.max_precise.

Some PMUs that do not implement hardware precise sampling (such as
software, breakpoint, or AUX trace PMUs) silently ignore attr.precise_ip
even on non-sampling events (sample_period == 0), whereas PMUs that
genuinely validate precise_ip either reject precise_ip > 0 on counting
events or are sampling-only PMUs. Check for this before probing levels
1..3 so non-precise PMUs are not misreported as supporting precise_ip,
while still detecting higher precision levels when core events are
forwarded to hardware sampling units (such as AMD IBS).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  4 +++
 2 files changed, 64 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e965a47bf3b4..53ce3e5fae3b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3485,6 +3485,66 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 	if (pmu->probed.can_sample)
 		probe_sample_types(pmu, &base_attr, pid, cpu, flags);
 
+	/*
+	 * 3. Precise sampling support (:p, :pp, :ppp).
+	 * PMUs that do not validate attr.precise_ip (such as software,
+	 * breakpoint, or intel_pt) silently accept precise_ip > 0 even when
+	 * sample_period == 0. A PMU that genuinely implements precise_ip
+	 * either rejects precise_ip > 0 on non-sampling events or is a
+	 * sampling-only PMU (such as AMD ibs_op).
+	 * Note: On AMD, core events like cycles:P are forwarded to IBS and
+	 * support higher precision than advertised in sysfs caps/max_precise.
+	 */
+	if (pmu->probed.can_sample && !pmu->auxtrace) {
+		bool ignores_precise_ip = false;
+
+		if (pmu->probed.can_count) {
+			struct perf_event_attr c_attr = base_attr;
+			int fd;
+
+			c_attr.sample_period = 0;
+			c_attr.freq = 0;
+			c_attr.sample_type = 0;
+			c_attr.precise_ip = 1;
+			fd = sys_perf_event_open(&c_attr, pid, cpu, -1, flags);
+			if (fd >= 0) {
+				close(fd);
+				ignores_precise_ip = true;
+			}
+		}
+
+		if (!ignores_precise_ip) {
+			for (int level = 1; level <= 3; level++) {
+				struct perf_event_attr p_attr = base_attr;
+				int fd;
+
+				p_attr.sample_period = 10000;
+				p_attr.sample_type = PERF_SAMPLE_IP;
+				p_attr.precise_ip = level;
+				fd = sys_perf_event_open(&p_attr, pid, cpu, -1, flags);
+				if (fd < 0 && p_attr.exclude_kernel && p_attr.config2 == 0) {
+					p_attr.config2 = 1;
+					fd = sys_perf_event_open(&p_attr, pid, cpu, -1, flags);
+				}
+				if (fd >= 0) {
+					close(fd);
+					pmu->probed.precise_mask |= (1u << level);
+					pmu->probed.max_precise = level;
+				}
+			}
+			/*
+			 * Sampling-only PMUs, like AMD ibs_op, can't be checked
+			 * with a counting event. If every level, including 3
+			 * that few PMUs support, opened then assume precise_ip
+			 * is ignored.
+			 */
+			if (!pmu->probed.can_count && pmu->probed.precise_mask == 0xe) {
+				pmu->probed.precise_mask = 0;
+				pmu->probed.max_precise = 0;
+			}
+		}
+	}
+
 	if (keepalive_fd >= 0)
 		close(keepalive_fd);
 	pmu->probed.checked = true;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 658485faa05d..fea65e314547 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -238,6 +238,10 @@ struct perf_pmu {
 		char *probe_event;
 		/** @probed.open_err: errno if open_supported is false. */
 		int open_err;
+		/** @probed.max_precise: Maximum precise_ip level (0..3) supported. */
+		int max_precise;
+		/** @probed.precise_mask: Bitmask of supported precise_ip levels (1..3). */
+		unsigned int precise_mask;
 		/**
 		 * @probed.sample_types: Bitmask of supported
 		 * enum perf_event_sample_format flags.
-- 
2.56.1.750.gf70dc682cf-goog

