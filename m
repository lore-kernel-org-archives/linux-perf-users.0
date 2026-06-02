Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC93F5BE9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413974; cv=none; b=COUUTTdIuYhyS7OqiYBg9EGOtXEWAaPdiPLJ6uOgZoY5LQYkU0YaNln4hCYrPca3IAzr9ToBlyzhw1Qo9CF26KyC9m8xK6pce4ScOFxDFx7mT/SJcFo/VHRW5yQlNj2rUvL0aBI6aCA9XXVjnT+PmY7ge9hTVda7dIpyaygkTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413974; c=relaxed/simple;
	bh=ogbImCbJZIA7lXP83GwEH6CI3+06smm7TRrjXInKNow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ScqNndO+ZLWwoBFmvvU4TmXBg/W3TD65tepir+sVI1ZYHJoqfeuJppqng3k6qDqMImdwDzGK/g4cbDXmfcYxMXuyeUBfNFMXJTNN/49of6W72LcVfXg5EmmVwyZW2MdWkrcDLIU0ShRwWYd+nEfid2VBfA88RQO/jmjVcfitgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6DkGDfq; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6DkGDfq"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f1820babso5367976eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413972; x=1781018772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbG72918MZZkcYCC+Pq7rtZ2nlhsMI+rthFBTDKNlsE=;
        b=e6DkGDfqqrTGOsO1XJcjWf8roRK9djwGxDUWeg1ePc6Tq0XEXyeEsEGi2/mE+f5IUf
         WQwM4L8QsXBEslXIrzvTe1V7Pr0vtidIGQLwKOITauKg0zDFKH4DxY+xi4+FPYmMeFnD
         2sDPiWKATLr/DGNtIbBdP64q4IupzyXCRXa52r1xk16jji25oFpd+JOfeuzC5X1pKdFH
         DXzZXzYxh8W4QPph8t7BiNm0vE+eap2d1wCmuGiSRN/ujGLDJBf6HCF6uY9QsedZ/KIS
         H22MxIbanxOqQdxAzuvnoEKYk7wxtfv6ysw3i/b1wwoHfBgBTAhPzd8sxYuKn7ycvfD2
         GhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413972; x=1781018772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbG72918MZZkcYCC+Pq7rtZ2nlhsMI+rthFBTDKNlsE=;
        b=JbXIGA8yuahMYmOUoiD/XgHdTZDCgMkVUsqB9HgjSHD5b6AQcKxtykSeKtnTiQa/dj
         kaFMgmAkfnsw/2FsCwY/Wia8bAAgmDklv/Ee5oEyTEWBvgzntfegbKoP3Y1T55xydGZ+
         9k2g4Q84eCEnfwVBUoKbhl+4eDNB4R9mTUIS22C2ABxQhZ3IIvgkgz/6zh3DlJNWVfqp
         t3z9O03hbx+MfZhsagP9GOLm9u7S5PmLAhGKwl0Esa7fAGrX+DvbtNnTqtsckcESe2yQ
         dGTMgaaHviv8PveXUox4j0DsMEzoIg6KzuXYmv08vXNQb4lhX0tjTJY2uD2MlNNbQPHj
         lYww==
X-Forwarded-Encrypted: i=1; AFNElJ/qxsC6h4A2F31AaZGPcD6V1onEFVX+6MtdaO9Glucf0rCBRP6rjKzk/xEzOFxJKA+me6SMkkDIgoBupJH5W2bX@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnmNkwcMFfPEvV3mUIHOeixHxzXQJI8LIlP6I06LN6G1Up357
	Tzm5hE9NJFIAhTT6UP6KX+uv12z0XvJVKzBCeCRMdR+MiMVRf60mR1VQv1v9tF5Z6Y8NyBEy0+X
	R5QwAuNJJkg==
