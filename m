Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42F2F0C79
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615948; cv=none; b=WH2NDwZdAeKKF1pvh8juqOgoM+o9Q6VoTT3w1R0EAng3++G4KWW/MW8KvGsQjQHuYIK/EsES3+1lxtUuVn6NfC77KFD9ssgqzPRCbLlYqE/Z2vPXh/NMoPvdv9DoyNi2EpKJ4ISjGiJDl4KvMaayQLdVJb2q3gqp+Mnx+apHCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615948; c=relaxed/simple;
	bh=1AQCbIx2nThviJTPKVO1TXJHUKW5IqCuek9PNbAKQ+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dWFbKOJ3gJRdQJ0yuvZppaf4yqZfICbxYIj/JRV+vkwUU/gek4IU/ykeRh/yjQ5yFEBgFsl8jLZjhpNOPBOkgU90vh8vmmirHF1hmlY7uffg49QtFEbPuTQ5iPBPUy+SPWdiHMj0y6r1VvKeDZva3ckyOJriXK0xvhYO35dTspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uW7/ONdC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uW7/ONdC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso48733a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783615946; x=1784220746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ncsoKbAKoq1oT4Gq9EjApiiq3meChA9U0GgwZuBf0M=;
        b=uW7/ONdCkv7tz4JbbWyIKzyEe6FZ90BQp+teS/LTZan+oerGpSTWNtzm4TR9qb+pgk
         r1bJB2boEx99hQ0SkpcicqjeHLK/0zHyzeRrssmRkeIOZtxH32/EsKaCGv6MabbI8cyP
         crLaamJ2y3Y24qfW8bjFPZ3GD0dBfigQ3qx6ezdZ0a+nXylHvH7GPH873WQRb6OiR9R8
         7OXzUgKSZSSaYF+1PDKuyuKTbEJoHoj384iAAnQ9wekiqI7OpluMIuaPhREXRk4KUpLj
         kOEwuRae1XVvdRFtd11anvRiEP4H7aSE6ViTj3T8ATx73WoMi1W2ppC4ZCcp3x8edfCB
         YeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615946; x=1784220746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ncsoKbAKoq1oT4Gq9EjApiiq3meChA9U0GgwZuBf0M=;
        b=Hsg9MpsA0Gk+oWhtWS+DQfFUw5BHYvXUrtoboDYjXC2f/Us0pVU0ISam1wVcOI5ECY
         paWfPyrOeV5ql6ZtCF2p+TqGf87+FDWtsG/jenWdVii9stMFiAgiYjeTuGdzM9PApfSQ
         a7FQHcBqznFhHtZYZY5zRCwfKtsKjDQm3bara+VlW/BlSWM28GSz1/pmochmQ3tG/5iu
         ZoMrunhTcH9Glx2aPzNnQth/6W5d5TGDOlZ4NDHpC3Xr6tXY2Ffmk9PmK5z/N2c2D5vp
         c03XOAO5eABIlLw9sz9FGKirtJWYev+m4I8Opvo8y+Gvwa832lZaoQR5ODhAx/5ds/49
         UB4A==
X-Forwarded-Encrypted: i=1; AHgh+Rqp3uTHfSAE9L+9P9skFizvVlGLzz2JRbdcEFTTcuOCy0cimlScdVIRs7T5jDyCIITKPK+1IJCX1NuSXWd3SNiH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9JUHJ5S3f/ZfezQvwoY8AIEiziDXLML22migBUWkWUjzj1Id
	qkctUeOaG8/zSMoc74iViY/d/9CDPCw1ALYQ5BWfoEjH49t+PZBZqvGAvG8T1SgeFaxW/9zyQcw
	pnYfPEuDKkw==
X-Received: from dldyq14-n1.prod.google.com ([2002:a05:701b:454e:10b0:138:5e8:1b36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d0c:b0:3c0:9c1a:8935
 with SMTP id adf61e73a8af0-3c0bcc26a29mr10212076637.61.1783615946230; Thu, 09
 Jul 2026 09:52:26 -0700 (PDT)
Date: Thu,  9 Jul 2026 09:52:17 -0700
In-Reply-To: <20260709033701.1117943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709033701.1117943-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709165220.1411149-1-irogers@google.com>
Subject: [PATCH v3 1/4] perf ui hists: In report UI ensure thread is set
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

A map_symbol contains a thread that provides access to the wider perf
session. Recent changes used the thread to get the e_machine to better
support cross-platform disassembly. Unfortunately the UI code wasn't
populating the thread and so the e_machine lookup failed early
breaking the 'a' for annotate TUI action. Populate the map_symbol
thread to fix this.

Note: For the popup_action array, we intentionally do NOT use
thread__get() or map__get() when assigning to ms.thread and
ms.map. The actions array has a strictly bounded lifecycle that does
not outlive the menu loop, making raw pointers safe. If we took
references, we would have to clean them up (e.g., via
map_symbol__exit()), which if erroneously applied to raw pointers
would incorrectly drop references owned by the caller and lead to a
use-after-free.

Reported-by: Josh Stone <jistone@redhat.com>
Fixes: 0e26ba5a8774 ("perf disasm: Refactor arch__find and initialization of arch structs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index da7cc195b9f4..f8ffd9b73582 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3155,10 +3155,12 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 						continue;
 
 					actions->ms.sym = symbol__new_unresolved(bi->to.al_addr, bi->to.ms.map);
+					actions->ms.thread = bi->to.ms.thread;
 					actions->ms.map = bi->to.ms.map;
 				} else {
 					actions->ms.sym = symbol__new_unresolved(browser->he_selection->ip,
 										 browser->selection->map);
+					actions->ms.thread = browser->selection->thread;
 					actions->ms.map = browser->selection->map;
 				}
 
@@ -3173,6 +3175,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					continue;
 				}
 
+				actions->ms.thread = browser->selection->thread;
 				actions->ms.map = browser->selection->map;
 				actions->ms.sym = browser->selection->sym;
 			}
-- 
2.55.0.795.g602f6c329a-goog

