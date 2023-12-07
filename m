Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6Jg92+T"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360C810D5
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:17:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d8da78a5fbso1677587b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911864; x=1702516664; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iP54Cr9KwIg5SXZNIJ2CNouxtqfS0z8vptSkYLl8pjs=;
        b=K6Jg92+TTBp3xLM12S1wvjpOrw3T47ou7Idt6HCsWY72f7AFYk1rgmI/UR1CpngO9h
         ToKjhyCiEUG/IVn8+d5vt+Ft6EWuzvf28XO0RHvhS7+17KvcWRN4Z7lHxNNO9M9b9o0l
         qiXEYCURU3k1AriVszIjZ5NUjycet2VJgcVKiiEocr/wBGma1BqqjGrs7i1DEkKffGy6
         KEpYR7KJ/BTvIA9FMLSZaAZEsiDiFGMDFIsf+71oVXispU1+oiCqluORaz+6xhSoTLoK
         W5ZBiC7zMzW00JtmXjNtXbeSkU4z+08EggXIA6w2WYNMBOhaS//6+irw/ONm13F9L8eJ
         c4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911864; x=1702516664;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iP54Cr9KwIg5SXZNIJ2CNouxtqfS0z8vptSkYLl8pjs=;
        b=Xq9uJAqapkKCPdNwhVn/+jnL449jaOOBpTpotDzIN9B2bSTef+knMDvT7dt8+dTi5/
         hrdT3eZWwCMIbFqvBDBYbFIf35jTMbXKEe+ntLbLburoiKAlfGIE2HHlTkUFJTj365Eq
         mS1cgsZ/P0xOMQ5aFgG04OB8E5bnQqGjUn+x8sTk/38EqHftEF4FjvBXP3iYd79KIFr5
         fdeIqqadbCnkZFPUMXQsQXeK+JTKWnAEBazlWhc/vuRu42t4Xezf+5wWSArMRa78dVOJ
         9K35o7IqQseB/eWkPlS+M+FNsOMsz1ZOcsygKN1cSh9JK85eoN5w4Oq2jbl+jnYsxqk6
         DLjQ==
X-Gm-Message-State: AOJu0YwaMDwn9lM3qc2R3+jGj3RRM6Zc5I0QydsEUzOYvE9jLSnNu5kg
	cXmB9+YOwFvDY6Y0R45ZEP7gnLAC53tZ
X-Google-Smtp-Source: AGHT+IEuTthv6In6QokLOv3x+M0cveb3NvaEajld685ubY7CPHtnY6sUKHoVMjTqxAoqeu0ioqvCrvZuktHP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:ad24:0:b0:5d9:20ac:5126 with SMTP id
 l36-20020a81ad24000000b005d920ac5126mr26328ywh.4.1701911864205; Wed, 06 Dec
 2023 17:17:44 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:41 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 07/47] perf probe-event: Use function to add missing maps lock
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

Switch kernel_get_module_map from loop macro maps__for_each_entry to
maps__for_each_map function that takes a callback. The function holds
the maps lock, which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/probe-event.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 1a5b7fa459b2..a1a796043691 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -149,10 +149,32 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 	return 0;
 }
 
+struct kernel_get_module_map_cb_args {
+	const char *module;
+	struct map *result;
+};
+
+static int kernel_get_module_map_cb(struct map *map, void *data)
+{
+	struct kernel_get_module_map_cb_args *args = data;
+	struct dso *dso = map__dso(map);
+	const char *short_name = dso->short_name; /* short_name is "[module]" */
+	u16 short_name_len =  dso->short_name_len;
+
+	if (strncmp(short_name + 1, args->module, short_name_len - 2) == 0 &&
+	    args->module[short_name_len - 2] == '\0') {
+		args->result = map__get(map);
+		return 1;
+	}
+	return 0;
+}
+
 static struct map *kernel_get_module_map(const char *module)
 {
-	struct maps *maps = machine__kernel_maps(host_machine);
-	struct map_rb_node *pos;
+	struct kernel_get_module_map_cb_args args = {
+		.module = module,
+		.result = NULL,
+	};
 
 	/* A file path -- this is an offline module */
 	if (module && strchr(module, '/'))
@@ -164,19 +186,9 @@ static struct map *kernel_get_module_map(const char *module)
 		return map__get(map);
 	}
 
-	maps__for_each_entry(maps, pos) {
-		/* short_name is "[module]" */
-		struct dso *dso = map__dso(pos->map);
-		const char *short_name = dso->short_name;
-		u16 short_name_len =  dso->short_name_len;
+	maps__for_each_map(machine__kernel_maps(host_machine), kernel_get_module_map_cb, &args);
 
-		if (strncmp(short_name + 1, module,
-			    short_name_len - 2) == 0 &&
-		    module[short_name_len - 2] == '\0') {
-			return map__get(pos->map);
-		}
-	}
-	return NULL;
+	return args.result;
 }
 
 struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
-- 
2.43.0.rc2.451.g8631bc7472-goog

