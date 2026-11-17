Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909380;
	b=bSigv5qF10sefRi2IrZbcfoDdOVURu95K3O5hGtMBu77Q7br4QwYnq39Td28qwg5D3fo
	 z52RW6GmBIizZr2PffQupCSloelJBw42pkJ4PofzOK4jkBNvaD/KbuKM5V8uTMNdJ26cJ
	 byKXWT8h+NI3qhKnxWAUdtCnACdSGjhXvg8AvgfvUWU1e5Ig2iSqIfmjJaQ0VoPzFSo5O
	 4URnZh+NjqxnXHbYQcxi87TZLTyU8EeMslc6jBerkHA2he0RaFxZK9b7qsGpHfJFVsuCV
	 uI3ZeMnvfMibGbSJDsmxIM9JV7TG42V7KdTy3vGChDtKkl5IAURisl6ExW0IGbqbxdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909380;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Royer+bWAP6YmMyoelMLXXSfC/ffN4vqj+ijoI0otKA=;
	b=dQ29IK3yS4eUi8oPBj6Jl6omQ1O4Kzravos+v6W/I0QNYW/qujlKMI77vJ2bEx6Ffjyp
	 +7ZpqDXXR2hAIxth4fjEVRpLzeRkhT3ksap9BYbdZuqBGQlHTDHB6c7o9Susr6HpC+Rfl
	 aPNDjRum0fCfVzW0La+6c4AQbV1ZfMWKfo7ug+Mt35n2U3d30EKEaa/88MS+++ZBtPgkP
	 0QIRGQLqipsSVK+YYNYjkKyElqv6mJSioN6yMcOmfjOkcyvp1PrvRVf314N/ZRPyUfKwh
	 5HxNOis0ffgdiyxd7wPkb0/hxnTqO8/xwPME95VaoyeLG6AkTpflWTGgb43zuGSscAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wdtTOOnU;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721F606A323;
	Tue, 17 Nov 2026 09:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A721F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wdtTOOnU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=wdtTOOnUbFg7uM1vhCy+u24JzFgLHZ7f7Gf5AvVCO4a+LXpvZFoQEhZUl/6AtZ30F4imIPdfDKoLC
	 iY2H16rmKiV5SAidqmCDvNA1vK9WDfD7NjI0WnQ9SQ2xJvvBTA42gF0/cS8UWPsYV31kcaPL3a8aHy
	 nUWzmR1Cnbuz35zo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56afc24bb3ed-06e2c;
	Tue, 17 Nov 2026 17:56:15 +0800 (CST)
X-RM-TRANSID:2ee56afc24bb3ed-06e2c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56afc24b5457-acde9;
	Tue, 17 Nov 2026 17:56:15 +0800 (CST)
X-RM-TRANSID:2ee56afc24b5457-acde9
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
Subject: [PATCH] perf parse-events: free partially copied terms if term cloning fails
Date: Tue, 17 Nov 2026 17:56:01 +0800
Message-ID: <20261117095603.2397-2-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261117095603.2397-1-gubin@cmss.chinamobile.com>
References: <20261117095603.2397-1-gubin@cmss.chinamobile.com>
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

parse_events_terms__copy() clones the terms of src into dest one by
one and stops as soon as parse_events_term__clone() fails, leaving the
terms cloned so far queued on dest->terms.  Both callers,
parse_events_add_pmu() and parse_events_multi_pmu_add(), return on
that error without freeing the local parsed_terms, so the partially
copied terms and their strings are leaked.

Free the local terms with parse_events_terms__exit() before
returning, as both functions already do on their later error paths.

Fixes: 0d3f0e6f94ef ("perf parse-events: Introduce 'struct parse_events_terms'")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/util/parse-events.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f3ba70d4f76b..8ab02a2fe1c3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1539,8 +1539,10 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (const_parsed_terms) {
 		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
 
-		if (ret)
+		if (ret) {
+			parse_events_terms__exit(&parsed_terms);
 			return ret;
+		}
 	}
 	fix_raw(&parsed_terms, pmu);
 
@@ -1642,8 +1644,10 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	if (const_parsed_terms) {
 		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
 
-		if (ret)
+		if (ret) {
+			parse_events_terms__exit(&parsed_terms);
 			return ret;
+		}
 	}
 
 	config = strdup(event_name);
-- 
2.50.1.windows.1



