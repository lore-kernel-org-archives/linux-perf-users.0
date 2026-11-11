Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418980;
	b=2NXYhqlbajuzygZ+A7P/jpfFlsZE3QNfdPFtIeK8/kAR/iSDp2qLjECqT4orZVnMlvM2
	 Q0qXKt3rzwhPgrd7ZEMNDaZ0Xu77cLqCQWxrZKIaBQAIMJh35Pj/2wioQP0HCzbLf9sta
	 ZchDUtkb/PVbLwor/a0aWdjvXMDcG8d81dvrSHiisMLFlGpDaO1miTROPh9pbDJ89Gq/v
	 5xwznilpursyFiep2EE6gsYI8zCZ6fhwhGkkviYSip9fhjQLpMhIsxvyQBfSuxaQ+fnZ/
	 t7ISVY0NklT/QGKPYbdEtRCZkdbqsfgTUS12bn4HsqhGO2INlddYhJyv7P+VWKBX0fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CJCV5FAjldeZZ8pPMlGSAH37gvDySd6J3mbbMVPyJm4=;
	b=eHMpG+Xz+7wiJ9YcKkVhL/6QC5E90nWjunM0zA3aOIFx985mVj3jMA/vOG1gRZEfqQk8
	 lHyBLM+iaYQvqWickLvqmP86vLAg+JMEvP93QLqOhKtyEy33NT+aKRaiUTnO2sYIDtoav
	 aKz18YWAII6IPTCe8aJ/7BUpYd1PpyenUr2kqP/mFV9i2kLx+D5Cu7YYXgMrK1nBzzXKd
	 Zq84k90l6kT7AZTKhKVm9y4WqbgWq8CdWZS77S+VRi3jkvyiwUYkgDqjGE65pdcRO/M8b
	 rBfYeYJAanPVEM+1CEBN4pba4n9O2DAdfVu8o8YqyfubgupfLtGZZebE0zn7jp+Cq9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IwHlCo1d;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D990606B4E5
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D990606B4E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IwHlCo1d
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad91787a1aso2571679a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418979; x=1795023779; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJCV5FAjldeZZ8pPMlGSAH37gvDySd6J3mbbMVPyJm4=;
        b=IwHlCo1dK3LIm2bCl6NYADeKbRO7Krvb7ofWVI5TGkNuvDugf6v98x5BP6lypSRMKC
         KBvOyTEG0xYK5lFqf1oFGtWybMk6rbC2MSJFS6gJy27bWx733V4JmwTGb2DCRjLS4L1s
         koQ/4++o6RjF2KA2evLmeuckhe69nrf0lg32ZEFYf0r1aS8j/xpDotamd9VC9jqSjtW+
         xW162S5lQBX0QTh/4LUxX2aeS9a/dXaywhOZFEUyfT1CwZib4aWfuZCynVvevopqYNSh
         Oqbk26t4dt7hAG9aCDXps6Bwtq0+bbeiwehI7pfSMhOP5Uh8UUVoEZ1tG8xGYgp8gcbp
         WtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418979; x=1795023779;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJCV5FAjldeZZ8pPMlGSAH37gvDySd6J3mbbMVPyJm4=;
        b=vhur1F2iBoz9/8DG6KahDR+grIED++qNoLYO/5TvZ5AYUs40IcxOiw6O87CSeTVyQw
         bhvz6fzWV19XXfFCsCzrJXqwhazelihb/ChWcdS6DFrciyNr06Mvi2qvNjhiMWwbzX18
         MPmCK7cE+wmgyX3vd5KJbP1Tp8HgpY1mLhySILEOZL6pPMY3/vqfhC056iCSHv0aoyqt
         C3VY3GN6XtitnCQ3bRIuVpCPSwk6x/ExbfuMuHQStQHzCmNitOtzNINWAGQByrvogPO3
         C3ELXTIZasLBAgVIK6UGKokh1hi8aWARQdpLmIckWuvnaywo2OUmTOAJIDgjdk4lPqLQ
         fU+g==
X-Forwarded-Encrypted: i=1; AL+hErHWRC2wL40vvOQngSciGc9HERMg22crFUKtKtwwWnZ2Q0lkjiToOOCtFvlSrMKaxDCVj47z4lYPa6zszflgOscP@vger.kernel.org
X-Gm-Message-State: APuU4Z9vSyhJEK5Z0MCGybtNfF/wfUkfExk13nzrEZDownyVh2XY+GWE
	F/Oq0jsMOuoTMk9LUH5jjOMWz1j3mxwyF/3K779H2wBG9rCdlVXWNQ7aKXguJY1I5aPCLdRjHgd
	BgFPmabYwig==
X-Received: from pjzp24.prod.google.com ([2002:a17:90b:118:b0:3b1:15d2:6bd3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e710:b0:3a4:967c:6947
 with SMTP id 98e67ed59e1d1-3b182eac808mr2863948a91.21.1794418978458; Wed, 11
 Nov 2026 09:42:58 -0800 (PST)
Date: Wed, 11 Nov 2026 09:42:10 -0800
In-Reply-To: <20261111174213.3526604-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111174213.3526604-19-irogers@google.com>
Subject: [PATCH v12 18/20] perf maps: Fix lock inversion in maps__load_first()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In maps__load_first(), take a reference to the first map and drop
maps__lock(maps) before calling map__load() to avoid a read-to-write
self-deadlock when loading kernel maps inserts extra trampoline maps.

Fixes: e77b0236cd0c ("perf maps: Add maps__load_first()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..7ca33e5218e7 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1459,10 +1459,15 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
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
2.56.0.542.g3ef89b7020-goog

