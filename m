Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DB210F5
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRoCphS4"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C3D1FDC
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:59:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b1ff96d5b9so17688967b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947968; x=1699552768; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWO5cb/JGhq0YhhkeavtzpdshUSY9BdgMbF9Q9qBiTA=;
        b=uRoCphS4a9ghls3sAYAX7ZAuJANZx9SSqLeMB9FiVNgB/fbH176oYzGdft8sdIpm8o
         wXq+z+WBKiXVhnxX3RPhsytFffanBsYX6Ta06ScOLtprRjYvR014DfYQo3eKyHs2xiU4
         Tua9WqMIa4eDW9qpEKNZkEqAblO6J1vRfbJJOpCibqvWYaXcymcYIx2+gEpdvVsa7RyE
         6mfd6QnBwXUhvFeKM0b08PfFraQOpGE5qnzGiFx4PJFQ+J6c/KXKhq5jT+YEfIZtYc2+
         sV8TXUwGJozE55n6/j/kGWW74EwZJVpFYpI5fEH+obnqbZfbM9eHWDKoWlxtWTDnIclu
         nmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947968; x=1699552768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWO5cb/JGhq0YhhkeavtzpdshUSY9BdgMbF9Q9qBiTA=;
        b=o1fvjh3zq5D5UbRStAj43gpaP/622U2JiCiZaIQurCfHoQvx01YBznyY5YU6g7idtk
         zujK3M58RYDcFQwZ1uFs61bcARvuI9dHUDwcthSmfhyZEbZpJenHZRit5R04q1NaW17l
         iPkkhHk3VW+rsIjldrB5eC1lJtfwoVnPKAiGZogSldilFfNodzC/lUI0fvy9SnHtHOo1
         /lLvwr0B3MYshts90LBawJlQULoTL0/5yR7zRw4q+Xj8CPfxvVqJ29P8SSct0Gx/taHD
         79lI4+h7njP1RjI8OOjCIPMYZKKPALmACNhi4NVbZiRr7c44WHlgF9uH/av1yS0wNTrG
         rqdg==
X-Gm-Message-State: AOJu0YwGEpvMwRu57ErdDmGwTQ1gwDPwwEamkynZWjANrXzl4s6/Tn2E
	PUy1kbRfxvUbRT5iSOaWHlY8vrSG30e5
X-Google-Smtp-Source: AGHT+IHiCSNiwtVO+sCrdD2Mg2fwEV+vcc69wWBZdswoUAczP+5MhgJ9MgBKBwzIu9ysa21AlSt8cBmLq49h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:168c:b0:da0:3e46:8ba5 with SMTP
 id bx12-20020a056902168c00b00da03e468ba5mr359961ybb.8.1698947967753; Thu, 02
 Nov 2023 10:59:27 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:22 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-41-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 40/53] perf threads: Reduce table size from 256 to 8
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.42.0.869.gea05f2083d-goog

