Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948669;
	b=0m1hxosYb2/y6JwK1rR3JkI71RVT5YofgyP5ySbv/Ax7E7zlgVatLN2skmcsLPa/KOqs
	 FbU2SIWRq/blzsCyGMdTBv4krWUW3CZA7odIWcwy7FoIQo1jXXWtjZgGRfcuj6xODDghy
	 Zw7tDAKcwVHIPsbCofp3iiNzRaBF3wLQIaI8HK64OEfrXMExPxCN4LRebPQaBX4D8hCmZ
	 +BUGAJ0v0Em7yRyBZ2zVTrH0LaHKAIBuBKsYJYL5dVX7PJPMOxxTP/HWrei/eG3Uh06+V
	 wmfoVL+2JkeUppVuUMji1LWDE6wbZ9y2m0Vo9fwqBCD6PDWJLzRquSnu8K4Vun3vLdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jPaRO8oHRGj9zo+g5wm6NL8QtaNqCuHhACg6/Ph4t2I=;
	b=v2Yzr4kqDoRpZJ3mRZHqbhxDQN/UEj2vx3AVfPrr/jZ7QL8S7oDhoVqVTcTvD8SqMUE5
	 iLRFfTUoaXjvZReceR+Yh4RvIJODJP8ipMw880DhF4sch0yHkQw8j1nckb8A23AAMAfH0
	 cDZFXLXJO0oCVHziJagk39SpZI2MeqnIcpij20QmTkF0wY+3SNSt4CoFm1GBIAJ4oiFct
	 qtCFibmJWcX8LMLhiBN+nDsJKsRYSUN7HCLeassLvnnWvepxjJuJQd/W2LnazX5By3CG9
	 pwcGHoqaTGBMbB77GzmgKCqknId6MQ6qusVbyGDb4ce0AB2v6+31qb+781xPD+fIiqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I+lqxi8U;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D6606EE91
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C46D6606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I+lqxi8U
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso518486eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948668; x=1794553468; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPaRO8oHRGj9zo+g5wm6NL8QtaNqCuHhACg6/Ph4t2I=;
        b=I+lqxi8UeUTsgak0qPdMOUy2UHOVDa7n/VTCGKsDSqBoNu35G/tXR7aW+fqtMboUFy
         uT45vAilzUlnQfKuX5ZMs4bBek1+OqDYvveSgMtccMqo3ENkitcKqgiOeWK1OP0eIxfq
         ANfaiqFPNlRezl1a1Y1a/eOkdrVxeH78jBIDno7n2tkXDRNp3BDPpR6Ai4e2JM7+kSWJ
         M1CB5//dQ0d1C2MGU1fWbDGuqImRsfIk7J7tdXLrtvhgiITJXDORqTavBJxsYoGbsMvx
         +WvxJQ2vVLBTlG709Xr4PsT2NWCXaHxRlRFZj4eedGkDx8tWC0Z+0OxfJyCyBXd0aKCn
         K3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948668; x=1794553468;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jPaRO8oHRGj9zo+g5wm6NL8QtaNqCuHhACg6/Ph4t2I=;
        b=ai0qM/HFaOaqgLWzaC7c+XQl8Y23a77lqJ/s7HtUJIm4+nSSOfNOgH6XkRKH6BJgWD
         nG/Kv4Y3qlGOZs2mQArkGGyJsI9TRCSQUSXVqifEi6oUgTuE8iOMVNvRua7OM5o6MuL9
         KTQWlVvC/36szh0A8GTnKCwo0NYI5o3fOn5kHE0pJbyniK2lK2CQWd0j+KO0Qbg/Yc7o
         6kYeStnXdZz0+Oj3sIl2p4uqn16p6rMcmvVt7jJfzNgssGYbVHCt+CCEsbN3IVc+Rj/b
         gTrVpAE6KyU9h3UnOr5lSSg9GgobxaG13wF4+Umq/Dk/Lwk49rkFLcFDCKyhF0DmxZvA
         5rIw==
X-Forwarded-Encrypted: i=1; AKwUvBw62t6ZG1Tmm3Ad2phTIwTq93zFoaRyKK6cNLbPvjAMichoZjQMvBc1b08k9VB+JHHrOM13el1Yc7bDV+GOz/bK@vger.kernel.org
X-Gm-Message-State: APuU4Z/IFocadajpPjPtV8qxN29VRfMB4N95+TdzW8pYsM445W0W7uZl
	QnPyGUKjK78+G5r/EEJU6aYZfHR3GQhFl/Y7TLdipFXOsJkOzvnwbnLP7j+gNU7VKXM2NpfZbXR
	NC3kshg/bOw==
X-Received: from dldyq20-n2.prod.google.com ([2002:a05:701b:4554:20b0:1b2:415b:9bf4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:170e:b0:18a:8164:ce4
 with SMTP id a92af1059eb24-1b25d1e3e6fmr1997788c88.0.1793948667649; Thu, 05
 Nov 2026 23:04:27 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:42 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-19-irogers@google.com>
Subject: [PATCH v10 18/20] perf maps: Fix lock inversion in maps__load_first()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In maps__load_first(), take a reference to the first map and drop
maps__lock(maps) before calling map__load() to avoid a read-to-write
self-deadlock when loading kernel maps inserts extra trampoline maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..7ca33e5218e7 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1459,10 +1459,15 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
 void maps__load_first(struct maps *maps)
 {
-	down_read(maps__lock(maps));
+	struct map *first = NULL;
 
+	down_read(maps__lock(maps));
 	if (maps__nr_maps(maps) > 0)
-		map__load(maps__maps_by_address(maps)[0]);
-
+		first = map__get(maps__maps_by_address(maps)[0]);
 	up_read(maps__lock(maps));
+
+	if (first) {
+		map__load(first);
+		map__put(first);
+	}
 }
-- 
2.56.0.455.g6c5a503b38-goog

