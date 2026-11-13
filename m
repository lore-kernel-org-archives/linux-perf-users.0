Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599781;
	b=w2nFYQ6wV5zFzCldrazJI2n3I91qieFLxhHljTw3MZZsnxW5QaR8LyHUvYVFGKF1kG1x
	 dTjd2NCYQWK15CubgzDfHd9fYuo7vCBEjpR1FQXg/eYaznZ5hyDJ82kYMAGUtT+j3JQud
	 0XsQ5BGhWE7yTpjoblWHgGad6mUAp8YhXFm+e9OHWLiLTdyDI2/ZegfJOGY3acwLVUywj
	 45eDQbTwx9lah2j2Gt6sM2nl8Eg+2JAZWc6DCwhD8bXsSV8aU6G6yZ0FzJ0zg8gc3F8e+
	 Z6NjeuU3uIXrbxk38xfOkeDI+8/QLsFLa0UqZWd5W/08sKOy0Kvt2WVlF+2q8uXPV9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xFeCjHce/j/R2Nf/AVGRzvQxGmU3GCDj7F7sqvOkGOk=;
	b=qoGT1cHJUgmaBlEfx7JBGDibjGoKlhRs5t+sCxlpT1DoXBcLRF52UkIAYxy9cBACyfiZ
	 67aE2zdxZkTNaNmM2xxsk+eI2nFdxPljb7fEYlJB68UOYRc9Yshjko91evLoxeTyYbso+
	 ptMY2G6q2udqfo2lNwCg9EvZ+r25KAUqM1OXV8NyS5di5NemnAq8ovQhcmtF8ty9u8/Y6
	 vQ5dU6MVaPbWcIzX0BWrRoadhRxi5vpSFvPFKelSt5o44sDBdwBUNI6JdfsllBhbt1l5R
	 ajmmP41+AfiGNReulmoB110O3S0Pisxo4VIdqopcSSSu67kKDH/M76pcQey8aggUGeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RA9TsXTx;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4B60A5BDE
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C4B60A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RA9TsXTx
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2000263eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599780; x=1795204580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFeCjHce/j/R2Nf/AVGRzvQxGmU3GCDj7F7sqvOkGOk=;
        b=RA9TsXTxXGr6fLdgs9QnRmXx/b+D56r1p+dvmufMbjgYlhqZFQNN+fOBzpcLySdl7W
         v9m5HZWE9B+jgJvWJ7STZnyM0riBQxzGXIQYMQINBOjHh9ecLM+kiAQbaUPLWHXmqqPw
         UHqGKz+ahPNkjJV3GEw0GLKgDNXYbQAPB53P2HwqdWMfTzF3ENh5sHcyHMfJFUZYjLLY
         d48ReUV48OJN8P1VE8zzsHf6DlcH0YjmaN9IPTt/3vQxva2SdK1y16qY+t1oVcUrjoJV
         3AepBD9HcGFUWoyXCVJYglb+Ec+RxxuGZe1a0ksK5qDaAY2iJptFsb0Snwt7ZgSDFThv
         xd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599780; x=1795204580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFeCjHce/j/R2Nf/AVGRzvQxGmU3GCDj7F7sqvOkGOk=;
        b=jMwDCzzsQsBdDJwx9J0dSFLqb18+cE8lF7xUcdKiOgEYM9akRWaYLlMw34bopIMh7F
         C6ojPiLS6YovqoAuT8jlpzE7npNiPmK5eToLAovHLxxJR7p0oRSg7A/FAEE/L1V3NMYT
         AdUNXf/JhiepkLdUJPnMEKdPZlqDngzJ8m2H9NVufzEXuYfGq6X80n7mO1cdZp8yLGB6
         mXOPjeK13AfO0a/5ET0+MZ5R0TaV75QB9g+T3UK50Ou23nTWs+NaN1H6JELazZtPqIkt
         mx6Ku+GD/XMMsda+YurytC1PNWZWe0NDeTbyRGVg85P5oJbW+0MRJuZ/VFtfXFq1gLRk
         zuZw==
X-Gm-Message-State: APuU4Z+kT4/AQpslmgzgCGrrTWx+ehPO43rfDNePmTQ/RWhZpfT/+jZH
	d9jt9toFAoQEcbllaCGAWD3/WFk6CJlNvlz5yEmetVmJehMCTZuaUEPiagT++OOTndZg4Xhbq6F
	/JRjbaKn2sQ==
