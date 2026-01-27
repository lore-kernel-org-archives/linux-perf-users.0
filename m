Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53302C08D5
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479604; cv=none; b=Xo6BLNzl+cyPsfiU7NGj7a+M2/EVdG7snO8HXvB0d5410zdnHkbo4/uxwETmvtwKN+5HIpA4MSkgeEuQuIC21FD4eqyQSpFBe2MewpQyfBQXB5Wokh79IJcnj2I+mhaOH1pv4tv3MVslOcR6VYpw94BGnl8ijTdDl27bnJKlQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479604; c=relaxed/simple;
	bh=/ewm3WATBiT0DnxOwn8y9wg14IR21nssXLkB3T2qWfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGUzm3Uk6FY13O40T1DWiJwIdoKa8aScklAJoclZ+rgVo1L6Pt4lVuoGUBJDlqixm1FPw5g/MfFqgIK0yPWp35MWMvrcsGNvLLtwJF0QYdtYN6J+lTt/VelvkxFzWYAPPwLEVoyK1s1G6TDVPireRfBRIhF/Ywiwsw4C/UiTNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=Co/0hxmy; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="Co/0hxmy"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64960418d46so3191268d50.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479601; x=1770084401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUTDEas+pFI9zxM7B/p19P+ipqufAuvebaix0EtFBQY=;
        b=Co/0hxmyI3nuwg11HZBvmBXiAVQYX35HSgWpBEIcPcmWFd8ljQ6ylnQY0Mx4DzxOeI
         DV0T53ZinfTM2FUnJs6l5FJl9SR1ASzrqmIi1WwNOo5YDqvBkqMhL3K3pbmyOogP2ETn
         1Sx895o693ic1fyUV7X9L8xTqGxxCqicGtoTlVsp7mlcFg5aCR+STHNtf/3vfulozxw9
         neiL2mPjMoS9QoXihdKSHUGBlBm7RGhKX/6jdmbKJf8IHvaqHL5JKtocTNNX94d9gNmr
         g/tl8Evyr0ingYEifNZU894ex6ZIeqa5IeoLKx3DrGKSSAtuBQwgWvFSFkucJDP6pSkQ
         v99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479601; x=1770084401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RUTDEas+pFI9zxM7B/p19P+ipqufAuvebaix0EtFBQY=;
        b=TTfL074JsX+6hCwCfOf8NydPOt03gnsiob4aMW+fJEAz7UQTTJKQfw/ykMKhU0LTO5
         hsN70KAou1a7ZTs+FKoqY6Fn59v4TPFQ3LUZyL+L4pfPlHHxbcyTm37o3JWeMbNCCvRu
         Bpp9QhdicNvn3kuR6dssIj3uANMKs5+gpJGey8lblyiTOIjDY/sZd33IHymcO4nE45+Z
         Dr9Sst8dYYx7QY2dKIhVl/CXrfoCGWYdj9w3LdmbXSmMvblgWbuBj+j3B5N23wWblhp1
         U5jPEqkAC+PGDBnOAPo4WNGwDOjDGPsd7+1CkWbvEo5VhWwk8b+b+cAJYH3LEnpintSD
         EY1A==
X-Forwarded-Encrypted: i=1; AJvYcCXbYdK61bpifCv/j4U7cfNHxfOrAd8YU7kOBn5vOIa6pM8KVwEcpdbXXgohbD5/riYxU65yueflX0mAQJixtJ5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6JzSvQ4jF4GGPG2m5EwZCdOwbt0KU8O5bQnoYKCoODTDvxpa
	8NXTPwtPqe0U0/aOJAINSf7swc4g4HMtYOC253KXZEcNJu+H5P+8Nqc8L8j/FoXkgw==
X-Gm-Gg: AZuq6aIv/8xEv03VGlccv85BgPj753iwSA7RFkERjI7qNuR7LcLPCRk3SUaw4X8HLRn
	6gk1KZShXE6r3nOPhgamjx5Wm4OPoIadn0xIiB2182bR6tFAIOs2GT+lut7vr7X/53g45HHiT5n
	nnH/S9Pd1xfPCKf2Cp76QeaJiBc/XM0MKcJ9XUWcIu3ciiCva8YKyWFt08i0bcuH9vU11vcA7mV
	0RTSbEuy9O91/WTN5QCCNZrKDE3jSr0LPsekEOs+Ao9TKL81SnfKtYoPILe4buhDHA0PS9g0MqG
	blHWuPwKg8C1z7I6NsgjFSJxmBhGkB6G96rN3v3m+nEe5v5VQuN0Owngag5J/YC3xILNkQLSYUj
	iMNjhhAmPEIllWLop4GDVLuwI0HC4jt3eUz6IgVNJDdxHcLWxqg+sgrk2fO+tx49N1u2bO4wWj/
	RLhbrrgpBnMA==
X-Received: by 2002:a05:690e:4088:b0:63f:9c70:84ed with SMTP id 956f58d0204a3-6498fc46089mr694d50.58.1769479601298;
        Mon, 26 Jan 2026 18:06:41 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:40 -0800 (PST)
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
Subject: [PATCH v1 07/11] perf annotate-data: Handle global variable access with const register
Date: Mon, 26 Jan 2026 21:05:00 -0500
Message-ID: <20260127020617.2804780-8-zli94@ncsu.edu>
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

When a register holds a constant value (TSR_KIND_CONST) and is used with
a negative offset, treat it as a potential global variable access
instead of falling through to CFA (frame) handling.

This fixes cases like array indexing with computed offsets:

    movzbl -0x7d72725a(%rax), %eax   # array[%rax]

Where %rax contains a computed index and the negative offset points to a
global array. Previously this fell through to the CFA path which doesn't
handle global variables, resulting in "no type information".

The fix redirects such accesses to check_kernel which calls
get_global_var_type() to resolve the type from the global variable
cache. We could also treat registers with integer types to the global
variable path, but this requires more changes.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 970238bc81b7..177aa6634504 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1230,6 +1230,10 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		return PERF_TMR_BAIL_OUT;
 	}
 
+	if (state->regs[reg].kind == TSR_KIND_CONST) {
+		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
+			goto check_kernel;
+	}
 check_non_register:
 	if (reg == dloc->fbreg || reg == state->stack_reg) {
 		struct type_state_stack *stack;
-- 
2.52.0

