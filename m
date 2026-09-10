Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF93C10B3
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074770; cv=none; b=WKJpPsFT+YeryR4Xg+CxpmJjMMOFeXdfCdUoUM4Gm+Z/Kku4tOTJm3OvcnD0KvkIeDwQ0tGhsSGP7sawt8fhajC7xeynejsVWRiuNAL9Fgu7hpFOx5ccAISuMqro27J044kcaNf/AUOFACFoLYp0+h1ZVdTp4vlpXnADf7v5g5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074770; c=relaxed/simple;
	bh=/EzAoEUS2YE8bsBvoGE3Tm/8BjynJFrFkU9MDyxB9Zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WkwwVC6CBiWgD0gcU5ei4xbIPfx8dSI6CAN9xSID/dv3HVU2RSFdLzZZz/6rklbqPQ0lAP1ysl/6LaLxn4GDxGESHysWt1+PkbtwtkMmFbK5qELcC4NmA7WGpSadW2qdzBovTaqd7OQdMIhvFuIqlTzcQcKgs1phVZ7fHYbtcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4yspzZf; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4yspzZf"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b6416441eso324985a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789074755; x=1789679555; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tr7m1319nZL5iERS06+kdvt+gsbg/YAeXusZ5Kgx2bw=;
        b=e4yspzZfHIlNEPoOJtGJp+NTRzzz6b0aMqy3sSWTovQGomYSzyG1FV+WO0Nkstnb2o
         4zgXUZT/PLqrCPvWQCMFVY94EqE9yrIQKh2AElnYhIPkPV0X05JDPq9adfrZLlnvx10N
         J7keGd70FfUt7bMj0C9EYj6osJYywH5V7H8w/HCczKV8l/JWyehcf6xhDXNX7VlY7ykG
         PxW6PAAHrUdNQ645hs+mGPUcKt0QnLXT3KQx0/3eq7nuJLtulfcQVeL7dhlatJWfmJbt
         x7Np89RXdl1HV2verdDUUjdIV6Dt7ALbm80tllEp/WWfTieW+hCmhM4NXZ76zFdTxZhY
         iICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074755; x=1789679555;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tr7m1319nZL5iERS06+kdvt+gsbg/YAeXusZ5Kgx2bw=;
        b=sQ/S7qtajHKVzKOO7voSALPt7BdBLACX7EO+b6m4VJivtRlUHyhUn4/k5J3Gx2Jn54
         07DsX+vA+zboF0Dy0FTFqcJRia4UaQVWmsdK2yMWarOfbPEHbMS5WtbTe2wA7r87hGZj
         /KPxK08NJU5+E5RjkyMZ8OI0emiEqTIgfiuFQtjEhYL2q72WkayWrrdTyhbucOjG2X0w
         nDCjubvN4yVIf/LMcTGRX0IYXH2ehwvY49opPebVFZQwTzIeipjLbJeRcRWOo1DKJoLf
         p1Tg7ISIVE5Iz/uCqqcDTlanxsinayJ82PBTX64/rrJI8Ft0bGsb8TBdbE4drGfv3IXx
         R7oA==
X-Forwarded-Encrypted: i=1; AKwUvBymZRTGbqpC/j96TiawLFL2KiEgy99nH4rctUbKmfP2g6AEfc3EfLicxSa5NqUR6sSejKqdPCTtXHxm997HxROp@vger.kernel.org
X-Gm-Message-State: AFuF++lGCK0tuJrTxWt7ZtHV2ZZz69/7VmADAO9mJD5ql8uJkiEqOQew
	xeKRdgAEEj91YnC3B+pCBvgh5og/O9CuLRrsG+fJXtu15elYEcD4lG1SS0wPxoAeHiiH0hgTf5n
	SQV21L0bWNw==
X-Received: from dld34.prod.google.com ([2002:a05:7022:322:b0:13b:2a9e:ffc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2741:b0:393:19a3:4f1
 with SMTP id 98e67ed59e1d1-39d9bdbb0e4mr920398a91.6.1789074754460; Thu, 10
 Sep 2026 14:12:34 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:12:17 -0700
In-Reply-To: <20260910175634.3014018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910175634.3014018-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910211221.3154261-1-irogers@google.com>
Subject: [PATCH v3 0/3] perf header: Fix memory corruption and unnecessary warning
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some minor fixes that have shown up during testing.

v3: Fix Sashiko include nit. Accidentally posted wrong 1st patch in v2 (sorry :-( )
v2: Fix missing newling for pr_warning:
https://lore.kernel.org/linux-perf-users/20260910175634.3014018-1-irogers@google.com/
v1:
https://lore.kernel.org/linux-perf-users/20260910173715.2996571-1-irogers@google.com/

Ian Rogers (3):
  perf header: Fix HEADER_COMPRESSED validation for comp_mmap_len
  perf header: Fix potential memory corruption in cpu_cache_level__read
  perf header: Transition WARN macros to debug.h equivalents

 tools/perf/util/header.c | 122 ++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 48 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog

