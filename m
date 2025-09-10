Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018631D38A
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511041; cv=none; b=j6m15pGE1X/onhCMkkw0F6B6EJAUr+sEtE3zCWWkFgI8xOXybFPI+3I4QmXE1CXMjBDqZex1ATiRbRmxlDXAuri558R4j7/Ejs6Z162BHcWStEHoUoJqC1E6fyuS8aCukyVtWfbkn2PeSAohouRUls3McLfZbCZ33u04SuaobyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511041; c=relaxed/simple;
	bh=+0dvYWW0YLM6sPn0xa7nIVy3l++/JTX8Z40PttWV9BQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tjWzA6IvHAaKwSN9GRInOGn+YFJniUMjwm/8sqpal7DLv/P+5z66VdJg0PtfX95ugbBhtydczcVzJysqHLkOkYtFRWYicDebrJXjtTRTL9wPkBNeYTTBPmwBlwCLx6J9qGmSV258q8ohfl+pBUpiU0/UdZ5g8P01I2yKgzcQNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QgP8xVIY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgP8xVIY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso45359615e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757511038; x=1758115838; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuM5ADDmsvDRmcHroZq1v+E7rFT9yvEbvExVg13TLRI=;
        b=QgP8xVIYwV/VGmeJaGKNe9DitHsvUPGw5AKmErd5k23t723JyS6n2+TaG9caQ+7NjY
         mwwq8xW5WvwROllrlDhSz5RuZshZnLlUwNHjZixH8SqTnSxMJe/Cbiiz909Fru50ksW9
         n6YBDa8sS1KBlJYL1NVCYTEJJzvpusVrSRKq6T8/reVIUx3MbrYyIG0HxTeN15ReWyyb
         twvrH+rYs8rj69AHl9QF78ZOcebZKcV/0BYYcxXmab7wGyQGGw7G7qTdXyW4khAXN75Z
         I+dpE5qeY5wjU0Ehe9O7WdyWUvNxlYkbTiCi0TtSjp4SJ3y0pgj67t8phQrKqV9q2rsq
         eNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511038; x=1758115838;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuM5ADDmsvDRmcHroZq1v+E7rFT9yvEbvExVg13TLRI=;
        b=r4lEa2jlPxrhfakA81Y1XHVG3LshwR0l7+SoG3vzurNBUJY54466uRbYysRUyPwG6m
         grfWkTT9t4HZzwEWgM8eKa/tfsYKF/XgaeNFdwVgOWWg4OQN7NH2mUe9T9apn32qtNC6
         9wze1hYkj4EcpAVCU1+qzLO13CQ1t+2xA3TJTSccMk+YAXJqHFTHofGpKx6Phh8kNyK2
         2oNKTc6eYj0wEn549r/MWvRiRkruY+Rmt9wDEZ1ZLu15CW4BVUWyMeBsdx57Dt27WkcN
         XVjJ14bwPsfk902C14beADAflSs5Cp/au3fQ7cetxaU4E6eKwGLUefYgNknpOaKXY87b
         SYSw==
X-Forwarded-Encrypted: i=1; AJvYcCXQdv2GmauLhmIRCqVrf+aGdltvMdTwgHkZLTXZGdTmUr+FSP4sru0KX8WhGdrRjx88HpOkBSW290K4Cu0WG8e6@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGjiCKea8EasKqKg1eBT8WpA3sC19UjvOhNSN/A/tCfLimuwI
	3Eu+NFtZCyWHF5NeJyZuVJ0EUaNhUmVrlvlEO1zNq/Grp9OhkMqWpD/LQf84WAw3MjE=
X-Gm-Gg: ASbGncuPvttgO59nMGSO3hbKQML5xy++WR1W27VI5PzkCYwQDSAi6CcrtLcBuZhX5to
	iUSKAnt9etdZ1+EDGfWC+k3oSNOfskL2Kx88BRQEY2DD4HXMW+l21oXAxe4/a8FxOaDjXFo0/oq
	Iuuoy4kxSwUIomFDRbxfqFozPEKON4cUPIcSB+HDC6J4vN+uEoccwPGrcyY4VJj9XsYrK8NIhZq
	gKaaOjmWW1o5cYopKn9gMYH8uCChPTE1d2++piaTD1PiY6E66cjsEaL15QZlhBF1MOJOtjq0Wtl
	HStOLzZCI3o1BN9Jc4oHUGhO65M/slMDAjvmJRIbRbopwYjnWpftTKaiQi2XraEXE82n3ThBflO
	xX2dyVkarO3zB+WJWD8Yk0DxbFgKbB7zfu6MOGDLe6Q==
X-Google-Smtp-Source: AGHT+IF16lC7AxEoodua5PGUp1T0kiWW7xMxMFTLoAHAXL3Sovft4Oyrs9B7sSnWNkctNMCKPUA2JA==
X-Received: by 2002:a05:600c:c8f:b0:45c:b55f:466a with SMTP id 5b1f17b1804b1-45ddde9295dmr149406865e9.15.1757511038256;
        Wed, 10 Sep 2025 06:30:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df16070bdsm30387015e9.3.2025.09.10.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:30:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] tools headers: Cleanup headers
Date: Wed, 10 Sep 2025 14:30:10 +0100
Message-Id: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJ9wWgC/x3MQQ6CMBAF0KuQWTtJqWDAqxgWY/nIEGxJR40J4
 e42Lt/m7WTICqNrtVPGR01TLKhPFYVZ4gOsYzF551vX144XecL4ldJqPENGZA4rJL437s/3S2i
 8NEE6KsGWMen3n9+G4/gBhkIqVmwAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

A few headers are unused so remove them.

---
James Clark (2):
      tools headers: Remove unused kvm_perf.h copies
      tools headers: Remove unused arm32 asm/kvm.h copy

 tools/arch/arm/include/uapi/asm/kvm.h       | 315 ----------------------------
 tools/arch/s390/include/uapi/asm/kvm_perf.h |  22 --
 tools/arch/x86/include/uapi/asm/kvm_perf.h  |  17 --
 tools/perf/check-headers.sh                 |   3 -
 4 files changed, 357 deletions(-)
---
base-commit: fb96bf8f51698f0666ecd74f7d1b9b394262b65e
change-id: 20250910-james-tools-header-cleanup-93b6c42a4ca8

Best regards,
-- 
James Clark <james.clark@linaro.org>

