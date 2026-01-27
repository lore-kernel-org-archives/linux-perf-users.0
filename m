Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6572BE7CD
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479597; cv=none; b=B1XHZ9AiuX5dJFeeqCdAUkgHpPdb/lq5BKrSxKZopWfEi2IZID4gwHBD7agLZqR+f9VecHJR7ICSj/uWjsvVg6j1P8KfkrnO+rzSNDd5QAh7iI5Pxc8n+ro3YpT2aVKamI7QBnzeUMpx0bX/jO0sVkXQroiuzNaJgefaW90B17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479597; c=relaxed/simple;
	bh=i80TKajRiEuVneQrCHiSCEPg83oHdF+i7sToJtpIIX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/N8TuOv8LdbcSB6iDREIDOinm8VzfY6X/vUbG7fK7+O/HmiF5GDN4jsTyOn70B8j8DPZnAliK7oJheDLbBv0lmc8YhzZBc6G5/dDKehXH3hAscX+/zPyrQVg8DVw/kGPwItpkhEw0we/cFDR4MKpl5LbyFUV2VqJcKRYAYTIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=FdKqIANi; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="FdKqIANi"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6494a3d92f5so5511263d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479594; x=1770084394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/VSRhcfTfb5hhDHzDq8bEnhOPc5XRtqbWUqCb7o3as=;
        b=FdKqIANipF/LERt6lIEgfSuX5Fbvm0TzO/Zv86/PjQF5YHZbQal+xkBCtveZt9LXJh
         Pa7jilNDhf+yYRCZTDDgEZ5sBRUOXIAl4AEP52oDghjb6KtOEtxinlR56QGE9zZUBKJN
         Nu2k+xHZFcKDFT14bvnu22AQSYtL242CwiECaJFHk0xom8cv/fytQe0iGNP0ERcP2+zE
         rRB4FSWCEbx2zdbO86VwODbbDF6O0ZSOcRoXJHTAR0QFXx5TbC5le9ijxBlDLFgUW3eG
         6sJ+w4fCF4fKShBXx0+0J6pRpPv1Ulu4y29rAlQncBQPxwyD8ulfrt7tMgrw3bzjkwKW
         ywiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479594; x=1770084394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/VSRhcfTfb5hhDHzDq8bEnhOPc5XRtqbWUqCb7o3as=;
        b=OU90vhnMIBKg1sQu0dw5Zn2zeA0r6eXOMfX9q0JggCrxih3UTdxom/jO5JeW7Gar8z
         609YH7XBRpPwwCUzg1uy3UvgPy9PE/HLAm5rWXW1P0N9UyOvxXlCEQ7laaHPpVKj3U7G
         JKZEatujuZkHTHl6sz5qpFyB4BBtYeoyjCv1+9HeabEmeT12zbeV44sQbTEbD389dcbj
         YaLA3eQ00tSwZvXT9ohzVG0bGZdpXkDq9BHOx/F8fOuZX7y+y/+xrT2juSGqJvuZZDuJ
         ersLWEDnWyQi6rf7+oAD3A5Aib1FBUiVY/LdFsNClvaPs1tWCeAIcb13MfYvbjs7uqb+
         0W2A==
X-Forwarded-Encrypted: i=1; AJvYcCUv6RTpWisY2F3KyHfl+KwjYvLQNyxGZzKrybL/wq5mPiBxDEOWCfjpN4vRjc+Kln2eCtheNKyI48+wOXOB5Y1W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87aFDInEo+IFpsP7rX9amRj7rMrIRuJTr7sW9UOQFhplhhQds
	kQYfIaGBADVLvQIhnKd4j/GhMKQLdLoIliSidsnQFMSGLFVtgDgKpv9UHlKzZZXAyKk2maptbzS
	lMaxVvg==
