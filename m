Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059534B68F
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833892; cv=none; b=YvzJqJvonICf95T+OA14cd+h8Vak4XR2vRQEbTtf6jztPL7BRnLw81TrlDUYa1YamOKK8WTcAVDl1r/BOszdOwMij57ok3fN4fUzQO1Zoay7kX7XFJu1A1G9SPiJyc+Kurc4pOjMxlkV6mRTx65PN4Lm97WJSeAxDlcnDQbuj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833892; c=relaxed/simple;
	bh=7NP/VCWcDtaQ9ddY1vDzUSspDiDop3c4KIH6lorm7/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hTKqtoy4l6jBceVfaFc5UEaiqovv/7vB/pQo4M5wDJHgfF0K6XVmv5AuQnRFSPVK6y9UE7MNHU+CPHpwV8LYxa0y7V1CBh6lDdrcm2I1z4kSlWIsMh9Y995Vdx+ALu2PQvpVVuOFM6pBkb3GT7hozoErMpJRF34OIxl3+311XUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kt9tyjrP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kt9tyjrP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2982dec5ccbso32107825ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833890; x=1763438690; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf2tG0VSbGuTREXl21iJqSVPQmFIFuxPe8RAulQFiSU=;
        b=kt9tyjrP4hZkDeoWC7TBY4nQAe1Pt2atieP+gx/2kh12misHkMrsy7YOm+Iygmlb12
         B8t29ODOvvhV9CadZcrQr3SRw67fowUXo2B3sr6WJO7eamy2zhYEwd9BmMCTxXhjG8H8
         O2jWyWQ1FZiH5ZqrCPUnKNzGT3MHNDJrYvKesrxdqZ3LrQojyPeB5zYKwCOEbocmeZSS
         M2FkChLNhnG8J/ewKI7s5cI09unqX+KLIH/TilFTGXAKJR5SPvUohiQpPQJPiEiUEYoZ
         XFv1WIS4S+FQIwwdp0nXWIY1NZhR1KlrNamGzw59QiMVPfsCInjQgYczT4RC0COOzb2i
         fT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833890; x=1763438690;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf2tG0VSbGuTREXl21iJqSVPQmFIFuxPe8RAulQFiSU=;
        b=MFYgRtLVpwR2Go1bDC2+mVBEIzJKDcQUIrHTTMHfmWqhyDq9sq7c0P6pfMqGGt2zQO
         BXiL83Cw7KAyadvwysSJ5elFAQBtOgK02MDMxrUiMrYCPi0i/ZQie0Olr17tAcT438JE
         elJfVniBy4hig7hzYUb+MPSeo9MADs4Me/0NDZluqgKrjq/R865AgHyE3ve9LzMk5XRZ
         aQLxjpbWibNQAzKS7tlHkYkXbl7ZzsntZpiCeBOjze50p1CJPFNrRZXQq5AnyRUOKHel
         BaQTpCBUVkCRpeTOIiiobPxO/12e3BCHmd1GrkUSrxWXVhsHxCkSmEH6pWXAApiUMaGO
         fxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0GEsPg9oyfLOegBr5NVHzW9RByTLJhm3LA4WcuVg4yGHb7WbxxabmYimAwhBpWnco85Q0Map3PrGmQ+iyYHv@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzyCwOfN5/1XD3yUhUcftHfYO6Nru1f+HCY3iCu3hgERRLLPB
	9j/W9tqzUvnrdQGWT/t1hKSLALtS3NyfT0UZuum3kLCVnqVIljy4swKDoVkHVqTzwKHfhaK6srg
	8xu9AZTSPYA==
X-Google-Smtp-Source: AGHT+IF0XIujBIQ4BHEF6rVrrs4Ei1rf7m9r0QAR9t7GsRl8tXu89zXHQL+Hk/jzWA/cU46Hzzz7xVolj7+P
X-Received: from dlbrf23.prod.google.com ([2002:a05:7022:f217:b0:119:49ca:6b87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19c8:b0:295:fdc2:1f52
 with SMTP id d9443c01a7336-297e5625cf9mr142122905ad.14.1762833890175; Mon, 10
 Nov 2025 20:04:50 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:12 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-14-irogers@google.com>
Subject: [PATCH v3 13/18] perf test stat: Update std_output testing metric expectations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Make the expectations match json metrics rather than the previous hard
coded ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index ec41f24299d9..9c4b92ecf448 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -12,8 +12,8 @@ set -e
 stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
-event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
+event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
+skip_metric=("tma_" "TopdownL1")
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.51.2.1041.gc1ab5b90ca-goog

