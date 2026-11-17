Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909380;
	b=sYSHzKkxqZo7BArpr02Olf1H/v6xvMRY6OJrFV3QcYMSMr19C0KMCU0+Fdfd8qnm4CuO
	 Sv9/t4x9A+GFTyniIiQJS3mvXhsoxgiiHWW7YGMmLwf5zcNdNizDJ0lYowApjGMeohjlV
	 KiJAUwgTYE5jhApkM2x7bHyht1l6wb0CEul1R3kNHZnktktIRzXSamCuKNaInxWwoV1JE
	 q1UnIIu/BYH58DrqavY9L8a9hYEMLm7gqsLfUs0Dhpef0VygjBun6D1cOGsIsMACApici
	 7l7GDLSTXH5Hei32lhFQc5W3nY4Vk8XmjewSnwQJgzDQJKUSxoW8hHdQOGf/CRtDEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909380;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CluE4Dh1kKG4+k2ic12hszvWOzLMpgYMf4ldDPVCJcI=;
	b=SrOHReWNK9/556ThS21Ct2/a60uYE5agkrW4mO6QnZc6zjipCIpmBtWmOamOEm8FlUCJ
	 fG1Yzt+yOtGZHuTMmLYFDC5wiVmJ5W2Il+Ku+gkqgWdR8JsnrkOAHeSycgdSwNZbeh7v2
	 KvCGjrsdvGF8x9WBREQDCvhg/N5ar/JhldWx9o6LzHfjwfPlnIKPWgZfKGzDG7gpwgVpl
	 lVBeaUGFu0LRIAUUXbJYfu6Bx/3r0i2PLZ6rh0mtru+i4p6mtgAsJ9Yl5gPDLfJnKVG33
	 JCCk7BDFXZ7enmYz4t9e1sQUVbzqq7LmXaeOUTbUO1emd9+RCEQSmJRsZ1NfbVp++sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Gj1dVoh1;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D6A606A31C;
	Tue, 17 Nov 2026 09:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2D6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Gj1dVoh1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Gj1dVoh1WFIXvJZ3Ah+sRLsVD8Q3FoO9LLjluk2hzDE+4x8mnmnUHv17RlMg9ycVYPNrgQ50MUgDN
	 BWd9YiusCDUqTg1XPpNAh9tiGonRSpyRDhX1dw3j+yxxbaqEmq+OjS3O9ioJmOJxC/8ijIhponNm2E
	 e/czjf/Oj400vWrw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66afc24bb383-d6441;
	Tue, 17 Nov 2026 17:56:14 +0800 (CST)
X-RM-TRANSID:2ee66afc24bb383-d6441
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56afc24b5457-acdda;
	Tue, 17 Nov 2026 17:56:14 +0800 (CST)
X-RM-TRANSID:2ee56afc24b5457-acdda
From: Gu Bin <gubin@cmss.chinamobile.com>
To: acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf trace: free filter_pids entries in trace__exit()
Date: Tue, 17 Nov 2026 17:56:00 +0800
Message-ID: <20261117095603.2397-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace__set_filter_pids_from_option() allocates trace->filter_pids.entries
with calloc() when the --filter-pids option is parsed, but trace__exit()
never frees it.  Free it there along with the other entries array of the
trace struct, ev_qualifier_ids.

Fixes: f078c3852c73 ("perf trace: Introduce --filter-pids")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4094141461f91..9bd95be106d19 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5755,6 +5755,7 @@ static void trace__exit(struct trace *trace)
 	thread__zput(trace->current);
 	strlist__delete(trace->ev_qualifier);
 	zfree(&trace->ev_qualifier_ids.entries);
+	zfree(&trace->filter_pids.entries);
 	if (trace->syscalls.table) {
 		for (size_t i = 0; i < trace->syscalls.table_size; i++)
 			syscall__delete(trace->syscalls.table[i]);
-- 
2.50.1.windows.1



