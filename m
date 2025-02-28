Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06F1DE4C7
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781433; cv=none; b=L6JYfBFt9AlJsS41/3lgFC83Kj4+1H9zs0Wj/KJ68Wt5bl+IB3WedQCG1bfjWVcJQgoWPxPcvMw11Xzr2d7sx1pXwhHTMrks6nYk9sFLrKMSrgaEPAzb1lieTKnjqHqcQ29EU7X2tV5kdDXtz5ptZ+hM+wGG/jR9iee9aniJyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781433; c=relaxed/simple;
	bh=t5obstzOsFYHZQMeUlh840zqrWOvu/IZWSg25oxLlQw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=KAKJNp9VF0TXcxqPAml0MJge0IYGsz+ojUTN+MQylxQkPu2njDCcDhWzuBvsoflkHxxD+U1nSLQX5jcbnot6jUBuvufKz50qY8xTdaz63GJ5n+NOeuLr37iMuKeL1mgKDoz9jsGfJapJ5bCOMmlG7MRpDMZNKTV1KU/Z7ka5OSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9S66EPs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9S66EPs"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2793679ebso30658427b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781431; x=1741386231; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1gaG8MxbaAldmJlxoU3EEkJb8EuBrTpS7RMIu6uThJI=;
        b=R9S66EPs5txJDHZJRFELkQx8sX8HqW09/2bgOBrLpIWJ0g3kIeWu5xrSGtAmT+XOAz
         IyEw52yJosbmL4fsTJK1OqvcCx+Kuk/8XlIWThmU3ikx+5OYGXhPZWsAwTHYieNXha3v
         F+im59uZ9goTq9tcIqNDpRl+5Ehbf5SL1pXOmvjTxcxpTfqekLVvnyaNtmmiyxc1HjqL
         e5qOoz78I7KpA79ME5v0X6E/idWDLl4mQFYoW7joKtDHAltK2xTuhFpzyKbMwP4cYjyJ
         tSmgb2QmEld+E1+7Y/do7n9jBcZpEMzbsashGaL8dbWXZz0ur4DvLrb95RkguE+1w8zI
         Aiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781431; x=1741386231;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gaG8MxbaAldmJlxoU3EEkJb8EuBrTpS7RMIu6uThJI=;
        b=fXsohQn3RJFk/g/F0l/wp9952zzyUAeqs3lwofU1JPguRm4tVN+Q+qLBTFMcb0gzzq
         9GDnfpszFD0tFnIsMxqcxub9TNVqqMv8Q3oxPK4A5p5KwDzZxaBdXy+sQtQTa3A3D2Oi
         EggT6Mx+tfywYsUcfV+8Y9L/NkK/uwbQybB/07SVuB1LFsPohSdK1M+ieCzkIA8CwMUB
         hwiI5obwA5RbsSwyabLsn0s7gfZhnC+yQBL1Q/hqb5P88c7WLxWv1M9FHMtD18227puW
         TqlDgljTwfLCDMSSYKbw1wG4UQuBywPK+u3a+L4b7K0St5EHO0MYr2q5z3bc8o4zCgwk
         TOiA==
X-Forwarded-Encrypted: i=1; AJvYcCVvC+gs5gjnuFrgug7jOl34EfahciR5Z5W1ubCVHULWgt+dOlWb60wEYk9TTb3SCSeJvpLo04viqbwCZ+MCAnWK@vger.kernel.org
X-Gm-Message-State: AOJu0YwuB+EKhIKQBcfKYt9roO4phR+WaX4n+me+WaKcYrLR/LLHq5MK
	qTHPK3qYZM463U+rPkxj56qm89q183Q9mYzWfOSRI5LCQ6Ytzym+nNsKfvVP9SPl270UFhl+0hs
	iDNQbRQ==
X-Google-Smtp-Source: AGHT+IEO8S8uc3Pu23GUjCfLISxHYBj4GGmavUA+KxZLvnODKz5g4cAro5i1QbvxsUJyyjyVdTINfVJka6we
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a5b:b43:0:b0:e5e:fdc:88e1 with SMTP id
 3f1490d57ef6-e60b2f347b6mr513963276.4.1740781430772; Fri, 28 Feb 2025
 14:23:50 -0800 (PST)
Date: Fri, 28 Feb 2025 14:22:57 -0800
Message-Id: <20250228222308.626803-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 00/11] Python improvements for a real use of parse_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

While parse_events access in python was added, it wasn't used by any
python script. In enabling this for the tracepoint.py script a number
of latent bugs and necessary improvements were discovered.

v2: Fix a whitespace issue on the evlist.config patch spotted by
    Howard and add his reviewed-by tags.

Ian Rogers (11):
  perf debug: Avoid stack overflow in recursive error message
  perf evlist: Add success path to evlist__create_syswide_maps
  perf evsel: tp_format accessing improvements
  perf python: Add evlist enable and disable methods
  perf python: Add member access to a number of evsel variables
  perf python: Add optional cpus and threads arguments to parse_events
  perf python: Update ungrouped evsel leader in clone
  perf python: Avoid duplicated code in get_tracepoint_field
  perf python: Add evlist all_cpus accessor
  perf python: Add evlist.config to set up record options
  perf python tracepoint: Switch to using parse_events

 tools/perf/python/tracepoint.py |  23 +++---
 tools/perf/util/debug.c         |   2 +-
 tools/perf/util/evlist.c        |  13 ++--
 tools/perf/util/evsel.c         |  16 +++-
 tools/perf/util/python.c        | 127 ++++++++++++++++++++++++++++----
 5 files changed, 145 insertions(+), 36 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog

