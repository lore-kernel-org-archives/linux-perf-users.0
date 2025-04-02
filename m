Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFF13957E
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612447; cv=none; b=OdCBTRqmZoRHftq6JtgibcW35lriC0puNQ4tft9JfW1hw0D46nuaZejbzScKvzsS7X3qOdvu4paj385/HlJp8p7P4QFAvcgYisM3mSKxfH/AUVrxA4qmoPk2oqfDBVCv8GBNhrJNk5nMMFtnCkl5C+DEdM+Tif1Hl4BPIdkHb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612447; c=relaxed/simple;
	bh=8uZrNecXdf9WMTuxk6LZlsdLmuyrTIq1kpqDpzaDdh4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=FxTB7vLk1x6AnBUJGmjWy55LB42cG1Wy2kfjFSe6GnceffrO7f3irpFCJF+Xtr+fSqNgTD+3f5ivfYWV2HBV2lIsF5z/4EfsL/k3D7GB5JGns7zsJ15LDDTDyjjY0q/RvgfLqEMptYhmvy/agGX85uGSjDGxiFwSMVYAdJXpxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EsSODmUJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsSODmUJ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7395095a505so3441b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743612445; x=1744217245; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PVnv1ifk/rRII3YKtoo3yxRHMTzfbahaxqJkJewxpwQ=;
        b=EsSODmUJvDQXtWXBuZ0ePbkBEmlQp4xH1iFsDDRqvYxQ7kJj/w0XNKy/xObI2yQa/g
         iGKS4tkMvPwljwtwaO10QJFCps7XfdyRHsEjy6GU2hKUaIBSPXKRJ90jPbp8kxTXbUoo
         2JuNhvSHZtcemg7FgECUP4Vf9iyCl1Ej4Yj0zAz/B7kzlEHn8W5m1mBgIMronHebI+zL
         orxfytBLFyukp1oL6Qj9ueKPxy9hTJYf1KlsVXDUtQbxTtiZoUMLOQzKborkFGRnvB65
         DksqQX8QlXO4+cwc3EIG7y4o9jIJCUcW9fakHJxOIN/qx5EUZq3ee3Ws9nq7B4tlYvgS
         lt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612445; x=1744217245;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVnv1ifk/rRII3YKtoo3yxRHMTzfbahaxqJkJewxpwQ=;
        b=m6Pv91CV/075WaB8Jfj/7M1PNuJTict9yBPrelbKSIX9pPDn83r4xnF9xCKEpsf/51
         I2qGCAj9XyZVApbZXtJbp/5CF/+ZsCUYCL8a2KGtx4SykSzs3M2e7B5zwJ4THxsoDL25
         Ja0dYy+7GQ9rE3Szg9HTMXLh4wPs6EgTYgSAPL1DaVZ5uf8QezGEIWMx04m2/DXwOw+K
         NAlTtkkjg8rUzOCvlyOv6p36DW62AXhZ7yOXo9EsVNLund2syNnhFhjzZJAgjfwp+0qq
         s1PXkdhqsfI9HfkW4uAQas1VI+16pgE+3bmwNOPLGnYhyC/yck8qAiju41hgRWQH3aJU
         n2DA==
X-Forwarded-Encrypted: i=1; AJvYcCUkqz3Mo7IlZqy3vFN9JosyqMz4agudxROhdEWeBw1FtLFWPYMmR6xC0F+SeHFjcO2J800fyGsEKZAaTmj/w783@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMHN4eBSxF4GrTBVpJp8tEJZVy/hxNUJa7qgf1+3LNhQWmF3Y
	L29JGTOR8+O9nFFctP3TWgV7VC1uHrZ532aQBxaosM589RnBgo6mnAl0UlE656fWaQ6L/fP0L7l
	4v2ChSw==
X-Google-Smtp-Source: AGHT+IFbMkJj9ne/OwXFL6hbxTJviKMau0ZrjEO9my5uifu4AeWO0qy/X/nYCmeUaICKAHkEaZqh7otMMDef
X-Received: from pfbei43.prod.google.com ([2002:a05:6a00:80eb:b0:736:46a8:452d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1251:b0:736:34a2:8a20
 with SMTP id d2e1a72fcca58-739804356e6mr25656621b3a.21.1743612445110; Wed, 02
 Apr 2025 09:47:25 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:47:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402164720.3847573-1-irogers@google.com>
Subject: [PATCH v2 0/5] NMI warning and debug improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The NMI warning wouldn't fire even if all the events were for one PMU
type. Remove a nearby, and no longer useful, mixed hardware event
group function. Improve the evlist to string function and dump it in
verbose mode after the reordered events warning.

As commonly happens legacy events like instructions will be uniquified
to hybrid events like cpu_core/instructions/, even though the
encodings differ. To make this correct either:
https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
or:
https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-irogers@google.com/
needs merging.

v2: Rename evlist__has_hybrid to evlist__has_hybrid_pmus and add a
    max_length parameter to evlist__format_evsels as suggested by Kan
    Liang.

Ian Rogers (5):
  perf stat: Better hybrid support for the NMI watchdog warning
  perf stat: Remove print_mixed_hw_group_error
  perf evlist: Refactor evlist__scnprintf_evsels
  perf evlist: Add groups to evlist__format_evsels
  perf parse-events: Add debug dump of evlist if reordered

 tools/perf/builtin-record.c    |  9 ++++---
 tools/perf/util/evlist.c       | 34 ++++++++++++++++-------
 tools/perf/util/evlist.h       |  3 ++-
 tools/perf/util/parse-events.c | 16 ++++++++---
 tools/perf/util/stat-display.c | 49 +++++++++++-----------------------
 tools/perf/util/stat.h         |  1 -
 6 files changed, 60 insertions(+), 52 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog

