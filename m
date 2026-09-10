Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615D42900A
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074773; cv=none; b=TqPmR0EGn3kTNMWtzBuhrAiIDLuhNLQ/ocYPKrnGXxlgAcGw26mAhrPJ5yjGjJ2FjnB8l4U28GkFy6itEjpfXqBsjwLayq+9ojQtNEtfTSno+iKKnSBDdfPtBh/8PF20vjzZi9mfvfLg4qBnRX9tatgy1eS8hD2f2DnPYtihxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074773; c=relaxed/simple;
	bh=fJ+aO3P5RIRWxVwd58geKjoPWlLgqh9u4SLJ00UGSTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Yn4oTsOE+W21QAalT1LRXI2aUHAsxbunS6zsumC7Mo0P80cU0dpVfspm+8NQ5eZDXqzbO5IVbhw/X5Z3E4pAt2SXzGfteMLKsu6qHUsVDivvDjEoDaW0+2hqWuDB58N0fUfqeaa+9lnle5c7zzTtsOkvVS2JChD9zI/m/8mlVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jtl5+xMO; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jtl5+xMO"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39af92138f9so413045a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789074759; x=1789679559; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eu4tcgV+KEQyHj+vflBVWyTo2dzh8uAlVTzpcsVpWHo=;
        b=Jtl5+xMOAJYUwq+0arPrRc/927pVR5r10tuKmd3e7qVi4awbE0GSuSepw9knweHJwR
         pi+IHTd6rUdbW0zZfT/bb7oxOwwCNWoQ/Jf//U17oCVCRIRXnXtdA7oO7nzjQGBkxR+n
         jmrjP7Et5jrkyGJTKC4FRZF6Rhc6IkrNxTMU9PTJxcOr49LJkYUwRK3rhjJNIIeG8HZ/
         TcajIpYZShZBplNt690W7jlSBey+/rtlUQ5YXY/DiWJIwKXxUJHxUp1QCFOz4S/dve6E
         L2kHUZGTbNzC7lfmZU1fOkhhsOozbUHBV10ocOsmugrLeR9Lp0wmTJoTdxNESQUBG5Wg
         d6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074759; x=1789679559;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eu4tcgV+KEQyHj+vflBVWyTo2dzh8uAlVTzpcsVpWHo=;
        b=acFc5Sz+E/AIRWcmik0p3X0JRIKFl5IQ4vneTojHGHvZxSGJfvrm4wYiB0HDubZI8c
         z1wPRhA82S8jyz6Vb2HtQYtA1zOH+ouj9lXW3SEgiOALc0M2RqQmmcN2YoBBDYeLqY5F
         5h4vwLAkcODtuWVLtTpIDkHSZfWLU0WKSJcjfiPsalt8CKp1UEkdWYm7hUtGRrFtPmGP
         DJxzmnAu/NZDNT3x6Jikw8fp28DNCToEvpJ/7azgCCBxeyhsDirkqQ5+C2cP70AbKZEw
         cW/xHgFBQrOEaCXASAyP6G/sgoNgikybfY1lcN64j97dlxicR7WvnYY54neQ8am6xnfe
         NpPA==
X-Forwarded-Encrypted: i=1; AKwUvByoR6jNz/oyauFw4posiHoBmN2zEJ1xfjBp2pCQSc4dNnjdaP4vjBKgJz+qVlZeOshpU1O6XSfl5+koAYXMHC5h@vger.kernel.org
X-Gm-Message-State: AFuF++ldHXquAXniU9vjStfoxnXyMTy4t6f0bwqXZBsitXyH6VgPS3+3
	9q0fzyoamb68dXPKQyo6m7a9wXars9FEVyB+ysJzBwm4EHPu8xdGVmAyYgTIOc6u4aS4uCkRIBc
	YGqSZ0wBxig==
X-Received: from dlbuy19.prod.google.com ([2002:a05:7022:1e13:b0:142:d9a6:93e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0d:b0:38e:6d55:b1a6
 with SMTP id 98e67ed59e1d1-39d97ea0248mr1131117a91.3.1789074759098; Thu, 10
 Sep 2026 14:12:39 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:12:19 -0700
In-Reply-To: <20260910211221.3154261-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910175634.3014018-1-irogers@google.com> <20260910211221.3154261-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910211221.3154261-3-irogers@google.com>
Subject: [PATCH v3 2/3] perf header: Fix potential memory corruption in cpu_cache_level__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

strim may advance the pointer assigned to cache->size which causes
later frees to crash. Fix by performing the strim and then memmove-ing
the potentially shifted string back over the original string. The bug
was introduced by the transition from rtrim to strim, as rtrim
wouldn't move on the left.

Fixes: 13c230ab6e56 ("perf tools: Ditch rtrim(), use strim() from tools/lib")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/header.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 974ce1c926cd..0a4236fc0293 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1268,7 +1268,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 		return -1;
 
 	cache->type[len] = 0;
-	cache->type = strim(cache->type);
+	{
+		char *trimmed = strim(cache->type);
+
+		memmove(cache->type, trimmed, strlen(trimmed) + 1);
+	}
 
 	scnprintf(file, PATH_MAX, "%s/size", path);
 	if (sysfs__read_str(file, &cache->size, &len)) {
@@ -1277,7 +1281,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	}
 
 	cache->size[len] = 0;
-	cache->size = strim(cache->size);
+	{
+		char *trimmed = strim(cache->size);
+
+		memmove(cache->size, trimmed, strlen(trimmed) + 1);
+	}
 
 	scnprintf(file, PATH_MAX, "%s/shared_cpu_list", path);
 	if (sysfs__read_str(file, &cache->map, &len)) {
@@ -1287,7 +1295,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	}
 
 	cache->map[len] = 0;
-	cache->map = strim(cache->map);
+	{
+		char *trimmed = strim(cache->map);
+
+		memmove(cache->map, trimmed, strlen(trimmed) + 1);
+	}
 	return 0;
 }
 
-- 
2.55.0.1007.g17ff1f9808-goog

