Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867F1F8937
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328141; cv=none; b=Vt6gzZEvQelHglpQUKBSfMs9s7yHgcjMDD0wYzp07U7YEG8Xc2p2m+jJqPYOF8IIMztx0xLvqJy7chl4nCmTxr/s+bNRYNNVMThpnURwwi248tYgV4TH/J804iTl3ylR2vAorLrtlt3z4Ju1YEz1ns4xXkfRuN9vgbqC5mE4nKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328141; c=relaxed/simple;
	bh=6GAQwN/G8OaPU5mQrLfIZzTMBZfklMbE3h/w4v7DU6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Fwk2f+lngN9/x49ole7BwWrEfb4kTOH3oWudsHxjtVpkopGWjdWr/xNoj/XIySDNGI+IFa56dtQ4TmmIqVdF/L4CTc4thXjvWlcFo0CJ2Y/3lQdY3v5xAIuFGiFjPViS+AoGKST5d9okbGIY7lcrQjPXwptOp5AS0GaLqvrCJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHAqnrXk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHAqnrXk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7462aff55bfso100020b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 23:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328139; x=1748932939; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBLkKYkdQ5SiRC198gXvkCB/ma/yQ9E3LOnnNzaUpPE=;
        b=SHAqnrXkray3yUDLuFE9fZBD6dM6fD0QW+sjwwXtGNoGY19iIPBJ6F9XIY+e9SKKkv
         vFtQnRSzn5XzmD5VVZazSy+ATBapGYgcUMUKyCpCMV1H3uQIlUnlHZ0bYuk/lQ8yF7/w
         PeBYqVWlDOdFrqfSMXbajto6KvpzSXAgrUeRZp1EvbH67ggNfSPJ6tskIPVPXncYbwk+
         lQMyqNNGdsrGMCe3yGLMV1iAN9PUb9XJy/57x2I9TtHPtzMlqXHsMOyKQxUI6LwK7pAp
         dhhzi7sGocGNuwqZbihO5dkLP4uyEn/Y2fjY8ZqYNLGaXBL00bRsq/QAjLmd/27gLxZ5
         Kr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328139; x=1748932939;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBLkKYkdQ5SiRC198gXvkCB/ma/yQ9E3LOnnNzaUpPE=;
        b=XY9dIQE7D7UE8LW6YVasIWnClPyQEhnYrk0MSvDiY9yzvf3+7jmUQgpnpkSCj9IvXI
         zmY+YUlf7Ri1tj4qUMPnq8Ann2mEeK5VelaMv5CnALk5vOjtJdLM2GwcrxHqHxrNBXOc
         XdB2ICgJY9POtNDQz+BDZceaIx/ALJGvnvmtL9hnc8iS+ToD+gdwwBgFKLFBL/bEhUpZ
         /HqxpGMULbRG5aBmv8WYwMoGxB3Fp0lxSM143qOyd+KE/sqthYXgWYohjZJ3nf4NbGDF
         QI584rxkF7uSOlhTqOQLwr/DMDGPKf4KTUCcNg15HsZqP9Z/RPL5ImPft6yfN7FeF1Uu
         iNyg==
X-Forwarded-Encrypted: i=1; AJvYcCXW7ZnPjs46U9QM9u3vpo4tY5MLEsrRx1sw88uc/diYWgoKjjQ/dLNKsXrwDr3Tic21InCmifbvrd1JJaIC0LCR@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4Odyk7jn3Dt3dY8ri6At32t3sdjurN9iYrQR+srFScWUXRqR
	qR3yMjAf0c4KoRCj72fNIdU9XKH/8lw8c4XavzRH4NgLTmsD5O/pU90LR/lLEpDgMDh2mBNSfvI
	JIJmsdysXcg==
X-Google-Smtp-Source: AGHT+IHqlWKmFD9yc2csGjHzi/9TzTaV3F/Ku4c45zz+W7Lqi3AOLD7NV2uIbBNeShcVb9hrPPZxDweD3Vwi
X-Received: from pfad17.prod.google.com ([2002:a05:6a00:291:b0:746:1a2e:b29b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1b:b0:740:4095:4d07
 with SMTP id d2e1a72fcca58-745fdf4aabcmr19069753b3a.12.1748328139389; Mon, 26
 May 2025 23:42:19 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:49 -0700
In-Reply-To: <20250527064153.149939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527064153.149939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-8-irogers@google.com>
Subject: [PATCH v1 07/11] perf session: Add host_env argument to perf_session__new
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

When creating a perf_session the host perf_env may or may not want to
be used. For example, `perf top` uses a host perf_env while `perf
inject` does not. Add a host_env argument to perf_session__new so that
sessions requiring a host perf_env can pass it in. Currently if none
is specified the global perf_env variable is used, but this will
change in later patches.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 3 ++-
 tools/perf/util/session.c   | 5 +++--
 tools/perf/util/session.h   | 5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 1b8c4ff39124..e6f1bf093bc3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2532,7 +2532,8 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
 	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, &inject.tool,
-					     /*trace_event_repipe=*/inject.output.is_pipe);
+					     /*trace_event_repipe=*/inject.output.is_pipe,
+					     /*host_env=*/NULL);
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index beb74d9fcc07..9b477cc73c85 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -137,7 +137,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe)
+					 bool trace_event_repipe,
+					 struct perf_env *host_env)
 {
 	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
@@ -191,7 +192,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
-		session->machines.host.env = &perf_env;
+		session->machines.host.env = host_env ?: &perf_env;
 	}
 	if (session->evlist)
 		session->evlist->session = session;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 088868f1004a..baa59fab761b 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -109,12 +109,13 @@ struct perf_tool;
 
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe);
+					 bool trace_event_repipe,
+					 struct perf_env *host_env);
 
 static inline struct perf_session *perf_session__new(struct perf_data *data,
 						     struct perf_tool *tool)
 {
-	return __perf_session__new(data, tool, /*trace_event_repipe=*/false);
+	return __perf_session__new(data, tool, /*trace_event_repipe=*/false, /*host_env=*/NULL);
 }
 
 void perf_session__delete(struct perf_session *session);
-- 
2.49.0.1151.ga128411c76-goog

