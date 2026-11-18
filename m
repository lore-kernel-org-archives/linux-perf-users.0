Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019392;
	b=1kvQF/EGTt3gkIgoJKp1Qz6boR7rWYE4GUpAoyYwI8GHKq+w++oMEFNEobWF6/aJdUnu
	 QZQ0O4xqq7BdT3K4eJ39LoWd6b0IlWSPKznbF7Nv9ZICSheqQmCbCCgFeXZnAXPUmJd69
	 peUA9EZh3sPaYUOJQ2nX7+xNfk3bDQr8RSW1z49nw9YGggbJT3G9gC4G9XSpU1/F64BLq
	 bAZLDfiJhGSWRXqd1XrFV0c03Rx20/Moe4BLAe6YpF1+pCk8IVk4Jiaepr2NqcVFL6Jex
	 hwEDOmqgOaOqQJ35WeA4ZQCewU/JYi+EvNtXjmc7DQcv/hqMmEhWE0uwq9BYahA566g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZoY49G9OBW2Ss+uxh9zKm04Sv5cGEWU0IEPT/pkp6FA=;
	b=armn/9Fin9gmo2HM+y0/LjQn4YPPOKlyMGgcRNBlYdcyQyvaaeY9pxiGZ1empJZVAJxi
	 DYzjpjz/k+oJtbRkWaY41MOfhi3So7y2WLApVsvO6m8UBjuGI7S73Ysa0b4stQosDYZqU
	 ZZ4g5EhuT5L+pQRBkesZ4aPK5F+oByVVKHZu5vpL6vg9vDGauJYFJDo6QyhKI/eG48uwP
	 9FOsiL6gApDl4WVkdgCZhRVq0mpf+GR0G5XIP1qLOYvYDPQqnWGNkzl8RbNtEXx2Ig4vp
	 ZGvDS2eeTR8qhd12PFg7oo88kKRrWkjmm8qeo6tWL60Sr3iwrGNGU+lcPdnvWL38muQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ItxjA1sV;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA260A261B
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1AA260A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ItxjA1sV
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1071076f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019389; x=1795624189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoY49G9OBW2Ss+uxh9zKm04Sv5cGEWU0IEPT/pkp6FA=;
        b=ItxjA1sVIskn2bXlZ8MTSXkdRYNJRscOn99Rj9xvDeRBspcvHJp4myUSRG1aCmqm6E
         LhPNNj9jqiVN/6CMIlYllbOqVP4DCwD7ioMPADk5wxEhjTFuu/3YmhZpPpdzMc6FlLRD
         pRYPa14fW6iY5u+eS74t4wnyLRfXxd7j0gFDg1HDgG8BJUXIFLX1diV9WjCN5u3Uc0ka
         54FFZ2zDykxmpIjiTs1eJI6GSXG0jQJlFA9uItihYz2rSPs5LJw2olI5hpOiiyXazoMd
         F0E8dRo9+TqspRbRJsMExuh52UnO02AhmhSTtaRiY+FUxk813z13SuNh91xV6/5Ubbdu
         XKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019389; x=1795624189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZoY49G9OBW2Ss+uxh9zKm04Sv5cGEWU0IEPT/pkp6FA=;
        b=a6bAZmfDloeG0Rwq53psp/A5PXycrRQJ6LM7ACnLE48VOlkuWQqnhPhNxPXCyAMVxU
         caUQQbs0XFrO0jVeobHf00e6Mv+gE3j4db3FKav3mrbZVMDJtraOMGfWNxoNUii5dW4q
         JoSEv6Qvy8mivm2cbJHBYOTTnsIskBcQz9x8zsNORUW4cTN3GzORdKlIpyMt1pOBGuZ+
         FbHiOqe/iGHMKukBVAeLnG019U57maJPdm49WmaLBWR7wobDEvyJrFUSz3dzN3SSy11a
         ObmmAqm5YN1Rt9yY2AvoFz4A/jXVtC1HPh43JEmkgAiliJR5qxVqy1hQOmzuDyQ7V9pQ
         tLOg==
