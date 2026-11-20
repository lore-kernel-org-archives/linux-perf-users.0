Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212824;
	b=0N68li/XudpLs5SLnL7/wV+IKCHQNGe1TOjzaLjK/BLZ98FH10xfrZkL6xJX4QXWQ0ZJ
	 wa0N0wRLsSdVTwIfeu36LBFqsN/NcoVjOWlppA+JQ2NAR/rhGoJSzBcxuRd72uwbswWu3
	 b3rsnGmHcArdFkWpiIk7NQ5ystnTeRQeudAEwSZr+H5GwEeMDcXXrcktrbMAVxoNDAVs6
	 Ihp9RDSs7ZDraIo0H1Ylw/SEkkH2Y61mKiOOreidUFv1/CEqD8dcN+IK1PCHTBfm8w5xx
	 pMhE8uFh9EFFCDU4zBZWPZO0W/RvSvvq1u2s4R9FFTpDZn6gGA9T6my5eU76C9zRHuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fdTVu9ac2YLECwcoGWeJTi+3MACuUXbIR+eJpbYlxEk=;
	b=uexI3iwykCwMNKuyZBf4d1KO2C3YvoWe92U7FUZnRBuEawm7TqBFhoysbV6i+AOyaB2Y
	 Fn4VytkE+YjOXcSeqPFHm3QM6DyEQ88p6z5iIgvgdCuuWOJcpBvG+nhWCuAhs5Af2t7qh
	 xUbymk+7DKSzujcB+blfX/nHFW1yqeIKfMBE89bxOCpVtlt4F3ovIpgkHrBJRdWBekotU
	 SRnkqXPj6qHHopXodZJqLfyu6Eto7n8NUkc9KIhgCTBOjpajx2karZyWTxoRJ2BFoa01B
	 lJ0ksGnL1qh9WXE236OpnAugGk+Ev3xjz50k+gagMopXORUQDD/NcWxjwIHUybcC+0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JFpASQic;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB660A2604
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36DB660A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JFpASQic
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1af203073e0so1523030c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212819; x=1795817619; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdTVu9ac2YLECwcoGWeJTi+3MACuUXbIR+eJpbYlxEk=;
        b=JFpASQicDGpQu9Wjo+7e0MRRG/c6JZD3XKzAGRnD7fUKbN67dE/kwUdHfALquOVo9j
         f94S5KhYSjIZF3FaGTdxa1a5WQ6fagZZEqGKP4xvUw1qBol/7f+0wSdFimCfVcENqLbU
         PrztFv8aGjdS4zvVNCdrkl09PSoGQ32VBezfKR/fKSC/T/wTNNpx1Rhy4iJi33WTZA/S
         gUceMdKfYauuumnLXnaPsUcfpQj4g1GvXFEFM+JcPka251JR0ssZ3wvXEox4OosN8F9V
         jmRsTXwIf2BRRn1X+z1SSiKhdPZ8tQPou86lJn13om1rkKgk9iEsszt/zMEDQ3u5XP6F
         Vr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212819; x=1795817619;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdTVu9ac2YLECwcoGWeJTi+3MACuUXbIR+eJpbYlxEk=;
        b=letVn6duvAhmqvEPxzqVRwtB5in4yhf9kCULHgpn7s9pJhF5fQOh4CtyMiraAs0pqN
         yCchWPz2pMi4B7xPheoEEYeD9eyxztsGuqAiDHn8Zry76gHcgD+xsrAD6UgUIiX672w9
         pboljRDYFKvBjx6ZwLv6uw+DctDbTR0P+Mw8oLQDDNMJxNX3gfWdaRwhs/ygM3cpheHI
         923MhP4TWNT62JyGeQmx1YevW6E73kzQ0gZT9FZX0oG6VsU4ZLs5uL0dhVMGPAXohtrF
         KHJYr0XnOMxon0IM1SRSVi+BafMlMGehUPwr82NSouxszETpXwLOtt+pfV9jFWxzqf82
         MsRg==
X-Gm-Message-State: APuU4Z/tdt/LFQs8AUkM/mg9mk6vyP7JMOitnPG/bQ4cZNsUQqkuYKX7
	q6Jv79YsKFLHD0t61tAcOVPVjozghWp6zlIYbP+yXgeE0tg4vCuOdEKOltsyoErYh2E1KnyGxDL
	mtj1eum0Cog==
X-Received: from dlbuy9.prod.google.com ([2002:a05:7022:1e09:b0:18c:3061:3bca])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f109:b0:1b3:8814:8383
 with SMTP id a92af1059eb24-1b55689fca6mr3255964c88.9.1795212818746; Fri, 20
 Nov 2026 14:13:38 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:02 -0800
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
Message-ID: <20261120221332.2245191-2-irogers@google.com>
Subject: [PATCH v3 01/30] perf pmus: Don't skip core PMUs as duplicates
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_pmus__scan_skip_duplicates() skips a PMU whose name, without a
numeric suffix, matches the previous PMU's. This is intended for uncore
PMUs, such as uncore_cha_0 and uncore_cha_1, that have the same events.
The check was also applied to core PMUs, but core PMUs of heterogeneous
systems may differ only by such a suffix while having different events.
For example, ARM ACPI systems with two kinds of core name their PMUs
armv8_pmuv3_0 and armv8_pmuv3_1, and devicetree systems may name them
armv8_cortex_a53 and armv8_cortex_a57 where "a53" and "a57" are hex
suffixes. Only the first core PMU was listed by "perf list" and the
events of the other core PMUs were missing.

Before, on such a system, "perf list" and "perf list --unit=<pmu>" only
showed the events of the first core PMU, the scan having skipped the
others. After, the events of every core PMU are shown, as on Intel
hybrid systems with cpu_core and cpu_atom PMUs. Uncore PMU deduplication
is unchanged and pmu_deduped_name_len() already avoided removing the
suffix of core PMU names when printing events. Similarly avoid removing
the suffix of core PMU names in the raw event encodings that "perf list"
shows for each PMU, so that each core PMU's encoding is shown with its
own name.

Fixes: cd4e1efbbc40 ("perf pmus: Skip duplicate PMUs and don't print list suffix by default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 8d3238fd23f1..03d79ec5037f 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -488,15 +488,14 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 	if (use_core_pmus) {
-		list_for_each_entry_continue(pmu, &core_pmus, list) {
-			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
-
-			if (last_pmu_name_len == pmu_name_len &&
-			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
-				continue;
-
+		/*
+		 * Core PMUs, such as armv8_cortex_a53 and armv8_cortex_a57,
+		 * may differ only by a suffix but have different events, so
+		 * they are never duplicates.
+		 */
+		list_for_each_entry_continue(pmu, &core_pmus, list)
 			return pmu;
-		}
+
 		pmu = NULL;
 		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
@@ -785,7 +784,9 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 			.long_string = STRBUF_INIT,
 			.num_formats = 0,
 		};
-		int len = pmu_name_len_no_suffix(pmu->name);
+		/* Core PMUs aren't duplicates so keep their suffix. */
+		int len = pmu->is_core ? (int)strlen(pmu->name)
+				       : (int)pmu_name_len_no_suffix(pmu->name);
 		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
 
 		if (!pmu->is_core)
-- 
2.56.1.750.gf70dc682cf-goog

