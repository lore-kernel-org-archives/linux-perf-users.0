Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821228;
	b=43HpOMb1Pmia3nT3yeWls15kCefrtAxwjT08znmnAZP4ZZbUvwu1Rs1i9BIdhV4FC+Z6
	 zfvkaWE9oxz/yoPx3WSDYCqD3Ru2dCA5xpyK6Udu/wT4FHX8/364H+Abosq72g6S4kGq0
	 9/6OfX9aBaVZcnOfecKWZjzfyM+2sZnf5Yr9amBd+hutwO12HdMexyfaJez8T8J+uUhBT
	 r/756g0YTnaB/tIt5Nfs1PeIKqd4kR3eq0BxfJ9q8Etq4GzOaQeVmG9+Pl8kb/AsUsX9s
	 cSqwSfxpzoI/SmNejHSHpX8sMpRweK7fNZmgJqN7jTg2Sm5eW+vlJt14/S6Jui6tF1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821228;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=MWsVBLgZW16pqsBfRZm53nUtd+lGf7v+gvt3DbChD1k=;
	b=kspfkudCWbmju/SAMiTYp6/iywVBtFU2B3mpD6v0Oij1C1FcC3eTMPDZ4Wc/lqDlBWTj
	 U6EzQy9N7HTIAQsoSvZ6XYvzn4jZI39j/usycQGSsCP4CGXHNazh8wvGK3WIrw06QUa8L
	 DJLzZjCpcU2pexB94sGMVr3tCDjKLS2+Od8xs/cvvepyNcn/rqOUMYsItx1WGgRpIdXZF
	 ua84AsHhPYaIhIIKGro8iGUuwXD61hrNveXZCadl8GRQd2ji/QbHziAleRFQSl6AnNeAs
	 orURovDbEVUWDeD8eLytyO2Yj52M7XdWk5p+XDTk5QhhdN1vRnHoepPRgC28u852MNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=G6SRAoyy;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 69A2A606A323;
	Mon, 16 Nov 2026 09:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A2A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=G6SRAoyy
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Li RongQing <lirongqing@baidu.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf intel-pt: Save the reference window used to detect snapshot wraps
Date: Mon, 16 Nov 2026 17:26:50 +0800
Message-ID: <20261116092650.1714-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794821223;
	bh=MWsVBLgZW16pqsBfRZm53nUtd+lGf7v+gvt3DbChD1k=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=G6SRAoyyhIyD6LSu1UrMc7QsVRbZpN0rQdazkUTEomGCmciKgf5hGQYiA0e/5OwgY
	 oYSBk7+orb2ii3j70mQq3tDAkjtOV3kVPmm7AEgUbiFq6rtg2A699pSzlgTgROqAGr
	 GujlEY6+GMujyzrYhiu+5noyYjQzm+UDLOxPPxu9LhSZnKJ7kMUIr0aB6hTblngciA
	 Mi+EGH7PUMwAvKLzxHAxsOpmVru7m9Zgr2vnU3Ojxz93kCKADcvDURg4Ye4K2IJQGi
	 ZwZChmhEZLbM+khRC+szNt6jtvO6/UKtcuSejESXB7uuy9rnOD/3YWocUQPJv9QInW
	 lydN6i4d2XDqw==

From: Li RongQing <lirongqing@baidu.com>

The snapshot reference offset is initialized to the end of the AUX
buffer and does not change. The comparison checks that fixed window,
but the reference update copies bytes immediately before the current
head instead.

Two snapshots before the trace reaches the buffer end can consequently
compare trace bytes against an untouched tail and falsely report a wrap.
The reader then treats the buffer as full and emits stale or unwritten
bytes in addition to the new trace.

Copy the window ending at ref_offset plus its size, matching the window
used by the comparison.

Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index a533114..5e38b9c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1091,7 +1091,7 @@ static bool intel_pt_wrapped(struct intel_pt_recording *ptr, int idx,
 				       data, head);
 
 	intel_pt_copy_ref(ref->ref_buf, ptr->snapshot_ref_buf_size, mm->len,
-			  data, head);
+			  data, ref->ref_offset + ptr->snapshot_ref_buf_size);
 
 	return wrapped;
 }
-- 
2.9.4

