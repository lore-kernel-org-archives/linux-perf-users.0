Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52011738
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9UFPyOU"
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168F31B9;
	Fri, 27 Oct 2023 01:46:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso25284861fa.3;
        Fri, 27 Oct 2023 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396395; x=1699001195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLCn7UHp+SZUNn49syvJKwh2mLvcGW4KGz1Fbc7fgO0=;
        b=Y9UFPyOUUCFiKkZ0Yu3kcYGITrQ3CpII+GjF4ASQ4tYkcQ4mhMseAt90beAayKQyGJ
         5vW06bv7YLC2UHu/CMIBk7B8loESczPjbKH9gmUgvEQZ4HFGjCwVUjtmWJpJP+k3cOp7
         lkyNGzZxwBAQMi7BLSeyfpYxhtRfXKZAy3XPZejlpEuyIday2d5WH7R51MNdo0axctnF
         Xb93GiuFVrp81rWG8OC5N13GzwusuPVuiYdF2AkJuxwP+5QxewSkiLWSBvp2Gsy98ETR
         LuYkzH0DI5mRXvipRrEwzIFRI6XMDzG0bXIeBFIMHfhsp50AyrI6VvIEQl0kbUu/a3qJ
         Mejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396395; x=1699001195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLCn7UHp+SZUNn49syvJKwh2mLvcGW4KGz1Fbc7fgO0=;
        b=b9lq8YAHF/3bi9tqp/fDXSTxBEtuuvUA/z1LvEvBgm66xMTkGRK6NbWXs4hkf+cNAQ
         LTPJW2pCKbjcOj21ym4m1kdI3nmDlu5pJHReGVOAR08Gagbgghzanu45TjP6aMporvBT
         4SKDpuzhQjjejJAFLLkndHYFeW+lmUaYQIyd52RwDNntxHXcR/P8hnpFEPRuCsk+78Pr
         PScO60yUahavUbR5MaJnD6zxnMetOtHqTe/OzD6sNh+F2vyvgr7mHT3KlB9hczCty4RU
         leRF3DMHH3QdByipigiwRWQVGadMqCQgm4eSWet8jOol+D74/vARZg5Ox/OtcYz/89p1
         0Xbw==
X-Gm-Message-State: AOJu0YxpFvxjS+YdOMXkzKua4mqgE25bfN4sNq2IkxXJZcxfZF+q3sxj
	yBK3E6FR9cC+cIpnh6Vc/zA=
X-Google-Smtp-Source: AGHT+IGUvjJGJ/lC22QiIWWvXgmA6P40WDl5e/vGTz779cMSodx/zSxvFWrbY6bA4N1hQYBuTMfdGA==
X-Received: by 2002:a05:651c:2211:b0:2c5:6c7:9e73 with SMTP id y17-20020a05651c221100b002c506c79e73mr1776256ljq.48.1698396394942;
        Fri, 27 Oct 2023 01:46:34 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b003fc0505be19sm1077344wmq.37.2023.10.27.01.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:46:34 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf callchain: Fix spelling mistake "statisitcs" -> "statistics"
Date: Fri, 27 Oct 2023 09:46:33 +0100
Message-Id: <20231027084633.1167530-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of spelling mistakes in perror messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/util/callchain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 99cce43ba152..8262f69118db 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -605,7 +605,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 				if (!call->brtype_stat) {
 					call->brtype_stat = zalloc(sizeof(*call->brtype_stat));
 					if (!call->brtype_stat) {
-						perror("not enough memory for the code path branch statisitcs");
+						perror("not enough memory for the code path branch statistics");
 						free(call->brtype_stat);
 						return -ENOMEM;
 					}
@@ -774,7 +774,7 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			if (!cnode->brtype_stat) {
 				cnode->brtype_stat = zalloc(sizeof(*cnode->brtype_stat));
 				if (!cnode->brtype_stat) {
-					perror("not enough memory for the code path branch statisitcs");
+					perror("not enough memory for the code path branch statistics");
 					return MATCH_ERROR;
 				}
 			}
-- 
2.39.2

