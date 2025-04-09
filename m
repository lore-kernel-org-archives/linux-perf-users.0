Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E61DF75C
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179084; cv=none; b=izxHnfIiEncObjh46yZkWY6qVmOMNz1kISZWW8NF9650wrNpAdIDgexi7eNmFUiaUNJhAvwDvSJlkxRnaBqmfjzCkF9fyEk6NFZ1koDc2Lmb9rXC6vECx4S31oTX+OsM5KrnlEa01pIr8n5FBiXEEK1l1y4JzGJ0w0x5u0TrQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179084; c=relaxed/simple;
	bh=4/dJlTWkcf5FOf5+oh0Up7fh8r5QO82sMonPjvpz42s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=b3echBuGrJOXNF1rz29wgF7+eCAWNBKuswGlCSPnb5WWhsR338vE6+GuSVtqh0gn04EyLjh9HVOo3lityaGXvvBTYEHZsRR2rXQRsrQBJSfR+j3DVmZQ99922ZuI6OA4qSKl1obb+b8S9XSbz2L0k17mGTrp1NfKzPW0HB6+wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9HfJtMr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9HfJtMr"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22aa75e6653so25009115ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179083; x=1744783883; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtCRHQR2grinPcYBxNOrxZNvf1a5RF1zR0pJL1Q63Gw=;
        b=q9HfJtMrwhKKv9ml7ofKLvmRyApi2OlKDB9l2zT28ORtwuQIAQOjzQCg1F9jUCIEFb
         nc0Hw7QxmPZR0igWkfv1FpIkuuEx9DS4Wi6tpC4U+bJZ8UrO3yYkQbbPQOP6ItQKR+Ef
         VHFYSs2b7QMY0X8QShA9coggzbIfm8GuQvz+Du7nNq3ZpCHfAYnIxjXOZ/EW8AGU60zR
         WQZxteMH8CVk7vxDShjst1DImjVNwIOKGJl0cKdQRNkgROEPX2poi6LYXcrTztP2C3li
         7Hw96XgFteT55uR+i7OyWyIAK3LmK6uQ+I+xOpdpC2RfqjPMcID0vQb3J0y8UtBmUyZ2
         ybFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179083; x=1744783883;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtCRHQR2grinPcYBxNOrxZNvf1a5RF1zR0pJL1Q63Gw=;
        b=pYjl/kFJGkVeiKQilf0kPMVnv9tP5HxAZzURQAyx5fkmz6UUeg5I6zflVI+8LFESp3
         zxNWLeqJ+pphyikyryVMIfOxSUaXBXYkxyKelzNFsyElghJQq+Hxlugfd5wNgDkewBPZ
         3ydJTTbQpp0hOziLuaOT2TB5FEyroann5wU4TTCIOX0+hN3Xk+523ibj/DHegSJJsg7k
         5IOrz1YhwZtsx44Fr4PlSOudO0hmZbJDB+8e9uUh38tV9LX6n4eXjrBnOD2SpM/pCzrp
         gbHzCnGv0Kq/5YYzuehvxeFdOJPLvthfEN/oiLbKqqMyhcLa1ZtxNoVsoQI7npVzpMi3
         9QTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUsS3Qz6NwwiNNa8Fi9lIHBqd25hUvgw60IdMOlTtG2/AmfqNtYRRuNvTgc6tOWbO1nNxwLmHyJBrV4vk9thTZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDxtilXlmPNTI4jt1FoOWGZaLt5ZBmvlGLsZktx/4vqbYoku/
	xKQrJKXrf3a+IAoW2XEoubWL/K9QYtJaN9PMS2HCLWH9tUugm5t73mDXINqndOsaVvTfbwpsL4M
	Z6nne3w==
X-Google-Smtp-Source: AGHT+IHYk+LFNBBiynPtVNovcETcZCxDxx0BUOk/LDRrrAx60CkktUGsfjUsusDYp1BB/HyawJ4Su1hVXzId
X-Received: from plhn7.prod.google.com ([2002:a17:903:1107:b0:223:690d:fd84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c1:b0:224:1ec0:8a16
 with SMTP id d9443c01a7336-22ac29938f3mr25480675ad.21.1744179082762; Tue, 08
 Apr 2025 23:11:22 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:43 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-17-irogers@google.com>
Subject: [PATCH v4 16/16] perf record: Retirement latency cleanup in evsel__config
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf record will fail with retirement latency events as the open
doesn't do a perf_event_open system call. Use evsel__config to set up
such events for recording by removing the flag and enabling sample
weights - the sample weights containing the retirement latency.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 661a07cbdb25..6a84893e3c58 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1440,9 +1440,10 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->branch_sample_type = opts->branch_stack;
 	}
 
-	if (opts->sample_weight)
+	if (opts->sample_weight || evsel->retire_lat) {
 		arch_evsel__set_sample_weight(evsel);
-
+		evsel->retire_lat = false;
+	}
 	attr->task     = track;
 	attr->mmap     = track;
 	attr->mmap2    = track && !perf_missing_features.mmap2;
-- 
2.49.0.504.g3bcea36a83-goog

