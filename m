Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621757;
	b=xt1ultznI9psaUV8EpkbHzd0MfTWKrpM+7zy4UwYvidgYyyE6jRS/QnosyOtNt7wgrN7
	 28txhNE0W7sX7QcoJ+Gy/nbytuctWh9q2yRekk+G5M+YAqE3Xs0bSS0xBu3p0wZ4riGuh
	 WvdvRF5k4dNcW9vq15kN2a5TBGEHkkk3WQaQoKgC1+okWqD4dTri7evkz54ZFmgKdZdxQ
	 YrsuZH904NZVq5Q8W2mzGuEUR/Zlbse+cOANuguxJXKJdzQiBR+xDR3UnEWQxXHjqWcT1
	 PuJ7H2u96enIE5jMHQagNpOKbYr8JAGKv3Mgii3fjRQmSE3YaAcDkF4+GrB4XBhYT7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Tfbh1sEe/bDWqkSnXbEmJhwFJWqdcIiSyVXsN0XzB/g=;
	b=AxxCzSmxlKsgKlTVNB0NLLPNpNn8J7EPh1LeQQbBxHYDe+bsal6xV+5/XEeAdTKa3xpQ
	 b2H5/DaFR5g9EdpGEQUlGrpcZIgt8+KTV/R/9TtJVcj0n5ffFnIZQ51Xz6IQP5hjyxMRJ
	 A/DOj1BKalgQn7DQTxvncKtxhzP3BFby6eg9fh0zg7WwL1nbhIEkWGo4ZlH62ga1g0iFZ
	 40VLMTNCw/mrZExdssfo+getNtOG9fjC3qH05mRUmQDVVSdAS9oVXL4QqRxOC7krHweyc
	 38qBnvcxOc7Xb27fvHZvIXRICRrx2H0Qft8rMeyU/g4BP+Zs0xtP6DkrXIR3twZ+R2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sYcKzM9d;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681E60A5BE0
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9681E60A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sYcKzM9d
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so18255825e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621755; x=1794226555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tfbh1sEe/bDWqkSnXbEmJhwFJWqdcIiSyVXsN0XzB/g=;
        b=sYcKzM9d8EFXn7TM4eMl1zoSRfzsSlaSLAx3Z8IDMXtzXqFiEsUKVtZwQsAbuG1VQw
         J3MgoBeHHlU/4tbivrBpkvPi7EniiVRta8VwZ0SPYSEsAduZrB4OJ51LHA9CrUw5Fjx3
         Q5C46GTXDKDu67KAJ70dfar78IKwJm/O40k0QXnz20v7B6U7s1YUmdhX/g6ZUHB9qEd2
         nIfS9Bo579b72d5LSpoz3HTpLWJ46vSGAcahvoAsYegN/P8EA/9EhzKLMs/cuF82aCcO
         T5Ams4qCqzYqO4nWIckNmTKO5sQNWhkO68qw3DlrUV2/sH6OmZpQtDIu6jsubzMsSSWX
         Ps9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621755; x=1794226555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tfbh1sEe/bDWqkSnXbEmJhwFJWqdcIiSyVXsN0XzB/g=;
        b=XA8V6/FAVWnJebFeNkySWv2D3H+dD6uosrlTox5RibHBbQM9k5fTMM4/44KWfa61Ar
         EJ/m/mT6gg11dc1jsOEEujol+S58kv5d8stbVKfBhAQlVuDNn37BFu8MzMdF3EH4nx1D
         WXaYpbNUr/R2RAV+HSVHI2wKuzo3sPK66D70NwM2Bxiw7N91LN9h/V9yNYjiDoZZXYvh
         Dhl1HkqAya2sItuXap+zaQ8Jip4y0XzvQHfAH0IuTcHa1GJFQq+Zu8pIn37p2P5x1flp
         eZx8jba9ywU5FbBHPKO04I8KMx8ofxY7VzsHq5CgV0zfE/QV7pzgVydmtzq6tySe318D
         I8pQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGJ51Lru3QDU5aA9HH+B4AfkcBpWktF1flWWNRDJTq3E3CqJ+k9ewZxDZagbBzskH28WA2aNVlVPxgyUkzfe/8@vger.kernel.org
X-Gm-Message-State: AFq9FYKWUYpAD4pTCk7/Hc+KJUpwhpzup+0L0JNYm7z8bv2QW9YYsWXW
	f3LskVEKKPnthz40hYG1LH28PxjZAn68s3+OtnDbk68S/Scp4lE3ZEzA8VCsQhGwVjg=
X-Gm-Gg: AYBFou01jjJiJ90SoNrnMr/LSDSMjOTuoerDspVhwQ4A8QpcBRFcE6YQeSWHlPyQtw2
	ko08KEpJaGUNxhLVUEby7JwP3qpFZhQFKnd7q0KzsIQDhPdGTN1qchFuVmTlb5a47hhKqj1vOzX
	l2H53BEFMr48eLBAPAHU/ZYa/XRNzcFD6TzZLko2GcJN4WvxFiMoUsEcKR3f5At3SnX74qlpd0w
	y5s7ebzSKjadEWoDOZhLbbPAS+uBGsna7mWYKXWomg5fKKDhiquwZrS4mLJ4kAJLo5ZfIb+wUae
	aKQcMyp9fBBAGPnTMLfG2Y5HG13FRY0pQ1JJili6p193D3eBuDye2vVlRGmPHfZWtlUTZ2n13W8
	aOoAVMioONmtC/WkC2x7Fi0vCmBtqpq3gKLBOzo9A3Cey3W+WdkIgtnQdzmunLaVhhJMA1EqPmT
	zbtyHqxl0kBcVsTvaNEZ5sq7E/zpyV8MSqbt5OY93TUlQ5bSwH7gqz9lcGlaIj8WVpgfRleMOwG
	kqTzYHEAAV4QqXVW9i3YT9LocYNHDeaKIvnNyLrzqtucL+dybOoUyX9xaoYtpRnXHNhM1Y+9+LT
	B8lWfwa0kpNPU5PPAR968CQvejFVdbmC
X-Received: by 2002:a05:600c:8b61:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4ac17752ee4mr210928905e9.16.1793621755020;
        Mon, 02 Nov 2026 04:15:55 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:54 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:23 +0000
Subject: [PATCH v3 09/18] perf cs-etm: Increase default timestamp
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-9-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
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

