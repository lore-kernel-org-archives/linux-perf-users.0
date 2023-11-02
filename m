Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8020B2D
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnWi1pUO"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80FD78
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da033914f7cso1463315276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947938; x=1699552738; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZBuX81183QRrNaiqbrsOc3T/YgY2oF4/Db+YNFRBBQ=;
        b=CnWi1pUOApOSGz7yPQQN2/n66MaHAO7Hjl2ZVWURDfA5rrkBZPFC1ahMouJimPDjaU
         AxO37SZ/AXfly5TXSnzvXhQJgcbmM0mqVIY+Rvt37lWITKM0bJp4di7KWDcSB1xnnKYr
         xvJBjsiHNJGS+/KlnxG7SsQVZcZTUHtXi5bjm4Pw/NB4BtZMUrq+ypP1jrumyV9modXO
         3sQgVJq1ji87YThnejgrDysCajgLCD3J8ObCbu2rPXOuBxGUjBN6Rmxt5YTwOhkBW/DQ
         j8XjmsqRn/2r7Nktof5dpjCoSv97OP7WvcWloP/Ik4VL+i9e9dOt1oDi1Yohm72JiGUs
         ihBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947938; x=1699552738;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZBuX81183QRrNaiqbrsOc3T/YgY2oF4/Db+YNFRBBQ=;
        b=MIh2Vupdx5u0LePKOEadKFa5AH6YZPRNE57DTBd1jdg8WGDD76YeVjKe5snFQwmW7E
         AUhByX2aYs8GEjpV/ji353S5z0AKPCcQMEBDlU9oITplHQtfgvq3gV2MPHRWCnnc6H+d
         fdxU1YmrLOBzAnSiaz7JOkLP/HSxLEhxEuo2sFBdLL8OrjoDKimYZHL5kue6ceNnnIrv
         CV4V/AQ1FAJjqq2V/HWnUJU6ui6mCJkMf2foO3JwsXgwsVEkC/Ad7qKgz6/W4IKXf+mj
         Cw/QkBSjHh6ZFUDTnYEKH24yFRYM5uboJHl0e1/3ZNzS9ey+9i3lHFumzZFtGIZdGFw5
         MuyA==
X-Gm-Message-State: AOJu0YydvEcLEPOh05HT4y2+zntXcpBnO8vYywOT4cRLwCw2Uc11Xd/S
	8GDoRMw1/sKCtbY2x1QC0O7AgTU6phgZ
X-Google-Smtp-Source: AGHT+IEl3qANM6gjbu74OwwL0Dqv2kvdXq7ayyS5FKZI30Es8f2oT9DzQiwouXtKFDxkyMl9cz0lzSCZTaJt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr460470ybu.7.1698947937955; Thu, 02
 Nov 2023 10:58:57 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:09 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 27/53] perf maps: Fix up overlaps during fixup_end
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
2.42.0.869.gea05f2083d-goog

