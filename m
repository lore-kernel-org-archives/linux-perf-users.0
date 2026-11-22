Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323856;
	b=42gAEtveEWk4f/FNQXDy6FB9CqpPU6iUXgss/sD7swyyAWiM/6n7hn7qhzYb1xZTcdA4
	 wmwjEH75sGSba1E1iTr9WYZFCSanQvsA8NXuKUFHez8ZTXO3PJdXRnM09K1tg3yE5Qiq7
	 fQRdnbcYpR8Im2mm7+BOIPmy9SMgn4K60O+/adRKxrZSHqE3gG7/dahSuCQpGXQHXg9B+
	 gzaupPp3Kr+0obdBwBSwgah5qL0lQs9tXEyLwxNANSooDzcWOt7n8a/kehuYl2AisjOYC
	 inW8BY1uuoS+wojS62jnd5R2mnW2jTWSKLTRC9sOJChukItemNZCEVsz5WDUd3kX9oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pH2BPzLxsd8NvvUmkGMcSjMobCCeF4ip9zrDbmpxIGM=;
	b=jDPTD4YCG5RXQNCxZQoKgkOlIv5+F9cB87zYEYpOLcOsROuIXkimkPdNgYh0OQ/1WOPv
	 MhueNikooGgzxvKEYQm1puJBv+tsd0sci2yiqF2Rl6LwzIrFIHBTVSXpAkDpV1RHRYzey
	 BNuk6i7+F0KLBfMe9CbAd2gjdoKfPDOVAXS5s8phH0rda7H+bBwgQOfidWT/nOvLAcRgD
	 rPONL0T6HwA81CGfogJWcEzNckGcNmA+oaUwi8M+nDysfypjrGIXFtqo58R5KC0AivOYy
	 JjfJwzJ+yeUhnCJ98BE93Afh5jwPj1XkPWhwBxsNF6RSj12Vb4uFlwtkDdjaN1H+Shw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nLQ0PXQ7;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD97606A320
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD97606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nLQ0PXQ7
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-38355b03cb8so2265773eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 21:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795323855; x=1795928655; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pH2BPzLxsd8NvvUmkGMcSjMobCCeF4ip9zrDbmpxIGM=;
        b=nLQ0PXQ7VRoh6j8O1l2lTKM+Mz25ztUwDpe2kiROjNruKcbNSKU9EKsMjX22EvwqL9
         S31tRt1aPR/FVNkn5+joY9QOtq/2KH4ZmkUSDaBZZvG32nRzap0XESdf86Kx6JBuohvq
         gcUHl0hU9k7eyRH5tE6xoDw2KW0q9xmVS36GxYEZAAVUwpVTv+ctpgdUFYaxYlfnapLM
         y7E6rVo8LllAPUVeeQWF59zYZZThH9v7YTYMpDSI+HGtiZcREr+SpHIA4aR9/R6Uhtpv
         Lv3EE9C24llnyBfKNuAwd79+ARYnP/v9rKq2Fd0YtpCDJmRUM/p6k+qUUw31GoIpBpTp
         ujSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323855; x=1795928655;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pH2BPzLxsd8NvvUmkGMcSjMobCCeF4ip9zrDbmpxIGM=;
        b=tkDJX656XsDqfFUFGOq0lkoI2E2jX/FywaoB/dk5hxYV/OF1r7HSah2lPM1H/tZcTM
         2ZSssN9Q1DubKZqOPk+20GranEWUezciiiTEcKBGBjVDJL6qsd+NJ+Gdn4/GHqwYnBbF
         ASK6gpnR+B/mHE/Hhs4w+a1WjOGP/zRA3pgc2xOS7+oc/5gro/PhoIcpA0NrnKxtj7TC
         YX/F7F12GohU1wcLEhACL7s2bdQoald3g60D6eaxReKyQJqySGlPoclMOlTzF1BdFQVx
         2FcCx785GqaGJGfexJ1lSKLSkIOPm3XvDFW0Ohs5ICiWXDjjfJ5oWWfG/OzOS9Zr7fmL
         nGUA==
X-Forwarded-Encrypted: i=1; AL+hErE3VyO8rw4rUk40htGx3atl+Z/7EgY0v8+cebeAJcemLr+ImvoSCMc4fKWN7ZPt+p3EaqG8JWVggFz02gNg+mY2@vger.kernel.org
X-Gm-Message-State: APuU4Z+o8WRILlACOk2NBERlbUly0aAOl5nHCXQjrwWfY2iGXTUTob3g
	GXMWy2+deW6xs2TuBbp1tHq+R+4EJbIPIBIZ73F3NjMeM+r0ms5zfV/FBR4SyplLvahA9X+DYNk
	s40pvHG1YkQ==
X-Received: from dlam5-n1.prod.google.com ([2002:a05:701b:2085:10b0:15d:6b8d:2adc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2088:10b0:1b3:a22c:7f68
 with SMTP id a92af1059eb24-1b5568d349fmr8253316c88.29.1795323854566; Sat, 21
 Nov 2026 21:04:14 -0800 (PST)
Date: Sat, 21 Nov 2026 21:03:56 -0800
In-Reply-To: <20261122050405.80335-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122050405.80335-2-irogers@google.com>
Subject: [PATCH v8 01/10] perf kmem: Fix alloc_func_regex leak on error in build_alloc_func_list()
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In build_alloc_func_list(), after regcomp(&alloc_func_regex, ...)
succeeds, the early error returns on map__load() failure and realloc()
failure return without calling regfree(&alloc_func_regex), leaking the
compiled regular expression buffer.

Call regfree(&alloc_func_regex) on both error paths before returning.

Fixes: c9758cc45699 ("perf kmem: Implement stat --page --caller")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 8693c6b135ca..1404b523a785 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -364,6 +364,7 @@ static int build_alloc_func_list(void)
 	kernel_map = machine__kernel_map(machine);
 	if (map__load(kernel_map) < 0) {
 		pr_err("cannot load kernel map\n");
+		regfree(&alloc_func_regex);
 		return -ENOENT;
 	}
 
@@ -373,8 +374,10 @@ static int build_alloc_func_list(void)
 
 		func = realloc(alloc_func_list,
 			       (nr_alloc_funcs + 1) * sizeof(*func));
-		if (func == NULL)
+		if (func == NULL) {
+			regfree(&alloc_func_regex);
 			return -ENOMEM;
+		}
 
 		pr_debug("alloc func: %s\n", sym->name);
 		func[nr_alloc_funcs].start = sym->start;
-- 
2.56.1.750.gf70dc682cf-goog

