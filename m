Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F146D2D0
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305779; cv=none; b=lJE430i2fog4MzLdyWUrmul8JPooiMRkgsX0d7LAEiAPUnJxdymD2cuEw11VKt3dGz1IErXo4IoFlm7lvrRiUq4H91iHlXPlyTvl7/tLa4FxMlLUE9yCuaEgaglKeAkjbWA1nRDGSCrAX34av8JgeCPEWXuMUziNIxWjS2nlIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305779; c=relaxed/simple;
	bh=h2Q0M74fb6yudEF8zDu1K70Lt8wJfWd+FJHyFrYnfK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8kTrrGpVXEEI6UBfHR5gwool7IL9dGavPecsxeYIyUmqcuFr23SNIxVWd4b2DfbQf4yfNwNZ5tSaaq6n0sjRjX9WNjNW9hoTcooYBQDG7/bMyUHD/lIwDtP39BglZX/1JYxcOiOUraEUqkZ8NCBNVGcsOcXV8YMAgwPWg05j/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yRHObLfo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRHObLfo"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4813ea321cdso1341065f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305767; x=1787910567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjkcq8l0GSb9YOwXmla3++8CiBcoyxIkWo/FH5SvfOY=;
        b=yRHObLfoToUFaETJVNEIsodYXUXhy4bnofOQMJGo5rGXvEpWgolomWuigdAIj/NDN+
         zAB6Jz3OnxeEvCSAnJCPACSg2Ref5w2ulMHAbIkrKuq6Ga/3Uz6ss08VeW4QsDdxM59d
         /yGGSs7qx/ok2/CvTxXBSM3wGNxvtSKwxbYcIUIMMrhxhW99K60jvgfynp8LLFP409mm
         5V89sjCr79CEQPWDnweYQupJx0z5IRW0VPSef20U81T8joKK6soWgbetUK1MdqeqkyUR
         PWsdMXOrZ6ua6HLGp8XQveK2qTMyHV4t1T5mGrpOO5jzDtpdi11TORBGJKoph53WPhoU
         wRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305767; x=1787910567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjkcq8l0GSb9YOwXmla3++8CiBcoyxIkWo/FH5SvfOY=;
        b=QFHqST219VTCgvepC5AEZmppgQ/aZ3fNlVwcGN1NVDHiSfqvqbKL1iZ/rE8JBNfjIn
         1dgkd/aMQn+ZsVe3aGzjydiMGpB5eJeJTaQVb4Z6U0eHRpSXYuTt3CsOgFmJ2ZAxfYxY
         52RIoqrEAGgt8Sp71GVw1fsL5QTZAhxuTSlxm+M+I//ODez5uY/muVpmEAWZh3zj0fCu
         4VOX94TuCVShaJ4QVUk0k8SjBrbS9e8dA3M/er9d0A5awDPTnH/+IazJUv2/67/sjoN9
         ogakhfS6uRFWMpcab2K89jvFRwhl2+1/FdwdJGm8l99cSvwY5+xtEXHdIuR4njVtUuZ0
         tNZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtNb59fzOwdcKOK/Hm8dqwz6Eaw8cS3J57UrXy10Z412j0mVqkYsKxSOTLkDQI83Bt0c85RxuuVbKn8zL5KDwU@vger.kernel.org
X-Gm-Message-State: AFuF++lb11vAakzvTVxSxY50OjhJiyXdfgL4Yr5HuIxoX1tdqbt7KwPz
	MMcWIWN41tCjE2Li61Uh1YhUcAB3j37/SiBjMhFxU7UY2kl6NBoewum8TybEtlfWeTE=
X-Gm-Gg: AR+sD13sxoFyEbCRLb+oadI8nm8NyVbqS+nYODIrtYTzIlqwrCdd1vGGzEP6MrsFyxL
	Cf741CO9T91fG1in4mVqMR67Ut+rPqpOM8OMZnG4Fm6KABbRaiQCGhG8QkzU9Pn7t1XCTQHvYtU
	kn1D6sNJncduUGGC547eKNTDKUl5p8pyhUNzxqw7uIUd4gkXN4UkrFXd76jLivrGnTfebrO/WlS
	+43V6ANvuGPbkmWC0j/O8r44eXt8uv3IaMn3YWcOtF5sf5SikFTtfrx3YiLSqcNb3qKO2sCYY0n
	waJK7UqNIA82jFAKUDb1PrwWrn5Lggfvt4KUmHmYDEM6Z2xx1gHZ8PBBe9wv45FxwMYK9N3HrXE
	Rt44+aAfVtYsFm9/02o698BOcljwhZPRDq8wyHQ8pyN6YMZrKNMxgIX/PbqUQ88Qjv++HiewqRu
	1a367lG//s4aklmmCJhyR8cx+pF3xzgt4EfKbROg1diiCK6Qv2sUCQgf7gDHCp/rv7SChAZr7nE
	nA=
X-Received: by 2002:a05:6000:985:b0:47f:e746:dcab with SMTP id ffacd0b85a97d-482c1184819mr5551648f8f.10.1787305767292;
        Fri, 21 Aug 2026 02:49:27 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:00 +0100
Subject: [PATCH v2 02/14] perf cs-etm: Warn for invalid timestamp option
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-2-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Instead of silently returning an error, print a useful warning.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d2861d66a661..acfdb3f53821 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -176,8 +176,11 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 	 *  0b01000 Implementation supports a maximum timestamp of 64bits.
 	 */
 	trcidr0 &= GENMASK(28, 24);
-	if (!trcidr0)
+	if (!trcidr0) {
+		pr_err("%s: timestamp not supported by HW, disable with %s/timestamp=0/\n",
+		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 		return -EINVAL;
+	}
 
 	return 0;
 }

-- 
2.43.0

