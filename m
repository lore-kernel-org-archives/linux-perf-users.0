Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771012B6C;
	Sun,  5 May 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714907671; cv=none; b=iK5MpA1cvg+C3mHRgy4N6sqKTgD0ilLT5oXDosij9kcAxkvPN4uM/30KZcgUEREPteJL+FILXwFrAedTnDDcZRAfq4xsLKthX62iTCBPEgZ83lE759pGx5eECe8gDQ19CP8k1kGXR8GOw3SNKip9dvNLefLAuBDu0kVUBNywfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714907671; c=relaxed/simple;
	bh=xKnBTCxnt5rlmVlrpPihx0UXzUvVRUUzCiDejy13t0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vocr+ZJtjXkJwfPt17Y9Iz+YiU1Ci2mUKHatsCulKYINqlAnWsNdnH9Pso5Bbin+uwxpdi6yTZ/PNiQhwoD7oNFJ8Myk+RK6H2DlBqIEihQt+hnDNLrTLGG435H2FUWRRMUSX+D/p1EAosBuAGm4DBfnGr9zlwqVWhKRbRN0pUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HXteSmh1; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HXteSmh1"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6326C14C2DE;
	Sun,  5 May 2024 13:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1714907667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKbH9oEqAm9I5NHPxq8nJr2oLH8flpN/ZtGXaQSeqZQ=;
	b=HXteSmh1JntxcCesRQRXbEQPzP8ARQSjY8nvhssf4dEGQmhLh6AQYcmOMZzNKVttuu7pze
	cRZcSA+d82CUJP3Uc9eA6cYt4iAyxJ3HEbA46FFmfJE3JgoiVtz4aXtxd8Z+9REkiZ485f
	2NgmpEhGH9zDYZ7iukqT5AVEU6EvH1gBJKvNz0Bm6a6UqUaIEP5XAGWy8CnfWU2sDvqAea
	r14JqdI2G0Doh7mdj12TrSf+/ewJNXKKU0WSKF+asZRPDu8LhhUHTHN+cHcw7V25bc6DzF
	Sy7rGxR98pSstPzoUfroAim8bheqX8VRcORTWPQOEkwkl2yWvBAVScJkt+BUew==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 32b789c4;
	Sun, 5 May 2024 11:14:12 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Sun, 05 May 2024 20:13:59 +0900
Subject: [PATCH v2 3/3] perf parse: Allow names to start with digits
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240505-perf_digit-v2-3-6ece307fdaad@codewreck.org>
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
In-Reply-To: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=xKnBTCxnt5rlmVlrpPihx0UXzUvVRUUzCiDejy13t0E=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmN2oDVJM7LJl9HF5S6HxBR2ccQNvyzGhy8aGv8
 UHj480KYc2JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZjdqAwAKCRCrTpvsapjm
 cAFSD/47tK7VTcnW0HNnFkX+F8PJj4kYKJC7wEQ7oqOMTctVgA5NKVzSQ8QR5RoOmzd9lGrl3ca
 RfQd3RKH4B+2F9QC/xfVrSEexUJZBLCevj+9m350EcqKcU0v3+iKZChrkauRBmU42RsEWeukoSX
 rsHAYSo5NDT1xrZLk2AN5iYO0wHK4CHT2+MKcjD1xokR/sQItgUdU+tE4n+Uci+TfsNk96jl6NV
 sdNo0bwekQuiGhAWuiVCaQ+B0DspOPwdYun2tX9J4jB0e5ilMoOKolvWXuVihfILdSV89v1T5G3
 CoP6hFRmOwWLku3wnrVwoYcMo6ZRvYyfvhJJyqyF2PheWoTzhtBiCBR+9pP74vrj/oqlgX3fASi
 OEYpd2rZEuOEpya7V+ng6TlEJejsqektG+hsu+k8f684w//cbbXrHRphdereFIWixmwkuuptIC4
 16yHFM32Wx+bMNzpu6Z1gqIB1xl++v1ArN/GMq0kXOmhWOvW9DSWhNhqQnRZQH89dsLYVYfIktg
 oIc/6LX/7k/QoFVEFojFoCMC8brXwJUPgcifHJ21EirZhYMxjNkpLcB+VA3OxflFbysKkTTJ2mj
 PjC3mvXnSlenxumEhV97klUd609TrmoQldDqdEwO8n1zjVukFqIQBkwXC3o5viBQkKnHg/4Mux3
 429FgpW3kWOjVPw==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

Tracepoints can start with digits, although we don't have many of these:

$ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
net/mac802154/trace.h
53:TRACE_EVENT(802154_drv_return_int,
...

net/ieee802154/trace.h
66:TRACE_EVENT(802154_rdev_add_virtual_intf,
...

include/trace/events/9p.h
124:TRACE_EVENT(9p_client_req,
...

Just allow names to start with digits too so e.g. perf trace -e '9p:*'
works

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/tests/parse-events.c | 5 +++++
 tools/perf/util/parse-events.l  | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index ef056e8740fe..6cf055dd5c09 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2280,6 +2280,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_2_events,
 		/* 3 */
 	},
+	{
+		.name = "9p:9p_client_req",
+		.check = test__checkevent_tracepoint,
+		/* 4 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index e86c45675e1d..c36f8dbf593a 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -158,8 +158,8 @@ event		[^,{}/]+
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]{1,16}
 num_raw_hex	[a-fA-F0-9]{1,16}
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
-name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
+name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
+name_tag	[\'][a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /*

-- 
2.44.0

