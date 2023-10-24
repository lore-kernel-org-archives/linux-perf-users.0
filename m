Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DB41ABA
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0mftjNSi"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9123F19B3
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:26:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9b9aeb4962so5969873276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186366; x=1698791166; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sjI1f5vh005/1ecdkhswjpcyMDjRf+co04ydutakFc=;
        b=0mftjNSiZkd5dREGeEaZNyv6LBjxHSv2swaWzvpTTkWy8FVG631QJ0ZMXkEScP3I0z
         Hq80lqN/UCzoBj08yxMC6nVtzA3b/YocmW/ca2aOEqD1cO9WCQZlKPGvnqwKv12Z2SSm
         1A+iW82WTU0dmvlPo4HAKyqSDYE8iTvCrSGHI6rtU1mRA4QetKxSz+PZw1eQoXI+CCOC
         G/Pj7PeB1ElHk/vxY97a7qTmjIQ/E2YmVf7+SmfM2BKzStqHqdN5R6kL4Eso7n0h6V6z
         3qb47vdlEgr39hgqYnXMQYttbmo40x036UZlvoISCl1f7U6rA47OnzDd3sL3jY0EGvMN
         ZQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186366; x=1698791166;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sjI1f5vh005/1ecdkhswjpcyMDjRf+co04ydutakFc=;
        b=tKZYKRiigU4DXyoF9jV9f5kwJ+RUOCW/FW2q2z/tlmhh84dHhhv/kfzMFrfxqs7nuH
         pKdXDdl+Q00+p+pzoADTOaVtPD448VkyqFQLKndMPowDXIN8XpyvjtvLGh1+WwjCGI/5
         qjAdjVhZRjLznA22Xy1wmOYldVP2B17R0ykKesTRrxCvEVsszbmP63hSUtZZRjZhvolM
         j6ScR3xvL9QvXZKmbV6QzPCh+Ife/AeFca4vqXxQnW5b6jD2cmAQj2yCkOhj9pUw2Qur
         p7E/hN1+29qc047J3omU7XeQZEXOFs+YRRo3NqZvj39wFD5B12jKRQb0Arn6YGSYO5nd
         MdPA==
X-Gm-Message-State: AOJu0YzVkSnuy45h7O2F3AJoYntyX456Mu85/uY89mjeP5m5+ZE5MnWz
	SNs5P8JRPTqe6hcp6uCDtt+oPDkc4a0Z
X-Google-Smtp-Source: AGHT+IGyVGLRMSCRZiZ7/84qie+da+k0hc1yspyUwRnl9NUhjP0cDot58jEhGfqQ0aDKIoxV/jlx5re8T6mL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:181e:b0:da0:622b:553b with SMTP
 id cf30-20020a056902181e00b00da0622b553bmr29800ybb.12.1698186365779; Tue, 24
 Oct 2023 15:26:05 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:53 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-51-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 50/50] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
2.42.0.758.gaed0368e0e-goog