X-Received: from dybry9.prod.google.com ([2002:a05:7301:4d09:b0:304:d831:cdfc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c84:b0:2ea:ed70:3ea8
 with SMTP id 5a478bee46e88-304fa6939demr7896561eec.29.1780413971734; Tue, 02
 Jun 2026 08:26:11 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:11 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-15-irogers@google.com>
Subject: [PATCH v12 14/19] perf env: Refactor perf_env__arch_strerrno
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The previous approach maps an architecture string to a function
pointer to a function that takes an int errno value and returns a
string. The new approach takes an e_machine and an errno value and
returns a string.

As the only call site is in builtin-trace.c, the e_machine is already
present and potentially more specific than the perf_env arch string
that is a single global value.

Since the errno-to-name mapping is now generated statically and no
longer depends on libtraceevent, we can remove the HAVE_LIBTRACEEVENT
guards entirely, making perf_env__arch_strerrno unconditionally
available.

The major complication in this approach is having the shell script
that generates the C code map a linux directory name to the matching
ELF machine constants. To ensure compatibility with older hosts that
have older glibc versions, output fallback definitions for newer ELF
machine constants (EM_AARCH64, EM_CSKY, EM_LOONGARCH) if they are not
defined in the system <elf.h>.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                  |  7 +--
 tools/perf/trace/beauty/Build               |  1 +
 tools/perf/trace/beauty/arch_errno_names.sh | 53 +++++++++++++++++++--
 tools/perf/util/env.c                       | 13 ++---
 tools/perf/util/env.h                       |  6 +--
 5 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2530b4035e4f..377f0a18b00e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3032,9 +3032,8 @@ static int trace__sys_exit(struct trace *trace,
 	} else if (ret < 0) {
 errno_print: {
 		char bf[STRERR_BUFSIZE];
-		struct perf_env *env = evsel__env(evsel) ?: &trace->host_env;
 		const char *emsg = str_error_r(-ret, bf, sizeof(bf));
-		const char *e = perf_env__arch_strerrno(env, err);
+		const char *e = perf_env__arch_strerrno(e_machine, err);
 
 		fprintf(trace->output, "-1 %s (%s)", e, emsg);
 	}
@@ -4921,7 +4920,9 @@ static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
 
 				for (e = 0; e < stats->max_errno; ++e) {
 					if (stats->errnos[e] != 0)
-						fprintf(fp, "\t\t\t\t%s: %d\n", perf_env__arch_strerrno(trace->host->env, e + 1), stats->errnos[e]);
+						fprintf(fp, "\t\t\t\t%s: %d\n",
+							perf_env__arch_strerrno(e_machine, e + 1),
+							stats->errnos[e]);
 				}
 			}
 			lines++;
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 996e63cdf765..bf9553f683f8 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -36,6 +36,7 @@ perf-y += signum.o
 perf-y += socket_type.o
 perf-y += waitid_options.o
 perf-util-y += arch_errno_names.o
+
 perf-y += tracepoints/
 
 ifdef SHELLCHECK
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index d48d8561a7bb..8751bfa4a2b2 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -52,21 +52,50 @@ process_arch()
 		|IFS=, create_errno_lookup_func "$arch"
 }
 
+arch_to_e_machine()
+{
+	case "$1" in
+	alpha)      printf '\tcase EM_ALPHA:\n' ;;
+	arc)        printf '\tcase EM_ARC:\n' ;;
+	arm)        printf '\tcase EM_ARM:\n' ;;
+	arm64)      printf '\tcase EM_AARCH64:\n' ;;
+	csky)       printf '\tcase EM_CSKY:\n' ;;
+	hexagon)    printf '\tcase EM_HEXAGON:\n' ;;
+	loongarch)  printf '\tcase EM_LOONGARCH:\n' ;;
+	microblaze) printf '\tcase EM_MICROBLAZE:\n' ;;
+	mips)       printf '\tcase EM_MIPS:\n' ;;
+	parisc)     printf '\tcase EM_PARISC:\n' ;;
+	powerpc)    printf '\tcase EM_PPC:\n\tcase EM_PPC64:\n' ;;
+	riscv)      printf '\tcase EM_RISCV:\n' ;;
+	s390)       printf '\tcase EM_S390:\n' ;;
+	sh)         printf '\tcase EM_SH:\n' ;;
+	sparc)      printf '\tcase EM_SPARC:\n\tcase EM_SPARCV9:\n' ;;
+	x86)        printf '\tcase EM_386:\n\tcase EM_X86_64:\n' ;;
+	xtensa)     printf '\tcase EM_XTENSA:\n' ;;
+	esac
+}
+
 create_arch_errno_table_func()
 {
 	archlist="$1"
 	default="$2"
 
-	printf 'arch_syscalls__strerrno_t *\n'
-	printf 'arch_syscalls__strerrno_function(const char *arch)\n'
+	printf 'const char *arch_syscalls__strerrno(uint16_t e_machine, int err);\n\n'
+	printf '__attribute__((unused)) const char *\n'
+	printf 'arch_syscalls__strerrno(uint16_t e_machine, int err)\n'
 	printf '{\n'
+	printf '\tswitch (e_machine) {\n'
 	for arch in $archlist; do
 		arch_str=$(arch_string "$arch")
-		printf '\tif (!strcmp(arch, "%s"))\n' "$arch_str"
-		printf '\t\treturn errno_to_name__%s;\n' "$arch_str"
+		ems=$(arch_to_e_machine "$arch_str")
+		if [ -n "$ems" ]; then
+			printf '%s\n' "$ems"
+			printf '\t\treturn errno_to_name__%s(err);\n' "$arch_str"
+		fi
 	done
 	arch_str=$(arch_string "$default")
-	printf '\treturn errno_to_name__%s;\n' "$arch_str"
+	printf '\tdefault:\n\t\treturn errno_to_name__%s(err);\n' "$arch_str"
+	printf '\t}\n'
 	printf '}\n'
 }
 
