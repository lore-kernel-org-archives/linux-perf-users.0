Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472297;
	b=dmX5uwUn1ZvdtoF6yAjW+KvlwbAozetb7j/idl2xudgrSouu+bOe7VvXxjM5viGWpRib
	 rHTkQ7ve8/il7lFUkcySqQo5A6h1FaZoMgfD9GvISb8DLb5VtJpcgpDnJ8UlWsR3oZm5m
	 1pSOUpQOiCfwOtGbuBqztAIV/TB3XrHNzqL1FsRJc9fqP5Ze1/x7n5hKLzWE0q/W0pIFZ
	 mjZpmQIDz88preFXEOeeOt13B+iDui38zU/Ls9mtCnQQKYso0iJsnVnGMeQdK/RGHIlNR
	 clIuPNtUAPJLQoLLh/3o6m1T3Olua1phdjJvoqyaZHhB51DjYwpdF1rATGoNqveaVIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472297;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WTMP0qB+Gr3K1SJjWUtokclRO7IURpuNe512cL5dDeY=;
	b=Q7hdaEjOdV/owpkXcAYs1TfAaMwJ4qAJ9uD5MITLg/nYGuTL3Q+gYgAsUIGAdIQILiQm
	 DfakroQBnFO16bxk5GSJDdhVuwXh8iAVq1MvYwrME2HmlrtZoq+RX3+w7Fy/3zeeoHvR0
	 q6vlFfn1djwe6y0PKTfE6SFGU7TZRFhIiule+XRfvsZU2DQDSlcp399zwX0xIYk8wz5sU
	 rxD1wfdLRLOGzNu6zz8LD+G00sZiUMMPTChRE43fO7PS/f6VI6QuvMDwQdMW3P7FEA3z7
	 CprwwKKAfGgu/T396raWUmNHzCk05KU4HPOgPa5jfdIWue6QZIMllivtyBkEsqdFxaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=AWJttntf;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA962606E987;
	Thu, 12 Nov 2026 08:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA962606E987
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=AWJttntf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=AWJttntfeactBmaEDNemcBJlaLhBPo46gTIg3SJ4VkC6skVmUVfp6Nwt3cPt6u9+/FOcqbspeCkCC
	 iz6qqJA14swJBcNKF4mPCpImJqVcYebtlgciJxdDzghOdTPe+CXq+kCyeymoI9STmjO7jsNKL8qV+i
	 5BbjABWJ/xvWjbL8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af579628d8-e5d3c;
	Thu, 12 Nov 2026 16:31:33 +0800 (CST)
X-RM-TRANSID:2ee96af579628d8-e5d3c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af5795ef03-f838a;
	Thu, 12 Nov 2026 16:31:33 +0800 (CST)
X-RM-TRANSID:2ee36af5795ef03-f838a
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
Subject: [PATCH] perf trace: free intlist on filter_pids calloc failure
Date: Thu, 12 Nov 2026 16:31:22 +0800
Message-ID: <20261112083123.2154-1-gubin@cmss.chinamobile.com>
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

trace__set_filter_pids_from_option() builds an intlist and stores its
entry count in trace->filter_pids.nr before allocating the entries
array.  If that calloc fails, the function jumps to the out label,
which returns without freeing the intlist: the option callback exits
perf with an error, so the leak is the only damage, but it is
triggered on every --filter-pids run under memory pressure.

Restructure the function so that every path that has created the
intlist also frees it: the failure path now falls through to
intlist__delete() as well, and the out label is gone.

Fixes: f078c3852c73 ("perf trace: Introduce --filter-pids")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/builtin-trace.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4094141461f91..d435b35f1351c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5432,17 +5432,16 @@ static int trace__set_filter_pids_from_option(const struct option *opt, const ch
 	i = trace->filter_pids.nr = intlist__nr_entries(list) + 1;
 	trace->filter_pids.entries = calloc(i, sizeof(pid_t));
 
-	if (trace->filter_pids.entries == NULL)
-		goto out;
+	if (trace->filter_pids.entries) {
+		trace->filter_pids.entries[0] = getpid();
 
-	trace->filter_pids.entries[0] = getpid();
+		for (i = 1; i < trace->filter_pids.nr; ++i)
+			trace->filter_pids.entries[i] = intlist__entry(list, i - 1)->i;
 
-	for (i = 1; i < trace->filter_pids.nr; ++i)
-		trace->filter_pids.entries[i] = intlist__entry(list, i - 1)->i;
+		ret = 0;
+	}
 
 	intlist__delete(list);
-	ret = 0;
-out:
 	return ret;
 }
 
-- 
2.50.1.windows.1



