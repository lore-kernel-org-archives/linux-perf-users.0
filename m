Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333047;
	b=ypHztXuS0fugdv5dNhL2gKo6yJHIIhWEebTXY5J4angqV5Jjv0BJfGQItpQwSRhmSRw6
	 q2JDnID5jtmPGY1aSJwH1hhz1w7BgpIVau8R7pZ3AF9d9LFzP2//e7JMA2yhAtff6QoAz
	 OGYSUqoPQRxM2JnukK8g8vEg51FFHdC3TMEWDvMpsiPN7M00kkvR+8EJb8n1mPvujUn8x
	 EP0RzaWs5TcGZDUhrNtkiBdMUxego+MX2iCz0TtesjPfMhdZg9uoDfkLil68QPoxbAueU
	 /p0n0zWuYoTMJ4mtuuS27h0PZYOJNBjBD+EDKapA6INyswPCnCiVgdpiA1Rw8ghchfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=615A56KQSKwDjQwBeP1BUSDjG/OPw+Q52l+yGTWeJr0=;
	b=dEcpF3p6kNrN9xLDo5GMQbvUJ4M+02yVeXhZJRjWpYF9g0Oo1Tert+1ZGM5dTB05fB0d
	 hTGFJ/cSRUWYWYtP4vkAkfIFfYFgdfuQTsZQxuQb9jj4olI7xui3l7Zt/pjVK9IZ9N2cY
	 mV+htPAapXLl8npPbbVK6liBbZ82kBFiFYGm/GsgzFak4XrpCOM0aoGKQxdJTBETf1tx7
	 1OmvGJNNY5psI/euYG+vgLwmI9AN0RqYU9tfnbvqPf/9KiPE/9xqgPIlhMoRVXWl17gha
	 ywfyxN3mKh8OCuptVldNn4QsVMYlzFh4aOZRkOj0BId8G7j9SLBZC/N+UNVsy03Q+XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z9Q+e2bd;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D91606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0D91606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z9Q+e2bd
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-679a2b5fe87so204605d50.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333046; x=1793937846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=615A56KQSKwDjQwBeP1BUSDjG/OPw+Q52l+yGTWeJr0=;
        b=z9Q+e2bdVF1oOGa/Lj/sMU5hnxveiPBPIaoeBiGBdpaFr8uyw5G5Hwbvt7ZfTjcaN8
         niaGrbZIseIox+EkrmhSRwv6Zq1stHhm/jZ1bbyxNikypnXFPpHbgMmJfx5GI8zTbN6D
         lYI9b1x0Kn3tuVEnHJ4VkkCjHmYdVThbYSVkzv1l4nZ/K6d0L8PBVJs4+5fC9jpGgR9+
         gHh35jtiYtl9Qer459PljTiOa2YP2JMEVkq8Rx9mXZAWCFWi1fuqzD0NRwhAqkjoc8ed
         VzzUjQzt+45z++8ev6SMWQzjonir7EnEk/EG9igOGBSjUcLgiu6Wk2gIRnyzX103nZtY
         RvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333046; x=1793937846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=615A56KQSKwDjQwBeP1BUSDjG/OPw+Q52l+yGTWeJr0=;
        b=AP+dgx1cTcxbsPEO/kIVln324goMa30Tmd9i1lHe0IEvKyAE8mZxhAIyVfBuYN5zWW
         Q5Pi2C/6Wr2bCNCcAlEC8MMZmNJZvDNix/j5pd/gj3+W301IBgw0MTQ/c3xPOWL1DXM+
         M1uW5fFiGNNoV1NWbn8LPlA5tCnEaoHLXBKCozcXTWKx3dbG7pdtOkPELH3HRX441jdT
         iQ+BquiRviSV1w19NKbYkSGMCryz7IrByb5B8Iecs5ID8kRTKKVTR/RcO2L+j0iU9wDy
         fcO62CaEGStz44LY9QcYvH0JRoa3mSB4BpmcTgjrTN/aqBn1mA/HN5pMkjH4YhGswGQz
         UHNQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3CzzRt+h4mUc1SPtGXfA7qeo44n3Gjm6pN2Lgi/tFmajaNE+QdyApPuZtLMZlApqU9F0NPruSMdaAwsPR0K/z@vger.kernel.org
