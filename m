Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED1378D98
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529508; cv=none; b=RTHpYc85AsGvr59Zri9s90+8b3oh2p2pfpPRJWPbqzKfC5lxNiqtdQ0Cotfkcbwh7m9XuZ0ajL0539Pfjwr0/mbCGn0bv2Ow3xI6+XOykkGZ4VEHGlxAmv5AZRUCXAtTx6gNzYOdY6WZ1CZ/LP+tpX5grPNrcmkCq/c5bHgqz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529508; c=relaxed/simple;
	bh=ZzB4cJjh2YZ15PoZXeoA3YUK98wnJnoSQhdUo5kZTQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gy2njCPrU/YADjDenXUKHxrajfkTpseTEAlUnxH6eAueQOYYZ39ZFNC7TTnPRCp82rP7XDaajdxWY+Qrt3Dr6/JclcPXorW0AgM63v3lvCJYPJrZ7bROIG0CJWgB3gdkEqexqjPo4RfSNuzyZ95KCoOmUDW0TB5QA0lx3exrLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YGzC4HbQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YGzC4HbQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf452def93so20089455ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Sep 2026 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788529506; x=1789134306; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AUtU0AVCxf0g+bF8SriUie/TsgOUIfxYtjr/CjWgxZQ=;
        b=YGzC4HbQrjs86eyvSI3Yl9b4OkyvHapQ+Xysl3Hk54YpFyX511+X9dPULs8oSjI1iy
         Ut3b6LbJnA7BRcgh5znc1ZHlhKJnBJ7TA+TzHx00t4PUNhPvHrI/6THrCXjhOHt6qjgE
         KdBAg4N7Bu2jFWQSKeAmFpGq7J97mK4HirZmprIMlPODhJEr4j55JcmQT23hQtp6xRb/
         3EWM9/bicm+Uiq++ZEh3wJ47WGRoEb5QBrqWAz9tMvc62IO0T2MtDL7CmhayHtkRUFdk
         1pLsSNqfYL/GWNeVh7GsbWj3/aG3pXTlV7bUq2rF+wbbN3PBGWcmx8Gdy+MDVSoaOIdz
         2OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529506; x=1789134306;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AUtU0AVCxf0g+bF8SriUie/TsgOUIfxYtjr/CjWgxZQ=;
        b=qwO5h0fT/belbSigaw4FhyrDE5SiyB72gaL81tS45TOKSvsWC0PYjDda1bmooeYkv8
         pseNIsJbHvbKxpRCZoipPgew4DrsozW5y7rRhtzUpZAC+8WeLaofdNaIDjkOV9Tq2ARF
         d+iqxbYzg9ZO9oaBOEvExh2WX4VyfNldHfcRopeqwflGAIwfV3QbA2ag0g/2U7rMR42j
         aT9Sw1wRyULJdXzY717ayjldUw0SSXCpWGkZB80NopBCosuW6Xi3mrkVPi1YOtlP1hsf
         J307Kg0cloS0Zp4sOSg2BNCE7Iek08nmnrqwRjKMy0GDQe1rEeH+00PIX71CxVDflkvR
         Fctw==
X-Forwarded-Encrypted: i=1; AKwUvBzM4P+yhGcDYZuqz5gwo12QklJ3W0d0zNRnionIlZAKK6vlfKotyc297xN5t1Gp4qRK5Zv7psRpz0pceS3NTU2D@vger.kernel.org
X-Gm-Message-State: AFuF++nZpkXZ9xVpTxbgX6Lt4yBNBT0/ptaYpNOX5T7V++JAIOb65ZpN
	xKHXKvkoSN0YbOVYZGVzelc0HVEUHy6v5iK/nitTUIy2RE1cN4hJQIRwGl2pVAbalvEBRDa3vGu
	kIHcIoTI7PQ==
X-Gm-Gg: AYBFou02VtpAyKyBmpeAJDoIap6ZzKsdvIDdzIe/Edql1r6wSBNQPi7BqcTYAeORnCz
	mJyutDup7oz2/RBgtOb9GmXSUZsGjQvkvHKPMAqykqY7o6Yh/fif7YdtJi6FGE4UJCrBY2RAQ2b
	kT+A5X1vVeP4X/oVRxXWpsQl9BsxU9vaAUD3wLiO1zy/QH39BZJpFm/YB8jvfEsI5J53wBeHwLX
	O822KRCDpj1OCG5tZ3/Y8aevzvnyJ1jA1fnv+YM4yintjlwTh9yT5C90E23oiym9LMaRcJ2mmLw
	05241H02nBz7eoqhnzI5qSOVVNvpv79QP8K840FH0kxlYzRHjnDi/QGFkGAzVyEXktY/gykwhtx
	15fH13b3WfPXJNvngaBKa1LvAUoMo8JXw2vVBUDvqsEUAGL1mNGIUO4kBrRxfkzmQusDQjlMbPv
	RNImghrPLC505fxBSNN/EucHTX7ssV2JUziEipMiBSmpKlofIgTJ85xJ7tuF4xdpsirtf3nBI=
