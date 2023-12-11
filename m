Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkYC/+W6"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CED99
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 10:13:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf61210e3so53678967b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702318382; x=1702923182; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3zU0Mza8xelLsIrsnPiZI1psCs6jGW5zuolURJTG2A=;
        b=qkYC/+W6fAj6/EytOdsO61Mf2TH19e+VrAuC1bTyYHA4e49Fnea4tI5JkTEXVAfZqu
         A3IU0TFs6TCcChAoHnI1lTf12zG2mM+/R264rSykA2Wg1qTJos8gk6C3xd8RjuqBl496
         GruzQ8ScYweLw0sDzKoAKsaSlQRrLjXoWlHrAbiAs4nHXH0/ifZYkQFiVHSjJdr6hbFr
         HBflecuFmovXV7Q7txoVIHTJ7nH5Lg9JOJBGRK+7P8fJ/dyZT9uUKynLdJzlQmaiS2XC
         gtfxjNJstDSeXEwAG9bImWO88uwSMAojul7q+tnr9EPej3h5X4N0PsYFKY+ZvXgB8Jy0
         O6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318382; x=1702923182;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3zU0Mza8xelLsIrsnPiZI1psCs6jGW5zuolURJTG2A=;
        b=uwVb0DNTyp0NH2C/qRhKy/OF5kbZEVmnkSlwbt21c4/lQOw9tjlIAqAAhTH1ubwR/m
         buLg+MGdYtRbOHeLUEbl5i3U5ijjdlDu91+KXpcXo+MBuy3ydVs/emp7jganqEH61cGt
         J5ftBmhoNtmVATv/3cin5NSB11psUO1jMgl45CC00vniojEgLkPyGrDEtHM6aNDX7l8N
         btg9RHXUvvaXsS5XM4ZbLkbrAa6jSmgMsagM9dgBByUtDYZP8AFKzIa4za7JJPGABuha
         6AqDuNywdNw+Yy9SFq+fkTj8zE960xfjsE2u9JOqxBpLZwlXmsIsh6fxzcNCorO2S6RW
         33gA==
X-Gm-Message-State: AOJu0YzgMI+b3QR8mhrQETVGvVgRGxvr4dmzPjclhHqp/qDiWa2XgTHi
	jf8L58bpmxM1q+/ai3pHmp3X+kl13N2G
X-Google-Smtp-Source: AGHT+IGVlhrck8yldxsx8dzUPl5v/hDJwqs4ANNzPwmrRmXJdkTzkOSefZMYaoKPX7fG+zB0OzOPNJxTw47L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7997:94ef:ba9a:d2b6])
 (user=irogers job=sendgmr) by 2002:a81:fe04:0:b0:5d2:735c:b9f4 with SMTP id
 j4-20020a81fe04000000b005d2735cb9f4mr40965ywn.1.1702318382095; Mon, 11 Dec
 2023 10:13:02 -0800 (PST)
Date: Mon, 11 Dec 2023 10:12:41 -0800
Message-Id: <20231211181242.1721059-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1] perf stat: Fix hard coded ll miss units
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guillaume Endignoux <guillaumee@google.com>
Content-Type: text/plain; charset="UTF-8"

Copy-paste error where LL cache misses are reported as l1i.

Suggested-by: Guillaume Endignoux <guillaumee@google.com>
Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 1c5c3eeba4cf..e31426167852 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -264,7 +264,7 @@ static void print_ll_miss(struct perf_stat_config *config,
 	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
 	print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, color_ratios,
-		    "of all L1-icache accesses");
+		    "of all LL-cache accesses");
 }
 
 static void print_dtlb_miss(struct perf_stat_config *config,
-- 
2.43.0.472.g3155946c3a-goog

