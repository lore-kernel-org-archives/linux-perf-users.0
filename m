Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559936;
	b=UQ/sUSK17jmOYn9NPJMKf2UuM6wIUeQMWCO7VgeQfhoDDp0wmqOSDJ4IeNKsAaA2GYgI
	 iueXaOFq1YQ71htkDmXF5Ua4Qxmi19XMZQ17AZqO5nQXl2y/kJCyOxa6vBtT142lQn5Tw
	 AypfFerOkmtJJU+PGz5SwxS3EoYfMGbzsw4KiLWNzbY1YhNJ9bKxpoO0Y1BxIlxDuccOu
	 00M6S9H8P797QD730aTLZt3XP173D386zQAqiVlDVhRgeok2+/pbylu19cImxgiGR9EAq
	 olzdRNolHItXWuJLwh4xiXZF8zuSmZkpfKbFrs/ZiL1xD2TpyQ/7F13TZ/zibZGx/7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559936;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wtaaWGkNtrZKN3+YRi7hlUoVrdf0ltLOVxSsQvs6oT0=;
	b=00LG11jM1TjqmCWWOnneLpXqnDXtprqb+lfTPZ2S8eUkPOB2XWLfdh6pBuHkhVG9TMRY
	 AUinibXAL0wUZ6I/X8PiOmCcSxBE7XuDzK3xtYXmWZdQCEG8u71fBzKmv5lDnnXcB8Wwv
	 mXbeEM+5fr1CUSuXdxrTBOM3FrsUlDk1vm3X71kH4HgGJWqJK9+6Fb6mS6SDplCtOAeHZ
	 USskdBCERtEvvFTY6f8UFT1W8Pbze+gTgDNOiY6wKs4eGWA2cJBw72CA8btlZ2P4P/KzC
	 gS5MdJSlzO510xTHcPnVHXsiPGRDsaZ9PET25Fl1m/WtwcsDaqJCmZhzkOxaPrXaTWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=S2mnvMAy;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6960A5BE1;
	Fri, 13 Nov 2026 08:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B6960A5BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=S2mnvMAy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=S2mnvMAy3kFHMjSeSlC0WWNjRfrCSRz5XxZxR08Tw6kzx/FCdc2x5lU4boPhttP8MsfWTonubkQOD
	 46U7r2k7XRtcZALvuN4/HdGE7ejAjKfnFLQzRAChcOT21kNshVkxVWn6pUQ9I0Gb34ueOEutXKqeQ4
	 u/1rF3qMZ1MbSzLQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af6cfbb51a-8a7e4;
	Fri, 13 Nov 2026 16:52:11 +0800 (CST)
X-RM-TRANSID:2ee86af6cfbb51a-8a7e4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af6cfb4353-1edfa;
	Fri, 13 Nov 2026 16:52:11 +0800 (CST)
X-RM-TRANSID:2eea6af6cfb4353-1edfa
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
Subject: [PATCH] perf parse-events: free evsel and config terms if term conversion fails
Date: Fri, 13 Nov 2026 16:52:00 +0800
Message-ID: <20261113085202.2334-1-gubin@cmss.chinamobile.com>
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

add_tracepoint() creates the evsel with evsel__newtp_idx() before
converting the user-supplied config terms with get_config_terms().
If a term allocation fails there, the function returns -ENOMEM with
the evsel not yet on any list, so nobody frees it, and the terms
that get_config_terms() already queued on the local config_terms
list are leaked as well.

Free the partially built config_terms list, then release the evsel
with evsel__put(), before returning.

Fixes: e637d17757a1 ("perf tools: Enable event_config terms to tracepoint events")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/util/parse-events.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f3ba70d4f76b..e4f842532145 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -490,8 +490,11 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 	if (head_config) {
 		LIST_HEAD(config_terms);
 
-		if (get_config_terms(head_config, &config_terms))
+		if (get_config_terms(head_config, &config_terms)) {
+			free_config_terms(&config_terms);
+			evsel__put(evsel);
 			return -ENOMEM;
+		}
 		list_splice(&config_terms, &evsel->config_terms);
 	}
 
-- 
2.50.1.windows.1



