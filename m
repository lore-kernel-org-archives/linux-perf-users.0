Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674924;
	b=CpTxFsvH8NvhHW4PEF7bNqWM4EOMLeW5NhiLw3F4kLm/Uko9C+vU3C+G1/liLS5Vzr1h
	 uRan0mzY62gmd+k3vn8vuQaRsKZJSrpKNt9Dr73ytcY7YOFCNRn1prsMsEjl13yIn04br
	 LnympsOHut0zM0vdVAcxbdhg5RtGIjjiehFbI5/E/6TblfJbNS9pHK57aTpu20m0CkG/y
	 uczAB2FWueIlB3Wh2qe6nVcNvNfWH7VGHCRhQ5FBIM1+NKJvJVePRNEf7+0K6f4uIr+zK
	 HU6KEfrd7M9+zTdTlgZ41NMb5oAMLsnHVakafWbHSi4NtzommGlWXQILAHehgK5SgNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
	b=eaqpj3NzuIQu99O+oXevkcmR2LyJe80OvJMwLQDWKgSxf0jw7i8r5rjJiLTupEge8bSS
	 YGto5co8DRFA127U1lNDj4UDNMzZkIKaC+cixLiFW5WoeyPJGi0FhQBtiigvGg199//lT
	 BdZ/BbwFDZoxat3gisg9nsKOhxs5s/ooqJzJXoIBgaY1+PHmVW4qoT+75cc+zj/X6M9Q4
	 ikQzMuz6G0skSA7dAUk73okf0NYrvBlikzXEBxC3YHE8mQqW8NYJBIvS727CoJWybek+l
	 5J7AJtAPWcCGpExsOT9n+aszXstgVcxLpafgGuCOnecpwNYiDb6zCp840jJCW/nqbIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cI+YxjPw;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E313606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E313606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cI+YxjPw
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0d63f60bcso30004017b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 19:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674923; x=1794279723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
        b=cI+YxjPwQPj2Xf957E27Wp+XxIb4yChJzZbZYX8kq66xhBbz2plXjwmpFC12zqpmfh
         MP/ezqfYqBKNlIsQGumTNE+dbj/6fzo9edXGzgN0553QGo0wVdzQuKBRwRMeE1a74/tu
         KrWYNk1IrRxg6P53t7d0isgAi05mboS8HzHK373q/1hrqJc7zo4eo6gKScKmBf9emJWM
         utHAbg2rQjHfMwJN6gbuMQAQnYcfdl0aaJrS7Pa1JKT+5QkzOMNMmGaWwSHAJpmhiavC
         fOZ79BsVJcEqKWr86o0a/Xh8kcIHLPCPizWBrQLQqkmmfRPqmmuKKooS1bkZ/2prHxtj
         qiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674923; x=1794279723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
        b=rMqG0Z9jskVg9kzgbfBauOy/bRuts+F5mICNpCAL2N1JL3/DKvV3X/IJsq3yoDemSl
         44trW7T4BMIrxoKx8oYFuy3DWTTEUv5gLLexko9L1AhaqFG6hEVUBBUBa8VdhVzMM5uo
         DjX5fkTUqfIWKMhy2+OmJ68NjEdFtGDVtONwGU9PYiJ52H07d4xCVPulAVqsRHoqWkRj
         5EmY93+nmAXzNKfZ5xmQNfUqJeZQb+sJRqpjXyExhw9QTT0tRh5qN197bTEfr0G2zpzo
         NaUq7EWoYtrdRkXv0B9TRhhiEvPwFRG1K4AyDflskGX2FQ8GTuclFESSllGaMERcy7lE
         y6vg==
X-Forwarded-Encrypted: i=1; AKwUvBwAnHfFHI+YtQt7UqtyxFhMMslx8shX0vnQq+TrkPyAMgTNWzDw45BPasA9i+4VE5rSGprmOPJ+Ji0JEj4wFLka@vger.kernel.org
X-Gm-Message-State: APuU4Z8gddrUVFSrH1vJsq/IAayno5dlKqmKAcdJaAbzXWv6hKVbBWzv
	762bJaW89+QbsFJHiX3gC0VJ0ORnywfto+5cPYT8YnDgyIBZ1fUB78TZZp7Nepyv
X-Gm-Gg: AYBFou04VvGl2RONg/O3IafqOhT4j946lB0rgd9LOn5VwhuHfAEtR3zRnro55t0D4P6
	ZLJI3uZNYjatLiGjkOWpRy3QP/0Xut7toVrHJfMYUa09euAP9Y+RsZ08b8lp9qUZ8afdUjVOrn4
	qJeQtB3UgFWo5nzjuMYqBacl/ZNAdX97NZJCJ8Ua6w67Xj917dPTn5I5c0ZUY5j47BiVD8izlaH
	keElahDaVK7NpFcWNoqZiBuAzJnN3313lv+pxnldFwEFXOar/RfWFjmBHaPmYWPskhC0SlTshXk
	OtHaoIqmOcdvD+msCeYsdWcd3PBxvvZ/4tQLs4t+YqrqeMNVzwQnxKo1HwrE1n4e0o4fkeAc2oT
	p5sSOLKIOv27re5ZA6h4PFaqb2dnYDyksiIdmDXsiypcJ7Lx/61gcmQuX5nxdWdFb1n7G4tVEKh
	C5yxs67rQywfED7zowD9cFVS1izAVBVwIXF2u/hes5ulpEB9Y9p8A70RjnMT+f57KLulPKJMC6X
	yEl0yf9vtUcgeI5jXgl+H0l/SxEXRnyQGP6GNPFcEF0u+YzcT13hlbAxpS9B6aUnhMcVCjPU94H
	hSARH/X+51gctPZ1SAPDcl+OYZUmkRUmp7ckLkM2WUK8BEwa9Pv39ntkwYIJnkG/+fHZN/ehOMC
	F+CemGgzGkA==
X-Received: by 2002:a05:690c:c4e5:b0:8b0:8b34:ede3 with SMTP id 00721157ae682-8b2b6594f0cmr82898097b3.3.1793674923045;
        Mon, 02 Nov 2026 19:02:03 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704d699sm64247177b3.5.2026.11.02.19.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:02:01 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 02 Nov 2026 22:01:57 -0500
Subject: [PATCH v4 2/7] alpha/perf: add sysfs format and event attributes
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
Message-Id: <20261102-alpha-profileme-v4-2-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
In-Reply-To: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=nsB8jInGhmdIwF4AteMUmNQCWwgxX1qv6DhmPNtskC4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe+i3+9Pn5Wi+fGY8PTw9ZJ53Dva5N4K2M/4clx5bbX
 TVbo/HtXcdHFgYxLoaZYooscesVWWa17Vjqc1r6F8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6BjFQ+T0GDQyi4tLU4t00wqKHPLySxJLMvPzivXyC1LzCtIL9NIy00oyMvKLilOBRujlpZa
 Yujq6GRkamFg6Wpg5WTiamjg7Oxk6uTk6Ors6GVmamxg4WzqauFqaM3BxCsBcw/2RkaF3GeNkHf
 3nx1Vu8z0/WbnvyqtzdnNfaZUkvT7EWje/+4oEw/+shSW67a+jnQ/O+C7WMf0xc1hXDVsIk3N+t
 cKdxRlvJ3ABAA==
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

