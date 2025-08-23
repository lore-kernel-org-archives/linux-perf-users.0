Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31402264C9
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Aug 2025 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909193; cv=none; b=UumaAU8k3mAiClPfAxoN4Lh/i10dVFwhTBykj5JBHSeGiTSvAfuL822LpbLf5/TG65voea6jniWrs8WuELOTfOITfDRGNzScJ8JfrCrSXfCNWD/YyHXSekNC+QC8jSe/06GCXhLXJf4oOJ2Dl9td13NjMkAa64kevynrtWHjcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909193; c=relaxed/simple;
	bh=reMtgj7bhiRhPENa3OkjdqODITaMaOHCqMyeNuoIDv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=q3Zw6X/syKOfRA5XqsPNExuRFxxnV9BBu7UoWeJyySLoVKhyzMO/9/BnngsXXZaAsW2GBXzDs5J0AkSbyMgoFjcbtmZAYfwjjUVvTRbyulEtdWlOxi4PLLhF6AxN79s3XT0Y/l+QNbsB6f9u4ves57qrmjTfen9DQj32FSc/La4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMDrhxP7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMDrhxP7"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174c65b0so4771947a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909190; x=1756513990; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doZ9j7K6Q/ofgZz5QhoA4/GKu8/BR4eF9OnVOTmqiJI=;
        b=oMDrhxP7fqBgYnmXbEBEmya/0+59IKd6aMIs6SALRriwebWPhv6dY4LviCWZUHiskV
         zPzuFrM9fq7dioEZz+gcwhT4ItSf2k9MF7LM0aa2jZqILDA7gALYkaEaeRduUt2+yb3R
         EDze4ZRAjJGiF7uSLiF/pSmjpe2lbhoVFtZhLx5BSK6szfSRUJQKoZYeYsW5I7k6Twoc
         4FLnU1N2yviQHwFphirKo3YW2X8mhgPZZzn+tr8F21XmYSh4k6oJ5zEKxZvfJa6gJlIh
         37T2JZCC50WTjqCbOR5sY5akjZSNvDh2V26RfdprBmh0cEHCh3CEu7HjkAz64v1FLK5+
         DJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909190; x=1756513990;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doZ9j7K6Q/ofgZz5QhoA4/GKu8/BR4eF9OnVOTmqiJI=;
        b=L2vnPSemgC7+m8jCLb6lRo69hTyBV0673gpL7dtIT19hw6upv+0gh7Yzs9hbHM0aKa
         U5Y3KTqtIccEqzkAR6OX30nwA+vZH9loqCjReLfWAIo8s5qIIOIP0VzeSIvxHnqgdvCa
         2vPEHzE13PO1Hxn56UZ2VLW1ujSGFvu77ju3RzJh5ZVsEpPRU+YfWV3TlONzyRyfzMi/
         rH0kPLpPDX+HVF/oH8eQ99Mqlbc53wB7Lv2S5UTurgoKv03ZrEPcdL+zTrAjYvHi8wWg
         eOcBliLOen8OEBkB3AW12ZmzG8IBh1hCmcJakFc1NmCfXHih0UitwdGG6QAChagIRuYy
         3/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWdFvZP+cj44x4/j9JZ+FmSRaGWVndUA4ceGUa211zihXrwMfkAxDvcpFlNPbkHQ90zuI4ruZWFdKpCX5zrPza@vger.kernel.org
X-Gm-Message-State: AOJu0Yxump/zDm333NrFHZzto/bEAj1EyEp4u3MkAXpan+vq2AAUeFcG
	jgpxZkRP0gpWYUI4Xqr72vcWxS+UVNhKh3lrxhmnfLps4z/9T8iQ2eppaBh+qQLfTy/n1hxDnbI
	7ntzDWXAbmQ==
X-Google-Smtp-Source: AGHT+IGBzXcz7uUMdP+OXRWsOAJbtWHQsETrwAIkMwAxbb0yxrGNNH1fXbELcmiKGSKA7OceGBgYbjqXkS1w
X-Received: from pjbtd5.prod.google.com ([2002:a17:90b:5445:b0:31f:210e:e35d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939f:b0:240:c3d:2449
 with SMTP id adf61e73a8af0-24340d1c795mr7060450637.42.1755909190133; Fri, 22
 Aug 2025 17:33:10 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:15 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-20-irogers@google.com>
Subject: [PATCH v5 19/19] perf disasm: Remove unused evsel from annotate_args
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Set in symbol__annotate but never used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 -
 tools/perf/util/disasm.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0dd475a744b6..9548c5688fa8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1013,7 +1013,6 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
-		.evsel		= evsel,
 		.options	= &annotate_opts,
 	};
 	struct arch *arch = NULL;
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 09c86f540f7f..d2cb555e4a3b 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -98,7 +98,6 @@ struct ins_ops {
 struct annotate_args {
 	struct arch		  *arch;
 	struct map_symbol	  ms;
-	struct evsel		  *evsel;
 	struct annotation_options *options;
 	s64			  offset;
 	char			  *line;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

