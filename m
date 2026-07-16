Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1F3AFCF4
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186648; cv=none; b=F7s97m1Sp9f909YAVZUNOxO3I1GDrx4/QgS5Toj4tUEjxMukaRCXLE1Q+i7JrDbDjl5t+/ZX0rIdQoytp2JddFR2V/3EYbAfAFW6u+mt3XHZ/Ghq6+n5voIoqAyCKjB20P435wkFhSGg2Clf2m08mvCREB7BUlvexzo7Im/qwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186648; c=relaxed/simple;
	bh=OQnZG4lWwCVZNFFv+qmWSuLDOYj1modF7T7mDaffX0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C6Z+kYb0L8B0gvDInRt8AkYkHqesi/2ZjLomZMW83FLb6HeHa0iGO5VFIeabH//RO46UQwJUUokaziuA3tQPaUDk+2lW++5dRNWAFmihBRRrGMWAY4SJ9fp4MPowNZFYbwmF49ut4PC2WKh2VOxRSGtQpRVKr7GMtvQMBNoJGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0E65c6G; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0E65c6G"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so8698558a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186638; x=1784791438; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4AyOHGwQFEQf1jZv135QVF27AMFmEDsSuusEH3Het24=;
        b=d0E65c6G/Mmq6d5KlCZeGHTmqRq7Jv0BhQU+UbB0F3eJ7sQt/ETRxo/sJh4PmcNxzE
         ytl6XIGaiMD2oybBKh9PomD73wO4+40tLxEcCBN1i/W9jpNXyN8b1iTX/EBOnX2wdhYt
         RuTBdnxfRAhWv8ScT5EDZ5JLzuJh828i4WAjsqKUkTlIxjz74j9jb3kBzJuN00vgeQxf
         n8TaqGfemAzOgzZnBcvJAgAcntZdrp4POO8RDS1w7DmhLXjujvFtfP37NGl36X+YMQT0
         tOpQ9Jm5s85Bz2ADTOSdCcH+BQyEKTGgwJI5Xvzfixc/Ao3vKdXhjdKyQ8rv0hoki7Mo
         xuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186638; x=1784791438;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AyOHGwQFEQf1jZv135QVF27AMFmEDsSuusEH3Het24=;
        b=pDZJ6Xp8zFRVcVdFG6POnFf3EsS43sQN9rPJpLfisY+eFpabNLjUpnS4MH5P1QpMmO
         KBXENGZ6My3ISSJAVGmT1N8NSFfM1QHIAb1TGZgl+zJXlVH/020B6W0MWfCwWwzIFvXB
         iwfk4StX1/K/a5XYwSoNgvY5x0RZVKNwFi1a1J/+LU8XZyk8tMCEUy2p/bauOkPJWivX
         ZkY7X6t1e3XMRbWCYeJx7PBa5yQxucVPZBHYdqeCL4O8z85mm4uXQEoZ/V9r0BsBc/FZ
         5jZ28Lyq9vhQapuJtAR33r3dRx1Gs/MC4Wx4F5vbioye6oSRjw0BXdv6JjzVT1aKWTpu
         idoA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+XwZDdZFpB1t071YeFlpumILjxKNfe4gqIrvyLKXCqslY4j0jPbDGpnE7f6OLvy20j7gY6sYA8KxrH5wohsFq@vger.kernel.org
X-Gm-Message-State: AOJu0YyVv3cckLvo6Fsp6HJh9epg8m/dqYA+phOH779rmbog3HC/AmW/
	WEuj24PK9HLO0ei0m4iuwLQtzGrhvwI8hfJUWJpaxBbqCA9dIT3dJk96tU1Rvg7E/WflwTEFQuF
	PVMZjEg3KIw==
X-Received: from dlbvc4.prod.google.com ([2002:a05:7022:fe04:b0:13b:33a8:bf96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a98:b0:3bf:6c08:fb83
 with SMTP id adf61e73a8af0-3c36c3ddccbmr6597294637.51.1784186637705; Thu, 16
 Jul 2026 00:23:57 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:43 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-2-irogers@google.com>
Subject: [PATCH v6 02/10] perf ui hists: Fix uninitialized stack memory free
 on pstack allocation failure
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fixes heap corruption by initializing the options and actions arrays before
the pstack allocation check, preventing an uninitialized stack pointer from
being passed to free_popup_options() if the allocation fails.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260709035230.6DBEE1F000E9@smtp.kernel.org/
Fixes: f2b487db45f2 ("perf hists browser: Fix possible memory leak")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6163cc3ace27..319c3d6c0375 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3064,15 +3064,15 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 		browser->min_pcnt = min_pcnt;
 	hist_browser__update_nr_entries(browser);
 
+	memset(options, 0, sizeof(options));
+	memset(actions, 0, sizeof(actions));
+
 	browser->pstack = pstack__new(3);
 	if (browser->pstack == NULL)
 		goto out;
 
 	ui_helpline__push(helpline);
 
-	memset(options, 0, sizeof(options));
-	memset(actions, 0, sizeof(actions));
-
 	if (symbol_conf.col_width_list_str)
 		perf_hpp__set_user_width(symbol_conf.col_width_list_str);
 
-- 
2.55.0.141.g00534a21ce-goog

