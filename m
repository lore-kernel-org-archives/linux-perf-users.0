Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C11E8338
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684323; cv=none; b=ISsPQ6priDji8qYgHx1iJ+L4i2yY12xGtokZrmcsuEkG/9K4VgWFtEgEzbtapbzsTeJb99+QqS+pkyiD58gOeCGdZW29R11mNfP556bcVFwK01/cqiJ/6Ns0YJ3ioUbl2tKxz2f1dIbJ7gLFeb7loDgM7EBVGRpS0yZ63eh2GcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684323; c=relaxed/simple;
	bh=moBbk0e4zwG56wqQUF81dVts+MTk1ZzL4lCGN3wIn8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VpfnHkT4SPi/JlvgS+dSIdTqAQE3X5ziMMbMU29ZnDrgt6QxLd8jczNUbbs9KBUE3tyJRkfqwybqtWbXq1UvWN2d6X35eJi3JsE1eIrnIYlgTjIfK3L1UX35jmE6PHUKZdL2lLLU0OzLQXQ/FR5cqwga/jEFlDLiHo9ozo8iJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJETqKNP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJETqKNP"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e0fee541so2757218a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747684321; x=1748289121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLEswg+2ZvrVLuaVvJaBqbKOECqngCDtBESlmPXVj5E=;
        b=NJETqKNP8/5/a9EMxvxtiUaJmWDegkDzzfPbEZI4DXFm608qlg9J99HvvSU+YcrxCx
         Z0IQkqHcuZRWgPSKs5L59cVwXQ79e57zYNfDz8J8cXcKUTgPwvUl+B3Uer/Am8PRxfiM
         bWmIqkQ8PJUjyqckxfMSLdY9YnENISuW2PSWpLWqPMhQhO3yfbhfnyTU0H73d+veOCXF
         CuP1hPOLKEnsjymUrSzl+43VkNFn9Yw2YPriYjhd0VGR65T/Z1EztrAbkwYMsiKxDtt6
         SlsEAl3kVhKsSeVPy9Yd1ydA9vzABhyzMdGmUvMdEzqAxP83frxrb1g0NzGsFFrJGHRr
         063Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684321; x=1748289121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLEswg+2ZvrVLuaVvJaBqbKOECqngCDtBESlmPXVj5E=;
        b=B4nVwu0V6xy8gfoNsm59mKGexM5ysCa7Arred/QbeiWfq+csrRWYdsKOR0eDJAfSsH
         EjhhmHNMg4M443jmS8D4NGteMJDo8OOT0u0FKrOnL92qHZEpe6OY1BSWv3ALtQxwU2ho
         iD1RLm9l3R2LLO+ZHt4MbQzXdYHYMfcGO285c+IQPNn2dE9YZzjCwaUcby+Q1mc5w+Hj
         WvuGNAScvFMQjxh0B1hGrRYDxeQhFEJpaOxctD8OMTv/dAJ5wsraeX/AGRCO0i50WOWH
         vMRhIKfqDHXw3UDN793ESfoOsmQUCSLv0y5SwBkIPYOnYpz99EZ+kxcjX8GSrsKYcXjD
         gcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeaLAQfUhZlOYNlNV8AkvNuotveaa0BTx/YxW0keDHUbQseyheAx8npWqhC3oI9pS7C6LGoHLJUvVZ1qeN7MQP@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDq8aXuQ2zlD1pYY5D6fJxUdROxU1bq43Q9iNAo1AGA7v3+E/
	UE4fj9vhG+431xJAAw151xbuv27SLfvm921v1Qi7n8E19cUnbsJtIgdp39NsfmwG5TLj1PTw08y
	G1qZ0OpqrwQ==
X-Google-Smtp-Source: AGHT+IGiY7OLM1UzxicQml+gH+PtRzbE8+fqCyt/LZBKRCSiwh5xxuwG513k9Tf7aNUBoQ3RvzqhqxPjjUnf
X-Received: from plbma15.prod.google.com ([2002:a17:903:94f:b0:22e:4a61:5545])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1988:b0:21b:d2b6:ca7f
 with SMTP id d9443c01a7336-231de3ada46mr178538855ad.32.1747684321434; Mon, 19
 May 2025 12:52:01 -0700 (PDT)
Date: Mon, 19 May 2025 12:51:38 -0700
In-Reply-To: <20250519195148.1708988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519195148.1708988-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519195148.1708988-2-irogers@google.com>
Subject: [PATCH v3 1/7] libperf threadmap: Don't segv for index 0 for the NULL perf_thread_map
From: Ian Rogers <irogers@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

perf_thread_map__nr returns length 1 if the perf_thread_map is NULL,
meaning index 0 is valid. When perf_thread_map__pid of index 0 is read
then return the expected "any" -1 value. Assert this is only done for
index 0.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/threadmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index 07968f3ea093..3ca9ba4987fc 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -97,5 +97,10 @@ int perf_thread_map__nr(struct perf_thread_map *threads)
 
 pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx)
 {
+	if (!map) {
+		assert(idx == 0);
+		return -1;
+	}
+
 	return map->map[idx].pid;
 }
-- 
2.49.0.1101.gccaa498523-goog

