Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788582;
	b=HofQ5LbVzMl5obVIYLbxg4XlQun0Z976LjLUJYjrLzz1Kcc4r9nkAuH4JPJ9SQa4Idl+
	 EDXsAYxOmZw46KnRYJ7xnnmobBA9J8wSDAFDeBRFtpDeCFOftauRfa5Z+orpDs5erzTtY
	 sJoiFwPPAiflxKXhdjOwRH736JK6AeVw8ClYmlxsew38jdkJYdMvcXY96PxanM0h/tBaP
	 hBUhS8PeCgWP5wATlo1LEWaPoKl6Lr6SDizOsyj+jqtsXUf8x6tdb5leUqMXkVxoNQSvA
	 00QnYyLP+Rr4sk2S8T2/Pncu0nC+FZb/o1EzHazQi14s6eIl6O9QIzl6gMFmc+/5L1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788582;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3R6H4nmALRF5bd3rg0DNAJDqLFgFqR9KvvKwf7fQjBo=;
	b=IVVH3t9FJaChYYwze1KIkLt3VlqnmOgwDVOIxBUvRLbaHIKthQ6rAI7XyZKAuM/9U1u7
	 CiM4p9YuyED5MaCK0g2/H+W0CL94IMEKqKlg/Iu7s8FZWMilYi23dbMKJvpCrt4Qjx22b
	 y0jwmOA9W8a0iEmSDqjz1jjJEhQ+MUXCvEp+oVzotSHm/kAmZ4e1CA7bGSFiTGckxznDe
	 AfAvp25Kq2V878RygTkRo+GRgSXwPeKVF6ye+G8MOqo4ka07WctB8jscaY4si+xY2yg8O
	 7UV7ZUPoqSwi+SXPUj/5v3vzheo1LMzYTjzwobUhq1IBRoBTDgBw2wQQGvJYfqwlrvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xDojqDEA;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AC5606A31B;
	Wed,  4 Nov 2026 10:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1AC5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xDojqDEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=xDojqDEAMjKH3R512z/2NAzqMNJv+6ZbW3mNEQDAdZIWzSSeGXGkCgci2Xdl4UZ7qGOR+t8Fro1hU
	 7DxNQqpZpJ6d/ZZbxnXFKxaXEl77tfgbUlm7D86qSsRrWT2wanieabRH+dFWxutUjjEhrtJE9paJJ1
	 JN+JCdKz7zqcZxcA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86aeb0a9d515-3d21f;
	Wed, 04 Nov 2026 18:36:16 +0800 (CST)
X-RM-TRANSID:2ee86aeb0a9d515-3d21f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeb0a98151-1f53a;
	Wed, 04 Nov 2026 18:36:16 +0800 (CST)
X-RM-TRANSID:2ee76aeb0a98151-1f53a
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
Subject: [PATCH] perf evsel: fix buffer offset when building the EPERM error string
Date: Wed,  4 Nov 2026 18:36:05 +0800
Message-ID: <20261104103607.1903-1-gubin@cmss.chinamobile.com>
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

When building the EPERM error string, the scnprintf() that emits "No
permission to enable %s event" uses (msg, size) instead of (msg +
printed, size - printed) like every other line in this case, overwriting
the "Access to performance monitoring..." preamble and truncating the
following hint. The message shown to the user for a failed open with
EPERM is therefore garbled: the preamble is lost and stale bytes from
the overwritten content remain in the buffer.

Use the correct offset and remaining size.

Fixes: c1034eb06920 ("perf tool: Make perf tool aware of SELinux access control")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d060fca8090f..6d69f63b7fb1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4590,7 +4590,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 		}
 
 		if (err == EPERM)
-			printed += scnprintf(msg, size,
+			printed += scnprintf(msg + printed, size - printed,
 				"No permission to enable %s event.\n\n", evsel__name(evsel));
 
 		return printed + scnprintf(msg + printed, size - printed,
-- 
2.55.0.windows.3



