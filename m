Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8D22DA17;
	Tue,  3 Jun 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957816; cv=pass; b=jawb/XXq/dI3f8HB/SCdCoW/eoL1U71I/rnszAi1py6BfO6p396jwGLRPnt4Q53lPtxJgLD7c+vemNL00AxZH/cdjgNuJ9ZBbx/PEPsXHvkmo837I6IELFbKBjzyQNAo+bzE61LFRnsDL/5AS0T1SRGMbJoFB5UJ6txuc9vPE7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957816; c=relaxed/simple;
	bh=ggSD5TWyCWxeirSaMJPrl1giOPLd1NsohN9SeJ3A2c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nsx6xToavbeOlGnYaJWWwDV3TzFl75N9UaH5yZSdCbt9TMZuAv/0kOoqnM0rolfIE5i2CGeG7Yjeh9Vdy+7tep1AcOfmDhu3AJSXBFKsu3qnb7dkqoYFFQyl/v9RO61RXiBwWA7OCN0fpshTpAYg7H9wqxrDLYh3qaRz+O1Lz2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=I317dWfQ; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=5KxrZqAq; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="I317dWfQ";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="5KxrZqAq"
ARC-Seal: i=1; a=rsa-sha256; t=1748957804; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ikoTMZbBkbQOKvsYPM/CBFQZG8NyfGjHDe1B6rNsTzUyWq0X/DedvZ32HU65KyGUm8
    Uo+U8lSFZH3kJQN7UBT7gQyy7e+zrFst4pfXnQKuMtOyk+PsTkOI+CITP7GDvmseYlFK
    inNhuNSYW3Jdpo0WY4QePBQbuRja7T0TyiLWLmfQvAs/oftOQeLTMygXmcFtMdHenRtX
    52gjcTjINA7fzS8fbVHJSsJON7avNwitfUAbtHNzh/Tt97DTU7fwubja08Nd4tfvjsY+
    FvCOZSbgjlOAV7J8k01xsq7GJsb8w8UoaLmUEyAtOUtnWns+xKueJHEJFJSYR29nH0zv
    oE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748957804;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ynHn4pR2QysbnPMSx8mcbuJVwE2t+RsfvJbTInBcDCA=;
    b=ksVRI//7ulTUCCNmNWlzpDP+Z5mmBUhHAMMySdSdCEr9iSa0zhQDGEK42DyEk44AYd
    cnr8g5GrdBa5iA8OAdlWw1RGQ/LtNBWkBHYzixO6yBp4JOjMsdkKsSazRX3eSDUeWaRW
    ETQ4X494lOWpYrqUmZDt28E9ilVP6lekR/+E/trhWHjmVa36gx1YPlOZuUaVB4oQmCHv
    W3hPQhUJ5eTM+Af8RcKZUN8z6HzP2UXd3nMu/iLb8Wgl/AF2QLPS6NdAynzQX3IYVPAM
    enX7do/ugCTAo3j8cmdiFhWSwxJmBDIFDjD2g/GvL6p3HOZMJK5C56cDJXyuxEhtItwa
    9Trg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748957804;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ynHn4pR2QysbnPMSx8mcbuJVwE2t+RsfvJbTInBcDCA=;
    b=I317dWfQF6ux62fZMO7tVxc1ccQSx3xL+SviOHdflqjcU78QfGQq+XPo2QCE0bRDhq
    Zoli7D1jdt+99ZnbV+G9qjRs7TlXA5HdcQlePlyh9lYnSNoFZ6psB5M32wO3rnqQWgDi
    Cgy1X4qCX0ThaSpvzR1Ltuu+R+wVd1n6vRmMu4Xl3fXAMiatzQm/260w11FLle76H97P
    BH3RenAiCRfPuxD93qECfKnJhbYYFiVh/d2ZHQ1jKVOQqvDrKh+WH1kFlGg92s7kHv2z
    niSAEH+hfxp8FudAAdIq5NTveMVBLWPY6BWRZenwuRkwPtYaEx0L8yRnzI/E6Hlb46wS
    kw4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748957804;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ynHn4pR2QysbnPMSx8mcbuJVwE2t+RsfvJbTInBcDCA=;
    b=5KxrZqAqFHu+PlBYbHs5WUWOn3qbHuk5fxRIEvTMTGTiuGMoUTIMlyjtjYXFBjX2zQ
    YnAen8VgYTVOMCvhDgCw==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J2b110153DahwZO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Jun 2025 15:36:43 +0200 (CEST)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang,
	Kan <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] tools: Remove the check for packed_struct.h header
Date: Tue,  3 Jun 2025 15:36:35 +0200
Message-Id: <20250603133635.3685397-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The functions in the header 'unaligned/packed_struct.h' were deprecated,
and not used anymore, thus the header was removed. So, we can also
remove the check in 'check-headers.sh'.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 tools/perf/check-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e9fab20e9330..cee372312974 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -188,7 +188,7 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check arch/x86/include/asm/amd/ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
 check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
-check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
+check include/linux/unaligned.h '-I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
-- 
2.34.1

