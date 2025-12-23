Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6633451C6
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509253; cv=none; b=UgQ/pYpdCUK58n7/r1SZt5hD5gYK8z7vgWlSGSFto5+ovBXH1mrU1ng+x8SNpWaddcjwM5VgldFc0tnIbzN+QvGZoOWuXIzgQBeLzRulonIaQ5Sxqr5lfgb5/boOfpeWYjs9wNRyN8dKuAagm/dzgpAhE+tuIsE5Cvn7VtK5epc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509253; c=relaxed/simple;
	bh=pUYrmgn7uq9Mo0NK2QK9zsQpEV/O2MlR+EPzwebQhY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7jvbxrYZhdFsn0Ih4Mv35m0+UDkZT9QbUnJagKR2MSS+QOw/+Zcr3yfYqbS6KRDbQEXqj8oHE0GL0kdkBltbn2gTF0nxZBPVzK3RrJXTJ+2kKgTTw/jf2Kps5ppnpQ6quGBzXl+JapSGfx4uf9NhCuvDNZ/tP4MVfP9lDjxFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uYb0uFmO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYb0uFmO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso21569075e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766509250; x=1767114050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jY15ct2AtdcJrqbdqFR5HlO/a9tT55YDM1xtJfQUjyU=;
        b=uYb0uFmOTYB+3NZ7nKHAPMYhgF5VNNTDM1sNPrBEu7LX+BnT4xOJOomM/83nFkT08N
         gjCd4ybr5JvskX8O7VdL7wdiRdlQSrNobuoiw+kWFdFa0AXMLA7fCnmkjB+PWWYHDpA6
         HVIbAYeQrOGrPEStSduVZNn9ngujRDm7gbRvZWbu6K74ogjUs06aE2IrD/bNp0BCV7SE
         W534URxbXT/saSFcCIgBVFzjwdKie6+HG3skaFv31XUTQ3ap06AaE8iFcxP0ElrdMBa7
         P1I/pilHAQNbGBB2KlWjosouKJoantDqVuemTXsyli0JeIZSIY6/QaEREYkaYiSLwphq
         Iv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509250; x=1767114050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jY15ct2AtdcJrqbdqFR5HlO/a9tT55YDM1xtJfQUjyU=;
        b=Xuafilvrxyb6lyOb5aAwMvmwW//4K5bAtboevQZluJ4H0StQ+L/0H18q0uwLwGKY2I
         x2VfYgsY6LxXXwNJ/b+jjVxjJt9EQuhLVlivqAH0HNGZT5yop0Xkrr0Qyz8C02YQt4lB
         0XUfSGf3nwh1BIph3CK3G85NMoo6EvIk9AA17RcfMluHvqs6idIhDny5Fl7OiI/qNVOi
         K3M2H8XG+YhcbDEWwgVM+Uq6eLDa9ekunetRzKndjJwmMkKn2eK9R0gRyDHPrHR71lls
         YiEHWZeb/2gxVK5hOyrk0OognkDdZw9Bl1cdj1+jBO0XGiXqJKzyWC8htygFqMGzzYFR
         +vYQ==
X-Gm-Message-State: AOJu0YyBA+MNPGsgdxyw7bBoStUX3ONF6Hr3ypL1yMXxUdx9UoCT7dJp
	54FsqjBqdnVYpcA4eJ8a/deoS8Dz1BaViKeFluRppgQRXr3WD999dmIL76eA0Qkg6Xjdclh80Hy
	u1pTPuwM=
X-Gm-Gg: AY/fxX5rgeXuuXVpLX4Cn4EU7t6Wu4M46V2ZMdH/ivb99LXckkw0SpzJb5nA81ukEG7
	fJedWBMjAq8wtbJF63RsDvpAfUt/b5cH5r+us2fGkwxZWEr4V5gwHX/Uw1f38rKOIYHHrpd6apP
	9Z4ielMt1PA3DgjP+vCWpH8JHJAfAnTM+uk0KQRdE7n5Rgt75dSB5sKK0LM7VRyZHeUKrZ+k4+K
	LAy7RJzImqqaZq8NxSeJrzSU9OLfCyjUT6ZWEGkMmNvzK4boAJCxwCqtv8ree16UTBWKFrzunJm
	/gGLTz0/KmQFCXyhkBK4XCz1PJl03WP85PMnR/xC3aM9An9C4bh9pYUu6gCD2cMC93Fq4gF3RtQ
	SWgn5xHpqRCdm6HUblVzx/ZTkBpIApbxN5HSVL7tcHRUrfUZ5z9hCy58jh14okAzOkaKnOeLOjg
	vYzzLOewlETYdBqaGus2HX
X-Google-Smtp-Source: AGHT+IE2RrxdNBawOcJgC1lywM/+u8T2O5P9U9OWWUIJAKyrwXRhaIEa/RxLHYXY0F/IIfkkW6BZWA==
X-Received: by 2002:a05:600c:1d1d:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47d1958f9c5mr146273855e9.26.1766509249044;
        Tue, 23 Dec 2025 09:00:49 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm28895137f8f.7.2025.12.23.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:00:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 23 Dec 2025 17:00:25 +0000
Subject: [PATCH 2/5] perf build: Do all non-distro feature checks in one go
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-james-libbfd-feat-check-v1-2-0e901ba32ed9@linaro.org>
References: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
In-Reply-To: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Leo Yan <leo.yan@arm.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

None of the if statements or variable assignments in the non-distro
block actually affect the feature checks. Just do them all in one place
so the flow isn't obscured.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Makefile.config | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ea6636a09a95..594fe3ecfee0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -923,36 +923,28 @@ ifneq ($(NO_JEVENTS),1)
 endif
 
 ifdef BUILD_NONDISTRO
+  # call all detections now so we get correct status in VF output
   $(call feature_check,libbfd)
+  $(call feature_check,disassembler-four-args)
+  $(call feature_check,disassembler-init-styled)
+  $(call feature_check,libbfd-buildid)
+  $(call feature_check,libbfd-liberty)
+  $(call feature_check,libbfd-liberty-z)
 
+  # we may be on a system that requires -liberty and (maybe) -lz
+  # to link against -lbfd; test each case individually here
   ifeq ($(feature-libbfd), 1)
     EXTLIBS += -lbfd -lopcodes
-  else
-    # we are on a system that requires -liberty and (maybe) -lz
-    # to link against -lbfd; test each case individually here
-
-    # call all detections now so we get correct
-    # status in VF output
-    $(call feature_check,libbfd-liberty)
-    $(call feature_check,libbfd-liberty-z)
-
-    ifeq ($(feature-libbfd-liberty), 1)
-      EXTLIBS += -lbfd -lopcodes -liberty
-    else
-      ifeq ($(feature-libbfd-liberty-z), 1)
-        EXTLIBS += -lbfd -lopcodes -liberty -lz
-      endif
-    endif
-    $(call feature_check,disassembler-four-args)
-    $(call feature_check,disassembler-init-styled)
+  else ifeq ($(feature-libbfd-liberty), 1)
+    EXTLIBS += -lbfd -lopcodes -liberty
+  else ifeq ($(feature-libbfd-liberty-z), 1)
+    EXTLIBS += -lbfd -lopcodes -liberty -lz
   endif
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
   CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
   $(call detected,CONFIG_LIBBFD)
 
-  $(call feature_check,libbfd-buildid)
-
   ifeq ($(feature-libbfd-buildid), 1)
     CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
   else

-- 
2.34.1

