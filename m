Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F008233948
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395653; cv=none; b=UQWG4WS2w/gfZbyCVSLcBBZQv12jd2a284WKmzi+6EHFf9jYypczOJV7dkycX7nPk0UnSX5MJzpfTmU2Ft3peLcHVafSJOfkG4+2+Hlao6gohRu8fGNVFCf+lQUmNO8glm+lHSD28iBrqPC9kOtvMgqKwJ993l617qzn6EPOoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395653; c=relaxed/simple;
	bh=pOsQ4XO72poc7wOrZ+GHNJNf7l216/JQ02vguHI9XJA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=VQVRO7zjkl8HVkjQfR58CAH5mvGsBOoD9rxxSbcrnORp/xeRHoPUSLJy/V3+xHp5MHw5AWMumqHDRHOmT5ptiiMIE6E1OYINzNUpzy1NkgwJPgZ2N37XMC61HqXxzrNPTICguk69zclLraQv/jWuIZ/h/A2AMufsug0ymA0EpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0DCYaNI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0DCYaNI"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845ea8fd3easo8775160b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783395652; x=1784000452; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cGj80XCm4wdghDxSP8d9s/PJ28xqVi6NsISwnz0drt8=;
        b=Z0DCYaNIewg3GCrsSrm6VfQhFEglPWhbMjXZGRVo4HH4oaftCUvoGFcDDRsoPX665G
         vkgxEgLqkU4JxTyQVto3nlIW7UnpW0WavN6Zo7Oivzrh2zJcMH+JaH5TP+RtTHIZrN5K
         erovLJriyDstsWqrj/6d5SNA2Kg8mEoM1YrFDDgZGMf13qzOs8qjL1gMtvebEBfX8mN+
         lunDQS49sJTn6iSB8AdYPj7AjbV63+ppFABLzddx3luZZ6I1AMJlOXFQ+8aUX64TpQ5L
         sdvTUtoPitSm1tlNUPhRcuQzxnY0YBAH5Q5QUhS2brZ2CQ0me/kbeTrE5H/TU1T9Ylv7
         Viqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783395652; x=1784000452;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGj80XCm4wdghDxSP8d9s/PJ28xqVi6NsISwnz0drt8=;
        b=TgQVMfutUeLxWU94+bdU4/yDLrYiQ/hA8Q9nZ9USrtqXQOz1H+6S/o4N5JsTgkiB8h
         UDgM8GBrfp9AfT2n7x2h/7fwzyewOQdvpU11MOONDvNKxLWRuOsHsE7z36CaFFKLAM+l
         jz2s/kr+P7gmH3Y/SdyE3dZ/nLw11br+WUIZOZw264O9ZGjM4ZatZDrPFPaLIfcRFo+I
         kA8wnWcNpWUL/tXWYNDBrzWnULEAi5X6ft0lyvIOiGdSdnmeWIaFVRG19f4J+fsM6W7n
         z5EICwc6+S09br9xpLL2E9PbnJXRq+ZH/21GUQvmzkSrnhTjkBje/CVdTTptKS/rbbPs
         5Jug==
X-Forwarded-Encrypted: i=1; AHgh+Rq4NK+fmrs01aFkuaOTguwznreFON1h4XoM08jeJ4IGQZtpppfCfeawNwIHS+vlKP1NDIbzF2VqzAGB9MUvu3kT@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsPgd/YtelJSagpVvx95eeWkXwJ7AWRZUz94S02xPkyyWDGbK
	Bl7zCCZFF90tLp3/yWfMqDdnsvzPENJDg60qHVYcPORGw5RPzoH4B7Wm4wbfhUU4QDeaPaLfOyo
	EkgkrLQFl8Q==
X-Received: from dlbps1.prod.google.com ([2002:a05:7023:881:b0:13b:2a9e:ffc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3510:b0:3c0:278c:6a31
 with SMTP id adf61e73a8af0-3c08ec78844mr4467994637.11.1783395651632; Mon, 06
 Jul 2026 20:40:51 -0700 (PDT)
Date: Mon,  6 Jul 2026 20:40:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707034019.241762-1-irogers@google.com>
Subject: [PATCH v1 0/3]  perf jevents: Deterministic build fix and mypy cleanliness
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, 
	Chun-Tse Shao <ctshao@google.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"

Nazar Kazakov reported non-deterministic builds due to the metrics
being reordered in the jevents.py output. Fix by sorting metrics on
more than just their name.

Checking the code with mypy showed a large range of type warnings. Fix
by largely adding asserts that values aren't None and by adding type
annotations.

Ian Rogers (3):
  perf jevents: Add more components to the metric sorting order
  perf jevents: Add python type annotations
  perf jevents metric: Add python type annotations

 tools/perf/pmu-events/jevents.py | 82 +++++++++++++++++++-------------
 tools/perf/pmu-events/metric.py  | 23 +++++----
 2 files changed, 62 insertions(+), 43 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog

