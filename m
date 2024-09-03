Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5F1AD25C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358922; cv=none; b=BskHxbJ/JdXHrqkFsL5P61626b2VF38Lx5zgkFL40MXGoYnOdbHIXpioV8AV0YJoUKy74aHXjAmZs0eM/tai4OUftNJqxkFtps61lDJFnYwPrESG/OWjmQbNMAKTBKBGScW1JYNeuC9F33YiYQ8p+GWjHPorAGJcV45HOtAPGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358922; c=relaxed/simple;
	bh=TCmY5/W8UjZo5v+UmsAxTLf+W/oV6ui66khMLptw/MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ByLHqpWjVs8Q8OiREOyUiNB0/CCQHHcDczpFGvMP659E85aksNeREjprtOLY1v1ETtHygKyEZKlm5Tv+IDuhz6oqaa31fJSLno9a57buGDh9G1lnHnWg74Fp5MBgE/07PniqDfADk49cMOZirsUkC30n18/03DFNVRu6YQALYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9KXqpdR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9KXqpdR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so27673195e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725358919; x=1725963719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=T9KXqpdRcK6yUw8FjCTY3wMO0UJIsDxMVMDoMXeUrw5yNcZ/7diKn0I9R6J4buyR9X
         XoCMATjd82wSIlWEPSywZwCdzlSfXIzWPj41D31tPPo8DsyhKCo6t9TGv9uXEfA/ySWs
         HaGbKY0X2+GCx0YnlIeyWcWiiv/slatxRLu1qxEniTVm6UL8qr/O7RcAvyKLJpXFhl+M
         5+q16TEqtYRF3NKCZ2Jr9LKV2nI1aZzHz5ZAJ8Q9Sr+Mpjt8QEQnBNmf0bPxy7lYthpy
         SKiiUooH4T+835/+e8BKv6PaDlxPcFdwFMhRc0Og/AXrVimMzkJSfW/quP/KHMqYMj3w
         GgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358919; x=1725963719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=Oin0349KdGnpkVhCngtX6T8MP9932ZpgnuFdn40sj1XwIfXziYeg7nnDp5bhQldXGb
         7ik+BNNLZQYg1+7OPZHRZ5t7fSNLzrNCkKxfvEY1nwcLdXgzdLgo8MgMv8EGY3tPWqA8
         7L+ahYpeNknUOdSv+nIz6HXRLLv/aDX35XQC2tmuLVtIY1dE+e0FbBp2FKuf5t6Qf/Lb
         cU1k4H+yTbxV5E3dbpwaux0TDXYN+z4oeiBB7E4eP0naQpbg1E/0/Fvm1QHH+zDR7rr6
         HDw+VTuDa22scv5EoveY40jyfpnH8aA8WUtPlB279gAbsmjtfjfFBPB9ev2hpXJfhWRx
         P/9g==
X-Forwarded-Encrypted: i=1; AJvYcCVIgyT29GlyRDPYVvPqSAyKTM5U9O/CpojE6diATeKj7vbHXgchYqlfjWDBU3SD3MHtU0KIZuauYTgEQjvfUDiz@vger.kernel.org
X-Gm-Message-State: AOJu0YxrI8u2KWE60yzG3mwn8iC3SR4NDXXlzXKgMFrVk6Fva2lvkv3o
	P1BMIvxtF3bBC30jshww3Pub75gjaa3IxDs6570uMKr9jWSvz7gDTFw8gKBF/K8=
X-Google-Smtp-Source: AGHT+IHkBX4KzIJzZmErwYTrZ+5GhpDTKAgX+51Byz51rMyHGi/ROqeYUZBfKl487Mq1nQLo3tEQCg==
X-Received: by 2002:a05:600c:1c1b:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-42bb01b4c35mr118683625e9.13.1725358918867;
        Tue, 03 Sep 2024 03:21:58 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274ccsm168739995e9.37.2024.09.03.03.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:21:58 -0700 (PDT)
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
Subject: [PATCH v6 6/7] perf test: Make stat test work on DT devices
Date: Tue,  3 Sep 2024 11:19:50 +0100
Message-Id: <20240903102005.78049-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903102005.78049-1-james.clark@linaro.org>
References: <20240903102005.78049-1-james.clark@linaro.org>
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

