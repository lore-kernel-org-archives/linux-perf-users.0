Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947D1E1C29
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539242; cv=none; b=Cxwc/oSe95X2RQw3s5hJ2sev960WwTeTgxrLbQ+4/PJoJTPWZI1WoNYD7x7T0YK+9SsOXdsLtmRIM3n9rn7Mwxnqre+luU4wDzfF4tDUw8w/57ADdIZyEcTxsfv0859nWYal5Dwmrj7mp2z/coOAscAnAISZXxmf1EPK740U7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539242; c=relaxed/simple;
	bh=ls5qZCb42mdenHEt70taljAg+gpCpFTv/mhHrJQzPlc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=EF1f7Vsd8Po7DPos4p9MdvKHgX9o/vvXO6P/dTIBYzS2nA5cki1DPMxnJZUk3RA/AjuJXFFJFN4Mp6Io1iK73tHaPEm7yG6k0HwxC3cO2gvVAyYDO/HT3gumJItMgTOTrh1HWAAo6okGuAQ8ehW8Izr8j1ZivGOP9Vx6sv45Sdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SheM3Mig; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SheM3Mig"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224192ff68bso105477665ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743539240; x=1744144040; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CrKgWnMbesTBpg6SuAlZsn2snjKZtTa3nvJ1nzvzfeU=;
        b=SheM3MigByrNTRjrERbiqOnqCVRghjYQc26Ul14+lV8iVpo+5/GrbZTmbnO6sAL2Om
         bOQtFITA/8ebVJGns70La4HbPKlRvBMRZM2NWuA9y+kMwuu18I0VOzwqt7SsXy0Ya46t
         Ri0jzdfzCB+X/ry0dHFeMvI+LrV+4v4NJpcvkiimBuUYCr4fLeM9NEEPNeDtX4Px/9Yk
         ZPZ8D4msrBqlUPhyRRYsQ0mOSo5wh+AvyXyEUC1EJpGDAZVaBYsDFjAIdmvDt1OiSset
         iwkBMFkzc3eAZd/1wBZMpgvRviXAhxLpx3kcGU7D0rYN6Yar13aQgpdpiNOM9iVo95qk
         I9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743539240; x=1744144040;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrKgWnMbesTBpg6SuAlZsn2snjKZtTa3nvJ1nzvzfeU=;
        b=aY+e0vXSCbKyRB5CIzuLHo05t653NwyRA7eCPOMz24eicK+hWe6FvjR1yNj+7C3MyQ
         Zm4Sk3lF7pPWOUFvP34kPy2rTz9CYgJiej6L/Lt22pX4jiBHRkJbKh/EpDyXr5GehC1s
         BQ7q4s0Ed9/2eaMY4SjMlWF/d7tZOegpG31YdwCAb4++BuYIoG1/IkYrXvb4akFeo6Dm
         zR/e7B5T8RU4/HELQSO/8B7Qy304cfE8hb5epRrKWAHUJBgnGTizBJFCYshQOMP6Vd56
         g1SHWu0Bflyx3yEQBSlZ/PTZ9sOcME7CZ3EqEuWyyHsHRzTNRJH4xqkmbevnF0cUISgo
         PfRw==
X-Forwarded-Encrypted: i=1; AJvYcCWLhCML39aOJ3wQwnOWY6T1i3QSZPkdjb7eyjuI+m3aRT4I7W7AVTMb5V2hYFiBV5hHbqWUjm/DdUicI/oQETy4@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUoj/uiAdqNLSeUQkxtdqZ//cCg/Hs1KQtvWu0QL/pspgH5ZF
	NAEC9SSZleV6JRry9ybduI7q+cT+P3Ez4M98ltlPIH4tozwiqUFyGoNUjXA9igv3xCDAFiQ17cr
	+lyY9TQ==
X-Google-Smtp-Source: AGHT+IHdcXtWotKjnkHzQvM1nTk8QOmr4msmXRENMRa8HKqr5N+tkus6bKggdN1PfI5aOLhiVYHsBd+zNXe5
X-Received: from pjvf6.prod.google.com ([2002:a17:90a:da86:b0:2fc:2ee0:d38a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c4:b0:224:6a7:a5b0
 with SMTP id d9443c01a7336-2292f944df8mr214304305ad.2.1743539240555; Tue, 01
 Apr 2025 13:27:20 -0700 (PDT)
Date: Tue,  1 Apr 2025 13:27:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401202715.3493567-1-irogers@google.com>
Subject: [PATCH v1] perf trace: Fix some more memory leaks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The files.max is the maximum valid fd in the files array and so
freeing the values needs to be inclusive of the max value.

Add missing thread__put of the found parent thread in
thread__e_machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 tools/perf/util/thread.c   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 58a2ce3ff2db..c02ea4e8b270 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1657,7 +1657,7 @@ static const size_t trace__entry_str_size = 2048;
 
 static void thread_trace__free_files(struct thread_trace *ttrace)
 {
-	for (int i = 0; i < ttrace->files.max; ++i) {
+	for (int i = 0; i <= ttrace->files.max; ++i) {
 		struct file *file = ttrace->files.table + i;
 		zfree(&file->pathname);
 	}
@@ -1703,6 +1703,7 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 
 	if (file != NULL) {
 		struct stat st;
+
 		if (stat(pathname, &st) == 0)
 			file->dev_maj = major(st.st_rdev);
 		file->pathname = strdup(pathname);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 89585f53c1d5..415c0e5d1e75 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -471,6 +471,7 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine)
 
 		if (parent) {
 			e_machine = thread__e_machine(parent, machine);
+			thread__put(parent);
 			thread__set_e_machine(thread, e_machine);
 			return e_machine;
 		}
-- 
2.49.0.504.g3bcea36a83-goog

