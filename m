Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7418953A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854193; cv=none; b=ECrODxxFFxRGusnBEmdu8MhPtdgy9Tkzc18sZSeE4hB23u7aX3wei+J79zLD6/RnhicGhv0MoZyMZeej5LGBecfb0bT1Deg9zG3JumtLBAwTVCDR2NGbJLQFu0/XEj65hUjodPp+P20eavvOnFH8MSPQojr/y8oaNZ8mM03dUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854193; c=relaxed/simple;
	bh=iJebi4RnGEDb/WDnZ9Fx1JV2iX2h8srqqUl2h1UV8Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYTIeEHLxqrB5dAJ/X25S3bowTyT7OgrvMp9bdhVEKNXCKF2JjQWN6+sPLayc/D7WK45BHKV/6e6+UtMvlrmrrMMyZ3LEkla6HvoFZiaxmlc3A2hP5vWsVyCNTLHVHnyngSeGC3HFXxbudmtKn5enCSouyCKqWm9MYeRbXAEZyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cgP+lcep; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgP+lcep"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso421704166b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854191; x=1725458991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il04epHFd9BrsJtGAU8mELFSezcE7nnWBSPUsdUkN8I=;
        b=cgP+lceps/CN0jW83sVt4yrHOj7+Id/AijP4zEz9JG23yFc2pVVOBV2fFNJa3oofT9
         ZZf8WOX6JLJFaz5hxw5TMZ3Q045CT1Fot/WTC7x9KD1HzK5N85KcubZU+AfGwD2/0m6D
         N+NX9WzugHmXV0U5V831Ngjq6VVaKkLAKL4uhy5QYxRSKkj9d+xLF7jl0AXwRjIpi8X9
         HQKnJ/AfyQf7pWr7+agxms5ckEZlEWbh9EM8Z6+DDuXBZ1psVQDzjFJTg65qN/NQKXrB
         uqakSa6477tA5k50j8TGOYu/+ziczdValV1yEpreGKT+PfTox60FKURVfTdUwISAoEJE
         25aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854191; x=1725458991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il04epHFd9BrsJtGAU8mELFSezcE7nnWBSPUsdUkN8I=;
        b=Q7fgsfAf5ll3amgWkSchLK2c1GIk697EqIyMoo5DNcYiWO2x0tYfrDkDAIWhiSsAUQ
         fONjTRTuWT1C4Vo8g3DtSX97EK7hOdgM6jwodgNTyJ2ryz/fG+f3HKFriQTW/hBoOFyW
         Oy5nKLpMHhYwJmt0j3mFzbNC35jJxaz+wldHhiEuZz9GKy2sMIaa6X0aMl2FJ5bH6SVQ
         kTmdjL3xjL9fu3iDgEP9QlHYDpUFhxOixzcwGK5hy0rtlZDjj928ScFpqclhhd6O/MQt
         VyYvpKn3q7Kr1hX4asyum8kwXlxnjeNTOApZV4d01fSMUnZk5iSrUwglW834o2KmLnTW
         4jWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmWBj5ZyaF/kSGHJyVFP5M4YR4l+0zQNyhI9Vg0zkqfssXEQ8NDO5SJKIR7aVNe7CYb88fB6Vm1kQ598O1Ok+5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oDq4aXP0FNMqXzdbY3/zGEKA3r3wSGkwMcy+54TNN+RzyNFi
	sfvuWts21XFEj88lrUlBUUUmciymTIZ1R7skg8bzs926EAQj2Oi+VpoIunJJAN0=
X-Google-Smtp-Source: AGHT+IGfU9r8eCZ1F54SsYtSTEbWp48pODz+BAIgPEFvEm7Ao+dfQxCs2umNAwFacPms+yzwmqUedg==
X-Received: by 2002:a17:907:e6a3:b0:a7a:ab8a:38f with SMTP id a640c23a62f3a-a86a52c37c9mr1305055766b.41.1724854190212;
        Wed, 28 Aug 2024 07:09:50 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:09:49 -0700 (PDT)
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
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] perf test: Add a test for default perf stat command
Date: Wed, 28 Aug 2024 15:07:21 +0100
Message-Id: <20240828140736.156703-8-james.clark@linaro.org>
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

Test that one cycles event is opened for each core PMU when "perf stat"
is run without arguments.

The event line can either be output as "pmu/cycles/" or just "cycles" if
there is only one PMU. Include 2 spaces for padding in the one PMU case
to avoid matching when the word cycles is included in metric
descriptions.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/stat.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 525d0c44fdc6..24ace1de71cc 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -148,6 +148,26 @@ test_cputype() {
   echo "cputype test [Success]"
 }
 
+test_hybrid() {
+  # Test the default stat command on hybrid devices opens one cycles event for
+  # each CPU type.
+  echo "hybrid test"
+
+  # Count the number of core PMUs
+  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
+
+  # Run default Perf stat
+  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
+
+  if [ "$pmus" -ne "$cycles_events" ]
+  then
+    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
+    err=1
+    return
+  fi
+  echo "hybrid test [Success]"
+}
+
 test_default_stat
 test_stat_record_report
 test_stat_record_script
@@ -155,4 +175,5 @@ test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
 test_cputype
+test_hybrid
 exit $err
-- 
2.34.1

