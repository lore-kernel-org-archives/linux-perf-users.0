Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939431;
	b=J53GvVvbVdl0joWCYa0pQOG8CZg3/wWh3A6iqa5jCHr9XcgHC3lNF6XgoTjREgzawXXe
	 Ia/ra6gsxpa4RzJ3YlvLxLWBhYusu925C3YFHg/enrPyo+9HiyI1tfU/PioPK4patC5oT
	 eVnOmodasM241Ua/GbVJ1qgeb7WZHamBAJYmWO8AW0fXsrd0/TEsaX3FOeYEsF2orOcJC
	 QP7gYiakLBERDi4+I7y4mZTJYoqryCHcAIltsLHZnKj7CaCIMnqblXNWRYKTZ6Gils5DE
	 k1186chCpGafi0TL9Lf2y00nOERwVX4ooL4ams0GZgJRWiiLRBmQSt0m2NmKD/05HyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=l9FfNcYVQqBj1OaIcv9GJuMGud6+OOiFH5MqJ1VwAOI=;
	b=RT21W+r0VjsNyQw3OqCFzGHD4pMCrFsjIDIgLn6lk3WsNNEatOql9aH4lAwAEZKhIUfQ
	 LItPia0kEpNjdx185DJSQ9FVxamRfhRepmnqKv9sEONO8FvCLP734tydaWrGOVfnnQcSS
	 saKB07mLqdV4Xm2X+PKzhOdjYl36qb19gtpWNu5rSpJL/sYY5qEfFoccOx/TXmYMKZ9DI
	 devA3gyHCcgEb1LEXsi6C4ajWVS4VWdJ+k4vfVYv6YYbHgb3YPMA0loF8m4YUVedb3Fys
	 WEFuLinn5IpiJ7abPt7wSfIzPUgAY0GBWuAa67eJnQcg3qcO6gVYSH7hG2KiEJCRpvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=maQRfi8d;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0240606A332
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0240606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=maQRfi8d
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b31448caccso1322947b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939430; x=1794544230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l9FfNcYVQqBj1OaIcv9GJuMGud6+OOiFH5MqJ1VwAOI=;
        b=maQRfi8dTvCJ4SDIG50ec6x7qj5P2kQOrFggAQuLC7NiykPOscxAT2lnG9oKwNoZp+
         pLZe6X4gL4wJf5UB83AXJ6XXcOrP+YQd2GuMc8HTRvGDVTtIM84q22s/VTA/dbJCZ4X1
         VW59dD7gdct4AZ4fcs54FfSdb+tO9S/Gl0DFp29UMwukVPY2mUQ6mj3rKwpD/1xPPoNL
         nOe0VuQFCCaTJsoYuO30qTY+e6SPwGlD4ysQ8QBRd6ihgRO3IMi/XaYJt1ttV7XmPolQ
         xQVJCMs1MRnZSP8ggvBVHmjoHUExirqtJ5K/ZLoViY3tO4kbI5L5vaqbrzReObpfgWwt
         DIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939430; x=1794544230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l9FfNcYVQqBj1OaIcv9GJuMGud6+OOiFH5MqJ1VwAOI=;
        b=RdlVNehcwCbB7zWEOliTLmvsdAA89mH4LGVGaAs9B6U5NPHpZG1QMKiGzPf1kJcfoB
         cltASi9BCtC/a0TkfTxhem3n0gB4ESCXL9LmTpf3CMbtiYi/HhAXuS8DoTQjXcrvo4sW
         TOtB+Dzf54IDLxw5gHJyGA5OZfba52I2ivGjEGILk+8k9XloSHNQgBsKPNeI91nHKW0V
         EgWrmwhwoyCh3J6YD2NHZZSzDg6q6pTleIKemi4lXTz0LA2Zf7PmRx8J/aj0zcu9r5bh
         FWB2ldn2P2deh8FxFVa+z4WPKF6SHW19Q0SzmC3K2cMsB77wSjia7AFM57uav981++jv
         C/RA==
