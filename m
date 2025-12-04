Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DB33A703
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839479; cv=none; b=KG7bY8ZkFF1QnFFIS7zS+LqnnDUlALSkWqJA0wHa1IkYGe2r+YDu5qtK5xq+M81j4Wnb1hyXHkYvOoT/EIcRY1ZNfwmAqi9sh0Eili0l4VkNrmrQPBLIcfNf9rlbTUSXQj+s9qNx0jWPtdFWQtj9NeqDKbE73d7nc8EXJ0u3M4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839479; c=relaxed/simple;
	bh=8frtk5z9hSo5HnEzgaBz2tN5s3r3d7yy87S5hYIPvx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWpV3CjSLi9Ui+c9Nm/tEauq2VJnKkvRFHSPfX0/Y/QkGx+D3DoWhg9ZKywLWN9FZNyWg2DS5zQaSjuutHn0J3tuI/CXfJ7l/GxNRan1DBOcH5gjt7xKtgVX8csK8opdoi2Nzx/YxmACEP6iWHkJAVW4EYpcIuVDEJoEOJ3OJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nwAiAqFE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwAiAqFE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477563e28a3so5189765e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764839475; x=1765444275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfE4/ajLC28SzlSPz1UE6pjm/MfduJBPof5RsWVz1j4=;
        b=nwAiAqFEaqV1Un/hUPOPOO5dxn+y5i8LH8u53H8m4jFcF2cfIS7vkkGrLR4zWXpyQf
         tN/v6mK9+jg389G/yZK+b0estLZ05tOmyVQNXkwTv8Qd7oMyzvJ5pZJo+gnEtXm/wY9L
         LiNqvhR3DVYYMlWZ9Vj20XijVEcUIn6hvg+VjabDBt84Ip0c+wM8YqvGwE+/Q6q4O10C
         sm4yzfMa6jN8BhhpLKKeUleAh6vyzTgJDWtlwuSCBp/88pSv4UZrvoyMfn+0TEaViQLa
         ISlKtfU3sOoRztEWhJMkGJ/e1M7/6ZtjePkZXiV3XP2uF/UkSzINm3bO3TRXIY3Ui8Yx
         K1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764839475; x=1765444275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZfE4/ajLC28SzlSPz1UE6pjm/MfduJBPof5RsWVz1j4=;
        b=PipU4ftbpbmrGR346bhb4zxnyOQMtLT3z8UvmE8t5D+Ed4USMMxR9sIlS/cPv6Fz9D
         EWl8S5hz8Q3EEsuyOXhe8Gyiq7jkEeOyYOw/GzU6lDZVo3giMpRdc5atecuL6BAHhU0r
         fWd1SxXD3RxsnhGyGjNge+pNo58w1ebGg7Sgpo6oMVkhC+06J/rkAf3grEms8D8q6YDk
         MCD9ApsWBCpX4SUZcWBUElwRdMtGTyqL6YRmQOL4iAVUWv7W65Gv+DTr9aIo2arebo12
         yvjTbH+jDmWCaJABl7Dwyg/HMlyWUItQugoYAYTUWdpAtfyjVpBY30Pm5ZWMEVeBquIJ
         eOGQ==
X-Gm-Message-State: AOJu0Yw4ghUMUSDu6TrHH4p92IyXEnwWeg/RFmhXiCA10k/3vpuRAupy
	PzJs081oLa1lVQh6CE35aqIOG2f8kl/OslIzATIFfnwOwnw/tqlqvih/5LyWpkfyFEY=
X-Gm-Gg: ASbGncu0xlarbp/tqbCaplTM18By+QYsaQhY5V6cwnW9QirJOKxJthVGNBP39z7SS8D
	ansuygQUqooTAlYr20layMnBxgGaGjlawZa8hXD0H4FLDPX0+zmlJi2ERFm8Yuv4DdUFF5xegsr
	nypNXQZJ7cXr65YhWaRlPvJ77UDWcGP54d4PsaA0MxiL2YaDgMbqSGJFAsCzYoML8QctnPlkiZY
	FeVjKUbI/Sa62dLcKspzOBokCZgQ+CTwrEdSIoqeIkvDYkl2RfRv8PUeD9XDXE6umiYljgMl5dX
	Rfadz9PXMX2qOXGP7qPZYOUti9UtZ9LieI5UF+qZ2iDH4zBhlvSm239GA6e+5mJHaY28F5iyyjY
	hGKEgZE0eEJEoVA5zRlIFhPf3LsDtHh52jscvklmLWx3fXGpFQkuf5lxJYQr9ecG8uKf+hrnZJA
	nwXSqpRc3WHc5YZ763H1/L
X-Google-Smtp-Source: AGHT+IGbsiceQtseRPJsW4T8XAnxPt5gaOiwwQOsN7ZNvlkDAp5/3z7uAVqt+X+fvVzjLRBmzzMM3A==
X-Received: by 2002:a05:600c:4fd6:b0:477:a219:cdc3 with SMTP id 5b1f17b1804b1-4792eb36fd9mr28938935e9.12.1764839475597;
        Thu, 04 Dec 2025 01:11:15 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b157783sm38720515e9.5.2025.12.04.01.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:11:15 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 04 Dec 2025 09:10:54 +0000
Subject: [PATCH 2/2] perf test: Add missing newlines in debug messages
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-james-parse-events-test-v1-2-e6f922ca395e@linaro.org>
References: <20251204-james-parse-events-test-v1-0-e6f922ca395e@linaro.org>
In-Reply-To: <20251204-james-parse-events-test-v1-0-e6f922ca395e@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

These debug messages bleed into the next log line. Fix it by adding the
missing newlines.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/parse-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 128d21dc389f..62aa40d8114a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2627,7 +2627,7 @@ static int test_events(const struct evlist_test *events, int cnt)
 		pr_debug("running test %d '%s'\n", i, e.name);
 		test_ret = test_event(&e);
 		if (test_ret != TEST_OK) {
-			pr_debug("Event test failure: test %d '%s'", i, e.name);
+			pr_debug("Event test failure: test %d '%s'\n", i, e.name);
 			ret = combine_test_results(ret, test_ret);
 		}
 	}
@@ -2764,7 +2764,7 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 
 			test_ret = test_event(&e);
 			if (test_ret != TEST_OK) {
-				pr_debug("Test PMU event failed for '%s'", name);
+				pr_debug("Test PMU event failed for '%s'\n", name);
 				ret = combine_test_results(ret, test_ret);
 			}
 
@@ -2790,7 +2790,7 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 			e.check = test__checkevent_pmu_events_mix;
 			test_ret = test_event(&e);
 			if (test_ret != TEST_OK) {
-				pr_debug("Test PMU event failed for '%s'", name);
+				pr_debug("Test PMU event failed for '%s'\n", name);
 				ret = combine_test_results(ret, test_ret);
 			}
 		}

-- 
2.34.1

