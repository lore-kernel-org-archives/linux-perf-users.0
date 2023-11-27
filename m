Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Km0rF0ZH"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A41AD
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daf6c1591d5so4291392276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122963; x=1701727763; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbPv4PyEdmBWH7WUrzt8/XaXbmHzexj4Rz5EFZB1OQM=;
        b=Km0rF0ZHW0TaTKx+npA8OJvPAtKyQKPO0A8M2mJ/DBBM41qhFvDyHLcEZxTP3w4vaS
         NwknOG+NnF1RF1aat0v7kfg2YfEpZn+q9ULMB4TONRjsECUCb8RdWk1SvrJjGGC2h3t7
         jNmmImB82KKjBgexV9sN64hmZU85VFmA8SO5GNZnXKxbfsPcmnLVdZb79Y4U7X07Cyii
         R7R8wv9Pw/BsiSbhDOc/CmjIe/9diA7ZDgl/UMgusk9oDsMg4f0bEDNDf0wbhQfVLMY0
         3uB5/YY3q1N5VdPdRG8gkqZV9iYZISz2aC1K7m9MJ0dNfvGx3N/4CqwWyc3ocgAzmdG/
         pACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122963; x=1701727763;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbPv4PyEdmBWH7WUrzt8/XaXbmHzexj4Rz5EFZB1OQM=;
        b=LTexO737UsNqeZhL/KyQN7H9A31GYklLsJmqONxdjqvTNQqJciuSbioHYRtSmIp07D
         nJ5op9fnoNxTWXqZgAr2akcUJJNr1C1ncqqX4AVP/55o+PGZb5ZB2u3sKhQZvdL5P63p
         9qKdny+WjcIwrNK0uUSlnuN02dxsdU7Sq1KPSl41H/coRtkyBlAjBU9ennbMbkRk8QRX
         KyFEbK3oidJuhiR36mTMpBE0Hmn/fI5KYbAfmVOFFo3me/Pv+WEqUVId4/vhY79DLP/v
         +/IJmH7citItL0tYsJYjS+LqAjqUQM3cvT49nEpbPu/8zfUbNVa07LWGxdFdq6nGSp5i
         tukw==
X-Gm-Message-State: AOJu0Yw9e42vn+0CGTmPuIyjGMBDOSPiKjidefdmHbMOByn3UIeyzxXH
	lOTP2ENHAfeMxIS5//zzHlEwXvvXc3ee
X-Google-Smtp-Source: AGHT+IExUtMtiR+ptGG23+Vabnoaqo7AIZnyIS3yKYDbfx4Y1r3PAu2qXUtV6Z+us//6QncipclrfVxBHfi9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:d081:0:b0:d9a:c946:c18c with SMTP id
 h123-20020a25d081000000b00d9ac946c18cmr452645ybg.6.1701122962825; Mon, 27 Nov
 2023 14:09:22 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:13 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 01/50] perf comm: Use regular mutex
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

The rwsem is only after used for writing so switch to a mutex that has
better error checking.

Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index afb8d4fd2644..4ae7bc2aa9a6 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -17,7 +17,7 @@ struct comm_str {
 
 /* Should perhaps be moved to struct machine */
 static struct rb_root comm_str_root;
-static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
+static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
 
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
@@ -30,9 +30,9 @@ static struct comm_str *comm_str__get(struct comm_str *cs)
 static void comm_str__put(struct comm_str *cs)
 {
 	if (cs && refcount_dec_and_test(&cs->refcnt)) {
-		down_write(&comm_str_lock);
+		mutex_lock(&comm_str_lock);
 		rb_erase(&cs->rb_node, &comm_str_root);
-		up_write(&comm_str_lock);
+		mutex_unlock(&comm_str_lock);
 		zfree(&cs->str);
 		free(cs);
 	}
@@ -98,9 +98,9 @@ static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
 {
 	struct comm_str *cs;
 
-	down_write(&comm_str_lock);
+	mutex_lock(&comm_str_lock);
 	cs = __comm_str__findnew(str, root);
-	up_write(&comm_str_lock);
+	mutex_unlock(&comm_str_lock);
 
 	return cs;
 }
-- 
2.43.0.rc1.413.gea7ed67945-goog

