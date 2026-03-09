Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DCB3F23C6
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078959; cv=none; b=cvYnHq3onKoujla3/nqXmspHJzNiNUFKqGwTQTB+G0dKhp+cUPJRgKkwHLI9AkhVIDFByM+XBdGsV/d1jD5gnyoIcPAsxHhi32ODhGCBWynkGKQvRAmS4isBSTtxMqXqKARToT2OTNShhqIztjpIGaRcvEcm5+3myw4rwUEGyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078959; c=relaxed/simple;
	bh=gr5gzJz+zJGQrTtkuM3wSWcpKQ5StwlicyaLJNKlcq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2XxQJpfIuu7bDmOZ9MKu/3z6hQMRTU7lHSBhLIHBUTmGKDFOy6HvDI+BD0wfGhvJaRpVR1HJQQk2LjdemeaW8szblGrt6iX06wj8fNfUpPoIWloMtT+CtWlrq6o365EvUdh7OJGVtIqVjX4aI56TSYCQUd7NGT1eX/UMcuOVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=J2BgIqRf; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="J2BgIqRf"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64c9707fc11so8831531d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078954; x=1773683754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejER9XjyWi4jI3dlIAUxOX0udAsfG8pEAsk5mvY+7tE=;
        b=J2BgIqRf4P4r3NWQVSgrDsiQ6aHB634LBci6lJez0270GAja1tQvlmVHFsmJNI7wwD
         Pr/JbWw3iYmYNH2vMZG//oRS1uaT+Qq2BHzYenTKiySNgiXqBk1Lwy/QxFwiWPNbDaYp
         hm7UTvDu/Bs0sREVynN+QAs8D8VWbBxJY5DdqXZ5mOmxmKsLnii+heAJ/xJCZcgpGkB9
         XWoVWRF/LseXCW75XOyDj5wtVywrTKFgQX85K9F2L2NtbN/qEqep84+BA0PTXBEkHYYq
         VUyHKACzELZxhrfhRhDVuLlsVkrFo+QsBGz3+zAHe+adp3YxZlKSUZmGGZzn9DcXTaOc
         Rd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078954; x=1773683754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ejER9XjyWi4jI3dlIAUxOX0udAsfG8pEAsk5mvY+7tE=;
        b=RiDFQEIOIt3VlBKpE0SUZGsPlDrs2Db3jS2rlmyBfu7CVJLT/3fYAZauD4LRdrAprc
         PtAHKENLsoONSm5EDTd4DgnuJNrBaz3jkkwwhkfuTcP72PvoAiPboHhNx1wmHJL9TGlZ
         UbK7ucg28xyqu/BoJpj6v7FrqsFd50Qws8UOI4kSTnmKHNkmv6FST9sSSU6e5Nn6ew9P
         8AP6KUPoPtzsdUcwf7vPidAw8lhTvbkp+notNNhKaOJieNY+cuLdPA5qQ+SUm0mQFwKT
         +TJarFN7kKCjgVUub6I/W7iL+ZNTV5efd1y+NM6ao6li8TNZ2BrYQ2l/GIJch9O+cadL
         EOzg==
X-Forwarded-Encrypted: i=1; AJvYcCXTF+OJSxOHFbXx4p1EjpcSfqZlobB0fTlCrwwI7nr/dgM+apwXl6lC6RoZSWmqQanwgOXcUHTjS+wf4AWubqe9@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGQNL2WDtZbRP2em3Tp4Woz0Jj3hz8YzZKeg9gvfaGiFi3jpv
	X0roCoz5JY8NT07XY0H/fXr6jkH0ARMD/wzlFrIImS1c0KEJ3YWi8am9zkfYiFF7tQ==
X-Gm-Gg: ATEYQzy3FPj5/rWIBu2pcA5hUK0xTs2u1PQ4vITiAMn1s/zx3qKVUyGbFxhgLsFfPys
	Gb1towlO1blAqQdkBzRFSGa8keUEfYn2w0PK7hGyLKY5OthjfXdq6P7MxfteIOnaYsL3HtWhGQu
	q5UvTbdF3hpUwSkvmOjqAqchK2E1W29U3JEIXYNhNZ4xjhK0r3T0N4Sbrpwqtacf+u6w+r+VW+s
	aUJ20g4PXFAQejr1aqmtdcVF85MgrAZizNc4nq38GY1aFJ1qwh2X4wu0x7NUEPSK0UV20XgqDa0
	rICKl2RSIVyPCj7rqSutMW5DNLOPkM1aXkX4BZLkLRqGZOdPFDap796nmsH+ZI0IPj4ItjWNwD1
	U9FNoDXl98YKOLKcXbdO7uswSig7oflrOmskMy4J7h9NQ/dtjzwU9JMEbINpTown1vLTOBr8ezu
	Sye+oUJFBOt4YBe0zmOSZSa4sBsGZR7u40kXGAIcJglsuQ59SYAN4ZaE00iNyaFDAfe94=
X-Received: by 2002:a53:e194:0:b0:64a:d6eb:6e with SMTP id 956f58d0204a3-64d1436ec4fmr8312416d50.80.1773078953722;
        Mon, 09 Mar 2026 10:55:53 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:53 -0700 (PDT)
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
Subject: [PATCH v2 02/11] perf dwarf-aux: Preserve typedefs in match_var_offset
Date: Mon,  9 Mar 2026 13:55:15 -0400
Message-ID: <20260309175546.916039-3-zli94@ncsu.edu>
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

From: Zecheng Li <zecheng@google.com>

Preserve typedefs in match_var_offset to match the results by
__die_get_real_type. Also move the (offset == 0) branch after the
is_pointer check to ensure the correct type is used, fixing cases where
an incorrect pointer type was chosen when the access offset was 0.

Signed-off-by: Zecheng Li <zecheng@google.com>
Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/dwarf-aux.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 38142062d6e5..3b0fc9038f19 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1405,6 +1405,8 @@ struct find_var_data {
 	Dwarf_Addr addr;
 	/* Target register */
 	unsigned reg;
+	/* Access data type */
+	Dwarf_Die type;
 	/* Access offset, set for global data */
 	int offset;
 	/* True if the current register is the frame base */
@@ -1417,29 +1419,31 @@ struct find_var_data {
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 			     s64 addr_offset, s64 addr_type, bool is_pointer)
 {
-	Dwarf_Die type_die;
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
 
-	if (die_get_real_type(die_mem, &type_die) == NULL)
+	if (__die_get_real_type(die_mem, &data->type) == NULL)
 		return false;
 
-	if (is_pointer && dwarf_tag(&type_die) == DW_TAG_pointer_type) {
+	ptr_type = die_get_pointer_type(&data->type, &ptr_die);
+	if (is_pointer && ptr_type) {
 		/* Get the target type of the pointer */
-		if (die_get_real_type(&type_die, &type_die) == NULL)
+		if (__die_get_real_type(ptr_type, &data->type) == NULL)
 			return false;
 	}
 
-	if (dwarf_aggregate_size(&type_die, &size) < 0)
+	if (offset == 0) {
+		/* Update offset relative to the start of the variable */
+		data->offset = 0;
+		return true;
+	}
+
+	if (dwarf_aggregate_size(&data->type, &size) < 0)
 		return false;
 
 	if ((u64)offset >= size)
-- 
2.53.0

