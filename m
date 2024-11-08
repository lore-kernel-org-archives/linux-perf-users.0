Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC5A1F26E4;
	Fri,  8 Nov 2024 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098511; cv=none; b=IEDLk7dOmMbc8GTGe2eBZ8i0arN9aSDWHCKK8Z46QVnyQqu4iQ5TgKyguvDJ3F4jTPRd+FCmtby46HemT2r4SHpvCIPeVbw1vKMWXsW6Eietjiu9sAaM3ZNkb5aIv/wy2b71ae7Y/TNDaCm8a5A2BArwhop+apgvg/YU6ezilCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098511; c=relaxed/simple;
	bh=KAEPyUMP2cinUNJZtTkPnMj8loQm7ritRd3p3n2vPRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxFuTNbwiQXMl231IQS3Yxp5WHi7+cT62pjOGjsFyQ/ydgjCc16fPgs3RbWPkH0AKtAycmy5vLFzef/Ha/+7YfLidaAizHLqgR1eklaHhO5SaWTEnacnwzsN4MBBJF4LlZOy4pDqi5Oo1dB8NNhnzlmglOBeQaBhIRavp3tq9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmvbBopk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmvbBopk"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e625b00bcso2016693b3a.3;
        Fri, 08 Nov 2024 12:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098509; x=1731703309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX6/Xbf/UBZHrGsZsvktBK/Q1YsFh4ovVpWZ0bQhbXg=;
        b=KmvbBopk0e5qJXMUx7P9MhFYrI33ta6BNk2fBDDqZf/J3FRBFEiSvteqQeLaPq/qG2
         M6ZlWLVaJdzRssdLPeQ5bzuqIRJ1BEdOBk2LGX+IILlwtEEL1Is78AE8bSpfEIjkDuwf
         AQ2UiHNyYVhIOHLpWPNJBohKXTQSOLZe5UsKLoofVyO8RtSF6TAFnvoHN7eNIpXlkXmh
         v9pAInt//QQzNs53NsGsVWpFMcVxvZYtShOSxXgp5CryAxVzobGwtEKFbcxL4Braaaud
         IW4+4Q9CyxkJwVkp76xekvUUIpNCP8zM5/QOjjB/hJSpz/6kCGBionyZTry3fMwRbLFm
         O+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098509; x=1731703309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX6/Xbf/UBZHrGsZsvktBK/Q1YsFh4ovVpWZ0bQhbXg=;
        b=tSBlNyVs3woNITbCvEvmIn2+ZMJ4k+wDSDPqc2i3oseue8Lc1ysHAslqi6ZvoPrlGw
         UVeB3BUYgovLWAbFtOBYZ99SCkqhaERRj5NPr3bxVMvBVuINlEklB0YE1JWBy0Ia5Uy+
         OUZRX0QJs1lXSpG6j0HMEfmt1cR2TO+d8617OedYquBak3JLGmCFu8tyMQ4lyDpVe1u7
         51T6xnw/wcH54IBwMwYxaLAJ1WJDJEt38RxTd1tot5ASnzxy2ltV17ZjNjEPk8sLJvV2
         3jGnjnc1Z94jE03raDDUZnDX/T08+gAYb/fpoTKJTarUi92igtRXzJqi0s5YWyYgyt53
         RGVA==
X-Forwarded-Encrypted: i=1; AJvYcCUr6p9fg7QbHy6LGTOMTr6xS70gCjsTCbnpWWHSZN3aR9Fn3WufIQmSYXgB6nKKZ/OgcPJxC0dUsF02bxo=@vger.kernel.org, AJvYcCXtL38Y6YcLUjlrDgtYXHQ43fwdmpKUW6lTFBwSKcWSWaOV8QfkQTx6/NEB1idy/p0xqNTTdWatS8kIh6XS5G/Yag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoBiTCPxCs+XGlojPSpEqDx2Q0Vi8hQNdk1VNA177k1AVvf5s
	Oi4xbWlmxzlgSq+KWy4ZbIPo7y3RgUe0df36obx3XYAVdZ3SPDyz
X-Google-Smtp-Source: AGHT+IGEDiTz0kucWsEbjpEjj9gZl5wIynfTiQnYEWbBSzvuH0vb+0uZ0QeSPnX53LkWoEUzFFFxQQ==
X-Received: by 2002:a05:6a00:3a29:b0:71e:680d:5e94 with SMTP id d2e1a72fcca58-724133510d7mr5616878b3a.19.1731098508845;
        Fri, 08 Nov 2024 12:41:48 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:48 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 03/10] perf record --off-cpu: Parse off-cpu event
Date: Fri,  8 Nov 2024 12:41:30 -0800
Message-ID: <20241108204137.2444151-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the off-cpu event using parse_event, as bpf-output.

no-inherit is should be set to 1, here's the reason:

We update the BPF perf_event map for direct off-cpu sample dumping (in
following patches), it executes as follows:

bpf_map_update_value()
 bpf_fd_array_map_update_elem()
  perf_event_fd_array_get_ptr()
   perf_event_read_local()

In perf_event_read_local(), there is:

int perf_event_read_local(struct perf_event *event, u64 *value,
			  u64 *enabled, u64 *running)
{
...
	/*
	 * It must not be an event with inherit set, we cannot read
	 * all child counters from atomic context.
	 */
	if (event->attr.inherit) {
		ret = -EOPNOTSUPP;
		goto out;
	}

Which means no-inherit has to be true for updating the BPF perf_event
map.

Moreover, for bpf-output events, we primarily want a system-wide event
instead of a per-task event.

The reason is that in BPF's bpf_perf_event_output(), BPF uses the CPU
index to retrieve the perf_event file descriptor it outputs to.

Making a bpf-output event system-wide naturally satisfies this
requirement by mapping CPU appropriately.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_off_cpu.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index a590a8ac1f9d..558c5e5c2dc3 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -38,32 +38,21 @@ union off_cpu_data {
 
 static int off_cpu_config(struct evlist *evlist)
 {
+	char off_cpu_event[64];
 	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config = PERF_COUNT_SW_BPF_OUTPUT,
-		.size	= sizeof(attr), /* to capture ABI version */
-	};
-	char *evname = strdup(OFFCPU_EVENT);
-
-	if (evname == NULL)
-		return -ENOMEM;
 
-	evsel = evsel__new(&attr);
-	if (!evsel) {
-		free(evname);
-		return -ENOMEM;
+	scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT);
+	if (parse_event(evlist, off_cpu_event)) {
+		pr_err("Failed to open off-cpu event\n");
+		return -1;
 	}
 
-	evsel->core.attr.freq = 1;
-	evsel->core.attr.sample_period = 1;
-	/* off-cpu analysis depends on stack trace */
-	evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
-
-	evlist__add(evlist, evsel);
-
-	free(evsel->name);
-	evsel->name = evname;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_offcpu_event(evsel)) {
+			evsel->core.system_wide = true;
+			break;
+		}
+	}
 
 	return 0;
 }
-- 
2.43.0

