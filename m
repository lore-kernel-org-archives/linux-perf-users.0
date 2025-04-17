Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EE22172D
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931280; cv=none; b=F1onSwsvmw9CCliu+FBMl7HEdHxS0msLs1VzhspQrB4EAlWYzteIiVegYAufOLvQNMViBU8Kdcno7OcXa/FRIDlfv70oVb6OkSfFq22sG9WmYbNVjE977KFwjj2PgOmuMkQPpSKT3FuZh0xWuk6lTfc7A0HauGzoOMkq3szFfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931280; c=relaxed/simple;
	bh=mJQVFLCm9ty84JCDlLg5++0OwAqRrW5FDC64ClqBhO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z7RCAXmGvqsY1VpEkn9ePo/0DChXgrC3ts1MOakwV7H4lhSJXOKelxlE1L+xGA+MywF7geWeGbu3t7WlpnzlL6Ue9h9lgdA7IkoSqH4dUb8pmIpS52KLTH6oj6Vsnql7Fdi/I0TxdVZ3G7XJiAlq9gmVITjQ9U5ky0ZZcaYpXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBrxRa1+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBrxRa1+"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so1883966a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931278; x=1745536078; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaI5u9A1ZK2E6Bx2qH0e5jW/HFuv3lmW4guRFbw3gqw=;
        b=qBrxRa1+ec9Ws5tbhZ5R2CKAnzVXDEeFJP3B6jGs+HI0iYWUEGJozfy8MqMkuCvm30
         LNOTriykQ+VIw+5RpRWZDNTburKjCrilgYLM8o1Cgf55zOp5SyuMohATP88D+1p8oDY3
         QoIBPiNyELe1l8s/+mhLwro4zdxuSWo7HF7Vz15o+PX1Wht69PY/8bv6M4xZsXGwsosd
         LoEWRbXP2/PfBrbSu25tyUi+8FJtzqeS1s8hoELNJI7j7NDim2EhUR6+czjC6v+ESEQW
         eU7wd5tC5nO+D3X9EI0BMQZPkCYxyet01tI6vxVFm38q1WM+3B0EU5ANIYGnHlEWywqt
         8yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931278; x=1745536078;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaI5u9A1ZK2E6Bx2qH0e5jW/HFuv3lmW4guRFbw3gqw=;
        b=uoXYq13nQUpHEHpyTBIksR7KnmgrKkhiuocjUOvHoVzXhNiOz41oqRlZYSwACcdURE
         +CEr92siEGn7toeWDg6imrwKpzvHtutudha0pZAnE452+a5LyvinItZG37gn9JxrCH3O
         82lu2nKH0SdImSgDLSv9U2HQCP35slKOq+hn5MpggnAq86Hn19F4MDK6Ynbno+ml7VCo
         WYORLAqhBXl4Bil8Q6pWY9fEqFduvQ+3S0I56E8sHUb34Kow5vLfU3Pi1HoG7TzLqG3g
         ermHzweVSG2Ry11w/YsiHiGtXvE+FLNrW/+seOqQkzQUGiMFSkbOwXCLEyuJYInrAvnD
         tF8g==
X-Forwarded-Encrypted: i=1; AJvYcCX5hRuBRavhVcvrUQzfDivrHok4zjxeivYWOKCMxJCP+hqaLXS3lT3LmUu19tl7W6cM/Z30aOififBe0bKQmLW5@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTwE03F9mXN7qhaWfPeg5ijPcVK11CpFA3U+J1NR/txiCBHg8
	f+5QPsCQ2c+wHG+THZGhHSyLMbNwMx5P7iVrvNHFJQ3TRaqTOuOGsuhByO/hIpuca2HuV9B8W/G
	Y6SsuKA==
X-Google-Smtp-Source: AGHT+IF4TiTN8mIjFeWYyjcvH+QxpKzHnUuvBCtLoCycCssQ0z2iMetyKW3xvnPKYvVbL7H/8N/Pe+HdGEeN
X-Received: from pjbsf15.prod.google.com ([2002:a17:90b:51cf:b0:2fa:1fac:2695])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a4b:b0:2fe:b774:3ec8
 with SMTP id 98e67ed59e1d1-3087bcc7f59mr819081a91.23.1744931278619; Thu, 17
 Apr 2025 16:07:58 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:23 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-3-irogers@google.com>
Subject: [PATCH v4 02/19] perf map: Constify objdump offset/address conversion APIs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the map argument const as the conversion act won't modify the map
and this allows other callers to use a const struct map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 19 +++++++++++++++----
 tools/perf/util/map.h |  6 +++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d729438b7d65..a22a423792d7 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -514,6 +514,8 @@ void srccode_state_free(struct srccode_state *state)
 	state->line = 0;
 }
 
+static const struct kmap *__map__const_kmap(const struct map *map);
+
 /**
  * map__rip_2objdump - convert symbol start address to objdump address.
  * @map: memory map
@@ -525,9 +527,9 @@ void srccode_state_free(struct srccode_state *state)
  *
  * Return: Address suitable for passing to "objdump --start-address="
  */
-u64 map__rip_2objdump(struct map *map, u64 rip)
+u64 map__rip_2objdump(const struct map *map, u64 rip)
 {
-	struct kmap *kmap = __map__kmap(map);
+	const struct kmap *kmap = __map__const_kmap(map);
 	const struct dso *dso = map__dso(map);
 
 	/*
@@ -570,7 +572,7 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
  *
  * Return: Memory address.
  */
-u64 map__objdump_2mem(struct map *map, u64 ip)
+u64 map__objdump_2mem(const struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
@@ -587,7 +589,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 }
 
 /* convert objdump address to relative address.  (To be removed) */
-u64 map__objdump_2rip(struct map *map, u64 ip)
+u64 map__objdump_2rip(const struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
@@ -619,6 +621,15 @@ struct kmap *__map__kmap(struct map *map)
 	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
 }
 
+static const struct kmap *__map__const_kmap(const struct map *map)
+{
+	const struct dso *dso = map__dso(map);
+
+	if (!dso || !dso__kernel(dso))
+		return NULL;
+	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
+}
+
 struct kmap *map__kmap(struct map *map)
 {
 	struct kmap *kmap = __map__kmap(map);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 4262f5a143be..768501eec70e 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -133,13 +133,13 @@ static inline u64 map__unmap_ip(const struct map *map, u64 ip_or_rip)
 }
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
-u64 map__rip_2objdump(struct map *map, u64 rip);
+u64 map__rip_2objdump(const struct map *map, u64 rip);
 
 /* objdump address -> memory address */
-u64 map__objdump_2mem(struct map *map, u64 ip);
+u64 map__objdump_2mem(const struct map *map, u64 ip);
 
 /* objdump address -> rip */
-u64 map__objdump_2rip(struct map *map, u64 ip);
+u64 map__objdump_2rip(const struct map *map, u64 ip);
 
 struct symbol;
 struct thread;
-- 
2.49.0.805.g082f7c87e0-goog

