Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BD3FB05B
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078964; cv=none; b=XtrV4HVfE8N6V6GD69zUygBnqDfeQ5F+TD4FG/KYWSIs0w3+6kyFrSRaDbDn2hDuJixyH7GNncn9qucK7f0h9xuCUygq5xGYP64vUDwuAbG1hx1Kzzq+vrDsn2rAYEqc6xApJIbPHVGrKhV798taG3HPIMHF/ag6Y58IGvLAKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078964; c=relaxed/simple;
	bh=9uNtpknv29cmQteZhSGGznRmJ73KHryeX5TUxc7eu8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOCElQI4f/uMUetANDcUaqZMNfth60Si1QwTZht7Sz+Pc8oa1zEp6J5yHCfGYW2bYi0gZU00RTd4TIXIGBLm4DTgRc4z5QpCRQ4n9aF9Jcw4A5aUw7bfKhLFkEPeiKVpcWrheLGwgXmM9P4Ewm0V1xsZLiKZzXjdGBah4FxHpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=ONcZWxa6; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="ONcZWxa6"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca2b32f46so8897457d50.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078959; x=1773683759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7oosy5/acey/h5OCheMNJ9lzD2RKykZWn+tBKBfRfY=;
        b=ONcZWxa6FsK3tMxk99UDimwn5IByxqxiUlAgd55fWChkCAlnRNfkuD9kMhovTF/hY/
         I3w+UcVv5dtEhhpw3r66WHe2S8r87M1gPErcHlP18xcVXj09IYPIJStECEFkiKhi8G6N
         5b0O8uidN7H3qG4IvlDiLI/DNxPdDMQp9XufLr73r+Eixb1SuyOgH0dpnMer7FdbXaoQ
         9LK5DhyZ98zlRDUldI7BG22nHolw0i3KW68tA+b7VcumrjsRsnGK7oBBmFwarbV3J6QX
         LDLXZFY4Nl+NVzqZ8rBgxSEZvQLqFzmfBvcTSfYBARjdmtvMqgvFIm+w5ZrEfO024p04
         SCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078959; x=1773683759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S7oosy5/acey/h5OCheMNJ9lzD2RKykZWn+tBKBfRfY=;
        b=vJ0M2in7r8C/0hEgrdXMS8HRFbYauzSkCmmwSKZ7MrGm9Y8yZ+t4QZl2M6K/V0Q0oY
         td2CfdSlWDP6ATY6GhkKIv4G5XmBp9xMHjDezWhDTbuGbRVrSjSx5Nmk99xpM93RSunR
         c2nv/FAnmPLG+pWfiMg44XdHnyexo1g/hU0uZRnWQrYZocerDCh9ylgLYGZv+o64TEUn
         DgFjkktfGv2g1MpfUf/MltADYtFM+T1/JEP3uOzKAqK9CRLlzJpLTeHoQ7DDpEnn7Yon
         gA82Ge9eg7prGfxeWbYGVySAoG0jwBuM2W11zAptWYLRKTxSS9/kKRvjEKQlOGo6KHas
         5JYg==
X-Forwarded-Encrypted: i=1; AJvYcCWk+VpEBODZQLFW0mF0NGM18WMaNmzqzwUUpgwfimuhqk4pwp01CYBEMHsuPtypmMKMvOSpz6W9U+GbPQMixQU0@vger.kernel.org
X-Gm-Message-State: AOJu0YyipAErcwumSrYEt3SnGmijGNE4q0Popd8ARFvTRvGp1sWmbHOw
	Q3aIHoXf6Al/1WI6qPvUAp9UFn+WyEycaaQX9f+dhsyTBfSKQX4qv6uSb67RPihb5A==
X-Gm-Gg: ATEYQzwK796C6UOrATNodxJjG1MilBjFYyN5jvI3X6afHVlYW8m2uqi/VHW9vCWgYrq
	oLqb7oboB6GVvXkn4CTg74YVdk5G9Il+79Su7KrrY1iG5w76/0DZrXlPVPziLd1MTOFBUnjia0o
	EWsZPgcIg19/SnJf5bX0qO1Okr7MPkjJwiRjYpYeaC+PxNeAVqOyhE3OwBG9Y6UVBwjA3eXJVrj
	Hlhn4VEOdAPOw62Ry9x4DJspABrc/J8yOkaHwwvY0wCxjYxX19Zpz9+1MyCRGWy9qihcEWh6zVc
	Iu3RusNnny576kZ0vwVzZJadLnjS2SfVVTAznQdL1ITBmuk7MT+y93JO42Zp1rdDEE4ew2BWQBM
	/N78+wgI2kBdvyp4wNfPaH2oarJefN7lzX9AooJvXYcS0wo9ET+ITLAKPm0qVN3ucqBk4xWDYqV
	vpMuHj+Bj2HpfqcTlrXDxAjeZEYoMO2NYAprmgPEEY4UUTs7yHw3YTw0BN
X-Received: by 2002:a05:690e:118a:b0:64a:d80f:5cf with SMTP id 956f58d0204a3-64d141120b3mr11987752d50.25.1773078959162;
        Mon, 09 Mar 2026 10:55:59 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:58 -0700 (PDT)
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
Subject: [PATCH v2 07/11] perf annotate-data: Handle global variable access with const register
Date: Mon,  9 Mar 2026 13:55:20 -0400
Message-ID: <20260309175546.916039-8-zli94@ncsu.edu>
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
cache. This is only done for kernel DSOs since the pattern relies on
kernel-specific global variable resolution. We could also treat
registers with integer types to the global variable path, but this
requires more changes.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 301f73ea8275..50c82c91f828 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1229,6 +1229,11 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		return PERF_TMR_BAIL_OUT;
 	}
 
+	if (state->regs[reg].kind == TSR_KIND_CONST &&
+	    dso__kernel(map__dso(dloc->ms->map))) {
+		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
+			goto check_kernel;
+	}
 check_non_register:
 	if (reg == dloc->fbreg || reg == state->stack_reg) {
 		struct type_state_stack *stack;
-- 
2.53.0

