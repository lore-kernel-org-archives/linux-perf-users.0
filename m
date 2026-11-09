Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232106;
	b=QXLAhw24SL8/mUfHBJm62c1RQl+6IOrUBn7sN4l8FZuQ/DSR/qT7swtg3srM6Vk8egFw
	 RtNZq5KZY48d3rC6vPGv57xroAJt15A53gT+r0nDeceX+0rHip5SmPPtWhi8vyU+jxCQS
	 h1rDwg9CW8dsiDkH70qCCDPJzbfjZHnHoQl04Xc/zfyyZrK2QR24+KQ35Oscn07sPAI4h
	 5K4InCPm4GSUU9PmNEI09cqIcztLnXAcdqC+lL7tln9NGjGnfhe17ORbguvZNWSAFg16s
	 CHDyVpzUyKQeXibhAU/5cZPP4h0vWOrUbHj2UIpcuSTCNJasSnkQjs4yCGFYRwV0+hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=bvVa3bulUsYqSwCXV6o2ClwLUYzLh1XdnIqlWVEHka4=;
	b=KJh5EqsSQR1HCsIVMLogtBjK7WbqAQ6//WsvLVee6Bdoed4cxpEUNtJH4IWaebew/dUT
	 wWpR66l3KrSXDapQQ+CHV7ZG3/oiFGdIpUdC5hWRDXcJVOP1OfaX3A6viXcczltZuGGzJ
	 7Ocxc2fz5gt4XXlNmNTYnejWp7LpA/5myueg7t/u6yu7SqUywjIHHOGzpUafoWRxr2rFl
	 QwN4C/XjS7/mF3J3gwcQ6gTZpQeR4PaLxEgIvASZ9XzbNVEDhg38O1BZjHZ0HnQ7cYGi9
	 SwiRbxc63Mr61eL5tyhK12KvB9SjwJ5EGG23FZitIlhBzBOab1F/TN0xO+g7Dae+U2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bQ1u8Cx6;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26B606D803
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD26B606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bQ1u8Cx6
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso9726415e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 05:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794232104; x=1794836904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvVa3bulUsYqSwCXV6o2ClwLUYzLh1XdnIqlWVEHka4=;
        b=bQ1u8Cx6ADf0WgR5Bas7K5VpPdlLILisbMB0KN7Kj3GFh/HlLT+erO22gSTeleDybd
         OWTzCEMEUgLnp8Jc1BggaM2xXERnVAVSpuYr2TFt+ys2ajVfBMr4FTQGtZA5OL5mVCh5
         Tfzz/Kigt9UVQDQaCmQ3cRx6xAg9jk0gl4GZl4FsPqYDdMp1N+Gxidru9SXH92EiUl8S
         aFI//wTPFs2gZE8H77d/gLDny4SASMaDnIV1LKX5zJfeg9eHYatQ0WZj4mkKn8QqZE6D
         0RqcvIE1ZmFVwt0FsPoqUU+JYx0xFNZRsJWjStHIJr0fyWxZyP4pbD/ZElYB8NUzYWeE
         lJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232104; x=1794836904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvVa3bulUsYqSwCXV6o2ClwLUYzLh1XdnIqlWVEHka4=;
        b=GOs2Ku0K4TF6TtVJIw59+2noPg8C5R46RzGCkN+dCQ4qUuydK5LYeNCHHIRWxQ9VeZ
         k+FxlOPq3SRTvKE+2CecDOQd7oRCE4sFiYmsLW0t8Vlh7v1mLEou7ir0xtOMf+sGSTgL
         rIrdxniBI8v+dcKAgrboS7TidmcD0CKiNhv+hMer7XbEsvl3WMB1ZS5Z+O/RP66eu5kk
         XJ22sROeu4UWR3TwkhoFtMsjiXZL/k3JSPH7ftzQCsPbDa790PGMh/yTK9Y6sysfwLW0
         QeuP4C49R7ZKxYwc+zvSUHvZwpeOi4pK39HaK7ocZgE6aFymht7je1oTLn0cRGArL5gh
         hE/w==
X-Forwarded-Encrypted: i=1; AL+hErFjb6w7SMLSw6ZZldEMon8tZ5wYHtpLPIodOo4gvJk/F0Nw/CE2p7s/AocQ+knCpqQsKZrE+GARvX9SE7sMAcXW@vger.kernel.org
X-Gm-Message-State: APuU4Z//GR4P8AcfGKMyj01lkLP4pFjxKbd8QF8NdwcZOymkPSmBTqu1
	R0t3/FXThtVe3BgMsp6IWI3Hjr4E+BPfzkpFNL+O0WJFBl9ojThGC/R4tCHR7twd8j8=
