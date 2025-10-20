Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DB284684
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976573; cv=none; b=Iiu70feEsTQEIDy0ho1oJzQG/up9Y+W1Q8c0PpDWu0CYC5vbpImhAZVGNzpnlLIESvizw/llT0h7nI9hpITTGIjo4LNS3JrIp+HGFsvjR2mPKW0CqS82qf/l61LnsxcPNIW19AUSYz1nwqYKyNWQdU2svDeUhNwRdRs6dBSWP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976573; c=relaxed/simple;
	bh=ha6ie/2/u6zJrKwYTajAyrhyL5xMgX+Aax8ZNcQwaqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UuNQGKAkG1rU4n1UXehyNc7cPZ5+67seAVB6syau0dCaDwv1t9wdEP8GX7iRRF/EvuzwEkFuz6oCjOIRl0ijMT8uR2NQ96QhPYwgF6d2GCWICpS8Zf/lIVOVvXgH1c/spkf9iKC2fq1E9hMplKdL1/KSCCga8su3wXr2ejim4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSRivX1f; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSRivX1f"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso40591995e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976570; x=1761581370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdGV3pXRvDZEMUVAr3wBUVdjxRZ+XlT8jBZ7bZa9MFk=;
        b=NSRivX1fB3h8ImFLmeyB9+P04/MCuwil2D2FB78RFUg+vq80a0DukPWYw4stJnIbmq
         S2E8JWfs5skricbml9tg0XdAxIfYTaBbRVU4ED7FBpJgvMfhHah7251Hswy2yMZNeBgr
         lsk2xgRN70spAUv8CpUrefh5/ueaPIw50kvZCCZ7TboANyE0nK2iO/ml8puoc+W/ljPd
         K+0CI+IdJRdWV/VPJ7arObsDwfRiUaZJE4hDoKSZrBvP4hQCPE5y3p/4uDj78sY41KGG
         fvPFtbBvKgvYP00Ac57DI/4KD1Jy1YiaGUcuEOG31M24PG10MY1vEecK/670RHn6VDEL
         0URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976570; x=1761581370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdGV3pXRvDZEMUVAr3wBUVdjxRZ+XlT8jBZ7bZa9MFk=;
        b=r4PFlZWhOUWtFK80J9YlDWUxSfFjqbUt6NV96saNuNEza35Y4R2cozU8i270t6Tm2o
         jquLPkHSmQRxU6oB6RKUgjpeMmeP4Sc0xcRgvVI86/BeHJOqXevI5/8YyYXlOOcoqz7f
         SjMDSo7U9luYhr0xpowfvmOCh+Updo2ZR7kHUuREP/weMn2D9geu76w4f2zCUkQ93QNs
         Ga13sW3RiUvd8ciXytd1W54RBpUc1yD23Lp2pbdRDucGZMxxWyK+BILsBL2evbmBPZ15
         /1YpDizTp0zatrA/6qjxMSAZDySeGRpEnXRNq0UiJ5yqBHH0aRgFw4M1kH4/PQVHEGX8
         yFfA==
X-Gm-Message-State: AOJu0Yyew4iStfI5VmpiwK4ZLtMUTN97fn9kBDjaM0O2O2rr996QCi38
	oM3l00CkCYLq6PBJBPh+WJkXGJRMHmX9SPnSNp0/aujki+4FKofLL2prjyFYZ5TpabY=
X-Gm-Gg: ASbGncsctDCH++hcFihovN/U8TrhTBzZOkl0QyoDys/0eakQ68w23pW8qsQ3Xdxpbmv
	umtxol3QF6g2IZccKr9+p8qxwVsUT1xo5ieg7ItOfaEn63XZraRQcqWhsjltBCFggkxClFTjsF9
	eT0FAoziKY2eJYN7OAH3DOcrolmVz45li4qWYjmPeK4ifPO20VBUDF7zSDMrpot9sJS9f96OtTj
	As5LL8b7+WjrfVsAXesBwYMNRbTVgt+4mp9wuEdm8JoWszdtvRDmIGC9kiTGIUI6IM0MFvfabjW
	u5sEI7iAf26xNMQJ3jAkTYtUElCet188CkNmNxNm6yQtfWPG3hZIvHioJN7nvm/oTgyogCAVtpx
	x1fhYrMihPy0NvZy/twCMJXHj6S/6IoNErmQ0RbxTKpMR0q5ErJ/lPY99xylsHh05Plp7oJM6QB
	gzeVLEBjo12g==
X-Google-Smtp-Source: AGHT+IEpD/dgfFxYo7Xn6Vgdco+3DDr06fnsR0Y91h0oS5NHj2q4LVKHPL4JNe8M5lo+EseIF/VeOw==
X-Received: by 2002:a05:600c:34d0:b0:46e:3550:9390 with SMTP id 5b1f17b1804b1-47117907a3bmr93162205e9.20.1760976569664;
        Mon, 20 Oct 2025 09:09:29 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16408067f8f.28.2025.10.20.09.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:09:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 20 Oct 2025 17:08:28 +0100
Subject: [PATCH 3/3] perf jevents: Suppress circular dependency warnings
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-james-perf-fix-json-find-v1-3-627b938ccf0d@linaro.org>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
In-Reply-To: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

When doing an in source build, $(OUTPUT) is empty so the rule has the
same input and output file. Suppress the warning by only adding the rule
when doing an out of source build. The same condition already exists for
the clean rule for json files.

This fixes the following warnings:

  make[3]: Circular pmu-events/arch/nds32/mapfile.csv <- pmu-events/arch/nds32/mapfile.csv dependency dropped.
  make[3]: Circular pmu-events/arch/powerpc/mapfile.csv <- pmu-events/arch/powerpc/mapfile.csv dependency dropped.
  ...

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/pmu-events/Build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index c5e2d5f13766..a46ab7b612df 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -29,10 +29,12 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
-# Copy checked-in json for generation.
+# Copy checked-in json to OUTPUT for generation if it's an out of source build
+ifneq ($(OUTPUT),)
 $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
+endif
 
 $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 	$(call rule_mkdir)

-- 
2.34.1

