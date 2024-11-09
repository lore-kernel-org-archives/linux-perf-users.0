Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4E17E46E
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133136; cv=none; b=RwSbE6Z6dLvAu49SdLFSk7NHOsjydcP2WBjMkfN01r2cB2HF2bt/8BLkvhQ+O/6NFZviLYjCDRi3gwzvlWqFlvAVMq+tZ6uEGFpcARrAJA8CVpqGQUpUeMQaPJpsO8I6qftslLBKbNa4q+YmqVfsjYjkNHKp7usxgV+9ok9y9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133136; c=relaxed/simple;
	bh=Wbl/xP4VdR5ZVYx+gs/s7yb4T91c4UvpqUcjo9rjNDg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=cFmBvZsyM0EAgVbPSelWkuwQal/+E5VJjukVKpUKn8fz8KE8GC2U4KocXbgSuG6xBD4QQm9qi2XAJDLPTW/dRMHeGdLSzZybbeF2RQ7WsrteX8DjQEPx+x0rRmNj3dY3bibBJWzxe0U48oZUGQu+ZP8AF4fWiNO52DN+/z9uurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLUMObdA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLUMObdA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea6aa3b68bso55178577b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133133; x=1731737933; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vx9oh/oHlJIJYsgb8VChVGCOrMitkPgbmFPZ/WsME0=;
        b=LLUMObdAGtbQ4ghMJveZHOCxdf54ntWHKV51/J+GAlGaHoX12QS4MjCaelqFKlborI
         Lmwgo1Y4It+lqPM4SCrETB4jmSwxxAWUGLqO4GThWQPvzFVCnL5XEVN8qDHpk29D1gYC
         iU8tfgE03R1wHXXAf4/OKq3WmJEBBuUQNVhRRwlsnlb7XPyKrwuuRMs+OE8DH/i4EUXu
         j6RDLJUXbFiqhHNh9wZz2AvzUfh6p6ljNrmBN4O8aH7+CObpa3+sH8mlc0tJeN78o9Av
         yU56f1qFyDS3SdYLDvuZp00FzTKOihOyAmYwRiWmIxf97nGevhq6QmDpZ36kdiJXIQUI
         JEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133133; x=1731737933;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vx9oh/oHlJIJYsgb8VChVGCOrMitkPgbmFPZ/WsME0=;
        b=D/2CNlk+pIQD2pqqjIy7tz5zgVEPalVQjT1T2kJkZChSf0dzHOdpcVMEjAvELo8nzV
         24/sIG6ptzK7Ydh+aEH9lKxhpd08MztRqv1Mz1YFBdqnI3Mcnw4ZkxuIh/HsAlcE7DCV
         Tl8Rl2n3eOMbn+phvKK37npipfJ1Q1qb8l8CANJI9IPzpHVrSd0OBQz/79BQbcPfmXA+
         Lg2Sl93r5Y0bbwsdTefH+CCODndyp9XvXJZlYbm5URbGfIfm4CNI/sygCs2ztDkUfeIJ
         6RAR79UO41R8yK172pvDOVdhPLhxkgZSiJ2S56ZdS48APLk+9GCNkLEcEbNMBjS+ZVuq
         Q7VA==
X-Forwarded-Encrypted: i=1; AJvYcCVs931OoWOBx82/BC+UzR06+AtrPn1467vOAVnivzC+T/uaZZaAeXRkKFcJ06LWcJC+8fvCo2HrTKfjjSL01bgR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyov85oYhOk9L0D4THDDvvHdv+JDfB3BEWM0n3gy+zh1iz7XBUb
	gX9oARST4ac6nZDfa03y211hHlFb+Lu0QexqjzpZwg2H8fwp/FffvSDRrQnTDGQ9aHuh1fCPW0I
	a0cGIVA==
X-Google-Smtp-Source: AGHT+IFpNFhlI/CNVGIaK6Ib11HgYVVc8sX3OtfxqRD2FvGZdFxE8hca2Bt5p4qyWlKorL+a5Jw0t7j7k1RD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f12:b0:6e3:f32:5fc8 with SMTP id
 00721157ae682-6eaddd6a3e4mr397097b3.1.1731133133585; Fri, 08 Nov 2024
 22:18:53 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:01 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 14/22] perf env: Move arch errno function to only use in env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Move arch_syscalls__strerrno_function out of builtin-trace.c to env.c
so that there isn't a util to builtin function call. This allows the
python.c stub to be removed. Also, remove declaration/prototype from
env.h and make static to reduce scope. The include is moved inside
ifdefs to avoid, "defined but unused warnings".

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                  | 1 -
 tools/perf/trace/beauty/arch_errno_names.sh | 3 ++-
 tools/perf/util/env.c                       | 4 ++++
 tools/perf/util/env.h                       | 2 --
 tools/perf/util/python.c                    | 6 ------
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a661fbd870e7..29f64a4352dd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1108,7 +1108,6 @@ static bool syscall_arg__strtoul_btf_type(char *bf __maybe_unused, size_t size _
 	    .strtoul	= STUL_STRARRAY_FLAGS, \
 	    .parm	= &strarray__##array, }
 
-#include "trace/beauty/arch_errno_names.c"
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/futex_op.c"
 #include "trace/beauty/futex_val3.c"
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 30d3889b2957..b22890b8d272 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -57,7 +57,8 @@ create_arch_errno_table_func()
 	archlist="$1"
 	default="$2"
 
-	printf 'arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch)\n'
+	printf 'static arch_syscalls__strerrno_t *\n'
+	printf 'arch_syscalls__strerrno_function(const char *arch)\n'
 	printf '{\n'
 	for arch in $archlist; do
 		arch_str=$(arch_string "$arch")
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index ccb464026642..e58f56412fbb 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -470,6 +470,10 @@ const char *perf_env__arch(struct perf_env *env)
 	return normalize_arch(arch_name);
 }
 
+#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#include "trace/beauty/arch_errno_names.c"
+#endif
+
 const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
 {
 #if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index ae604c4edbb7..e9db89395dab 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -56,8 +56,6 @@ struct pmu_caps {
 
 typedef const char *(arch_syscalls__strerrno_t)(int err);
 
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
-
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 77e02fcc51dd..35d84a96dbec 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/env.h"
 #include "util/kwork.h"
 #include "util/sample.h"
 #include "util/lock-contention.h"
@@ -1305,11 +1304,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
-{
-	return NULL;
-}
-
 struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 				       struct kwork_class *class __maybe_unused,
 				       struct kwork_work *key  __maybe_unused)
-- 
2.47.0.277.g8800431eea-goog

