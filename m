Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOOgu7Dp"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96092273C
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:33 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd3cf2e21dso70758587b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123032; x=1701727832; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZfEEyCJPKtNkyz47mAJgILH81a+f20AhnpCUE58jks=;
        b=lOOgu7DpFF5e/5fBy4hzKmtp9Lhidfv2FMQzXONNxPyKIusQBoniXCvavpIVz7skqD
         3Gf8PT7TnxR5n4k/nDb28s+mvOzX5OGasLTfB5/2i3kkqLl4/V8AgXP+AEL/Oo5qyzFf
         ymSOkFJPvgq1itMhvvS6bY9X2EampnnBN2GKLDPOU8N7O5z79CpL+2Zzv9HaEBxwBFFB
         75ah3pTCsut1T9Ar/YNdjEhDINNfgfOG3RFob93Nysy6lwWt84ENxyMzTiV8k3wJv0Ve
         uzOM6C5H5oEOFFaCMYxRs5AD5WfZPhEcImbpDoliuM2Z/4PsjUn4W7smXBE5EoCNfBHf
         HjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123032; x=1701727832;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZfEEyCJPKtNkyz47mAJgILH81a+f20AhnpCUE58jks=;
        b=LNywHzz/AD8+90/IoTgsn/7gbq7LriTjC+fRhee/BV8A8k1MJW3mkVc/PFmiMA2lnP
         cMTKrZQv3a+jEWrdfcOCLDKrKezCXCxUJyCPdO5ois3tD7B8p8AXr/aJxIQAe8CyIRL0
         0XfqXU+IOCQwYJT9IOaAVwFrvTJaMFR+LWqzZJ5pWJK7AR5xxRTYxqBvYVehr4+hB5Ql
         khZCE9wsj0NuXc7knmBrIJSB8428+euRU/WBdA/DcLJprvDNQgmdEvCRKelBQfolAUax
         1LB+SHDS4o3a5rlDLVTIek9nrnxKUArcpKM/tkdNo5v1Z8cCIefaVYq6t1e3sMehFf/s
         JNsQ==
X-Gm-Message-State: AOJu0YzrgStkYtnxEBijIY2CE8M76ZSsPxa2BLTb5ns/oMrbUcOCYHAV
	MuJY4O2NtqNTqw/M4k4p6odXOncSWeJ2
X-Google-Smtp-Source: AGHT+IG12047g3qu0QJHS31vadZmor6Ba21ahU2lhuvfPpDRFMFveDvv/1r5dwsWgpSCdgHN2aeCCDHbABgA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:270e:b0:5ca:fa88:f4b6 with SMTP
 id dy14-20020a05690c270e00b005cafa88f4b6mr443123ywb.3.1701123032722; Mon, 27
 Nov 2023 14:10:32 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:42 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-31-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 30/50] perf maps: Locking tidy up of nr_maps
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

After this change maps__nr_maps is only used by tests, existing users
are migrated to maps__empty. Compute maps__empty under the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c |  2 +-
 tools/perf/util/maps.c    | 10 ++++++++--
 tools/perf/util/maps.h    |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 42d73f00f9c1..f9c77119af22 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -441,7 +441,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 		return NULL;
 
 	/* Assume maps are set up if there are any */
-	if (maps__nr_maps(thread__maps(thread)))
+	if (!maps__empty(thread__maps(thread)))
 		return thread;
 
 	host_thread = machine__find_thread(host_machine, -1, pid);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 41e9e39b1b4c..725f5d73e93a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -528,7 +528,13 @@ void maps__remove(struct maps *maps, struct map *map)
 
 bool maps__empty(struct maps *maps)
 {
-	return maps__nr_maps(maps) == 0;
+	bool res;
+
+	down_read(maps__lock(maps));
+	res = maps__nr_maps(maps) == 0;
+	up_read(maps__lock(maps));
+
+	return res;
 }
 
 bool maps__equal(struct maps *a, struct maps *b)
@@ -851,7 +857,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 
 	parent_maps_by_address = maps__maps_by_address(parent);
 	n = maps__nr_maps(parent);
-	if (maps__empty(dest)) {
+	if (maps__nr_maps(dest) == 0) {
 		/* No existing mappings so just copy from parent to avoid reallocs in insert. */
 		unsigned int nr_maps_allocated = RC_CHK_ACCESS(parent)->nr_maps_allocated;
 		struct map **dest_maps_by_address =
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4bcba136ffe5..d9aa62ed968a 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -43,8 +43,8 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 struct machine *maps__machine(const struct maps *maps);
-unsigned int maps__nr_maps(const struct maps *maps);
-refcount_t *maps__refcnt(struct maps *maps);
+unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
+refcount_t *maps__refcnt(struct maps *maps); /* Test only. */
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
 void *maps__addr_space(const struct maps *maps);
-- 
2.43.0.rc1.413.gea7ed67945-goog

