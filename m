Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6072A10E5
	for <linux-perf-users@vger.kernel.org>; Sun, 28 Apr 2024 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714282582; cv=none; b=m7/g/mOrSm1TW+aAwYusIC5GOwbPwCSQj72u4X6Y0Zx/DamA3/iuZAgli0LK3MKetOZQ/LPIUSqWKzsVEjxpNys6N/n/zqIPKfLGi/fY27g4c3redhYCcSkaRm5s2vqVQA6GCxa7YPshi4s++pfGMTVKgp8GtCxDW4szNzOPTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714282582; c=relaxed/simple;
	bh=NFU1j9REnnJnHP9rU0qINEtrlKmkOP2nR4Z7xM3qTzY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=nmXe55b7uy1QmzrhyAoOrJX/16wCIS7QUenRSCIjM6TYGu2lXL2awi5Xy5DZlwEm7KdsBj6w9AGEG7u7MzigJOMp5geSTu+yNLEckxU5loY8NOnmo82Ui1mQ/R6qZytGsAfjHkNxAazmTJmaUr1GBWIVR9oiZcpETZ525G5cIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjUKM5Rd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjUKM5Rd"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de465062289so7293770276.2
        for <linux-perf-users@vger.kernel.org>; Sat, 27 Apr 2024 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714282580; x=1714887380; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5UONr62/BtTjFsEWsO6NhiyjPYCMJsSpwuIBi8shds=;
        b=VjUKM5RdYC+JuffF5tG5W8bHB4lLYT/GmXOEmbSQL6+RFK6zofN0fgMuBK9Q5nQwYG
         QFoiXZ3ceBVatJCJ1TC+Mq9BSsoUP8VZQR6nm8evyr4Ip7aLWheWy8y+LnOhQnG3CK3i
         QO+EtmYnK4UnsoOdPo2QlSobCkaiCOuRMM0O2IvTiPQN5LI5kKdHoYlhHvczk86OVItt
         V55h7jFDg6djPn+DanMY7l8LPKzAB4Nlg4bE7zkxTe5x60wPCw/XL9jUwoyaJzrXmUts
         BuHTs2xHMWbT7qC9sJg35bBsgx8uEOYlMbbvHTi5+TYVjKNYABpo0JeSj59XI5+fcTLE
         5loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714282580; x=1714887380;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5UONr62/BtTjFsEWsO6NhiyjPYCMJsSpwuIBi8shds=;
        b=oSnbEtPy4ZRHGgBVVBQdhmfrvGgz6EhjnOFiAO8PBp0x+dzXpvf1WTT50IZPDd6dwb
         BoFylC1fSbfbz0gNGtaaPCTI0eSWXh+XiaCFzxzmnc8AtKGMlS6/jHDwQrUYBFvHk5Ge
         C16zMu3WiBZi/w0CX+KXmepUL990k7zR9A705B8Gsd3ObQJm+RK2m8yHzQtm9ME7uF2U
         6qoaqJqyqbMML6A/1r2XYHapOg0QUTmm/zgoN4xA67hW6vvcTmFt01T/e0vFVTNKyqkp
         ptEtzFELSTK9C/XJ1rlTxvJFS3Fu+d8anVlSjeLqjubqBMaLmvEtp+8NVZW/uy2XEKHE
         s09Q==
X-Forwarded-Encrypted: i=1; AJvYcCWj42EbsqEvfwE9mJicQLTjHgwST9fUSjvd2lx6EiA4oBUVIdYZXNhv+j5h/3KoKsAR2ayUVMvPxR6RsPlKl8z7KaLL20/BoABFNy63Fvj+ag==
X-Gm-Message-State: AOJu0Yy+BL8xVyGoc/HvGhhN2kDh8gcjx8Mc385GM/m1SgdlowYPtvSQ
	gSKtiTRzqs6TNuonunhAAKyaXdTrUASMC9Fy2sSIYYhYze8AEkAh50h6vjoBUts00cqWBEFI7yr
	Zi5GkhA==
X-Google-Smtp-Source: AGHT+IHnIqnyqOgG5wxLpKKGc0nBRCSWmDN48/SGCvVP7YH14n7K1dyVj/TAGmLMLknF4zCi/jqrnVM9edAg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:eaaa:2f79:c83c:9def])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b03:b0:de4:845b:8f08 with SMTP
 id fi3-20020a0569022b0300b00de4845b8f08mr2249715ybb.2.1714282580394; Sat, 27
 Apr 2024 22:36:20 -0700 (PDT)
Date: Sat, 27 Apr 2024 22:36:12 -0700
Message-Id: <20240428053616.1125891-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v2 0/3] Retirement latency perf stat support
From: Ian Rogers <irogers@google.com>
To: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support 'R' as a retirement latency modifier on events. When present
the evsel will fork perf record and perf report commands, parsing the
perf report output as the count value. The intent is to do something
similar to Weilin's series:
https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel.com/

While the 'R' and the retirement latency are Intel specific, in the
future I can imagine more evsel like commands that require child
processes. We can make the logic more generic at that point.

The code is untested on hardware that supports retirement latency, and
with metrics with retirement latency in them. The record is also of
sleep and various things need tweaking but I think v1 is good enough
for people to give input.

The first patch refactors tool events. I came across various issues
while looking into the issue and we can likely just pick it first. I
kept it in the series for cleanliness sake.

The code has benefitted greatly from Weilin's work and Namhyung's
great review input.

v2. Better refactor tool events to support interval mode and more.
    Switch "weight1" to "retire_lat" in perf report command.
    Ensure max precision 'P' is enabled on the perf record command.
    Kill the perf record at read but keep sleep 0.1.
    Fix issues around perf record of tool and retirement latency events.

Ian Rogers (3):
  perf evsel: Refactor tool events
  perf parse-events: Add a retirement latency modifier
  perf evsel: Add retirement latency event support

 tools/perf/builtin-stat.c      |  74 +++---
 tools/perf/util/evsel.c        | 409 ++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h        |  10 +
 tools/perf/util/parse-events.c |   2 +
 tools/perf/util/parse-events.h |   1 +
 tools/perf/util/parse-events.l |   3 +-
 6 files changed, 453 insertions(+), 46 deletions(-)

-- 
2.44.0.769.g3c40516874-goog

