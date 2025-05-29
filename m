Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882802571C6
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493631; cv=none; b=kpsKg5drs4l4MRhWvLGrSDuEBLCjaNY2m4JckmzpKgCvLxWOOydxY+GbyCZLry5mRizuceVVhHCwGhDh2PvtbfQcs/DHuwTLpPZuR3RtTKyAVHTGGQTVbocB+cGCLw04Lo+bYy5/sPFL6Z4o3jSdDgNJPtZMBHUX5MZHUb/oQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493631; c=relaxed/simple;
	bh=6yHwkKq6IIJbldd/zAUEevYoO7xZpmsIHYFkwvK/JAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PpoZTSnFgk6PZrkw0LnwC68rETTTYxOhVcFD3D9BEDSL4OL4Xk/TCAku+R6dajElsF/aECywOpNH4TpB3rlNdri2TdP0jZz8uA97WfxX6LdTME0w5Jew1oegp47ovBgORHemmMD8GIZ2qdLejkfwBGfar1r3SPV6fO4IRFGvRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNCQXbgg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNCQXbgg"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311fa374c2fso596839a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493629; x=1749098429; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbWFwE3NBJXfenPf6zVpWFqvg1HOaBHgLfR4kbE7bm4=;
        b=GNCQXbggoJ87SHq7Rgkv4ApEGKO+GTyDVvvnA42YNd4p9r6iVY0IxcnihyZ+yQkHXq
         mEQIOFnAeP+qqswB/w1BaxW9v34benJdND6DXpypX7HojagJSeAgLWuIyMM6g2ptTptd
         LE//uJxHbTahWJI52YujY5OcMcCe6O4nqUk/u2xnc46g3LTH7xixSQiR2oACdO1Jsnrj
         mS+3jIv8XQCSwoXs1NjOwQwHbhFt08WnnTMZW58NP7PptU5Bfaql6gcqu4ZW1WHE2pOy
         c+tJJigP87TGOExS0aol/2miz5Is222/pgZzINrTG1nhx8ja9lEQmKIeWUEK5SvKbGri
         /PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493629; x=1749098429;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbWFwE3NBJXfenPf6zVpWFqvg1HOaBHgLfR4kbE7bm4=;
        b=ApFKVfqayI0gI/bUNa3pl7yTCBRp6edwXgQjHk4CFF27erugFg+OXXXYm5135HyZN3
         j+gW1BgmM+o4shpkvpsFxdYk8CNxRECB4L+ARufgxzPwYw8NFsDd/Ejqpwx3OBj/OhXj
         P20aGtaB+rJguJmQffT/mmmiGzFfHlB3xGmCoHjYcBTzoia8WieIRDPPwo+gOt6B8fRR
         zfwKk8Asyj0YjUohD7BMn6J6oAiV8nvDCFybUw6NBOADd+trOLokgP3y2duCOElyjO3y
         RTGVVmslRclTQSHpoTwENGYdSjo4i7UB313IOossx60Qv6A3CNBnZ3h368ZABWj/IkmK
         Uz0A==
X-Forwarded-Encrypted: i=1; AJvYcCXF4bNo0qQNDWZtQSik5F4gxtVG8Aldy+arzwrxb4CY0G8Pw99D1oY4fBLXYgQ+jzKJ7NdcOY2cZB2m0PCTDmc1@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUCcddtd3dWB6/+E7WFrXqSZ1YokYGqwzB2hGNmjQ18gCim8A
	W5RJkSpzq1MiaDUJaP/tSAxlWtytXxeBU7e9RBmD7oxoEW4EriU9ze4T93dP+EeD0rlGCvgOCmg
	l+IpqnmpyiA==
X-Google-Smtp-Source: AGHT+IEMJs2IOOlHldXp9wTZAIVeYOWli7dpE37barkrgzVYs9ce83S04oJICPcjWW3vQ4qCtwTAbu1x11ne
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:2f9:dc36:b11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d87:b0:311:df4b:4b81
 with SMTP id 98e67ed59e1d1-3121dc9d6c3mr1350848a91.25.1748493628616; Wed, 28
 May 2025 21:40:28 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:47 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-12-irogers@google.com>
Subject: [PATCH v4 11/24] perf session: Add an env pointer for the current perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Initialize to `&header.env`. This will later allow the env value to be
changed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 3 ++-
 tools/perf/util/session.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d3888b78ed50..3af518243daf 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -155,6 +155,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 			     ordered_events__deliver_event, NULL);
 
 	perf_env__init(&session->header.env);
+	session->env = &session->header.env;
 	if (data) {
 		ret = perf_data__open(data);
 		if (ret < 0)
@@ -2746,5 +2747,5 @@ int perf_session__dsos_hit_all(struct perf_session *session)
 
 struct perf_env *perf_session__env(struct perf_session *session)
 {
-	return &session->header.env;
+	return session->env;
 }
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index e7f7464b838f..088868f1004a 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -45,6 +45,8 @@ struct perf_session {
 	struct perf_header	header;
 	/** @machines: Machines within the session a host and 0 or more guests. */
 	struct machines		machines;
+	/** @env: The perf_env being worked with, either from a data file or the host's. */
+	struct perf_env		*env;
 	/** @evlist: List of evsels/events of the session. */
 	struct evlist	*evlist;
 	/** @auxtrace: callbacks to allow AUX area data decoding. */
-- 
2.49.0.1204.g71687c7c1d-goog

