Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7BC17988
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854558; cv=none; b=PflRjw1+NPXqYd11FWH43PUniUGQVvv3VOXzmaczmtEA/p+gkrnN8cOlK+Q0Bk0OwvN5nqEW7bnH4xT8GYq9pRnwA7IoGaRKW0Ao5dn3ww6lPWrc3sLHj2s77+s+HGvLXkPId5HBZbu8XRFkCyIf/WrIAUzxn2lxBRC8C1OgeVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854558; c=relaxed/simple;
	bh=DaB8vTdXvQNZKpQ3zmCJbz1kO9aEvxkRfoyVK91CF/8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Nb+LC4y33YBd8F+s7IuydGIGmbIwi5Iqv7JP+q1IzIZMED6j4YRHQec5Ayp94mrRKDVQ4kjIms4Nqw0H4GvUzKM5pFI9zauOmZOeL8+s7VHdTrMlW6wcUDvcRdFXPhBGfPIxV+mn83699xReVx2nhY/6h8kJ9mT6DELeA4B7DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoIRlQsK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoIRlQsK"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6c2643a07so3113981276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 22:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854555; x=1707459355; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1NDzPJDQoypR+FtlykBmPEdE/4vIPaLTqPNnIbkP3o=;
        b=KoIRlQsKE20SUL48lWyZvfQmqDsCbSlEExODvgMfICbWuHk4PjCORHQecoj3iv8baa
         l0PxQihrApQi8ZY4jJ8glRfBnTwE1oRdBp4JshMO+mqxvUij2RdFnY5wNOh0mcg95Fje
         Eza60cebkrHbcIDkOnleMalvGl1aUTsYi0/FNb/s7fV7C2baAP1wFZy+VZJeuL9t+Sbo
         JCacnOfh3CQIN8AaL9Jr1dERw+sE4g+xWR23qb+e1pHZvqNt5Y1Djz07mF3EQFUkkVl+
         sFH025fVuUcVtCdVhIyknPFz+CKJXAbOH25aRSFoKcHTqBt/Jj41h5GEzBhKMAebUige
         JNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854555; x=1707459355;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1NDzPJDQoypR+FtlykBmPEdE/4vIPaLTqPNnIbkP3o=;
        b=o2hpk9jsfpUb4SCPwV6r1mtdPVLfUIveaR1dtjEmuDVwV68bJPr4h4WgkGk7TX86uQ
         GyQIi3pjGAW9CJQmdy1atuC99/rhx8l/k/v/M5iLPDtTxUoZeFrkSEViVMTTuUjXgu/O
         P3y1Zzcp3IkDyTv/srZOkFTTCCjOYTcHuqAHUNnJGemQGBbaMoVxYOppo1cSDvB8AciJ
         9r7JH4/6YE/nSVoByiZ2xFlYtVcGvTMPSq23MAWpnmwsQZCW0yaODeEatoogWMGknqcR
         AVrY8qt5zGwJ9eQd06B372Pi2inXdwdjYhb7Yuv7vff1kQreJGfX5oHINfafoQb4FWUo
         AunA==
X-Gm-Message-State: AOJu0Yy4Xf0NoNqRRTKzGKvEThVx6etclQlpO/2UnrEk2z3gWoTfN8fQ
	QOgwIzTJoqpcQTdoGN+HXl7fDt1coYIo8QmiLEUW0XSx9piONwbOqbcgd2H2yEHBJsqnUuMQado
	4gRRmlA==
X-Google-Smtp-Source: AGHT+IEdn3eFJFcsAx9byY8lyiQ9DFXzQLhh9fr4pbXsLWEMjpduRuO2BPnqszGLbRoNgT9IBwBT4qv0ABMp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:6902:f0a:b0:dc6:d3c0:ebe0 with SMTP id
 et10-20020a0569020f0a00b00dc6d3c0ebe0mr1158215ybb.0.1706854555663; Thu, 01
 Feb 2024 22:15:55 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:11 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 04/25] perf maps: Get map before returning in maps__find_next_entry
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
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
index 489072bebb5b..75e85c0e04bc 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -956,7 +956,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.594.gd9cf4e227d-goog

