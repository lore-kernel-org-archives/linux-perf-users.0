Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847625776
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976570; cv=none; b=EAZKOXfntq4iPy8xfQpqZIvdXNGqg/7XOiLxUOry3YznfhgGgzIbEADfMF7DEzsAkaIMIyPkaut0LobAG22Ou6KUww1q+KCAYY4QE2pFLX/VrFMS8hSooEwViBt8G3JnI1DcBRWOxAJXAJoKahm6nW1/pQHsj5HAZvfIHm7fVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976570; c=relaxed/simple;
	bh=2QXLP6SK3lKgJgIXqDsVNOIENOK0QQBocNMXMNGWMiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q/rduo/tItRaA6zKsjDqnDHDgtwyeuF8kY45xYZS5XFDW0TD4v1orHhGvCbezWcFMNTCPSgw56jaGngeCryxYNHKocIEjUGf9Wy0H2NL9eGVnTREdKnseseHfl/j6rT2PpWO6JnhE9IXOKmEaQKC5fROdzHYqePZA+InpTukMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znzkp6gV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znzkp6gV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47109187c32so21735555e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976566; x=1761581366; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pk8YGIw6vGecLqDCrpvEphONom+Aa8XzZmAi261ujCU=;
        b=znzkp6gV5lA60sZRuX45Pt+78DSTtLjGTOUX+bH0ckdoDB9Ei7WUai5XzBCmcuAOHr
         i0yc6WsNDE2pnejOAfCw3oj8SxTFO+eUSvKQWJi/ZGM/qDS9/T7i0y2+tSLLy+IS+gG8
         2pNEI48IqPPADzfUXLbKS5I4GhhfcODj5JWJ9R+7w6uF3jcnHunW5gwFmYdt9FChvDKJ
         BGuNJ5Bjp8Bnp53mX7z1jNrHN0aZ9ZsLEy4watOzAv2YMDGL3j8JndlLA+9o6f6kIQr1
         Fa1YcwQrQZrxzblvKJ9x+N1Eg4b7UEExB8Q4s96W/NCHGydUw0m3ultziRlPiAgF6Pix
         FSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976566; x=1761581366;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk8YGIw6vGecLqDCrpvEphONom+Aa8XzZmAi261ujCU=;
        b=ukPq0zgvmeeeQ0ZvXoKJRQ0knq05qfcsM7APgoeVxiLAX6hjh2d7JNBcLkLTb/1ovK
         auiPgD9+Ni2ZNRHLQ0wxemXX/GBMLOlXCabKQvei2FLCnfr6VAu4JZ959+qik1u334qG
         eJt3X7SKojSpMM2N8f1ZxIfQMILXCL3VZjgT/01Jh8YZvUCYCaQMindAQrgiGfxsfQaT
         bFhyUVj/hA3XftPRhWBPR2R/DwyXpfmVSj5akpc8xikjsV/sKNVLNZY4iDIO/ji65zch
         s4tBLStYXRojF08EKlakXG0dKXi8h9isbEAsbZViq1Jkp67rmrb8BFoXUjRt6D+lEfY1
         G5EA==
X-Gm-Message-State: AOJu0YxgI93SnkAW0fNbmC7T3rsx9OlNQFbpC0XDtCaW9ygfBHHkwnaI
	12sfgZOkYznv42MbDed4j9SZQiaCqUE6fdHjIzwSPYeJZ3qMyG5OOT1S6B8wyDNj78E=
X-Gm-Gg: ASbGncuer1zLQYHhIpEu8vLgVnnKsE6KQ5i0vLv7J6Mse89r0y2PtIqljBbXYnBF9NZ
	/23QwuMAyhmwbLLjeAWbQgcqdAaOAdshJxreBfj67zMu1BPO80JjoTwKH2xfa0djmFJdcLTIGaf
	rR5X2iRcNPiPLvssnEa4mjrnBvN1qvuMiafAAXE0TZtwnBCRS0FMAGvThFgnfzr48ZbJDT2uJV5
	k9EJpKO1ElUnxsKmAU40xtqodoup2z0d+YZJSwSV1tYWAWWv+njQqshhUoHjwPehsv1Z7ut0CxZ
	a6n9H0XfzUCebAYoQDZa1L4VMN0srEsFEXwSCrHGn0lHRD8AuJDZXiRWeHqazm+5IqBE5ngSSt3
	SUOBARJ5z0xjJ795tS5l+vbNNAaqFFT+xEbI7WRGP7nU/1dhsOqeQONPm+olad0ImxpL9lG/QRu
	owCBlz6EI9Tg==
X-Google-Smtp-Source: AGHT+IH9ev28WRuhzDTHIVO6uset6CmxbofPJQPzPY3DjQS/+NnjZudW3Wzskkz3N9KsfAEPDlvMlQ==
X-Received: by 2002:a05:600c:828a:b0:46e:5a5b:db60 with SMTP id 5b1f17b1804b1-4711791c4eamr97032365e9.31.1760976566515;
        Mon, 20 Oct 2025 09:09:26 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16408067f8f.28.2025.10.20.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:09:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3] perf jevents: Fix build when there are other json
 files in the tree
Date: Mon, 20 Oct 2025 17:08:25 +0100
Message-Id: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHle9mgC/x2MQQqEMBAEvyJzdiDJ4kL8iniQTUcnsFEyIIL49
 x32VgXVfZOiCZTG7qaGU1T2auL7jj7bUlewJHMKLgzeBcdl+UL5QMuc5eKiezWoiWPOSB5DeMc
 X2fxosOB/Pc3P8wNZXj9TagAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

I hit this issue because I'm using clangd with a json compile database.
Not sure if anyone else will actually hit this, but it's not impossible
and the fix is trivial anyway. The first commit is the fix so has a tag.
The other two commits are minor related cleanups.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (3):
      perf jevents: Fix build when there are other json files in the tree
      perf jevents: Remove unused makefile variable
      perf jevents: Suppress circular dependency warnings

 tools/perf/pmu-events/Build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
---
base-commit: ad83f3b7155db28e82de24dbaa1af2b8f5d972a3
change-id: 20251020-james-perf-fix-json-find-9ffed1e52693

Best regards,
-- 
James Clark <james.clark@linaro.org>

