Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95C39E19A
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568258; cv=none; b=W9W1Bag1tTC1bJOR0jiKXQK7oQYpe6atXoJ7JtQiU0Jw4nO6ciMpve7zTCscgLka3zqqnsUlOn/sQrGZ5NTz+TcdlggnJYPKPmyqoaTCmE77YYxU8bpag8Mn0KdluDa8xS5ucv1FSozDBRIEKle0U0jGijQSgarltQbjmGK3oRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568258; c=relaxed/simple;
	bh=4q94ECQVBZOhRPLDtv5FDLpMM7MbJO6sFWNCWprhLTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ji6HsyjOc4VkvNvhiarBrlWB0BylS3Exi/aWd1dF3nvhqqD7kNi7Z+dQEeoytxuMwBb7TmziOaImJMpeX6jX4TN5KRP+MwCHRfFIAsBZhQ0RLtlrINUZ+6ylqmqGESc22seHYpWJcz4qbHOTt8DtWPR9/Tg/nhfdfDsztJsRc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qOf9kd8J; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOf9kd8J"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38869800848so938994a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 20:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783568256; x=1784173056; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9AH2jaYJ4t23+z22yutmg7GsDf/OW2DQL/dv0EX3Jw0=;
        b=qOf9kd8JpBsYkW28d29l/Rjg/pSjubQ3QltHms+acE+b5xJhW6BqP6GlSwpqltZoqE
         51HUbj95BbPBHqdmdCkYUliKuTn61PTbO026qnSdSPJs7WTgoNLjv8sxHguW4sNekXR6
         /s5UpKZLhYmlI5/LaneRdx6cS17g3a4XrL3u7Kp4PZhfON0KJgMVpOVM3ObUAWEmu5xK
         m6WnmQznwAm3VI0SYaVCCEnhaBwiwMljYDo8qygaSkhV5CbgMPEitAq1EXNShdw8BRVD
         tvN99J5M2aO9WX/asTg7nmr733GQDseCcbz4lzZkc3DLIRTLai3N7xriaXsNNPXTcWaP
         iC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783568256; x=1784173056;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9AH2jaYJ4t23+z22yutmg7GsDf/OW2DQL/dv0EX3Jw0=;
        b=HUNSZUzSq01OOwDOLfDD1Eujevujq/44/ydiNB+N9GRwk9rXdSxnYiskEwttEaH4fm
         /hcT4r8VMPmHT30KQUwqY23iUN6/cKzSkXzvA9M64IqcZFElzWLy2CqhUnb7s4jdoqOB
         O+EKa8PEeE8wbTyn0aW0SZeJcVB+w7HkN7gZIZXUoPm7Jn1afUwSDiz7U3Kzyzpm1k9M
         +ShlK5whTbWCP96PfhFuw7Qu+5ZJ1XAS+xt5Vv8dhA8hHl5+blhO/bPjrk6vK96hpWrg
         GS94JLuA5CuKke/J+ZFGoQNqCpejotiVqq/nR6TZfZXZM2WQLNit1meNvpysi+8cD+ju
         PsRg==
X-Forwarded-Encrypted: i=1; AHgh+RrYsudE6Wd7crW7xdP19TTguGgkmvO2K5BFBqtvwV/CaEtyTijGttoV2bJGCjmj3JET0lxUXDqBKQhHCdlhknJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YysROcgC1hFrDC8Ns44g+8ET1ZUDEC5DS78eAz0wV73VMJc5ahu
	XZ7G72wD4boR2XovF3oktBAMQA/u880DCgo4vHc8QP9gs0fMs8+HcMbyWASM+nja/WOKOmOOdir
	pcebe/CqZSQ==
X-Received: from dycqr10.prod.google.com ([2002:a05:7300:ff4a:b0:30f:a15e:d701])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2682:b0:37f:9ce1:7364
 with SMTP id 98e67ed59e1d1-38941201e0cmr5587454a91.26.1783568256089; Wed, 08
 Jul 2026 20:37:36 -0700 (PDT)
Date: Wed,  8 Jul 2026 20:37:01 -0700
In-Reply-To: <20260709033701.1117943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708234646.1040003-1-irogers@google.com> <20260709033701.1117943-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709033701.1117943-4-irogers@google.com>
Subject: [PATCH v2 4/4] perf hists browser: Increase MAX_OPTIONS to prevent
 stack buffer overflow
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

In evsel__hists_browse(), the 'options' and 'actions' arrays are
statically allocated on the stack with a size of MAX_OPTIONS
(16). Further down, the function sequentially calls several
add_*_opt() functions, which increment nr_options without bounds
checking.

Depending on the context (e.g., branch mode, scripting, annotations),
the sum of added options can theoretically exceed 16 (potentially
reaching up to ~19).  This could lead to a stack buffer overflow.

Increase MAX_OPTIONS to 32 to accommodate the maximum possible number
of options without risking an overflow.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260708235834.3FB771F00A3A@smtp.kernel.org/
Fixes: f2b487db45f2 ("perf hists browser: Fix possible memory leak")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index c032068568d5..ff607e36a0a6 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3002,7 +3002,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env);
 	struct branch_info *bi = NULL;
-#define MAX_OPTIONS  16
+#define MAX_OPTIONS  32
 	char *options[MAX_OPTIONS];
 	struct popup_action actions[MAX_OPTIONS];
 	int nr_options = 0;
-- 
2.55.0.795.g602f6c329a-goog

