Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561291;
	b=N9HTxSqbsni5NByyJSZw3Y46+yGUMetrY3rFBrL9j6I+1B5VjrAK4CQWOYQJEe5fLhBQ
	 I0/WJwJRBCII8PIiYQcqD/JdgnjY6xKOrkVHVmfJdYomsUzfRN6lp+V+2QNQ/OUJh9hW3
	 SvNbIyHYqHWJmhNVtWbf2dnhb7hncAsfof84G5O8XIi4GObDOUwEg2ndOnmhCqVbW/Vlz
	 2RSDs2AeOth4KHVDs3NYuqMpLDE7mV8Evqr/pBGXetQPDtGpAS5D6MseDxbTwAjFRVOE/
	 iTelz0nNdlJVgAUP696t79g9mH9ix2Pp0KTnIrTJg4zIK4D3FydvTDHDrtRCCdOxM8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
	b=nfAf0Ld5XPdnPd3CPJaVH7tTTGdjslyX7vwHQtc81oh6PgwdtIi5sg5FuRfE/PXAqfbP
	 cXF9hAbYJoL9NeyUMTWZzG0Pw6zpXjiTMgVUbXAdTOShzjq01kB6MRoeT0w6F63jP9qv3
	 6MYJAlv5DwN70OxbeAENxIgIYZ7R73tJkcbGUdXPT7skXX+nt70B4OP+08h35tkymMXFG
	 QRorL8lSTdajg/JrbuuAze/yiwokBXAcKDDtJg9p6GMXZNK/kl5Eqvc9PqJ/9AErC/ncM
	 30Nt9ddhkTKqBhs6Hmg/q+0OpH5WiyRGesf/Y53kNxjb4oy/vMq/fCTTv8icojLDOeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iu5NFwRt;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F3606A337
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A2F3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iu5NFwRt
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ab43af5e97so24826437b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Nov 2026 11:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793561290; x=1794166090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
        b=iu5NFwRtmJYrFvn9JNU/9uakhYFdVOgLX3iENODjW3PRn7MxLmuhkjz4RSgPlaQknN
         Hnf7aGqHK3Ae5vmg7/yO2zpjArV09GY3Wm3mnuhMqsPgydPRs0NolFhRo4sfZ/b3iRsH
         PHAWt3Qj8oAiIpyE3bzbMAT9ettQL4YyqU7RsUI8p2DlROgS8MOxdSGMW74AK/yZFJQ6
         xjIw+LspWHK6Y9lhOTlvgz77Y/8V7xEDZEJlCRXOHYoGH0JgAl+rQPf0rSqRV81UkDbh
         4zZw5rkOwSwbxp1MfePfrdBXKx601wAdn9nflCrdT06raeBHcOJyyBlJxLOoL/WmrRJE
         oAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561290; x=1794166090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
        b=npy2qQ9KDLUAyi0r8hj/qcXI1QckicU/0+zzoQ+XBtkGnhK+t7l6fBcfEDiomKuA5v
         tQF9K9n6l3sGkNqfwx9gKcatfu1Ma1xtx+8qEJ7TGqXUQEwwNLa1c9sBXlU1eyaNYqmZ
         N7254F2xc0Tkb7zHwjKIrkI42RsO9nFrbnf1jHZVgcEeLmmNgM2s1gK7Q2v4CpL7qvdJ
         STFq0luP+9MwIR+A6oq4h6Vbt/wn2a+LmYh8L13yFbnOfeFBrF4IxwR8Wp3rJJsuP0pA
         iavAPGkZ7tNLh119pt+BgFHnm4oFbCwMPP30UfRgToktOlGnAuKUEGOASYJlJvMxYTgE
         vWAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHwbeW/Kyi+7M6OXJCk7/KTwag+0mYrZgVblxj5ZW1d7Q8CbukGV5pc/6o4WM8J6882lkg+UTOyDPRs3nhD6v6@vger.kernel.org
X-Gm-Message-State: APuU4Z9Oaw92mO5OVa2YTR/Nm/N3i5+hXkS79N1AYJCsOFsGP9HmARWH
	2U9pIjtvUp3365x7VJfmOz4ropSwBcDerFrdhC2PxE6KKU7mb4tUH0Wk
