Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969522EF5
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Jun 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861677; cv=none; b=dkaNurgtzmQmndtBU+S2gU6zWvOWN+iYHkf2eyREEj3HDzTN92pk58jsZB0Nov0rOV7s/jZKUNkHMvZmxLufr28J1Dg3DtpA+fWLdXyicoYEKul9FZ5D08a9GWo6p/ez2QBYm3O/WPLNeEFb4OEWqj3g7ns4EZUPKb80cMx0Izw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861677; c=relaxed/simple;
	bh=oN3BYIv1X3S/u1Mo6YTEtbt/BDcHUYpHqNKZWnMpRxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KA+expHy/eEQm1XEmaFNoEkJZyzWvdh+vQ0MNUslofnPW6KKfT4AgYffEX75ZzHWxsrorq13wHXTOJrlgliNLciU0hPf017OiKSvfWc9AOVkR2NPv+/AiiuTK90cMZA24jnTPxBK2h5l9AUOO5Sn2RYME4n7F00SNQTi6nYzziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXEmh/pC; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXEmh/pC"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2ea89e10eeaso2042317fac.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 17:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749861675; x=1750466475; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIS7VuzJ57xapf7f7yFC0ISYZ4tym+nwEbWhw3lcqKw=;
        b=KXEmh/pCQqgR/9gPg0ngePiFcpFoIl3JR05EbK5z5ZRz3J42BeIVtAUpVCbpqzbAcZ
         Ok4SZNAJOKm3qE4foDoGbTOLaoPLQg8oXXZlJ31+eM01n9hhDxf7ePps0awtHCmiVZBI
         mzOIzMyqDU5SN60XEYnHQPlqfvwnRWDiRgJEIe1/8prl4GIJ+T9TivV2rGictddXffPI
         MMV/UeFnDVVnmJulTV+vV7JSe47AV0zwq4GgdLikx6raArs9yh9Jw2OTe5ypHwFB3T1D
         fCs56lPKdsMEsqKWHmad3i8Cef6ZBgewCUt/JWuwK/k8FOURJOxppQYU+HKogqMr771S
         5FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749861675; x=1750466475;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIS7VuzJ57xapf7f7yFC0ISYZ4tym+nwEbWhw3lcqKw=;
        b=I6YPPKSMZZD9pWKmuvNCVxNY6xl16iDB5vdrMfUlOpK1gqTXRd3dWR/FdgoB2rXhKX
         AjRsGS7cukWOI77JNSHd67bslDSdVZI1bryRS1s5j9yssvoEgO9u5N/IciFT1wRTAVLU
         BsCXjW30uhEC3YMNAhp8ZYRKpujbiDDeZctXIAMAp7hqdQWklEgwpVzkNnklga/jfZr+
         x9rLMH41pvB4yB/dN/OSyw4f6AsiGYWqATHtW20NIDnNTmWjMS7h5aqVWSacD5tnOmeC
         IUwMsTi4Mbh67TDBlA//tCla719aEhWXM+jhTsnUMsrw4/CLXhyJk+kp+B725XOkb+Je
         DB6w==
X-Forwarded-Encrypted: i=1; AJvYcCXvRtmrjn7K//A3ErVMXs1kmNHPyNa8Lz/AJ+NIdrPdy5n97BKupwt3IinpsUAFbAcquHkWOZIBkYElGa6Y1SjT@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlFOoZjo2kvh7j/x9eAd+R43+POlnHVOryJR3HvvAxD8csCmK
	b4eCO2vqSxYTIQSsOIWjC8GH3gIqLyDnAWm83k3euwa2lHThGRSHp/+QioDxjgbIXvqVgZwlRHm
	2fqhwwNEUCQ==
X-Google-Smtp-Source: AGHT+IEkR+VxlvZKAv3aQOYK6PDsZQNMN4JyVSg8Cy2Rg3MCcgHrM2sojs7CgZIizz2tDc+Jew6e07LhSzCb
X-Received: from oabgh10.prod.google.com ([2002:a05:6870:3b0a:b0:2c1:6d20:7b92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:d1c5:b0:2d4:e101:13f1
 with SMTP id 586e51a60fabf-2eaf0a147b1mr1068527fac.13.1749861675136; Fri, 13
 Jun 2025 17:41:15 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:41:06 -0700
In-Reply-To: <20250614004108.1650988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614004108.1650988-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614004108.1650988-3-irogers@google.com>
Subject: [PATCH v1 3/4] perf trace: Add missed freeing of ordered events and thread
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Andi Kleen <ak@linux.intel.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Caught by leak sanitizer running "perf trace BTF general tests".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bf9b5d0630d3..39b6a13ca862 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5359,6 +5359,7 @@ static int trace__config(const char *var, const char *value, void *arg)
 
 static void trace__exit(struct trace *trace)
 {
+	thread__zput(trace->current);
 	strlist__delete(trace->ev_qualifier);
 	zfree(&trace->ev_qualifier_ids.entries);
 	if (trace->syscalls.table) {
@@ -5369,6 +5370,7 @@ static void trace__exit(struct trace *trace)
 	zfree(&trace->perfconfig_events);
 	evlist__delete(trace->evlist);
 	trace->evlist = NULL;
+	ordered_events__free(&trace->oe.data);
 #ifdef HAVE_LIBBPF_SUPPORT
 	btf__free(trace->btf);
 	trace->btf = NULL;
-- 
2.50.0.rc1.591.g9c95f17f64-goog

