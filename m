Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F82E8E0A
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873528; cv=none; b=j9YIdFF2yMpoQyMIr8UrgRD7ExulIC9DvNknOUIn+CNsF37MBlRZOrMmuLzjQgjWM8UAOvr4oepmebmX/NAa3rVdw4T+sMtO+QRDfhgIEkzY7N2MWcpBZVqWM7n+8eZwZVRo54SPyMuKDm/ZC5ih7IlzHGREFYjmiDHVKNvjubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873528; c=relaxed/simple;
	bh=/lWVvuqK7ZPO8OlTvbP03ml/m9hkltI7r5Lnp5abMlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SCmdJCYEMirkRKSdKIMV7sYXxKXD2AQFI+QH3GgFerKUiu1C50gZbMECjXdntWhtZajIOpVOw9OpmGBBJNJO/OgFV5ZXUZ+A5uGFup38xIXmjii2v6rkEejqP2xoYm68VOvdPJsYOgqkOamwhVI2RUX3dp+zVHUTchpGxFAjt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6gCMLKU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6gCMLKU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458345f5dso41999445ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873526; x=1758478326; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYSFwqlAy6DXlbte7Dca09XDOUDeXcrwb6x4Txuv9Fo=;
        b=W6gCMLKUf1Qdm0m8sZSIvC6nlStPHkMem3QGkMeeU/Jyn0BZIb+fvOMieAe2nP8Lct
         4i8YONekC7OySn9xo4aHCYd5t/D4MkOhXhqsZWnFMVHZIY0svCcsXj9XlYmgWeIRKklj
         uOaZVw37+qBD7I1Q+2ORHQwtzjoI1mn1JBqPs3sEE6jAKuMk90qf3Jyx2pNhzb3vbGcj
         PiKtjrre9fwcRdS2nJU20t3vC7mRWXnPcbg2Bj8Ot4ZLQmTuQ5wdI89Ehb+UR9nOGkPp
         VMSgY+aH56YJ8Pdqb73hmJSFhfCLDANoMsKmw2nIBPKe/sPs3mfsmftvc+sHRpn3HlDS
         e1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873526; x=1758478326;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYSFwqlAy6DXlbte7Dca09XDOUDeXcrwb6x4Txuv9Fo=;
        b=MrWZCTkE5KJtiAx099W/pc8kRdF17Zxc47lKguLPrXyxp+YlpMnrL4I1QHu6sZ/nQC
         3uGUIa0LURHoTJj2tQFXlA66th7IDT1is08A07j64M5rXejebakQ3EG0M1mKFY+wP2xG
         CyEf62mQ/79g1GUqmQiD8raTKIOJ1jbG5MKyO29X2sIxkDzFyki8gWZRK92HwSJmZvxu
         ik5DHdmnaHplxj51kifhs+LM1fegR5uUo6k6S0meJ9y3/NGUGIgsiwDfGXqCz81AFgbA
         FjSV19leJoJ8w6lj822NGufCRR7symYsEhz54HNWWz9YOcAZDw3+cY6kqXSBzuNvzS5y
         dE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWScIp9vOXULnoKdXT1rx2DBeQqQACgbnD7wUlJaIM4M5SptaCr4X8LkbaWp+TlhDbKKmEWrEB7KysfCoP6AcA0@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLcO1szCR5rsndy5dt/k44swa3c2jC5iih3KIVY57T6RscWqO
	TXJQgV5nMrTdrAta0Z47WfhM/DLoVFM9Vh/8hD3b+BJFhZSnbFBUqkU3+b3QcswLV6g5dEnaWSu
	JMngEP8dtvw==
X-Google-Smtp-Source: AGHT+IEEErKdREcN8hd/P7bK3uoM7X5PVPYZyYex0CAoLECSrtA99Rqt2eeKZc9BNuOL1rvt04CzwP6Ktni/
X-Received: from plsl15.prod.google.com ([2002:a17:903:244f:b0:25b:db75:cd39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1590:b0:24e:af92:70c2
 with SMTP id d9443c01a7336-25d24ea0302mr124377165ad.24.1757873526082; Sun, 14
 Sep 2025 11:12:06 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:21 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-22-irogers@google.com>
Subject: [PATCH v4 21/21] perf test: Make stat grep more robust
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

If no cycles event is found by grep don't fail the grep.
Tweak the reg-exp to allow cpu-cycles on ARM.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 8a100a7f2dc1..45041827745d 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -196,7 +196,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/[uH]*|  cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -- true 2>&1 | grep -E "cycles/[uH]*|  cycles[:uH]*  " -c || true)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.51.0.384.g4c02a37b29-goog

