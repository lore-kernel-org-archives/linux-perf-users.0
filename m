Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA73D99A
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzf29tqS"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4195010C6
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cad450d5fso5712941276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186259; x=1698791059; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMICwswuJ/vFGwUP8a8fOw6frHIgUKsDaScdLo+z8js=;
        b=yzf29tqSgdydmD27uXNLY91T1l+1xEhTu+Qf8zjxwFlVdrHiJASm//O1glCrXisOlQ
         4/Fft7aAdPvmDbUF2T1Z8H7eOVrKsKJuBlkATpb8TKk5f6WpRn7T7wQLo8TIUx7c1hKI
         lD5ItFDFLWi1XtcDaIIlyzFSwXGHmWo+aB8v8W8hS67EBvh/pf+kLWe7ENxIbGcrKW67
         O+VAkhdigKl6XKUvH2gAw1HyUfdA+HWgHkqIfFqtYo8M+lblSlMD8SMKsjSbgidOvU1Y
         o0LJyyOdNnCPNiDCH1U2ZV+dgTqmTF2Y8Or5rJtJpP8boqX7MYnOC+Qfdj1n9tmY607J
         vVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186259; x=1698791059;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMICwswuJ/vFGwUP8a8fOw6frHIgUKsDaScdLo+z8js=;
        b=fy05DM5jyLyMaOHnFtqEd8nQbF/p/sXOaN2TjadLccErQH/vqa6p+MmhdB86EdcNwo
         Sfcdl4oECyESEP265DKNlFYC6W1fWNKvSS7W2YhD+88Ex46ocrBvH0J6qHs99R5aOlYj
         2RxabVEaZwZAYFhLhEtvhwlf7w0WVV5iidMoyJRuCyJ1StB8s/e5fvmUuZFazlubJi0n
         Ru0ZFCL3SOMd866qXJnqDP9oIVPq/GWJPjUl0fbzi7GKjC2DBE/4P1kP+KNrjEVbz1L9
         xLHiyKORsc7CFRkYwKSQU98uTxLiAz/pF4XwfVXIxAdVF7lR1LQUHQuHBiGm6p6TsmYs
         9GEg==
X-Gm-Message-State: AOJu0Yz3JZRcOpykX/TqLRAYKda4R+ooIKz9ib9ymaeYzfpdMqAvpbBa
	9T9aQuhn6cFWZt8SPq0+wa5LPDTpLE0V
X-Google-Smtp-Source: AGHT+IGH1SZn1zn8K8NyiItgFc808ePGZb6XN4ZOKPcuHdsBubSFyT8X7390Havy+imS2kby0Hx4flUrLWTD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:168c:b0:d9a:e6ae:ddb7 with SMTP
 id bx12-20020a056902168c00b00d9ae6aeddb7mr243432ybb.7.1698186259418; Tue, 24
 Oct 2023 15:24:19 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:06 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 03/50] libperf rc_check: Make implicit enabling work for GCC
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

Make the implicit REFCOUNT_CHECKING robust to when building with GCC.

Fixes: 9be6ab181b7b ("libperf rc_check: Enable implicitly with sanitizers")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
index d5d771ccdc7b..e88a6d8a0b0f 100644
--- a/tools/lib/perf/include/internal/rc_check.h
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -9,8 +9,12 @@
  * Enable reference count checking implicitly with leak checking, which is
  * integrated into address sanitizer.
  */
-#if defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
+#if defined(__SANITIZE_ADDRESS__) || defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
 #define REFCNT_CHECKING 1
+#elif defined(__has_feature)
+#if __has_feature(address_sanitizer) || __has_feature(leak_sanitizer)
+#define REFCNT_CHECKING 1
+#endif
 #endif
 
 /*
-- 
2.42.0.758.gaed0368e0e-goog

