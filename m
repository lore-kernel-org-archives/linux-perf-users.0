Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0291E8853;
	Fri, 11 Oct 2024 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612850; cv=none; b=fvdceA9t7Y7cxS+B2L8mSrFFkrqEpsvfy3BjbVwp+ZlmFoOim1BO3f0dLwVNkkPmBdBSJikyth7UdpyKnyJPpCqZx2qsFr3MVdkgCiHY1bYPCYqXgKWwK+gy5nas3cqDsBIqgXuKEzCyXyOIqxSoDOZQbAN4n8IyvWRBDNIXd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612850; c=relaxed/simple;
	bh=d5lvLGEZ65TVJlhuGEWaEeJKYjfBPSlaDFuG96uwbRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsVe3i5IREDpcxzy71fBQIQQiWrHRqNXW2J/Fg0xHq7Q1C3fPhCSpCDMlJIM4FvipGwA2+2FgPevzx/NXbkBnwlVucCdAwtpTWRZ672aXACXK2Dd2fDHg2qF8/JlWnPHaZQ7qB1IEpFSNR1Bd86d1j1nyiDzTm/MN3epmlrbRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu54j5Gc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu54j5Gc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso922034a91.1;
        Thu, 10 Oct 2024 19:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728612848; x=1729217648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2reijhdOBoBbFvrgZ4U5IyA3FFXxmpzR2VeqS0lYuQ=;
        b=Tu54j5GcT96y2qhOysOSE4noYv+Slptx7aB4fm6JARsh7kA4QWGD878Gc9wcFY3Vjw
         orUEAzuOWkmx/IEWQAF4miMaGY9nHKPBSe33/fg0L8kAQtGYS72w9lxJ99IBHCptD6Lt
         pP4GnwNdYT1PWEdk5SaQEYYFnI8hu74Qt/0LO+Bfy2NtT30xPTILoh+SOJe8WkGJY9q/
         Aya9d0uqSMw5xbIkT36qcO6Hz2fBTm9plziB7YCy0bSDBZdsQi3AEUG60R1gKwoWIcAk
         2k2NFm5cSNYZsTrfeMW5AKsMza3t5i9BIYkGcfXfo2Q+vCmLNooFqykjYoqBAT3ln+vJ
         9/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612848; x=1729217648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2reijhdOBoBbFvrgZ4U5IyA3FFXxmpzR2VeqS0lYuQ=;
        b=tcio7YZPeeQ49BJpuUnTPCxodW6VHvHTeojQ3GoxZSCot+Ii7wMdYYpcYrOJtvLmyz
         dV7tjJc/6wqervwpb1jFSSl0FyIWkFWBlRftyVd4xiKbkOAP6BtJR565Xpiju5cg22+2
         6U+/M+faHll6SGasqNxiIzkAt+puoH484qkKAawp2pNDaACJc4AJUnq0PHb1NX5ZtICl
         RpizwMa/j85wNnGSyQCFUaxN4e765tP/unqxGNCHgaDtX5Enakz7tzjsNFKF/dQ+EiIV
         FxEENSSYdPWNoJK6eovnizJ80Vccwhz5JZ6r7sD6P4sk7A/N6S9YooltqRWIRKHa//XZ
         e8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0UwLvX8I2vUPWaKoWK2K9+HmTH3rmgQUXXsdrgsMMv7gCdda6r/4dEVjzni4GRDucYRDFlX/AmdWY9jw=@vger.kernel.org, AJvYcCVpX+u9SV0vzDuASXU6wNuEOhi5YnLputpLkwdzrfJnMVxPIf0MvuhCXSyj3L7xb+AZd1SKHJTsQRWSmqtxfRu1Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pHvsHHw4ORKsBf1TG7Wu/PcbqblsP8HrPXMIOZshhqenCnA/
	DajSoHYNen2kqIIMwoIsFVPDR4TityfeKWQNtjs6h9PTSTuxQMOP
X-Google-Smtp-Source: AGHT+IHQE4FfBR3kJshs+4NtrCU3rQz7r8v+pfCskhU2F+pQHBJhfZiz3TPt8qrhuwDbH70AU9nTAA==
X-Received: by 2002:a17:90a:8a05:b0:2e2:ad29:11a4 with SMTP id 98e67ed59e1d1-2e2f0d8bf53mr1516251a91.25.1728612848481;
        Thu, 10 Oct 2024 19:14:08 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a56f71b5sm4393024a91.20.2024.10.10.19.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 19:14:08 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	james.clark@linaro.org,
	alan.maguire@oracle.com,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 1/2] perf build: Change the clang check back to 12.0.1
Date: Thu, 10 Oct 2024 19:14:01 -0700
Message-ID: <20241011021403.4089793-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011021403.4089793-1-howardchu95@gmail.com>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This serves as a revert for this patch:
https://lore.kernel.org/linux-perf-users/ZuGL9ROeTV2uXoSp@x1/

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4dcf7a0fd235..adfad92ac8ef 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -701,8 +701,8 @@ ifeq ($(BUILD_BPF_SKEL),1)
     BUILD_BPF_SKEL := 0
   else
     CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
-    ifeq ($(call version-lt3,$(CLANG_VERSION),16.0.6),1)
-      $(warning Warning: Disabled BPF skeletons as at least $(CLANG) version 16.0.6 is reported to be a working setup with the current of BPF based perf features)
+    ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
+      $(warning Warning: Disabled BPF skeletons as reliable BTF generation needs at least $(CLANG) version 12.0.1)
       BUILD_BPF_SKEL := 0
     endif
   endif
-- 
2.43.0

