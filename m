Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91BF42909
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvJXOZLy"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094810FE
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a824ef7a83so63948537b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186345; x=1698791145; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/kNgXH1Uh+lkDKn4udeU01EF+mxZdpavmj5nGxyL2A=;
        b=XvJXOZLyXI3pgqCPjcPyjhB/+6CS50YS/z6g04SRTQdp3wZ+Ct5TwGaohC3c+kvMFW
         VxPrRlzdeSmaqV44r0kHCXNm5yBNk3UfUCVXUMmtcJwc650v8sdh1I0WVDFB/OwZ3x2o
         3KbU1FRFVi+WAxU9u3xo4sTczU97ySsf7Y544dtcz/lbS6TLSCRoYhnlpBwHOeeZH5Cy
         sSOdnBbDOrhzdbRlwSBujoXqW/mk8bw7/x3yElFW+MPDWEHiAtvtx3Zis5Hih/3T1Z1L
         jTPQTU0iBufLjZTqaBXalfjhpwfGuG8Bi+Pl+jeCDD7kk19uxzHogOYK8hlwrgZL6BLU
         wvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186345; x=1698791145;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/kNgXH1Uh+lkDKn4udeU01EF+mxZdpavmj5nGxyL2A=;
        b=WgUtWavC/6Te33VYHcjbcpA3EOKJB9rQIDRWgCj3GruZfmQXsh5PyGtFD+jH8naofu
         lVVtGmzN8ItmPrR4DbBzUJRkgJIRS7UvObfg9z6SeugZeFHAdDLb1V7yXFRaQMcJOgGq
         az5cwX6Kt+n1wxXn9ZOqUxOQODjx2gxdrYsc+eRyJv86NAEaG8320EKfGonQAesGqqfJ
         /t2wq97H+OUG2BlraqQlb2tZJSoJjbWooARyDwYSwF2XSvo/s1DENTWGcDE+Z23aKf1w
         vpq02wB3/R9AKIqsQvYBx+stDStPFD7/6ZoOvcRCl/JXOZwVV3xd96ozS2PVhxdNP1vK
         BhFw==
X-Gm-Message-State: AOJu0Yz0iITqGVXciLw4SOC/YVRBHRRihOzautE4eeoIlNZuXaJoiVLz
	QNIt8WnVGruu3TAey9YVy7T0oVPflfa9
X-Google-Smtp-Source: AGHT+IEZn/79C0WxXeapm9MG7+V0rd8DVy1PiiAJtvyIYSGp0278m4lV2yy0OiU0jNwiItS3x7WOE65BqKFM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:aa45:0:b0:da0:3e46:8ba5 with SMTP id
 s63-20020a25aa45000000b00da03e468ba5mr57420ybi.8.1698186345124; Tue, 24 Oct
 2023 15:25:45 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:44 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-42-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 41/50] perf maps: Get map before returning in maps__find_next_entry
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

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 4 +++-
 tools/perf/util/maps.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d6b3f84cb935..42d73f00f9c1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1758,8 +1758,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
 							 machine__kernel_map(machine));
 
-		if (next)
+		if (next) {
 			machine__set_kernel_mmap(machine, start, map__start(next));
+			map__put(next);
+		}
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 8a8c1f216b86..b3937e734cbf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -942,7 +942,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.42.0.758.gaed0368e0e-goog

