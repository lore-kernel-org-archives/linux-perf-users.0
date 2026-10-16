Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC4599A5C
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171926; cv=none; b=ImWlROPYuAJFmceO6axFO4dYXPjA2h1N2dD4lTtQw31AemSvVkAvNG+JZhOkJeTk8XF0kW1xv2YCbGdyj9JzLnBHIuhoy0pPp1CyISaKqCC7SVk4XcIOsR4fdq5YEJ3K3Ls/ZH9x4M644yH7aWnoZUFB9yIY4fyoqBOL/ZYSayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171926; c=relaxed/simple;
	bh=CCjXTNqHT89zyONIcSR+OwfqIxnWIP+Ljxt3b+OKT+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e/mDZLTps+4bVt/OxKj98/0NBCXrw4wQSwft7dZFmXsipsG468D2VTJGGKoSIvu7HRjW0pR1n9gwuQRC/PwKWRSTGPn9XP3EHc6NQtlA1BDg9dIGYdE13Jw2lCCy371p+byWrnUsxkjtbkcMz+8sP7eB3sKdVNnKXLVkQUFWEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAszSJ9Z; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAszSJ9Z"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso232138c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171921; x=1792776721; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUulpA5j+azs4E3npojsUIbJgcVsNwHBau6Ow0JhWuo=;
        b=GAszSJ9ZhQGEPAD/dCALi+xAFupEd1k3i8ebXO4tSRlvA3sjpBB16d5sERkewoqYQO
         KT+7jV+/oD/K7T87mUq4Y69J6V+X2V/wmA80f3h/dCszdE1JPVxzpjLNqM/8WADE+XLI
         HiZMB1vf/twU8S1DtOXcWD5BzTFtkbhscNiNyFRws6IDV8xk5ZZXJi2Dgf0ZddG4jEO8
         V42fIa2UpO4X2IgH8p+GhcN8ckPJZmgBQO1qUW535FE+sHCVL48+cApO8r3NAMu1QYiI
         ueV1xukGuVU/DFFF2iA84KvzBWvtF0HKqXYL95s4DvAnJNvfPC5FMaST5SLbdeh8bGrL
         gPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171921; x=1792776721;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUulpA5j+azs4E3npojsUIbJgcVsNwHBau6Ow0JhWuo=;
        b=madAni5BLLvpAvinuO3kEP5bRi5nS2AVEOsgSx1+kNgfKkAi5SuIbcwECZBAd2wbll
         BxgfIucTJJ1P5BZaV6MhkqnQWa4Ja2/8/lpwQt8D+81+YnfZkSDmxzpu/ffcrP2GWoSJ
         zsIrG6y1EnYl0YAEF4ylC7V9OZtXJcvvDEnUHrXsnN6dvMhwYqKWiQj9LaHk+ydLPZks
         tKZcNTf0aIWO9yBQdbGhcc81UMuYplrcOQqWYy2fvi0JaNYaFU7tmpz/mUt6ZL7mXIzL
         mXNbokG1JR+H4cA0X6egzsGpLRbLBr5VbPS1OfyNylGGwe9VaQzqbXDdG47Xo0sHMUQE
         0JoA==
X-Forwarded-Encrypted: i=1; AKwUvBxmIKXyno5UYzoy49IgU9Ph1vn0ZWGokciD9cIWla9ybBf1Gh/kByS5ZMY8SsDMiUzQ9xW1E+PdW95XL2F1aF/R@vger.kernel.org
X-Gm-Message-State: AFq9FYJuIT9CK2zSLVSYEYmek67DYcZ2BpZjPFHudyqKugZtOxpnw7kZ
	hD5urR/i9l4nx/0pSFvn8MNHy2VEjXOWls5rQEQQQBsFD6XdtNfXGvW115oJ+oUgpPhTmtRuybF
	SWIRi1dNjmQ==
X-Received: from dlee25.prod.google.com ([2002:a05:7022:6299:b0:144:c124:514e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f01:b0:178:d38c:eafa
 with SMTP id a92af1059eb24-18512579328mr608006c88.21.1792171920582; Fri, 16
 Oct 2026 10:32:00 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:31:05 -0700
In-Reply-To: <20261016173106.679725-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com> <20261016173106.679725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-17-irogers@google.com>
Subject: [PATCH v3 16/17] perf maps: Fix lock inversion in maps__load_first()
 and bounds check in __maps__remove()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In maps__load_first(), take a reference to the first map and drop
maps__lock(maps) before calling map__load() to avoid a read-to-write
self-deadlock when loading kernel maps inserts extra trampoline maps.

In __maps__remove(), check that the index returned by
maps__by_address_index() and maps__by_name_index() is within nr_maps
before indexing and removing the entry, in case a concurrent thread
already removed the map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..c0fccb776bed 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -548,6 +548,8 @@ static void __maps__remove(struct maps *maps, struct map *map)
 
 	/* Slide later mappings over the one to remove */
 	address_idx = maps__by_address_index(maps, map);
+	if (address_idx >= nr_maps)
+		return;
 	map__put(maps_by_address[address_idx]);
 	memmove(&maps_by_address[address_idx],
 		&maps_by_address[address_idx + 1],
@@ -556,10 +558,14 @@ static void __maps__remove(struct maps *maps, struct map *map)
 	if (maps_by_name) {
 		unsigned int name_idx = maps__by_name_index(maps, map);
 
-		map__put(maps_by_name[name_idx]);
-		memmove(&maps_by_name[name_idx],
-			&maps_by_name[name_idx + 1],
-			(nr_maps - name_idx - 1) *  sizeof(*maps_by_name));
+		if (name_idx < nr_maps) {
+			map__put(maps_by_name[name_idx]);
+			memmove(&maps_by_name[name_idx],
+				&maps_by_name[name_idx + 1],
+				(nr_maps - name_idx - 1) * sizeof(*maps_by_name));
+		} else {
+			__maps__free_maps_by_name(maps);
+		}
 	}
 
 	--RC_CHK_ACCESS(maps)->nr_maps;
@@ -1459,10 +1465,15 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
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
2.56.0.212.g129ede20d9-goog