X-Gm-Gg: AZuq6aImp11Lme0vxfovWYXWIKxgzfln9a5IVg8GlNndzAc1mQKsGLHVlogtgmUzg90
	vRbw1LwDlxheDSPOWMHFnYQChr/7S7eG0KdoJLKXYcGn3a9UqMd1S1QcWfxvXhUdc7PqaqO0nsz
	BPlq6AiKhtmV3hP1ddOVcE/vYk4HgmvYNqxG/t+o4gjlo0fmY1kifhfx4uP93ftvibYsYIUWodp
	oOMvUcOq3pLMaOCH14XDd1bp5xVXca7kPAXPzW9QYqpVEMx07BWA2CG8KwXmv2iqStxh38XXUBZ
	DAFaui2U/Zla/81nEvxxB9qIEQ/Lrp073Ujj4Xhkjaa4wjCF7kHPXwVvBNXU1iPFBnK/FEh/66p
	FzI8FDI+l5SqruCO1AvNEyzW06Yw+hIGkz3ErfgwezcMaJPsOiLWzFMprbJUNSl6AXdnhekN3iy
	rmxHKRZ/KyeQ==
X-Received: by 2002:a05:690e:4011:b0:644:472d:db04 with SMTP id 956f58d0204a3-6498fc4c76bmr310d50.55.1769479593659;
        Mon, 26 Jan 2026 18:06:33 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:33 -0800 (PST)
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
Subject: [PATCH v1 00/11] perf tools: Improvements to data type profiler
Date: Mon, 26 Jan 2026 21:04:53 -0500
Message-ID: <20260127020617.2804780-1-zli94@ncsu.edu>
X-Mailer: git-send-email 2.52.0
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
- Skip redundant check_variable for die_find_variable_by_reg since
  match_var_offset already performs sufficient checking
- Add die_get_pointer_type() to properly handle typedef'd pointer types
- Preserve typedefs in match_var_offset for consistent type handling
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
functions. Coverage rate includes all memory assess instructions,
excluding stack memory accesses.

`lost` means coverage loss (only including annotated -> none);
`chg` means type name change. Net coverage gain is new_rate - prev_rate.

         -------- vmlinux --------   ------- binutils -------
  Patch  rate     lost     chg       rate     lost     chg
  ----------------------------------------------------------------
  base   88.78%   -        -         72.55%   -        -
  1      72.95%   15.63%   .71%      65.01%   8.59%    22.89%
  2      72.95%   0%       0%        65.16%   0%       0%
  3      88.88%   0%       .73%      74.73%   0%       23.72%
  4      88.88%   0%       .83%      74.73%   0%       .17%
  5      89.09%   .01%     .08%      74.75%   0%       .01%
  6      89.10%   0%       .02%      75.67%   0%       1.62%
  7      89.16%   0%       0%        75.67%   0%       0%
  8      89.16%   0%       0%        75.64%   .02%     0%
  9      89.07%   .08%     0%        75.59%   .05%     0%
  10     89.02%   .08%     .09%      75.85%   .03%     .03%
  11     89.95%   0%       .10%      76.94%   .26%     .07%

  Total: vmlinux  88.78% -> 89.95% (+1.17%)
         binutils 72.55% -> 76.94% (+4.39%)

Note: Patches 1-3 are designed to work together. Patch 1 causes a
temporary regression that patch 3 resolves while adding typedef support.

Zecheng Li (11):
  perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
  perf dwarf-aux: Add die_get_pointer_type to get pointer types
  perf dwarf-aux: Preserve typedefs in match_var_offset
  perf annotate-data: Improve type comparison from different scopes
  perf dwarf-aux: Handle array types in die_get_member_type
  perf annotate-data: Collect global variables without name
  perf annotate-data: Handle global variable access with const register
  perf annotate-data: Add invalidate_reg_state() helper for x86
  perf annotate-data: Invalidate caller-saved regs for all calls
  perf annotate-data: Use DWARF location ranges to preserve reg state
  perf dwarf-aux: Collect all variable locations for insn tracking

 tools/perf/arch/x86/annotate/instructions.c |  69 +++++++---
 tools/perf/util/annotate-data.c             |  86 ++++++++----
 tools/perf/util/annotate-data.h             |   3 +
 tools/perf/util/dwarf-aux.c                 | 139 ++++++++++++++------
 tools/perf/util/dwarf-aux.h                 |   6 +-
 5 files changed, 211 insertions(+), 92 deletions(-)

-- 
2.52.0