X-Gm-Gg: AYBFou2Fd2w7zk+S3u/oMlS+t1eYCunJ3evmApQcc/LPISqg6Xf24F/WhN53WrQPeu5
	2W3SXNG9AQAuypVnaxSMtrLfaapQb/WgBaZYsYDNsQH9KJzna9COfDDseOXq34mMxIJfQ3Pm1TZ
	iXEBG1k63YuZaAXr550Bsg8q2D2BdYAYBBLwJ/G94Jb82xWTTSgtAGAvukFS01UR1czwJ/AaCwH
	nGItuKtXB2//3JXh26olvHMqIOOEnrrIqTFBQDr4rT20h3NEvSJXkAqgGQPUhDBW9ytLuyRRinL
	z1h97Kjzk2x8vyzu/QukMBQHhJqW+3PAe1ap07K7BVgGJiVHKhfpt1PaLpFB7ZlFlL4x3hVpQ//
	KqzEgiV7j2K57p1SwO/UJKeIHnLhtGUW2CCcVW7/AA9cYIDUkuJ8SMZtIUQgRcIsw20pL++LUyr
	aqp/h4K5DFC0UMSgeEkbqWcLaIkF/CJ2GfKT56AZjucHhqln8faQ9vlRobc1dbLuv1vydwxwAo9
	F/7tC2GpM5sHKL9LgHLOzviVgk83zcegqs5uun1UrJ/HbJIV5YVhVFG2Lu9S6a13/dsCGdzSTOQ
	yii7AyNHl6RkPC0tWm46EL7eUa30vTuYERbRw0Q07JtWF4Rwid0txdPQiASsEGJ/FQUOcjkvX3w
	1ZZVW9EvCWA==
X-Received: by 2002:a05:690c:c4e3:b0:8b0:cdf4:94ae with SMTP id 00721157ae682-8b2b65ade50mr58685557b3.3.1793561290282;
        Sun, 01 Nov 2026 11:28:10 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b719d2d5sm39894247b3.40.2026.11.01.11.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:28:09 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 01 Nov 2026 14:28:05 -0500
Subject: [PATCH v3 2/7] alpha/perf: add sysfs format and event attributes
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
Message-Id: <20261101-alpha-profileme-v3-2-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
In-Reply-To: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>, 
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=nsB8jInGhmdIwF4AteMUmNQCWwgxX1qv6DhmPNtskC4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeTzp6dmHz8k+MMTLrM16lTFlSqpJt2qJUWqzh+rNpb
 sB6Lpv7HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNN1jtGhncnG2dvu8
 LC+/31roxt6pf/BS7d7Fwwf/GdHbW7Vrk8S/3E8D9t6QTuY5HLdU6c5erhW7php+W9v1+rvwkUN
 Pd52Ncer+EDAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha PMU registers with no attribute groups, so the perf tool has no
way to learn the raw config layout, and the PMU's own events can only be
named as raw hex numbers.

Describe the event field in format/event and export aliases for the four
EV67 event types. mbox-replay has no generic hardware event, and can now
be named as cpu/mbox-replay/.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 2d9383425357..70840c05d39b 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -212,6 +212,44 @@ static int ev67_raw_event_valid(u64 config)
 };
 
 
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *ev67_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group ev67_format_group = {
+	.name = "format",
+	.attrs = ev67_format_attrs,
+};
+
+/* Values must match enum ev67_pmc_event_type. */
+PMU_EVENT_ATTR_STRING(cycles, ev67_event_cycles, "event=0x01");
+PMU_EVENT_ATTR_STRING(instructions, ev67_event_instructions, "event=0x02");
+PMU_EVENT_ATTR_STRING(bcache-misses, ev67_event_bcache_misses, "event=0x03");
+PMU_EVENT_ATTR_STRING(mbox-replay, ev67_event_mbox_replay, "event=0x04");
+
+static struct attribute *ev67_event_attrs[] = {
+	&ev67_event_cycles.attr.attr,
+	&ev67_event_instructions.attr.attr,
+	&ev67_event_bcache_misses.attr.attr,
+	&ev67_event_mbox_replay.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ev67_events_group = {
+	.name = "events",
+	.attrs = ev67_event_attrs,
+};
+
+static const struct attribute_group *ev67_attr_groups[] = {
+	&ev67_format_group,
+	&ev67_events_group,
+	NULL,
+};
+
+
 static const struct alpha_pmu_t ev67_pmu = {
 	.event_map = ev67_perfmon_event_map,
 	.max_events = ARRAY_SIZE(ev67_perfmon_event_map),
@@ -761,6 +799,7 @@ static struct pmu pmu = {
 	.start		= alpha_pmu_start,
 	.stop		= alpha_pmu_stop,
 	.read		= alpha_pmu_read,
+	.attr_groups	= ev67_attr_groups,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 

-- 
2.55.0

