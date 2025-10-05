Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716912BE053
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699360; cv=none; b=nwRx34avBK3GsotizMGvstCe67sXcDfrToJfxWxZZ+MN1fsPJL4MNW0vhkZ++ehVeBd2vp/JE8wX2Aepc3G3YO/6n33mvKqqyFEI9mOSoWtFV1fLUKpP6YyZisn2f/xkATxK52tNiGiGLJX1+dOBupgG83TLrHviXKJMkN5Krk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699360; c=relaxed/simple;
	bh=d45wEUY1c4jrn84/iwX20DQE8nKTJ3WT+ZgvlVq/fR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i94OOCFkOfAcSS4VBl4vQ3YrT6IxY+Z4b2hgvl4Yn5QpUPx/+q5D6Vcp53sXuUUeW4clZSLTn4YD9MZJnkVuQ4hiVhK5GIT01xE7YDwsZz8db8B1zgbIz8hw2deHbCihML57E1LdVK6cKe9MxudLFtkStVYRuC9S83TcUtmS8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNUpK6jh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNUpK6jh"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7900f597d08so335921b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699358; x=1760304158; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UwuX+qcsVkIci0z0OtUlxAA0Fd588bD/7/Leb924no=;
        b=iNUpK6jhPiS5f/hKDyyWnevN+OHiX3QhhcYyX+IlJdkzeQ66LZzEt6M9X0NYe0WshC
         1gS6cd6/5KuHzgs0hW3p7qCSZvV8krOdyGJ0QVlYzJaaNMkEepNQOdw2AdCpALrGc//I
         RYKINoeHj7LsI4WF8RPr8WcpSG5q/nUC3zzFGUGQp/FCM6T4z0ob9ZjrkX1p6yPKzceh
         4Y3/NBeioidySuI6sX5jNXJwgCg/XYfmWm9IU8twlYnyHwSIYSJ3QDahNyOnoBfZy4u6
         f+GR8GTQvvd0ptxbF6t8nxFI7lxwXne2dloWt28sXkwOK4vyHZu7SgHpDKNFl8RPKu7M
         N1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699358; x=1760304158;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UwuX+qcsVkIci0z0OtUlxAA0Fd588bD/7/Leb924no=;
        b=joZGbs/toOiJLFjp4kG8uCgs/sk2986FeTc3SscO/Z7fLkCR5ZQzi0Czh8jtKL+O8/
         GcjG1EQCTuyvHA269270csmQJ88UXbS/OjCrSM208j3BgoZNBCZRb6p8JR6S9oQyk9fa
         2CdaSqDFC/tMk5RzZQgiEBd1l/j3B3+G4WnTzwvcRW103j0gfAoLnuaGGoQq2cyquYcz
         L48VKD1YnwNBt2jg/KNhKmDgN9rAYDiwa25perliufiKaN2qhFF41aoMeoBl40+5kLcZ
         Qq1qZmSdqRDj0YrKZ8OlCT2RNtqpo8oA5qABvyDhbnYqDeSfrd9yLwKxtj6PmgM5PQxn
         NJhw==
X-Forwarded-Encrypted: i=1; AJvYcCVFe/EK/+JpZ/WqdeLT4kis1eUXclD6dYhCnggstpOui1U3lXj2gozw+tyhXkgHmKCENBWVQSVvuWYjkT48+C4I@vger.kernel.org
X-Gm-Message-State: AOJu0YwA5RvWYYj7AwX1pB6b+cGkCB109YoQQvPk3/yyEoQMzxn1krRY
	U/el3M39mrG8fHrxJuhIgVXt0IrmS8Kwi1Mf0KOFGjZ9DOu2udmLQ2h/dGQG/YCznp9CKk44AF8
	tBj9dPgeZxg==
X-Google-Smtp-Source: AGHT+IGvT5pslbMCXLmkI8dz33jGeGYCBPk++vUXwX3QDvVBJVh6+9SImEKQrDsiOMs+ve1hP/rqlLC1JAam
X-Received: from pgac17.prod.google.com ([2002:a05:6a02:2951:b0:b58:7d6e:e9c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d527:b0:32b:70a1:7c84
 with SMTP id adf61e73a8af0-32b70a17d56mr10844469637.28.1759699357519; Sun, 05
 Oct 2025 14:22:37 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:09 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-9-irogers@google.com>
Subject: [PATCH v7 08/11] perf disasm: Remove unused evsel from annotate_args
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Set in symbol__annotate but never used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 -
 tools/perf/util/disasm.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c9b220d9f924..a2e34f149a07 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1015,7 +1015,6 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
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
2.51.0.618.g983fd99d29-goog

