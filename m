Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED41AF0CD
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052711; cv=none; b=p/xuIoSCKkoiQaaugJbjgQmsFn4Z7d6GMmdQ46zINBXafpjsnFU6savHU33Mq2/tnMYRBYabelTbMIIvlJ8zFRFQROYrgMC8z6NPjyR1sEwY89R7CcKetacLDrySz3dijkLldV11pePg5V6M9L4+30pSh8sY6h+AOqIfnTTlL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052711; c=relaxed/simple;
	bh=atNphtq2muvnpNjRyq+CfSdLflI1yp8tf59eJGJ5FKY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Uymyg6oWp4kQNGZ5und1DCeT0riBHJ44VGD0fWixDCUljy1+kSJaAjW/OWCysM+o0PpX3zzuG8UoEAN7JbzorRuwVtw+Ww6q8IyLRFVSUaXBZjtUB0uhuoIAFVYAsL5Cupam13YcNRtGCrwT9x0lMm2+p/r6jM4+ZYrD6jCS2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfhSnokz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfhSnokz"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so9262320276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052709; x=1729657509; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9FBvcyPFVemeh0oNlvVwr42rd3aNqdBh2Zt6Y7kv3s=;
        b=GfhSnokzPlTdThNa+NEMJ5l9YQcMB62EJc1mOKCi01/q67Jr+JqHy3WH/UtmNwbh/m
         kku9tcPZ3NT6Fq+7shTyB1I2nMmIvhNaZcoHZql7aBec5Rlg2jQ4SfjKSXfrGXuGUzU8
         sNcc3vU8E+VLNg8nxmTH3fgT5a1oWNFcjkra2jdz7JNQKFWGaqLSTWZKdHPH3jYS17fY
         H6W9e0lvfiJFj/t6a63+uHYsQU6l56TVyaHL5ELo3KZDjr6w84r8bUiVw+M/iiXLerFD
         PdYNNrFLeNpf+XoDIO3FaPAi42jEC6B9HwGIkG2+RdfhdOErMQ4M/RiBfhOiu1yG5BKk
         ZKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052709; x=1729657509;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9FBvcyPFVemeh0oNlvVwr42rd3aNqdBh2Zt6Y7kv3s=;
        b=P3ZNH/ojYAE7UlcPoDPosAAmHbrAvphNiY4JZ3MLXcjVmPkg3bdY7y7OFf/wNYbdo1
         BGUITO1c7RdMFdw5UzHeIwqOZmnkvm0xjC6SrXcGtO6pa9184J/SF9qnXHrTWdV02pqR
         AjWIquseAsGTSCcPFazx4GSFlGmpg6uMswyPwBVOWCZ/CqwhF1DebqXj2rp4xLNHiDzC
         Sm85oLeLx9RC5NInk+RTL5p47bf+y34W1uge/Kd11vg9UNHqqsDBKG1Esz6gGtxX5Cts
         hmrA9Vaz33ckOOA6fF9qsE84QNWEWANtmuWhethMukRtjyRtInGAYinIHhThWkVS/ATm
         WXaA==
X-Forwarded-Encrypted: i=1; AJvYcCXj1XrTYk/rUUWAJU3yR5bH7c5FentXU36S8UZhi5IAM261WhuJ+OsCL/SdqCJmbrlOjJpqyxjSahLTFJ5ExD0L@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMdRo8SwN4/JFMO4lqLZVwwzCOtHBRZoqCahL/pLdOMix9xm5
	KVs0l4yOwQS6fQ2IVubYT0VpTwgoBNDflmduryHDyEO9fLW2tXl2RLhm/XXdBOVmxDcUvw/WZiR
	1jzDaJw==
X-Google-Smtp-Source: AGHT+IG0WlG2n418T7PMxezvNke9lFkjjek058CnnTXKNxeKbgILUTZrua9v/4XFvBZYiE3o8pXnS/9hYV2Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:d614:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e29785a421amr2168276.10.1729052709171; Tue, 15 Oct 2024 21:25:09
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:14 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 15/16] perf build: Remove test library from python shared object
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
index e54c6953cf02..957b25322786 100644
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
2.47.0.rc1.288.g06298d1525-goog

