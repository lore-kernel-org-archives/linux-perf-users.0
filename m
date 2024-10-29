Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB620E337
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241914; cv=none; b=Q3ays0SHCC6GZrqxtHaZeJukYg0P9xOPHpyXYAHljeNcVSyDarJuXKQncYbxx/1HMazzJoj3x42C6o3tuGSrTIu6ZjFFH9XO5hHvDXv+apEGg6jyznxdjwLWOr+9PHzzqFvI8JKbPsFEDqsHDQuQQBH4P9LhnR7wJ2wrLkF4tRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241914; c=relaxed/simple;
	bh=iNS6gSj7D1lsvc1g5KMcNyPf5WgHbLQ5ta+6ZtnweO0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=j/5f2dl7m6pWHkwJ/bp4KzYLIlrA/QZX3KyolqSJsa30Q8zDdBnXMBdg6xtjKMY6IBI1/srJFfPjG3kU4D/Vrv7Pusw1WHS/Mh5kINMSMdeKcsEtVmHo30S9k6REmes1g0sW9/BlH8OgjbuufjtGgwqeABQWxoJO0FD2LIq+RJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBaggpb1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBaggpb1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so4671237b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241912; x=1730846712; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1shwZLFPVJttCYQn91hD7eEDXA/86MDDB/52gfDhUo=;
        b=PBaggpb1CbQkG95scbZ7LNvGfd4HtiUSGm6Ssqi+74tRSniFcQvTmYk7zKo+aT89JR
         6VTd9qY2Gll85k2lyrv0Yb2BYABCX7Lb6VuDsHVmHYCGz4bRekpntE7HJt5738lugyED
         LadxmgI6+qhm26FYV7RFQpvED8fYGC9jZtEbQLJIkedB4ZNmrPmDz7YS3avo4LyWDju8
         DYs8/rcNAW5eRtNLN96YMmWkpg7PECHdn/lno8KGFWkt8vadgHsaD3eXQYmRYQc7lAnt
         UVgkpbjtD4zkuHDcpiYq016idostTRE/uGug0Ca40wf2AcBXmfbDjzBba7C++QCmdFDJ
         pBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241912; x=1730846712;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1shwZLFPVJttCYQn91hD7eEDXA/86MDDB/52gfDhUo=;
        b=qVbQH3DD14yVbmxsF32K2Marw/0dsqg7fQEalebzsjM9y2OsjW5RKMK+ATroeV2pTS
         PlVCIyjBjbJwzi5KYCoSvXCowBp4j5qwovcKCZcwALN/khTyQL0UjjSXdr4ZqzWH0eO9
         Yj4dq+RYhDwzB/5r3vJS8D1fLoTpimfNM2R6liqy9eYzU86jNFNPgUHVL8G8+ysKUfnH
         YyzI51VPJalVSYZDDvR6K6KXEXwIKBTK5XYoJbgO26PcgmF4V5VvvZCFzh7v+mFvbNxn
         PuJFogzPRDJ/s0suugYohT/pZ2mwrUhKkdHdhArrhVNgYfVnfVf0PjsqFsxs4OfgafPI
         z8/w==
X-Forwarded-Encrypted: i=1; AJvYcCXry1fwrqUVAgCSvlen9hhywDnIBN1FupvP5NI+/NABt+l/DYb9eavP5fCkGnxyKVLewcAxhp8eYIWlgz9uNn5I@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7T4b7MwsTS3inTFTijv/7GwZgPsZIiX/EPsErIbCksLz5K62
	Pru+yqu5BqgqxUR3viakBmFWuEJejWuq98uSY/6GarFaDI4kjvV0MOKZGoa/KW5kvCBNpIrujqu
	80usWNw==
X-Google-Smtp-Source: AGHT+IEwTaJlXSQRR4sx+ZQnzVzk15DS6veFG4A3cQyhb+cmNvvvPfy1YzJ3tWyEoBvgx2hnMXYELCvii+HH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:3582:b0:6d9:d865:46c7 with SMTP
 id 00721157ae682-6ea3e721cdemr176997b3.2.1730241912105; Tue, 29 Oct 2024
 15:45:12 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:27 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 15/19] perf build: Remove test library from python shared object
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the attr.c code moved to a shell test, there is no need to link
the test code into the python dso to avoid a missing reference to
test_attr__open. Drop the test code from the python library.

With the bench and test code removed from the python library on my x86
debian derived laptop the python library is reduced in size by 508,712
bytes or nearly 5%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ef1b39b5042d..2059f1c4b78d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,7 +487,7 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
 LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
-- 
2.47.0.163.g1226f6d8fa-goog

