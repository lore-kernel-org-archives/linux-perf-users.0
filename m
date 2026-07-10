Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A714367283
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661810; cv=none; b=OY/VqcFThljPlCcbYaV/gbBu0sX01rP3BJ3626fGJC16vFjyL+DUREfzDDuoov4KbyPyKwJtsl2d8ssVCjBzYsLJ+C5K9gf60j8pN+LN+WfiuJ6AGvKFVIng8JyXZuaGIf2h566qCVFrYlYsfdOREidJvuCfCVj8ucIsD07sGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661810; c=relaxed/simple;
	bh=hKGyDE36dfV91F1WT4Vx6pvey4Ji0I8vnv/pQ/TKtCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ahv9cS7V4T7Z9lkOjpQDD6ehcOP+1rMoz1mnqfCqjNcbXgf7xEchUVnEx98XjmVAy3YFi0FqolBvAvFgTX0Zvohfz1IPbAuwK3aoPcskxIkhJ6AZzCLCTy/1vnad2RuoMnc4tWWp/zKbNAGyK57IdeEHZbepHAPbH/nzxaiFYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mwf6AbWp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mwf6AbWp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so10905295ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661808; x=1784266608; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hesNL3oF9RYcVUZEBH/FXzVEqwtaDV8FqrcsPIFGKKE=;
        b=Mwf6AbWpOJjeMcFXwkM7L8q0F+UJ1SehixkGKw1TSbNqfqXDuSjkv3a7/RWeqCxD4B
         ibwpymQIxzOeBA3lAbm9plQvXmTcYltFms/gWMan43irdFpHWDOOcISSB/49CFzqoN/B
         3uLD7cY7dJ90wqOxw4NyKwxo200gFPO47tyjggVkUz43iFccmouz9otKGlbry6Sq6ipc
         VNDB59YAdjdfr0SX9Uh8pflBCs9LtVVOjYK1e4igmsR0WK/5PUdymnk6kKcNo1KKceHZ
         azoL/kdESVB6HEiBSeK39tLOF2J9lNVH9rs2qZ94SG/mrDZgD9TWSkfUXv+B6bX/nvme
         86qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661808; x=1784266608;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hesNL3oF9RYcVUZEBH/FXzVEqwtaDV8FqrcsPIFGKKE=;
        b=l32SgX/z541GFDNSiVnsXGUitZG91gVIridCZ7r9uIhIoOfmicbFr6Fh8fkO2fcQvo
         GMCoHYFUkP0exdenw2ohIgss10LBeIAKOMcGhvHggiD6Msw0UrUHVX9OtUOM2PKTsIyE
         FVVvYntXnKHP++hLcpPxwz71m2spR8Q+YoBqGpwnblf1IjKEK+rW7crcDppwEjVHGCjR
         JiPxy0FV6eHec8Kwqbk3+n/IddUqV8FPTld/LgG6nSACSNLk7x7gGgayx2DqQ++4iTo3
         NZWmZM49bUQfXJTkCuA0wA75hHjZaLS5AXmeYELtT+SCnU1ntmlocK+ahrmu3djFbEUG
         7uHg==
X-Forwarded-Encrypted: i=1; AHgh+RpqrnLDs5DYdM7YhsZFwQmIXkdY1/I6LoWhjnG3SXbGlR0JNsbb8aUD4s7aCmVrt7AEnLslNLp8yvRrCaFuxlLS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8t5wMpbVgSmeIMkM+8OULcfar9RJRTPHs09rwdKDKlQZwK9lH
	e4/WjrWx9YthBUnOy/x/vCFxz0AWLVyXTdMwIKmLMX/yW9x6f3nQk1bxMbzyWdSeQ9YMwiN6S3f
	OZyAjodZXvA==
X-Received: from dld10.prod.google.com ([2002:a05:7022:30a:b0:139:afc8:5acc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6817:b0:3bf:a0e5:99a1
 with SMTP id adf61e73a8af0-3c0bcc26966mr12525540637.51.1783661808243; Thu, 09
 Jul 2026 22:36:48 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:26 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-8-irogers@google.com>
Subject: [PATCH v5 08/10] perf ui hists: Remove duplicated thread in popup_action
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

struct popup_action has a thread but this is duplicated in the
map_symbol. Remove the non-map_symbol version so that there's only ever
1 thread with a popup_action.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b0d421768dc5..55dd1af9c81f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2359,7 +2359,6 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 
 struct popup_action {
 	unsigned long		time;
-	struct thread		*thread;
 	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 	struct map_symbol	ms;
 	int			socket;
-- 
2.55.0.795.g602f6c329a-goog

