Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818156;
	b=K9j+H5ziDQ9jxNUbPOO8gtayQbEkIxtQAEkPAcNeyXrRaMSOEkJwHCJk/TT9Q5C037ha
	 60AUSmjDpSeNG3kzVKXbsI8IFpTNe6tgIOyb9+HgcVHwOel77dXXgOLBBnwmt/xu0E4uJ
	 aSGl5mMVQ1mdMf/uA/TNwtHImnaiH6tNARYwShhj05MM3Gk1Cyp4SnPt8vqgivuHtBbkF
	 gdc+qbIPn8pF37RGUvtidjHHoN+Hwbq4QRVq4JYAtVIw1ThPs//ytJTihdKumcZfXWPeY
	 v4EXj73gZA3uMjNBmPxdOtygGKI2iVqxyRzIuNDSbDUttJ1FLsBrRDsoCxx4LahSH1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
	b=Qi93LTvVzdARlcZBm+kTyldpnLsYnTNuHFJDrFEsuEK5G5kyYdo+ZTtgL6/Q6Xwynt/S
	 7SKUQJB6pV4yD4m8fj5+mL04/hetv66w4l4IkuvreLiY1BopdsLDg7Q6tEwXqug+9DZ2Y
	 qHSHw/G1IakZK4S49SHQX2SAaN083Lg16EqvlhgnYLjSWVYzb+5RrmJSEOiLcaPpdCZMx
	 KbpF2uU5zgs+9sbKFwhCEJ4WRajmGpW3HyN+s85YrCCFy6p6jVFHgaNDs4qZDmznW9+Kp
	 Df934XIxl/2EbGQ+kvr1I944vzCSxKyghJz6AnfweUa0G6lqiFpj2DUANfz/5prkusg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mrr0ksDP;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A67606D81C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7A67606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mrr0ksDP
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b31448caccso8477697b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818155; x=1794422955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
        b=Mrr0ksDP79GRmhE+NSytNllRHQddie1qCX/qCdauyOszsQxpNAfOe6hSgYPqC8pSP5
         6kaKBVyy2TOg+H3WfbgO8zR+akkuuKJfvfv+akCm2I3jwzhKAUzeRCQve9BLNwKI1Afk
         A5WPcpysj84im93WrlXI7HKTfU/n67a0U2o7tAX1RpPTB9sPFozFw9q+bVwcqpqD4Lsn
         AydXeqyM/csh+L8kppKKqP+cYZqmo3bGjvUOyQqrpvt+kft//t0HPeQXNf+54Qx/qcZv
         sAWEpXld29UhikCKwfJ1fZytDZNotnVlB9RJ0AQpkU8tZFHbr+0pmUbjGtog3400E5n8
         Vr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818155; x=1794422955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
        b=Qd/PG2PX4Sn3fQ11dfbNQuFOgmG1UYPEDZW7ydscB/7HbC9VOzxAL6RBghjF0mwSVk
         sdS1JLF7ogYfMFjd6y5cOsOtSxwWNKfzfGPKvz6G9SEyCh5UrKLqaTjx6HNLHHQnKp2t
         jXzGTS4Sm2KZdU6uwOMvvEsIMRCq6YRx7vDOiwetn7VkBvTO/wrn7os6WJz+dDfT2qUr
         B1sL7upGKfgsEmY7u4fJ+lBqpYEBfBsWQfB0HpHGxxe7HSMUmvpfo1vH2wx+qw8PHPKs
         U3V0lCv5Y1Nh1AOU2JeDnnUQoC/fABBB1VgNMRoyd9mlfRhsauM/D4My6zXQNN6yHzaB
         UqkA==
X-Forwarded-Encrypted: i=1; AKwUvBzyXtAoCUt1Vk7wqIrtO1RsxPh2eZEIl55Z8+4xX4qVSXNrjeMlb+/2/p6VSH59D5RCGA529PhtP5epdc9yzou6@vger.kernel.org
X-Gm-Message-State: APuU4Z8R0oXa0M8SP3h4wAlSK/kD4eIWX/NYLOPxn7G46YDenpwZUZ6U
	KUdxXkMWMj2GyLLdEkgjjmBr3fKL/OGZ7K95DKxsPLyd2DVRed9ZSosXXk2qPQ==
X-Gm-Gg: AYBFou0TEBXKsUlneAiGXXiiEy4k5K69q0tK6gBhZGsbFgyUrGVK7P9Ts9bY+RuR1lL
	ZsOcy93HsevfWXLQqafI6eg3TJ3rUhryNrfYFiUN1tt8JswMVyZA5syIu1ncOdeqla606jzmS1A
	CMSWyiaQKOmoaJaIenwcbCs4BEn70S8SApY2osisBl0B3BySa51UzYaDEWOQRG9OD6t7YH6GjI+
	+yJPUN6k/cVq10uORPIUksXhVGL4RE/o/DAQYF4ZGiHrPFeik+rQaWEfrWej98IamA6e4DEKVcL
	G8KS27Wc3bK0UUOulrVD9QdO0zT21PwFpAOUIKDOKYmk9BCGaBS4DSvoTc9qgNH9+LA3loYplAI
	YoTLJJ0NKHLff8iO10x2khKDuEf4n7flWUd0ERt41tLwJoDXRhKS6bal5YEscx4sLr67rsQ+XYN
	96VTGV0AjQAHtUoTMNpt7x7WOfd0dzagLrhflKM3LSbttWRGeKxVZM6LGyYkTyU817vcnybdQcj
	rMkgG8/FEYcP2wbFqLqTHA0uejqgbSqh/Tk/Qqd0kKnlkEGH7OZcS78o2FhmHH42/l/dXOsqtao
	bQBrYXOjhsCEpCxQJ9i9YMhHuAZYtg55fgK61Pb+jr+kqq17MliA2uGpcwOkz42WmTqqEL8uU0l
	kQlUAIWViqQ==
X-Received: by 2002:a05:690c:e010:20b0:8b3:2352:cc8e with SMTP id 00721157ae682-8b32352d394mr7107647b3.59.1793818154602;
        Wed, 04 Nov 2026 10:49:14 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3097117b3sm24456457b3.1.2026.11.04.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:49:13 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:49:09 -0500
Subject: [PATCH v6 02/13] alpha/perf: add sysfs format and event attributes
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
Message-Id: <20261104-alpha-profileme-v6-2-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
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
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe16n8cxBhnnZH3cbnpkZGiP+Or88KnnhuOcsZkuPV1
 NFoM4mh4yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK65asHI8Jnh9uUtKZ
 t2zNgbqVChL6fm0//z7DLO1zfuBDwKXXur8izD/wSrg+5cQRfmF7S0Vua2H3P8cobvawHzMcG3d
 QvL/vvEsQIA
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

