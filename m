Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A44175D48
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612448; cv=none; b=OZKLu7u3OTFqk1o6MUgVNDNTmQ0mgvkzcBatqc9aiFTUDAyvRz/typ/gs6K7bzZFr8cWB57v0ZYwHPBS1qRjFgtkk8hZx28kzX+eg3m4TYG62Q4STRM6QBKhH2H/aMZZPqEi8dikQE6SZiKswC7slJm6A1PQ88E3mNlVbL1rE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612448; c=relaxed/simple;
	bh=mdSSrhP7G24frprN16593VOBIgMZgeUhPBNK6wrZNsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dXfYlf/fIz9bX4ACRFwo+Tc7i/5B3i2GNBHCX2hE/7eQ7xa4+TLsTrip/YUkIBCi6kjYTnROxmGCy0Fj2xvymH4OF4WVwIVe4GellyiZoww3rDwl8Zha2MWf2ZsPxY0enhr98EzD3FoujS1SoEjVFx//Z9Iw26/QTq7ALugQxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CVTWEySv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVTWEySv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240a960f9cso642785ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743612446; x=1744217246; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32l0Pu2pjVOQ0/rzRKMg0Sp9sEBo5wkzEsYD7DuEcpE=;
        b=CVTWEySvNa2BKwtyTADx4/lW2Bg8dl0Rql0Zkn8KtOyi7OnL2rDiOzzew/nznJ0c+3
         rdiXiNmzlU2EAgv58ya4J5NckY30yfsKwkS4P0DgITuf9x6wPQqGfq8eLkWejQe5gZ13
         4/D9amub89+iUkrKt1AOB/6gJk30gH68IOBPFeNHWi4RLnadRLubzqACC0jIR8/WHwgz
         sOxyIuqXbJh6SFdZ3XCeJv0er7I/bZ78JO0aNfmnVfUMkNhEIBR6LxDN3Lt/fETltqHX
         ZpZGC+nvX6lD/HohcM+DmC48f++ZmyLRxVym0mqNwXn3kOwDqWDGs7woUFA/FIqsAH0j
         PHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612446; x=1744217246;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32l0Pu2pjVOQ0/rzRKMg0Sp9sEBo5wkzEsYD7DuEcpE=;
        b=OE+zzuwomU0Bx1tYsfUb/z36GpjwqVNxDFxn+97brN3c5UbhmyB4aTO+bEpqC0fvCo
         n3q1tp5KzI6zvGcy8sqiGYv6yKlhyINzD4pTeCwXpe2AXODIsHxkAIx85boGThAg9b3n
         X1PxiErKcc/2yQ08Iz18bGyDu8UJenofKOD64h94/3ofpifh0bPED41jpWXduEnjqp+M
         do4R2rJiaCKrKeRzhEm7Q0LWwPy9Gw7Xr9Ey5HlVByXDtX6usXNxm/h2k4deF28cKTnd
         Z76iWof5kba2mimB7+a8zHqelBr4Y33Hj6erTGqVuCZIV3inaH5fIH2s4nc7GQF/6CRM
         nSQA==
X-Forwarded-Encrypted: i=1; AJvYcCU6A7axs1D/AT/18hZh7TZzlC7PkuVM8KIAeJY5WQrYhze0AkdyVxPi189sjwq+FmG0+ujrYpnQVYIbu92R1GND@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVWOidYAeUTvXKFF8RQCU5pxdYsKFehczx/j7X/4hUyXX5b02
	NmAkMEtpJ5si2bJYJP649NJX+oraC7DmipYESIj2weciQ/vtlBHxVOMWovzanW6AgVsBs1B7MPe
	8twlSHw==
X-Google-Smtp-Source: AGHT+IGCGqrDwBXC2WLXzmtNZD0tnxmjJy9+AtvHPheDKufpBqRlCNAGPLYftjaH/tRCYxxH1vMoPKmrSGL6
X-Received: from plbmk14.prod.google.com ([2002:a17:903:2bce:b0:223:f487:afc6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19c7:b0:223:6657:5008
 with SMTP id d9443c01a7336-2292f974807mr300287625ad.24.1743612446668; Wed, 02
 Apr 2025 09:47:26 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:47:16 -0700
In-Reply-To: <20250402164720.3847573-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402164720.3847573-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402164720.3847573-2-irogers@google.com>
Subject: [PATCH v2 1/5] perf stat: Better hybrid support for the NMI watchdog warning
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prior to this patch evlist__has_hybrid would return false if the
processor wasn't hybrid or the evlist didn't contain any core
events. If the only PMU used by events was cpu_core then it would
true even though there are no cpu_atom events. For example:

```
$ perf stat --cputype=cpu_core -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' true

 Performance counter stats for 'true':

     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)

       0.001981900 seconds time elapsed

       0.002311000 seconds user
       0.000000000 seconds sys
```

This patch changes evlist__has_hybrid to return true only if the
evlist contains events from >1 core PMU. This means the NMI watchdog
warning is shown for the case above.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e852ac0d9847..1115efb380fb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -822,16 +822,28 @@ static bool is_mixed_hw_group(struct evsel *counter)
 	return false;
 }
 
-static bool evlist__has_hybrid(struct evlist *evlist)
+static bool evlist__has_hybrid_pmus(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct perf_pmu *last_core_pmu = NULL;
 
 	if (perf_pmus__num_core_pmus() == 1)
 		return false;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.is_pmu_core)
+		if (evsel->core.is_pmu_core) {
+			struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+			if (pmu == last_core_pmu)
+				continue;
+
+			if (last_core_pmu == NULL) {
+				last_core_pmu = pmu;
+				continue;
+			}
+			/* A distinct core PMU. */
 			return true;
+		}
 	}
 
 	return false;
@@ -872,7 +884,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		ok = false;
 
 		if (counter->supported) {
-			if (!evlist__has_hybrid(counter->evlist)) {
+			if (!evlist__has_hybrid_pmus(counter->evlist)) {
 				config->print_free_counters_hint = 1;
 				if (is_mixed_hw_group(counter))
 					config->print_mixed_hw_group_error = 1;
-- 
2.49.0.504.g3bcea36a83-goog

