Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738263;
	b=bsn1iN6QCSGYtXu+pvsUIBTgeYou1/cQ3Hzf/DO2FnEDIjRPuGUZprvlbbiMSQaN4f6z
	 6YbccwTvbQ6vhQLVvR6ILeHbUxmOgds83bOxCJYj08lKYcA4DYtzYYcCGBbV6YOIU1AB/
	 Gi4SPVJ5oyHfCkpghzreXFzobVQ6dsWvTE1Wr/YywNFuF7hQrNbCy3t9iqBcCmbUMopTM
	 sAadD9IuWzBJO0s7eLgPP0vMmQ0UT6yTDald72XY4szG139ppPeGjAb9j8f+UgDyt7wN1
	 Q5hAJkfZCioM+OtrafMuju6LLdTCOqo84tIfjSyH0PC4dPEmqj1doTgy3cIHcEPY17g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
	b=iE0n8hPArwOdiolKMSvWQqsnQB7J58qFrW9xQpExNxdrUTPbTt2OzluG4u1XEyynxO6w
	 fknysvvH82Wqqgj/1N+7LyAumGiCIMZIpuRN1fXXyv4C76Y4jXQM2r6rdmCxIuJIHRvxp
	 5BkuQQG4QTDzu2CvStc8rD0EFc7H96kYxsUKAXG5X25WUebKEn2UmOg6UrgUqCY6XallF
	 ykrvm8I5QUik7Uioe73bp96JawHCEZZywvvVbB8SETOPoP+mbMsDDsLm5Xc5UsIG5dveh
	 81mgSjIIPS4FcHoXo5lMTAzkWXOt47xN/3sMIPUja0xkQes3e64MjpxEgD+Sy5BCm7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QGcRxCyy;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08229606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08229606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QGcRxCyy
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b06c0794cfso212647b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738261; x=1794343061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
        b=QGcRxCyyZavan20f5rvxAWpjP5dMO+edega1ZNvy0t3r2u7NIHu4hCiIjT8Iem2wal
         DrDLn1GPE9cxjl1ACYPPWmDIVAnJ/Kwn5FoXkh3Sivz9cIKfrVEGKPOoO+h8chJxBaxD
         dwm4zF9hNBNw1beGJ+46KGxTB8oXtXr7dOsFQL4tkkZMlrrHpWBglnJJwYVD7Hzwa6ia
         BOISDIbw0tP3NloioPoXBFLgvSieDVKzKlmVHdtZ5rgtR2ZWZnJ5hYcuRQJ0rUz7sbyF
         cOitetx4j0n4K1ZDoxoplXZDCC2B334+8zo+zSh2oRaPYDCf2ovOYeIMT8fwjLPRWjw8
         7o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738261; x=1794343061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/6UJdmTXHa5CFtPmZ35mg3YaxIUiqdjrGgBWpPFHWo=;
        b=Np/T1l6FQBQzgW1k1m6SPDE7TqDluGwoYcHRnEwPIF/shXKglLUzj6nydIzEuo7bQt
         hOvYQmlRwDJMJhMdyqUxCEdQJzYcZzLRaupgWa7GIemXhO5iRTOoz4dkv+GxpAumhhpP
         Wh/jlmWEdO07E1G9m/pLYYgnFWLlIQyXiDK5xk87ru9pOxS0zB0sIkCcB8Tdr3O3yRjC
         7c1KCm9Ix+Eh6/jrujw8Jre60UfA2JOME8BNsf5vmrUTp16OUo1ea2MLpI0//s/7PaIq
         HFyazOXkVB2/WsW8pqoIivmXJLPkc+yGL40gSin8X4tIQySqjm7zJpLVIZLfZT6KAwy0
         KZ4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzq4gPhzg7MJsX0jUBQS/VxC+yfEzuqP5DHfGjS5AVP7kpSLpeoXuoeQBhd4GWQMGxK6wDBCJ+SlQEMlUpa/T/S@vger.kernel.org
X-Gm-Message-State: APuU4Z/gjtG5WRl1DJkKcuI+p4HwPTn7NJ7eWH9rnZ4pON+fdxL9EMH8
	JVLrPMxOjB/rfDd/p1AOkZU1cV6bH4bq/9XVkIrRLxohLtxUPb2O/+MD
X-Gm-Gg: AYBFou0ztr80/Y5Ez9cNfEEpKbD526Gu4DytSai9Y4k6vZHdWMkybcElAhwOxlvu0D+
	ILkVRUkRYCx3bX13k2iQA4ozFpeA+6xqVbbXKXDeGlwjPCLiPNbOcvxxp5iCBzliiINBNIiGyKy
	15AFuWvoR/hvMLrijhjyHY6UtRSQH1om2NLbxmzMebdTXIG67LkxIIIcHog1ofzc5zZmGUlplp8
	9hAp+d4whW4wUMdmSxXxNJvIg/FbATod7cb472wKZKYFWbATKFoKi61reFq/EjRkeQfLTOYuvdW
	pWQAROwm+G5dxxHyQP0Vu2Yd+uMAVtk9ULNEKzKHfAwksoaEw5md5RVkrURJnKVTHr7i09MtE5G
	NPhXUYiR0914aFLtE7Wit9cxsy+ok7Jd/th5jnjn82fh7vQacjddpmL7qaECcjRTa5OVw/zTU2K
	hHCmn3/wyqVXO/4PcrNKQA8CMo7do8/2Fl+NZ3NnjnmIh65BJZgZ3UtfnaPRHHcXjyqIUCmp/ya
	l34BTbADsSniz6Rm6YGiaFOVWbUeI0jg53NdE55PSx9AQQVdJqsUfy4kLBkmtfYKu0ll7yGEnfK
	iQ0Vw8+yXVHdHyg+wxe0a19EgRv+W5xLUXAsSt2uu27qr12DHkcEPKbyFsxsnyIj2bpMPDV2RR8
	CELjq6jBj1w==
X-Received: by 2002:a05:690c:39b:b0:8b1:46a1:2893 with SMTP id 00721157ae682-8b2b6597d22mr113291007b3.6.1793738260652;
        Tue, 03 Nov 2026 12:37:40 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b30998fd95sm4601797b3.30.2026.11.03.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:37:39 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 03 Nov 2026 15:37:35 -0500
Subject: [PATCH v5 02/11] alpha/perf: add sysfs format and event attributes
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
Message-Id: <20261103-alpha-profileme-v5-2-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
In-Reply-To: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
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
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeufF5L/Q8LuHmx7eydXv/0fKX2qYbjnsVcGmLHfANr
 FY9rvip4yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK6x3M/wvypuQv/Wg4
 Ef5p9yfV7uc0/XUSlE/GOXDevfvn1fevmOWTIy9DCzHZ++slxRee1H+/s1nXP1o4ymaEz7+WTWp
 DV7WBztuQA=
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

