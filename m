Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520031;
	b=uJJZKO6kMFwnMw+YmAOOtgQ913upFDrOz8IJ2I/B5MaCh87Qy7QBLpfItPmAMyDg6qwF
	 fL8HSxhWMObAESLOPzHco7u11icEZ0tqMxfFV5RZ1wxQu3+pyS77a6ComFOyECTNg4gJt
	 TdBsF4Z37m6zbIvtGdUECju5oMFk/7iuaw3Yy9IOUoQ54iUtTyrEBcMWX70uV98JgCmtI
	 yNmU3iBVhrEXiUYj30OvodzgSvLqjG5gKQQFTtKXrTzzuUdyko4q6zML++GDQzPiQE753
	 XtaD6ulPv1N8QABwSXP94yDlh6yeFGluXlSlhl7YUWOFZMpPYvwKFylp6AUtH21IWog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=1J7Web4u1psnSF4QBdJ6aHCPuKUAX0/CwZlSXWic3/8=;
	b=tUGHqJ1wUPPk6tD2RJwZ7gYFU/PApJ6LmmBE+qFmn2X/tPZaSfYM/c6pU+U5rLpCprNA
	 PXuHuRMhktXyYegNjadcXDUBJRlW7nhpnDyzacmTceI5Be9kvNsQFVjJH/fFOZsy5zyQ4
	 TtSK8caGywOO5iVndRMNvClKH6qNqELCTZYBTNB0HX+qLLBbdVhbLu356UpnifuX1z3Xq
	 lMK2JgQjGUrL4ACC4buFFevCVDrU0T3Gj3ulsrYBuTwsj0ocvDiTN5V61ZPZPjrwKKOvr
	 vA8HVslbnhvrSuVr9x/DhB5uYN1k0EX097cQDxEiOcgywMIthu/Y6jymOzSPGsql3PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Spn7587T;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A32606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 11:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A32606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Spn7587T
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so34925745e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795520029; x=1796124829; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1J7Web4u1psnSF4QBdJ6aHCPuKUAX0/CwZlSXWic3/8=;
        b=Spn7587Ti8W9cVT2FPz9CQAEL9DMYhjHK/NIWHzepK06a3cCmbGsbKyva/M6ZQqSem
         sbZqx9t7qOWJmtaVuCVhNZHi4JHVXcIzQHAiLco21CVq6X9P60lzvr+5plSbXI9/UaI5
         msSX2zxbTJRYCVRd5GyYewUkUHq6OKqqCmnJqdhwG7jP3Epgs8F7dwqOHPZbu0uSMi0+
         x4KV3fHfvT/HsPdPBHenjFEBsO/XvuqLDSIfAbNtQ0GnFlGiw6NszpJE2rOAj3/CzLJQ
         PpfhrdNN2dtZ4HxcY8T/A4iHypxxpIqWJ/08Pas/ZkpW/IZLm82y7MJE1dgh1ed/PUAe
         DobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520029; x=1796124829;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1J7Web4u1psnSF4QBdJ6aHCPuKUAX0/CwZlSXWic3/8=;
        b=SEH3ZgVJMERp40kvGQKQ1yurfX3w8vLZnxlYkcT157tDfmf23a8Kg3QwgtnqcQ8uAN
         HFlKm0xh75v6PGGuslIBrk1Nt+WcTj1z2dZ7flVMe+DOcYA7G3i+tI4Tf+Fm/Bmn+3uX
         WjlqVqW5l7qcGrObalfGVDxBN9DQDT0JS8hJt0w1mfLwd1I8hvR1bipAxGkq6yPfBqXL
         XNwp9WR6vsY7g8dxf98konaKoGQ83qUirPGwnZ/Kj6lhTicSdcF5GYrSVSF+PrqUyE33
         BV3FA/kKzKLLw3nDANyRbMDChZA5MWiLGeyLVuKX9bp7JU8+55EuSHrrnSCjeIjFeWMb
         0Hcg==
X-Gm-Message-State: APuU4Z9YhV0eHp5F0JF0wmegC6uNQu8iBHNSlMjT1sVq+i/lPe5MsEDO
	b+FL7fowaqp69xBuxrrzI1lfwkNuH411/swNZQcXZA2L95RU2l7awVm0+OqSeUfuR/3dKAAcCur
	raH9bUAk=
X-Gm-Gg: AZFdTZeAqhv/a49Bqb90EzD/oeOhZDGp5oTqkY5P1IskUoWKtRod7J6ayiJz+w0t6ti
	5ssLVSyplbbwP3vfJoaf6c/+OFblvxjL0/vRPB2VE/lAGmy6v8T39ovg7iDyUgortwzQ06So2fK
	tYpdAFoACnpMw8wNpefBRpBE+Y9dPbtT0GGOoM36kuGo2c84QUSdBZ0NCtmh2OXhR7LDLbq8a9D
	Rjioy7gCe9vNVyhYsBY8ACPy2MFdMFW+Q7MIxpIRgbnTRFAwmBdq4IP9Y9H0E9bOGPHMN0Og49G
	7TknGNuT5wcZZYsOvHcTI4g2HO9wJf6EykKKINjfi1HoD1YGPN73v9GxInanmIyF7lonwCicFQC
	F4TH5GKoHaB29l3pv1xy6m5CRXE+7ti2ihk95AVOt+PLIhV3OWQvO8nFtdSakUnf2aSZc7FOqQn
	EJXGZih6Naw2QzupHhdfsM4ubTopukcdJR71JPKjZBoPFhyB5o+G86dZ5Hsb7IOpG8q4/NPik3w
	xLn3/LqnOmbOruWhH+GuXZPwcoBQT62oyLmQ7RxAiQBLkn7jT4RtVX37xC3cLPha7Tbx7dScSzc
	WlzC18wy85ggHCNY2PBCVoKI571PGQF8ruRj7p/1rhNN28x8lvOpeA==
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr273001885e9.12.1795520029457;
        Tue, 24 Nov 2026 03:33:49 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067a0e6sm186691865e9.4.2026.11.24.03.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:33:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 24 Nov 2026 11:33:33 +0000
