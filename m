Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B1386572
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661807; cv=none; b=PTydfjuMqJUXOCA3XwcTFm9JBZZ4s5rmx+jnJvAsNii5bHzLRllMwOxn0yS5wQe9AAD95qXiftlg2tot621WIIgyURq0wG0jrylMd1VQAfY5OuBooLqEWWVFbXwf+w43LvYyOWh0vPMVItn9Srt3xOskA+D1dhKpZ1WMi9iZUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661807; c=relaxed/simple;
	bh=ZxzdG19fbYBghEuIrEuTgTxHA8qtyRnNbe7dOi5ZR20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oeipe1p5eUiHu6HhvfgQX0rEgankLIpXASTpVewWZAD4V+0ihUEk573xp/y093PrEUeUsf5XrZ8pDaD2dzU2natGbMmQ54+DzDoOBSdhYoY/9LofAWFGSRbyVaf8yq2FNGfi26pSDc8ysJIDYpRWplGy3EKWpnouzmzKQPlbopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhLI3NGz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhLI3NGz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ca860baea9fso1227860a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661802; x=1784266602; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcEl/D3UjguyythsUfEPZfAokE3+4zb1YC7SD5trpOo=;
        b=hhLI3NGzS8HGr662lx3nGoD6wV86NzYT8AKVANcSEP3qWjJfOdWPyo7ztCOMo8PaAC
         8oXtzzKzOTYalfWmosKKHlOLSCse7zYXkOOw4W0upD6uuJ5sSBfgP5FAbEoMum/+w8ys
         PKNdQjRYo4It+VpzRvSDZVrj1YGdqwF0w2ybG5Tuh4hgjRzUImzvJ3ihXX93+ua4AX1o
         1KosWLIwYnqzztsm7OaOpZ9DarBDQaXEzSkV6ImSPsWtYbxPJjuWGPLFSWlI8OziWhY6
         hR+FhDnpnt8EZIoisyVTCt00d2x3ysc69eIjgDFYVIrufr2oK50wt+P7TPPLXtAxV+3N
         TXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661802; x=1784266602;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcEl/D3UjguyythsUfEPZfAokE3+4zb1YC7SD5trpOo=;
        b=oZKumUAphEzOnsAb6H+LRh9+qyrRU54STnh4G5PW+OKQ93eKcEUXUOb/nc3xhty+nr
         cCa+umDmUyBfynWuzZ0dx/BlEcIanScERAdpBdrVyVZrL6gl9vYMe6F4Pxp+ir9ZS6nj
         d1Mrl1vkcWOtLGJOrgo0GXHh7HV609vVVe8Uq9Aqy/WlvkdYWPxnFjsssKv8mKtJd4F4
         TP8RXeuxWLxn5wzG67zYC8RtE5NJ3LoSsnIba6N+araogqr7Wy25DGP/H9llXGDS6o5R
         edYmnYKKS12lCDbYGqbNh86j1Kbul3XJeZqxo+JjFcbC15p8xRA5eR3Bbo0kak8Hsjwl
         socg==
X-Forwarded-Encrypted: i=1; AHgh+RpJ9jAj9dhifZcK/cBsmFza3YlgGqvpHyTTIkW6aPg6XO0H31QVfGqek2GXnkuYls1pVZjDGtdS72eZGy5D1snf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PdTwxE2sX2tHAdudVA9pR6EVAm2R3NXloJsUHpxdnJ9LXnsp
	v4/QMSkIMvaR484StdzEzVdLwjwtNUQajsfd0+QrepWda9QwmUFItUwFIoVqkWCRWgY2J+y09gq
	2FFFP9OMmyQ==
X-Received: from dlbds43.prod.google.com ([2002:a05:7022:252b:b0:13b:2b79:dd26])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6196:b0:3bf:6c08:2848
 with SMTP id adf61e73a8af0-3c0bd276a70mr12130585637.55.1783661802008; Thu, 09
 Jul 2026 22:36:42 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:23 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-5-irogers@google.com>
Subject: [PATCH v5 05/10] perf disasm: Fix potential NULL pointer dereference
 and use-after-free in arch__find()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In arch__find(), if the architecture's arch_new_fn[e_machine]() returns
NULL, the error handling path attempts to read result->name, dereferencing
a NULL pointer and crashing. At the same time, it invokes free(tmp)
BEFORE updating the static global archs pointer to tmp. If the
reallocarray() call moved the allocated block, the original archs pointer
remained active but was freed. A subsequent call to arch__find() would
then pass this dangling pointer into bsearch(), causing a use-after-free.

Fix both by printing the numeric e_machine ID instead of result->name,
and updating the static global archs pointer to tmp immediately after the
successful reallocarray() invocation to safely retain the valid prior
architectures.

Closes: https://lore.kernel.org/linux-perf-users/20260709035721.9EE901F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 0a1a7e9cf3ef..6cfdbabbb8c7 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -180,14 +180,14 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
 	if (!tmp)
 		return NULL;
 
+	archs = tmp;
+
 	result = arch_new_fn[e_machine](&key, cpuid);
 	if (!result) {
-		pr_err("%s: failed to initialize %s (%u) arch priv area\n",
-			__func__, result->name, e_machine);
-		free(tmp);
+		pr_err("%s: failed to initialize %u arch priv area\n",
+			__func__, e_machine);
 		return NULL;
 	}
-	archs = tmp;
 	archs[num_archs++] = result;
 	qsort(archs, num_archs, sizeof(*archs), arch__cmp);
 	return result;
-- 
2.55.0.795.g602f6c329a-goog

