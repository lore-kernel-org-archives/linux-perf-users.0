Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962119;
	b=P+I1hwJIXl3eOs3pC87ycyMb3jXUZkSGigByGTo1HOj04IbX2UGoYaF4SOG2aWbtn1vd
	 fMNqGXvy2DSyGVYcamONpvpxKEE8TCv3gpXIcp60M7+M9YvOEPZNxAYr3qjE1rkwa++X+
	 kluPSus6jRPU954uaPwWoGrZCW3O/h/dZ99usoL+VD9VFhqnAv990uhrWHV0TXVbZ00OE
	 xljYE6v7oRoz78b21kEkpiHLksz8IVGhmlxMhLIaTGNt1eyYYW1g2Y09XJsg9s6vDvTm5
	 uJzX4dhFkzq5eRSQxt2wWP9I1rGZwXu96iiGB1FJp/F/SkGs7/vWfh/v5btZjx5hpcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+NDIW4GYlXIUEZa7G8ChY2/F4l8YQP7LThVem17rj6s=;
	b=yq0AUGDVl6l+9jxNga9GnYnBScS/Olg4AXabEHdp4shPR3H/RaoWnEHaIgMs7mCatMwH
	 SJ0mzqgdV9CUZ/Jya7hfOP4XjJwI2NVY1JYs7WeC42Xt/Akg+rPbD6bHe8GOjiQQZDATm
	 5WPV1fPWUhAvCZ3kYoSD+HpRc9K8f6vp5sQmzabUm7SVNCj35U0+Ei1Z9RA+dCTfmSWgy
	 088wJeyJWxVlrXS4jm4zMfi/zibPgU7jypeM799HqxUouly8pzEQ9bud9VlAjL4hfZUKR
	 KR5NLqkUR276WhLZ+LQpgbv28dA6ebP01L2FgjM3aGdtsN00fjpvyl3Z+Ww+O+ouf1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SEFTbpFH;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBC606EE90
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BBC606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SEFTbpFH
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48fd2e38825so326224f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793962117; x=1794566917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NDIW4GYlXIUEZa7G8ChY2/F4l8YQP7LThVem17rj6s=;
        b=SEFTbpFHSvLhuLD8ZLY6OFEBDgqKqu8thUW5FHT7S5WQjiAqQYAG9Ahg/9DGUSU9U1
         qUsPmJCeC6nZECCR0oz4PmyCtQbwl/shEd+2tn8s7M90lmANszukREymxoj01EXFFSXQ
         3xR/CKllP4ovUgJ1L+a/zmu61nFeWsMVwbuCBLiFufUtVJSgQNW6vUU+Z1HDGAYW8erV
         S+mitXBJy+xBqSl2+C/LWupcS7cbUEfe1JBOMZLMN0K5vPhQNj5PIGdYxEmNmgGttS8q
         CaYCiir5hGZgi65OKXDnhHjx6HPg0zSMbB9RZXjp2YaBc5X/8AmLweJiG7JFJDLxGtTx
         bMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962117; x=1794566917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NDIW4GYlXIUEZa7G8ChY2/F4l8YQP7LThVem17rj6s=;
        b=U3bEY2jHGbeE4DYK+P8LLV9BVH3+9Q7e60swbbXeUQgPFoLarS9A9qvqx9N3wlLZ5/
         JkbpWbmd+o0zyG34nlVjhMZ7aIOJ3QuHXcrUtCW/jKW43SOc3hhwVEtghOGL1ZJZAW38
         r0qHf+g8CtuQZwcaoQ5E9Udxd6ksNIo0K1cEcrMbs39rpB3PCU7/gghoo/FfrNftCitE
         T93BNUv7SFrEjyqFjLZSCuRt1NWFNOYyI89u5k8wPqMQFzdi7c47JfZXwKO9VPlvEMKc
         A/Nz5KYFNi3YBeswPHB9bPoT+3xlBkknm2cjOVaNEI9VOiMd++aUy0gumJRCTZhTuYRu
         Urgg==
X-Forwarded-Encrypted: i=1; AL+hErEahduGBZiPprW0zuTsBbf9iPbzCBYTHy5W4RRyJ842YrqvG9oEuwrU9LC7BiD67eJM9FIIPtKbepuhL8/dUIyN@vger.kernel.org
X-Gm-Message-State: APuU4Z8AEfZKWFx0+Ibsg3by2q3ZqSUlialzhPZ1R7mWq6lY7qYVbAgE
	YG0eMsFNCVXrsyPac6Lgrw0haluz46ZMUfMmI6sdezIGLJznw2AXFdR/WLV2r5mnZy+uCsSBZUE
	x3RMdgOI=
X-Gm-Gg: AYBFou2qNKmwEM4K3uHaaiusDJ0SVQYWuNFgjVWPiUVeTAUoGLIFVM6h34Vegt/mRQw
	Y/BazKlwF8omCgN/1D+bpbnRsu57lCc6qDIqhUi4b52w/lyI0ENdGGpAes/r+ndL6b40dhRzfo6
	7+xcxzQBw/GVsNjKwkeSHDqD14v/sebVwl3UgUhoRbdKUWpylRSmuuITfw8Akq+ro9GT5TKTSDS
	f0hXCOMyi/s0DJWGzagNhqZdIhZZ72U5dB3L1C1GDYe31EL3YQ4eWTJgvwhcyouRa63OCRNyQd0
	jfLvMvix8+PphHnQdMwxweK1cPrbt2jy9wCOIGGlPVewuGJfjgX016yVVoU1VsU7M7YmquNyP6c
	4xHU3WLcGukJa3fecl0G5Lo4mvJtdQO/lGtH2GTa3yD11Z3/VmlQVc+i+7KYpfpyodI9lg/pv+n
	Htu18pPm2Zsh2alYXAd/E5xltpDRSCVR04QjJ2zUKsLgEbpB0sdL3iUZAFQw1vweDYHEniQCIdz
	OleT8CVsac2LrJlaZtjWjuf7RQakyNOrhwQjJdnmGyvjAJ+X13kiADfN71gNEdopxz0G434HEJk
	l5g4VqfQ1W7SHQpJLPZAMlOzmDelLoPg
X-Received: by 2002:a05:6000:460c:b0:48e:666d:c96d with SMTP id ffacd0b85a97d-4927807d901mr3965431f8f.51.1793962117373;
        Fri, 06 Nov 2026 02:48:37 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ae2sm3232248f8f.11.2026.11.06.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:48:37 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 06 Nov 2026 10:48:08 +0000
Subject: [PATCH v2 2/4] perf dwarf-aux: Support DW_OP_addrx locations for
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
Message-Id: <20261106-james-perf-test-fixes-v2-2-9a912662f822@linaro.org>
References: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
In-Reply-To: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
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
index 742fccba5376..2f0c4b229659 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1658,6 +1658,27 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
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
@@ -1665,7 +1686,7 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 	int tag = dwarf_tag(die_mem);
 	ptrdiff_t off = 0;
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end, addr;
 	Dwarf_Op *ops;
 	size_t nops;
 
@@ -1676,11 +1697,11 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
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
@@ -1806,7 +1827,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Die type_die;
 	int tag = dwarf_tag(die_mem);
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end, addr;
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
@@ -1821,7 +1842,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
 		return DIE_FIND_CB_SIBLING;
 
-	if (ops->atom != DW_OP_addr)
+	if (!die_get_op_addr(&attr, ops, &addr))
 		return DIE_FIND_CB_SIBLING;
 
 	if (!check_allowed_ops(ops, nops))
@@ -1837,7 +1858,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
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

