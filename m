Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270E16A930
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158168; cv=none; b=cixdjTj8x/VxPfK//jAHZDu0C4RqwZhrpgiKgub2M16KNw23YvEe65L29EFwqruYSJHRnGVKu32O/CszJ2i4oZTM3paaGK9XqiecK50J2fdm/QaQl3+3QW5hgrGn/b8JPLzwAHfUBXjdzQqOFcvv5oE5KcoTWdVDQ//d4cMno60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158168; c=relaxed/simple;
	bh=7T62nVUnz2I2Gia0eUGZ0foLAAktxEd4nUH/IRsxY3g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H3hHwQEOz4yFIQ0UUUo0x9vXyoS/zVqPHLvQoGndlQsoOmB50fm0tt4be8MHf8ZBDcTeE0jZ0uNuH+uGbWk3E6zHJ5IQWst3eo3SiSeVSdyYO+0bWBQIB9ByFXQ94v6ZBnlktuuxJWVEOKARpDBEZjCJjL7W1EdUkyNDtc14RE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4Qiv7ef; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4Qiv7ef"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e0082c1dd0so71672437b3.3
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158165; x=1728762965; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kkv8bNfBm9/dMXp08m7d8I1ujeupVoM1qxtGNFcSU78=;
        b=W4Qiv7efgEzDsL33w+nE3HaqipEbVLcG4WzhVoPj0p2ahQcifKeKhEhiXLKzK+HYSt
         w4O23pcdudTEowpSHk5O2Zj7ripu0ZM9dEVA8cAybT894YjrrzF0xAxgwNs14CmjM1Ld
         N3fH72KPs93hW6xzf9AjQ+ncxIwjlX9EBZ46dOsGU4HuxQ7RgQScXTf6TGG44P/jZ0FD
         EtHZqv8MDC9f91hsSW0WcxYV359eQotFZxLx5DB0PYB1vOjql5jb//Kbn46GNxYmMCi6
         H+Lp2g5ejVQg5qQCKDzKu4L+O53nast+sPyIsrx9Syzpp4fXz8b+JL1uD9efNnjenuc+
         SuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158165; x=1728762965;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kkv8bNfBm9/dMXp08m7d8I1ujeupVoM1qxtGNFcSU78=;
        b=nvzCvW0/3YCoxDlCt+3fzGSu4D5flheFNC4pdvlHGLoHcdX61C5n7ifwuWDUUjTnZ5
         ZDA1tP4yNNtkYydPe6A+leONngqAj9UhSk1cjGV0PcwbacU9dHZhlNUoOS/njX72IVUx
         83N6FpqbR7zGECXtdR0/Z30H8/9wnMYVUbdekKDbXB2RLA4fyJ+b4SwErlnTFBuy+hCw
         b6/ECYditS89EXmsa3SoYv4VJPxZz/d9TTJ9ZnXEFQ97bG8fdmaKhOaMiCk93fVkFpwm
         myTYfHAhT+RJTPRVP0hAQWsnK11kUhsZmQsQJj6E59qsEnGborR9MBWZzzzZCcg7A9R3
         pP9A==
X-Forwarded-Encrypted: i=1; AJvYcCUMyQimaUMc3WSc56uDocur3P1rczeF50JF8oywGP5gZSBVv7bhTaw60zUd1W+Q71EFPJLEHjylZLtJvlQOTExk@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhBT068nxBFC/ug0DrUZi6iuXknVgVnbqiwLBd5g6qIHBgz+r
	+uarU5bLrQhGWOxPxgQ7zNeqmXHkZdBEC5LDd4AyW8lAeH6aeY32sCd3cfM7pD301A3Plbhpwag
	cKInJ4g==
X-Google-Smtp-Source: AGHT+IHhkYnBtrBd+SOkXzP7+HOoF5g3/WxbcOIpY5cilwtjjCAK86WSpPWlw1sMJUnsYpXgeVLoazZjXm6V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:7446:0:b0:e16:6771:a299 with SMTP id
 3f1490d57ef6-e289394dd4dmr4215276.11.1728158164909; Sat, 05 Oct 2024 12:56:04
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:13 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 03/31] perf build: Remove defined but never used variable
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Previously NO_DWARF_UNWIND was part of conditional compilation but it
is now unused so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 55a39211496d..182e14e39cd5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -753,8 +753,6 @@ endif
 ifeq ($(dwarf-post-unwind),1)
   CFLAGS += -DHAVE_DWARF_UNWIND_SUPPORT
   $(call detected,CONFIG_DWARF_UNWIND)
-else
-  NO_DWARF_UNWIND := 1
 endif
 
 ifndef NO_LOCAL_LIBUNWIND
-- 
2.47.0.rc0.187.ge670bccf7e-goog

