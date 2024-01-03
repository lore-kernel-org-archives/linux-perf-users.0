Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A9182A4
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jan 2024 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gtgb+4Q9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eb8b6e777cso108157787b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jan 2024 21:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258416; x=1704863216; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDc8U8CcTfXk6/xIXhbcXcxIlZrCEy1yfrH0rSN6Nbc=;
        b=Gtgb+4Q9xwIphF8/8mfvogKyMwRh0Di3byJfqsGDfslLmpiC9vheU0Cg0LyZn+FWGq
         k3ztS05mrQiyz4fVwnVitZ6N9CQ7MVV8VGwuYblBWa5oCLHQ3D94Ki2jMI0MTsaY3FSI
         LKTx4U4oFZAuSVHT7pPH0JQRfqU5rMWZ4Ec9CxsH1FikfV+4D2t//YH4DoLTOgIsHQZ1
         229yQfUQ3KdwUkIHTdL2m8mI2xV5UIEkUAYutz7NmmXknsDtgJnslG0yd9PbKB/kApPm
         V5PMWW+FtEdBVds/azg7XYqGRKVgyvYdFc1Kw2xxJpZOsWhhOaxxJncv7iI52zXIda51
         Sweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258416; x=1704863216;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDc8U8CcTfXk6/xIXhbcXcxIlZrCEy1yfrH0rSN6Nbc=;
        b=B3hAU+E5mdMA291T7t6jnk4Or9ZUGsGOVhFbqTUYHPk5AaofXgp0QL2XcN4ufwGfbC
         oIPghLTUknnjg16Z4lSoABNdY4FKZ7Lx/K9/iBtbC+nyjKsMFy0Cu2a+8CM7O2Bf+wjp
         8G7FVi1/qCvqjt8rNosl894Cj5KC3Eu5JrYnTR61qR7slJaKlBZlS+zWwo8Lx7X7pidk
         RlniEzVTwE/0wrDKAPFQvOf/kcMFgqTktcytgVhOo4Z3t6PCjRiScQXfz9RLuKGF/EXf
         qUAhVg4oejalqaSQOeq8jsZCfH5/i7xrIQfr8w9YyYw49DUGcJUIPyYSsttiLwmsnsy3
         hR3Q==
X-Gm-Message-State: AOJu0Yyq6d5F8wy+MQtEt+wNQGLfQ2RTb4uyTY5oBvhgPRHjEtrkwshF
	Umbp2bxu1Xqs24HSdc00U39xV3FKak1xhckhtgw=
X-Google-Smtp-Source: AGHT+IEWQozhVRYwGCCAlT1qAhGP5s8IvwEvk0gRqu/SXQlWuFk1hq7ijyvYo99OzzTD24b/L7tp9ntzLYE+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a05:690c:b83:b0:5ca:5fcd:7063 with SMTP id
 ck3-20020a05690c0b8300b005ca5fcd7063mr8363427ywb.3.1704258416086; Tue, 02 Jan
 2024 21:06:56 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:14 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 04/25] perf maps: Get map before returning in maps__find_next_entry
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
index 7031f6fddcae..4911734411b5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1761,8 +1761,10 @@ int machine__create_kernel_maps(struct machine *machine)
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
index b85147cc8723..0438c417ee44 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -943,7 +943,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.472.g3155946c3a-goog

