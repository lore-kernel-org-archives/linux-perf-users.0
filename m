Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244380;
	b=JIAKue6gTpxPaA8hZ2+ybKAdL77agjnGbVGSkfueh3Zsk5kAuYfOqnqN7sWEoyi5iqe9
	 Qnh4AsCLSIp/+pSekmKHaBIWH3JIlMPfaF+KJAd8eNBCcHcLi0XsrrrRBbnxIw8/H8ETq
	 TB78JIc1aH3D1Hnvb5iaWMVOgYkV8PB8e0Ob6wFFvcQ9wRzAiuC2dRDQMdYaOkFcwFwyg
	 exY38UnYTqOiei/79toP9DIiySVQJkKVVCH6VKF3gimVNzDiijf1bmS40K/xfj+FTHqms
	 Mn19HWYg7shIsw8M9q+fCZ1h36gFsCj65SxfffiAHlWKyMA850gTy8z35aLW1Qs6kVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KOONOUBRea55D4L/MhBbf8K2lc+JFi0aqBhiCgSX6Yw=;
	b=zRVNkeY7YEG0Sc4MZXyrnmYwZUgPRfP3vTlIyJfC46ZJL6wBV1tX3s7Z45P4fTauM0SL
	 2hogF+w1toAiZufNdpENuhf582tug+hL2T/SwNahEiwF96b4CqGXKNDZs8rnC50K6bS7L
	 70xgt67xwVaTXys7fcuDcRta29/GqK+Mnx4augL0Ll2wYowmAqWx2vv/g8EuWo48sv9Qh
	 QYy7tIjF/X+VdgXVMUsbM5HXFBznVf/ErfksjrHE2berP3f9SPibl+hH/jSPQdXYmJTkv
	 EUMlyyYmtavdWJdHAsp/f54uUEqUyL9owk5mv5MH+pzeSBs/sFckN41dA/lDBMNkecQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XTr5xx8D;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761E606A330
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A761E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XTr5xx8D
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-8488f31d754so1173562a34.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244379; x=1795849179; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOONOUBRea55D4L/MhBbf8K2lc+JFi0aqBhiCgSX6Yw=;
        b=XTr5xx8Dnfe+l2AuL3AwIcShg6lt/rcTnFHr7wqhNtlP45dfH3p2umXPfPwGVvSKLk
         QKZyt4dQ9J4pEdjvz/t/AlS14D+x0aaAjSFJ77CtBLSzQ9TkPLMlwXHd8kmdju6GQTo4
         oIKvi/FuH1/jq3SXIMokDR5wHPvPHi2HH+cupOO1L+plr9zdvsYqwck2QodoiJHLQJvT
         sdC0ZyskYnIG0zMxw+NrmEBJEN2JYMEfXqLY7V51vLbAe9mD9qGfjTSPsbAHFCOjcWJG
         qyt0m56DUrdlqy6QRlm7pOWVKQlNYk5S9x1g+UKDEUv3y7JJiB3OJz4wO2mnHQJxqYJP
         k0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244379; x=1795849179;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KOONOUBRea55D4L/MhBbf8K2lc+JFi0aqBhiCgSX6Yw=;
        b=yy6kB2f9uqAhNrnCzmatSGW03YZPf7ot0M2Vfh1DBuKiL7UPbZ/XDxgTXzClFOl7Sr
         nr2QZ2PjQLjQk6Zfq8k0CKSuc+YjCCRTKssM4JGR6UNWH+FKt9So/HyfefueHKhG8ZuI
         2CgmY74CiZy9ALc4vag21YEc0azTAYYN2iEVTqMNb3BC+gHn9Jvuv7tjtZdasPdlyaB/
         LF5k7F2//Gma6AJlujAMa2GSoCDrTKlUAbiqbBAb2lTO+ekVUG22Psxd2zRyLqqD1/D+
         vWE0yYkwbogE9zTkiAPj5hTkqqJYCNkgTGWhMQaAKLIn+Rbfgu9nxWSffXUqJXu0PYAd
         HyEw==
X-Forwarded-Encrypted: i=1; AL+hErG4NZMcmaYcXXHLFrIV8kFRwbQPQGvKYo+pGsrptcWHABZpsnkk9ocbBjcrZHkemmzt9YYU4Dw8itIy0aSyWNU+@vger.kernel.org
X-Gm-Message-State: APuU4Z9SijdBC+jG4tTDiIUeuwXRrZIfzZIYRDbQN0/Oow2yCEj6iaX+
	MENhMNtzwq4QjqL5UNl/NvhH8yLGkrW7DBdgWRjUbHqaOhti2S06V1ws7A6r0aAtcpbNJeSXUyf
	a+4c/IYx4LQ==
X-Received: from iobmr2-n2.prod.google.com ([2002:a05:6602:a542:20b0:9e2:221a:fd83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1a02:b0:572:2919:eba3
 with SMTP id 5614622812f47-57a0ccdebf8mr6144982b6e.67.1795244378377; Fri, 20
 Nov 2026 22:59:38 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:08 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-20-irogers@google.com>
Subject: [PATCH v15 19/23] perf maps: Remove unused maps__load_first()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 553d18c98a89 ("perf lock contention: Load kernel map before
lookup") removed the last caller of maps__load_first(). Remove the
unused function and its declaration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 10 ----------
 tools/perf/util/maps.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 675fe0223faa..496a592284c5 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1457,13 +1457,3 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	up_write(maps__lock(kmaps));
 	return 0;
 }
-
-void maps__load_first(struct maps *maps)
-{
-	down_read(maps__lock(maps));
-
-	if (maps__nr_maps(maps) > 0)
-		map__load(maps__maps_by_address(maps)[0]);
-
-	up_read(maps__lock(maps));
-}
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4ec9b7453a3b..4e6eff244125 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -83,6 +83,4 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
 void maps__fixup_end(struct maps *maps);
 
-void maps__load_first(struct maps *maps);
-
 #endif // __PERF_MAPS_H
-- 
2.56.1.750.gf70dc682cf-goog