X-Gm-Gg: AYBFou2eIGiZ0plU9FtyK+VMLvhmaDr3htF50eWwU8dYPAOa2E8MaumtgJWwixcSlR9
	2ry61x3HBu1KkfyV61/uoS6rFbsBy+eNNb4mi210h9uEeZMD7u4EVr9/dEMbMZurja90rXA+kB/
	h61rS2Rp4zD3Sdr/IvMJs1hflY8TUSWD0zoqlhbXxVJU2XpITIWz0wAtkehXf4QI9SGWWg15xBq
	DGSfpOijFzGGLBVGe3hIHPZmp0eI3/5G1OyobCBWmatDyRtAWwAqnuVbhFTTDhFBIhnxIyw9rDL
	YRKCGWGWbJTuo3c5klXuacRnUuhgjTzRvqCrYOHaRn8t43zx3htwSEAucUsCOOtTKA7TzEqeEHI
	fkhY30XjA4AiZggd9LFw/0ohb8gCYVufHkqg5qKTF+/yeXDl2ZuTZTE48dgMSRywTJP18iKsN/g
	GDDxIZflyPqciA5AWIbV3V9hS7sEkbzkTTrtRTeTI69PPuMa/sClosZ6/9lR02zP4LPeS0IG3Mf
	qDwuRq0ZL1Dv334G7nvyNhqW+1CkY4n6ADfyU9LacMwQRt9/ywRI7QnxxCAmdgPStTauaeX0qK/
	K0rECQ/LukkPFhm0NJ3Xo13QzrmH/HSa
X-Received: by 2002:a05:600c:6087:b0:4a1:9663:7633 with SMTP id 5b1f17b1804b1-4b963c6cfc2mr74331665e9.11.1794232104174;
        Mon, 09 Nov 2026 05:48:24 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7bb101537sm98522045e9.0.2026.11.09.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:48:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Nov 2026 13:48:09 +0000
Subject: [PATCH v4 2/4] perf dwarf-aux: Support DW_OP_addrx locations for
 global variables
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-james-perf-test-fixes-v4-2-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

die_find_variable_by_addr() and die_collect_global_vars() only accept
global variables with a DW_OP_addr location. DWARF 5 producers like
clang use DW_OP_addrx instead, which is an index into .debug_addr, so
global variables are never found when Perf is built with LLVM=1.

Add a helper that also resolves DW_OP_addrx and DW_OP_GNU_addr_index
through dwarf_getlocation_attr() and dwarf_formaddr(), and use it in
both places. This fixes the "perf data type profiling tests" test:

  $ perf test -vvv "perf data type profiling tests"
  ...
  Basic C perf annotate test
  Basic annotate [Failed: missing target data type]
  ...
  Pipe C perf annotate test
  Pipe annotate [Failed: missing target data type]
  ...
  Basic FS perf annotate test
  Basic annotate [Failed: missing target data type]
  ...
  Pipe FS perf annotate test
  Pipe annotate [Failed: missing target data type]
  ---- end(-1) ----
   88: perf data type profiling tests : FAILED!

Fixes: d60469d7c0e5 ("perf dwarf-aux: Add die_find_variable_by_addr()")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/dwarf-aux.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 4cc231ffcb2a..d972c121171f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1666,6 +1666,27 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 	return result;
 }
 
+/*
+ * Get the absolute address of a location op. DWARF 5 producers like clang use
+ * DW_OP_addrx, which is an index into .debug_addr, instead of DW_OP_addr.
+ */
+static bool die_get_op_addr(Dwarf_Attribute *attr, Dwarf_Op *op, Dwarf_Addr *addr)
+{
+	Dwarf_Attribute addr_attr;
+
+	switch (op->atom) {
+	case DW_OP_addr:
+		*addr = op->number;
+		return true;
+	case DW_OP_addrx:
+	case DW_OP_GNU_addr_index:
+		return dwarf_getlocation_attr(attr, op, &addr_attr) == 0 &&
+		       dwarf_formaddr(&addr_attr, addr) == 0;
+	default:
+		return false;
+	}
+}
+
 /* Only checks direct child DIEs in the given scope */
 static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1673,7 +1694,7 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 	int tag = dwarf_tag(die_mem);
 	ptrdiff_t off = 0;
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end, addr;
 	Dwarf_Op *ops;
 	size_t nops;
 
@@ -1684,11 +1705,11 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 		return DIE_FIND_CB_SIBLING;
 
 	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
-		if (ops->atom != DW_OP_addr)
+		if (!die_get_op_addr(&attr, ops, &addr))
 			continue;
 
 		if (check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->addr, ops->number,
+		    match_var_offset(die_mem, data, data->addr, addr,
 				     /*is_pointer=*/false))
 			return DIE_FIND_CB_END;
 	}
@@ -1814,7 +1835,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Die type_die;
 	int tag = dwarf_tag(die_mem);
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end, addr;
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
@@ -1829,7 +1850,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
 		return DIE_FIND_CB_SIBLING;
 
-	if (ops->atom != DW_OP_addr)
+	if (!die_get_op_addr(&attr, ops, &addr))
 		return DIE_FIND_CB_SIBLING;
 
 	if (!check_allowed_ops(ops, nops))
@@ -1845,7 +1866,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	vt->die_off = dwarf_dieoffset(&type_die);
 	vt->die_tag = dwarf_tag(&type_die);
 	vt->from_alt = !die_same_file(die_mem, &type_die);
-	vt->addr = ops->number;
+	vt->addr = addr;
 	vt->end = 0;
 	vt->has_range = false;
 	vt->reg = -1;

-- 
2.43.0

