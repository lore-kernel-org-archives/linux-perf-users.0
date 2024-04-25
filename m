Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FEC175A5
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084457; cv=none; b=KG32CmvUWb2URWQu+Q3rLayK5f/UvjED6dHKwWQphsGLl+jzJ4+YLxvVVLwoTJ4PI9I83q8aptOjdc/2vcNHbB1ZbPi6miwx1yD/UNkGZCYZZdgFiLx/ClUwfrdU+7jNEsuxX/PLW+zlqhhpKUnVtriGPxqbBapSTKxs/GoFhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084457; c=relaxed/simple;
	bh=u3et4SImCb3YPPJX9fDXXvlB2s1vG4/taao+OPDBknE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=me5TL55NFmE9zyn1VNwtb62MabXB9KSyPvk9acNMCfapC0nXiCG7Fi5LVH2rzxPOZp6YENeEoLBFWFa5rb049tkNipXpUszFUDICgfRe4Np/zzs3t9Wr1KXZsRz7cYWxPhy/KCaQcy42J5Yskw1ffyzOlpCjSr/vez/PvXqEEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qoa4adkT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qoa4adkT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150e36ca0dso27908027b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714084455; x=1714689255; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJJk73p5r9jx3t8Jke0lmFYDY3+/7qA+0Gxv92CMnvA=;
        b=Qoa4adkTKdEGzt79TRvuIifoI5taET5PjO5tgtqQ8tkUkEie9XIfBP2py+LNPRvw1A
         LhlITKWD84084uOyYlXsw9kBtCxTfDQNtlRKoHv/wmMI8w7wIM2CoTYzwN10m44BArew
         zqCsoJbunhCI+QeRWUb61tYy6Xcf74QqaRCF/fQ7s73zsMVIhyqzSOjPNl5pDNs8ygKR
         slFhYTzdu53j16WOn0BVIkzvNt1oSmEMOzcePNP0Le5Va49Y1jJCCH++pisy5G6nFjSA
         H+NVN9TpO/e2XU8pZxggmgKpqDcwN9KBIx8Gw3d3MYJjcdFlrDKh7mETLX5+nw+9Lwlx
         DWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084455; x=1714689255;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJJk73p5r9jx3t8Jke0lmFYDY3+/7qA+0Gxv92CMnvA=;
        b=hXTQ2jwjI46dGnY2SOHXUdRpi95Rf3Vf6DdZEFo+HvKx/LCzn7AGmfQo5hBaMKbWjL
         loikG+Ma5oRCg7a1GyqZFBX52SEYSyFNnHBDqB5N84Rjelhzg2pGJ9RbkW+7NzowM5Qm
         Tb/dV7nYpfGMFPWxiFjlfskce+zOqpoY/WI0YtH9iM1r3M09l6f277LQSDM2PtfYa7S6
         5qw23peoxwMEyI58suk1H+KTzaKDWrmpiloHotnKGa6Jm5McBVNv7KAA+aHnA+80HkFR
         UKS1F7v9wIYD1Cv7M9DEHKDoV1GJ5zYqMzXTFq/Kor88+C9Pa0SJp0J0zHDVJUaO7x2G
         7nAA==
X-Forwarded-Encrypted: i=1; AJvYcCXwjSMCMcHxJK7w76oU/LA+obVj46pd1GTp0bAO9wqJXtyrzUgKnrz4uaYrhtyNTNNe1MzZRmNp/Y/Hcx+qPgKg8WuwFHwN7TraFwO6+M7Oew==
X-Gm-Message-State: AOJu0YxHLGxg4FX+rF+8Akg/IhHuKQgXtl2AEug/uN6M2KLHEXntoitb
	L+7i/uB9C/4WtjAmbgzHH0KK2ZW31NnGFsKS4/BEz5PgNzRkEzvIllxTLSn+jzR7u1eQ4pC4ZdE
	w7jmuxQ==
X-Google-Smtp-Source: AGHT+IESkc4K7XHM6bNS+4yg1KNJp7FaXL9c5WJvsUk5NRy2l3NzTgt7ORt5BdiPwvkajo96EI9OSQB3G0pD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8708:517d:aade:8c87])
 (user=irogers job=sendgmr) by 2002:a05:6902:1028:b0:de5:3003:4b64 with SMTP
 id x8-20020a056902102800b00de530034b64mr120115ybt.1.1714084454877; Thu, 25
 Apr 2024 15:34:14 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:34:03 -0700
Message-Id: <20240425223406.471120-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v1 0/3] Retirement latency perf stat support
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

The first patch stops opening a dummy event for tool events. I came
across this while looking into the issue and we can likely just pick
it first. I kept it in the series for cleanliness sake.

The code has benefitted greatly from Weilin's work and Namhyung's
great review input.

Ian Rogers (3):
  perf evsel: Don't open tool events
  perf parse-events: Add a retirement latency modifier
  perf evsel: Add retirement latency event support

 tools/perf/util/evsel.c        | 186 ++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h        |   4 +
 tools/perf/util/parse-events.c |   2 +
 tools/perf/util/parse-events.h |   1 +
 tools/perf/util/parse-events.l |   3 +-
 5 files changed, 192 insertions(+), 4 deletions(-)

-- 
2.44.0.769.g3c40516874-goog

