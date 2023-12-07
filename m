Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zgutos3x"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DEE10F5
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:17:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db547d41413so448172276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911866; x=1702516666; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AO9qbVdz92aeOF04iN3sGAA+G8iEwxSn4ALkZn1Ljr4=;
        b=Zgutos3xtH5+U2/BS+FcOeiKpwHPGi2oOXAFzwDqk4105+AxXsU/AymCQlaNemjyK1
         IvwbHyf/okcc0jTHW5WFtHu0jJeUQPRZxfIrvzSm8ZlJxwMfM+Mja/NmO0af+i9Yb/5U
         sz32+03aMZSqt+YeP416/mt3fS3uWtZDKkCZXwrWJkA59KCtIbwwf6PaK6CiSjx4fiV4
         hEanIFEPEp65UStVNGdcLT4MVfCrJutdRljADCh6nGuG7hUYZbPQoHWOBY6ZI5sQeNX6
         cBEuhJYpkAufuLXqNvR3uoZueLEI+oRFCfMzz1870vQr8P7XX6LaFJUx6ajZr1K7QAMI
         k5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911866; x=1702516666;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AO9qbVdz92aeOF04iN3sGAA+G8iEwxSn4ALkZn1Ljr4=;
        b=mb2LVh1iiJOIwgLL3P4q/aovyvFBmuUT7iyYZ2OkrLGm5ErxxsARmCPUGiOPM2ht18
         aZKxhBEgAMWnpU5+pnPNa3BAdpn5dgZyTJwLUS7GskculKUb/5VwfPKSG0TRjwhAKO/E
         +Jr+sy1ziVJyEG0XEL7lj65zhmtXMTZDrA8fxTAWs+ZRsLqkjxfD062ZLXUXvoFgHU0a
         iTvq1yYoOCQU+ocz39Va+B+sUlv3oNJZ67K0aatOzEZddQ9LuViEP1IQouG1Q+/XQooQ
         ph3sfLktZbxIOF0pAW74eB/aIQhpeCI/x9RGpJII49P07yE+Y2RwrokOwIsZ0fKLkfML
         rIyA==
X-Gm-Message-State: AOJu0Yzm3I7+XtTgdzA25XqRs80cPtJEfWnvxyIEntDPPS7Kl7TnoHGz
	RnZtUobzPJ9EDpd5fLO2zjYgEFjCncrp
X-Google-Smtp-Source: AGHT+IFZShnoES+NZiyREpT/gFpeijKkhzAYIhu+beyX8tCaB7kyYLyiBn92ban+fdsdihdux7Lj+fuWL7yd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:3144:0:b0:db5:4a00:a153 with SMTP id
 x65-20020a253144000000b00db54a00a153mr42999ybx.4.1701911866495; Wed, 06 Dec
 2023 17:17:46 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:42 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 08/47] perf symbol: Use function to add missing maps lock
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

Switch do_validate_kcore_modules from loop macro maps__for_each_entry to
maps__for_each_map function that takes a callback. The function holds
the maps lock, which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1cc42b8d8afb..72f03b875478 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1114,33 +1114,35 @@ int compare_proc_modules(const char *from, const char *to)
 	return ret;
 }
 
+static int do_validate_kcore_modules_cb(struct map *old_map, void *data)
+{
+	struct rb_root *modules = data;
+	struct module_info *mi;
+	struct dso *dso;
+
+	if (!__map__is_kmodule(old_map))
+		return 0;
+
+	dso = map__dso(old_map);
+	/* Module must be in memory at the same address */
+	mi = find_module(dso->short_name, modules);
+	if (!mi || mi->start != map__start(old_map))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 {
 	struct rb_root modules = RB_ROOT;
-	struct map_rb_node *old_node;
 	int err;
 
 	err = read_proc_modules(filename, &modules);
 	if (err)
 		return err;
 
-	maps__for_each_entry(kmaps, old_node) {
-		struct map *old_map = old_node->map;
-		struct module_info *mi;
-		struct dso *dso;
+	err = maps__for_each_map(kmaps, do_validate_kcore_modules_cb, &modules);
 
-		if (!__map__is_kmodule(old_map)) {
-			continue;
-		}
-		dso = map__dso(old_map);
-		/* Module must be in memory at the same address */
-		mi = find_module(dso->short_name, &modules);
-		if (!mi || mi->start != map__start(old_map)) {
-			err = -EINVAL;
-			goto out;
-		}
-	}
-out:
 	delete_modules(&modules);
 	return err;
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

