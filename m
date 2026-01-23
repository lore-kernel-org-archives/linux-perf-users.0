Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AF320CD9;
	Fri, 23 Jan 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162576; cv=none; b=keCXIiQXhzRzQncIdZHA29sP8H/+eNRlDeW+rXGCamPlDEzSuS5euBXUu1f1Y+pRcI2F/bvfhSGs4lrnzMmz3Lk8rKMcu8dMnnhe/xOMSbLwyHtadwm5uQdPKjf0tB0BM6GTbQt1oOGZBnlnyKWSZJfs3WyMKrqwOEtD54Cf4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162576; c=relaxed/simple;
	bh=d/I0DYn4lkHUeQ50ip4C4D5h5ELivq7q5hR8hZ3DVgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BY6HJ3FvkmJrnux6QkMUZzuBO9a7xfxLHGgaEGfHrFnQ6lo4SdAH2n15YGHOVDJ4g7FbC9Jz2QD39JhxM7bruPMMnlDoqZwpFStno9JPtsC0abC0w9uQw9x0yw6aaEn8MJiL3egR/CETnGWgxyE5kv9eSxb4DtykLCCdh42QiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38CF61476;
	Fri, 23 Jan 2026 02:02:36 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09F9D3F740;
	Fri, 23 Jan 2026 02:02:40 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Sasha Levin <sashal@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	Thomas Voegtle <tv@lio96.de>,
	stable@vger.kernel.org
Subject: [PATCH] perf arm_spe: Fix bitfield dependency failure
Date: Fri, 23 Jan 2026 10:02:18 +0000
Message-Id: <20260123100218.233246-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A perf build failure was reported by Thomas Voegtle on stable kernel
v6.6.120:

  make perf NO_JEVENTS=1 NO_LIBTRACEEVENT=1
    BUILD:   Doing 'make -j12' parallel build
    HOSTCC  fixdep.o
    HOSTLD  fixdep-in.o
  ...
  ...
    CC      tests/sample-parsing.o
    CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
    CC      util/perf-regs-arch/perf_regs_csky.o
    CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
    CC      util/perf-regs-arch/perf_regs_loongarch.o
  In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.h:10,
                   from util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:
  /local/git/linux-stable-rc/tools/include/linux/bitfield.h: In function ‘le16_encode_bits’:
  /local/git/linux-stable-rc/tools/include/linux/bitfield.h:166:31: error: implicit declaration of
  function ‘cpu_to_le16’; did you mean ‘htole16’? [-Werror=implicit-function-declaration]
    ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
                                 ^~~~~~~~~
  /local/git/linux-stable-rc/tools/include/linux/bitfield.h:149:9: note: in definition of macro
  ‘____MAKE_OP’
    return to((v & field_mask(field)) * field_multiplier(field)); \
           ^~
  /local/git/linux-stable-rc/tools/include/linux/bitfield.h:170:1: note: in expansion of macro
  ‘__MAKE_OP’
   __MAKE_OP(16)

Fix this by including linux/kernel.h, which provides the required
definitions.

The relevant C file in mainline already includes kernel.h, so the issue is
not exposed.  It'd be good to merge this change on mainline as well for
robustness.

Fixes: 64d86c03e144 ("perf arm-spe: Extend branch operations")
Reported-by: Thomas Voegtle <tv@lio96.de>
Closes: https://lore.kernel.org/stable/3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de/
Cc: stable@vger.kernel.org
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index adf4cde320aa..8d16619cd098 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -7,6 +7,7 @@
 #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
 #define INCLUDE__ARM_SPE_PKT_DECODER_H__
 
+#include <linux/kernel.h>
 #include <linux/bitfield.h>
 #include <stddef.h>
 #include <stdint.h>
-- 
2.34.1