Subject: [PATCH v3] perf build: Stub out __guarded_by() on older Clang
 versions
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
Message-Id: <20261124-james-perf-late-parse-attr-v3-1-f9e906dd9da5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAx2BWsC/43NQQ6CMBCF4auQrh3TFkTqynsYFy0MUIKUTCvRE
 O4uxY1ujMs/efnezDySRc9OycwIJ+utG9ZIdwkrWz00CLZam0kucyFkCp2+oYcRqYZeB4RRk0f
 QIRBkqFSeFqI4qJqtwEhY28eGX67v9nfTYRmiGBet9cHRc3ufRNz9dTQJEFDWaMqqEFrl8tzbQ
 ZPbO2pYfJrkp5X9tGS0TGE4rxTP9PHLWpblBaovJS4jAQAA
X-Change-ID: 20261123-james-perf-late-parse-attr-4e996381859f
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

__guarded_by() annotations that reference struct members require Clang
19 or later [1], otherwise the build fails on older versions, e.g. Clang
18:

  util/env.h:142:39: error: use of undeclared identifier 'lock'
    142 |    struct rb_root          infos __guarded_by(&lock);

Stub out __guarded_by() and __pt_guarded_by() on older versions, but
keep the rest of the context analysis enabled. Add an exception to
check-headers.sh for the tools only change.

[1]: https://github.com/llvm/llvm-project/pull/95455

Fixes: 321967859933 ("perf build: Enable context analysis and Clang thread-safety flags")
Signed-off-by: James Clark <james.clark@linaro.org>
---
Assisted by Claude Opus 5.5
---
Changes in v3:
- Fix check-headers.sh diff warning (Sashiko)
- Link to v2: https://patch.msgid.link/20261124-james-perf-late-parse-attr-v2-1-cb8b00d904a7@linaro.org

Changes in v2:
- Only stub out __guarded_by() on < Clang 19 so all the other working
  checks remain on all other compiler versions.
- Change summary from "perf build: Only enable context analysis with Clang 23 or later"
- Link to v1: https://patch.msgid.link/20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org
---
 tools/include/linux/compiler-context-analysis.h | 8 ++++++++
 tools/perf/check-headers.sh                     | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/compiler-context-analysis.h b/tools/include/linux/compiler-context-analysis.h
index 024e303188ad..b6619cdc295c 100644
--- a/tools/include/linux/compiler-context-analysis.h
+++ b/tools/include/linux/compiler-context-analysis.h
@@ -60,7 +60,11 @@
  *		long counter __guarded_by(&lock1, &lock2);
  *	};
  */
+#if defined(__clang__) && __clang_major__ < 19
+# define __guarded_by(...)
+#else /* !(__clang_major__ < 19) */
 # define __guarded_by(...)		__attribute__((guarded_by(__VA_ARGS__)))
+#endif /* __clang_major__ < 19 */
 
 /**
  * __pt_guarded_by() - struct member and globals attribute, declares pointed-to
@@ -85,7 +89,11 @@
  *		long *counter __pt_guarded_by(&lock1, &lock2);
  *	};
  */
+#if defined(__clang__) && __clang_major__ < 19
+# define __pt_guarded_by(...)
+#else /* !(__clang_major__ < 19) */
 # define __pt_guarded_by(...)		__attribute__((pt_guarded_by(__VA_ARGS__)))
+#endif /* __clang_major__ < 19 */
 
 /**
  * context_lock_struct() - declare or define a context lock struct
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index c6b2ecadf9b1..caa7ab26968c 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -23,7 +23,6 @@ declare -a FILES=(
   "include/linux/bits.h"
   "include/vdso/bits.h"
   "include/linux/cfi_types.h"
-  "include/linux/compiler-context-analysis.h"
   "include/linux/const.h"
   "include/vdso/const.h"
   "include/vdso/unaligned.h"
@@ -193,6 +192,7 @@ check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
 check include/linux/ctype.h	      '-I "isdigit("'
+check include/linux/compiler-context-analysis.h '-I "__clang_major__ < 19" -I "^# define __\(pt_\)*guarded_by(...)$"'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
 
 # diff non-symmetric files

---
base-commit: eb79d2fbc230d41b009e49f20671303c6efbd946
change-id: 20261123-james-perf-late-parse-attr-4e996381859f

Best regards,
--  
James Clark <james.clark@linaro.org>

