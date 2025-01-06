Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D22360;
	Mon,  6 Jan 2025 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736193010; cv=none; b=QzB11J2Ojy8hV9LW/0D7HmR0v4b7zK2WVr/4nNu9MbtWiFNbhK66Ei+4Y47DFi73Y9iuFW9VhHDQg58GN257ND3pl1uPSTd36XaTLnMetPxav3ggSDk8BShY43mF8llnousvimFXvlprUAJXddBPc5QafEXCtRnnre+dAXTgsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736193010; c=relaxed/simple;
	bh=IZC+Ucm7AU9piK1OfxvR+u81ZkjwnuBAOrtHh5CBEKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDFVGcDJu0hKYk10rMN5guZ3hERgUgZN3HEgUnh3FuI333Yy3UPOb6vBM2RQ/cBo9XtNdTSRoQdN74orcN2/DXm3a4pU/W3ZdiQn6gDN34wlPv7SSmOakVwouG20t6yoYmEsnalo+1eVJf54ln3c7QV7trbtZGH1Y7BRlb3dfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YRkxw3VvCz9sRk;
	Mon,  6 Jan 2025 20:38:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xx50HgpFI3Gi; Mon,  6 Jan 2025 20:38:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YRkxw2dmJz9rvV;
	Mon,  6 Jan 2025 20:38:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3776D8B779;
	Mon,  6 Jan 2025 20:38:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id c7EvnHz87GyX; Mon,  6 Jan 2025 20:38:44 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D4C78B781;
	Mon,  6 Jan 2025 20:38:43 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf: Fix display of kernel symbols
Date: Mon,  6 Jan 2025 20:38:29 +0100
Message-ID: <3fda227e6ff229b5063d4181ecf75567ca016c18.1736188475.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu>
References: <8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736192308; l=1838; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=IZC+Ucm7AU9piK1OfxvR+u81ZkjwnuBAOrtHh5CBEKk=; b=qKg2BDod6CEGJ0IHAxSluXn8fNvV2JKvDgvHH+WujAxVHXaqYD20W7XM/907bzJGYJbnawM1N U/m7HeRSm6/Ascmu0OWMMe/cdHzEmS9W6Vw+g1IK5JHkwh4+mvOfNj/
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Since commit 659ad3492b91 ("perf maps: Switch from rbtree to lazily
sorted array for addresses"), perf doesn't display anymore kernel
symbols on powerpc, allthough it still detects them as kernel addresses.

	# Overhead  Command     Shared Object  Symbol
	# ........  ..........  ............. ......................................
	#
	    80.49%  Coeur main  [unknown]      [k] 0xc005f0f8
	     3.91%  Coeur main  gau            [.] engine_loop.constprop.0.isra.0
	     1.72%  Coeur main  [unknown]      [k] 0xc005f11c
	     1.09%  Coeur main  [unknown]      [k] 0xc01f82c8
	     0.44%  Coeur main  libc.so.6      [.] epoll_wait
	     0.38%  Coeur main  [unknown]      [k] 0xc0011718
	     0.36%  Coeur main  [unknown]      [k] 0xc01f45c0

This is because function maps__find_next_entry() now returns current
entry instead of next entry, leading to kernel map end address
getting mis-configured with its own start address instead of the
start address of the following map.

Fix it by really taking the next entry.

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 432399cbe5dd..d39bf27a5fdd 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1137,7 +1137,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
-	if (i < maps__nr_maps(maps))
+	if (++i < maps__nr_maps(maps))
 		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
-- 
2.47.0

