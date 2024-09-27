Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FA1C3F1E;
	Fri, 27 Sep 2024 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468881; cv=none; b=k+dc8lUytW1LZs9G8qJMxWtQ7bnCcsIci/8FcK6OylJeNWq2sLVADLojqpBKqXFO4NtbE2Y8Z/qtFL3HnSciLjMof2XrBdi7ews96fl6xQUmIQz6zB7VnABER9lXD3XeEUjYNLzGzBByfFEkrp+XNaglY3iJifaE86jWIbssaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468881; c=relaxed/simple;
	bh=BfKLXsdD+x//Y3ebfcycwHplNHYTY+Xgi8RSHLfMrc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km+SPBrMew/XpNMvFYtZqAgzS7aKSCRK9MVO36/ntKN0leAnehR/mDWMGhlBqgagrhyu0SxunAlRdST9XAgyMNvxJvjzilsF52d7e5B8+g1cwFv7Lrn11fKsqSgHCmST5OyzsX+g80qNBuz6cIKvcnm9cam7cuy5h97FiHPwuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXfcFomN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXfcFomN"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso2074865a12.1;
        Fri, 27 Sep 2024 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727468879; x=1728073679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D5uxLLs8a+eADmi1psHFkftjw0ias/dpesC5XMo5zY=;
        b=QXfcFomNSoE6GHIgqn0vV0aWzSS4WA6W2xabvVGthNR1WbEZrXP5KIoE3nE4vwrEJm
         EHrfZjiBvsq/9qOAgveqqPq0atZUoZB0N1CxQL48fqnLYCWrezG/Fx90dXdQf8eYzipO
         pGDvmk5WWqcn+sN+AFPuh/N1EdfghvhcQZhiQZGdENnOJ30oHR+VRj3bPvCF4gydn8bD
         xmqnAFBmSy2CbviixpXXQ1sd1mvtiTOEDqcipaSRvXH+8iY1uvrU80cXeLtgDbvXpOIZ
         EguT9d1WGO66fdw7Enjb8W9eVqardgBmUw2QYY9t/yV+yuTE+7OrYiAlJ6arwKsKUOny
         bYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468879; x=1728073679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6D5uxLLs8a+eADmi1psHFkftjw0ias/dpesC5XMo5zY=;
        b=pntq9wNGIoVoYjnf70ZdazKdNO8SuHKsERkiMM+UAF3uv/b7+k5+l1I97wz30v8y0H
         xlnw1Y/lyKIs0ToqwUnpJlKqeYJK480iMCf6t4EDkBxkAHNNip7eYDZ67LBZZpcZU4mz
         JlRLEHYLVYDA/CXlbtnPhSWF2kFeESLC+HeVAU23XnurvfUrEkNnElUX/HDbKDL5okyO
         zIQWi260lmS5nJ1nIkOgv7g3zdh9r5bJm5BWTYidFV7SGnnYxWCbmAiDmbMGSqPx4D3J
         SgefQfPiaw19R3nnk3eruDNt5X4VAJyaozXc2Ohg9Zs+Bz6QL6ZG9komjwY5pcV2Gi97
         07DA==
X-Forwarded-Encrypted: i=1; AJvYcCUZXku/b/v9IjTTVTxv1FQNdw6P9EDfDc5wl+mTwZnsRdUk3CVLUAldmYEJxWPllY/wdHqmTymE1METky4=@vger.kernel.org, AJvYcCWqAp8nNXtHYKFbuwSMa9CAI1ft2SVzIcaJa2Dez/ARQNdVaDMLj8fom/CI5u/dxRZiLL08ARBJLtiMtSk02uFzig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DNBZvAKQf69mIWBQTdMj9a9JHMtQVtPKKZYc5GvCQ74YREMR
	eXbndfCTs8IvXfuygNeR9YnsKDg/vll/hNQIqZ4HwPyFYzan8m+e
X-Google-Smtp-Source: AGHT+IHncx/0ceG080D82c2JmisjmK8fYC9I9mNouHjQFAXaatZBnS6JlN27YttmodW0GNM9FdQeWA==
X-Received: by 2002:a05:6a21:3a96:b0:1d3:b30:44a2 with SMTP id adf61e73a8af0-1d4fa6394c0mr6878101637.7.1727468878686;
        Fri, 27 Sep 2024 13:27:58 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524c32sm1998410b3a.157.2024.09.27.13.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:27:58 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v6 6/8] perf evsel: Delete unnecessary = 0
Date: Fri, 27 Sep 2024 13:27:34 -0700
Message-ID: <20240927202736.767941-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927202736.767941-1-howardchu95@gmail.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete unnecessary zero-initializations because they are already set to
zero at the top of evsel__parse_sample(). If we don't remove them, it
becomes troublesome to overwrite the sample using data from raw_data.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evsel.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 500ca62669cb..32196e4f0637 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2965,7 +2965,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
-	data->intr_regs.abi = PERF_SAMPLE_REGS_ABI_NONE;
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		OVERFLOW_CHECK_u64(array);
 		data->intr_regs.abi = *array;
@@ -2982,25 +2981,21 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		}
 	}
 
-	data->phys_addr = 0;
 	if (type & PERF_SAMPLE_PHYS_ADDR) {
 		data->phys_addr = *array;
 		array++;
 	}
 
-	data->cgroup = 0;
 	if (type & PERF_SAMPLE_CGROUP) {
 		data->cgroup = *array;
 		array++;
 	}
 
-	data->data_page_size = 0;
 	if (type & PERF_SAMPLE_DATA_PAGE_SIZE) {
 		data->data_page_size = *array;
 		array++;
 	}
 
-	data->code_page_size = 0;
 	if (type & PERF_SAMPLE_CODE_PAGE_SIZE) {
 		data->code_page_size = *array;
 		array++;
-- 
2.43.0

