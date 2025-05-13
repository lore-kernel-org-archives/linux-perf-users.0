Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4A23C504
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130254; cv=none; b=SEZArwXcOapTBnSSFJHA76j5SPI3i2sUZ5oMsUSlRV4rr5QiQO8as8fzEXpJu2f/ubQ5NsKH8uDeZzwUC1szARRnudEwQNn/aBjfnmBd+qFM1WcPgQZGo47pNd04ZT/9ONxUm5D1lGoPO5xlHb0kRyVg7DS7XPigte5HX7kkZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130254; c=relaxed/simple;
	bh=m7dk+dz/FQ5y5TwuOJuv8h8k/o/ZvuzcKicVSuADyhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qEPbxfExTxSqrMOW7d33FsSugAjZNiTH2ltSajir5gBgnP6/IhKfgi9nBcV8B62gIiET7p/edJy9CeaWZv8h37uWK//sShFs583GJeoZ/vSM7Uffspos6q4CzsZ/Ae4DxmWJS/p+aWmyKEdVA59WWpwk/LjLETaFwo8ESnWkuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hi6NQ90X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hi6NQ90X"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso32913115e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747130250; x=1747735050; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLOdbjvW3023c+QSK4O/m+8FGrzwf9Sug5Us+R2Jh0w=;
        b=hi6NQ90XWR15nxlpVNdyfYm2s/IA77FUXBPd3bJKrHq0MRr325VSnr0uQivcqxE+aO
         iFvxsRhg2n1Hhws64shklZY6x/P+YzolFJddr0wgZOjbiLRjsxAlXDZYrkiKrCTm3JmU
         nRh2CPWUaBICk6yUSBX5XN+AW4zHvGVl+MN0uWbFEkMhBGO9MnLn6fsDMl+UGQ1GOcjC
         75vJsZ9lWGz7QmYoVRqcZj3O/4aspKsZy5B+EKO7CCTSVeLvToDuf6ZgVvgar22hWu5v
         0Bx6RvNN1Y/or1UME6reVF2T+sd+acC9knf33boMPTUVwgaYtfsmBAjaDxSqYzRq7id/
         j15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747130250; x=1747735050;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLOdbjvW3023c+QSK4O/m+8FGrzwf9Sug5Us+R2Jh0w=;
        b=o1f5jJTM4kUJdc+xyyfFlT8zAK3jSrTFbmbSaltI+Tm+E5obeUEEjITOFNJVlFM/lw
         o74ge1nPExac7/Zg0RcVz+ovnfzWfKwYzxbTSjDFIjfrMCn/z5M+0HPCWgXnr5vNtKn9
         gUa9xRfHX0bs3FCkBQ0/CbvSo2ecS+gip9XCHpDCsr1VdX65Wz90m9hqmOPJw6UaiEBW
         NcoF7nMGgSxUaCzkzQ0qkIhlj9uhOx14zjjA1Wi1SXmSbxS8pC8k5S115KoWDEvyKnus
         25eiyogOVCFfQ+o7d6j0LXCKH9RYVBw1lC99GvSwCUdpzxZr6N1CFFaToL/RoJD7TeEO
         VHBw==
X-Gm-Message-State: AOJu0YxGJTe0s8ShWEj/OiDMyKRgjfufZKlBcfajwZlQgycRTGiwD9AC
	J+Y2AAqi7v2nTOzWzYrsniyWbDoHFPo7O92aSVQFkl85zjKjiVuIi3oa3U0arO4=
X-Gm-Gg: ASbGncv5pdUeiEVSJXswuUdSbrs/sguX46RZwp/PDfmPSwlxsZHFRuV4LPKaPzCEtyi
	t1zh6Pmyrx0QTYbGldf6LVOvG2aFeho3u2Yi9tN/+cuibqDBmaAuOGnFeUDF32Z0YO12ZQgeig+
	+6Lh7f5xvgp1EYzyv2VL5ncCWfVztOgK757JOVpP9vl5ARGi/kefs3CVLN74E3CYH6B9XER2+7O
	3vM4yinyuNKICH8mVxdNbYWxhdTivyqZ90+V/mdiNmBL1IH0QnXQrVmYPVezCWh7damQIPxTFT4
	290dsGrdFaeyEDGRsuF45eX14TgX5SVJnqfAdxXB1k/afc42lAUObO+nCb6wIMVk6xA8CmcCN8/
	dX88hs0P6A3c2LnaXG/5JPQ==
X-Google-Smtp-Source: AGHT+IFmloF2gXlsJK/TdytelTjfQyRAY2cW/iP2qUFwPDDpUiYaqsBBWIdshKt4SYc+wAa8wx85KA==
X-Received: by 2002:a05:6000:1786:b0:3a0:8c4d:7033 with SMTP id ffacd0b85a97d-3a1f646d8c0mr12827020f8f.5.1747130250512;
        Tue, 13 May 2025 02:57:30 -0700 (PDT)
Received: from e133063.arm.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ebe4fsm15858404f8f.39.2025.05.13.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:57:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 13 May 2025 10:57:30 +0100
Subject: [PATCH] perf tools: Fix arm64 source package build
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-james-perf-src-pkg-fix-v1-1-bcfd0486dbd6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIkXI2gC/x2MzQqDQAwGX0VyNrD+5KCvUnqQ7ec2luqSgAiL7
 96lxxmYKeQwhdPcFDKc6nrsFbq2ofhe9gTWV2XqQy9BuoG35QvnDFvZLXL+JF71YpkgiDLEMYx
 U42yo+j9+PO/7B7dTBcFoAAAA
X-Change-ID: 20250513-james-perf-src-pkg-fix-59e5ec53c404
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

Syscall tables are generated from rules in the kernel tree. Add the
related files to the MANIFEST to fix the Perf source package build.

Fixes: bfb713ea53c7 ("perf tools: Fix arm64 build by generating unistd_64.h")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/MANIFEST | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 364b55b00b4841fc7b3505e8f27ea9f3f246e3be..34af57b8ec2a9cb7f8ff75b4515f32f866452e3e 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -1,8 +1,10 @@
 COPYING
 LICENSES/preferred/GPL-2.0
 arch/arm64/tools/gen-sysreg.awk
+arch/arm64/tools/syscall_64.tbl
 arch/arm64/tools/sysreg
 arch/*/include/uapi/asm/bpf_perf_event.h
+include/uapi/asm-generic/Kbuild
 tools/perf
 tools/arch
 tools/scripts
@@ -25,6 +27,10 @@ tools/lib/str_error_r.c
 tools/lib/vsprintf.c
 tools/lib/zalloc.c
 scripts/bpf_doc.py
+scripts/Kbuild.include
+scripts/Makefile.asm-headers
+scripts/syscall.tbl
+scripts/syscallhdr.sh
 tools/bpf/bpftool
 kernel/bpf/disasm.c
 kernel/bpf/disasm.h

---
base-commit: 8988c4b91945173a6b5505764915d470f0238fdc
change-id: 20250513-james-perf-src-pkg-fix-59e5ec53c404

Best regards,
-- 
James Clark <james.clark@linaro.org>

