Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290713659E5
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806131; cv=none; b=IOLVxBb8MRxC/sC3mkoqhxsCfUH0oJF+uPPCirPG/saARQRJjX7LhrNySzKBbD7Xi7KQxqAtH/8TpoB5IbCQvpOlsLc/hfiOjr7dbyFG+CB82KllYNvBPexkcxORStU1WR6rJ7KMWGpUfXucf55lZtXhs8ByGE78i7i1PQ+gVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806131; c=relaxed/simple;
	bh=tnjOCiWW3gUp20QGilqKcnBxOCrAFWRtlEqrhCtgQTE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fHZyZ7ME/HFikV7pNwXA0srfTOJkFqkktly7iAxcabp9YqnEERkxrhZWaZorFsFmJJsxpLuP89jEAAh2ZNYRVc+PVNUH1eaRz6GTdGM3hzqxIO2HH0JHlVsX33UDCxng21qll5OxUyhtHxWiMv0C6dIbkW8o0JqlWhekdd5kgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sJeNev1n; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sJeNev1n"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c5b40f60so2733671f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772806128; x=1773410928; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTFnqPhdGDy0o98vgCtpr3hY5Ue9KjjzpvOD/DLxois=;
        b=sJeNev1nQr5ijEaf9PbJdSgHJLxGBPf2f7cVZXAKDhXkszBqYoSvRLLLnbbkla6mFI
         Lst+tq5Zo+AB7ncalnUVdJR5Lo2Njjz6CQ9/ddAW3R6S+vHcve4JTivlPDzGjR9erbup
         dy8R88QiBKaalDjT6cr0xlOGuvXF34fhwK0GgTxQqxPUjBxhmYsYrL1mkGPNhnefw3xs
         YR8f4v6BxAATbtMF1T+PicukdG7ubX5j6S1KMBnXpslmegjroSzEy3pygp5UmvhNVNDF
         A1MD8Fp+HXYqrOcNRJ1ZKESOvq1jfuSsYwVMnu7hdU/w9GEm7HK+s8w939dhUs9egUB6
         ixMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772806128; x=1773410928;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTFnqPhdGDy0o98vgCtpr3hY5Ue9KjjzpvOD/DLxois=;
        b=cUYiIFBfgsHTheG5h9TOFHHeYKcJhWflc0JHwxBGuAJtmI3WFAFk5zGRR/leBhs9AP
         oDj8QWb2k3CDLXlzuxQ231tjblRc6pG5nbdjalNUTY5HrIET25iBWnXMyVi2qLt7KLnl
         /HbuhA48Yf43oYwx5T9OqcSSAMsyFsj4BmfUwBDPci3DAHSAM0vlxS6OQffeuxn2XvBl
         AYhT0ykn/Bi5JEkghIL+4TKMAVnaw0CQR/KAKFn7FeFGRv0Yyx9zckShyW7XPd0Tn1v+
         FD/nIBRvBE73cmSNhioIluVm6J7fGCT2ocAavRNd/eFFUdsbTYjjqw+o4p/lQnzl6g8w
         qeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgI1EszhJvMITe5/TXQAlx8tsIYfphVxP0e9vSaHEQoBqDXSHaXFQ+qeFd9Eacyan+pZY/HwtB8oUxEzcjuvDU@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPEH12O7AUIa5WCZFXDmDQWtpOlB9/hczIySgKCKtuI6w7k+A
	g+a4mdMIyZ9QXePnW9A0Y+9/aeXyYqmjXZyObQKNTWj+/zpCazYgPPHM07KwOKYjHVQ=
X-Gm-Gg: ATEYQzx2CoI4UDk0FoS9Bhua2jJYwvCjKvCzR/R57tev5k3WoBNKYP6u7ekXmaWIcvl
	1mgS7a71z+AiejJ7SGc2RwFh94Lf2bWw43am8kciqkw3QLcEg2BgGFb7Fo17ijc8byRbX1bmegv
	kITEiY9UdcZLpSxSdUFxMgEGLJDFQWS2E5Riusrx7LLz0Ugr72MVbo7mYqskNcftB03QY9TzNVK
	Gqf1w61pIkZA7gWGLGV/IhHyw/+nOal+6tyjnTpwqX671U0zRRCBJhqVWoDCCVvGaMbOlrmq0Sg
	4bKgIXIPCp/RkyHElkKs2Emx47VwVPbxM+bYTkvOc0vgdzqge2HHT1ij1D8NJCY6vB/hHj9lKQ4
	iHLu9ZmelXeUwzHTfpGGsxe4f0W9chGm/UERVH4GZi5VvYZUFutH3RRGH6wlBlhDHTweg5+P5bX
	YQBTbKMGkWqjw9bQLifPUIFXi3CpTwByOw
X-Received: by 2002:a05:6000:2886:b0:439:b7c9:2edb with SMTP id ffacd0b85a97d-439da35c8e3mr4031345f8f.25.1772806128424;
        Fri, 06 Mar 2026 06:08:48 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2bdf8sm4212967f8f.25.2026.03.06.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:08:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/2] perf cs-etm: Finish removal of ETM_OPT_*
Date: Fri, 06 Mar 2026 14:08:33 +0000
Message-Id: <20260306-james-perf-remove-etm_opt-v2-0-b411d3ae24b3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHfqmkC/42NQQrCMBBFryKzdmSaQKyuvIcUCem0HbFNmZSgl
 N7d2BO4fA/++yskVuEE18MKylmSxKmAOR4gDH7qGaUtDIaMI0sOn37khDNrh8pjzIy8jI84Lxi
 IL/7s6jZwDWU/K3fy3tv3pvAgaYn62a9y9bP/VHOFhGSDc8bWZF11e8nkNZ6i9tBs2/YFXU/gG
 sMAAAA=
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0

Finish removal of ETM_OPT_* defines so the coresight-pmu.h header can
by synced from the kernel.

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v2:
- Access metadata through existing etm pointer (Leo)
- Link to v1: https://lore.kernel.org/r/20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org

---
James Clark (2):
      perf cs-etm: Finish removal of ETM_OPT_*
      tools: Sync coresight-pmu.h header

 tools/include/linux/coresight-pmu.h             | 24 -----------------
 tools/perf/arch/arm/util/cs-etm.c               | 14 ----------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +-
 tools/perf/util/cs-etm.c                        | 36 +++++++++----------------
 tools/perf/util/cs-etm.h                        | 15 +++++++++++
 5 files changed, 29 insertions(+), 62 deletions(-)
---
base-commit: b1718b0367ba31e8db273e3896ebd1707bcbe59e
change-id: 20260306-james-perf-remove-etm_opt-c0e9a768dce8

Best regards,
-- 
James Clark <james.clark@linaro.org>

