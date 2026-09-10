Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4756C62B
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061863; cv=none; b=t0K7lC7DTnmmMoEeIidMj693/bzP8US8EJsNkubuM+WWgNYdChtlETZpb/ufRi2VJany8dLt43hhiA5Oee4b1xJP+Rh41jKN1UN43jgS2RC8Ga42yIz1f8rGBkcUehAgLkbVlmkRHQ10KMN+81iEtw0ocsYa/7n3RLg3LIij5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061863; c=relaxed/simple;
	bh=vaBOM7gJFJP/iDNYbksPS4xPwihltpK6FFy2L5l2j5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZZSbjFAo6TbkK3ZcYIrUjzlvN9r5stJ66mEBYPOTjAU/qwkX0T0QLwUhiPsy0mqh+CtWp9eA+IwuagXDvaiVuADoi/oteF5y/kz7/Al8/9kC3oJW36Lv07nq+oaq22dOs5lGBo6LKywNjZVx9qsTRSmR4jwGT09LC9ORApfb0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTInslN0; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTInslN0"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso14396908a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789061849; x=1789666649; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fnzBeOHTZJ3ZGeQaPHN7X7+9Lkvg1S3DJgXkiyBoNCg=;
        b=BTInslN0zIKtVxAVEapKn9gb3ds+5ceDVUk7v09zZrgLO7yhtPs3YAShKB7ErI6NeR
         tkqDZyqZmQ4AcTXARY+NLWKpVflYW0i6j0tnREo/p2LoeUREZQ+1wZooCt7E5taGU8fp
         Bc3yrwa6LA9y5BRo1net7wPNeZvmjzXvStdTx33SMkYbFTZz9XUH9Be2AIGitjTNYPmU
         Yr944aY+lYuv1XBx/WebXhTbC2whIf24RPtSaszvWs1huWflKJr0MGO5PK5xHj/PFDOQ
         OiaDLthbE5AA0JZ3wG3U7zaJrd2ond2mBRMYjoRv2Tq6s2mD3/KIHdYKPQeuG89SZiDo
         qM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061849; x=1789666649;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnzBeOHTZJ3ZGeQaPHN7X7+9Lkvg1S3DJgXkiyBoNCg=;
        b=FroWCjuHfiTDIvAH4QWOVIAVM/RIpQhd1EgL/Mlxm+pG/sKAPuXXldlGjOKsGnrpPL
         7rYnNTJsJU93G1XqhB2iTsanFsi99TJGlFR5OX155CxjRh/SSMl/7TxhIcOdu2lu7dGC
         RFRugIQx/L7ZmCUPNzHeT/CYxiWMnA9kpUGrhaI3IAKEYfwbTWooL1O2vrGEjoAwPncc
         7SErd8cvCTV8fylgtEdCihIe+WNjLAB18XRMfkum8hI5EgNR6zFD7jQi9WrTduxm4Fz3
         4GqQVZr7SLsp80ymIWYbXUlf0d0N0ZqAJYLHt2W95RcoCG5Ioa88Sc52CHGyCVFs5wqW
         TB4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxl5QiEGR/ylyo85TpBfS8qUE3Z4R9WeHqxqiuMwRmnwjy+TBvUXqKdPEG/aBtqsY29lhH0180xEGNbhI3yy8E7@vger.kernel.org
X-Gm-Message-State: AFuF++nTXVJ98yzbLQKEUG4t4URJYIqTOY45a7TI/MJb37RwUGZCCdUB
	Z5H5UHpDAP0xg1tgEPw85pRTcAQGutxH+5CEr6N62cKdSNqjvJj10r/nT39O4hKEIMYLVbYsysZ
	o9W+/T55v7w==
X-Received: from dlbeg10.prod.google.com ([2002:a05:7022:f8a:b0:143:5f6d:2f6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d45:b0:38f:2168:b9cb
 with SMTP id 98e67ed59e1d1-39bac1d89b4mr20515211a91.9.1789061848826; Thu, 10
 Sep 2026 10:37:28 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:37:14 -0700
In-Reply-To: <20260910173715.2996571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910173715.2996571-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910173715.2996571-2-irogers@google.com>
Subject: [PATCH v1 2/3] perf header: Fix potential memory corruption in cpu_cache_level__read
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
index bdd79d7542ef..78b16a098148 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1267,7 +1267,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
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
@@ -1276,7 +1280,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
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
@@ -1286,7 +1294,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
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

