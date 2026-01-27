Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CA2D97A6
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479604; cv=none; b=RNJKeXXjqZvcN0NldW1OtnwuOU+elyOnaJLrt2wp64ZOf2Ujx2M+3q5u+Nb6/HfEHPCS4bbykR+hlSf6y28UhvoNpIiuJs2P1JiU9TDLLViqT4tO9ZtkHCTpcP+GVi0qx2El36y9qi7RSTt6yGSdRmjx3fc3OKFA0kUUdwJxf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479604; c=relaxed/simple;
	bh=mYBobRXu3FK4wXmLvDov/G1ul6SSw5NijXnRXbItZpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNh9ronCGm7FxLu4Bg2hJiz3GrsNe9FGnaBV8TbTCWY9wLXe3pNHIBG0FkwYhnApfOl0ljfn1j95CrsQIIEIXoNLTImraWDLPwRjbK3ju3OtWByuqfNvUdFCxLGm0krBK+z6XjW13FLphioF8By1Ou1t46mKXIm+rTKpylORLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=An2dUA4x; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="An2dUA4x"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64965ee303dso2632616d50.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479600; x=1770084400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNHFu4kzRwC9eEJaKe6PAV5wflRvk28X4nOD9s6tJhI=;
        b=An2dUA4xcnbtdFDvXT66q7tFj9s8SiMmb28O2pxbxh1BDRRpx6nSlF0QFRLCwbwZTE
         amLJd0I7te/OfOFsCiqq8P4U2x0/2DKKQZfFN9MaSPFD1m0lVC6Glg0v1QEmjNwPuQOg
         2mxtbPHTrpamoFjhB+Bpy9TUSPJVRG73xApzijknou1x80KkSjQmUy+tY1DljAP9LlUQ
         IFfsCN4aEl90ldfypI7rwi3u1LvIIamjIozsLDPuWLvW31cwkDoOHqFWRzRpGSeKRlWB
         xgkBklDxE0xFDOdLFqzFr6bH3hClyVKnic6dWfkPFTaoEtvi9Z9FPQfS09PL3+VaCYKR
         0ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479600; x=1770084400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iNHFu4kzRwC9eEJaKe6PAV5wflRvk28X4nOD9s6tJhI=;
        b=OvHAeGZJs2jBpbqcDBixeF7lg+phGFa5yPFkTyAS1oVLw9oPc583UkOXdkj1rGjKmx
         4L1byCSdTYdJFOKrifJOAitk0O3LDitUz4XW2xaLeZvgBT348CeeHXHrfEYCH0JhKe/L
         BJjlzT44g3AFHDhGPCnzHockBhxQREBId6jQZ6pHG5qR6nRzfcOwoq7XqWaab91x75qy
         PCcsbhIVopaGcpfFnp+MSGoIIfG8ZYH4VWfKyTKjcsxpTXxeV5Uw4tRfbEIEwJFg94XG
         idTH5auGZGHL7elY8PtBsfpLDAX3YvpMQJ4ysXEXNBfNlsqVhJugLXvOtwcDyrBR8/+G
         UoXw==
X-Forwarded-Encrypted: i=1; AJvYcCUwI36VPgsuDL/4vih0LFZymz+1YkS2fwBj2iz0n7V3Zs22LaMLjrXOiFQF/YqBesHv9ecfrD/44y3IXtEyvrk9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GrVIyPFfxuiiKEOfLXcytZMPSwTCDsse5b5pz7PyijmWBc8j
	OtoNGxID4Ea+pyKX5jD6MCnWeiyqjhGMvXukc6uPr7GS0l5/TsABa+6Xu7DT3f8ytQ==
X-Gm-Gg: AZuq6aJlPzs+Zg3+/ZCt1CeCVCKxsU/twlNtTGH9S+f+ErSYpodTtNVHIQPENSEXwnZ
	FwxLAiuMdeskpw1rv0OLimcad5SM4PvOFzbzs0rKBo8ytNK48C3vqR9eg6eQ+yLrq8vcUe931Xf
	H6VM8d2oYZO+MFnF/nIQczdiJFHgJkEjXqQvajm3SqYU6h3eY6TLTQCG05Nj+70ep04khUOtSNb
	tTvd/6Zc2W2yj65dOXY20mTqQT2s/eYC56GmBzwzP7l22vtfxx4hNxATNHI35ljQ/dJ+RaSqvLK
	DE3fvtYZKCGMlD6py/qlfkEf/8jkcCb8SkrDVaOlmE24QNtp5ANJLrasdANi7TOUK9x4FPJniPH
	OaJrHb6K4adsgOULvdMjNjjnyu0kDG640k91GYyvhyR08Z6GMiMer9+1XYbDSourOjQePhAywuM
	S7YEeHVnmwQg==
X-Received: by 2002:a05:690e:1698:b0:649:447b:5857 with SMTP id 956f58d0204a3-6498fbf6fecmr11847d50.40.1769479600319;
        Mon, 26 Jan 2026 18:06:40 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:39 -0800 (PST)
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
Subject: [PATCH v1 06/11] perf annotate-data: Collect global variables without name
Date: Mon, 26 Jan 2026 21:04:59 -0500
Message-ID: <20260127020617.2804780-7-zli94@ncsu.edu>
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

Previously, global_var__collect() required get_global_var_info() to
succeed (i.e., the variable must have a symbol name) before caching a
global variable. This prevented variables that exist in DWARF but lack
symbol table coverage from being cached.

Remove the symbol table requirement since DW_OP_addr already provides
the variable's address directly from DWARF. The symbol table lookup is
now optional to obtain the variable name when available.

Also remove the var_offset != 0 check, which was intended to skip
variables where the access address doesn't match the symbol start.
The symbol table lookup is now optional and I found removing this check
has no effect on the annotation results for both kernel and userspace
programs.

Test results show improved annotation coverage especially for userspace
programs with RIP-relative addressing instructions.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 8ea3e8b024e8..970238bc81b7 100644
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
2.52.0

