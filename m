Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C4A2D
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409078; cv=none; b=RREzhEiCfiJwpFdWTLfIzil8da7VnYeNLM7ed8ZOkiEjxsQZNCRpt9wC3Athv4pvLR5kvBJ5LetWQW3FyAX3zLQtliFXWEsbcQspzKwKuKF+PUUoWxQf6ILe/lyGIYMBfGYcllMc0R/92Bf98EBhxMSwIAJ0czF96cK5sdepwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409078; c=relaxed/simple;
	bh=NgNGGXDCEmAc1LpZTPl9JoIjk6vyEGof3BxpbdHW61w=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=uom77kz5iO6KvI+3roQE/n0QilH3idTjzAtJh/9IJxNUch3XBthEg+oMsphWwzYtKPclb9BSvWhfYmYH1t3oHMdB1xdrCiXs2WdOmhgc9Dg4e17t+VZrwxplhUrg9Iu9IKXQZIN9CHOhpISB/xRN4ajhhhYkAXqbLpMT/SHy9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbvhMu59; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbvhMu59"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso1427626276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409076; x=1737013876; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A6oCyJ6VA9pSfECFyiTNm0tpn1KomntB6XldcC3u6rs=;
        b=qbvhMu59fo+IafQmEu0jNeiJ+8MRlV5IlnTvJZ9vgQG5HhsJ2iI46FUQfKPAOcRiCi
         mt1sYy7BAOwiM1XDt5HdiCRljxLhAa2zQoItfN8yQO44vkrrkYJ1Fn1qieaEi7eo1RJ1
         YANgsf/hXetCxOW2S9eBOvix0FFCGAqaNt2RmXzYzg2Y+XdiFkVikYKdJ5fw+Eo87QCQ
         Xn9o3ZL47oDHX6KPTI5pGxgIxaftFuF6U46rzl7Wl59Fhl/ZeHpp/qHyIeZwkwJTO7I4
         6kDcX5UJ9HeMpusDQ8XUQlMflNFqjJZZLKviscdFesiPXc+WcdJrCJ2pPSciaS64EIgm
         QJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409076; x=1737013876;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6oCyJ6VA9pSfECFyiTNm0tpn1KomntB6XldcC3u6rs=;
        b=rnxeojzTVSo7FvJPTM9N4k0gdxWa9ZTt1NS+E+5jQ17txxVCZbFcFvArHzz55sLuTZ
         g34Ejaeeq9zfBcKkFkEQBH0Hqmohh8FsL+E5d8ZzZBUlX9bqmOdPksNNGsfCRqvB6RBr
         oP4js5+XQjKqSKCZE02L4KXl6jqUkowYwCYb2iZTm3EgSwh4Zr2Sygn8HPDY155huZPv
         pQ8EVeQfhveyBwW1+NrtfJ2ZM8T5NOGjE84/Vk4gHd3eYXVRHysJ5FlMYbWrxlIS1XU3
         grxZ6mRhYw2jjzrVQNVJh6ndn6sgV26PyKk1eX5aZul+Ul1KKiG/EBtOiZG2E4NNrxbZ
         OJMw==
X-Forwarded-Encrypted: i=1; AJvYcCUN3wAEQG3vuU7dbllhHFu6JlmdboGhI41yA7+eRS4GSMU8IoHBIbAoN1y0kbDCAdRBOFYICMcZpD2VYdP31qLg@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIwkOo2m5YmHIU/5fL6axNyVVv9wPC+bV3tIdbF4yh3zgE1cK
	IRuteVBCfamiSEr8kHGDf/Xsj3R9CzY4yGZpSKRWuxJUaRueGtWKeWGPy17cDpPx5o3+2Khv9Ft
	d8L/zeg==
X-Google-Smtp-Source: AGHT+IHGqzJHFrQqDKAYKyAb+ZZ8g4MgI0TN9EkCiyaffrCYucpAYRDPWXdTPAEYsAA+ArrnD2gzwIO6IEIq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:c70b:0:b0:e48:3916:d902 with SMTP id
 3f1490d57ef6-e54ee1f9930mr14093276.6.1736409076261; Wed, 08 Jan 2025 23:51:16
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:50:57 -0800
Message-Id: <20250109075108.7651-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 00/11] Python improvements for a real use of parse_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While parse_events access in python was added, it wasn't used by any
python script. In enabling this for the tracepoint.py script a number
of latent bugs and necessary improvements were discovered.

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
2.47.1.613.gc27f4b7a9f-goog

