Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66F2C18A
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873899; cv=none; b=koDBYlIF3EeyLzJEun6eNNcpc5Qwmf+KOaGRRBDgP5qMym9Z901KcZizMz1DDYvLGOXfycod022qYz02CXGoUAXKURDjS/6s8r3uCtZ2Lp5ZmuvZYiFGImYlG3O4Ssgtnu5t55QHx7rpdeWw37XePfhwE81FHCdEY4hsSAHANyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873899; c=relaxed/simple;
	bh=2cGC2IX7m/qq5OqemImtqzbxOfAoC13cZti4xGjvr2M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=COzEbq23+a6DVd7niJq9Z+es/PvXJxnsLnGAvYZHQgZ0AcBIZIA5K8lo76x2aEfwb7l+wkiyCr+2lks65+NPoGqTEOWJft938DZbutypd8VaZxWvH/6GoAk8dP8GkGb5hlMVGRYvjOyir/zZ64P6eXw/+aWsIz9OvewuNXGshCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mh1R1s8S; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mh1R1s8S"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248d9301475so53208415ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873896; x=1758478696; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bi0k3TpX+saOMQswzu6XG0cElzWGEVMTmu4d6zBBHZg=;
        b=mh1R1s8SthdO5u85FADH/UbV87H6cQCdcU8uwuTZrDawsFcTugopwkDcT3Z/Yo214C
         /1cI/zpaCNubGnqMcLJR5AaKUNzYSXAcJD7E8+uiONNCqjM5ZEyK0WMgHYojBTvyrvhC
         m7iRcaTDja7ljzqGtXoEld5THGUggv9Kc90q8N+pWoyN8sarx6prcD+yHzs6XIpjOGLV
         AT0LldVqfmut0cIZTqWkIo8wSX29Nb/wlT06aMvejf5OFt/UQIq/ODoYnM/Y9XzGyzff
         ICal47aNZQI0tpJT6paZcEmxAnoZvuhKYfaPDADCltK3v0Fdt3E874aAVd1zoDptEdao
         FYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873896; x=1758478696;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bi0k3TpX+saOMQswzu6XG0cElzWGEVMTmu4d6zBBHZg=;
        b=va1hUoAomV0GrSiaoR3LfxkMJ2gs3EF5VQl1KhkqqTT1V3+h3D8QNtREh0Yo4IjeHA
         o2myH4kHPoKXczs8OPXkqmloP6ixFu/fgOS8Uj28b96nZBfuA69LrEeUaLNlsuXpETTt
         w7LseLDotFuyakGGW7IqLQ9m5g76yF7ECCmNP1NRZ8ySnTYfmYQgSoeflA2qy9upRotZ
         oo2v8qZudksF6JiX3Y6xI9rpxyPGf3yjcDVC4KQrzwLp6m5OWMPFzdpDHSuiInucql7r
         6Z8H0yuZUK8xUPJ/xbIq5a/76dQFRTHMazksyT+3IO1TwDnE9AhKua6sQCtQliANjc38
         0PMw==
X-Forwarded-Encrypted: i=1; AJvYcCVpGXAcyrGkwjNWxauxD8Dvc3hJS3d6h01sdmLmIFvig1nMmOatWwdUAjOAH+IgIG2tbCOGuBnYJdlvZ77AKQxB@vger.kernel.org
X-Gm-Message-State: AOJu0YyqT0GkU7ymdSgOF1jGlh6W0OU67GGd03wKcXny+TR/p7vuwmuk
	fJsjVhlEAw0IWXSpdiWG7XALVbdBL/mdyOMWWXiQscu97kq91+5mdlXY40YLy6drx5b1ybnfXop
	hA2831gkq7Q==
X-Google-Smtp-Source: AGHT+IHTbTCs1wnw2lFNLVJJ8yhyLkuzjt3S0GvGOyaObENDRkwG86pcQRHmlGQUqT79gvZ1avanwlpjwPix
X-Received: from plei5.prod.google.com ([2002:a17:902:e485:b0:245:f002:d659])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc45:b0:261:1abb:e302
 with SMTP id d9443c01a7336-2611abbf094mr65953605ad.14.1757873895767; Sun, 14
 Sep 2025 11:18:15 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:18:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181808.1957729-1-irogers@google.com>
Subject: [PATCH v1] perf maps: Ensure kmap is set up for all inserts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__maps__fixup_overlap_and_insert may split or directly insert a map,
when doing this the map may need to have a kmap set up for the sake of
the kmaps. The missing kmap set up fails the check_invariants test in
maps, later "Internal error" reports from map__kmap and ultimately
causes segfaults.

Similar fixes were added in commit e0e4e0b8b7fa ("perf maps: Add
missing map__set_kmap_maps() when replacing a kernel map") and commit
25d9c0301d36 ("perf maps: Set the kmaps for newly created/added kernel
maps") but they missed cases. To try to reduce the risk of this,
update the kmap directly following any manual insert. This identified
another problem in maps__copy_from.

Fixes: e0e4e0b8b7fa ("perf maps: Add missing map__set_kmap_maps() when replacing a kernel map")
Fixes: 25d9c0301d36 ("perf maps: Set the kmaps for newly created/added kernel maps")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 85b2a93a59ac..779f6230130a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -477,6 +477,7 @@ static int __maps__insert(struct maps *maps, struct map *new)
 	}
 	/* Insert the value at the end. */
 	maps_by_address[nr_maps] = map__get(new);
+	map__set_kmap_maps(new, maps);
 	if (maps_by_name)
 		maps_by_name[nr_maps] = map__get(new);
 
@@ -502,8 +503,6 @@ static int __maps__insert(struct maps *maps, struct map *new)
 	if (map__end(new) < map__start(new))
 		RC_CHK_ACCESS(maps)->ends_broken = true;
 
-	map__set_kmap_maps(new, maps);
-
 	return 0;
 }
 
@@ -891,6 +890,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 		if (before) {
 			map__put(maps_by_address[i]);
 			maps_by_address[i] = before;
+			map__set_kmap_maps(before, maps);
 
 			if (maps_by_name) {
 				map__put(maps_by_name[ni]);
@@ -918,6 +918,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			 */
 			map__put(maps_by_address[i]);
 			maps_by_address[i] = map__get(new);
+			map__set_kmap_maps(new, maps);
 
 			if (maps_by_name) {
 				map__put(maps_by_name[ni]);
@@ -942,14 +943,13 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				 */
 				map__put(maps_by_address[i]);
 				maps_by_address[i] = map__get(new);
+				map__set_kmap_maps(new, maps);
 
 				if (maps_by_name) {
 					map__put(maps_by_name[ni]);
 					maps_by_name[ni] = map__get(new);
 				}
 
-				map__set_kmap_maps(new, maps);
-
 				check_invariants(maps);
 				return err;
 			}
@@ -1019,6 +1019,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 				err = unwind__prepare_access(dest, new, NULL);
 				if (!err) {
 					dest_maps_by_address[i] = new;
+					map__set_kmap_maps(new, dest);
 					if (dest_maps_by_name)
 						dest_maps_by_name[i] = map__get(new);
 					RC_CHK_ACCESS(dest)->nr_maps = i + 1;
-- 
2.51.0.384.g4c02a37b29-goog

