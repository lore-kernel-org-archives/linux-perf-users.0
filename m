Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32263019BA
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452693; cv=none; b=KiZTJN90P2gGdhY+t6EeokofaWF6NYuwDeQxkce5hM/RSalbA2tuFYWoWQu5svwy7aVGY/UL64T8jNLeVV1vtYRDz07EVjXc2nc2n8+YAIsgq21V+Gz2s4ymFQ9k1TrCVr5Qiu5paXrNqZRwYkRjsBWc7DEb8DFVPC2QSSlFEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452693; c=relaxed/simple;
	bh=rH5/T6FT365KFZmlKnO8FVcvnpa30Sdy8DDRsLNiNPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cbD3m252O5Nb5PPy3DU483UWTcUvc3xANoQfOAEVWm1coHbg97mUPm4r/O385wGedUDZdzBYIJXvH+/SXXpBOzqCEfm90xSZ7MUE2JAKNxQ87mZxVmyLJvQFcH929icgpoy023gcGRW/ezgvGlNVOBR2C7E3CijD3ZzA0/D+YeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tur3aFjv; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tur3aFjv"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124627fc58dso5171839c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 00:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770452693; x=1771057493; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7d6a//qLSGe67LfY/IQ7qyHIlWhv3Mm2rhpPsBvuHso=;
        b=tur3aFjviSYOuDgvGlfi203e6LyqHbaXXWjwOlR9Tt0mFOFmoL80sP+FNFADeEPYXm
         KOiwl8C4ZKKCD+NulodA6wyf7dFwZHxlIeXSsqM8fUIzjfint/XM9ABDKrS6URCHZhWD
         2DiHcepKwhJ5fx6Aeuoy6xK+EGJPrCmcE9rhTL4lcaFvQD6/hjwntz6XeU7AjalFLFGv
         3CWKX12HnKZynZRGP3ziGc7B0DCaYiusmNWYlhw8KT9z7PtODri6oPs9H0WZPFw14JEO
         cFMkzy566QWeTE/FEdyCMD4g+uw+CrPL8CBKazae79syTrYjqcgpzISQSWwwo4OOPp8+
         c/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770452693; x=1771057493;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d6a//qLSGe67LfY/IQ7qyHIlWhv3Mm2rhpPsBvuHso=;
        b=cpkMsU4U+4Lvz5evAqZeRefvrG+OlFt/4qT7TuAI1DMpM41iZiMoERXKnT4MP4OX76
         +IwB6eUNHIs0umqPHy16j5JmyKXz9rbWkqzUoUQYcs72iL2ijc2icLHnzWbNBGg14gr0
         sXy0d/o2dGsUgGwzGHrji1JOW3MsCJdQ82g4GjGtNMAsxVRog4HGVluLned6hiWSJXOZ
         1YRqVo5NLqK0Gx6Vo53GgA3TjIfRGSHlFfAHFykRGTrMllrERKwwWLn4z9ldAErHY1kL
         vfkG4sTLYAstiRpYsErvUvQbOtwBtlKHDGufvPnYKSPoBMG34IExXTNMIk2uaQZdw5TG
         SGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRlWSv9XLh4mGGdL714rW+egw9/zUUkK3bUkotgLWTN3II0ElubOaskNWPh8tPJPQI6N1Fy2xxTEGQVpCy7hBr@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbTlXFDBTHimpTYXm+NksuGRl/JXleimkrXILDynl4rMHFg6Q
	HKVTyTspOy26FaooVbys5CMvrUxSE4XMK3A2M5H+E5c1feSs5+eAjad3TQW6WIThiM+RaDXR40Y
	9yNa+VPCqDQ==
X-Received: from dlbpk3.prod.google.com ([2002:a05:7022:3843:b0:11b:d8a1:4048])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1b0b:b0:127:c88:d597
 with SMTP id a92af1059eb24-1270c88da04mr1886807c88.10.1770452693030; Sat, 07
 Feb 2026 00:24:53 -0800 (PST)
