Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333052;
	b=QhS8Al76lFEu4hJkFw/QpCbHcsKr6giypBZILifCbOVDJ7D+Ty/YhT/sbjw5J/6QlA5e
	 GakrZ7+akkhFgMl9gq1MnqbVSB9iNShN4vIfLLxnHEbiB2EC6hub7/E7Mij09MPpXa/rE
	 NHdXbtYQhKKySMNzEQmE9f+YwwFLdqetKrvZ8OQQSEyuQRFKEcgSTEVyyB3ymGRY5r/eH
	 11ipf2nvj0SKgM3yyTNVlGCbBUfuaFhPZwJZLvcsdNEVIrcMG4II+irmdEhpvOigMkBMX
	 6WDlyMQfi2RXp2It+POUy53pHGH/KJDROoNwLQReqO8eG1fadZAlCfwNgalK9AQsB1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lNqmpGtTgW9fUJol2Sbmf3JaAFwyCUvKXpRbTU4nX5o=;
	b=lbbkKjZYZjPJpkTYGioBWo1wr7KNnDxeep4d1xxOIlFNcxpb2MTos1aFuJbJLUHPVOI0
	 56sLbIExwZ3NQZCeRz1lTfpZbmb8cCer083mc3ZWC2P293TEHGhsHQeyXrxNsf6bNGEfh
	 nHzfAd8lQWWJr39pYynTNHxxbYKlrvIRcVtTuM6nn6ujcNdUzYWCj+tUIkdPW01edVfdB
	 HM5tFktinOnFU03rl03G6a2oPG6JE+1UxNVRwo0PcaANnQqZSLHr14hF/RHypNhyXxE3L
	 GCraLYHwBQu5na8d1tfcF5URR50Y68K/Jq7HohdedZ9GPkwetFnoTR0bfUQZDJ2nBYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3pKE8Mk;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D6606A33D
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A7D6606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3pKE8Mk
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679334baa1fso259246d50.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333051; x=1793937851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNqmpGtTgW9fUJol2Sbmf3JaAFwyCUvKXpRbTU4nX5o=;
        b=o3pKE8Mk5lLoXMN8tyFjew+zoik7KSYUndCtzpeYTexQYSJ2fBZ4mQhkpISh+08wMH
         hzSrOYsCv53Q6E/c7K44HuYsOr0EQ8DidRsIXP1GZWdc/5kDCc3lQG8VAFAxpeR9S60Q
         P69+G9xmVFaMzAfT3+bm0GL4RmWgKcC0vLbSie9S1yukd6vqeOuFq+JF1oIEvq38nZp3
         JLhHNf1NKIxif1aiFVOlUYGKxU61Sj2JeHcqVxkljzfjGCiGeIODJ/gsuMH93khorrfD
         gw5iJ+WXdaK9LlcL8O7geZeJGIMr5gc8NJ5FGYacWxyyuqnX7oxDGnn2zuCuD+msuyo0
         m2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333051; x=1793937851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNqmpGtTgW9fUJol2Sbmf3JaAFwyCUvKXpRbTU4nX5o=;
        b=So4a+rHF5dgT/3tW/UNm6BVSLQJ9/qQ+J4JntfGFiQrKB5YBFMOfTDpdxkbH7haKos
         oVEOqHf3DV9RBdHGcwMe746ECUzSQE+3dxpAVjpHlP+jBkNoqPHp+WBCZFDpzlpxuUeF
         yElZQ/y1nf+Oevs+//rCKg3jeax5j8WgVNDnRRCN0mTNaoItTQrPDLh66BkVu3OHI0ET
         4nmP9qprRb48Mi+NTbxUqif6RnWqmvLsr7InJVaxnqwnfAzlGokH35dU/85QVbZTwJ2w
         S5UQUWS32pnpT2osP80ARolV7VMvUVxBR0x9Dx5DzSMB+NlS76DvEYYKL2FtQfZ8w2gB
         qlIQ==
