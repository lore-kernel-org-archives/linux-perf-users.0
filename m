Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7E199FB3
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981539; cv=none; b=TLb9WOYAXwXLrDYwUkqpV1Fjxx6ZYRZhaOqyC+P2B9135XCFQ252QEfLoXPdABUBqvElVEpIQgRXKAjv7K/D95i5gy7/rmGRgEj9qKIs+b1f+trTqZ13e61Ctzc7hJURecFrdAuFwHpXbbnOtkleNHE+7KSD2Sk2PQ5RnJqLsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981539; c=relaxed/simple;
	bh=B7L8eicaLL/uQdqZZRGKF332ltFTMFjZxuNmtoxY+qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjrubYfKtbHk1CpDDrKj8qeXPoiBTADvBD6OfFaXsTD49JX72+5Zs4FjjlcKz2aKelMC1PzTxYzbaNxcBZyVqZhkAdYlUcKBJvi5GekBVC2M6Le+Fsem5N3XVfV15EsxR1M0LBDkhXHEZn+iwOAZGR3bgRC8weXHBqKOUSUjPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEr7/BtE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEr7/BtE"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37747c1d928so3558447f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981536; x=1726586336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzYejL55jw2kalTO5A0DRq7hhLyM8T3G+Vfejwo9sVk=;
        b=gEr7/BtE13W5sDCDX8u125oEB9fkDvvPXsLSfAqeMfWLFDS9sELGm/hWoFEhk2gyGJ
         Mrm5gubKEpHrCNNWb1a0Fh87VCIRU5yluJ4jWaz7RTPhWlLYm1SYM1jL7LOMA5I/Pxhy
         b+wYVSJHf9okd75fb1jgxAjuHljf42J4Z2eB3gCthb1EU0GVSCkuCsupTH412I5f1zna
         huWrggSs5ffDt2GFyp8TmCpQy8y6qdimvTOK+AM+zVJneZ0naKMZ15bFLlR+i6wXMxYg
         mJBbEDQiFIGgkDfQl4NcCEkVn5ltkwpZBDuS1bwx0FMTQ6CLn71Ho1ukT7mkoTyVNy8r
         qCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981536; x=1726586336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzYejL55jw2kalTO5A0DRq7hhLyM8T3G+Vfejwo9sVk=;
        b=Qn5OlKeWPzT2kUoarkIxJRl2+pA6d4ScgA02cmpFrhaQfgNHCLt5mguCdv4aEN3biG
         H08Le/FvgzXxibQZCVh9OmSVl5IX1KTok3LcEFUGRJdxNqCV6UXrgiQWOhh7FVRW9ACV
         Ggrfzt9WSUwdFdJV5sYBageGU4z6MsX0TwtdAblpq7VZ3tDvudkhXI4H5yP+isR6oQjd
         rfnlWsDWyUWybd2nN0AbFiJ8hrhxeJl31icbflYR4MSE27hEgCbcNBxgri87BLqCeznm
         Ta1QojOo3SLXW510jLrbpz5upUSEy/I8vE6rjdXKaMSKkMDTqNnt7Mz1Y6F6zmyVHefu
         id2A==
X-Forwarded-Encrypted: i=1; AJvYcCX18R74qX1oD02tq++x082hpfr5sQlVrsUVmBvD3D0+e/K5xaQM+tKgAeg53TJkovStn3g7KzkAHUSfLxnADMWW@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHDV7YBfjZlkc1pbM+jgMbRAFzrvv8HSoliDNzgEDP8RyD+G2
	SzZc8OFi2wZGuMOOp+MmH1VwCrvf5GyoaGaIzEX1Olh8aYVjJbtLmzrbDyhTjEU=
X-Google-Smtp-Source: AGHT+IHy/RhwX57CcCqc82tipU7Ic/6+Q/to0vq5e7VGq8SEkdeQH7tu0qUqClXsdQ0xyoyauIPQiA==
X-Received: by 2002:a05:6000:d05:b0:374:b399:ad6e with SMTP id ffacd0b85a97d-378895f20damr9927699f8f.35.1725981536253;
        Tue, 10 Sep 2024 08:18:56 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm9440844f8f.36.2024.09.10.08.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:18:55 -0700 (PDT)
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/7] perf test: Add a test for default perf stat command
Date: Tue, 10 Sep 2024 16:16:25 +0100
Message-Id: <20240910151640.907359-8-james.clark@linaro.org>
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

Test that one cycles event is opened for each core PMU when "perf stat"
is run without arguments.

The event line can either be output as "pmu/cycles/" or just "cycles" if
there is only one PMU. Include 2 spaces for padding in the one PMU case
to avoid matching when the word cycles is included in metric
descriptions.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/stat.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 525d0c44fdc6..5a2ca2bcf94d 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -148,6 +148,30 @@ test_cputype() {
   echo "cputype test [Success]"
 }
 
+test_hybrid() {
+  # Test the default stat command on hybrid devices opens one cycles event for
+  # each CPU type.
+  echo "hybrid test"
+
+  # Count the number of core PMUs, assume minimum of 1
+  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
+  if [ "$pmus" -lt 1 ]
+  then
+    pmus=1
+  fi
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
@@ -155,4 +179,5 @@ test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
 test_cputype
+test_hybrid
 exit $err
-- 
2.34.1

