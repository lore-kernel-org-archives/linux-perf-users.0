Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16AD4EB36
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly7tgk2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC08EC433CC;
	Fri,  1 Dec 2023 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701462660;
	bh=+mj0dcN7GlPP3mSnBDcO9llFhhVlvh7EarboXmVwsd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ly7tgk2aHQCuPkEy3d0psO0fSlUxGiuY/19+2l3JKYAzw2+dgsX70kVlPH6a30e/1
	 vy04Wvgg19peOLQMUhsmQYSVibsgt7pntzMX+FnYiRJRBzpIITky3qe44wzcyvQTJN
	 CZwTwfluwXcs/fi1E/YTcXO2EfxTrQfGrOFwwsIBFXt8HAr+2a1rpRZR8Y7SSUwtcv
	 IwyzFJFKlxQ3s2mtbDD1oOP6YcLW+dyscEqSIDOVpw/I7cLBQXm5r6VYtWOp+/uy6H
	 9XmU2EtZZBpphq9sIVY4TxkWrUmLYirCv8UTSj4gJfkpLmjFFvifqBNqseggX/ZI9X
	 tELCENgp9/mrQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH 2/2] perf env: Cache the arch specific strerrno function in perf_env__arch_strerrno()
Date: Fri,  1 Dec 2023 17:30:46 -0300
Message-ID: <20231201203046.486596-3-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201203046.486596-1-acme@kernel.org>
References: <20231201203046.486596-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we don't have to go thru the series of strcmp(arch) calls for
each id -> string translation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/arch_errno_names.sh | 6 +++---
 tools/perf/trace/beauty/beauty.h            | 2 --
 tools/perf/util/env.c                       | 6 ++++--
 tools/perf/util/env.h                       | 5 +++++
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index b6e0767b4b34e46a..7df4bf5b55a3cc2a 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -57,13 +57,13 @@ create_arch_errno_table_func()
 	archlist="$1"
 	default="$2"
 
-	printf 'const char *arch_syscalls__strerrno(const char *arch, int err)\n'
+	printf 'arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch)\n'
 	printf '{\n'
 	for arch in $archlist; do
 		printf '\tif (!strcmp(arch, "%s"))\n' $(arch_string "$arch")
-		printf '\t\treturn errno_to_name__%s(err);\n' $(arch_string "$arch")
+		printf '\t\treturn errno_to_name__%s;\n' $(arch_string "$arch")
 	done
-	printf '\treturn errno_to_name__%s(err);\n' $(arch_string "$default")
+	printf '\treturn errno_to_name__%s;\n' $(arch_string "$default")
 	printf '}\n'
 }
 
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 788e8f6bd90eb753..9feb794f5c6e15f4 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -251,6 +251,4 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool sh
 void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 				    size_t (*ret_scnprintf)(char *bf, size_t size, struct syscall_arg *arg));
 
-const char *arch_syscalls__strerrno(const char *arch, int err);
-
 #endif /* _PERF_TRACE_BEAUTY_H */
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index fdd62ea00173ccf5..2845b9f4694591be 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -456,8 +456,10 @@ const char *perf_env__arch(struct perf_env *env)
 
 const char *perf_env__arch_strerrno(struct perf_env *env, int err)
 {
-	const char *arch_name = perf_env__arch(env);
-	return arch_syscalls__strerrno(arch_name, err);
+	if (env->arch_strerrno == NULL)
+		env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
+
+	return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific strerrno function";
 }
 
 const char *perf_env__cpuid(struct perf_env *env)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 79f371879f45bafc..bf7e3c4c211f971e 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -53,6 +53,10 @@ struct pmu_caps {
 	char            *pmu_name;
 };
 
+typedef const char *(arch_syscalls__strerrno_t)(int err);
+
+arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
+
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -135,6 +139,7 @@ struct perf_env {
 		 */
 		bool	enabled;
 	} clock;
+	arch_syscalls__strerrno_t *arch_strerrno;
 };
 
 enum perf_compress_type {
-- 
2.41.0

