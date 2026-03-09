Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B782D0602
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078963; cv=none; b=Af4DJlJamDyM4t9v26YCk7+ybXjUUZuTzeK2CdRZp3NRixILMJH9+AM05c1AW6C+BAzJDseUXa4wVifb53YM2mg3XteiKsEKzTV3APGvej8hQtXXoUOylDBP7mCO4FAB9149e7x381uLeO7kVNPm6rm6034oO+wXw/huci4SxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078963; c=relaxed/simple;
	bh=pvxNnOKqeHa3u9P/BSdLX/F7/QbZo7WG8Lg+nWmEajQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNNWrYoud9G/56TWcuyJODyHVxRSTTi1Z+iglDcdiGIa7h8YdDlluI6pvu5/OhnCADzM713STigs5kXAZjG510q0QJzHRl4fkkpQbz7VVpXanotfKQrixtCUhd0j1qheXksFoITEntMBKigW/XyJpvwxaO/0nG3O6TNAxqZ/uVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=RczIOqwJ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="RczIOqwJ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64c97997b0fso8439981d50.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078958; x=1773683758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPYwqT1EEY7+NbPzds3BGnxWg5Bdt7m7QdEJl4nIWoA=;
        b=RczIOqwJ6ihTF8Imcou4a3eoOb2tlIuHjkjVLFXlQtfOqiM/rW0rDf4HLuikNpRVie
         Grrj7k7I/HvE7AJT5PGWi00bO86EVmqq0AAi/ehrWtp5/xMNg8jxyVjJteW4mnXfA2Fq
         SF3TaYbzETE0cqXsl56gpWHlOQiBM4NxMOsxDVHEYUhAOi4tU6O2jn/E21VnLfXPnyYq
         Zc5F2lXh/2dkE9tQRJRIogf655RTL9ZVUOsXpH055SMfRc5dXRXLTNmGy9AJ8n3GXvCp
         yk7a96Xq6fli1dlUelITRTTOX6iDWyd2Z73JNM5xAuhZtkAx4MxSH4lyEzcD2i5WF681
         QLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078958; x=1773683758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPYwqT1EEY7+NbPzds3BGnxWg5Bdt7m7QdEJl4nIWoA=;
        b=ql7VD8tUwHaQZ1YlwhfZgHkrGUcXewzftAjCTs5eR4A4sg3B4uofG3+SoelMC3Nxte
         gn4e2TLh8dNXYzivD6A3TjRqztuLWSEq8hM+N6/jsmB3ZwkuSlCr49LwrZGXVLy6wV05
         zuPk5UywVwmOJ29kqkxuC+tVlexaxlx9seyBs3EqU0Lf35xRBJ5pmbIqeOCq6IK5gAyH
         nnIckjgjG7Yd9iU6r31Rdnvn+KwodrxIXvUf/R7IhoCTdjHNl0hflENqDmzjBKNJLYBg
         yzMU5C0oX8VMCe9eOyy+/mLTqw7rpnxrplx/KYFVvRif2rtUyt5TRRYYlYWptgtie/mY
         M3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXczh2jnhtVapuBMy4Nf+QW5YUs7n9Sz3CEmj9JdSprDzModM/LxdpHO32mBV4BoCjwYJF0z5EVVghqDpR4G8m2@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTGujEdurso79M0RXjT4zTyoJCCqP65Y4mKC95Pqew00O4Lsd
	BdsHqsYWCEV16drvjgVKKL4y/z/mv+JltulWX5rb+Lo7IO038abkSH+EOeH/CaPh5A==
X-Gm-Gg: ATEYQzw25wj1im9vMmdJWGtg6+7TMHGzoYBU65UDwsHtbdknRpgH8QU+v51r5YMHIAq
	lK4cSohtWsZek9BtkFxDaDff9XiYoJPv6+/TfpBVguGSM73shAP/b7ZUcYFGApuqImzGnH10VIj
	ewe/R542PPtuzbHWIvGrlcsex/6gq2Ti8Bu39eapydsgsC7mcSp/J3Fl6NGL+ivA8fS29WVG38Q
	p2CeijDw/9h3HieXHeOrnYf+tbH0RezFwN++E3OFATU2PRNe4PxrA87Ms5sYT6x+XfdZ0FiWJCr
	aw1Eyvymt2+NYz+8vzPyv2zBpkDfLY767w9c4YUOz3wV5umkPpAtGxfMYdCTTEenKCrXnVyaNYv
	VK5vR3UDTsFBoIIbdvYePBqQ/gNWJNCFqb5i43uLh2tCmYxsQ9/usqkyjd0usqWF5aD5tpuP1Jt
	9PNnRAYQNU5993ccsJeCJYKU3DkyCPFEgfbM4KWpUoHm4PrGceRty4ZDZQ
X-Received: by 2002:a05:690e:c44:b0:649:ca5c:5990 with SMTP id 956f58d0204a3-64d14316d3dmr11274047d50.66.1773078957901;
        Mon, 09 Mar 2026 10:55:57 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:57 -0700 (PDT)
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
Subject: [PATCH v2 06/11] perf annotate-data: Collect global variables without name
Date: Mon,  9 Mar 2026 13:55:19 -0400
Message-ID: <20260309175546.916039-7-zli94@ncsu.edu>
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

Previously, global_var__collect() required get_global_var_info() to
succeed (i.e., the variable must have a symbol name) before caching a
global variable. This prevented variables that exist in DWARF but lack
symbol table coverage from being cached.

Remove the symbol table requirement since DW_OP_addr already provides
the variable's address directly from DWARF. The symbol table lookup is
now optional to obtain the variable name when available.

Also remove the var_offset != 0 check, which was intended to skip
variables where the access address doesn't match the symbol start. The
symbol table lookup is now optional and I found removing this check has
no effect on the annotation results for both kernel and userspace
programs.

Test results show improved annotation coverage especially for userspace
programs with RIP-relative addressing instructions.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 6fe2efd48a83..301f73ea8275 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -774,12 +774,7 @@ static void global_var__collect(struct data_loc_info *dloc)
 			if (!dwarf_offdie(dwarf, pos->die_off, &type_die))
 				continue;
 
-			if (!get_global_var_info(dloc, pos->addr, &var_name,
-						 &var_offset))
-				continue;
-
-			if (var_offset != 0)
-				continue;
+			get_global_var_info(dloc, pos->addr, &var_name, &var_offset);
 
 			global_var__add(dloc, pos->addr, var_name, &type_die);
 		}
-- 
2.53.0

