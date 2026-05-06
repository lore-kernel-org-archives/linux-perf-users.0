Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1524336D
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028364; cv=none; b=BIoz26VxphEDf5zGIKIRogsFfGWTOs5tLqIqO3jbQdhZ+Z8lJgwGOz/XoiX4uJzuzqc27K37uvjpnisl0p+1V+xfznuLp7rPYFVzP9f+qDAwi9fpfzRf/I+qgkDgz7WoHS9cdOhm84Ke29UMuUcWfzBGIimV+vR79c9myyHvdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028364; c=relaxed/simple;
	bh=K0v5k7ohAIGp1ovP6WBrlQf0O1Cj4kRGfYBqP+FfH8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dbkNEB3Lm6+PZTIzn9gaf8aOt9ojxUireRQy7txtlxCt6j5qNL+JwYndv6njw/Ado/hXdOh9MYURG7VWgQLXcTFuAJYonXLcODvgsyphFlPVTOs7UqCp22nbNp5zu9O2r/SDbMldyHyLHGwstv6gCWGg9iwihY9gB1zX1VgriNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnSMI6MR; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnSMI6MR"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1320f2754d0so17373c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778028363; x=1778633163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9l04Nhv68ISYgUcRIyEzfbm9pU+jEiwpVxMxGUMc6pQ=;
        b=OnSMI6MRwVK2gbfkYW2Uk3IjF1aozLWQ9r4tnrKQo7LHHYFrYSDlyKl5i93zVNTqyH
         L56MRmZ2ydfbR/XpfaLvYBAFgADDOIjKz6z9Ijzr7q65hp+9KpXHOy9KsGoBwHnrQhSl
         q7/8Y6rkreGPAT0LrJuGHYtco/M4X5uVy811Jn5/VZIRo/G6ynwNwUQdQt9LyyjU9QJL
         qurqHqxSIO/P78YWGLhZwqoaXPDlG5PtijRNfmR2s0ksJZfWGKKyBFW/SH5uONPGESan
         u/prnkiU1GD+biOnKxgn5rgAmeJOyv+jynJT3G1SF47v+7Pherkk1PMvv5bPdxO/HW/t
         uHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028363; x=1778633163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9l04Nhv68ISYgUcRIyEzfbm9pU+jEiwpVxMxGUMc6pQ=;
        b=VBMXhONywaMaRZTjxl2ON3yxeqbPUkKUFwBA1wl6bHgXuaHD0gm4/3DC8VXfO0jIli
         t4i+JIO7LjOeK68zietwmiLKoPh6KndqZTD5KRE6atF3Ar9ZCVO86WQElHBRwHVsk8pf
         snRrbI6RQ23PSpvrN7IaOv4J1S+DAhczlxt6TclgY9hitxmxS0xPjoZXPl5vLwRWiOQX
         TG3g3sXtfr9FxY2zSU4h2kXcxo3WostUh+z2CKSYOcKdOrylTgcTvWxZpMm4IxwfpFnd
         Zdy402hvOPW1rKNLZ2ulf5wi6touZT1nDgQoOZAkQJ0AEKJRv7x9Uk2Bfg6YeS3RRt+G
         buyw==
X-Forwarded-Encrypted: i=1; AFNElJ9zdIAxQ94L+bGB9Bxp2PEdvGdtEY1E78o894kiKRrSzCY+7zgQ9P36GlNwfVgoDQE/DsKi0BfGYPxc1k81lk+O@vger.kernel.org
X-Gm-Message-State: AOJu0YwCkjjxJIT5+XDYmORQDKVWykRprfPTd0VNjvWpRHiJMQdbWKxS
	ZbVTbagbRnARc+2QaOoRGPcuz2royiVty9vA/ocZ3XM3dYiV9E28F3Zajr8lTmFrH5WZZxs8P6M
	dq3MiGDVLWA==
X-Received: from dleb2-n1.prod.google.com ([2002:a05:701b:4242:10b0:12c:5db:d6d1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:698b:b0:12d:e126:b7c8
 with SMTP id a92af1059eb24-131965c2123mr723864c88.13.1778028362570; Tue, 05
 May 2026 17:46:02 -0700 (PDT)
Date: Tue,  5 May 2026 17:45:44 -0700
In-Reply-To: <20260506004546.3140141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504072937.2103453-1-irogers@google.com> <20260506004546.3140141-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506004546.3140141-4-irogers@google.com>
Subject: [PATCH v5 3/5] perf symbols: Fix map removal sequence inside dso__process_kernel_symbol()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When parsing vmlinux ELF binary symbols, dso__process_kernel_symbol()
mutates the map's start address key fields in place before executing
maps__remove(). This forces maps__by_address_index() to look up the
new mutated address range via strict binary search inside an array
interval that was ordered using the old unmutated boundaries, leading
to a bsearch() mismatch failure and leaking maps index errors.

Fix this natively by executing maps__remove() before mutating the
map fields in place, ensuring binary search maps queries always locate
and extract target elements flawlessly.

Fixes: 39b12f781271 ("perf tools: Make it possible to read object code from vmlinux")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7afa8a117139..f31d481a8627 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1372,20 +1372,31 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 */
 		if (*remap_kernel && dso__kernel(dso) && !kmodule) {
 			*remap_kernel = false;
-			map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
-			map__set_end(map, map__start(map) + shdr->sh_size);
-			map__set_pgoff(map, shdr->sh_offset);
-			map__set_mapping_type(map, MAPPING_TYPE__DSO);
-			/* Ensure maps are correctly ordered */
+			/*
+			 * If the map is tracking inside the kmaps cache list array, we
+			 * MUST remove it before mutating its virtual address key fields
+			 * in place. Otherwise, downstream binary search lookups (bsearch)
+			 * will search for mutated keys inside an array sorted under old
+			 * invariants, causing indexing desynchronization faults.
+			 */
 			if (kmaps) {
 				int err;
 				struct map *tmp = map__get(map);
 
 				maps__remove(kmaps, map);
+				map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
+				map__set_end(map, map__start(map) + shdr->sh_size);
+				map__set_pgoff(map, shdr->sh_offset);
+				map__set_mapping_type(map, MAPPING_TYPE__DSO);
 				err = maps__insert(kmaps, map);
 				map__put(tmp);
 				if (err)
 					return err;
+			} else {
+				map__set_start(map, shdr->sh_addr + ref_reloc(kmap));
+				map__set_end(map, map__start(map) + shdr->sh_size);
+				map__set_pgoff(map, shdr->sh_offset);
+				map__set_mapping_type(map, MAPPING_TYPE__DSO);
 			}
 		}
 
-- 
2.54.0.545.g6539524ca2-goog

