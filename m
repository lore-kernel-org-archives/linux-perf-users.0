Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3261DFED
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896417; cv=none; b=BNI4LaW1LRrWlgHAsJVcajkUrSZ5G5UsSyz6IKcQeFJpWXvehNB0p/zd5UHlYzo5bYM0QsScqhqXpNRmYyV0piocciZ8nfdd9Zf09Jv6Aow0TZoEWVhOIlbR31Yo6rBJrHe0/HMkR9virx/fWsDOhbuZvjt9KqzK74nimze/i0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896417; c=relaxed/simple;
	bh=64Spdtq5v0tNmQvl+3hIEU6NKDiPaXBSsDonQX6xE98=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=HFonbR0mq5euFCSlY0c8G0JDyTaPvKG+xbMBU73T89a+gu8zENnWu/rAuP+5YVfnC3K38qalaBH0DFwPZ4jxMMIYoNy/ci8jczdoGNHKiq5JDFjg8k3z1+IPsCJLGL6si8qakCWyQGEu1UhfWur0eFRE1Dat6C/4V6eq52v8xoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IugzljfT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IugzljfT"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e53bf9e60e4so14743404276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 15:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736896415; x=1737501215; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+oRuY3YdhcoxwQSLbrJvwKqce5Vo+bJ/IFTavPOkL8=;
        b=IugzljfTWos7d+ffYHheOB2kkknZkMG60azvmb3qpwqe5ZiZU4OR5KKGI/5Vf/y+L4
         WQKTmWF1//IlAZI1PY/xh3UEZS/C8BaQ0mdoXHbUx80QCirWMLiN6F3NpO3Ax2OlWtLi
         ABgwbgU5LqIloYBDKzdRdy+FSObA7BQzs817ikjCxAktpK8JFP++ol3GuIuAbZ3eGAZe
         HHcN7e9cZ2C9HO+h5fSjeaBWM+VlUGjmpInfqJJWeNdZTMEhWcwIW7F3UUXR3xJSFuf2
         PzwHqAW8tHnWkKm9E0Bqq4iXNaB85IU2lddpg33fn4c/9/xE9FcQz17atkAa0Inv+OTX
         Q4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896415; x=1737501215;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+oRuY3YdhcoxwQSLbrJvwKqce5Vo+bJ/IFTavPOkL8=;
        b=Ymjb3zulXBLGIlylyLWnFECRvdVAwJfOpHTgYcYQEu0PBMnSEyOxtoG0aePvHaFS3W
         A36/5V24opa1GjLFobdS1HhEt4vQNknL9tKLRvBzfHEfnP/QZXxBZMHmN0+YjptERN36
         W+7EASPKplnjRwU18e3CcW6cBfE7YxRe9tROPrsKHFsJuMEvuPNxZ8oOKFBhQ613Buhn
         SGu9dHAF9mnBX36ny76kie/0x+Lt9A9nwL574fiDFPKwxdpA9VbH4xJt4PkHJhqh1dBq
         /BYn39CFQn629Yisrnw2VdYG1B35ydZAaqok2RPNX3u3WRD2Y8iAHvFqXBSHBrtIkqEa
         bN6A==
X-Forwarded-Encrypted: i=1; AJvYcCWi4oo7PM/JiXc1Ub96h9d5RWaITKii0yDwWm0PEGPVkvxGZDmCplV+N6iRQ8e0PXml1qdXdWlNDK2ijlalNimi@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbTUVhv73LptH83qhq2XPyv0EJDUDJTio64Mya5Q2WOtu5v9G
	tELSioH29NcSDGHl611VeLLVxpJDJlIEKEK615RxjK2mupydJQt7kdR8M+Wh7SanCp4dfptP0FO
	1jSLGcA==
X-Google-Smtp-Source: AGHT+IGtPQmBvE61IcLwLAja+B9hycGGygBwXBDNHaGwMGEZLA5VzCaM0E8SQw2e6dSyyiz+/puS5+EG61/g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b3e8:96da:3fa1:5494])
 (user=irogers job=sendgmr) by 2002:a0d:c385:0:b0:6ee:b2fa:d8a8 with SMTP id
 00721157ae682-6f5311e3e80mr611207b3.1.1736896415223; Tue, 14 Jan 2025
 15:13:35 -0800 (PST)
Date: Tue, 14 Jan 2025 15:13:28 -0800
Message-Id: <20250114231332.13419-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v1 0/4] perf hwmon related improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Try to do less scanning of files/directories with or without hwmon
PMUs. Don't merge all events with the same name, only merge those on
the same PMU ignoring suffix. Refactor uniquification so the evsels
with the same name as other evsels in the evlist are uniquified.

Ian Rogers (4):
  perf evsel: Reduce scanning core PMUs in is_hybrid
  perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
  perf stat: Don't merge counters purely on name
  perf stat: Changes to event name uniquification

 tools/perf/util/evsel.c        |   4 +-
 tools/perf/util/evsel.h        |   1 +
 tools/perf/util/pmu.h          |   2 +
 tools/perf/util/pmus.c         | 144 +++++++++++++++++++++------------
 tools/perf/util/stat-display.c | 111 +++++++++++++++++--------
 tools/perf/util/stat.c         |  13 ++-
 6 files changed, 187 insertions(+), 88 deletions(-)

-- 
2.48.0.rc2.279.g1de40edade-goog

