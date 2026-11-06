Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931536;
	b=kVNE7ap+RFLzXCiMrqgRaDcceglZFCibRdbn8r6O3deu8Kt4pYXwvwNtgQUryhl+sAl2
	 QkaJMQqvRSavlFxx0XWDurtZL/U7ORKPJmvUTBbkLeFSLiIxq4HEC+xTzGkJHRfQWpAOH
	 NYgwUwynx0PDuuPNzXKga+R0ANuBulxWIvnbXRPNvYfg5H0cUm/6Klt77BZvGrvVPD4OJ
	 4tUXsbFsc3jzT23q0kSUdnGM7Ht3Tk5AuRktChtsW/C6X3TRqsCFrfMRdKSgqPAngpWED
	 8ua2kmvd8rP21uam07PmMLQuMjMwMhDK/JPRzqf2ebjgPiMYxieQMgSJkn0RY00hJnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931536;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=6dJHP+Y2OwGWFMqm8HX9Xg7DmSky1rjFU2yZpEk6AQU=;
	b=1YydsLCkzMKxpNGbsh+gZGQf8io0oHyzdPBfRjsCc65dKrlQs8q7gtTVoZon0yYMNOac
	 qVrUlpdp/ZAzSpB8gQHQ49e1UOHeZQCIjhznOlGdUV7LQ8pPDhPgPrIBDjSpzOaaOvaac
	 w99Lti+S8uYDrxj828R9ksDpoIS2qSahT0uXwt5Pgx3nx2Mzf0vEb73SiefHpr4/uwCoI
	 MyuIkv6gO7CfR9CK0bqLzLsB7EyMj8jCM17xunwbL+Mvj4Jz55b72YDQUiYu5aUc9fAct
	 c+owRTAXN7ttTYF9m444Ovlp6dXyPOn76+9BWv5UTmLCpF8O6A+vniLLtZVV52tU40g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=YaXhvS8V;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7661F606A326;
	Fri,  6 Nov 2026 02:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7661F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=YaXhvS8V
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Li RongQing <lirongqing@baidu.com>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf iostat: Release the port list if command allocation fails
Date: Fri, 6 Nov 2026 10:18:40 +0800
Message-ID: <20261106021840.2186-1-lirongqing@baidu.com>
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
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793931531;
	bh=6dJHP+Y2OwGWFMqm8HX9Xg7DmSky1rjFU2yZpEk6AQU=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=YaXhvS8V8yVplJhtIzC6z5RSzCaO2w8SWt8GplXqopxYWfABRFS3qyR6pmopRqV4M
	 x+6b5W9QFJMfggN2GITPJrQ06H4fUtgwc4x3k48PuNGYNyo1ADQuWjfLCrcpzLl5bW
	 AeXvWrEW1JbVZxyXLRJrbhPRwM40QyC7Pex2UqSj3ZHY9+UQWNbSDqKkD9EWcic1eH
	 HMjrPU/3iztlKDKL1zM5MM06rFiDQJ3AGA2NiQ3+tTNPLM2lA2PwY2xbswpupICViy
	 cGDWxpRYH6c0NnQ+TZalnqi2C2TfuCRsMVrJu5fAXVZhTQmN18gMnskbrKvtO8tgre
	 TaSpbECx69SaQ==

From: Li RongQing <lirongqing@baidu.com>

The event-group builder takes ownership of the root port list and frees
it on its normal and parsing-error paths. If allocation of the event
command fails, however, it returns directly without releasing the list,
its pointer array or its ports.

Use the existing cleanup path for this allocation failure too, before
any port has been transferred to an event.

Found while testing the iostat fixes with allocation fault injection.

Fixes: f9ed693e8bc0 ("perf stat: Enable iostat mode for x86 platforms")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/arch/x86/util/iostat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 2dc5ac6..f8b4939 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -342,8 +342,10 @@ static int iostat_event_group(struct evlist *evl,
 	struct perf_cpu cpu;
 	unsigned int cpu_map_idx;
 
-	if (!iostat_cmd)
-		return -ENOMEM;
+	if (!iostat_cmd) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	for (idx = 0; idx < list->nr_entries; idx++) {
 		sprintf(iostat_cmd, iostat_cmd_template,
-- 
2.9.4

