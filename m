Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD72EDC
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952377; cv=none; b=f7/xRd5sEqD0YwE4rGW+7jS4/R1QkPOnloloFqMigfCdPE+TgKmZ5AHw9FtCC0cnmzO53AwhZVzbEBz7yxtYGRPpp4G2QeHKLAVE2pr0tGufWl/GuW+8OZvP8FhsgZdcGvgmld2rnzLPkuN2OgMC/O/NT8qOkcMYkVBuNq5a/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952377; c=relaxed/simple;
	bh=RPvZL/F/5+LZWPkRsGvRCYGU0F/BRfHT875AjHjPcQk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=j9UPn61aPy7HY3WKapEjIvZohlRoarziw78l3AC1tDYnXi3FDnMp2AhA/VavBdto87n/q4hED+0USzu2gJzSOwHSqzGNLe1Matvm1tjXVcPrLvb6zf1p0pd1508gVbYdPSeHvGuaSRe5o/Ad6gTK9C6qpTrTE6SepuhVe8uSMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpTm3xKu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpTm3xKu"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so10815245276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710952374; x=1711557174; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPh3+JK8STaNVcaoNnrH04Bjmq+JVNkjWGAVdUYYJeY=;
        b=GpTm3xKuy410sMKsXDSQGUFIj+rNkFZsErRGI/47uYdGayXTv4rxHDu49yW38OC3pQ
         wmuH5ojL/XEeFlSFhmP9k0unaNCsYYJ/hVXrgintVjT2TmS/halhKarxvlBZbsNGRNqR
         1Tm29B+cGE2yJNXyX1+KAvpFHc30NeLnL/gedZmzQpHjsN/33jReS8WzGXQBxMDqXC6h
         PMQvMHfWbvjyhUFOMuaNes3j4uHoT107GN1gncHvTvRHjNfA6+2x95UBuAfjOxCDz3IK
         f5DMjQGA/qp4P8JM6V9RpMEGz0XHNNAAF9nr0o6Lu8+azN4dSCX5sivDMg2U+cpf18iy
         LtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952374; x=1711557174;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPh3+JK8STaNVcaoNnrH04Bjmq+JVNkjWGAVdUYYJeY=;
        b=lAl9P3A65fq2Z5dnspWcRG3o1XLf7yPiMjovDKsjT/GIVMYe8iyutTPyyi3EQoAdDu
         ARSz0NkjVreHl4wAF0R7D0ZI3v6VVNeUlKovL0FazsaTjO2fNvyCDUbny8qIqHCDLCXG
         YFIawc/2b9xqc2r9g1kg5pNJwWPJs5EqlEFywHAVWpbiu46t5csDMP9/OhF0YlwgN662
         uxVnXFiIwJTffCBBOQgAaKiZ59gHKhFpJn4r526ixsCnR8y542S9CXs/jqacHixrT4or
         ewAevVkaL2KkYD4ltsOtIxxWhVAdJuMqs2TvrvsQwjkZMBKikcQ3E+GrkK+WY61S7m6j
         o+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTwjjCL64zC1Qmm9axIX8gvESzZkQRf/qyYeXM5jq2DlDf0t18MWFIQwkX93gKccx3BABOuHmRoCjOdOAzZIoNqJKyQz76IwEMzuodlA1AbA==
X-Gm-Message-State: AOJu0YwXu+Ps11YtWg4qn21ItFL6jK+V4VP6vRJf8x8uOkyJ8t82tksY
	Im4UKd5zU0yCS4Z+jDxXNFWR1o3W/dxko+83GZQb8ZCddXafXPKqyQX0qHIMDs9hd3hAtOqNJeh
	3/1hJOg==
X-Google-Smtp-Source: AGHT+IFy9qjZJ8qJt0m0fdcRwFHSNGZaErdUyns14VLHFaZriYh2eKSTtrlv5EWKfPlpoppugb2t3dHqFr41
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f4f0:8ad8:3c73:cef7])
 (user=irogers job=sendgmr) by 2002:a05:6902:124b:b0:dd9:312c:83c8 with SMTP
 id t11-20020a056902124b00b00dd9312c83c8mr460549ybu.10.1710952374659; Wed, 20
 Mar 2024 09:32:54 -0700 (PDT)
Date: Wed, 20 Mar 2024 09:32:44 -0700
Message-Id: <20240320163244.1287780-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Subject: [PATCH v1] perf build: Pretend scandirat is missing with msan
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Memory sanitizer lacks an interceptor for scandirat, reporting all
memory it allocates as uninitialized. Memory sanitizer has a scandir
interceptor so use the fallback function in this case. This allows
perf test to run under memory sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1fe8df97fe88..74e0b17050b5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -486,7 +486,10 @@ ifdef NO_DWARF
 endif
 
 ifeq ($(feature-scandirat), 1)
-  CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
+  # Ignore having scandirat with memory sanitizer that lacks an interceptor.
+  ifeq ($(filter s% -fsanitize=memory%,$(EXTRA_CFLAGS),),)
+    CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
+  endif
 endif
 
 ifeq ($(feature-sched_getcpu), 1)
-- 
2.44.0.291.gc1ea87d7ee-goog