X-Received: by 2002:a17:90b:4c4e:b0:38e:a52e:a3c9 with SMTP id 98e67ed59e1d1-39b07fe9dd8mr14830129a91.8.1788529505989;
        Fri, 04 Sep 2026 06:45:05 -0700 (PDT)
Received: from sw08.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534152sm6834306eec.10.2026.09.04.06.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:45:05 -0700 (PDT)
From: Nia Su <nia.su@sifive.com>
Date: Fri, 04 Sep 2026 06:45:03 -0700
Subject: [PATCH] perf evlist: don't restrict uncore events to PMU CPUs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com>
X-B4-Tracking: v=1; b=H4sIAF/LmmoC/x3MQQqEMAxA0atI1gZSKU71KuLCqekYkFpSlQHp3
 afM8i3+fyCzCmcYmweUb8lyxArTNuC3JX4YZa2GjrqeBrKYWAPyvUs+8Yr+UEafLnxbtMYtgYJ
 5eUdQ+6Qc5Pt/T3MpP7m8fe5rAAAA
X-Change-ID: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nia Su <nia.su@sifive.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=nia.su@sifive.com;
 h=from:subject:message-id; bh=ZzB4cJjh2YZ15PoZXeoA3YUK98wnJnoSQhdUo5kZTQ8=;
 b=owEBbQKS/ZANAwAIAYihNJa3+YfgAcsmYgBqmsthAKuYn2tcMo57yITZ9AHSBIITrVA8UueLM
 nh/mN37t86JAjMEAAEIAB0WIQThGl/T4FqBBU9NhIeIoTSWt/mH4AUCaprLYQAKCRCIoTSWt/mH
 4NEXD/42GlCi/YxiAy6dR7WafgLocFvabPf8yzORrMalaNSXkKbWVDLqbhFnm2VLfue27aek8FP
 IvsXJHYaJO4vFd0OZQDhD5DdZyHO3bu0L65juIi6KvVE7u3h6tWwsBsZKJfkH0dc1DUbp0CBoYW
 gQF8BUo3QEQpj82kfO8+ZGGiAKw787qyngGy2XtHNyjWWhbZMXRC0NhLnthRXr6gqIKS3qZ+vaj
 +EbHpaes1zVSFKbMTMLwdBChRp64Cv0pvWFm8isi7AzdBFIlb8Z/1oytmKEoezTfBRqhZJ91YwH
 k+fBWIiXi00Q5HZ5yP6x3Qv9kamsT1koFTH+T4Xo5nsU+QnjnybZeusfBQIZZl5a13ggmCI3ATR
 hsMqcs1OyYmyIEL9a433sNzipFt1VYcEe6lXSV+r2xJQxuH7k2xqzojux0qJgeRitFdBcGkXezh
 N6GToeyroC4bQ6PIGDvermFqlwy7rFw/nDys4pwkqI7Y4CTdnJazcN+ctiOvjXXVmOZMhunk+jn
 J+1tc7w60Xpuf4Mq7cXTR1d0nFFxU06b/sUJnkiDp+j1deJqY1RWBsnlqHnieFJKTtclvrwNSYc
 FtBiiTg3FDuBX1FLRsSZdK+A+eoEXpBWa9X0caCe2Zc5jxEENHHmdTi3+KnJz7coZI2zg8TWQlf
 nMGuyt/gKiBfU3w==
X-Developer-Key: i=nia.su@sifive.com; a=openpgp;
 fpr=55235C875092ACC578EFCE6CD1699E646B29B1AF

The PMU CPU map has different semantics for core and uncore PMUs.

For core PMUs, pmu_cpus contains the CPUs on which the event can be
opened. Intersect the user-requested CPU map with the PMU CPU map to
reject CPUs unsupported by the PMU.

For uncore PMUs, pmu_cpus is just the default CPU to open the event on,
not the set of CPUs it can only be opened on. The user-requested CPU may
override the default and be used directly, and the driver can redirect
the event to the appropriate control CPU.

Currently, __perf_evlist__propagate_maps() intersects the user-requested
CPU map with pmu_cpus for all PMUs. If the user-requested CPU is not in
pmu_cpus, the intersection becomes empty and the evsel is removed before
perf_event_open() is called.

Skip the intersection when evsel->requires_cpu is true, which is set for
uncore PMUs. is_pmu_core is also false for other non-core PMUs, so
gating on it would have loosened this check for them too. Core PMUs
continue to be restricted to their PMU CPU map.

requires_cpu can also be set for BPF counters regardless of PMU type,
but only when has_user_cpus is false, so this guard has no effect there
today.

Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")

Assisted-by: Claude Sonnet 5
Signed-off-by: Nia Su <nia.su@sifive.com>
---
 tools/lib/perf/evlist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 1f210dadd666ff818a23712ab95acaa659ccf8dc..a1064175f12ba655a9f7fe42e7c7e4c49ae60423 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -80,7 +80,8 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 	}
 
 	/* Ensure cpus only references valid PMU CPUs. */
-	if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
+	if (!evsel->requires_cpu &&
+	    !perf_cpu_map__has_any_cpu(evsel->cpus) &&
 	    !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
 		struct perf_cpu_map *tmp = perf_cpu_map__intersect(evsel->pmu_cpus, evsel->cpus);
 

---
base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
change-id: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80

--