Date: Sat,  7 Feb 2026 00:24:27 -0800
In-Reply-To: <20260207082428.1742209-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207082428.1742209-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260207082428.1742209-5-irogers@google.com>
Subject: [PATCH v1 4/5] perf bpf_map: Remove unused code
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_map__fprintf is unused so delete it, the header file declaring it
and the now unused static helper functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c |  1 -
 tools/perf/util/Build      |  1 -
 tools/perf/util/bpf_map.c  | 70 --------------------------------------
 tools/perf/util/bpf_map.h  | 23 -------------
 4 files changed, 95 deletions(-)
 delete mode 100644 tools/perf/util/bpf_map.c
 delete mode 100644 tools/perf/util/bpf_map.h

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 311d9da9896a..2aaa3ff452ac 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -21,7 +21,6 @@
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
 #endif
-#include "util/bpf_map.h"
 #include "util/rlimit.h"
 #include "builtin.h"
 #include "util/cgroup.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 89de23dec401..70cc91d00804 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -170,7 +170,6 @@ perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
 perf-util-y += intel-tpebs.o
 
-perf-util-$(CONFIG_LIBBPF) += bpf_map.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
deleted file mode 100644
index 442f91b4e8e1..000000000000
--- a/tools/perf/util/bpf_map.c
+++ /dev/null
@@ -1,70 +0,0 @@
-// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-#include "util/bpf_map.h"
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <errno.h>
-#include <stdbool.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-static bool bpf_map__is_per_cpu(enum bpf_map_type type)
-{
-	return type == BPF_MAP_TYPE_PERCPU_HASH ||
-	       type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	       type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
-}
-
-static void *bpf_map__alloc_value(const struct bpf_map *map)
-{
-	if (bpf_map__is_per_cpu(bpf_map__type(map)))
-		return malloc(round_up(bpf_map__value_size(map), 8) *
-			      sysconf(_SC_NPROCESSORS_CONF));
-
-	return malloc(bpf_map__value_size(map));
-}
-
-int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
-{
-	void *prev_key = NULL, *key, *value;
-	int fd = bpf_map__fd(map), err;
-	int printed = 0;
-
-	if (fd < 0)
-		return fd;
-
-	err = -ENOMEM;
-	key = malloc(bpf_map__key_size(map));
-	if (key == NULL)
-		goto out;
-
-	value = bpf_map__alloc_value(map);
-	if (value == NULL)
-		goto out_free_key;
-
-	while ((err = bpf_map_get_next_key(fd, prev_key, key) == 0)) {
-		int intkey = *(int *)key;
-
-		if (!bpf_map_lookup_elem(fd, key, value)) {
-			bool boolval = *(bool *)value;
-			if (boolval)
-				printed += fprintf(fp, "[%d] = %d,\n", intkey, boolval);
-		} else {
-			printed += fprintf(fp, "[%d] = ERROR,\n", intkey);
-		}
-
-		prev_key = key;
-	}
-
-	if (err == ENOENT)
-		err = printed;
-
-	free(value);
-out_free_key:
-	free(key);
-out:
-	return err;
-}
diff --git a/tools/perf/util/bpf_map.h b/tools/perf/util/bpf_map.h
deleted file mode 100644
index c2f7c13cba23..000000000000
--- a/tools/perf/util/bpf_map.h
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-#ifndef __PERF_BPF_MAP_H
-#define __PERF_BPF_MAP_H 1
-
-#include <stdio.h>
-struct bpf_map;
-
-#ifdef HAVE_LIBBPF_SUPPORT
-
-int bpf_map__fprintf(struct bpf_map *map, FILE *fp);
-
-#else
-
-#include <linux/compiler.h>
-
-static inline int bpf_map__fprintf(struct bpf_map *map __maybe_unused, FILE *fp __maybe_unused)
-{
-	return 0;
-}
-
-#endif // HAVE_LIBBPF_SUPPORT
-
-#endif // __PERF_BPF_MAP_H
-- 
2.53.0.239.g8d8fc8a987-goog