X-Forwarded-Encrypted: i=1; AL+hErF5BFAZSJIgwD+45ObrGn9PQM0uuVye1l1CaE7AA3IafrmsF3TQbrBtHY4Lt8/t+IeO6IL9mJKWO5Zm6Lv+TnMl@vger.kernel.org
X-Gm-Message-State: APuU4Z8v9NUyd6XSmPibBbmHzL1GrsBPj/Jz/FWmOWi9UO4AR5+bFEkD
	wD/xBkmUPusXGhiHVXKiWgHJKa1J/46DUwqrEKBCu5s16thlUYzhvdKm
X-Gm-Gg: AYBFou2t2yXOux/UAFP998WeIsnhvYxDDIIouGw9hIcr+6tpSdpREUpBLN9jqhtdZJx
	jESFrbjGbD/ASDr/JPvazrRfJnzOdVMXLi3hsi/YbVh5klkkmFNX8oMDrfX537s5b0UeZj7mNw9
	l7kCRErFitagSVLylw/7DHK6VIiA7sz3JHjuQlbqDdU7pwhGsINHXX4MK/LrhiBbW0RB30xiEaY
	sA+Nphlrg8lg6mBvyxKkBK3RDN1jkwvC7+5soqxbdvaTqLf7Q32CTXZsCWb+38reWOuat80OQpa
	mWpIHuW/F+4/7scibttVxQUsS8jphgE9XRCxM86O4GBkEtIbDJCwgljMhyUnNkDERhcEAiiabb+
	ZKCpQN3f9fvw3uCeNU7wCrMvxL+HSyrL0Lv2ZcVZbGsLcHWaFP8uAzTRskvIbVZQ3FGzRxxCXos
	18yTnyzuqKvBeH8ALjUEJPzyqH7bOdUGhRgWLpXgLqnFntKtcz4nMmkhNNgrv/sFJ0r13F4dhNN
	aY35qwn40tAM/NYfHyVZEnj7VRrocDOlA8z4awE0pipI0KofUj+XHBF4ZDp8DNPiKWEc58wnZ04
	32yjJqfifoINwrZkplKF0IJkiJ0Py2UrkWh/xp9/wSz4NUjXJA4eRBGDqq4p1G+DZOWbvcdN/z3
	04nLph6KTRQ==
X-Received: by 2002:a05:690c:d8a:b0:8b0:a4c4:1b16 with SMTP id 00721157ae682-8b3417b00e5mr8467667b3.1.1793939429778;
        Thu, 05 Nov 2026 20:30:29 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f2e0fsm11446517b3.4.2026.11.05.20.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:29 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 23:30:22 -0500
Subject: [PATCH v7 03/14] alpha/perf: add sysfs format and event attributes
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
Message-Id: <20261105-alpha-profileme-v7-3-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=DYl5daD4UHTnU+7rIRm7Di6fwnbZDZlkODIauQebLPE=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht/ZkaA5YYH/w8QFzr+6/i9PP39G4fFu3rCbpjIZQ
 fyWio9fdHxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1H74xMjQdnrHRKV
 2qXXWHzpEzM+sDvuxN//3/U7zp2uK4m/GxwSWMDMsTMz9+v9d6xC8wc9W62B3qVopFpsEfnyROZ
 Tsuxfn0OAsA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha PMU registers with no attribute groups, so the perf tool has no
way to learn the raw config layout, and the PMU's own events can only be
named as raw hex numbers.

Describe the event field in format/event and export aliases for the four
EV67 event types. mbox-replay has no generic hardware event, and can now
be named as cpu/mbox-replay/.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index bb0692e93748..2a00c4b86223 100644
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
@@ -767,6 +805,7 @@ static struct pmu pmu = {
 	.start		= alpha_pmu_start,
 	.stop		= alpha_pmu_stop,
 	.read		= alpha_pmu_read,
+	.attr_groups	= ev67_attr_groups,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 

-- 
2.55.0