X-Gm-Message-State: AFq9FYIAqk3xrnhbRPzrEXnMfNw2i19mKqliqk4VQ/C3djlOJ0I9cErE
	9K+yBvTXezuv8Qdf5QU6UlKC5tMuNbIVAojV3EkiF/vKqmtLilFJgX2q
X-Gm-Gg: AYBFou2a6pCFAZFIEDN+B0Msy/8MBjVTnrDSC8VhEI2DR5pc2RfmdD+nwEwJMPol2ye
	yk3l3DZR3dVXOvaWcv+eD7bY9NL35UjUW8/lwE2apV9wZx6DFoQ3aio+qY+vcGE+tj4Qcd7CdyR
	B5vcLpCXbI+CqdDN4Z7DNafAxhdwJVpXUS4sSlxkYghcJ2wp/gcpH4VRsTlMczxPY83X7NKYI+Y
	tGQ6MSqKMyBBZFQ4l5oSZNFwW4BxdkrrHlAQfsmo3U8UAdu6jGnaa85QHB/HRtVOJlzXyi3UBa0
	k8diOkE9JPXSyn2xdMzvxArW9DZ6RWvNxb5OEgs6LqWCF8ZdotcixSLqAtDi+EC7Qyx0Nmp/lq9
	upgYYy0ZP4R+zukQomF+dqvb/ETQr34iK0VtiKq0Pog/gErYp4r4A/Z3n4Ta35eza7gQOWOzlRT
	CpDEeRaA20w9QBV7Uz2ejsJOeRVC2sM+cfzL9AcqmpuhPmhlEEXBjpFKrdlyIoLjpd9Y2WIjwDJ
	UdIqHXIXKkjmJrElmU1jTc/sJ7pvl9wHOfzmub+7uLYAl/Zn5pMbR0d1sIWmhApa/5lo0UD3FAD
	ONFri2lJ6gKPZ4SRPUoLfXQrlD5cheL6rIt4oC3Sws9iQ1UG5JF4GW6Sut2sYNVAKvtuBlDHY8D
	l9UtMNED+wQ==
X-Received: by 2002:a05:690e:4553:20b0:679:b69a:99c4 with SMTP id 956f58d0204a3-67ba4c90a51mr451158d50.9.1793333045725;
        Thu, 29 Oct 2026 21:04:05 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba74e8dacsm320747d50.10.2026.10.29.21.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:04:05 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 00:04:00 -0400
Subject: [PATCH v2 2/5] alpha/perf: add sysfs format and event attributes
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
Message-Id: <20261030-alpha-profileme-v2-2-c702f1c65272@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=aXohGVuQ+3QGlwkw4lcu5MBGEFw0RN4GyCwS/v4JVPY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeiOtbz9hurFbKEjH1qaqb4AoJEd8s3+nXBVetnPcs3
 6kmcN2qjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmAw8jw7Q1x6Kz9k
 092Jq4v19XvP+pDVMG6yLp6n8JXxhjNjBx1jL8ZmvZtPG9/YEpsazTtPVcQzROlcSztt1cnVcw/
 UCC+oTvnAA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha PMU registers with no attribute groups, so the perf tool has no
way to learn the raw config layout, and the PMU's own events can only be
named as raw hex numbers.

Describe the event field in format/event and export aliases for the four
EV67 event types. mbox-replay has no generic hardware event, and can now
be named as cpu/mbox-replay/.

Signed-off-by: Matt Turner <mattst88@gmail.com>
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

