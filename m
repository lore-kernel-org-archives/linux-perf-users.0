Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845623C456E
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935065; cv=none; b=XMxlL6o27bwRqwm6JuBnBTNE1HWTJ1xRdHD/1mS4eQUmvKV+22cg5L2TafPqg76jDP/zCrU6aqBqIGdG9fBK2VSKQinYURikYE9uJZ7utMEeN0jccXph2wP4Qg0467hlpxo5stdn6vFKXvS0Pzk+a3hziPLRB/Bh2f6LdksV+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935065; c=relaxed/simple;
	bh=cLWE7bs+0Cxg9cEMpw2DCvBK22szFSANqxVQJFFr1kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oKQ56Sl//NfpKH/09QD9IgaMoMtm21cOtXRsxr0eoTyla7c7N+6aAiwGoz5wIKBnJvlASlyloLD0ADRQFcoCd5lfUW48nqXtG77QUJSPDdI3N35PPDZtQCRN+UuS78D7c8twTrx4eLEYv1WOpk9RqSBGLrVpRsV21VR4VcZJIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyhuYQSE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyhuYQSE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12737f276a2so14019679c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935064; x=1776539864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=XyhuYQSETq0ONy6Btxn1UfWmTbUUlpaXQ8tB+HzD3xFlO6BsYMx4lvFPqNyWHB7Sbr
         5Ej9cnL4azgE2lS4LKunHfGsm2SLTavw0946Eus43YvvIqGF4oGgubgm9ZJwfqVjY27n
         sa5Oy+KWqIfNtddnP0IS30FAJVCFlXBnN5mNH6nEhE53kZAcu7tZuCyaWtZTToNtkvNI
         vHsW/KodYCfBkKcCicolHBRkHudyAF+ez6NgMJ0EWw0tMFeAudTkxoDBgteTwdiwXj3L
         jUxCiRIZk5eC1Fv82aofbdkSgdnhnSBrO3pdv7OFoYb37w5BnzIwjbellRGXNKUNM7qa
         +ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935064; x=1776539864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=Eqf8H27Knrtxwj7wQal/h0livqrltrRMq1pAlPnd34bqTcOVM8shMBzhFm2Lpkhu+J
         y+xBcn98XUbK1PVvIXFV5OGtLm7x3UPBTU7QDibkSGuWV0Ab+Rm9ThS/ZJ22Xa/zgHGZ
         ufOYqMHzQ0zmvqjjGhxb6c7N7WFK1gywydD3FVMBUDjjZ2l7T9f8aTXu+4Aj4P9hYo4J
         w7zKur9gW6HgNr7+3/WpAfRoGpRNNxAB0N/spwh9yzilhXrSGTGXNYZ3FGp4OV/ec5Oq
         Q3jWwsxKbZd9vA4A1x0o8w0PZddM9lcUmjAfXF51SnkIhHsUzZx+/Gh94zsyGXBL2UxI
         n+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWTPVjSfSNwFVgRGRXMIWYiefMoa0qc4yaMSajgb9xpYXVQUdN9XBfLMHnWrNJmV/khtJdgIYR1WPyeLXYtDu9k@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoA0qrISE4b9N2wMv0kjcyCq2jv11bNIUMtRwVFkepyP2XV3x
	4Ayt/FzbL6tc/0HkfJFT2N0y96sZpf8vbNw3KRiFI0SniDsBZKN7WVZnkhhOiniTBOoQ9b3ylPW
	KmaJh/on9lg==
X-Received: from dled12-n1.prod.google.com ([2002:a05:701b:42cc:10b0:12c:1ff3:9fa4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b0b:b0:128:d7a7:5271
 with SMTP id a92af1059eb24-12c34ee6853mr4573838c88.28.1775935063458; Sat, 11
 Apr 2026 12:17:43 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:53 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-13-irogers@google.com>
Subject: [PATCH v9 12/29] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ff7117c5470f..3deb21f4d781 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -788,9 +788,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.53.0.1213.gd9a14994de-goog