X-Received: from dyclv15-n2.prod.google.com ([2002:a05:7301:618f:20b0:368:2c6d:de10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4146:20b0:36f:551:2bd5
 with SMTP id 5a478bee46e88-379e16d093cmr2184725eec.32.1794599779440; Fri, 13
 Nov 2026 11:56:19 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:51 -0800
In-Reply-To: <20261113195601.2872738-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195601.2872738-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195601.2872738-7-irogers@google.com>
Subject: [PATCH v2 06/16] perf pmu: Probe privilege exclusion modifiers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() with test_exclude_flag() to probe whether
exclude_user, exclude_kernel, exclude_hv, exclude_idle, exclude_host,
and exclude_guest are accepted by perf_event_open() on the PMU, storing
the results in struct perf_pmu::probed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h | 12 +++++++
 2 files changed, 85 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 322d90695c4b..ab4265154990 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3125,6 +3125,65 @@ static bool try_open_attr_variants(struct perf_event_attr *attr,
 	return false;
 }
 
+enum probe_exclude_flag {
+	PROBE_EXCLUDE_USER,
+	PROBE_EXCLUDE_KERNEL,
+	PROBE_EXCLUDE_HV,
+	PROBE_EXCLUDE_IDLE,
+	PROBE_EXCLUDE_HOST,
+	PROBE_EXCLUDE_GUEST,
+};
+
+/* Test whether @which privilege exclusion modifier is accepted by perf_event_open(). */
+static bool test_exclude_flag(const struct perf_event_attr *base_attr,
+			      pid_t pid, int cpu, unsigned long flags,
+			      enum probe_exclude_flag which)
+{
+	struct perf_event_attr attr = *base_attr;
+	int fd;
+
+	switch (which) {
+	case PROBE_EXCLUDE_USER:
+		attr.exclude_user = 1;
+		break;
+	case PROBE_EXCLUDE_KERNEL:
+		attr.exclude_kernel = 1;
+		attr.exclude_user = 0;
+		break;
+	case PROBE_EXCLUDE_HV:
+		attr.exclude_hv = 1;
+		break;
+	case PROBE_EXCLUDE_IDLE:
+		attr.exclude_idle = 1;
+		break;
+	case PROBE_EXCLUDE_HOST:
+		attr.exclude_host = 1;
+		attr.exclude_guest = 0;
+		break;
+	case PROBE_EXCLUDE_GUEST:
+		attr.exclude_guest = 1;
+		attr.exclude_host = 0;
+		break;
+	default:
+		return false;
+	}
+
+	fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+	if (fd >= 0) {
+		close(fd);
+		return true;
+	}
+	if (which == PROBE_EXCLUDE_USER && attr.exclude_kernel == 1) {
+		attr.exclude_kernel = 0;
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Probe which enum perf_event_sample_format flags are supported by @pmu,
  * testing a common bulk mask first before probing individual flags.
@@ -3535,6 +3594,20 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 		}
 	}
 
+	/* 4. Privilege / exclusion modifiers */
+	pmu->probed.exclude_user =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_USER);
+	pmu->probed.exclude_kernel =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_KERNEL);
+	pmu->probed.exclude_hv =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_HV);
+	pmu->probed.exclude_idle =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_IDLE);
+	pmu->probed.exclude_host =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_HOST);
+	pmu->probed.exclude_guest =
+		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_GUEST);
+
 	if (keepalive_fd >= 0)
 		close(keepalive_fd);
 	pmu->probed.checked = true;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index fea65e314547..a7d794d67bf2 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -234,6 +234,18 @@ struct perf_pmu {
 		bool can_data_src;
 		/** @probed.can_weight: Supports PERF_SAMPLE_WEIGHT. */
 		bool can_weight;
+		/** @probed.exclude_user: Supports perf_event_attr::exclude_user. */
+		bool exclude_user;
+		/** @probed.exclude_kernel: Supports perf_event_attr::exclude_kernel. */
+		bool exclude_kernel;
+		/** @probed.exclude_hv: Supports perf_event_attr::exclude_hv. */
+		bool exclude_hv;
+		/** @probed.exclude_idle: Supports perf_event_attr::exclude_idle. */
+		bool exclude_idle;
+		/** @probed.exclude_host: Supports perf_event_attr::exclude_host. */
+		bool exclude_host;
+		/** @probed.exclude_guest: Supports perf_event_attr::exclude_guest. */
+		bool exclude_guest;
 		/** @probed.probe_event: Name of the event used to probe the PMU. */
 		char *probe_event;
 		/** @probed.open_err: errno if open_supported is false. */
-- 
2.56.1.703.gf848ed807c-goog

