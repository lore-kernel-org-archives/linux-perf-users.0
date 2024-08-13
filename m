Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4819B3E3
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555540; cv=none; b=gOYSKLCaoRaSvSFSzjDnfLfDko4wydINzoQcOEmM9+hbScRYmwZjH1tnYXA1kuqDQJ/3wM8idH4Z2EjzITOjMs47T/ww66tUvW5IZm4/ZqT73NsmqMg6PPz66AxXDOhOuU3OxNwRCimDD9bUp1pbyf+B1EJeLB6ZA6m8Fo6NwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555540; c=relaxed/simple;
	bh=TCmY5/W8UjZo5v+UmsAxTLf+W/oV6ui66khMLptw/MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzxjDCqvCK7nYFBeKJH8qyfm97IslP+Tt0vbxztRPfCE/MupdMrqngfISUs7yAD5jdbC2ksYXbCbkyvtdnMcMtkT3Pz5Lj5C0MTZezzhXkjJ/boMB02ipurMhh7lia0if/jYw0CtvDmpnCuy0oiHcAWt/RUNhjccKsD7w/gaLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SyEubhuE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyEubhuE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso37037995e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555537; x=1724160337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=SyEubhuEKik3hYXSQIEkZ30iK4uJjqe3fZfSo4RIn9Iz8Hz7w7TDuqAiDazlwSIVbV
         4gNAe4IJAdnPNivrWzM8C7i3vRuibrUMXnIcjCN6bQcozqS2O8gnMTcRCXATEfg1hC/V
         r5bfi62NgxifckMKRxv4d2MiPzZQRylFom2MJWXoMVIJrfv+7DoGHdWmBTsj3/zzPveG
         fWIxyQJGy+cp+XcLMVkGL3iSHTrtMewDIJhoC4vJi0/UJuwFA7PAwapcnEQUwE+dHbAT
         g+whSboAI6dGGva1UYlI3rvZqmFjJfdr6+xR7wjYtRzeUJNYLUo9bTO9FUJYo7Jxa6RR
         M5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555537; x=1724160337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=dq1AZfugoC1awFkipuKMeERI+PVtajDw2ajdxunBibAuzxRw1GdR7JF3Puo1PJOlN+
         n9HdTJCBZd8AQ+S1IocL7Pocx8OgvWAQCqvlnXmBtn7RTKPCw38XFadzwot/a+3LOKHw
         qBJqVPupJMRuJIDxtC+HPqZxZUA/kn4TXunRBPkqHM3sPoCHJH96J+2i7xMmxbZwJlMK
         4PJMwtJlXzzC1st/K5QI3AFDgDItoA7ci3t4pWIRzluXofprb+HS8yxX2LNLnHByxiT8
         4I7COXPLpURHx+PgAhdLN0HWAC6cW0UDINAlr2Q49HMqJ9lBdeYw7/01zQLLh5vX0aCa
         RG+g==
X-Forwarded-Encrypted: i=1; AJvYcCVeb+CCu+3E6zT4Stt3hdZr+5el/72u4E512jOH5NNA++TnA1qXe1yoUaA/8aXcTzQYPT5zdMn2KDN0eh5J5bDl/L3/WrXZw1kCDQ4BLhEuOg==
X-Gm-Message-State: AOJu0Yw0GKh0T1dBs1GzB5mjI2UflmlmkWjWBrIsvAuD2ye64T+xITn1
	DykpJCIGp/hRfgP/fnd0zt8g5rBA1zDHpD6e5vfEl2yZqbys1z6UAEEjgnOOr+w=
X-Google-Smtp-Source: AGHT+IGc9t+MTAwYwGAaBX95OSnKFftghFZ3NfLAkZ7AAvwA9zVwqXl0BELY2LWwoeQ2oa+XAXA1ag==
X-Received: by 2002:a05:600c:3550:b0:424:a401:f012 with SMTP id 5b1f17b1804b1-429d6269733mr21164045e9.3.1723555537440;
        Tue, 13 Aug 2024 06:25:37 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:25:36 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ze Gao <zegao2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/7] perf test: Make stat test work on DT devices
Date: Tue, 13 Aug 2024 14:23:14 +0100
Message-Id: <20240813132323.98728-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
References: <20240813132323.98728-1-james.clark@linaro.org>
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

