Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF628C851;
	Mon,  7 Jul 2025 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751892194; cv=pass; b=QVyoI8mE1Kte4CSG/lYPDhAIe2QsdR0ycp0Hq2M9rROGFdJ+7h2wjSsTteARvNWC191OpB30GKyb3v/VWdiOxE+v4pGGqoTLOBwXrrYw9PdjwIHdf77HYSCFmdnJieQka+AKO0fF8vxZd/aCqPWaWHxtUtqMOJuj/Z+8uqrj14Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751892194; c=relaxed/simple;
	bh=oCNDRXBp98+7P1XQBdRSqQRZRFRIWI4Xdo1x8v8mfnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsJbZO5MFkFVuQQNWwggKOSwBqgJKhiKfp+7+KeX/motZ84KlYo7BPcyavtlNXSCgwJO2virJAdedK0GWRMnZaVbWRiMavyssjeFxELhE82107ebuCjP1TH2Tw9K1zQKd+Fg/mLsObhhFfJr7hNIBTMg+K7Kdp/ge5M6sI1vdAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=m4yeqWO8; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=PVUPsY0O; arc=pass smtp.client-ip=81.169.146.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="m4yeqWO8";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="PVUPsY0O"
ARC-Seal: i=1; a=rsa-sha256; t=1751891118; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QBSHV/hzIY1VSYZHIuEZMK1+t8oC/iBgTDHxbd8StsZY4Z1VAEUqqidJbX9S/2Pjs7
    NnByl6+gH4vjWXdh5WmBnR99ZhGAesZ/HyivYyBPTex6SKKuJ8phmsE9XJRBQNuTq9/M
    86/YM9S5krcmVKYQmcNtSxJ1T2m7BWAaHjcMNEaHdp8KA6tVkrEHAJgKszl3DKEpy1Pt
    tGYG3yAZ3clu9kVNngvXjNesCKyrka5ASYDnKc5eeYzLOwkDK2Zm+cuWXrMm4LZEXV2u
    qeWzK3jG57MgHHkSOJCyGlTX7E1EOBt7ztLtcJby/YYCcpzcfpIEKYbDsTveZJMoeo/d
    cawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891118;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DxvkT4RweGoxlXFPRfqgPFEM93r1hSUPg6SmpoHVhqk=;
    b=n4U7NAjXnMviSo7gRh38lskeiaiLELgEh2wRFAvNaPtfcWh/jIVfvArTyJc2l8T/AN
    +SG8EbmRY35idawvGhgdFM8WqPv/BQR5o8ncTzOEjsOn59xEd2a9hCpwcko8Zua29dZu
    IU4WNF/gl4NYVK6QtAutZ9STIaERd2Jl0EwGtTvj0xg8Iu89d9RfPU0Pwn2KRVTfq3QZ
    5yceTL/APcBX6PzMuY7jbOb1a3HrZ1nzl+xXB9eg9JOo4v2MHilADsTBA2NVyS7RD+Ly
    P9lAW34WmSyRTLYOs7YCt/1ky84K/eCAFH65qP4vVndSe5RR6eoYHqp6+1QmyYHgc7wP
    OS1Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891118;
    s=strato-dkim-0002; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DxvkT4RweGoxlXFPRfqgPFEM93r1hSUPg6SmpoHVhqk=;
    b=m4yeqWO8haRKraDZIwUKCwISTEpyYe9wHIPrBWXF8aGpBaApnAehJjD1/F3gwOi7Fn
    Js8TYTziM2v+zJYsNj0SLGJEG92Pw8/FKbZUzYhvF17x2rhR4AReBiE5SM/rq2GY8BYr
    LJxMj5haFYWPoBy3XQGoOnfS81NX2QLVSiotcZ4HUFnxntF6TRDN4BVBBD/AXQyapb1e
    F+nr4R/RXb9Cu9x8c/jRrfClrQANB2gbS3evAK6Ft/3OzZi+wx2bA7YzSWibLRKzhGTQ
    VouluQM7sb3AIrQvC9WIqwUdvURbP2fS3U/6F1VT/LWaMBm0nOU4aEk4UkNZ63u3rzgX
    OvGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751891118;
    s=strato-dkim-0003; d=outer-limits.org;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DxvkT4RweGoxlXFPRfqgPFEM93r1hSUPg6SmpoHVhqk=;
    b=PVUPsY0O7dFqqMgx/ZMg6Y9jDooW+JHpz0Nkt4iHz5zWPI59AN7aVlksz+B9CD+aia
    l8G1aLzwlwAqUI3l9cAw==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J1bd32167CPH718
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Jul 2025 14:25:17 +0200 (CEST)
From: Julian Vetter <julian@outer-limits.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH RESEND 5/5] tools: Remove the check for packed_struct.h header
Date: Mon,  7 Jul 2025 14:25:00 +0200
Message-Id: <20250707122500.724699-6-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707122500.724699-1-julian@outer-limits.org>
References: <20250707122500.724699-1-julian@outer-limits.org>
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
index 8085e4d1d8af..637eec11ddfa 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -188,7 +188,7 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check arch/x86/include/asm/amd/ibs.h  '-I "^#include .*/msr-index.h"'
 check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
-check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
+check include/linux/unaligned.h '-I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
-- 
2.34.1

