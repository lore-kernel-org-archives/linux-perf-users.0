Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46518991E
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854178; cv=none; b=afTqrvnZ+PJEB+tzZO1TNStiR0ndiGG/WGgz8ld1P3KXk97ecrv4a/pwJy7VLhfpqJtLXuK8O6vYI6+kRx14O4cZaeO8pajp2IcMCk9auSPd+LvHMiHUL+7hC6NrC1Ei29WlFJIHZWpeq4NwgB1zylpnbuSo4Fo4UY3QACSmnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854178; c=relaxed/simple;
	bh=TCmY5/W8UjZo5v+UmsAxTLf+W/oV6ui66khMLptw/MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xv+cwJVjhBwbvpTtdMClmALvVDYPY/PmloFfbG9Uq9X4UG1FTU3f/8YJeTa8ZayiZcYJWAEupmMRtpVTEM9cujRFolxSYV+5ShCNe/cbLk7gOw7XaVc4zffSxKPuZ0uiC9wUZkSAdjT0x/tLq7MKjCdQj50DSHMnHIEIiusxcSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtWUrWCu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtWUrWCu"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f409c87b07so80042571fa.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854175; x=1725458975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=mtWUrWCujaC6GK3StEy2a+IP/zyH/FH8WWgjSFMnjzOYuDY9u5buUBmpL2gIKtPQfH
         JHhdpegfr4TWg54mdmL4nIbuU5Mj7JvHIkxayJCfW6ECvPK60SOzvE1UMTJP+2oSrxOm
         NKDi4ptva+h7tAa5jnHZP6U7Fi946O6f9ml5mpNkuO/zxmSlxfwZVSw59F57sH3VRM3X
         Thro2XX+q82Xz7pbsHjpbNTHK+ohprR6ufpA2lCKWMSZXOn+6fM58HdJyhjrkJIlXguG
         bHYWLcKDDSp0Lo55+uTGFa2mHcVGmp+HRXKjFIKI8FvO0grc/oljl02ECn2fNuWxVYXM
         Iqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854175; x=1725458975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXow/HXS2t6eZsIhNK0KrvK5I+CXmczupsEF4/wQsaM=;
        b=VcX/pYisFABJ6irMcfJxCEYwt9mDcYxiiyx0PCdH5vt+6YxFzLQWbzDtWaVaobwarD
         PLd6NNJAlaBW373qTwnstajvFo66LR0MJ79zC/YGj/BOp+PIniWbWppVJMA1L5A76gBt
         K7gyKTXcmKPJhWxgYs6WP65tufu+NdzDBX/Xpn1rDvPwvwrHfPtgtkcOznB0GRdnuomN
         cUoOoQFeANZ36tmsb9Mxmgi7Jmy1u/bFCU828EYf0kl9452aBdY+YbOaXgxhMXQDQEyK
         n+IqZLDNvZhwNIqqI2Fu6qGs8G9teBxCKQ1tLFmrT5JFIjagIB/EWbo9cj98x+pnX1Zn
         RPqw==
X-Forwarded-Encrypted: i=1; AJvYcCXZQt+OgvMs7N5oc7Ma0w01M9uHN+jPzlqSsKcTxVzulFMkkfqcJyTCpcY1qwRHgDpDvzaMYcw943KfKPPwtjIm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/i+f8mmVKWJw1KaQm5K0rSDd8Lu4zIYEhgO8Uod6hoda345/y
	Y9rP61O83ZJUUj9w3eyxgo38NwZwVk2QN0p9KTGUs9QCRW4d2qIiDSNKF3d6ghvXP23yt8/17OX
	QvezgZw==
X-Google-Smtp-Source: AGHT+IFgmIslD8aeXezPJ8omK9Ym59j23rdPHAVaCBU3pdKjqfegi/dglTnAMLH6nBwoXlF35NdpKw==
X-Received: by 2002:a05:6512:3e08:b0:52c:825e:3b1c with SMTP id 2adb3069b0e04-53438783f89mr11126822e87.26.1724854174372;
        Wed, 28 Aug 2024 07:09:34 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:09:33 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com
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
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/7] perf test: Make stat test work on DT devices
Date: Wed, 28 Aug 2024 15:07:20 +0100
Message-Id: <20240828140736.156703-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828140736.156703-1-james.clark@linaro.org>
References: <20240828140736.156703-1-james.clark@linaro.org>
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

