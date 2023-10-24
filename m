Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759912C858
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAYKbecQ"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84E10D1
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9caf486775so5765856276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186257; x=1698791057; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soqORP6tbK7HSPMdiExWiSFnufIqC4NXz+eAMSjew4k=;
        b=VAYKbecQNlVTg/B52zPDUaaiURDyjiKy7S+6RIJOxJpJ0eHhouwdTSRRBJ27EJULRu
         dxqgDSMBuegaaEh2V9wyGFRlyBqDnas82lSaTbvD97QErmN4VbCrwd0kjJRS7TO3x9FG
         tVNhfEvHEB2Z/CQ6oMCpKUWDBVFqU090UkqLf+jv2vfjskvOUE8FlHbCKTT2mZsnQ+CN
         kegQ5T4b6AhmuMBRT431gSOe7l5kezCOzc/yHc/ZJmidQMGqyLqsQAIlmn4DT6WXgMhg
         osWbRexaBrpnCVGgOf22q7eEulXwowZ8Lmy7vwtcI9C+cz0kdMMFoWER/jYCV8iUL5cC
         4KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186257; x=1698791057;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soqORP6tbK7HSPMdiExWiSFnufIqC4NXz+eAMSjew4k=;
        b=mJMNrm8LRdrdrppwj/+664yqZzKKxwvKddglt/atwbqm96YMvQrdrQAt07TJq5CM9n
         9HcEjGzXkzAVv+sbdNcGmmo6Q0oYzZo+QRO2ozOFgMlhnmamX6HoEI1f+DE5NN/Pexaj
         0K6xp/SPb3Hzgiu02RgNRwCQnBvoVGNDu9KhI8prJl0qTuc8t1JmA/XJBQ81LeT/fanF
         0ukAqjdUsbr7RF/NxLyKnwhn4UXyijBCqyPTAGxtu2IB852igDrNofCZUw1lClYWzKuj
         dgXPjHjdzHq8WRC2yYD+fOHq5y9I6H++GlZtM+smdVOG6Z80hV9C2G5fIoQ+7UHf/Gqv
         Yrtw==
X-Gm-Message-State: AOJu0YxcFTqyYYTSEAGu96UZHn4JYORq/wxw4M6srY5ZeXgVzKCvUaON
	osm0bOG9GVo/RDb5fqKu+ptBBXXzcpy/
X-Google-Smtp-Source: AGHT+IEeWCPNZG1JcJgc7vYx5Xq8cYep1D+KXTRDSFxJng+4UHbNRG8N9ZPuO2UyyIN/UZxk0Kv+FVlm1ZMA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:324b:0:b0:d9b:f88c:ca2b with SMTP id
 y72-20020a25324b000000b00d9bf88cca2bmr258271yby.11.1698186257401; Tue, 24 Oct
 2023 15:24:17 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:05 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 02/50] perf machine: Avoid out of bounds LBR memory read
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

Running perf top with address sanitizer and "--call-graph=lbr" fails
due to reading sample 0 when no samples exist. Add a guard to prevent
this.

Fixes: e2b23483eb1d ("perf machine: Factor out lbr_callchain_add_lbr_ip()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index addfae2f63ef..e0e2c4a943e4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2622,16 +2622,18 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		save_lbr_cursor_node(thread, cursor, i);
 	}
 
-	/* Add LBR ip from first entries.to */
-	ip = entries[0].to;
-	flags = &entries[0].flags;
-	*branch_from = entries[0].from;
-	err = add_callchain_ip(thread, cursor, parent,
-			       root_al, &cpumode, ip,
-			       true, flags, NULL,
-			       *branch_from);
-	if (err)
-		return err;
+	if (lbr_nr > 0) {
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		flags = &entries[0].flags;
+		*branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				root_al, &cpumode, ip,
+				true, flags, NULL,
+				*branch_from);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
-- 
2.42.0.758.gaed0368e0e-goog

