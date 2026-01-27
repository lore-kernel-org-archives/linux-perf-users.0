Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401D2D8378
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479602; cv=none; b=moidIT4k3EtxL/f+DZJ2ThgJuJuuRsT7k/p8glbgmpgbmTWCCAXuXfGr5t50KW3zlWsVgXhxxMMIo3LXE0NZqunIWT7Wz9mBKUzo+3FLCvpFQ3rFqLAXAr2eBGUTSeTSxnS8CJuI+/YFllAcCifmZRk/N56tEy4lStu0SSBU81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479602; c=relaxed/simple;
	bh=qhOxCaKgcUM5iY1rf7o/kU9mLoxJMGT3w3Oo56OLRqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eep5Us9+C7zCUvP/itJ5L1OsYkT/sBl23XfjrDERV+E5wIU2GU8vOGtuHqBUQwG6Rwh1EZGq+depc75+ZvQFeJJU4PsNas02MjAAmbgJlzYRLuLSXCDhzhvkUX/LiLoinIwhijLvQxPjK2IoSyx+fHjn3/pkgHF28pFj0u/6OAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=C+MyFG3N; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="C+MyFG3N"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64969550a1aso2331244d50.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479598; x=1770084398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS6cufmSv5Bys/J7tQyqhkjwp+KCu1swmTcv6haTRuI=;
        b=C+MyFG3NQJaNmzUHOxSPDDyPk6zF7KaRJtVGiB6b5dzi8SCbA5iwQ++fVy/9/p8LBD
         2HFyESRfFi/gv+s3yTqxHverncDqbkVbmz+NXhybkKnAFPwoEFRSdbIO+CqGaP8O+u2Y
         lihBi30TRADe1+7C3+Odn/5G/59sqsru2Iq4cWZ9CYQieTMntNYrnMdQFVpH2Ru4ADq6
         5gekU7LCVdi/foUhZY75hv0r+QWPCgSYjg/CjdgvrcOb3xWHZnrcv6rl34IS6kqyXk+p
         KnPMuGHlpHusyFZa4/rMjRJJEap4hg3uA21o8EjJAKGoKorDr2KXwsdu7BxUMLmgvw4R
         QwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479598; x=1770084398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GS6cufmSv5Bys/J7tQyqhkjwp+KCu1swmTcv6haTRuI=;
        b=HXA5LpNbplb/36egian9gyCUlgIMaZ8luTYvHQOma6Cy1WySFsSwnWlWhr2Ei5lHTN
         FJYdRdHfvs6OJOjWUZtorx1kSuWNs2k1pHE/cOrgZi/iAEg/oz8kYN61rYWwPHEoLtte
         bKmrcHJjIMJqZqhTLQuvMtW+ylO2oZwrnlEkjpdDgTNxQIMSRcTR23V5dtfMwtcvPaAL
         LnOZtPJDKV/bfc+eVNbMLyaHQbYg9z8BfOeSuJqlBsaugTtw2XkXM5oiNXKe91Ep9DKV
         QZ2ql+y3j6vovUE271fxCKckPXJToym0YLmQAjihicL+IfGNL6o2RHhqjicZpslRiGaS
         OoTg==
X-Forwarded-Encrypted: i=1; AJvYcCW5OMOoxW1Y9gB8IEbHw92+AQy5lbSo2wDveBRCnsr/WlqVNJ7mzGZ8ZCS97RquviPx9gPM4lZJCmH1ku+4r7cW@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZ/vc6/T17aUx9CUl0jBh7dQtgu6A7f086OCzbDhyto2XUGqP
	aCmCfdp0X2LDasaO0JMTo+Tk+FIDbp0iFuUK6d2CSCKZe8tHGqvIRs5PMbxaZEVutQ==
X-Gm-Gg: AZuq6aJuu8kWnLxDHFLHcMsr8wcOjPu3758uzy8tm6hDyv1ljzuzzYkQryUOw1Wg5LR
	s1bAAIxJxzeGzSzknY4/90jV2rzi2NtLFg82qgccqSM0PXg2B155jCRL6+AazX8+UVb1eDCAZqr
	Z9W/riby5l9LpVppaI+8uJJZg4HJSdM0QgdyKh1gMsChC9rM8hWmqVaoaCqWRphv/Wmr6vBrdL3
	56lpcEfyVsaWjECTLckN1xMXacSkOacqLx0jVnvZFcDwB4tsaRHoWUw/lEiAEWuzXy6r9+KlCkh
	S6eeiBX3Iq7pQ4M5MjXMbl5T+U9phCFJ6fgS/0M9T8ckdO2hR4sPVMF7BJ4wr4/ziA3QzcIHfBg
	xQ0TEOMeR+yNae0Wpug4L2uDsI0N3DKl6+jvnxFs6crVU9QGHDBb2W7w9vwNjrOsuUspGBnkx24
	oY311dGV47pg==
X-Received: by 2002:a05:690e:d88:b0:649:34da:fbc0 with SMTP id 956f58d0204a3-6498fbed29amr16218d50.7.1769479598080;
        Mon, 26 Jan 2026 18:06:38 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:37 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Zecheng Li <zecheng@google.com>
Subject: [PATCH v1 04/11] perf annotate-data: Improve type comparison from different scopes
Date: Mon, 26 Jan 2026 21:04:57 -0500
Message-ID: <20260127020617.2804780-5-zli94@ncsu.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127020617.2804780-1-zli94@ncsu.edu>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zecheng Li <zecheng@google.com>

When comparing types from different scopes, first compare their type
offsets. A larger offset means the field belongs to an outer
(enclosing) struct. This helps resolve cases where a pointer is found
in an inner scope, but a struct containing that pointer exists in an
outer scope. Previously, is_better_type would prefer the pointer type,
but the struct type is actually more complete and should be chosen.

Prefer types from outer scopes when is_better_type cannot determine
a better type. This is a heuristic for the case `struct A { struct B; }`
where A and B have the same size but I think in most cases A is in the
outer scope and should be preferred.

Signed-off-by: Zecheng Li <zecheng@google.com>
Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 8ff1972981b7..8ea3e8b024e8 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1634,7 +1634,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 				pr_debug_dtp("type_offset=%#x\n", type_offset);
 			}
 
-			if (!found || is_better_type(type_die, &mem_die)) {
+			if (!found || dloc->type_offset < type_offset ||
+			    (dloc->type_offset == type_offset &&
+			     !is_better_type(&mem_die, type_die))) {
 				*type_die = mem_die;
 				dloc->type_offset = type_offset;
 				found = true;
-- 
2.52.0

