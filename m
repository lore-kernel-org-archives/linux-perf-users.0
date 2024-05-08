Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C721373;
	Wed,  8 May 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209282; cv=none; b=ojzlbGl2vJBwHXUrnF5WRwF+zb0DFfqi0Q0SZVrLD3nC+Onv55B93DcqPQwWpnP25SUc7Hwn0eL+krdhjjCUQ0uWbsYJFa7+9sL6TxqLM+KGuPBwwZlL6TJ0+BQi5N7EE7M+unJxvXBmamoUm5PtNRf5PwX3kBy95xaqo5ZLMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209282; c=relaxed/simple;
	bh=VFopXksH54fTTJDgybtqA31zpOE9Hd41aNi92fkPhes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0KDzKUg6Xfvy4nEnRTPBIBUFpMiisjH6gXeIVgU+Lgq6pfZvryCecI7FIax40FtXG2AbWZuHY6mCb+DSuvFvUud8ufGF/tojpEVjSEJQN99xHAyDcfKtU8U7bPF/W3CmKUmXQDQ+0/XNIs2Qt+KI+bUrY5Ibiy6xQ95sdiFlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=I21xA386; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="I21xA386"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CE59314C2DD;
	Thu,  9 May 2024 01:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715209279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLELdqYDEqKXiaXhVR2Yc3TRepFAVyLz/mWUqzkCaGw=;
	b=I21xA386Wv1D7lVR7KcG8plD2xFMY43KBpmCDLj/PUd5RImDrDuhYt3SGznd3B1BIhkL98
	u47PA9YA9QhHp6PYu3de4nBVjcwyE4BkKIJoFwpipx7dHJphEbXU/H2oUsuSu7ryVc+zL+
	kjhTAq31cz92zsHOdGOmciCDgcm7YJ+YcO8Ij3mYlXS9oSBkzi3svL/kvOWbgao0pFDSEO
	rvgSGz9VI8uHryGkcIZAa1+n6rHCL2/pCyglZQFtDna6IPoZix8UNAlmHp9uQora6BcSKt
	LZEN+VM/yLlUqo+jbzV4GehEGR+p6U6FC5wISe4UP55r7Z5UmKjI4fvkmqhrow==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id c5ce0fef;
	Wed, 8 May 2024 23:01:02 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 09 May 2024 08:00:47 +0900
Subject: [PATCH v3 3/3] perf parse: Allow names to start with digits
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-perf_digit-v3-3-9036bf7898da@codewreck.org>
References: <20240509-perf_digit-v3-0-9036bf7898da@codewreck.org>
In-Reply-To: <20240509-perf_digit-v3-0-9036bf7898da@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1859;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=VFopXksH54fTTJDgybtqA31zpOE9Hd41aNi92fkPhes=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmPAQuDgfJSgSBBuZI9gOB6kcLvMXJ0ESNELf26
 Cpx7pHxLZiJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZjwELgAKCRCrTpvsapjm
 cMcdD/9Vpf3/YYoo0nd/oE0JPOO+iOGLUUYWDD2SFW5uq4+zlzkuaJVc/qlaTx1G+L3UV3dZwkI
 gDvgbsEc6pTLhtHE1b3yEQgTJJoo9Y4UPU6oS4YniGCvuu/Z4Ju8SXUlZi8UWVqmDy2qmiqr//E
 0X/A35xSSoUy3lvS0cR6XaGxAE4JuTou0DzVOJ4CDy8pjTpZ+Mqu0gXauTaR433X4cDzWBfJbw+
 OE3IWeOxse9AvJINiyjqWp45iO8fgLsnngLOiIIOOaJtcuJbvFed23dJILF/L8/QLTI7MClZVOe
 dBDXLXToYA+2sDe52aLY4/CJCRTxqRfSeeKUI/jt2PFxo3omVn1sFoSK8p9LWp88CWua778kxEL
 KnDi8lVZVrkwHiU+fW1pl+nQr/7abn1RWrbS50Nb2dwsCfmGUd94ECvXukigm/Md6ixYXwLmYyk
 RQJLG9zIJnOoc4EpEJb1+iwDtn4Xr1dHH8BxCILUuLvoZFaPeC8UeOwHmI8PADoX/4x6qJeaZLO
 IOKbEvXBzw/xaVaUrL8/2SKDf0W5iHep3wVD0nBvMuAxED4/GQhFEPZhtww4TMae64y/f17x8Vh
 A4ophS7XcE35wVdV3Rzp2ijhSc4rWQ9krbLxFdU43Z5Jgxmw5vuzC0BSaPxSpSy/d+ieOtWJIFg
 /eYBteH3GfBZnYQ==
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

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/tests/parse-events.c | 5 +++++
 tools/perf/util/parse-events.l  | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index c3b77570bb57..417d4782a520 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2269,6 +2269,11 @@ static const struct evlist_test test__events[] = {
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
index 08ea2d845dc3..99d585d272e0 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -242,8 +242,8 @@ event		[^,{}/]+
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

