Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC461531DB
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979086; cv=none; b=hCNaMKN1jErcYZOtYofxiwiui3EPA5X9AvSjcwJKh2gmfWaqZv+XfqiMfmyfV4epRjojsjNX3tLBbJp5SumEYBiJPdq8GS5SizARhCK0gxoJ7V+lOiPDX3kBxiCCo+xoLYQeWzCMeJpHZ4+4z+y8mf4WDTJrH/B4KwmSIn6RR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979086; c=relaxed/simple;
	bh=iQQ3LZc5mw/4GGxCxzUwJSue+pQgAU0DqQT/hnMD0RM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=UNfeScK5PlFhjdTojgC1+j2PAA6rG8jNzP515lTIRf2ukM10xwzxf+HIccP2xof57LycKc5u9lH5+sQAkrnsd21CKpp9ecFa2g9GaoY2eZXGHMyDel469PU8kw9SgDlRWCvokv8GjVeMR8v2lT8PYrH5wzah2jVAZk2GiyT84zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/L6gwpu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/L6gwpu"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso480152276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979084; x=1732583884; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ExKOlmjeTcZeT9jR1UaHUCOwESnyQFe7AeKOMV0tEs=;
        b=d/L6gwpuvPVgrx9+8UOYOxvcnc+bdB50I+4ehs7uJAD7s0qbMDtm0TFdxkUxbZw8zI
         GlL0QAmVDD5X76MKsU4hO0VuGqZfnRc8aakz/0JdKWzYfdtqPXWP8BlnBjbWUM6xiNON
         HU8OaRx6ITpjZZ1fXS470qJOvNglEx0lR/QD2hAi9qF1CCo+sKSyU3IqtR8HPKv/OsZE
         MuKNFlemXt00FLJWN2q1UU8zDT0n3xZ5yEhd6Ki+JySg4dpXkUq2G7UwjVGQGCFoZj3w
         PuCz8DmloKGruuE+lhGi2n7FfkEXccrGpYljlE4wL8MkT/lsqahIw1ZTLg/LWHRQk/LZ
         ye3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979084; x=1732583884;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ExKOlmjeTcZeT9jR1UaHUCOwESnyQFe7AeKOMV0tEs=;
        b=OmNPfQj8ILGcrtNkvVnw5wqFp8FlIqgeoGVhYtCXnprjB0odqKWyWWnO1R4AHDowFy
         p7KnA06ckqjDqRJ5JL8LJ7CAIA36TPLS0iUWRM2fzl6eip/EaZIe9Jdjq1v8wPtFTMOv
         wfDWlClEEI9oFDsZMHSY8hOlfe1lwj84b9DJDgzxPhAsshxEQGHol/vI6ijnKbJlH594
         oKTv5hT35CSL9QFRSaFz/JkfveH+5m7WUStdtdLjGhKVQl9jfk+X3kyS4izJeZJg+jbg
         SDluv/G372WUuh5QE4/ydHkng+TZqsfFGU9T/nkxwfhQeeK5u/oQKc1cIQ68Nedxu4/I
         P8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVYvjZZ8SlGIZCh1tmx4d0FmC/Orm4sOesqVyc+oF9QDsp7qoDeGnYXLpkRD0NwqE09BINrVYsHUH5hk1yFDCX+@vger.kernel.org
X-Gm-Message-State: AOJu0YybgUONlgOF4MkHydjVbYzcFf6g2ChAQ24rdbneMmw03i6cJXK6
	xApAliTB/1r7OGOsEONvXX6CMqUr28dn0VbAatmjH2ZQ07SGLMfVIPdxPveJpfkNV6FxyCS1/Ks
	32Dyppw==
X-Google-Smtp-Source: AGHT+IHknBE0CtdUZdBequM0Ds1bydaymw8JachJZLvYhBrKfvT3sy/fvW2m74vrT7SCYwHMbLUjBXssdWoG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:5087:b0:6e3:1627:e866 with SMTP
 id 00721157ae682-6ee55c86077mr2811997b3.3.1731979084173; Mon, 18 Nov 2024
 17:18:04 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:36 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 14/22] perf env: Move arch errno function to only use in env
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
index 6a1a128fe645..d24ae46573b6 100644
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
index e2843ca2edd9..2238ae82ea70 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -472,6 +472,10 @@ const char *perf_env__arch(struct perf_env *env)
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
index fa3ab954662c..fa25e7ed8a7f 100644
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
2.47.0.338.g60cca15819-goog

