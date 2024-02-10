Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A89208A8
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Feb 2024 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535088; cv=none; b=P3Fg8+crBu/BzuiN/8JHbu8dv/F6S5oJQtEONV4XcIXmszwjHNFiR1FSV+yG4l9vfWXn0+DDyFLuVmIsfQfTAG1GIEWD0ZoXHqo+MmO2oWz9tslvEWnDzxN8axA1VKpjuwuoe3Wc/ALNshjMAdkDoyLL2e7REvyFSXf3y/IQ4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535088; c=relaxed/simple;
	bh=NlbGPHUjvYPN2VcnjTROsgfVOvtX5wfc2jhlMdVGruM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZtmpE6QBbVXedOub5gb1XXPuOA985MnXVfoNHd7ZhTV04mh1YJuic/DxbP6Dg2g0pRnjdZlOUzjDScIdldrheoksy2rk21k6KSWje2OUBZNEQ9/Okm2lkuNr1uwDKtLJqNkblgmzL64buS62XPRgEPNkJ5jQ0qswYaqILz01EHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnYdjP3H; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnYdjP3H"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ecfd153ccfso33084887b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 19:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707535085; x=1708139885; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCmA44GmuSEQ6KR355fhhypmUscD3id2lD2Aj801jbU=;
        b=ZnYdjP3HtTkPU+JzmqOwUWgjDDX8DA/CozgrchtAixilebiDQGVKBnXI9Ji17tUQ2r
         g/SQFMyiDWjZaXi6VHnsIBKSWiy4Oj9aw5/FgDgfAVbDl3HkJ5mfZuNBogE1lb6Idg2+
         9jjfqLMhIzaeT4bgKjpXe9Hx+KL1B9DB6tplU1O+9OqZOABB/Fc6AZxpeJ/+/PJBWtjY
         tSa4i77a/+wplygoZ9OQuJ64g/QA1j4fYIdtUJioTkML3VUYHMTXkgky8DuBNoiUXJXV
         EMYlSal2aiF+SxqLzadbqLo6eQPvsIMigVgWUr3sItk9OJy6HI2xM0YCG7HP8TQnbes/
         tdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707535085; x=1708139885;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCmA44GmuSEQ6KR355fhhypmUscD3id2lD2Aj801jbU=;
        b=pGtYxNIf79r4BoWAc3rQGle/B+r7ArRhHxiBe/PE7/i3DMcXlL/gNtpj9b9FbYedMk
         aiq2hOC4qLITcm/iB0FSN+i4EQMLLqkgLt5AslGukKUmzsCiHk9eVcH0cR/5YLSd3pJ6
         AFPUKdtlI5mWZTWFmFY6enbEmmtp0l1RFGYQn6iYeUHPvju5/9gtBRdwkxiKtxbXu1nu
         OpDUFp4xrevSP9WwjIUeSzW8g8uf0wOHhem0xie2cH9UyEzUX37DBxePtml59oYZQelW
         26gvTM9dtF/bcex1c00iZfc8DIlBIpJey8zpGopeNNpwVDhWt4pt1uAtuq93Y2vwx3W7
         Lw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoxxibMxhsVGY4UikFcWS/IaZb6vcsr2t7yzrV/bBljqXsH5L8ebl6G8oWkdi9f6F8Qu1Q0dec7O7QcBlrJlNAskwttr2Y5y4+26aTlx+x2A==
X-Gm-Message-State: AOJu0Ywu5z2b4slt4Q13kEy5nJG80DA8UPlyqPNp68m3pZpEyXhDXN5d
	iYOl1dsaq8MaKvbd51FSYxP3KQzH0NnLTx99518dfUwQ1hsVt2Ow+Hb97atLBIURWpmlfl7Uv+y
	bNHwx/w==
X-Google-Smtp-Source: AGHT+IE+Fj4pzKGvpjOG4c0i+qY8ApmS6WRhnUjNga2NlY4vxZvK+caBXOIKF5xvEAVx8bP8oFyl7nh+BLe1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a25:ce05:0:b0:dc7:31f3:9f98 with SMTP id
 x5-20020a25ce05000000b00dc731f39f98mr241172ybe.9.1707535085769; Fri, 09 Feb
 2024 19:18:05 -0800 (PST)
Date: Fri,  9 Feb 2024 19:17:44 -0800
In-Reply-To: <20240210031746.4057262-1-irogers@google.com>
Message-Id: <20240210031746.4057262-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 4/6] perf maps: Get map before returning in maps__find_next_entry
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 4 +++-
 tools/perf/util/maps.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7031f6fddcae..4911734411b5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1761,8 +1761,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
 							 machine__kernel_map(machine));
 
-		if (next)
+		if (next) {
 			machine__set_kernel_mmap(machine, start, map__start(next));
+			map__put(next);
+		}
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index ea8fa684e8c6..df0c8041899e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -962,7 +962,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.687.g38aa6559b0-goog

