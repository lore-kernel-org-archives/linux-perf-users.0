Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CB220698
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763528767; cv=none; b=hJZjVgxwiDKtt3rgt/mPVlY4hhGSzai+gumror5B92zn5XxXo1gm9Cg980RgmsCJBIRRuD0PPKCUaqEDhH8M6nvn/SY7F8I3McZXe0jaPZYLp4yM/C50n4QxZBgIe2XKpXuH7tnN5aubUMaiZbiZkQtDSYrD0OygPg9HmDUTwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763528767; c=relaxed/simple;
	bh=AL35jIWqLpEQrobs8WzgN+Or4eupxZTkrsxCfQu3Gek=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=cy2phn5hxHgzVIvh2LseGECXpPSVOGER3Z16oeLVY+te759lYBfSm3t8E9pabn8zZGp8p5GOrRQb5NvzgsJd/8sQPTREkygdwFTjuyiVenQ3/7plz9kG7T46w5LGLCAYULSkv7jUTbrzGo5o9041I09kzSLrth8pqc5bl6IFIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ztrg9DOK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ztrg9DOK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so10591053a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 21:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763528764; x=1764133564; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c4Sj77sHnV/MC5K9XeYJi0BLwRXY/iWwwqmvNrD5ZVY=;
        b=Ztrg9DOKew/ZDl5W0wN4eZ9aDk2nzNEJ84+Ht6McX2gstJrJYSv4N4hhtw/wLRuWLZ
         C5qqEq2WP3ntgjp9S4HIVJJT3lNYMWd+/4NAVpbp5jTHkjl9u+3SXr0akZYrCUyaU/3p
         xV22LFjikK+YIPaY+UDxKCSvnCvO0nlAKj9uo/xrwfYyFWjzKp98Gw/ucHmKZTRFWEJL
         FVX/X9kvuu3pn9sehrEJ7vSFE+co7PGcVqAWWk7VFmn+O+C7zabSOBqzmC+TapY3Xvg+
         +ReTRR4wiy3ux2+Iauj7wlP6uRDoOhv/BzpreJkeI07uLSRHwyYTzdQm8h8yIclNlWTg
         pWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763528764; x=1764133564;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4Sj77sHnV/MC5K9XeYJi0BLwRXY/iWwwqmvNrD5ZVY=;
        b=QlzB09o3LI7X8sXJ4Uj/U5HspUoNbQJvmPZaJbsQFaMu4Fu0z8DGwqI4STZN33FEtQ
         ZhmiY5VlfsFQF6NsppARwrFubgUP5d5EHfwUVFgtbWLHcgIrQVmMigNCpOiRFcgS04Fq
         GaKLTMecbPmSHrc9tsjvE2K+y8RcdIGy5N9eCoZtuoTg+bXnow+HIVKNiP8TppHn/A+T
         P2nsYHs9SCN7qVP8+IeIBc7LToRbH9bb7oljnEAMiEwCm8pNfcYz0Zz6g7p5lsPFdsHY
         L/zYW/02KrX4c1IxJqHV8pMEmWDQhMafnWsNpCaqi+winWklLQnjjGEBWVkEnOWNv8iN
         UE3g==
X-Forwarded-Encrypted: i=1; AJvYcCWh6JEi7MYN9W3dmezAQbXa8oPa/6ns6D813SknVBBWXFuKllkYqKRHigJmpTYQ9TjHJZEtIpDDU8otmyE4h/8i@vger.kernel.org
X-Gm-Message-State: AOJu0YxUC6p3N7UVwBNnFdX7+H7IYoDVzreqKWbIOHmmBy2ZwA3usv6B
	CVcupnpGlzw44zzbqkyo9pKCRJBNy3NHtdgvhZVbAVydi+wV0AWcT/4pak48dy9/W4X0zNCWk9E
	pxxuehoqTiQ==
X-Google-Smtp-Source: AGHT+IGSBE0RhBdd+d35qnzp5bKWP7QhMELtgQ6Z0RKPQAoNRniyHdZX2nUfVBbobHicgrQi/mmYWei/QZOu
X-Received: from dybic37.prod.google.com ([2002:a05:7300:c725:b0:2a4:603a:d428])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d50b:b0:2a4:617a:419f
 with SMTP id 5a478bee46e88-2a4aba98c9amr9258681eec.2.1763528764050; Tue, 18
 Nov 2025 21:06:04 -0800 (PST)
Date: Tue, 18 Nov 2025 21:05:54 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119050555.2017758-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf maps: Avoid RC_CHK use after free
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, German Gomez <german.gomez@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The case of __maps__fixup_overlap_and_insert where the "new" maps
covers existing mappings can create a use-after-free with reference
count checking enabled. The issue is that "pos" holds a map pointer
from maps_by_address that is put from maps_by_address but then used to
look for a map in maps_by_name (the compared map is now a
use-after-free). The issue stems from using maps__remove which redoes
some of the searches already done by __maps__fixup_overlap_and_insert,
so optimize the code (by avoiding repeated searches) and avoid the
use-after-free by inlining the appropriate removal code.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511141407.f9edcfa6-lkp@intel.com
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 779f6230130a..c321d4f4d846 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -931,8 +931,9 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			return err;
 		} else {
 			struct map *next = NULL;
+			unsigned int nr_maps = maps__nr_maps(maps);
 
-			if (i + 1 < maps__nr_maps(maps))
+			if (i + 1 < nr_maps)
 				next = maps_by_address[i + 1];
 
 			if (!next  || map__start(next) >= map__end(new)) {
@@ -953,7 +954,24 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				check_invariants(maps);
 				return err;
 			}
-			__maps__remove(maps, pos);
+			/*
+			 * pos fully covers the previous mapping so remove
+			 * it. The following is an inlined version of
+			 * maps__remove that reuses the already computed
+			 * indices.
+			 */
+			map__put(maps_by_address[i]);
+			memmove(&maps_by_address[i],
+				&maps_by_address[i + 1],
+				(nr_maps - i - 1) * sizeof(*maps_by_address));
+
+			if (maps_by_name) {
+				map__put(maps_by_name[ni]);
+				memmove(&maps_by_name[ni],
+					&maps_by_name[ni + 1],
+					(nr_maps - ni - 1) *  sizeof(*maps_by_name));
+			}
+			--RC_CHK_ACCESS(maps)->nr_maps;
 			check_invariants(maps);
 			/*
 			 * Maps are ordered but no need to increase `i` as the
-- 
2.52.0.rc1.455.g30608eb744-goog

