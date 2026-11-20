Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212838;
	b=QM7mIMbBTQ/g1VAq5qNq/53oqvHyBNCenP6gpwYyEqComa6QJfD9/2+91iDtTqEK3oF1
	 C9TnZkRPNcRlLe9OUTWW+su3Nnn+YTU+MndBiSykdU8pNnpXiPCI06rAr1LEHgczcKdlo
	 O/xgFm/Ryvd4mEiCSYl02EDtoXLGocZ9foxTgPf96WLt2HS5Iy6e4bBP/cmRejl4riy9q
	 MvlD12FjtbW1NiCsk3BHki7nHJhTtTBuQXHu7hSMiP5k4b1AWyq5SK5458+Myr8RKplvw
	 R0wo7k91V6lvU/xmdwe/vPuF0ddr34sCCJVGJJMILnX8/cagJVcaOcpaOj8nWkdCZxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4peQzHs6AvoizxfnquPA5N6VEKo2Q/iCjNJ4PP9zkI8=;
	b=rbMsTi5SvZqlEUs08Uhd0SnHOKtKInSE2D1R0IUjGrEFNb4uECYUVYSUiwOLpE7UJeMk
	 yRSDTnhiwNjsFmmCe5RsEIMR3AVYN1VXyDOQfUK62YCnojNYQuvnbRobMCr/GjTC3cgQx
	 bei0DOK7WiCyWQwy44nILPu5TSCyGaEQo37DHXvHLpqQ3B4/cI5Qvd/XmYnxHQr3VVk0G
	 8PM0KtkfSqBIodw/a0i0moRIeMwQVOtgEC3ED57unE8W5ZJ4ueqEAxtXdGM5SXDJhXzdM
	 BramO7eUr2AjcjVOVB3lZcGug/M+6++Mc7/FxzZonh5W5CPWRPKx+RhLTqLCXsraP3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y7efLO5D;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C59606A6A8
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C59606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y7efLO5D
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a41f46d629so2062561b6e.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212830; x=1795817630; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4peQzHs6AvoizxfnquPA5N6VEKo2Q/iCjNJ4PP9zkI8=;
        b=Y7efLO5DP6MUsIEbfesLt2qqrmpTKMB9CJ0Rc0ah0pyKmtRlsO/qE/NJjvNu1Yo3ax
         NON6jv/hBWYsyKrUic1LhUfsnr2kYWgxvi9vC10ipMdDl42FeBewblbN60+3GnjSRfRk
         wjdleE2ytmxAjzaHtpe6GPO0i81TXSlekXM/vHGS5nIxF87RMFrrvSk2gMsE2FlCmQ6z
         i7UIsgZLAntqt9jSph5B55h5onTLYO49/KWzNhKg2oqbJLFgcUsCLg8cgifWUaNFWlGe
         mAna3jXKgSNjkMu/ijr44L3YYeecHe+nOt/YmFP0ncnstmbzhPO9/2f6GZLUJoUUBER5
         PIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212830; x=1795817630;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4peQzHs6AvoizxfnquPA5N6VEKo2Q/iCjNJ4PP9zkI8=;
        b=KugRh+WcDHUlP79mwhyZrku7m6++3hUKlkte0eipuJlJ48Jr+a4afFCVBflwPXCIgc
         vvKcnqJtHUxjWeo9Wt+geHzzOWZyB996kuSKABoThXKnW97oZ0l3vOMJ9MmnUsig8OIF
         UiX0owizgIcTAzcr6gIgcwsEcoDw10IhHJr/zZtHCEu+nNYBX4oS54ZeNVIcDzO4gmvH
         InN2hTZ8wJzWbFkhKutKVrNkL0KfgimmLzzkvNaXdGAaKmuBYMqHeO62Puj+STJVXy2a
         9vBt0sUaqPntibLmBFbOPpz0+qEgOmEPsO2aQy9iB9vIQZT4n0A7j4yKsENoffHUmr2l
         kwrA==
X-Gm-Message-State: APuU4Z8uK2OFJxuCWnCc6KziQLA635MAy2X6ZjtlMmMSRXWInU7oe+Os
	vno5se7DItJo3nFgaeCJCOjn08cMRj0cslwi8xn27h92k4pOsN2BNwGgIdUNJxo93x05k+5mANp
	FnU2Qup6DnQ==
X-Received: from jatn14.prod.google.com ([2002:a05:6638:264e:b0:620:1b60:b872])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:6711:b0:571:a186:d69e
 with SMTP id 5614622812f47-57a09e0eb99mr4908901b6e.47.1795212830035; Fri, 20
 Nov 2026 14:13:50 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:04 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-4-irogers@google.com>
Subject: [PATCH v3 03/30] perf script: Don't drop metric samples for CPUs
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
2.56.1.750.gf70dc682cf-goog