@@ -74,6 +103,20 @@ cat <<EoHEADER
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <string.h>
+#include <stdint.h>
+#include <elf.h>
+
+#ifndef EM_AARCH64
+#define EM_AARCH64	183
+#endif
+
+#ifndef EM_CSKY
+#define EM_CSKY		252
+#endif
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH	258
+#endif
 
 EoHEADER
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index fae70b07ba8d..b41562fb06c6 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -851,16 +851,11 @@ const char *perf_env__arch(struct perf_env *env)
 	return arch;
 }
 
-const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
-{
-#if defined(HAVE_LIBTRACEEVENT)
-	if (env->arch_strerrno == NULL)
-		env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
+const char *arch_syscalls__strerrno(uint16_t e_machine, int err);
 
-	return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific strerrno function";
-#else
-	return "!HAVE_LIBTRACEEVENT";
-#endif
+const char *perf_env__arch_strerrno(uint16_t e_machine, int err)
+{
+	return arch_syscalls__strerrno(e_machine, err);
 }
 
 const char *perf_env__cpuid(struct perf_env *env)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index dd9907dbc345..5a917271ca0d 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -67,8 +67,6 @@ struct cpu_domain_map {
 	struct domain_info	**domains;
 };
 
-typedef const char *(arch_syscalls__strerrno_t)(int err);
-
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -158,7 +156,6 @@ struct perf_env {
 		 */
 		bool	enabled;
 	} clock;
-	arch_syscalls__strerrno_t *arch_strerrno;
 };
 
 enum perf_compress_type {
@@ -191,8 +188,7 @@ void cpu_cache_level__free(struct cpu_cache_level *cache);
 uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags);
 uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
-const char *perf_env__arch_strerrno(struct perf_env *env, int err);
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
+const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 const char *perf_env__cpuid(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
-- 
2.54.0.929.g9b7fa37559-goog