X-Forwarded-Encrypted: i=1; AKwUvBydzVOMkqXwMy+PBThQ1/dHNtWhUWG54sZ/YjOj9MPOcdYEEbPDYkfVC2OHxVFxZLirfXWOx3Sen3W9Qj31wQCJ@vger.kernel.org
X-Gm-Message-State: AFq9FYLgnNA9cVy65ukbl4C0nznCmhEzZMi9eqAeX2AZCHISm9x8ejGt
	qy8aBbkY7mDb0iWvToGplhV5FMrxo3cf0itHd7GDBIwbNfDG/RSlknJI
X-Gm-Gg: AYBFou0PQVTXp1lHSrPk41ihnsAdh4BHgE3BfD7OLxqoecdOdDnV755RFvfgWv3abRe
	QTyYGdwngTj6Kci5LjDF2yWrru7TUTB20KhTGQy1LgW7RNrJZPDbkkxL7eJPk3UhwKXdBh1T6Pn
	5nxcGrCcPC7jlHrXu13UVlBZzVRnhZ1/6BEswyyaGA0BlSDVHJOlqKzwzFEwwJa1BUQevdpNFR1
	sUoAHGYFfmUF4xAT0JOvTUazlEAt0fZXyQLpLOYHJL38Q+vSA4RSxm5SO2MOVdSLLCg2dVBrIMU
	xyx+4Za9s+m1ekyexKd3eFxp/nYpUVdSPpUMZL9W0BhMALSMz2ksB7wGCaGwx9WnG9lXxglM+Rl
	x5dGojYCvN8JUeKJ8PzmabSIXDlV6+33/ydpEcXoqKM3j3gFBF/nedwR1b2w7key8EXhxkubeLn
	MISQsnX5fe2VaXziJ3gMpcSRp8TvVIHJK3ZM/lPP3s4SGjEoilfepKUJpwirAVNS9LsyzfQAnO5
	zGuLCgmc9dlLHGng53W4edigSpEmTp43Nihwdyy0tYajjVvl6mOC3NSwDYS7H06G9qs8VC/OscH
	3fNsN1JqEFHmEv8wI1ZpuNUxV4fFflMt6RDxY35fYGxzkjfoW7jvybv+QRH97lm1plagHnZAFoe
	FVzlQOpuqdmRPE6XLG3hVGRtXDvfhXkg=
X-Received: by 2002:a53:c849:0:b0:679:aa23:415e with SMTP id 956f58d0204a3-67ba502ce45mr538074d50.87.1793333051349;
        Thu, 29 Oct 2026 21:04:11 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba7514e84sm310708d50.16.2026.10.29.21.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:04:10 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 00:04:03 -0400
Subject: [PATCH v2 5/5] alpha/perf: optionally randomize the ProfileMe
 sampling interval
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-alpha-profileme-v2-5-c702f1c65272@gmail.com>
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
In-Reply-To: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4423; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=k1TKL1tsmpw+6SouF+Nkc9CqghjK65hgxaoQW1zZB34=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeiOv3sUVzTfoceWLxFj7mw8c2O780YnxbnHfx1vLXP
 4/nnJizueMjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCuWb+XkWF904sfLH
 98r1VPTV5zSPmC4P3SJ+I5utVVFw7p8Xbf36PC8D+zsLjPOlX49y2DXTsE9A+cObD+TtXxO1ebV
 24pPX8zcxsHAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

A fixed sampling interval can phase-lock with a loop whose length divides
it, so that the same few instructions are profiled over and over while
the rest of the loop is never seen. DCPI avoided this by randomizing the
interval.

Add a randomize config bit that varies each interval by up to 1/16 of
the period in either direction. Only ProfileMe events accept it, since
Aggregate mode samples already land a variable distance from the
instruction that overflowed. Counts are unaffected, because prev_count
already records the value actually written to the counter. The jitter
is computed with mul_u64_u32_shr() and the sum saturates, so that a
period beyond 32 bits cannot overflow.

The jitter comes from a per-CPU prandom state rather than
get_random_u32_below(), which takes the batched entropy local lock and
triggers an invalid wait context report from lockdep in the PMI.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index c9d4b13817bc..c553cbd6c7a3 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -16,6 +16,9 @@
 #include <linux/kdebug.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
