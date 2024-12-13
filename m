Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3A1922DE
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123874; cv=none; b=pBXS84flX1SAgXriY68DDMlmR5D9P5+yFeFh4763mOtXwD6N2ioa8lr0T7665J6iMV/c5mlBghIJfylSZYQFwV2Ex1bwldeL0QGr40LTSPCCVG06XCnzEjbIPTFYsY5JKuo/HE+MmSUpIyat1YgpCo0P81whfs5AuDma/x0wLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123874; c=relaxed/simple;
	bh=ktN2a6Agsngw/a+xvIA2bOuppFEVJpLgXXt40yJ+gIw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=K35Bm1vvZ4JrF/fEXth+N3E7ZU1wTYCESVJLcoS+gZu5mf5hSHT2rWBgNoKDicc2qe3BNjPsQkYpHQO1u/E2saycoF8BDFnB1CMB3R+FjnNS36fn9PuoVkA6cax0kHbdCgqeJRNkhZDp4KNPwqCiaGqLkvRKiXZnSNoMoRoAjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zkrU6ylR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zkrU6ylR"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f27dd44f86so14491217b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 13:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123872; x=1734728672; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tU6TjW1pINueKv07ctCyQz1WMBPnAwz6m5Ynu7ivTdM=;
        b=zkrU6ylRXmSwxynkNeWKSy33cIuHvaRv30IcSnxHGwKlkzwJJvq1aGl287cO0LmIDq
         +5nD5c7mKKMfzuKUAbjPfACWkoPY4M9JiEQa9j62T0MsUAllO01+RMjhcJY8Ayg/X8+9
         98IRSMzHbs7Pkg9o0jr6X0ClEzjmL6pekczVQbPRXgIgc/PtXKUIUkR9KBo86mEh7cs0
         qeWqjNDYc3xf4BJQsLakT08j8HJ0Esqq8+y1nIhoeSjHJS0g7IKg4f9gV6PAqdsHkPTZ
         9ZhLe8gHPEKnT2Nn8kQr74w71vGM2P+xdl7t30fspblAaonOfQgeRAG74vYk7VE1XsEU
         CyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123872; x=1734728672;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tU6TjW1pINueKv07ctCyQz1WMBPnAwz6m5Ynu7ivTdM=;
        b=DHG95QEYK3z2HmXmR+JAhs2W+PS8GrgXXP+PEbtHyqkE+JwuCCW2nSn67yE0PWXFv7
         vbBI/LYyyj81NP3oJdxWflTMQxEhlbrS1uXPrrzQaM3DS1hnZnAhr6kBIMp3P9mGY24V
         FrLLwjgPSKcG4NkpIWGusmodSWYCXfaSmkpEgLZsfUCLK1eDyHEySw9FqoFVwVFePRLH
         5CkLyrhq/a5pWUa1SC6u7RgMqI2qpu/+N88yv6aTlHqKWfVZBu/SBXiv/ARnqjOXFuAK
         bY3zYXqibusnjXvzxxn9ixDywJwAfe4nzn/c8jou5wAVNDhjecHHFkTyQlrN0m9v5n46
         S8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXHVM7gXSMJo7OiQzF3dfVrF29M/rhqj7yEBLavMIEy8o2+CB9wXyvee7AcitjFR4nvVkZklXq8mQ5A4qrxI11w@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBXS9WSFiLw0DLl604wZksx7zCBNU+dtLLzKUeiwUwJwenHD1
	VwuUbDFtJ0+YecBUm7ZEjhoYnFjx3SOO52mezjb8x+Gqr6DLTBzGpzRVp6nPO+oNcC/c1IBW4JZ
	PM9uVAA==
X-Google-Smtp-Source: AGHT+IFkvmSk/8zglmDMq3J8SstOLsQKaXaNT3TY3/2pxe5wQCgKWjNVTmqP5xMQZVU2n3XHkgLGtFZCAfyU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a25:d6d1:0:b0:e3c:9f2c:7083 with SMTP id
 3f1490d57ef6-e4348d26e95mr4367276.1.1734123871815; Fri, 13 Dec 2024 13:04:31
 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:17 -0800
Message-Id: <20241213210425.526512-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 0/8] Various fixes around undefined behavior
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix various undefined behavior issues, improve tests to make them
easier to diagnose and add assertions so that problems don't recur.

Ian Rogers (8):
  perf disasm: Avoid undefined behavior in incrementing NULL
  perf test trace_btf_enum: Skip if permissions are insufficient
  tools headers: Update offsetof and container_of
  perf evsel: Avoid container_of on a NULL leader
  tools headers: Add non-NULL assert to container_of
  perf maps: Avoid UB passing NULL to bsearch
  perf test shell lock_contention: Extra debug diagnostics
  libperf event: Ensure tracing data is multiple of 8 sized

 tools/include/linux/kernel.h              | 16 ++++++++++------
 tools/lib/perf/include/perf/event.h       |  1 +
 tools/perf/tests/shell/lock_contention.sh |  9 +++++++--
 tools/perf/tests/shell/trace_btf_enum.sh  | 11 +++++++++++
 tools/perf/util/disasm.c                  |  7 +++++--
 tools/perf/util/evsel.c                   |  2 ++
 tools/perf/util/maps.c                    |  9 ++++++---
 7 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

