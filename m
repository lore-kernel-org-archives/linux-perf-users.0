Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599626;
	b=VavSyXFxEbuCRGiKiPWcl/0PYBvldpg1mxWXzORl7KJos2qImS4GpiS/w8jLlGw90/li
	 CUwPU8WsVrco6lK04W2o2Qiknf9i4UV7Tg+b3bt8iq7IbvoFotGa7r9nIINhiB3/tggmX
	 bXKeFysYNfn54p5ID7c1ee3DZkFQc25vv00fVDANMPAGCyJRJtlIm6vGurA5AGN64jVIN
	 Mkg9y/tBBYq2+GQos+MvD38OijjFpsDQMIze80OMSiQ/qFBNE1/2BGsSWQR65GA5Ol/qu
	 RBMnzdMq8ykFeP3VLVd13z6wNwx+2ClZRasxh+BM+X7OcA6xQTiYLGEgk1RNRBCMYSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yZK0I0eEPwGAQ1xcP6pQmWLybyZKGwMTjQ0dOlFSYB8=;
	b=NWTCV2vN39WvduioBS+QpTjPyvuQVDGl0kIioRN9kuQIgTniTm+VNzuUwIl0wzxpnmpf
	 efH6PM0wWRq2oH1i7IfFk/8gGW674iGEywLXimS1MB74dWwQnJhmqfVhe/aKUHdITVi3v
	 az9sygdsvZbaEST+c3+j0t/cmkcN0MYD8ZO3DBf1sgiHyzeujxkQI6PhO9tGi8siim5KT
	 oQjgoF3QLaJWpQHgdd1PN/oRD843ggwYvZo9aPPayssm3lm/k/9S6tuowS6Jjr2Z6jJRg
	 QZZQtsPrWY2T/+J8pKfrB015p02kIRLWYgK05CkpK2O1QlYfdgG8jhz91OnNYq4UeWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UsSHsvl+;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80524606A886
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80524606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UsSHsvl+
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-370230d93efso5988242eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599626; x=1795204426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZK0I0eEPwGAQ1xcP6pQmWLybyZKGwMTjQ0dOlFSYB8=;
        b=UsSHsvl+ZVJm5zPQej8h/ho8NG5MhRxPnMkNYKGfPbdh2KmLyF8FVyBA8i8C6GPrz9
         y80xS4SC6yOm40O+JyPq1HbEMLaegZKgeGemHnyrqEqcFC5o/DSVWIUxWZ4EJERnANro
         wMmD4T7oZhmDnnqBtvblFRVdxtQiwnTp//1sSRJp44JXFKREOPEQx/UrMWh8h0gbEITo
         sj9kX3PMw2ZHIBadQ7KGoivlIEfuI/SchZhM2/UaWaEscSw5yByxpStkSdwIm2I1MpIx
         oHlWCnJTjEFFoZ6A83m1axb45VH8YcMX8eIFMJ0408P1FPH4eMpq2V6Ff7FOMZ8baIGl
         9e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599626; x=1795204426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZK0I0eEPwGAQ1xcP6pQmWLybyZKGwMTjQ0dOlFSYB8=;
        b=kHQp1l3DzAd6MC02fNlyexShaTjlCsyIy/E43SMcEPqJzvavrPzcD28AV93sjwwfW4
         ++07qup2ZMsPzlXLe/NUDzLAFzOM7uPRCADr7MaonFRBnPUlxYMzn6tQsvUX9OWDk3AF
         dQn5m8RsVfvROiBjWcV8s8DKeKJFwEcaaDT0j2dkW+Q4HORFaLV5RQsFd7HkMLxTseeS
         QhAZ3ANVQF6KukLHR0YE+ttdHdIkYgKDORu6aSWOvzkKviWEU5ouYDKbnT6CUxOnrVja
         ELdzOKBwmP3vK74nzMn0l/79vh4KzCMjYUuABh9yJr3L+sKUAd72kB2FiQ8MOr6SuK9a
         6XeA==
X-Gm-Message-State: APuU4Z+0irq3QIRolClHQhjG004Pjq3NEF0ekmgfIa1ANjIrVSELm9px
	AQoeWpqszKuvaoY0o6dNJUUzLn+Fr4xeIPN/txH2Dr3hUPcUUEjtnWL3Rr5KuXNQJOxLv2UCKnH
	gyjD1Vlcupw==
X-Received: from dyjt26.prod.google.com ([2002:a05:7300:7b1a:b0:351:16da:ebbc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f401:b0:36a:1489:fdf6
 with SMTP id 5a478bee46e88-37966387750mr3171685eec.11.1794599625370; Fri, 13
 Nov 2026 11:53:45 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:08 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-4-irogers@google.com>
Subject: [PATCH v2 03/30] perf script: Don't drop metric samples for CPUs
 missing from the evsel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf script -F metric looks up the index of the sample's CPU in the
evsel's CPU map and, when it isn't present, prints "Missing CPU map
entry for CPU <n>" and ignores the sample. When the perf.data file
doesn't record the CPUs of an event, as is the case for perf record,
__perf_evlist__propagate_maps() sets the evsel's CPUs to the host's
online CPUs. If a CPU is offline when perf script is run, or the
perf.data file was recorded on a machine with more CPUs, then every
sample on such a CPU is dropped from the metrics with a message, for
example thousands of:

  Missing CPU map entry for CPU 1

perf script currently only supports global aggregation of the counts
used for metrics, the counts of all CPUs are summed. So place the counts
of a sample whose CPU isn't in the evsel's CPU map in the first CPU of
the map, as was already done for samples without a CPU. This doesn't
change the metric values computed for samples of the CPUs in the map,
the summed counts just include the previously dropped samples, and so
isn't a regression. Aggregating per CPU, and using the CPUs of the
perf.data file's environment rather than the host's, would be future
improvements.

Fixes: 3622990efaab ("perf script: Change metric format to use json metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c5a9651a197c..97bad639753f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2557,15 +2557,14 @@ static void perf_sample__fprint_metric(struct thread *thread,
 	/* Update the evsel's count using the sample's data. */
 	cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, (struct perf_cpu){sample->cpu});
 	if (cpu_map_idx < 0) {
-		/* Missing CPU, check for any CPU. */
-		if (perf_cpu_map__cpu(evsel->core.cpus, /*idx=*/0).cpu == -1 ||
-		    sample->cpu == (u32)-1) {
-			/* Place the counts in the which ever CPU is first in the map. */
-			cpu_map_idx = 0;
-		} else {
-			pr_info("Missing CPU map entry for CPU %d\n", sample->cpu);
-			return;
-		}
+		/*
+		 * The evsel's CPUs may not contain the sample's CPU, for
+		 * example the sample may have no CPU or, when the perf.data
+		 * file doesn't record the evsel's CPUs, the evsel's CPUs are
+		 * the host's online CPUs. As only global aggregation is
+		 * supported, place the counts in the first CPU of the map.
+		 */
+		cpu_map_idx = 0;
 	}
 	thread_map_idx = perf_thread_map__idx(evsel->core.threads, sample->tid);
 	if (thread_map_idx < 0) {
-- 
2.56.1.703.gf848ed807c-goog

