Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934432;
	b=zZttVCwvKk0JUxPP00UF/B6Q3UIr/4hU+1Z/l6j1Ty49mfcDnLwVyBCsQaDlxCHeUjov
	 zH/4pubEICyusZZ7M1hkPCswVjBbKb9TFcTkHB2o0sXR5VdxW+WMOQeSlcp0mRSjksZyG
	 eub6D8bbW2bNq3crPydr5MIyh88En3RThRdS2IszPpLMWJlq1CBUJWyB4wRflcQPP1AAJ
	 UOFGOvjtJ3/ROySw+Sq6Z1MiNXu/FX+QVZ9hM3SVq11Wa8j4fpwTbVI7lwPZh0iVkGIn/
	 BCQCt3Dlp8a3VWslTQiltUyJg7xJ04tT0hWujS2sSo2GR8ECPU9FwE6NIoqyqKbgelg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934432;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SEAX8sDv2DtDNpr8cOIQd6z9xBqi+QGbvhq2CyLVLL0=;
	b=4sJF2cCZ9hm3D8sxMmOTpLqCZ6B9VPrn7KLpNE7Nt8Dk5x2dPMWKqpCAaq0tE8bMQfCH
	 YUmgmpvDf93pQhs91ptDqucXd3v0ssI48t9BrVsk9fQToDtnU+O3AGfnXOQQ6vBG06yTN
	 yBiPTz7Lg9P5kAKyJxJMws9JSxpVZZYZs19nDX/uUat0Yv7I21XSdwCVALZhS/II9Gtu5
	 wbRk494AyK3pOtCo3GVp25RygaFnMEcOS8Adr3KGVZCDQJ3dWxhRnEKpnfV3ki7H6TgwW
	 PTDHjvjWC9filwUmMA9nSS6UZEK9/tar3CYvLEvJPLumZy49UYBQIivta0444+EmGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PGwPAq2x;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0E606A31B;
	Fri,  6 Nov 2026 03:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C0E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PGwPAq2x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PGwPAq2x9B9GUbo61qYMlEp+uiTiaaE+q0tmnseXa18b4GP/z1ErYxchD5PN3yS292aWv5bS3aP7S
	 RruiP/jSFBwIhfBkG1a3Z27EbKR7/9nWsl5KnHJo+r/ztUCHum+e4IRHiO74vzW87KizB+Dcfx+/Fx
	 v9h+qoNp1nUpCrm4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56aed4452171-a945d;
	Fri, 06 Nov 2026 11:07:02 +0800 (CST)
X-RM-TRANSID:2ee56aed4452171-a945d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86aed44545f9-0f6f7;
	Fri, 06 Nov 2026 11:07:01 +0800 (CST)
X-RM-TRANSID:2ee86aed44545f9-0f6f7
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, David Rientjes <rientjes@google.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/ds: don't WARN when the BTS buffer can't be allocated
Date: Fri, 06 Nov 2026 11:06:41 +0800
Message-ID: <20261105-perf-ds-bts-warn-1-yuehongwu@cmss.chinamobile.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

alloc_bts_buffer() asks for the buffer with __GFP_NOWARN and then WARNs
if the allocation failed anyway.  The failure is already handled: the
caller disables BTS for the event and releases what was set up, and
perf_event_open() returns -ENOMEM.

The WARN_ONCE() came with commit 4485154138f6 ("perf/x86/intel: Avoid
spamming kernel log for BTS buffer failure"), which added __GFP_NOWARN to
stop the log spam of the failing per-CPU allocation but kept one warning
as a hint.  That hint is fatal under panic_on_warn: on a machine with
BTS, the 64 KiB buffer allocation can fail on a memory-constrained
system and a plain perf_event_open() then panics the kernel.  Since the
allocation explicitly asked not to warn and the error path is fine, drop
the WARN_ONCE().

Reproduced on 7.3.0-next-20261027 by making the page allocator fail the
order-4 BTS buffer allocation (fail_page_alloc: min-order=4,
ignore-gfp-wait=0).  Without this change the first perf_event_open() of
a hardware event hits the warning and, with panic_on_warn=1, panics.
With this change the same allocation failure is silent: BTS is disabled
and a following branches/period=1 event returns -EOPNOTSUPP, while the
kernel keeps running.  The buffer is allocated per possible CPU,
independently of any specific BTS event, so the failure path is
exercised without BTS tracing.

Fixes: 4485154138f6 ("perf/x86/intel: Avoid spamming kernel log for BTS buffer failure")
Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
 arch/x86/events/intel/ds.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8444670..27e4115 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -939,10 +939,8 @@ static int alloc_bts_buffer(int cpu)
 		return 0;
 
 	buffer = dsalloc_pages(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, cpu);
-	if (unlikely(!buffer)) {
-		WARN_ONCE(1, "%s: BTS buffer allocation failure\n", __func__);
+	if (unlikely(!buffer))
 		return -ENOMEM;
-	}
 	hwev->ds_bts_vaddr = buffer;
 	/* Update the fixmap */
 	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.bts_buffer;
-- 
2.43.0



