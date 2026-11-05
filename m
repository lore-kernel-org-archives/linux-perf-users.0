Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879133;
	b=2lpZyHbfvqyXEGsJdjEO9FUI6b9n9PQlTREJoO921652F57W5aQm/BdM6ndQiAjkZ7NI
	 +nw0xAR/Vnsbf+9mGZciPOBD9rOJ/d91d3uRYXy0tqCSKm4IXvINSbX3fHHz1tgL2wVfk
	 BNmZLaqYWDiSCFCWcnyqpROoXOsidaNUsf/EaqAzfLKcV9J1/OEO0tDv7qChikoxtnOFD
	 6z6r9E99v8q3eBS50I/iqcL4yUQTOk4QHRT3PWBXTd7THprpWuKwNwco1c4ZcRsuiZ2W6
	 AKJhKqVXXWxtriXGjJXomUcRLYyxjjIkyKdGnYimPXY8Kj9UG8iqldidJMuiFl8IySw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=oqj2T0WXB8ZBG5xgwGVwwKzGsMQkmNW87CSFX8dkW1c=;
	b=fBqgmUFijSav3MX1WaVyhPPnTvI+paYk0uVHAFZiswQvHQB5GBjHM4HpMKqAcHyQsNTH
	 Er4iOLRcFKjjY8Fr6SdLOitGstIFBAumARn3mSIlaT+XZ7uEyXH/PWHLrHIcMfJdS4Pw6
	 VQUA/XdUBKv2LlxxsoyinmG6G+B+tWDHDN2XlA0pXfGQQLfe5pxSe4IgPwiABXvSmol1m
	 M301Ju5EqFIcBkYcNQr8IkdWSBcoAWZTfosrLGYE5fw9+8Q2+Bo60sxLLzvI91rLcXGs+
	 V7ug4/+c6/3ZP7UvZHirHCi3hdEaBbpTTvFpFoWVg/aeYGCsC19Yv7BZbmVZzO3w+2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yvofcizy;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B76660A381B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B76660A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yvofcizy
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so10724725e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879131; x=1794483931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oqj2T0WXB8ZBG5xgwGVwwKzGsMQkmNW87CSFX8dkW1c=;
        b=yvofcizyVVfGyph+dJ3vEwbU4lVksshxBSC9jWPZbxyr30nySOhCXhqj5IAsACtT5u
         zGxM8WAH0xU5MJQxzc4arn7QakSVdYo0stAl3HnGR+7+SxiC/HkFFt2qUrNZ9r9T5zB0
         8PMlIlZcTiS084mhFxLxIVIEWgaEilXAylmTLPTQxEowlCOLy7puTJG7oZMekVz4RZff
         Oh/ZTH9ZNrlq+Y6Zxhz7KSrAyQRzjs067+DQ1HSjnLH+F+J3wOgq9Cjzh4hcdrQQTPwW
         j1mIz780qkEgp0cKZ9rIi6VBNPNzG1h8JxiFqE2VnMROYVD3v8TCWmrAmKOR+RyaOJjK
         t/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879131; x=1794483931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqj2T0WXB8ZBG5xgwGVwwKzGsMQkmNW87CSFX8dkW1c=;
        b=sx7Mze+tMfyDuEx7zYmuceQ0M1EH5LegmoVB8Kyes44xApmXAO7xWkzQdKoJMIp6FS
         tjrjyl9AV97I+8yIv0jvdqUAvQ/oH0R9mgCXzgHaZcjAkhIziawD1Lt9bf8KdeZQfM6W
         90l3s4PNnYepaHnfmcE+fPNcprc9DkDAEBVhZk9cCa9ry9l+keDb0Q1zrSmey/3U2pQ4
         QMIn9mooRboRkCryP57UF6dXLnZNMbg7SSicGZuOApsvguTCkEGH0YpkcHIW+izho79X
         yYoTqZh8yklHib9zb4b3guKSsISpe5rN8+YEWYEtn+XyDGeCzGF/OPUYYyrMHbA/Tdbe
         EG+g==
X-Forwarded-Encrypted: i=1; AKwUvBw4F8Kgm6HdQNfjU3ekRom6FrK2Gvi1vHSi5NyD/4i1x/TYNB/jmOWSwIdcb3tyY80+iMkhqNEwh7exZLvIgqqs@vger.kernel.org
X-Gm-Message-State: APuU4Z85M9auz1UoBi1i9SEDAZ0XrZkRPBtsZMvZudBDqXu9NppGdBqi
	em6K2O9jWhm2wqQh0pmVQIYy6flquZKRUdo47hh8dyXR2ON2vdNEg5590jEBECCwJFc=
X-Gm-Gg: AYBFou243lJGmTcbVBJRzhFDdXIvCPXD72yLdh+/bCCr0h8A49qpz4J7jva+43RVMKq
	aDwt7B+rlIkMVp96twQdA2x+dalsf8pBR0z/SbAD/GZ/jP7Gf9Nh1oob2MBx330FfFUjX/Uh2Du
	UDJ+KrJuMduHwyTQMLQ2T2XivzsPNSIkvqkHpFSWtPvFttXxEXIFBeNZAh6KPqe8DejfO4KT9Z+
	hPnXFL6YB+/1mrfim5adx2njFqs2FL7lmuXTz2B42rmq5Gat8ER/v+68bOETgdw8Atc58WyAnoZ
	7FSGDPjzvzBlYZCjFc7jTsu7ORpVtaGZKWdQPM505tN4YPkBsEFiIZIms8jd+N+mkaFAwPyQTkA
	43ZkN7xijICZCiD+RSNiXUQ+aVP1rEcry0NAZjV6b7whXL2BZNvrRVN/7wcET1hxsRzTsu4VqLi
	JGG0ATAwfIZPGG3SFtwPqf/rJk8j2w/n7elxSlSW1nO1dLrsdP2dsJ5PF3O+FgoykjD7TkanPWX
	HKyho2M+LfLxFqRknXuzqehxldTBldYCcX+2CpIm/+4v7R9LiPr4EFkWlGaEpn/tuutV7AWCLhA
	Jwa61XSq9gm6iLgviZd2p14PqvykNxGK
X-Received: by 2002:a05:600c:a4e:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4ac187a766bmr411694955e9.21.1793879131015;
        Thu, 05 Nov 2026 03:45:31 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:30 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:44:57 +0000
Subject: [PATCH v4 09/19] perf cs-etm: Increase default timestamp
 generation period
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-9-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

The original purpose of timestamps in per-CPU mode was to roughly emit
samples in the order they occurred across multiple CPUs, rather than
emit all the trace from CPU 1 followed by all from CPU 2 etc.
Previously there was no way to change the interval from the minimum of 1
cycle, but custom intervals are now supported by the driver.

Drastically reduce the number of timestamps emitted by increasing the
interval, which is more than enough to interleave sample generation.
This reduces the size of the trace generated.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 47b4e386cc53..5e7d09b7170c 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -70,6 +70,9 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
+/* Default timestamp period of 256 cycles (2 ^ (9 - 1) = 256). */
+#define DEFAULT_TS	9
+
 static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
@@ -458,7 +461,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		 * Timestamps are required to interleave samples from different
 		 * CPUs.
 		 */
-		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
+		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", DEFAULT_TS);
 		/* Context IDs are required to associate trace to a process */
 		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
 	} else {
@@ -481,7 +484,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * timestamp tracing.
 	 */
 	if (opts->sample_time_set)
-		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
+		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", DEFAULT_TS);
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");

-- 
2.43.0

