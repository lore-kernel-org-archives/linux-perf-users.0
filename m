Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470977;
	b=naebTqLkt+3wvBeX3s9U1mRVgmq77fGhn09hKyNnWzHZ3Dgcc3bjFIySRPgrVUNJresH
	 LCALqFEbfLlL6BfjiLTAEHr4jo5/cjSd6knSxheDvwknq8akUnrWksVAXh80R2avApsiW
	 PISEDMD7V/SdRDAaGIhpXamfwmaAYw6n6si4XfxcZXGQpJo5zIZMwDrBR7uK/SbyxnERK
	 lngg2ytYyh74R/sY3oBl2p9JIRT0p6wvBC3syNzThM5+sT1L0oiIl1mWkghRXS+KlLdsM
	 PONdYOjwf3lCxBTWuyBYLOr6kd81vkG0H+fXNNGX0Ko21ig5O5lW35IStm29dbxmPhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470977;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DjAl4XgOg1dS5z3yYb4d+Tk1gYH65D5OSWDssukR0vI=;
	b=xs/W7LGZlVjI4fEpVoHC/LuClSQX3iu29ncp85thlMgJoOqrjRhD/yzFNLAdLq3QQi8T
	 HewRxuZ9vpv4xO1mUkrUL22au9rBt6KwVld51k+ZubvnWda27cwxvl73x74uA1etQ04XY
	 tZAc5pD1ncQh7La7iEBtIgNiP4NejRciXWUeUkJlHi7SJMTGO8bwA81CY9nhmFzWUou05
	 dOC1ZfAwg/MX//SvK6xIUDL2ZpNXb5HIrjLerkQ7txMGz6g/+qxijbVNFCPjHRxqALs6b
	 eMlo3lUWHXLHPrA87MegmLNzDYBSj3g9RDF92EVfG4z2i2hYHLxGt8BCp901rep8wyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fh4UZyPm;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DB606A88D;
	Thu, 12 Nov 2026 08:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 189DB606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fh4UZyPm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=fh4UZyPmoEq0QF9EgZQer4kgYiI/sYLgAkO0qTryrvYcB3lyNuUCkN+N/XnpdSqHPYE9OoVtAuBs6
	 KdBswuDForKH6WNa9V2RyBtSueD+6sTxCNN1+/SIUOijdg7q/VtJJqYXrvhmjFl3lgHDQxG4l1kX2F
	 2O6hb8bhgd0XO6wk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af5743d197-dd8bd;
	Thu, 12 Nov 2026 16:09:33 +0800 (CST)
X-RM-TRANSID:2ee56af5743d197-dd8bd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af574366b3-f8c0c;
	Thu, 12 Nov 2026 16:09:33 +0800 (CST)
X-RM-TRANSID:2ee96af574366b3-f8c0c
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
Subject: [PATCH] perf trace: propagate evsel__set_filter() error in trace__expand_filter()
Date: Thu, 12 Nov 2026 16:09:21 +0800
Message-ID: <20261112080924.2082-1-gubin@cmss.chinamobile.com>
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

At the end of trace__expand_filter(), the return value of
evsel__set_filter() is ignored. When the strdup() inside fails with
-ENOMEM, the function returns 0 anyway, leaving evsel->filter holding
the unexpanded filter, which still contains the symbolic constants the
loop meant to resolve. The failure then surfaces later and indirectly:
evlist__apply_filters() passes the unexpanded string to the tracepoint
filter parser, which rejects the symbolic name, so perf trace fails to
start with a filter syntax error whose real cause is the missed
allocation.

Propagate the error so the -ENOMEM is reported at the source and the
caller fails immediately.

Fixes: 90df0249c2ea ("perf trace: Expand strings in filters to integers")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/builtin-trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Found by the sashiko review of the fix to the asprintf() failure path
in the same function ([PATCH] perf trace: guard free(new_filter) to
avoid double-free on OOM), which flagged the unchecked return value of
evsel__set_filter() as a related pre-existing issue:

  https://sashiko.dev/#/bug/linux-cbf4bb01-a981-47dc-b440-68e5c9c3e81c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4094141461f91..ce1a7352ea9dd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4704,9 +4704,13 @@ static int trace__expand_filter(struct trace *trace, struct evsel *evsel)
 	}
 
 	if (new_filter != evsel->filter) {
+		int err;
+
 		pr_debug("New filter for %s: %s\n", evsel->name, new_filter);
-		evsel__set_filter(evsel, new_filter);
+		err = evsel__set_filter(evsel, new_filter);
 		free(new_filter);
+		if (err)
+			return err;
 	}
 
 	return 0;
-- 
2.50.1.windows.1



