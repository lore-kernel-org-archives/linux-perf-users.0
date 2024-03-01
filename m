Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593E69963
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279223; cv=none; b=uaDKf/bFpNffVQPBlv0ucaFZpin9uCftShgI+SeJ5gWDbAZhOEBc4KCYaqbhsLsQisUbksVY/Ul7Rv+ouiUEF4MGx24xRJ7aYEn9QVhpmTBHAZk7U8ikM6r5zjcAYMKuL40nx1siC8/L7WAjdgM894oizY86FirQ/6XtkRbDVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279223; c=relaxed/simple;
	bh=/sx6SEtFquJtDyl4dFJaKZNITaLfCxUGF+8rTsmsL5I=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ljC8C0hDMH7qS+04AwGWcnHRR8RwfthSriNqZU9dOC1CpLo1pIT8spwU7wM72d0HaI4PEScZtLgwB0SROAEfj87cQevehBYmAGRlfAiUNhKj4bkHxBJgN1SKbOg9ry4bQmjsq7LyuorMKaCVR55KZy3dgk6YSpYul7Wg7ZhXkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5CuGzuE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5CuGzuE"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso3845539276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 23:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709279221; x=1709884021; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2vDtF8jsZ47KJFPdTHlyCCCvC1lX3V2rNBLzzEwdQPY=;
        b=X5CuGzuEbpnd08seUNciEd2ZFar+I8pfG77yKvaboqu0k1oqz2VsNIAGgeHsJtXoVc
         Djc/WfsRTbCtqb9JEQO1R7EwaBXSYTMCRaM7GSHBjGoS6tFDvhaK7FvAcnsoQEmS3Iiu
         L/C5d98BhT42uyeHopNw5oXln845w5RwNqhhPypS2E0rvwymrcYExdx+Q6xH++Y+JBC6
         KQ1L7nrIUCMsPzi3nxupvoP9zFNCrlJ4tuXia3/pqna0ndAfYXv9RS7hdxmxTAM2VZoh
         JjB1eIlDSBVvDN4wWys8X+9kRBGr5KRau0lFnb4NUi2LXPM5lM80KNmqshwhU+2SECWF
         cVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279221; x=1709884021;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vDtF8jsZ47KJFPdTHlyCCCvC1lX3V2rNBLzzEwdQPY=;
        b=dtz0NIipe6Tb+ruRFgpT+YKsQIWmK6qmVHYkTi26VbqfiBAxFwqgr+MRLtFLE6uLiI
         6DrENRWSt1SoiCmFNKmNnN2ZheFM6vE4ZuLFmc6Fh6UxV/g2S61lPff5XLrbuxGtVXEg
         R8Si1TtKX14hRWrrPB2Y9v0Mzo+jtB6NQqfzJDyHK6+k2qaqeMyQu4JWGOzW8SSh4Rkg
         BlUgssgeVK221dJ7lFJsA4E+W6WCL79zKAIIBI/5R5ICbO3qUJVzq8lD5SmNkKg+l+9G
         +hyfxBgP9huGkRC4UQo2wEj37txNHx3gwC/4Nc0X6wo5H5Weyo+Sr1DFS5yD1tEVjIct
         r7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUnGQnK24uFdUt+PkfqGLAKMrwBtir6PIBUJhWgcHvvgWSsx23cq57+e/nWl66Bur4dfxRuj6sv+loLxZ5xnZg1bScIYwC90ZBIeifzVgJV5Q==
X-Gm-Message-State: AOJu0Yx/Rlyp//H+3uNHCe08v2z2C0qFeMHg/JT1xG3/1yX/6Zs/sEP7
	TM/wYPx2WJ0HhqigCJOjAtuv1xiYgYLGgKAubKANrIXP0PubWt5NtDWgNxUwpXNtQZz3SeJWFcZ
	mrPuYYw==
X-Google-Smtp-Source: AGHT+IHrBfzUxQP1oIvterNW8El5bqvNoQh6OVy17grQnyfwObnPYeXNFK/EoKiNIoBpOKL59O1t8A9qZGIg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a5b:f05:0:b0:dca:33b8:38d7 with SMTP id
 x5-20020a5b0f05000000b00dca33b838d7mr193989ybr.11.1709279221335; Thu, 29 Feb
 2024 23:47:01 -0800 (PST)
Date: Thu, 29 Feb 2024 23:46:36 -0800
Message-Id: <20240301074639.2260708-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 1/4] perf record: Delete session after stopping sideband thread
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The session has a header in it which contains a perf env with
bpf_progs. The bpf_progs are accessed by the sideband thread and so
the sideband thread must be stopped before the session is deleted, to
avoid a use after free.  This error was detected by AddressSanitizer
in the following:

```
==2054673==ERROR: AddressSanitizer: heap-use-after-free on address 0x61d000161e00 at pc 0x55769289de54 bp 0x7f9df36d4ab0 sp 0x7f9df36d4aa8
READ of size 8 at 0x61d000161e00 thread T1
    #0 0x55769289de53 in __perf_env__insert_bpf_prog_info util/env.c:42
    #1 0x55769289dbb1 in perf_env__insert_bpf_prog_info util/env.c:29
    #2 0x557692bbae29 in perf_env__add_bpf_info util/bpf-event.c:483
    #3 0x557692bbb01a in bpf_event__sb_cb util/bpf-event.c:512
    #4 0x5576928b75f4 in perf_evlist__poll_thread util/sideband_evlist.c:68
    #5 0x7f9df96a63eb in start_thread nptl/pthread_create.c:444
    #6 0x7f9df9726a4b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

0x61d000161e00 is located 384 bytes inside of 2136-byte region [0x61d000161c80,0x61d0001624d8)
freed by thread T0 here:
    #0 0x7f9dfa6d7288 in __interceptor_free libsanitizer/asan/asan_malloc_linux.cpp:52
    #1 0x557692978d50 in perf_session__delete util/session.c:319
    #2 0x557692673959 in __cmd_record tools/perf/builtin-record.c:2884
    #3 0x55769267a9f0 in cmd_record tools/perf/builtin-record.c:4259
    #4 0x55769286710c in run_builtin tools/perf/perf.c:349
    #5 0x557692867678 in handle_internal_command tools/perf/perf.c:402
    #6 0x557692867a40 in run_argv tools/perf/perf.c:446
    #7 0x557692867fae in main tools/perf/perf.c:562
    #8 0x7f9df96456c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
```

Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 92ccca9574ca..32df34dda9cd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2881,10 +2881,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 #endif
 	zstd_fini(&session->zstd_data);
-	perf_session__delete(session);
-
 	if (!opts->no_bpf_event)
 		evlist__stop_sb_thread(rec->sb_evlist);
+
+	perf_session__delete(session);
 	return status;
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog

