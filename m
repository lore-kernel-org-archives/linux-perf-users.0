Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPCl6vSI"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD21FD4
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:56 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cef61289fdso38425097b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122996; x=1701727796; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzfDI2A+Dhir6Mech0OT0IIjPNEDsBuzrIL0dTnaONc=;
        b=WPCl6vSIkYCmhmu5akCPCP2wiA+siWnPsU1ovqYyvnlCilvAj/f6d/b7vgwr+E/diC
         Ba6bBizXb1y82anhXo8OS5HdKsXpKCjA72oMgZuGAhFyaGlM6TMycIJBW9NdDAqdzyO9
         te6IJFlwKLbAZxtZbDSSMlhAZfqszic+zOL7Ercp+Q3xfVjP1Mg/DeWRNDcNYsY8m4PE
         5agcqzjazPelhn8a3OdtyzNGmjQHFNE1NUbmPvqx0AVDmc5rnl07tzOO47U5JmptxV37
         HousULPdBYyjJfZUeAIy95e8Afl3enRxsd2XgUbJzEi8G5D9WLdQA+K+9FdqpMjMgOiB
         jL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122996; x=1701727796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzfDI2A+Dhir6Mech0OT0IIjPNEDsBuzrIL0dTnaONc=;
        b=ct2+U1rpa8UxptLi9zbX9A6h0/dYxQbsRqlIAjWp+niqEc/DBQnNBoAmjN4gLb6khx
         TFT4gd7JhyLDvlu7VJDUnX+3BL78a2ynKG51xJJ8XtK4WrjF9x9HVKIzp7a/AY5LuCS9
         iZmpu8CTo4A7vmffoolHPBWL73yemOY5U1XtAQPM7WY3JuioXm4IDyYPhn09u8Ww0vZy
         N2eua7kzwI6brrxu1r+2xxjaVF3//Y2MS7YBhOnXQBQOKDuFMQ9IqBgvb1FihbwVAjsZ
         /xfKQmjKcvvlhkzUrpmNdgG96kEbsDuAwL8oNmGnekQqi8zO4l0oDkfmNxPbSwPgNnQR
         2qhA==
X-Gm-Message-State: AOJu0YzAmbLn8TePf+dg1M+erBsfd4kO5DCxg+oNSb37HyBTGNIY6zSs
	6YJH9FQ88+rPwG9Ee9adT5rTzeiheQLE
X-Google-Smtp-Source: AGHT+IGaIKu2ArZXpqNdtgLevplTsAmQxqFNH6ymMaSKl7+FsV5pF6ixsfu9G03ipjuFp54UpIs7B5jz9E9Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e87:b0:5cc:3d0c:2b60 with SMTP
 id eu7-20020a05690c2e8700b005cc3d0c2b60mr369861ywb.4.1701122996145; Mon, 27
 Nov 2023 14:09:56 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:26 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 14/50] perf thread: Add missing RC_CHK_EQUAL
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

Comparing pointers without RC_CHK_ACCESS means the indirect object
will be compared rather than the underlying maps when REFCNT_CHECKING
is enabled. Fix by adding missing RC_CHK_EQUAL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index fe5e6991ae4b..b9c2039c4230 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -385,7 +385,7 @@ static int thread__clone_maps(struct thread *thread, struct thread *parent, bool
 	if (thread__pid(thread) == thread__pid(parent))
 		return thread__prepare_access(thread);
 
-	if (thread__maps(thread) == thread__maps(parent)) {
+	if (RC_CHK_EQUAL(thread__maps(thread), thread__maps(parent))) {
 		pr_debug("broken map groups on thread %d/%d parent %d/%d\n",
 			 thread__pid(thread), thread__tid(thread),
 			 thread__pid(parent), thread__tid(parent));
-- 
2.43.0.rc1.413.gea7ed67945-goog

