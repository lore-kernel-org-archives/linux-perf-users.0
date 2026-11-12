Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453507;
	b=3f76hLs/FqZ8hLxUk35bfUWA1nNj3CvE9yUWorkZRrr7+RYCiwe0Svhs4wygJ/QdbWeG
	 JEp3eZrd0wr6Bp+Jy0ODoVLLi/6a5VmzvzrRkpcGWWnvsyfby+lZdi4iz9n9B8H9jjK82
	 vUDMaR+Q6ClrLJbQBRGkLwz42Yl1BUt5tI9XUojvdn1Pqv9SVz4fwir3gQVcUiNFs6GBR
	 3eoSeujB68RTQrdjw/sBh+iefUbZfmrQv9pIzuxaL4nove318ACPGJmvV4mG4ZXjeWbqj
	 CHN+hLwotY7j90A0xad09A4kOivP8Z3H7HXG393ogvDqFn446wWarF/K2E0elleWFLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453507;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rkgCe3kcXBiUoWZroWE7dS9OWAduUX8NcGUg0zi5U+0=;
	b=hIVX7S6G1iBFeEKmmsQtvZTERrdqjN8h9T1yxQqmHV45EOJUpcA44nBGmWMt6rIoqdXF
	 TyZzDgXuuGhGhiFUTfX04PiP27PI5qZ6bgZZImpHr3zXk5aupwLrql6cCZNYaiUSycEJo
	 yOR75GtElVnwsJ+rY30mgh2h7c2jjhppFiXjNKpXury5QpBZdYgqQ0PeqgWHTb0ST0rdZ
	 XTKznHDti3z6K8MiK5zDhMy+yCurIGKXfEcUoDnV5xui2vKhRGnvQyiQGn5zwE3Vt7t7k
	 86Dboa3y6TSvGPVEf3+66hBnpSuntM+w0YkUoHHiRw0sSsTmL3wfa/+FHgXwN/KXsOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=z8pYuoT3;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF4606A327;
	Thu, 12 Nov 2026 03:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79EF4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=z8pYuoT3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=z8pYuoT3+oelYGU7QjFGGAOE9sC2+usMTKNc4QjGNvjprQs8nHSpU8fS5t253CTLarbpzHFY3VBCd
	 JP64daZWBqq5LBuVxMgslsS0cve0McPx8038kSmFNe+EB0W6Ln5Y1MY0voWwTsSzRkuJHQgHX3eHUl
	 VXvWyBVAKHmfPS38=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af5300098c-a9322;
	Thu, 12 Nov 2026 11:18:25 +0800 (CST)
X-RM-TRANSID:2ee36af5300098c-a9322
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af52ff4f37-f0400;
	Thu, 12 Nov 2026 11:18:25 +0800 (CST)
X-RM-TRANSID:2eea6af52ff4f37-f0400
From: Gu Bin <gubin@cmss.chinamobile.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@redhat.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf trace: guard free(new_filter) to avoid double-free on OOM
Date: Thu, 12 Nov 2026 11:18:09 +0800
Message-ID: <20261112031810.1899-1-gubin@cmss.chinamobile.com>
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

On the asprintf() failure path in trace__expand_filter(), free(new_filter)
is called unconditionally. On the first iteration new_filter aliases
evsel->filter, so this frees the evsel's own filter string; when the
error propagates and the evsel is later deleted, evsel->filter is freed
a second time.

The success path, right below, guards the free with
"if (new_filter != evsel->filter)". Do the same on the error path.

Fixes: 90df0249c2ea ("perf trace: Expand strings in filters to integers")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4094141461f91..f4a67491f5be1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4679,7 +4679,8 @@ static int trace__expand_filter(struct trace *trace, struct evsel *evsel)
 
 					if (asprintf(&n, "%.*s%s%s", expansion_offset, new_filter, expansion, right_end) < 0) {
 						pr_debug(" out of memory!\n");
-						free(new_filter);
+						if (new_filter != evsel->filter)
+							free(new_filter);
 						return -1;
 					}
 					if (new_filter != evsel->filter)
-- 
2.50.1.windows.1



