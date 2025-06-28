Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36950125D6
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751073788; cv=none; b=iMtGTb1fd/Ul2d9wEPo8fEHnYZ2dk5iq6tLceFkE29m9hGHnjmBej28pOua+GwZBOAOQ/EIMVI6RAIQdP46rlldnx9fEHYqxvRpx43Ngn0CIAUEoPd/mZ99NjYmd3yK8zLQpn7ynEJpW9CXmpJSBtACssXEl5HNEIN6et5+99GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751073788; c=relaxed/simple;
	bh=je76FBVaj1rB2d3TV3oSpRxQI2J0akk3RWTS5bDyEbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=gwuVJeYva84r2H+SNJhB1SGOE4wNwX6lwW1MjE98PzWzAAZ5LCZuSgZn8CN2PXslQOHzr+jqMXySHqVtAYY8WXzESadtabHxfF0ocvE3hpWJEP/KAjjan5tJ/tUj5wbBqUCwvEJ6RZohSINyHt8q80wF343Bh4GQjfKbkpDUWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MX6W9vkG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MX6W9vkG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235dd77d11fso1192665ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751073786; x=1751678586; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJdhCyCuh5T0F4HLZedZyEKCTEq47ryiu3yriK9r3BU=;
        b=MX6W9vkG7uTtv2Al+ouuLhLLuCWTf0+PjkS7T79X2nSEKrRZLWVD1a8rW8xiR1Px8O
         iPdpTgc0jRR9MaGbn+NTxYRbtAB3dF75q/bF0o5HP0VyqCEn9ZVf2+i59TUXu94jlFyQ
         nVBXd8M62slyu5wHdk1KcIDS+HMQJ7wNeWEw/PjPzqsFAwfa46zJpXzPDhTvNYPJ468r
         m7Q1x41S54LeGGbfc4FDp6VszNdgtpQ92ktTeoff8FkfEGFMs4L6Kb2hRQY8IvY/EBcq
         PYgam0PK5nWom8jPcAa9evCJg3n1tyU3ADklG1dxC6dZDOqQ+1SnhlmlNtZCIgP/WPR7
         KwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751073786; x=1751678586;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJdhCyCuh5T0F4HLZedZyEKCTEq47ryiu3yriK9r3BU=;
        b=WGNHEqta2hAUl3bn0+1aA5FJA1MgqNWWMne4qDAnH23/MwucbrGMISN3zYz/K+KrLs
         hXr1SE6cCeK/YmFJtU+6e2X4KCSIp+5/Yev15tuFwKemzixKUvKMNiLwYnuLv9tChYMs
         WmkLRM0eN4WqTl2JLDOo93K6HyHk/HbXyt7fMtosnZTSdBuuPzj9W/fXa/s/IOoGJv1e
         cvEyLZ3tiJGId7hLiwD02tNfaK9Esn1ogvo1v9rR5toudL3qlIYQrn2NJGmuh2mRcHiW
         HN0EgUC67ukwsq2S1t6cnazdBNmznmh24BoZIAOn5fDm/monwuRvh9zWYvbQfRlkKYWt
         y+kw==
X-Forwarded-Encrypted: i=1; AJvYcCVPYTviKYdYTB7WtRISIAl8vZoetC7PCgRF3HZYgGAwt8pCuuN8SYKHeuontOfk/66xK9xlAjiQKmkzvrkE3+Id@vger.kernel.org
X-Gm-Message-State: AOJu0YypDbYGbiBfbWbCflyu0RqDsDX9dV46vODpQ+PixXaFywhTWNoL
	N9/6Mn3nbR++AH+4/F/yEMrnjyfTIytpMkDOQFglAtS+6ny6Gtkkz9kOEnCmzndfYsOnbeZ3uKm
	uuWVqCIa18Q==
X-Google-Smtp-Source: AGHT+IHOgbOqwBITWWwyDrtaLdWW5xgdFTxFtL3sTRBkCSKvRIZozfLeDng7N/MD3q93ZJw7ZHf6J9QZQL/6
X-Received: from plbmo12.prod.google.com ([2002:a17:903:a8c:b0:236:945a:3454])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a08:b0:234:d2fb:2d13
 with SMTP id d9443c01a7336-23ac3deae06mr64874015ad.18.1751073786652; Fri, 27
 Jun 2025 18:23:06 -0700 (PDT)
Date: Fri, 27 Jun 2025 18:23:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628012302.1242532-1-irogers@google.com>
Subject: [PATCH v3 1/2] perf test workload noploop: Name the noploop process
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Name the noploop process "perf-noploop" so that tests can easily check
for its existence.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Switch to using pthread_setname_np rather than prctl as glibc and
    musl having conflicting and mutually broken definitions of which
    header files to #include for prctl. Suggested by Namhyung Kim
    <namhyung@kernel.org>.
---
 tools/perf/tests/workloads/noploop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
index 940ea5910a84..656e472e6188 100644
--- a/tools/perf/tests/workloads/noploop.c
+++ b/tools/perf/tests/workloads/noploop.c
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <pthread.h>
 #include <stdlib.h>
 #include <signal.h>
 #include <unistd.h>
@@ -16,6 +17,7 @@ static int noploop(int argc, const char **argv)
 {
 	int sec = 1;
 
+	pthread_setname_np(pthread_self(), "perf-noploop");
 	if (argc > 0)
 		sec = atoi(argv[0]);
 
-- 
2.50.0.727.gbf7dc18ff4-goog

