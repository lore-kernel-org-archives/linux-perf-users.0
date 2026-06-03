Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6B3AF65A
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481862; cv=none; b=cOMikgiwE1wGnfmClaB6ie+IQIUMcOPvDo9NBQnmOd+kdNiv8f6VR5Gh5+fdtn5asO0eT+lcC6lR0GlLbMjSphLsQktxm+MgQwPXfamPRiG6Yt09ivfJ9BUOdF0MumiCUl0M6YRcssEHAYfQBfw6OE+zgLjI0NPHkwhuwzEUb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481862; c=relaxed/simple;
	bh=bBCpsHP6pxxOKGXqUqpPdX+SmhYJI6iRxQWCSYCtC/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhZZ7t4bluXPAY6qZfl5yteJsnvixN3udZH9D9k+kPsvfsb5BiLzv50hcip5OvioosPfJuir8sZmQsXiwI+U40SjpO3iygpOimGP6bvnmW9YEKpzzXxGFXf8yjPMltLZA4Y9SvuJJBJZxjViZz+zl4TEE5Zbkj7UMMifQupFjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pij6g+/1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pij6g+/1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so10086885e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481856; x=1781086656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/tFhBvkW5lHa9f/mqQAj4otAbWa3BZTThp9kdngA0w=;
        b=pij6g+/1MGujnNTCknim+cjuFNgO4He/hv4aeOFN5348PZmqBIvc4RojIJadRTNXz8
         n8loZ3TCZiW2mfD3E7XOJnRRx5maXZ40CnUQPxKYIXyXWQNE9/55AuG5+tnSxE0g2N8Z
         2xNxhOB0WKKL+KbEG2kluXhgUq/V7XWMbmHWhEvysnwIyFF3UBUjdGIrhD4QpIRpWJY1
         HjAh70y4+NgXeN50VZt5sGGG88pDnO3vYAQDkHn83Ka6/SKbkzMVC5BvvWZHp3gKF865
         6i7YI9iNlRgoCo8XTduGjRvvxChFoSas53Wjb+kMblRTuc4euVRPSzVcW9qsRTFKpMSC
         dIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481856; x=1781086656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t/tFhBvkW5lHa9f/mqQAj4otAbWa3BZTThp9kdngA0w=;
        b=oB78ZhgnviQS1ipDnxvw9tL0FEqT9fKk+5eHK/Tfhvndjrkg6SuFwTFZa+8meGYnXO
         fHQ/WeLWWD2FRPxtgbZC+G/3/EGtGvjfoMe8fIVNg4OUKz1JUu4o/XjgnZGewTdyWtCM
         2/h3E02cb7mFmGluTCP41JL1FXV11D/+L4EdFm97j/eVCaCjOqF72cut5taVOPAzMCes
         /8RKCFebPQWHopUEWZzYIXGtcyzjhuiVc52HcvX3JESIo/8Y5gfsXkU1uLP/UmDEc/6V
         YwH9G/JOj70LACxXGALkygLRH3VokKRYJH0j0S9Yg+IrRQXleCkH3OrSHR2Vaxy3BYbk
         FnuA==
X-Forwarded-Encrypted: i=1; AFNElJ8dWEeZfeDaESABV0I/aMuF5UtEUbnJXz7d3l5hXH5mA/mk0DarXOvw6JBREabJtK2h21VWv3ceBKW1tHEpgP/f@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfy+675EWIIhvcDmEZyFLpUo44suLFyFmdpOXT81+POViAe36m
	IFIf18UFHOjpU4NUxhv3+4KGUJDPI4pbVJQoSdN0bjZzFnoI9rfgIRor0U4ToEbrSys=
X-Gm-Gg: Acq92OH6ZVtYN5rMzHooNr27RqAP4S9za6Tfl6jJu1fEyIN330SEYgicDcr+h4JQEJw
	lkB3ZIp2y+DIfJxLZv5qkyvi0jV0d9bw82JWjTxwo8ZL7VZu2wOtVbxZrJAMv3z7HAh6gABrBWp
	ABoi9ZtmHFp/4w4oMGuNKZxFCx4+5bqxZDGbmMgpVbZI+BDsISdhgVr+yZP2zUEagCdVon/q9pa
	T0mnM4Eqr3meiHaXXDRmDY4foFH+QdHD9vuDSDucbuYZ7fQmDa3JYyX2Al/Aokn75b0S8M1c9bN
	OM1ZWUxG6eEBs0+LMW2Gy33OozXx4uojR1ZJQU9RprXZWz3MaGAQfPT58N3nVGBg0DfrObDv4n3
	6K/DhX9GF5swrSaXjr2uzWuCmpQBVIa/Ijh8Xyr9B4cc6g2Tfk17mnCpgGeD0TTN2Qi6WHidB2K
	Ua0k2lzlUY3S4zo61gIkZtOwKPBo6LaLg1qBfFbFUzhdYUmUCNfZ+d/w==
X-Received: by 2002:a05:600c:859b:b0:490:4b89:535d with SMTP id 5b1f17b1804b1-490b5e96157mr35776485e9.1.1780481856126;
        Wed, 03 Jun 2026 03:17:36 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:17 +0100
Subject: [PATCH v3 13/19] perf test cs-etm: Reduce snapshot size
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-13-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The default buffer size for root is 4MB which is very slow to decode. We
only need a few KB to verify that the dd process is hit so reduce the
size to 128KB.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 8ed2c934c87d..da2f599393e2 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -156,7 +156,7 @@ arm_cs_etm_system_wide_test() {
 
 arm_cs_etm_snapshot_test() {
 	echo "Recording trace with snapshot mode"
-	perf record -o ${perfdata} -e cs_etm// -S \
+	perf record -o ${perfdata} -e cs_etm// -S -m,128K \
 		-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
 	PERFPID=$!
 

-- 
2.34.1

