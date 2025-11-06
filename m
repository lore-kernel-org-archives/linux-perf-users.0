Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93B3590CD
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470969; cv=none; b=EdOUIQFkBeCkaYHCmrRhlEAOtQq1N641APSJT0HLN/54o+DWp4ybaIRu0FlaEXbaDpqjfV1AA1BKWVBu2TsSSXIiVko3Z+iA3/lKqpiqheHGSMujCKsM7406pgGK48NAYRHW8d0WknLciPvnG21WMR1XUz+OsTZzFX7GLYJ0IhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470969; c=relaxed/simple;
	bh=bWlWZmoSbjMlQJvhT1Kc+8bbCD51npTRBtHHE+YWJoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oDmnLKgS7mfg0NwQq0kWa9K8+xb14ud+KK1FHGM/RZz81kXNaJP01vDrkpWukzbjsKCipXuScBsZ5xQy8nNkUmrleVz7oTy5uqL85YRvpnbtbLgRBlxKoeRJr0JAQhz8dS3t9zU0O/ED9vlRscKANseLuqydYLkYeBR+BTxb0Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6lfZtOY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6lfZtOY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297b355d33eso2092575ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470966; x=1763075766; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=I6lfZtOY+vYKdpXfsWpCP0LB4JY1R3IB0Oyif8bh+EzrDzPGQuCAzFn48FoU8SVYpY
         KQbBl0BpbePp5N4J0+kzfZc8pdPR6vBccN7oFSX90CXEWxoqESXRR3uth43rh6XhvDQl
         XAbbZX+iGICvo06jNAMkkWcpwxx4HTkM9b7lDrJunQ50DGsgyGBQeYBf/4Esz7yRLbfY
         6RKNuK7VaEg7ueJDHttC5hwOEk7gedIixTd6Yx1GqZ7N1+AyWcErSW3mbxQkjkDKQ/Pz
         dklB/QhMgbTzOtw3cZGMSE3iDjsS7gl5eevYN73Ed2o9XQu/NWPjuYt+ioeWTYCsRzrr
         oA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470966; x=1763075766;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=GsA6vrnTrbkF27P0hKIzENQplvllC1YJsfgar0gU2FT4DkC7IXgs07GxRtt+utRKdO
         rWzwLt9SfNctpVXE1vMmSxKSBRD9SWXIsknB3c2rQBQ83YtGuEKwuk2DSf4syjktNWKi
         +Oda56iuwBSn7KKdhwcG7nJFumz/aaGOwCHrbFSOafC2QQDTe7XYHxOQRJGCBpon+om4
         I2CtomO4z9SfvfFU2LfxgPKh++EpvtRrXk1W1e0zN5a7DobWISiqYUrfrQytLqR4Juon
         BT8vDNisy9JaNrVmFHuv9kLjzNyVwOFBr0+gFJrOEXz6NC9nlblPjysV1nNgKsxow13f
         DT+w==
X-Forwarded-Encrypted: i=1; AJvYcCXmiXkLpaMuOv36leSU/nF/xkQGm2eMxzeZaSL6jxTUMWdfXB/fw4YqXVCVjDzagofql/9GnoD/KnjnV5BU1UKn@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSryEghCDPglhABIenuvItHtQfnjtzmFVpRgDfRpVetIWk0XU
	GRQ3L1IazE2Zn0/J8+AXRtPe7u2Pb0CvXkOzY2yaVGGc57dXEphZUreR/+Iw86osXiu4js06uw5
	27P2XEkdAQg==
X-Google-Smtp-Source: AGHT+IGlOsxlmvFm0qB6YZd991xh+uwXx3guS1pzc+tFdgny+jz5mNn6wDhurHuoiQ+/Bno1TZVtodykc9GF
X-Received: from dlk17.prod.google.com ([2002:a05:7022:111:b0:119:49ca:6b87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8d:b0:295:7b8c:661c
 with SMTP id d9443c01a7336-297c03fe292mr15047305ad.26.1762470965861; Thu, 06
 Nov 2025 15:16:05 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:04 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-15-irogers@google.com>
Subject: [PATCH v2 14/18] perf test metrics: Update all metrics for possibly
 failing default metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Default metrics may use unsupported events and be ignored. These
metrics shouldn't cause metric testing to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 6fa585a1e34c..a7edf01b3943 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -25,8 +25,13 @@ for m in $(perf list --raw-dump metrics); do
     # No error result and metric shown.
     continue
   fi
-  if [[ "$result" =~ "Cannot resolve IDs for" ]]
+  if [[ "$result" =~ "Cannot resolve IDs for" || "$result" =~ "No supported events found" ]]
   then
+    if [[ "$m" == @(l1_prefetch_miss_rate|stalled_cycles_per_instruction) ]]
+    then
+      # Default metrics that may use unsupported events.
+      continue
+    fi
     echo "Metric contains missing events"
     echo $result
     err=1 # Fail
-- 
2.51.2.1041.gc1ab5b90ca-goog

