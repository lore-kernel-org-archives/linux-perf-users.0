Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE72D5922
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479601; cv=none; b=JKdRuu0JdKVQywhS1X+s0kxCrOq9QTE96gq4O/uwxwhTLk/yfTYQSONVovwjgF5LoEJtLkcAmDq4E6pKNZ1eaRPsVV+zxcm+meoTvyhzFsHuoLQs0b4JInaJXqBkPdemYAYFCzAcnncWDnYAfX+F+btJAQnDASh+yXvszSdF7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479601; c=relaxed/simple;
	bh=IJ67sduqkigfvVKbopudRKuQkhcam3spI5srTIcgYL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhV9X05GIoGdTKemI1I4QLsPh3DFZXO5QGVsXD15IZ23sgchykxAXuJx12+KGTxSVHg2Orw++JkF+UPK0tKIEjUDK3XTDsMFyEsn3S+vZS90ZD7UNBzXkUadU7EIHrzEqhHcY0HTelKgZqac4JWiQVtKFu5Yk0iHnQxX7jg3nnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=cx5IWI0j; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="cx5IWI0j"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-649605d3664so3513534d50.3
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479597; x=1770084397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3SRFGPlfEBWXSd9iSIDRLjkWhD7NI153ihmh0SWrFA=;
        b=cx5IWI0jltVk9zZNdqMFt5ckDqFrClhKBu3CpWKVrjSP8jUlFLKJOlv6tJFD3nFdwX
         4M5x2vt0WSIbMRKVZJZvaVen8I/R9S4HOjiEqZHFH7q2lTBvqt8lCzpEnRpR9nFrLNEM
         GCMfRBTs9DTtlpVXDJmVnQymZlyI67nCFaVFHdQWUi5N6gzFJ0M8o6QtYWr8UgJat8Og
         zkMwrUxmF4zAzeMXSm1/hNRfDLw3YZnRKU43kMsBeK1hqzeWc3Ib9cHK/8fLs812CyiW
         HPFHhzhmvzpOJdjcKMpzv+LDoPGN3zM8NQTi2W19Tw2Es7i54YVLDPtUC4rg0mf1n/ZP
         u8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479597; x=1770084397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E3SRFGPlfEBWXSd9iSIDRLjkWhD7NI153ihmh0SWrFA=;
        b=nWrRjAi22gSfYPRYQPmDCjWmL4aP8+843Wa9FC/qV9J9LjkqDX+Syerv4ihj8GlzGS
         3rKMEu3Up8wC9dXCf5Nr8jhFv2pUho5gNpBIGeXvmsTYsNtx69SQZkcQUbOOgFEdcywg
         GkDQMZddGmyfspbZN3Wh4Mvwdwtu8984wHZ8bk58t5vlMckxSod/ZzEbsMlCvFuhrYtD
         xp39hnQFqxwHHOeUHBfPMsBaCCeqZ1o//W9jnlrEGtcVWeJVoCp6x9h+yMlU7nIiMKYK
         lc+j5NCFP4e9yEquDuvIYytLEMz9pva9LGMaYtTxsybBc6YR1ktMCkXMVCnNWF4vRTeP
         GXYw==
X-Forwarded-Encrypted: i=1; AJvYcCVLWtP/Y7v51z7zr529rsnfMfpWGZutB/9qLw50wUe7vrPXGHLukhWzb5/M2qYVEY7LNdOGfSMSmUXRTBapcQYY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2ViKLkslNhayfibEbOk9WqlPVpLmcXVa7gPanX5jw+xvidMj
	NumZlJMaid7FcNaC6lWFnUg/gtCPjc1q8hD6tR1crYlhNqsxhhaClcsT0m9FB95DrQ==
X-Gm-Gg: AZuq6aLOvr+jXEMRYTLs9+rBVm9AtqbBqP2DQsXt2if8hH+bv8KGvreOZ43tuB4ciTe
	Zckiwt3//R3ubtKwUJX1HR13AnEo//22uThdOOTz0BDvcVaUbIxPi+Zhn9cvPTIPMzsf9IPODi7
	JOiPcTbsNMUS6K6FMirWsXMF1fcTUzU5HT96EcD9Z/Tbu3n78/iYjaZ2L4IJ5rSJAwoazAkIYPj
	lWOmHzSE9EcXL0s9cTBsS3ATIP5a0WYubRhk0KijH4fRwQd8Dps8a4HrrF07ItlK6zSjXtkH8Kg
	RaLtZ5tV460xWJSG4+6gEFJWVPeJTsZrX4iS0TunmBZ06Sx/8gj8Xp8dGu+k735zRLyhfWH5Ik6
	Gd2jqGrLstBdcEPWMOEqC5xKdYP0L0BwOG7cFnyLc6gc7cWCho87HxR/Kop8JIr+lP2AoCXbAsn
	b7yj0/T+/8ig==
X-Received: by 2002:a05:690e:d08:b0:649:64d4:8127 with SMTP id 956f58d0204a3-6498fbed0e7mr15330d50.4.1769479597010;
        Mon, 26 Jan 2026 18:06:37 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:36 -0800 (PST)
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
Subject: [PATCH v1 03/11] perf dwarf-aux: Preserve typedefs in match_var_offset
Date: Mon, 26 Jan 2026 21:04:56 -0500
Message-ID: <20260127020617.2804780-4-zli94@ncsu.edu>
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

Since we are skipping the check_variable, we need to preserve typedefs
in match_var_offset to match the results by __die_get_real_type. Also
move the (offset == 0) branch after the is_pointer check to ensure the
correct type is used, fixing cases where an incorrect pointer type was
chosen when the access offset was 0.

Signed-off-by: Zecheng Li <zecheng@google.com>
Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/dwarf-aux.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 96cfcbd40c45..ce816aefa95b 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1420,26 +1420,29 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 			     s64 addr_offset, s64 addr_type, bool is_pointer)
 {
 	Dwarf_Word size;
+	Dwarf_Die ptr_die;
+	Dwarf_Die *ptr_type;
 	s64 offset = addr_offset - addr_type;
 
-	if (offset == 0) {
-		/* Update offset relative to the start of the variable */
-		data->offset = 0;
-		return true;
-	}
-
 	if (offset < 0)
 		return false;
 
-	if (die_get_real_type(die_mem, &data->type) == NULL)
+	if (__die_get_real_type(die_mem, &data->type) == NULL)
 		return false;
 
-	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
+	ptr_type = die_get_pointer_type(&data->type, &ptr_die);
+	if (is_pointer && ptr_type) {
 		/* Get the target type of the pointer */
-		if (die_get_real_type(&data->type, &data->type) == NULL)
+		if (__die_get_real_type(ptr_type, &data->type) == NULL)
 			return false;
 	}
 
+	if (offset == 0) {
+		/* Update offset relative to the start of the variable */
+		data->offset = 0;
+		return true;
+	}
+
 	if (dwarf_aggregate_size(&data->type, &size) < 0)
 		return false;
 
-- 
2.52.0