X-Gm-Message-State: APuU4Z8a3wP/5z7rV6m0/1krKv8IZzKDHDvbTT3DCYSN4LVgfi6tyG3u
	7TrP9KScyploQae6ft60bGK3vHdY7mHET7BdXrEq8hKWfUUltUfG2XhL6xKRPP4UgC8=
X-Gm-Gg: AZFdTZdq0/lEvSEjo3zpkGV3b05I/HGJfIfb7YTTp69u0fHq3epTfRIGyUQvfHhSqi6
	uWWoIXmtYM+sT/KZ58NcKTJvXVnZGsFnNNt/fmZNUfBHwCT5WEAeI2STiboywkGN38hHhRb9115
	ClU7R0gYfiZ8Pl4xtAboJMD1Ee0S4eOAssy04al+u1er5BSa2J5vlTFgB1YIEiqmlTVjXCwkQfn
	aOopjbpK+PGIFJ/SJvFfppBD02dk/3qtC8PL7j26V5NA1jywA1WFG6nr1dZkivJqFIxirc3e1yZ
	YEvwrLY/qFeM63JXd37tvCPxG3BZ+/Yx1dvxXfe0gPLqQe6g9vwP/BxkScDuFkErwIPgrwN6a1X
	eChEJA1DK85zMUDrz1ytTbXuUq3DKHj7QlLTFRw8XrjVmvjeEG3oOVkQiUNrZq9EYQBPSxltGrX
	OmuG82bimSqUBbUqUXDddxtedKNbOdu7Y5ZFrZh3r1HoDPFFs31N7fNZ5NG7c08rUBwIxvT9Fae
	hcJ7X0Efr/dj8rpt7WT/ZHOqjSo1f3Zd8PUu5j45wxI2wiVs3xFzNcCiA8NPODZorZW0nsJ4kDT
	4iKsqIfHSsTyuyP41cdQ7jVGdPkfGMyX
X-Received: by 2002:a05:6000:61e:b0:4a8:e472:a50 with SMTP id ffacd0b85a97d-4a8e4720c5amr42347f8f.7.1795019388940;
        Wed, 18 Nov 2026 08:29:48 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:23 +0000
Subject: [PATCH 01/34] perf jit: Support JITDUMP_USE_ARCH_TIMESTAMP on
 arm64
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
Message-Id: <20261118-james-coresight-jit-v1-1-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

CLOCK_MONOTONIC can't be correlated with timestamps in trace, so to
allow the JVMTI agent to be used with SPE and Coresight, use CNTVCT_EL0
when JITDUMP_USE_ARCH_TIMESTAMP is set.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/jvmti/jvmti_agent.c       | 5 +++++
 tools/perf/tests/workloads/jitdump.c | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 526dcaf9f079..674eed455586 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -96,6 +96,11 @@ get_arch_timestamp(void)
 	asm volatile("rdtsc" : "=a" (low), "=d" (high));
 
 	return low | ((uint64_t)high) << 32;
+#elif defined(__aarch64__)
+	uint64_t val;
+
+	asm volatile("mrs %0, cntvct_el0" : "=r" (val));
+	return val;
 #else
 	return 0;
 #endif
diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/workloads/jitdump.c
index 01cbbbd564e8..8422b66ee600 100644
--- a/tools/perf/tests/workloads/jitdump.c
+++ b/tools/perf/tests/workloads/jitdump.c
@@ -34,6 +34,11 @@ static inline uint64_t get_timestamp(void)
 	asm volatile("rdtsc" : "=a"(low), "=d"(high));
 
 	return low | ((uint64_t)high) << 32;
+#elif defined(__aarch64__)
+	uint64_t val;
+
+	asm volatile("mrs %0, cntvct_el0" : "=r" (val));
+	return val;
 #else
 	struct timespec ts;
 	int ret;
@@ -55,7 +60,7 @@ static FILE *open_jitdump(void)
 		.pid = getpid(),
 		.timestamp = get_timestamp(),
 		.flags =
-#if defined(__x86_64__) || defined(__i386__)
+#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
 			JITDUMP_FLAGS_ARCH_TIMESTAMP,
 #else
 			0,

-- 
2.43.0

