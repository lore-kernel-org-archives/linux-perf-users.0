Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970D3EFD2D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078956; cv=none; b=RK5zG40gP2+YYbG1wuCMpLIjAcniXB5BX91NBkiSG2LCS0xQ3biAeFldLq+QEp/mM+H8AEcawlTjcqV3Rpn8Pecjsf3T/e9A71EXw0PBknZHSk5mqysxkibsQS7fT/cQ4QaPpB0I3gw0OaD/yhdGBlXRt30g46+LtqK7zMcKQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078956; c=relaxed/simple;
	bh=erA0vHZIXnreUGcKUqzendnVvXL5q2Sfskx4F/EgGxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuIpz7bnM/u6fhpJGAEfe2pWYKxv7mnuy3VRknY76XJhnlR8LEHnUP+hk1NKv3ABOa2YDge65s/9op7x239EkV+Ac8uRrTTTfwif62+Vw+gcI6ifIl/agWgKAeRvdnGECS+R0yJBa41sBDSsCvuWdmACsi5MWbzr9uotJYoFK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=Lzm1qa6F; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="Lzm1qa6F"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64aedd812baso10687011d50.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078952; x=1773683752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YE2mHU6KwCoEtF8g4jF0uyxyhHL4Ep5rBF9TlDHsldU=;
        b=Lzm1qa6FwN6RM5XWnNzXB6uPAwBJCyyP6eF3mxVEjojo7KoECtu67xW0OdXvaneafb
         A2u69V/4dyGiGzn3MSduDDf9aB0RrUVAQ8r6DJ0yjfvUheVCbWC1NF4iI3YJzfVumtI6
         AmaM4WmMhgu/EzlZ+bguovm6oBtow6fb2NIUr60s4lAeS31PuKI2eRfVrHd6pwFX3aco
         CCZKwJQTd9vGWx53PMlp2yXe76VB5uRHEH1IXK7++fa8Exovg+b77T61MCV0tJVdhACF
         dj83+IF8Jat9RjCPnlfCXdiKbd4uPi40n9RUZFWBCHwnZ8FfKfWsPQYqZg8X+iHVxOl7
         CrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078952; x=1773683752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE2mHU6KwCoEtF8g4jF0uyxyhHL4Ep5rBF9TlDHsldU=;
        b=lIwV/OmqcEo4Hek4tl4ORx6JQ3RoCPTejWMMt1KENglUn8kes6K4iYKtQzRMA2a8DO
         OyL8zRPeXFfwM3N74k4pqlZ7d1fhZUqy/eg9d+ql8bOlClFV0XZxny37FbB2K2WwOq0I
         aeF/u438oJIhbH4AQSt1/Q2O+Z6NYxcOL9f+6xYLwXDxfwr6ivTibAQYsAXCxZvWSXdx
         oT9C2BzFo3jREh/deu+E9v+zjwpGA3yXzomcI/5nFKmoLNSMyITFlW5Hcjg5pqqycAaw
         zIpHNXBT83Z1B/Eqb7ugjIkEu/A3us5dR9pHIbBeGEmfJKQIvHrQsdaqrBKKFXXgVdeG
         DGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTP7X/hU/48YxIj2DwZdzXR/sgdXZdtC4BGnVLVMx/0/VNx4MGLM3FFD47Ayg8TRHGGlLRBL2fafK1fPyCrBKp@vger.kernel.org
X-Gm-Message-State: AOJu0YwvzeImmc6fgD7njg/4+zuuyCqSAF2rynaHIzyeAOlY2XqemV7r
	e7Ge3TtOSsfoYbinUOWeOUMNXVDYrm0gmjJqA9o0iyhMc8pCXkFQrkY0AtDrtmSigZlQ5nEeaph
	M7xY8YA==
X-Gm-Gg: ATEYQzzW9M/D/WS03d7ji162/RIub27KPQ5GZP+qR97Q5tyIehZPji8/SQJ7l1UfUzk
	4iBrTU9FdSLGMckiISmrVmuc6/KS/iOJ4kSKOUanwnSMBlg1+p1q6ManSrI0AC11PUvyFF3EFJP
	0pUS1iKOgm8byH3f/CnL1Q/rFfZFvaBLbhrmB5seTgtMmQoPNV57L+CLFXV19++KPAD0/nrfqfy
	r/z1YralCpUNpZqT0ITGwM2qorAT7Cx54qT1nKfGQw+DlW3+ulhcvl9qwn7EUVU7Kgbc+UwVDoV
	AxzmKwJS14qPcnjh/26eJjYeG2pz7lC7fVIMKNhnG+tILRMUxo4u8HmxIED5ky/79KL8y5d3OXq
	gkMw0ipE/Z31+OzZFbra3yujq14WtUsocURGBZqfLeQMrCdliS65Omk85CPjzfu1THzS2Wl3bLK
	52ZTmpouo/fE2imMjZi2tB0c/XMEWKOuU6KhzfokMXfKmMfb1OuQ+yvF3c
