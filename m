Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A31547FD
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362236; cv=none; b=Z4DsdmQPyogFKKt/in3x47nkJpjIUzJ74zxJfcLZar4FBwZObeGY9yU4pFe0izqh50pZ7FNLapPTQcqAZiNAAyF9OnoE6gtHBnRnwrfeiWP0FxF30uV3RnkqZL08QK3+1iUh1UTvq/jipdmoBcv317/9YP4OBl+rLaSPWHyOhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362236; c=relaxed/simple;
	bh=uEkMebtlJ3oS+pP2FKl25/DE83+yiPQjb4Lo5sy18SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHj5NqHTjvVnNU/8i/IE2c7zBBM/ivL/5WhA/nIscLOe7ExCOMz5N7zbzNtlz+5tdzIEGZGf1hzYi3w3oBfBQvNEuxuMHfBa5kIpKJuNs7bG9Kxz5bOoWfBnjcQ1lZiTKajT/J1NDQF1RpEMDKruEvL6wSEeLO724t9BXYrVT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X1aVKkvT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1aVKkvT"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365aa568ceso1306130e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727362231; x=1727967031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C2IaRNsHC56vkJV7d2z1hySpqTijtSB8YUkIrjThBQ=;
        b=X1aVKkvTUJK7Eg8qiaPMZy6enfQKgnvDpUy64n5wEa0L5CUDmJ4IvdRWuDcgptoMD4
         vKvdO7wwTbc3YgSg4afO3TtSKx/ZfP+KoHRV9c5Yft2PRRuDM5VpApPA7amvKmNmM3Ks
         pfwY8Hp2JaoYzKW3CuKeJ1F7ukSF3CbnC0CGw5qYMkfsZFshHxdOmvtp88ZHSXrEYUX7
         WIO+r04nu2I9bi7uutLyn8IDO/fdC7/Zirs/dp9FQvNFz4fB8pMT3+6QkDcxOKRfUgg8
         9bBdwesPhECaSY3CWWIsdCBjCMHPJB9pEPu1AWML8G6XeWlnd5eaatUGbK9yb54SG1Av
         22sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362231; x=1727967031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C2IaRNsHC56vkJV7d2z1hySpqTijtSB8YUkIrjThBQ=;
        b=huP6x5S3SFbjDWaKnB+LsLx2IaVQBV6x3/wdBJuNxkwGrUPivnhPc2+JKJV1b3WR21
         cxjTHHdI2+8M3lUNv4cJ01AyoHvxvH7YlX4zb1+QxF6EBt+8IZVvcCXQ8uy5szgaodhm
         4vcbjJQouh4X82PgROeKO+eScKYnmX8H3vQtISq1jujWeojGwT8MQsL4JhoAYINrRxtL
         NiKQefreC2S3QPgMIcJ/FnQ4Ca8h2LZ18NmblV+g3BVmpXnDn7DDjrdMUitmF340tFSU
         aplEfJ2fVT+W9PG5b13QJnFNPbrldxhdbapeC0WIBJ1RL8jOKWFsm/pvWL660Wht7Y/n
         lkNw==
X-Forwarded-Encrypted: i=1; AJvYcCWNMAZgK0FHB6pmgRC9nBHyZZ363h2C7mvb5zQFfClT9Z0/vr4lyOuLVJTKgXKPdQhzIQPdHQtFPoAqGpmxB+WU@vger.kernel.org
X-Gm-Message-State: AOJu0Yybu2ih2WQkMQnzXXZKrE04y7ILvJs7+5o4TdtGr8E9XXXfNQzF
	Sh5JcnazIcxtBQnzzQkuoLyy1p0S5p9PaWp5kHg09yUI9jh93pqFpmJW9awF1j0=
X-Google-Smtp-Source: AGHT+IHFBhIAAGgVt9IOOCYfDDIgsohl3GTjfp4I7Y73RftEYhJ7VTnhJZmj1Oc2A4CYQGF88oJngA==
X-Received: by 2002:a05:6512:3a90:b0:52e:fa5f:b6a7 with SMTP id 2adb3069b0e04-53870496c1fmr5903737e87.13.1727362231305;
        Thu, 26 Sep 2024 07:50:31 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c294833asm5589966b.98.2024.09.26.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:50:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/7] perf test: Make stat test work on DT devices
Date: Thu, 26 Sep 2024 15:48:37 +0100
Message-Id: <20240926144851.245903-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926144851.245903-1-james.clark@linaro.org>
References: <20240926144851.245903-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMUs aren't listed in /sys/devices/ on DT devices, so change the search
directory to /sys/bus/event_source/devices which works everywhere. Also
add armv8_cortex_* as a known PMU type to search for to make the test
run on more devices.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/stat.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 3f1e67795490..525d0c44fdc6 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -117,16 +117,18 @@ test_cputype() {
 
   # Find a known PMU for cputype.
   pmu=""
-  for i in cpu cpu_atom armv8_pmuv3_0
+  devs="/sys/bus/event_source/devices"
+  for i in $devs/cpu $devs/cpu_atom $devs/armv8_pmuv3_0 $devs/armv8_cortex_*
   do
-    if test -d "/sys/devices/$i"
+    i_base=$(basename "$i")
+    if test -d "$i"
     then
-      pmu="$i"
+      pmu="$i_base"
       break
     fi
-    if perf stat -e "$i/instructions/" true > /dev/null 2>&1
+    if perf stat -e "$i_base/instructions/" true > /dev/null 2>&1
     then
-      pmu="$i"
+      pmu="$i_base"
       break
     fi
   done
-- 
2.34.1

