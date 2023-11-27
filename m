Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErWAzoVP"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F386AD62
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd48fcc2f5so64247597b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123019; x=1701727819; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ac/6qiU0CE391qQluGr8+N93c3qEfm8YU+gNySdqzik=;
        b=ErWAzoVPnxhfE/+Z0Z8PJqkWEZp4g33EG283ml20WLX1eLobk99N90+qC4bcNfDOUd
         oQFCk1EUMQdMP0UTxmdrA1tk9O8AgpjA+HT6NTC1fjZLxA85zBkGRKBHdp3QQ6vqQdF+
         LrzWutE9nG+88FZ2ReQLSrVpPy2DFXRfE7658E9fe8pUvIr8eThJZeofHy3bQptS/ArC
         SyEKWIZQ6Gc/xMWFn9fxoakiQKJCUTo+vhvAjfaeLalwGQRdhxObBWb7qOqcl36PWy95
         FIbJJMzXZIji71S2IwxUnUnwc1mkL12ZDaTYyTXriaNlo9Vf5Fq7c0lopW39j/PUrkBm
         veyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123019; x=1701727819;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ac/6qiU0CE391qQluGr8+N93c3qEfm8YU+gNySdqzik=;
        b=Q93IMXUX0i8CsCGsK2luakrvF5kduVlzObE34Fwgqyq4Q4TivvojW12pF0PSdn4TfF
         0X+lDDCsVwwNGHk5VQ3E1ltQVZd5N3etp6vYJCqp4klgtfi0pT/A6T89jDFIdbJn5IYX
         t3S88tMyn5WGOmXloMPG37nX8BzmxeLhSg2km7Ah7X3ZHWtUu7jROk4pf3Z73uzLKrHx
         XeAva1GCXrYKXZRuPu9FPZRrQq/hteZrYrjj+LUGigCgGxRotamCxwL1Zd+0xxz6OHQC
         d2Nh8xIUc/9QOX68nEPC6ko1xJxhBgXzHsPLAYE3TiNOrx33CtPKd0Jmzl44TEVEcck2
         ewEg==
X-Gm-Message-State: AOJu0YxfcZUCVD+Y1I/rPr+umc2vdUiiDjshMqAsVoG67QLJG4Lmf1Pl
	yxCLby9ovse2Z6uLE7I0PiyfN2Jtew6C
X-Google-Smtp-Source: AGHT+IEXXAl6p+M+olmFxD/rf4AtM68xnqGl9h+GI6eQZ8wLewlBdH4r8z4932ePuvIrvHRyQG28FDDLVJ2W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:811:b0:5ca:f8cb:181d with SMTP id
 bx17-20020a05690c081100b005caf8cb181dmr425176ywb.3.1701123019001; Mon, 27 Nov
 2023 14:10:19 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:36 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 24/50] perf maps: Fix up overlaps during fixup_end
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

Maps are sometimes made overlapping, in particular kernel maps. If the
end of a map overlaps the start of the next, shorten the overlapping
map. This should remove potential non-determinism in maps__find, ie
finding maps by address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 01c15d0b300a..fba95a00ecdf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -700,7 +700,7 @@ void maps__fixup_end(struct maps *maps)
 	down_write(maps__lock(maps));
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !map__end(prev->map))
+		if (prev && (!map__end(prev->map) || map__end(prev->map) > map__start(curr->map)))
 			map__set_end(prev->map, map__start(curr->map));
 
 		prev = curr;
-- 
2.43.0.rc1.413.gea7ed67945-goog

