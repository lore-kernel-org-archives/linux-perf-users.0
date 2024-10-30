Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AA1E492D
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288403; cv=none; b=qH5/AFfWkCp480mbImdbXVH+eGLX+mrEY3eUqO9VgAY1xuBYqnq8yGVAK1ZP80/HjTEvx/mwyjmSuAgFjcZpG/KFXjNUAHvKP0xc7B1Wz5DAlthMOJF7qtYV6zhAoll09NkHxeOHsef4xtgylzksn2GOTzhLXaBqtJWj66k6wEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288403; c=relaxed/simple;
	bh=mIPtaWDJqtsaEQHxwqXP7OxYEV/lwPyYCOJyw1pv6EE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tYSXkdz/CWKu9PV1sr3Ko2Y2yIB+Fl9D+R3pwxZ0jg6nKkITeSVGtvplsntdrLbI9RAxAj8HNeyrTsF28OvD91GT7lO7AaWIB2Rk2HlYx0tSDaev25qLJmmbXvPOJB7O5EG+3l+Ec4uZUkYnaSqbloiKv88WTY4lElc80jUGs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ADDBRMIO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADDBRMIO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso83173375e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730288400; x=1730893200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsrM4nE/dAWuw/a82LKCSe9qni3gTvXsnkuiCmuf0hM=;
        b=ADDBRMIOH+/oK9e6GcVxF2ilZIg/JP4Qiu+dw1AKFeKb9ksSK8XQWwzyRqIRPYBFvb
         EWxxrGYe6nnAXSuz1xHz9RZmLjjKmfNZruta4N8+6PcqoJnOZSWJ14QsOBcut9vdmmWE
         CfiYi+jkZOPSzkctju4V+ejamta1iNz3/2hZ8/wF17V/5X7mHh6gjQI3wC0DT8bRhBXi
         7hBgc93TxAJO9uU8Tn0DDUJgXlEkglJAyjBojlvYns/E5GtJj0HhwDOxbJuDEP1v1frP
         +VyeTLDSJ4dAgthGuBdH61OUPxREGFVE3lbr5dauSugqM7K5SCRfPdq7B/ArhZe9yKqF
         Bafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288400; x=1730893200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsrM4nE/dAWuw/a82LKCSe9qni3gTvXsnkuiCmuf0hM=;
        b=Hd/BSyLTCt9I1rJ9ygbq/dET2FNkfbR6ayKTbPj6qkrPSuhQI6nmADrID7xrgrjPyP
         y3/GTl3Bw27FSwEy73suMeUT6LeWTNkbNrmU5g3buWgkwJ7cD7ZQfC86xwrt5f0XuGI5
         kZBVGD4C0EqZLxlMu/XO0VsYYhb/rJk/YCAj+A5FdM77hl5ZFwwmQ/kxuSMTe63kauN4
         +QYF3O3KQiS8yUKtuA2ve4tIhFb8wAOO5jVeKUI45IUAzTn+i9niIceq8gLKmsnhJ+i9
         aq1tTkpcV5K/eb6eysxm6EmbSMO/M27X0udh/4J3p7tfn+A0/V4BkqRMkVpjY9mqic31
         xmDA==
X-Gm-Message-State: AOJu0Yyuro5gzQ06zuU0lL2kI7CnP06SkZ9327Gnxm6DZWe2CyXq/zOD
	6Yp8Hyc3syGS/fbvDb7J04A8NgBadTfs8cvGAyUluwIi/WHUIab1AaNBgY8QzncGqWl8AonbxgS
	RMjU=
X-Google-Smtp-Source: AGHT+IHd/f9EqK1YhUX1cfDfRhSD6kG20xIVn/uvsdBFt4dtEH5o0x6Ry2gsyh7RFzYXjM7VH0/r/Q==
X-Received: by 2002:a05:6000:1ccc:b0:37d:4f69:c9b with SMTP id ffacd0b85a97d-380611e0c40mr13445805f8f.35.1730288399847;
        Wed, 30 Oct 2024 04:39:59 -0700 (PDT)
Received: from pop-os.. ([145.224.65.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca6f8sm18885045e9.39.2024.10.30.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:39:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf stat: Fix trailing comma when there is no metric unit
Date: Wed, 30 Oct 2024 11:39:43 +0000
Message-Id: <20241030113946.229361-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit is failing on Arm and I think the fix should stop more
trailing comma issues which keep happening.

The second one I just noticed when looking at it. I don't feel strongly
about it so not sure if we should do it or not, but seems like the empty
metric-units exclusion from the JSON should be consistent if we're going
to have it at all.

Changes since v1:

  * Don't skip printing when the metric-unit string is empty but pass
    NULL instead of an empty string.

James Clark (2):
  perf stat: Fix trailing comma when there is no metric unit
  perf stat: Also hide metric-units from JSON when event didn't run

 .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
 tools/perf/util/stat-display.c                | 182 ++++++++++--------
 2 files changed, 107 insertions(+), 89 deletions(-)

-- 
2.34.1

