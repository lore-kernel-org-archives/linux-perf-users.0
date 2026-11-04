Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758855;
	b=dvJ8kNO3RhLC0nKDiduIq9YpWUgp5cFL1o3e13D4DxUhHirHz0l3MH7fLHOH2yMvdfMn
	 gYmS/NwDOyeiJoGpp47Az7W806B7TvDi5d9hoYgPuw+Two/ySJnM7PeZo70Oxo6yLfahT
	 NNIaOKjfXY8VJ/taj7wtMDmJspwYsOmKwBFT9grbhp8vLIUYbRvzYGsav+B8mgQ7PHkIW
	 961zUiX62b/HmY+WSs34e+8lTrWBpBtjQOqYiBdeaCF3oGHuEUSi8JNzQDbARLvILzIfb
	 4+9X+tLwXT2zihtXrrduQyy+bH7/STNl9FQ2Qs51Nkd760VWO80EjLqkPJ4IPUkK4tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758855;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=8s1UjpddbLRALZnpmVrsyj1H9wxbV0f7gsSAeKON7lE=;
	b=ZFH/QCrteR++4WkhZewyoDqrJ6qwa/iNpFZB5FZKo4Aofu1fjFf/ed7Fq8h0ukP77N4m
	 71agd7XVeLuPYIEeOSkDyMxdn6UFTNZ82faShs2eovUH+fWQwxWTnHRrAFYyf3z1LU2Ou
	 Q5HjTVxno7bSVAZ00iKiZaTHpz/TWMM8RQs0Nrcnd+tSndIlfXhHlNHsJa6Bt5+c5IxJx
	 P9iCUqCDlKAowID9t609OfZlRR/cxV77CgcOKJMEkHpcJLr6MSYNyVg4AS56k/dTG/ISf
	 eznLhgffrFea4VqQgNvlr0cvWTfC/vikH51saOlBFC3TCmHDvHXH0neSIHPHG6QjL3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=jT0CT8BV;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 49ECF606A31B;
	Wed,  4 Nov 2026 02:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49ECF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=jT0CT8BV
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
Subject: [PATCH] perf intel-bts: Free the old snapshot reference array after growing it
Date: Wed, 4 Nov 2026 10:20:42 +0800
Message-ID: <20261104022042.1894-1-lirongqing@baidu.com>
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
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793758852;
	bh=8s1UjpddbLRALZnpmVrsyj1H9wxbV0f7gsSAeKON7lE=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=jT0CT8BVvBNtOuVfQnQr5j2tVoBN3Ez+T/wSKuvVjRl7iVTs5mdW16QDvIHUY2v5m
	 z8N7AqTNJaAQvwa5SDs/uTTw+hULi4hrePH2duehSk0qRb6VG82sE67eaXpIvSMSoY
	 7sCeoUmz8uJxd7V9e5YmoNsnywFsAFeYniaKSFbfYQ6NakafHKaN1tLVm26+HtUJln
	 S6/w8LZsoqIdYEwEwZGRJUsKsaSUOJkUSCV/ry2e9Xv7ytsMy0F60YRMExUzCDIj2V
	 W3/Giz6i1oQLoSEMEwLCBWJWhDjX2fegK8fTb0EJ90GrsaIHtAKrk84Viaiu3BiZ6h
	 CHiQVHDdckATw==

From: Li RongQing <lirongqing@baidu.com>

The snapshot reference array grows when a mapping index exceeds its
capacity. Its old entries are copied into a new allocation, but the old
array is abandoned when snapshot_refs is replaced.

Release the old array after copying it so expanding past sixteen
mappings does not leak it.

Fixes: d0170af7004d ("perf tools: Add Intel BTS support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/arch/x86/util/intel-bts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d44d568..9403681 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -299,6 +299,7 @@ static int intel_bts_alloc_snapshot_refs(struct intel_bts_recording *btsr,
 
 	memcpy(refs, btsr->snapshot_refs, cnt * sz);
 
+	free(btsr->snapshot_refs);
 	btsr->snapshot_refs = refs;
 	btsr->snapshot_ref_cnt = new_cnt;
 
-- 
2.9.4

