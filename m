Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5B768E9
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Feb 2024 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190416; cv=none; b=mh/m93VhvzCCOCgVBx+PAGwKTm+6xGlPkWtM5xVkMvD5CAfmeuHpSuZz+G6wVwrAV+2mmXE2hGZ24/hyeX7/zMEswFT2HhsWyj4pxAaqwXrj6bqy3UGESGLNQhsmFPouJ4pVRcX4jmpipETe0wkfUTlz31ESWWQxVl8LHTZomAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190416; c=relaxed/simple;
	bh=5X1qsUi3skYX0+XJLWX/k8pq64P7f+cfj6l98r2VoJ8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ARjXMTYilSkxXf7xjs4UM15EPe+obBIJu2BBxznLdXcP9ofTLmEgUOh5b1s46w2pnTP9WMA3rWQcqFvxrbSABl64+LinzU73UENxx4LziX9wsvHYf1He//tFRWzscOpK8Aebig5z2KLwmDmLh8d5EnF05xuJSZUwM3irKKTwzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZ7AdCqI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZ7AdCqI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047a047f4cso6110697b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Feb 2024 19:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707190413; x=1707795213; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5pESXQDW6zysG3DCALcAImBiyx5FS+UI74K+BRnd8=;
        b=DZ7AdCqIW4SN2p0fFMDtzJZsQtPSR2SW8mD/U+JILSftqL8rvTaRyvTFmtXRpk77+0
         usH3CaZILv3zi/4R5iZVfOOhJxmPYOKS/vbTefJmT1DdLWWLfXGUHHoB1CuUUjgqM61D
         SqywKLyd2ja6OT/OzJHMBpUJBWGAmniBKa+5Na0NvS9OwH2jnDHH2pnR5GasxDGYA3EX
         uJZ/HkhrRS5HhPQ4xQbY3xzjSYbds2vSuM2b5+3S06KwcCTjh2iK0uKKquTq5yme3OA2
         Iw9Mm5nnfyj2nQ+4PXEmMhcnAZuDuABnUeURZj+EaZYfO7sf33krKCNFTxPrEg+RrVV6
         Wj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190413; x=1707795213;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5pESXQDW6zysG3DCALcAImBiyx5FS+UI74K+BRnd8=;
        b=UXL4T4n7GUcY7GmGHpgbQzaQhyg6vCZvTPAFn57fWPc/F0pQ1T/MgIds3OzsDcIKyu
         xeFktnVC/LxJ9wsG2waYKne5bcuhtZqm/3zuNfxmMF4YVfLkb29SJsLwFjdeU/raeKaf
         YJ13JBJ2qhzEnaylbMl4xlesXHzwBGNr2SAGvVQGsYWMX3p42o3Fgq8oKv54Ele4oUng
         ojAutuPvAylIHEJJiNrjm1yQe9z+Jrhwu3VMXHwnn4TxAI79brJdxyw1gdbn/sjotLJw
         BfjaaGNE5gcpiRR3BQy/yktHM6804RLoLWN2Q+3FvoOzDg2U5/WzUpPvy35L7qxH6yy3
         6y5w==
X-Gm-Message-State: AOJu0YwdmfhHYt/xe2hj7sl59sEYdWjdFh34q10kwjhEF2v2Tbni1Dew
	rE7Se30xq9mP/E1wL8ZcF+ydMC/spMe7heOGZZ4DYj7ardbLCAJq561YKOKbMQuHE0f4nvTku55
	xKk0s0w==
X-Google-Smtp-Source: AGHT+IEVrQzvef2PB8ocQh4oMNlAgaBdn57OMhZd6HACfNXpfG2wAAU0mWAbGbzOYfUhhHLOFL/kwhqvK7Iv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:6902:2785:b0:dc6:dfc6:4207 with SMTP
 id eb5-20020a056902278500b00dc6dfc64207mr113515ybb.10.1707190413407; Mon, 05
 Feb 2024 19:33:33 -0800 (PST)
Date: Mon,  5 Feb 2024 19:33:18 -0800
In-Reply-To: <20240206033320.2657716-1-irogers@google.com>
Message-Id: <20240206033320.2657716-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206033320.2657716-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 4/6] perf maps: Get map before returning in maps__find_next_entry
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, liuwenyu <liuwenyu7@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
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
index f4855e2bfd6e..e577909456be 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -956,7 +956,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.594.gd9cf4e227d-goog

