Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29420B21F
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241886; cv=none; b=Dc72AdzhlywWCTzAp1t189fuKuQarN049FWERAYNTt4cr28y/jXCR/yV9u2RqWAVgRv590iMatXW/rgU+toEQFfipPbUHw5DXbXYTRC4c3n6+FGS2gIngAD4KPopFXFX/OzUB6t7Bro5wsyreVjTmo8xiU3dxVkFzvDCnrbHceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241886; c=relaxed/simple;
	bh=GYxmpcXArXMONJWsRe5WPl7DZqsyI1iL6F7x/lVFYsI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AWXSsfMMY7wTnyOcJay6SyumnijLTRHdzB2spo1xnKvoZMkJGE8TGBOnzADJfUZzXb4No3EMtjqsHRIeBWZHoqITAmaerPElgF55oL4xndHxktAABx03587dpUOidZcpZddCKGkhLLXmYZbQLdvBlBhFJP9qywPNJStmUIPADtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kPBhBlF0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPBhBlF0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d6713619so92697207b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241883; x=1730846683; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=kPBhBlF0DgUiCLowoYKdoq6OJJWUSE5CI2Nt+RoWQReK5+Rk7HVusHPJ/QJBU3M1i3
         3y+2wtK60zr7UB/vIqtkPTev1eLYr1mXIdpYWZfrBNFEeHeJ8F67ES6h81S1rzAOTsbY
         rQ3gHzygOkVZWCZ/b0GWaKAUnkMQvMw94akup0GZiUBav4NX/8gk6OLxmOPQBry10moN
         dTXGfe7S27HT+aTpmgYLW7dVyV8fSg95ICdIzckz7JjsmR1z0xWhHRPJmSY1hUiOkMhx
         yTKUiyDPU4nGTn3Qzcm7YCk8s6svROwrf3N8xwqRV+7u+MDbvitscwErlZbk+Y4rF1hB
         DKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241883; x=1730846683;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=A9yN+lIz3p0GPSW1ki7gZC1dgImr43S6YUMhBy7bEfGEFBwDTaS0Vq4+r8fTtgS8aR
         Ngbte1pD1MG/OT5YLVd0DMMInyDpw0IU+bO4N6pMxjVva/SMC+isEeH7Ggw4RlIimWjC
         NGjus2RzPliFaF8x//k2F/WFkvQ8akp0vcIbwyzHAvJQ0DmWhcqQNE71nkxJ19KXZJ5n
         8WAL5RPZECrb6dI5H5ojPjGv32LmA5z6dw1SYq9P11B0HHG1x+1SCewTja8+BT1riv2i
         31zIr8DHmbE7uOCPjsTkGrkuto84Fk1cLlNH3YS2s6gy5KBMdHRj5+10YvK9xpJEaCcc
         qdoA==
X-Forwarded-Encrypted: i=1; AJvYcCUXB/GM2cO+0fQYj3FsVAbixa1AvIOk/jQf8YgaQXpZJM+KnbEQNiFSFTAlKfnrNqYuHUhoe6P+uxx6SOBSoFG8@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8rbJ1l0mgDeQ3S2J0g6d4WcQQwmRUanqv7WfCLeGmLnRmIHL
	o7RkRG1AIS9nm8JqoN2rjlp40yCxv0jT5+Kve63QEyHQspL1cGqKSdZiGKmbjM/nSI9WrIm7a/H
	qhG4hIg==
X-Google-Smtp-Source: AGHT+IHlAm3tLezbzVt8GbVuqDvnkCdiAAUbGwwokxk31Ep1SZRLobw2hi3jMVj1TyxSH6r16iitdVAfC4fJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:4c09:b0:6e7:e493:2db6 with SMTP
 id 00721157ae682-6ea3b951361mr508657b3.3.1730241883136; Tue, 29 Oct 2024
 15:44:43 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:15 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 03/19] perf python: Remove unused #include
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

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 13dad27169a0..974578a04099 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/kwork.h"
-- 
2.47.0.163.g1226f6d8fa-goog

