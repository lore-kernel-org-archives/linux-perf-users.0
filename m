Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7B1864C
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Apr 2024 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712376560; cv=none; b=OJxQSxQYWG7vLiN4p/UNDU8fkOqiM2zReFTalEVMQOVKzsnMO8YgrbVVyobxLas+6fUXjKKT4kJ6qdytT3UrPAAysUWVjich2KaaaMmuhrutJ+my9l45oZkgZzEj9XFunvV6URsuk7HV4dxGl/zDRq5JcsOCBXleKSNZpRc/fk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712376560; c=relaxed/simple;
	bh=ryhaCjT8y83e6nm9rSvWXbKLjBmeKFK9uS2+aXyQEW0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fQAGoLGjdrtoxkj6G1eLj6/6f6V6TB5Uletw/ddiU5i0TMxehHPbzSADQhXz9mScElmP9tkKj4ng6vjinSaB3EaivqLWmPz7OfM4sBBqqffghr5lDB9fTSrRO8ifWYmQYZZoS6SuzUy0wUgH1aqaJnLHO5WeFBdyQaRivs5uabg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zBk0Xr7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zBk0Xr7"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615110c3472so51157667b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Apr 2024 21:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712376558; x=1712981358; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNu7c9amoaI33ZXVqjycoBCCoj/nNGvrPWP0zIU3JJE=;
        b=3zBk0Xr7z/O6DQ7wPX07f9FomFCdMKYk+5o37Ytw0tYuIrpnIAtC3TjJcAycYEYmK4
         8rjVaH7lXIa6Xel7D2it7fad1mWR2UbUMNUlrlnkDSKMdqSYcBd4L526I1caImigrENJ
         wokRdsmVG2KuNTgb2kCSu8BM8XixsY9/VFaRf3muRRqr7Vh4XfurriIDhyHh1o3zXQOC
         NSQoUYtzDiPlA34Dzn4WXbxpQET1AuD/caeXMd+cXp1s2hv07GrVSUjIGWmeHo0afjDw
         Ew0c1EaU0addIEkgbwFjvlTBsaGUs2LRloTptPy1TIrjT6Ta/hTKYvmWOk2UBNu3B5lD
         smFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712376558; x=1712981358;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNu7c9amoaI33ZXVqjycoBCCoj/nNGvrPWP0zIU3JJE=;
        b=lNqr9LqcL88F3LKjG1ZT1cmY5A+xeiscW+2EwftbOptfkSIeLODJ+gSDNexck4napL
         wh8CUOvjibFo8WPhlOhyRUg8f5nZ9cMuBpfeIryeXoCOd1H4lpLyHkx0EFkYDvJyBwzi
         ga2x/VyR4vBZbb/oq/aKa2gDvgJF3425Pb2QNP2NjG0WJ+0OXtIocDT5+Zt5SyWzFIa+
         Sm05TPupIKrH0mx+wv3SaHO2Khb+OYqcxGyzDIi4izNTeXjhltrB0c5lOESQJKkBk+iJ
         bBjcP1Y51LAEaIN/N8QpxaYra+eCF8/L4nV4YxNSRwzFFMEZXr+6t4eajFnKe3uC5wHg
         /kqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYYj2rb8rkQjo637UhQeeqUAeP21ZiqhMI7n+Pa7BNsrn3T65lLsdDtDHCsso7Wgeo0voZksb1xzdjEK9oIYXz+S48KSb7I2oKGQAjzmedqQ==
X-Gm-Message-State: AOJu0YxvGSDMStvFqcyt7jDJdwjrgx65aPNQIc1tFygghOpW78N2WtLS
	pfyz/ksDSeVH3suiOSoKY7sPdnMY8sCBd/OTG1shjU/O2CvbXJeKI+RqLLKi1a61PMTr/vo0VU5
	ECgiNgg==
X-Google-Smtp-Source: AGHT+IH7IGd2BpRVCyTAOvsnf3SjaXVdsGIlIFz5FXVc55i7Tlr9PCarJ5xLRb9aFCQWhPs6faG7upJWWRWK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51c1:e2b:9198:3cdc])
 (user=irogers job=sendgmr) by 2002:a0d:ca88:0:b0:614:ff0d:2c7b with SMTP id
 m130-20020a0dca88000000b00614ff0d2c7bmr806437ywd.10.1712376558227; Fri, 05
 Apr 2024 21:09:18 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:09:10 -0700
Message-Id: <20240406040911.1603801-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 1/2] perf bench uprobe: Remove lib64 from libc.so.6 binary path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kees Cook <keescook@chromium.org>, 
	Andrei Vagin <avagin@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_program__attach_uprobe_opts will search LD_LIBRARY_PATH and so
specifying `/lib64` is unnecessary and causes failures for libc.so.6
paths like `/lib/x86_64-linux-gnu/libc.so.6`.

Fixes: 7b47623b8cae ("perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 5c71fdc419dd..b722ff88fe7d 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -47,7 +47,7 @@ static const char * const bench_uprobe_usage[] = {
 #define bench_uprobe__attach_uprobe(prog) \
 	skel->links.prog = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.prog, \
 							   /*pid=*/-1, \
-							   /*binary_path=*/"/lib64/libc.so.6", \
+							   /*binary_path=*/"libc.so.6", \
 							   /*func_offset=*/0, \
 							   /*opts=*/&uprobe_opts); \
 	if (!skel->links.prog) { \
-- 
2.44.0.478.gd926399ef9-goog

