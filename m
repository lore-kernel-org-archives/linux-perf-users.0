Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A93F23C5
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078961; cv=none; b=q8DLKzdTPLztJBAm/ruBCQNhB36oBOkPg2HJph4rOWosu4SK2MndG/Xz411Ijtl6/HGnVgC7NGEd95/fvCuvQ1HRw0FZtQq83gQm8YY8fsvAnFbPaWGBpvQl2T0PZOBaDTUcm7wcPPmEfdmM3StRUGnT238pIbKTQvCNyBVNy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078961; c=relaxed/simple;
	bh=OAU4joyMCvkTz0gfnas3vvrqU9KLdL5ai5pE4aFt60k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkXwOTbTWc0cUe6WSMz09KKHnzwKbvUHRw93KcI8KADjAYJy8vqfFGOaOWgIDULJcqFtySuBXbDKlJck9i0eBYtexztsXarDrnAh5mFQB+PI+dZsUriVVQ7jiE9WGCV2Ms4iMbox8oaa2SkZjh7zwVVqBT0rTXo0nvW7vw4DJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=RaLAwFbz; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="RaLAwFbz"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso11527082d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078957; x=1773683757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSYCnTvgRwKgqJAv6DduOBpprY0x2d8AW9Jn0k87SVE=;
        b=RaLAwFbzkRcbjJaJXXz6kwuYB4M5qX+FSesZ4AzXwjJXOUw1fAp2COXxpyefz2iW+2
         qmnu0QYr+2+riFb10x8X40L/gr3LYE0EbiLBfAziKqaMMB9+4ghOiPUzxL1wxWFIpGv3
         HzGQk+NWOAzO3jr2uLev6yOFFbT16hSBXuRMRI6GNhoJI4NqA2FrG1tiOnZ4gzStSzBX
         nplxlABEBI7rxjn1sZVFXwMCatiIhFuNS4x+x9PXOfYEcyv+IsK25YQgnhqDqSX6eZtu
         8zG4rrAl0S9WDngUUMMpHLmNOvTyMesRpIQnoQ9xvr3JOIRyunKB7prylqGMkbVhDBi5
         S4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078957; x=1773683757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSYCnTvgRwKgqJAv6DduOBpprY0x2d8AW9Jn0k87SVE=;
        b=iELf6tv/nH/7fYlxA2i7ZHRgTLpW2h2UYe7b9/YwAL3XCsVYkEz9EIKF5rdXXuF86J
         lAZdTAU2AbCpqfu5bONcTqUdA57c9hF0k5Wp/vQc/SHRZzr06oAfQ8euCYVvs14pR0IR
         zCGp7u3fTRW1VYF+HfdH+rNfpKdkogrfcGFx22o8nuoNFYr4bfrE6SIZkx2ED9y9L41t
         PuUYF/1UcwFNerH6xMubTdSpH65THIK5d0FsIyRtfACQh9ZUs3yJZGKeyskQps+cuBmO
         eJ4ueEx/4UlBjaUHSY972nFpT1Hkxj4eYGZDsNQH+NDBn2wzZGIN8OmCvNao7Jb3vYNU
         eryw==
X-Forwarded-Encrypted: i=1; AJvYcCV071aPIZKQAuAQ/c+a5BsVLp2lPH2jTgHmIZ8EnF2ZHtJ78y19uvnN/UcCARwgX4weoyHirtViznFp5yhxz5WH@vger.kernel.org
X-Gm-Message-State: AOJu0YxNmEc031o1XULHPFX9LK6VR93peQqTnpOs72+IvISHv4jSkpra
	5ZPanXBF+6G23fd6Jo7tkEySMTzl6mIwmjIojhujv2g8/PFPSf8Ga3vREZ96SW4eFA==
X-Gm-Gg: ATEYQzxG5R4uuDa3AaHr0Q9gV7Tluh9tk/pCEoMkk2iO4wivrqUHc7p/SodqQa4LK/c
	EzdkBxSkgq9EM5HV/ccm6QfMdt93KIethjI0vtn2dbwv7oLTObFg+hTAGWXVZgQE18+IseW+bH7
	M397azMvNMD1AKujyuTjBEa+8my+KniernAlGBBIaaIKC+A2ZZa8w8Jn/eJCLIGMeNmLy2J6P3I
	0VXG8QuZcBxzQG18Pa8OFmMZ4hnVZ5hm3FbVuleM0HitG29nUFRzxOge39J/JuhHLdc4f8uSljT
	6vYjwLNPF+7BJmQYqntuNpKZltDhWvY+J89vZyZ2JQqfEsMymaCpHL+w7tKZ0vf34x4SYAGzd0Z
	C55I/XYxmpYkohRXfAxXNOAuc+abDVHfl74A7QhHhEMx4XgxPvqnZd9f2Z2+5XxdPRWG+zCiLOE
	vVfCjD2k+5RO+0cXKjtXstoNCToL0YFvskbRm2TVDobKlCKVXAS8ckg//W
X-Received: by 2002:a05:690e:134a:b0:64a:d1a9:a64 with SMTP id 956f58d0204a3-64d142baacdmr10625010d50.55.1773078956967;
        Mon, 09 Mar 2026 10:55:56 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:56 -0700 (PDT)
From: Zecheng Li <zli94@ncsu.edu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	xliuprof@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] perf dwarf-aux: Handle array types in die_get_member_type
Date: Mon,  9 Mar 2026 13:55:18 -0400
Message-ID: <20260309175546.916039-6-zli94@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309175546.916039-1-zli94@ncsu.edu>
References: <20260309175546.916039-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a struct member is an array type, die_get_member_type() would stop
iterating since array types weren't handled in the loop. This caused
accesses to array elements within structs to not resolve properly.

Add array type handling by resolving the array to its element type and
calculating the offset within an element using modulo arithmetic

This improves type annotation coverage for struct members that are
arrays.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/dwarf-aux.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 1484aa756826..1feefc329154 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -2127,13 +2127,28 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 		tag = dwarf_tag(&mb_type);
 
-		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
+		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
+		    tag == DW_TAG_array_type) {
 			Dwarf_Word loc;
 
 			/* Update offset for the start of the member struct */
 			if (die_get_data_member_location(member, &loc) == 0)
 				offset -= loc;
 		}
+
+		/* Handle array types: resolve to the element type by one level */
+		if (tag == DW_TAG_array_type) {
+			Dwarf_Word size;
+
+			if (die_get_real_type(&mb_type, &mb_type) == NULL)
+				return NULL;
+
+			if (dwarf_aggregate_size(&mb_type, &size) < 0)
+				return NULL;
+
+			offset = offset % size;
+			tag = dwarf_tag(&mb_type);
+		}
 	}
 	*die_mem = mb_type;
 	return die_mem;
-- 
2.53.0

