Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD218EC6
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jan 2024 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdJHL6FX"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eef1c0fdadso53624417b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jan 2024 21:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258436; x=1704863236; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbllDlnO3rG864Ljl3o3amAjh6guujvESwDRIjsIsd0=;
        b=PdJHL6FXm9mUjvkU+Rp+FGxsujYDKgrYBGnb7rHmF75miV3ClNxoXGCjUUFOBfcLYW
         zvD+e49q7l9tjPUrm+/bzK41mZmZPQ0E6LY7qiAjV80ALvmtmi0FoKwRcJI/q26Rjl50
         OdSuXc5xNvFbJ8SDMZhvVmNfjibNKRqm5M4dJOlsBqrGfbwt+tYevxhN/Nuj3dfcEx5U
         75/yiy+2vs5tpcB+D4Y10p9+37dKpjCDuTvJRr+xWMa+Vv3/W9M57T9fouTcmKgZPps5
         M2acrH6IGaAsC5caFVKOjckgXOikoP04cBffQIPMQDTJnUMr6sYHLvJgY4nKAMxR2ls4
         wpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258436; x=1704863236;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbllDlnO3rG864Ljl3o3amAjh6guujvESwDRIjsIsd0=;
        b=NmWiLaHH3HoxObmaWeYWzOMWCItUDl9Wdn0kYS+sWi0zKsLF0xXwkUBahjyzk4DFR0
         rsd38rtjGpV2NX30kzeVT5gLus0QzL4F2w3PMyW12IY5RtjI+QmPuQ+dSQveh+TL1M3t
         AOcXEksJx8nuj/I0C6HypG+SSWMPlA5We/38yb4rHjOLWGyvm/GrF72NrKGT7ObFlPKf
         KT2BaCFbq0rzC6LtTxsOYJtc3GLMGifY6rmE4SnXStudKJbGefU0HmrH/3J4XS+fmOkY
         qnxiNwEcHMbHTDAuCPfGWNOo/UkiK42Jga9J84KBQ5Y3rRDCdgXK6XOu48qkzK0ClaQb
         Jr6w==
X-Gm-Message-State: AOJu0YzMOHLU57CUtuj4UZuWRWwyOaegq0PlWkHp0fBUiUPUHKYNf2Ol
	A0VbR58A9ZCioymOhifVBWUTwd4VEkI3q7iISh4=
X-Google-Smtp-Source: AGHT+IHxLp0iKpmEsQX17RX9CCwHVCUgXcrO62HLLHys9X7M6IFXfS5Kr2lunC2WUjV+NW6k70K1eBUIpElf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a05:690c:a9d:b0:5e8:f747:1cb3 with SMTP id
 ci29-20020a05690c0a9d00b005e8f7471cb3mr6769721ywb.1.1704258436667; Tue, 02
 Jan 2024 21:07:16 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:23 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 13/25] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.43.0.472.g3155946c3a-goog

