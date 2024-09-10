Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A7199FDE
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981523; cv=none; b=OMvtgM4ppNno5CM8/3bFa1YsgUZj4c8S7Fqe9gs76AGVwofSRJPooWn1T9ciUf/z3rbET9oONnxFdmzIX/n2OygIaCOFougsF8uPwrmE/yZnXnOFfNYULYw1UwV0oMEIATbioJR47iB4jwRQnLV0/AOxNBK7EBz1udejuZoGtD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981523; c=relaxed/simple;
	bh=hd7oyorl4TOQWVxg+vhsoBj05DEdVB7R33IhLz/6S/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bto6b41b8mYyGL8JHrk/isX6u0UJOXaRBJo2U6fNEmMyZzhK0okYiNvI5HK0vJpJfWhMZWAfTwvFBnkdnFswaI5hJDryGTdG41tI2YmDPK6FJd+PxJkIy6qqMWDwnztGcvhJhK2JC+JcPF0gD67qR346i/kyWK4JWhYCsigTMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZ1QPh7W; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZ1QPh7W"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c6187b6eso3509609f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981520; x=1726586320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV/wWyP/OuoFa1Q1XSAgXw1mLQzgLi2JT0YhtXRGetA=;
        b=fZ1QPh7WHjyKH+VrNKGazUVUSD+fGshtPmNA+qVsDwEFqoYBTyUitvY76gznjJ03eX
         g+iSoSU6EIwwc/Ggp60IzInmrQolcI/nScRJB9vGNdOybhEJLy3JUBraSrtmoFFo5JpO
         gRJtNYehkRZIE8Wth2xbUz64b0pK9AM72Fh+zUt0ExpVzbzMU6slNyXW6O9r60HT+kU1
         NscqMDFRct4iyULzmT2bL0hiBidXv79Ns4j5tu3INC5sKE8woKBq10AwbYFGtIvx5/6h
         Lzbu0UWsW3yA+JZaMRtYdq6xQcnVz9KSHl+JfrQ6RCdz7ZPsR9W3Bo71t0hu3oBC3OQY
         U/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981520; x=1726586320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV/wWyP/OuoFa1Q1XSAgXw1mLQzgLi2JT0YhtXRGetA=;
        b=u1wAOE9Bq8UTzTM0LdEWiFu1GLkFlXdsFBBfHyDREd/5aDTce1+WAR2Cx5PvdHMJcu
         8ZpMW3Pm0MwjpQOeNoaEaNk8uygUEcgz6KhLSHjs6Ia9X+wewSMaC7tLhosN1sjtBsGZ
         Yhu7YF3N2jX14oGygXflVxQnNVn/P3DDbLtj+RgoYGQlojLlcYj8bs5Xhd7/FXXPWNVY
         Qc5x2ntEH8BIbdZQ/6ruXBdzQRR15wxyJ4PHP8dHffMTg6M+cFHAsTfp2s/vzsmVLedy
         4jLRHeIBIw0xV63g4WGFpc8MdLuTp1ES+zMY7wDdyQ4PLAy/fOcbNBOtoo7V38HvYZed
         PTRw==
X-Forwarded-Encrypted: i=1; AJvYcCWUqUhhtQGBZb+hZUgiFKZmMuNxBBCjLEM+pjdCZ/NcYNHa/GcH4Oxkm4joZt09uYBvDre0+G2fnf4S2ObxfuVe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09xJsjAZ46cbLldAkVeeBCfB47geC2o1OHbpBW2Rb8LA9T1Ew
	fmK0ZNYUP5ERp84K8sKt021Y8yInMPu3tRezjrBwhM/aTzA/vGiHWYffjyfBRe0=
X-Google-Smtp-Source: AGHT+IFvmRJ3kwcH44X8tEVQpW/XuglOxSPCkP6MHjK2ehbvCFJ8Z5bWzyalPeu3oqnDHG3TOgB6LQ==
X-Received: by 2002:adf:e544:0:b0:368:445e:91cc with SMTP id ffacd0b85a97d-378895c9deemr10636514f8f.21.1725981519545;
        Tue, 10 Sep 2024 08:18:39 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm9440844f8f.36.2024.09.10.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:18:38 -0700 (PDT)
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
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/7] perf test: Make stat test work on DT devices
Date: Tue, 10 Sep 2024 16:16:24 +0100
Message-Id: <20240910151640.907359-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910151640.907359-1-james.clark@linaro.org>
References: <20240910151640.907359-1-james.clark@linaro.org>
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

