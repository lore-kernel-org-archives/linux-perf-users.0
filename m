Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC9241C89
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097250; cv=none; b=ICZ+VrVmBcgxcubj0o/DtnuMpFDeaVdIqTt39hH5lxgpBjixuqJvJCRpjMH6cr6YWamrK1ZUpRp+xAHvbf99Ua72AXFHBh+MZ/QEkPGPo7qkqqGAFX/O/uIG0j3of4npw7/yZYjIR867PZZmwtQPm1GFiBjyuI1OLrbn/unBwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097250; c=relaxed/simple;
	bh=gv1i3DNEGxqaAyeBCm8oJ3IImT0PmMzZRaQt45Qua7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Qx/EQIKAtUuuF6x+XDSYYwu94ivZwwyTVQHp3zBEq+/hzqNzqNGh100C3bNjaGCKx7vnZfxP1GyjSI4qf3Ysj+auMt53UN/BV4VJX3VhbTl0fDaGqLDvjE/B09HRm/+8iOOZGs16nmXZfAHs6pOEbDxrCvuzORpV/zVb51FO5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVulkJtP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVulkJtP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235196dfc50so2989025ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097248; x=1752702048; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHFbmZZJXyMo6toKRekC1Kog8DjIMtKrGBEtrtRAi4A=;
        b=WVulkJtPYzidkgMfIz2HXX+bTEr3+bJWsIz+0xVf9kwJAO+dMADGGaubnaAlbnyb4R
         9v8jQhm11XuuJmRcG1zBR1IZ1Hp+568kVGhyYidARgb7ZQ/VBmZIeHf+qkvLBAIUPkX2
         7+hK/EGdPnkcSoj9TnKiQ2TxcIaJUSGo4z/Omqa8JtdpcagpfRMNatyXMvP3ldWw+Lrz
         gi7vECYqfWQYQG6n2/lonECi/6v9zbCgcStv+83qnxL4ti6pu5112hH5kTdiE8wO61iJ
         mlm+OLvG8TPcPUyBe9P0lv+TkCvuSM6HPW2FEB/vDPB5R1WiRxI+cXPjnN7QbfW4oa4d
         XR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097248; x=1752702048;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHFbmZZJXyMo6toKRekC1Kog8DjIMtKrGBEtrtRAi4A=;
        b=TVzTVJDRgNgDpueoMshy1PqNsXjhK6KR9A2YkQvw1xci+3iwsb7TH7IX98AzOelHJ8
         a2IQkOv10Qmblt/0mdo1K/IQxb2w+KCSipWL84K0ePgoQ51RrMB40pJm8UJ9fYADul5I
         umcSJa3azMXH8A35cBhjDAmDlKbAsdRZpG+3rp7WXiuOYmcLeR9QAvgURMOeFeTTKxPb
         WcICfWxZhnJLAzRuY4a0BVTDsKDFF8Xg7N7j7BJBdp4D94yzx/6WXyd8Tti7KUbfFry9
         sTSjJUnx9/wMdHG2Kd5H1RAMZxop08Q8FYSW9dVsWUv9ryqzJvsBrKAe5SkyGJUEoscj
         vQxg==
X-Forwarded-Encrypted: i=1; AJvYcCX8iAZApjLgE5GMVboIktiucS3wmjx18UdPb0KJMV5SqGxRjbOsFiTIKWC4brDJikrRvxLcfOdaNkDKe0ibEssY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+0ZVUSjOsAwjATNXDk57Vn5wBjgBhCAKNUhRw7DfgkOEGn3r
	H3ObVBh5lc5LH9WQuCgAe20ucTzN72D2BMLqxAirH1mGJxBx02rnmiJ/ZH4pJqcCIKH7qS4rlZN
	zFg1Z5h/5mQ==
X-Google-Smtp-Source: AGHT+IEPhXi1EE/yKqxcf/Tb2Zb4kUGNN8tEUGHpwwrfPN8hR88hey/bUWtBivYsketan+WB+niZag1LozhC
X-Received: from pjbdy15.prod.google.com ([2002:a17:90b:6cf:b0:311:4aa8:2179])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b2c:b0:234:595d:a58e
 with SMTP id d9443c01a7336-23de3008346mr15749645ad.25.1752097248268; Wed, 09
 Jul 2025 14:40:48 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:24 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-8-irogers@google.com>
Subject: [PATCH v1 07/12] perf expr: Accumulate rather than replace in the
 context counts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics will fill in the context to have mappings from an event to a
count. When counts are added they replace existing mappings which
generally shouldn't exist with aggregation. Switch to accumulating to
better support cases where perf stat's aggregation isn't used and we
may see a counter more than once.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 6413537442aa..ca70a14c7cdf 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -166,8 +166,12 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
 	ret = hashmap__set(ctx->ids, id, data_ptr, &old_key, &old_data);
-	if (ret)
+	if (ret) {
 		free(data_ptr);
+	} else if (old_data) {
+		data_ptr->val.val += old_data->val.val;
+		data_ptr->val.source_count += old_data->val.source_count;
+	}
 	free(old_key);
 	free(old_data);
 	return ret;
-- 
2.50.0.727.gbf7dc18ff4-goog

