Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaZt8UKp"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEF63251
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4038d7cfdso4283356276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123049; x=1701727849; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HtKu9iAXaV88hgxFxNvjjL2GaCw51rWrgIl23jSopU=;
        b=kaZt8UKpJh8eSa03SjPg8YmVvsB61n0XkjbapUWvBpD5C5NehTXQUD2lfWbM1WfJQm
         3J6Enc9mEDc2dOod8XtnnHI6OzLp0CUCEUUVUDfpkNrS39IGn8xDnZGH145aC29ADKks
         AOErk65kPODlI8xsclcrUfwooRWcBgYRxSSgnAtYDlRihaoGSIszG8l1r8uM4fOiNtP9
         +VdjOuukGeEo6gYEwxTQOUnb/H3gsyKrVoT0Z6dzXJF1O//iFIhtm6KNptw+AlBI9eQB
         i14RYVMsTNMQ+r4P/xckphgA23UvVfV1iazJ38UrBEFVGCG1BYoQk0qvPLyl/Ey7LtWj
         h59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123049; x=1701727849;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HtKu9iAXaV88hgxFxNvjjL2GaCw51rWrgIl23jSopU=;
        b=Bzu4NnS3zXYSYiRwC+7SrcslNOdi3jA2xZivkxHcWvJV4XUZznlRXjhl7OPrbyXE+F
         V7SD0vAQKgk4bT+1PrJcbAtIsLE7PqNmNTPY6OQ0llDb7mnrTiD6za6a39gbvVj1SpN8
         tKVGl8by0rKQcuayNt9FpfxYZoE5rjjRyD7UT6AawgOMRVzQmJSwuihXC0U2xfyqNXjE
         gR2ZG3gmkoUQQaou1vLxmutOLSQLJYNlN/YKFqujuqQw3tCmwVrq8HDb4Uil08js1qMC
         S+zDQr0EgW6xfa5Wmfj1HXtRM/8CXmgag57r+mtsgCX04ZGuTcifkmm40AzvUGZ7RGaB
         AFUA==
X-Gm-Message-State: AOJu0YwvNVzNcwtZ5qww8es42IHdnqrzPAI0JNVT+zGO+5JKEUQG10YN
	hQ5WOXL0ARIrVVDeyMtrTpPHpWFrnQBQ
X-Google-Smtp-Source: AGHT+IHKwGIzqmD+4VwGagbyeQGdljxxm9mwjsTQKZC4lVrD2Dj8rBymf92im5fvsMjXaEfXJyCoq+wlFK29
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:24d8:0:b0:db5:2a4:c55b with SMTP id
 k207-20020a2524d8000000b00db502a4c55bmr719ybk.2.1701123048730; Mon, 27 Nov
 2023 14:10:48 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:49 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-38-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 37/50] perf threads: Reduce table size from 256 to 8
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
2.43.0.rc1.413.gea7ed67945-goog

