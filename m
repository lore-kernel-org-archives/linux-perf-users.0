Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfn0pr6k"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF80271F
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca2e530041so70926827b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123028; x=1701727828; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbcVF6J0KDbkpD4NFjsmD9Sp0o+LDZsZhXDUnXGxxY8=;
        b=qfn0pr6k8F1baAihRSRQbB96jNImBoDJ0lGgMPqiRsWQKUFUkD/ZLlrxleou5txL4x
         nwllzS6Yu7Rx5E2mDiDYHvv3UuxAei5JG3iCaXGLZDb4IGratMRif99wP3sKgu2cZjZN
         aOTHdaiuTEAVezBZI8gVi/S7KEHnNZT+CR/3yKqJa0CHZDFDYKYD6odlat8UfvSEGdN7
         FfM0jmdcjwDWedfbcjxUeHyfq07JR3rMqhSBbSVXBjP1s5MFuqyqUuaL4z5sbefgzdNk
         NL4yKtJfvcm560CsR4G9DXDPFrS5hVZel7FpCWiUc6W4JMnj2TwJ2I5DkUY5U/PkhGol
         BLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123028; x=1701727828;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbcVF6J0KDbkpD4NFjsmD9Sp0o+LDZsZhXDUnXGxxY8=;
        b=GO491eRKQCamY4NdDgzEygo9Pt67k6KceTvfK0AhKVu7q+zSqfWP5V+pGpUYyhjckW
         XxOmx1C485uHnUH+3ZwjAOHhZegQMOdFSbSBsT6eeyOLIg9Q4sSJXgCu63mYCsccXYWP
         4buSdw5XKFJaF1W+Q/0lhAfRznbEz3UwFRxO1MKeFb5TWpDpZEabjy7NJCzAjeyViTHc
         89HUG8/oDP4FcYJyJY+Xo+pWe3XwIxs/j5mrNe1UJyJmS8GGVVHnjvNZeoio40cq5ecn
         lFIzko9erqkazs/KLVCtN7n81AHdPdEdXYf/s8+zjvHVgQ0w/uozu59wbACx4Cz6pO5w
         Cz2g==
X-Gm-Message-State: AOJu0YwmXnsF/U8P2oUpNV+CEt/f0TySKUF+4Y0k6YYZ5Hk3CHCAXsFE
	FNDjnnEPb6nLvugBuht7t4umUwgi7u4n
X-Google-Smtp-Source: AGHT+IGTGYqhEQe3GwIWy0LYkYLR6Szw+7ZpfEuawJN+o+/eJV1rmU9Hyau6TX3amswfEQM9gzA5t4t7zQSc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e10:b0:5ca:400:f1c with SMTP id
 et16-20020a05690c2e1000b005ca04000f1cmr376976ywb.8.1701123028227; Mon, 27 Nov
 2023 14:10:28 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:40 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-29-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 28/50] perf maps: Get map before returning in maps__find_next_entry
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
2.43.0.rc1.413.gea7ed67945-goog

