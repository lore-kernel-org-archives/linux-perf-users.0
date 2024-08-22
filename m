Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD01CB146
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333249; cv=none; b=Q+vXTstvBHlmIsRMkYr50HshSQRzRPPFRKE2i+CfHdaaBgL9Xgrqhh6/Z5EZixlkBDLXQ1V3EqQUQeckxLSrDoONXWRPlO/njEZdbf3lyYrGn1e/ltTIHSNzLzhsN36qit7urPqyITiXrF1A7PY4AkH526scmfKQCC46j0S47fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333249; c=relaxed/simple;
	bh=TCmY5/W8UjZo5v+UmsAxTLf+W/oV6ui66khMLptw/MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KseJiasywBrM6cAjFSYZJNtEealPv3+F69c2wBmo2efBkqNK2xb1s475eYIIQeTUzfrV8qroHBjJGgmuKkyUuGrxovPL9gLKm0R19vF31vM7ctybJEJph8pyCBMoV77pJfc2gPYQIdQcjnap3Y/1BNjmCVuXawV2nsGudcDHFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IX/wDaLG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX/wDaLG"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a843bef98so95800666b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724333246; x=1724938046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=IX/wDaLGug+bLkOFOTfZlaoWOY16vrMk9Fd0zWv8X/ybpwS2GTiNGEoweeFLxuBaYd
         Fm94vpf+ebatqM+Yo9RnH36Clqgn19dZvHDzvIvpPtQ6hvGB/EXTIkKNdzYuIputR9N6
         /PlCLn5WoGIesOS+svxRm3ZGIG/E/C2SPXC2lXNJBjPl1ToHrxTnjVj7OBX2gJmyrryW
         ozZ6gKKAxmGPhasmuaLZg3az5Miog4YKcFWnWSZqlN+iUncSh5MOr71SgkLMCn/mrbUb
         zP6Nr3sL0uPMef70pLjhJ4/A7VLkImhbhO+aS6tpVCgzn3tS5BPTqMmIIKMReec8r/hg
         ZYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333246; x=1724938046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=tAnGauVgoXQNvd6vN0CsRnGzDivmwKS+/8PDoItAf1t2ZF7UVqwaFEidDG51VIigRq
         cgQLt0+ECVTrhuYEId6N0bLp/QXRRFY5r0hnwXYRpUoTDmyqbvsJ6CrusVC7rtkoSdc0
         m6IL68tA5hBWr9fb9g/ii68rRwpQ97K6hboyaVLdqEmTlJYHD9yVgmfkZP2UbO1+8oPe
         Kv7bLD8dE8syhLPI6VU5L8tTYb804Go6YexWq6u2eRJLnh61i+n3ycPmzOU1Jp9svK3A
         FfEPePswmZZe9HgedJ4wyduZWNK8dmgIUOqOqR1G9ed+hiXrcJBpiKfA2rWmwFbZM8Xr
         2FZg==
X-Forwarded-Encrypted: i=1; AJvYcCV9JtBA9pucoow2dVCYwh6EOmLPf8Cc5NfpeOBeSqCdPA1xTJdQdoEkaVoD1aMi1uNhgkOYWHbtZA5jhwulsG9p@vger.kernel.org
X-Gm-Message-State: AOJu0YxEA2frLdvPw7mVowe7+1w8wRc8zHSsYxJDS/5TtOcN8mXqVXXt
	YI+/H0CQDFc7oPjZ6fqlmz8CN5w47J+rxeGlr0oSoSiM2Srcuh8FArYKVbPND2A=
X-Google-Smtp-Source: AGHT+IEIfESCaj20LeN3wdme4WvUm4ln3fDZaFGdKWeURVQl4E5qCNlJvP6ZZ2sqICCWJjg5IMrzYw==
X-Received: by 2002:a17:907:1c1f:b0:a86:86d7:2890 with SMTP id a640c23a62f3a-a8691c5bb94mr201014166b.50.1724333246080;
        Thu, 22 Aug 2024 06:27:26 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4365a9sm119497766b.125.2024.08.22.06.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:27:25 -0700 (PDT)
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
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ze Gao <zegao2021@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] perf test: Make stat test work on DT devices
Date: Thu, 22 Aug 2024 14:24:50 +0100
Message-Id: <20240822132506.1468090-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822132506.1468090-1-james.clark@linaro.org>
References: <20240822132506.1468090-1-james.clark@linaro.org>
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

