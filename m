Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269493D386
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ydbfqHeK"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3863E10FE
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da05c625cb9so767575276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186266; x=1698791066; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVGR9Xyq2raGKRiGJds6iUcO5Lwf67o/Z2QHhpJQbfc=;
        b=ydbfqHeKgSmvFccd0/lADv3jDFkKDDTtxmixOmTXahACyrE+ZbWlkxxgbjNr/CQEeM
         d+cfSwlTgZSyT6SM8NTk2sjvATpeYifQt66+2zi2i+FpB2gH0A5VVjJrkoAPKe4A8s0G
         09dIdKRnwy2R1ipHQJPVWTt8+jS7TRPuFFkH6t0heiUigPwY35F0Bvmsp55cYhUVKROf
         CiXKIeWui1hEXCBec5lnKU4Kqke7cIWHJg2bd4xtHQc5wmK4RZ9HBH7t7t/ZvTDu0PiF
         JWwc5+dfjSDD2voG0Agh4C4fQVN4AehnvGsbJnZYty009NEwb+6UYRvsZbdoGEQYGUbx
         ho5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186266; x=1698791066;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVGR9Xyq2raGKRiGJds6iUcO5Lwf67o/Z2QHhpJQbfc=;
        b=L6EZW10NqXARekRpay8bttSxYxlLxB1NHBKIJ/ghiNd/19y0DHIwdfLd7nIjXVKYbt
         k/OPMMIGRhnWfHF68xAYg/Gipti7ZC3TClXq3PbhDjJk3YJmHilWlMOKlXbFA7IgT8LV
         CQ1Z3ZAhOvse37EvOCVJuSdzDnCMtldXxtNonlQj5VLMHahxb13PezBkIuTj0NtuR80z
         aqVextrc30Yoihco5wZ+CAWSD4y4j1BPi5NBdNNJ2qgxVZc+QMm4dAFWie5duMOxb3ae
         5vxaPZjmDPkY0q/7FPmmeOWthm+MYpK/1EqAzz0i2txnJuotCdYud34v+qkvLUqjVJ1W
         FhGw==
X-Gm-Message-State: AOJu0YziZc0n0FQv4K5IgQzNLxJfC4qDByLygA8JqYJQsdpi9DjpLqC5
	V5oyn9SPPEyLdOV33Tp/vWZwTmAGay96
X-Google-Smtp-Source: AGHT+IE0LnLyRZWa3HLVttfv23W2KKPiQIO0rXTRdCKvqzFZLAQ2zpqNdQtleswviPvhJJuZK+5ZXsYOiV7e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:8541:0:b0:d89:b072:d06f with SMTP id
 f1-20020a258541000000b00d89b072d06fmr256399ybn.7.1698186266012; Tue, 24 Oct
 2023 15:24:26 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:09 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 06/50] perf threads: Remove unused dead thread list
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

Commit 40826c45eb0b ("perf thread: Remove notion of dead threads")
removed dead threads but the list head wasn't removed. Remove it here.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 1 -
 tools/perf/util/machine.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 098600d983c5..31fdbb0f27af 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -67,7 +67,6 @@ static void machine__threads_init(struct machine *machine)
 		threads->entries = RB_ROOT_CACHED;
 		init_rwsem(&threads->lock);
 		threads->nr = 0;
-		INIT_LIST_HEAD(&threads->dead);
 		threads->last_match = NULL;
 	}
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d034ecaf89c1..1279acda6a8a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -35,7 +35,6 @@ struct threads {
 	struct rb_root_cached  entries;
 	struct rw_semaphore    lock;
 	unsigned int	       nr;
-	struct list_head       dead;
 	struct thread	       *last_match;
 };
 
-- 
2.42.0.758.gaed0368e0e-goog