X-Received: by 2002:a05:690e:b4e:b0:63f:9ff9:1493 with SMTP id 956f58d0204a3-64d140a3665mr12225298d50.2.1773078951619;
        Mon, 09 Mar 2026 10:55:51 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:51 -0700 (PDT)
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
Subject: [PATCH v2 00/11] perf tools: Improvements to data type profiler
Date: Mon,  9 Mar 2026 13:55:13 -0400
Message-ID: <20260309175546.916039-1-zli94@ncsu.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves the coverage and correctness of data type
annotations in the perf tools.

Here's a breakdown of the patches:

Patches 1-4 improve variable type matching:
- Add die_get_pointer_type() to properly handle typedef'd pointer types
- Preserve typedefs in match_var_offset for consistent type handling
- Skip redundant check_variable for die_find_variable_by_reg and
  die_find_variable_by_addr since match_var_offset already performs
  sufficient checking
- Improve type comparison when variables are found in different scopes

Patch 5 handles array types in die_get_member_type, allowing proper
resolution of struct members that are arrays.

Patches 6-7 improve global variable handling:
- Allow collecting global variables without symbol names (DWARF provides
  the address directly via DW_OP_addr)
- Handle global variable access when a register holds a const value
  with negative offset

Patches 8-9 improve caller-saved register handling:
- Add invalidate_reg_state() helper for consistent register invalidation
- Always invalidate caller-saved registers for call instructions per ABI
  requirements, even when the call target is unknown

Patches 10-11 use DWARF location ranges to improve type tracking:
- Track DWARF location lifetime to preserve register state across calls
  when the debug info indicates the value is still valid
- Collect all variable location entries instead of just the first one

Tested with the Linux kernel vmlinux with sampled functions and five
programs from binutils (as, ld, nm, objdump, readelf) with all
functions. Coverage rate includes all memory access instructions,
excluding stack memory accesses.

`lost` means coverage loss (only including annotated -> none);
`chg` means type name change. Net coverage gain is new_rate - prev_rate.

         -------- vmlinux --------   ------- binutils -------
  Patch  rate     lost     chg       rate     lost     chg
  ----------------------------------------------------------------
  base   88.87%   -        -         72.55%   -        -
  1      88.87%   0%       0%        74.22%   0%       .03%
  2      88.88%   0%       .05%      74.32%   0%       0%
  3      88.90%   0%       .69%      74.38%   0%       .31%
  4      88.90%   0%       .83%      74.38%   0%       .17%
  5      89.11%   .01%     .08%      74.41%   0%       .01%
  6      89.12%   0%       .05%      75.33%   0%       1.62%
  7      89.18%   0%       0%        75.33%   0%       0%
  8      89.18%   0%       0%        75.30%   .02%     0%
  9      89.09%   .09%     0%        75.24%   .05%     0%
  10     89.05%   .08%     .09%      75.53%   .03%     .03%
  11     89.97%   0%       .10%      76.63%   .26%     .07%

  Total: vmlinux  88.87% -> 89.97% (+1.10%)
         binutils 72.55% -> 76.63% (+4.08%)

Changes in v2:
- Reorder patches 1-3 to avoid temporary regression: pointer_type and
  typedef patches now come before skip check_variable (Namhyung)
- Skip check_variable for both die_find_variable_by_reg and
  die_find_variable_by_addr paths (Namhyung)
- Add dso__kernel() guard for const register global variable access
  to restrict it to kernel DSOs (Namhyung)

Zecheng Li (11):
  perf dwarf-aux: Add die_get_pointer_type to get pointer types
  perf dwarf-aux: Preserve typedefs in match_var_offset
  perf dwarf-aux: Skip check_variable for variable lookup
  perf annotate-data: Improve type comparison from different scopes
  perf dwarf-aux: Handle array types in die_get_member_type
  perf annotate-data: Collect global variables without name
  perf annotate-data: Handle global variable access with const register
  perf annotate-data: Add invalidate_reg_state() helper for x86
  perf annotate-data: Invalidate caller-saved regs for all calls
  perf annotate-data: Use DWARF location ranges to preserve reg state
  perf dwarf-aux: Collect all variable locations for insn tracking

 tools/perf/util/annotate-arch/annotate-x86.c |  69 ++++++---
 tools/perf/util/annotate-data.c              | 119 ++++++++-------
 tools/perf/util/annotate-data.h              |   3 +
 tools/perf/util/dwarf-aux.c                  | 145 +++++++++++++------
 tools/perf/util/dwarf-aux.h                  |   9 +-
 5 files changed, 230 insertions(+), 115 deletions(-)

-- 
2.53.0

