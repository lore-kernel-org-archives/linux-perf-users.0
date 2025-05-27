Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB31F8AC8
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328130; cv=none; b=YAzfNoHdl9n3rN1vB7GqaKr67wjQUTYtd7m9H/foeVZe7zq+2+McQuJH2R0BNwM07b+Aq+d1zdAWU5qBKAU9dBlDyAcjP0UxhyI+Uc4k6hcravPr7sX0WqmiqAaiWBwEBTPVk3Ve9Per1Rmr2fS27OjgizkIRo8xBJKgvW/uecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328130; c=relaxed/simple;
	bh=esAza8BpL9KLHFoVuUTADRG9Z6iKZDwRWo4BZz0qfjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tP8p2jnnM0UxEu8IB5MVupxio9X4HYAgouCNDGL8VwyqPpqwL4fqTJvcr5eMJLqVPwb8hD6/twbe7HBC2GF6ATTO2zilngMFtSVefZF4TR2Mcpe4dd7ORaO88nPOh4dXpjoblTXtke+8Vdiau8N3ONXmuzIDTv+aqAjWFc/K6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSrPUo2u; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSrPUo2u"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e120e300so3163845a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328128; x=1748932928; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNBSgGt6ntBeP6bJfTxMkVoL1Im4HvH+NsU4r6JbrSA=;
        b=rSrPUo2ua0rUpurKv+UseGLnNc7ZLcWb8NN9C24C7FGbkfNEX7kgtusH9+dfm//os6
         RnhZ4Bg3MnYmnuDWdYhBjdxCdEOvlJUvM2XFAVmNGM2T/q/k37Zv+qotuiaqsY2SMOvO
         LOk1lNJS16XAi8BbC76FdkQutYom5LgL4++rDRyf/oNgTGZASj5+ElSrD95RefZtZDjT
         NIueyf60mtr81hEST58f32EEVYksFHWdsWTR+nSoEwRM6zlMCggSewqzyPJj+RtR7ZZD
         zadqs2Gf9o/1pjbN1PPxLEHSjiDBQJ87OXjekOqzVaM/VFuOTEjPtqucQMVbFxBOLVOy
         +Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328128; x=1748932928;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNBSgGt6ntBeP6bJfTxMkVoL1Im4HvH+NsU4r6JbrSA=;
        b=iTF+hl79tZ98Sy/8dYNdQSYnhEvuCJDImcm4kYrM1CfSCEQ3bVoQ7R1HkWbWk8FSfg
         V4ibozypEL+xz04U6bvlWafOgTpsMYcaj8IFUTapr8WrjFJk1XNWR/O0xhO50orRWc1M
         Ch/2tDXNbCbzQIujwII2Np4GEZeXypWSmP1hpVYVnSK+mt3oCQ1qnL4VIaw/jiBQKO0M
         B8hDwNLYq8wyoAA7PoNp/50cZKCDkl62AfMbuKTuVxL2xW+y8hd8QPWF3gqw89k7w+xb
         FJ5hd5iS2/zETDuS7HjvVgVenqWjivX+S4dv+txnw7Ir5SkM9TO9MI/PwOzJAo4qAoyK
         jFUA==
X-Forwarded-Encrypted: i=1; AJvYcCXvgus+Km2FEZGmj/LSaXenM3wm43a9XyyduZZLqjVL2W9WH5pLfeisw41JBT5lA8dqzztV+OXb/AbGNTOspQ5g@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8sc1bQySPX1K2PBSflMx3FjKXjVBCIYRY4ZfWo/SC07wcxX8
	XQytoP6+omqHzKGyfGeDMyJnHRC3ZiYXRR3g6rkFmxaJb2oZ4SP9fAKbrB+1DnmGZomTINQzqPi
	8he7CaGQg+A==
X-Google-Smtp-Source: AGHT+IFenJln4YVrxzSoeKFPhnKekKykeEQwGp49nReAoUtxshS+gVghFYMEClRpQQkgs64NC+iCtwEFYlZz
X-Received: from pfkq8.prod.google.com ([2002:a05:6a00:848:b0:742:ac1f:7e2f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c707:b0:1f5:8622:5ed5
 with SMTP id adf61e73a8af0-2188c1e875dmr19059538637.3.1748328128059; Mon, 26
 May 2025 23:42:08 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:44 -0700
In-Reply-To: <20250527064153.149939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527064153.149939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-3-irogers@google.com>
Subject: [PATCH v1 02/11] perf session: Add an env pointer for the current perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
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
2.49.0.1151.ga128411c76-goog

