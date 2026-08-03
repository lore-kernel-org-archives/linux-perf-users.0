Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D42264C7
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793843; cv=none; b=BmzwTrDG/n+oZkgXKUbeYKyerhNlwZ+WplHY1DPlFV5nhgADHIp9Qy/o89YOupKQ5S6yI6OZL5CfJzKydZCd7NeBMJUuVq7mXXSUAxhMeswViwYx6/3/jJlexEivwbKLj7cfzJBjAJXu4hQjIWSwst3hhtIgMmwyz82oiLN3H0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793843; c=relaxed/simple;
	bh=NjWtQo+kEGc/x7EaUY4qqsEwJfhrVhDbA2oa+bQc0gI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gTUnWy5bKUQN82dxo+vpN519cPRHC/JpLweD3XWfWe4q62To1LSXajSK/vQ5uPbmljKEfpCFd57Ziqjvsus8sptvPmpjk0XEVoLN80Xs1DbgJcoGodpOodQeGzxM/mCdp1fZBMEKrJtIWcStvm80pYSmFTUknRkXAKnVIZTQ9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eb9XcgXk; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eb9XcgXk"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d02df2bf09so53515155ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Aug 2026 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785793842; x=1786398642; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mR2tn6efe+5cHDvaoYCDlGHvnBKMWujaugvzLeKnhGE=;
        b=Eb9XcgXk5AG5GmfA/ItFbEamYH3MnWlCjhbM8C2xL2Y9wCGHhBfM6X8iOFc4mw+PhJ
         omrdWQ8RuBaKy1mewln3LramFNz/ptsPxCu/5EpOeK9VtX4SO4R4AEFiZpJ61Vdqjkcu
         MVmqea/lwy4ZQ4w+pQjfrFy/7aSljIUvnwEggfy/b+4jB2tOEvPIJHYlfP2Su5HBR+h+
         U1qjsgfH2ZYNWqRIY5U8sDaKO5txKyHAg9sHg8UMSeogfft19+Hh9aTf7J8NUKcnNVtZ
         q1Mz5FRr6EL8ZDWo6ZtCaoVOI0vXbZIWM/199aPNPbRtybzY/18/ZCBpreKoS/wg/8lO
         QoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793842; x=1786398642;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mR2tn6efe+5cHDvaoYCDlGHvnBKMWujaugvzLeKnhGE=;
        b=LYT6Ay/yFX2O5CXg1Kh8cwjmLPs2yNQJXtPl8cxWygmSrdsikOxMr9JSMP5SFCntYk
         yII1JAzQ5VghD1PrdROyWgrPoazSUmjZPRuARwv43uD9id/sMIUhfEtC2EVWYc29n/kp
         ppeJuwt4sVvGkYnpIRSE5YE3e34saUE2Mb0LNZE4LIWpLbFkjxybbbHdshRPtdbzvVq6
         w7Gh2sLGaUC0yYfuqivcgdPsejUMeHAuwEP5Ls3iFfE3UmLGuzB7sg0pTzm40DI8U6Up
         Kh5eeTi9HFbGwzYJHT+EmeMsLe4tm//31YYj5IGaikigTMujLvy/7qPjAxdkXsdcKoeN
         Jp0g==
X-Forwarded-Encrypted: i=1; AHgh+Rrt7F7xIQrKx6pGcXygTHfP1hG0z36FVU0//uhfiRD1A8JsdDj1FJXsvi7Tj+Ffe6Ajx2i3a7fMgyA6/ey9zuJS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UUugV7p0knLnqyEArc3tSU0CIWNedz3Mn8jIdLYwlHikZbTh
	NGN/TAsUdOSOrBJp30O/GvGrjnwmW6jmkF3s5HVRTThKR5jBMXRZOkkh+Tb/3s/WhMexfk63TuB
	yBOR+Vw==
X-Received: from plzw9.prod.google.com ([2002:a17:902:9049:b0:2ce:fc90:1592])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa6:b0:2cc:85a7:36ee
 with SMTP id d9443c01a7336-2d052462dc8mr120177175ad.32.1785793841784; Mon, 03
 Aug 2026 14:50:41 -0700 (PDT)
Date: Mon,  3 Aug 2026 14:50:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803215028.834556-1-ctshao@google.com>
Subject: [PATCH v1 1/1] perf vendor events intel: Fix Novalake CPUID regex in mapfile.csv
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Based on offline discussion with Intel in
lore.kernel.org/20260715211144.3144895-1-ctshao@google.com, we decided
to drop the leading zero from Nova Lake models 0x01 and 0x03 in
mapfile.csv to match single-digit model numbers without zero padding
(GenuineIntel-18-[13]).

The updated mapfile entry was published in:
github.com/intel/perfmon/commit/00167baed45ac3b2708e89dbf1b9ce4769e9d115

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 8e4ee898942c..e5d90825041b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -39,7 +39,7 @@ GenuineIntel-6-8[CD],v1.19,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
 GenuineIntel-6-2F,v4,westmereex,core
-GenuineIntel-18-0[13],v1.00,novalake,core
+GenuineIntel-18-[13],v1.00,novalake,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
-- 
2.55.0.571.g244d577d93-goog

