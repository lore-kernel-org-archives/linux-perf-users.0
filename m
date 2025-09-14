Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5A243968
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874282; cv=none; b=XlmZ/fKvwfcgU/SyAs01FFMc9BKwTr2ukskHEUqEsNzWdDCyUgmgWzaI2CcttZMGpbetTZjiJDcsaaqdT/3MVP+0F9k1fajvwPf3+icUJnDnkCtNk8Ucc72aFK10hQMio4xVhWQy1kvxM4bFglIwfZ90XNaFp+BesXFwq/zQyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874282; c=relaxed/simple;
	bh=c1zhOVVMQ8wU+7mhRUNPp+wxtAoMdBZyfu+0+9wUxd0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Dct9Nx1URLys/1L5zkfTpHQKmIMNylCK//dOrxzaqrMR91yl+9j2iaJwNWiHyXRsYUAXGH6I/oJ6K//lLYYD7L5GrPTCCahyfKP/n6GrXZvzFPQBF1VwQwP7GAR4MZpZsRp+3PVq0QD+Evm7urDGv5n1AGYjFeeS7dj3gMRwPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCuPDNuy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCuPDNuy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-25bdf8126ceso65120345ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874281; x=1758479081; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IE+Ce4sKejx+7TLffAwOq5GqAqr/hiqBaebc9tZypdw=;
        b=gCuPDNuyiH4TcTrmuWSyE0jSnaTxfRVxOPFdEIeTfFPeYe0okwSc+yzS91nKQdc/uy
         bl1n7M0zTauWiF7VITlmMVkGWM8ob9i024OI6hSockcoUCnq66DtUfnsa1bEmh9jnXg/
         Om/LV44mfnwJwBBn1kZ5RUxCUWWEec7x9Ol4313L4FVnd4WAONtwAmQsJRQc/IeEV0XG
         6bIKJwF0yIAZ1NwpwAvmuzdgjxg6UHvEm+LAxmw877TOGR0kXgDFkYKxkphvT6qKFvl7
         Fs8PgbYx1HVVV4/LLJUVWIYmEocxjc2qo/wmbIPDhMvuqHGomX6CvMZF4tBofPvEFrjT
         349Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874281; x=1758479081;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IE+Ce4sKejx+7TLffAwOq5GqAqr/hiqBaebc9tZypdw=;
        b=Y9ETNqtHL2JlhwukBWWDnIZfHByyCWRlaNiRBTwxsT6cXP8SkdWC2QviO834/Lp/dF
         hW5j74RoSBalLp6iKZGLs8MvFWowIAY3iZ3fBK7L/fuK2LtmoOrmXQZri/DkyS5JPKSg
         hEn+ijAd/2XV2RF2WoTQLR5IPSGby7qaC8WZKOlCyHc8dHsuiER51/j8G2h3GrWJsh/F
         uhxn0IYBWRc0J4FAD+q/ZzqVhc8ymo/X+AMcy7W/RS0jo+6tMFBONU6QvAut6IVSekHp
         R6NCKK0IqtnGvCvPhRvVES8iaQr3n7oDthjntw9jYRbrftZjaBF0VNLps1WDu/4VNREg
         ikbA==
X-Forwarded-Encrypted: i=1; AJvYcCWAn5wvr3iDs+dmYrY8Il4ne/m/8n5/6BI/j2HEJG1BntjRde4h7KM5ob8CpkgUnHGBpG6RyP5G4EoH0PEW3gcN@vger.kernel.org
X-Gm-Message-State: AOJu0YziATm3t05EF5RC3AevPVDsTnjdzkuVs7pjEHvneakWhB7AfYaG
	ZsaheyDyg20bhYYe5UAXYyJRxgkOC9EQeRzCHtvWadugbYDUN5SjdhjXCZbPuQ3AZuq9A/pveMf
	k5mvjs0bPtw==
X-Google-Smtp-Source: AGHT+IEni+sfrUT3uNfCX7z902e/80bK4Z6raO5OgXAr7WxdCZ+MhDqLjdto7FL8yKctv7osY/7uM7ublLqw
X-Received: from plsl15.prod.google.com ([2002:a17:903:244f:b0:25b:db75:cd39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d512:b0:263:b8f:77dd
 with SMTP id d9443c01a7336-2630b8f7bedmr59519585ad.57.1757874280773; Sun, 14
 Sep 2025 11:24:40 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:24:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182437.1959331-1-irogers@google.com>
Subject: [PATCH v1] libperf mmap: In user mmap rdpmc avoid undefined behavior
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A shift left of a signed 64-bit s64 may overflow and result in
undefined behavior caught by ubsan. Switch to a u64 instead.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index c1a51d925e0e..ec124eb0ec0a 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -508,7 +508,7 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
 		idx = READ_ONCE(pc->index);
 		cnt = READ_ONCE(pc->offset);
 		if (pc->cap_user_rdpmc && idx) {
-			s64 evcnt = read_perf_counter(idx - 1);
+			u64 evcnt = read_perf_counter(idx - 1);
 			u16 width = READ_ONCE(pc->pmc_width);
 
 			evcnt <<= 64 - width;
-- 
2.51.0.384.g4c02a37b29-goog