+#include <linux/math64.h>
+#include <linux/overflow.h>
+#include <linux/prandom.h>
 
 #include <asm/hwrpb.h>
 #include <linux/atomic.h>
@@ -33,9 +36,11 @@
 /* Layout of attr.config for PERF_TYPE_RAW events; see format/ in sysfs. */
 #define ALPHA_PERF_CONFIG_EVENT		0xffULL
 #define ALPHA_PERF_CONFIG_PROFILEME	BIT_ULL(8)
+#define ALPHA_PERF_CONFIG_RANDOMIZE	BIT_ULL(9)
 
 /* hw_perf_event.flags */
 #define ALPHA_PERF_FLAG_PROFILEME	0x1
+#define ALPHA_PERF_FLAG_RANDOMIZE	0x2
 
 /* For tracking PMCs and the hw events they monitor on each CPU. */
 struct cpu_hw_events {
@@ -59,6 +64,9 @@ struct cpu_hw_events {
 };
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
+/* For randomizing sample intervals from the PMI, where locks are not allowed. */
+static DEFINE_PER_CPU(struct rnd_state, alpha_perf_rnd);
+
 
 
 /*
@@ -246,10 +254,12 @@ static int ev67_raw_event_valid(u64 config)
 
 PMU_FORMAT_ATTR(event, "config:0-7");
 PMU_FORMAT_ATTR(profileme, "config:8");
+PMU_FORMAT_ATTR(randomize, "config:9");
 
 static struct attribute *ev67_format_attrs[] = {
 	&format_attr_event.attr,
 	&format_attr_profileme.attr,
+	&format_attr_randomize.attr,
 	NULL,
 };
 
@@ -367,6 +377,22 @@ static int alpha_perf_event_set_period(struct perf_event *event,
 		ret = 1;
 	}
 
+	/*
+	 * Vary each new interval by up to 1/16 of the period either way, so
+	 * the samples cannot phase-lock with a loop whose length divides the
+	 * period. The count stays exact because prev_count records the value
+	 * actually written.
+	 */
+	if (ret && (hwc->flags & ALPHA_PERF_FLAG_RANDOMIZE) && period >= 8) {
+		long jitter = period / 8;
+		u32 r = prandom_u32_state(this_cpu_ptr(&alpha_perf_rnd));
+		long offset = mul_u64_u32_shr(jitter, r, 32) - jitter / 2;
+
+		if (check_add_overflow(left, offset, &left))
+			left = LONG_MAX;
+		local64_set(&hwc->period_left, left);
+	}
+
 	/*
 	 * Hardware restrictions require that the counters must not be
 	 * written with values that are too close to the maximum period.
@@ -738,7 +764,8 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	} else if (attr->type == PERF_TYPE_RAW) {
 		if (attr->config & ~(ALPHA_PERF_CONFIG_EVENT |
-				     ALPHA_PERF_CONFIG_PROFILEME))
+				     ALPHA_PERF_CONFIG_PROFILEME |
+				     ALPHA_PERF_CONFIG_RANDOMIZE))
 			return -EINVAL;
 		ev = attr->config & ALPHA_PERF_CONFIG_EVENT;
 		if (!alpha_pmu->raw_event_valid(ev))
@@ -763,6 +790,14 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -EINVAL;
 	hwc->flags = profileme ? ALPHA_PERF_FLAG_PROFILEME : 0;
 
+	if (attr->type == PERF_TYPE_RAW &&
+	    (attr->config & ALPHA_PERF_CONFIG_RANDOMIZE)) {
+		if (!profileme)
+			return -EINVAL;
+		prandom_init_once(&alpha_perf_rnd);
+		hwc->flags |= ALPHA_PERF_FLAG_RANDOMIZE;
+	}
+
 	/*
 	 * We place the event type in event_base here and leave calculation
 	 * of the codes to programme the PMU for alpha_pmu_enable() because

-- 
2.55.0

