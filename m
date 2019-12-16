From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/9] perf top: Do not bail out when perf_env__read_cpuid() returns ENOSYS
Date: Mon, 16 Dec 2019 17:47:32 -0300
Message-ID: <20191216204738.12107-4-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, John Garry <john.garry@huawei.com>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Will Deacon <will@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

'perf top' stopped working on hw architectures that do not provide a
get_cpuid() implementation and thus fallback to the weak get_cpuid()
default function.

This is done because at annotation time we may need it in the arch
specific annotation init routine, but that is only being used by arches
that do provide a get_cpuid() implementation:

  $ find tools/  -name "*.[ch]" | xargs grep 'evlist->env'
  tools/perf/builtin-top.c:	top.evlist->env = &perf_env;
  tools/perf/util/evsel.c:		return evsel->evlist->env;
  tools/perf/util/s390-cpumsf.c:	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
  tools/perf/util/header.c:	session->evlist->env = &header->env;
  tools/perf/util/sample-raw.c:	const char *arch_pf = perf_env__arch(evlist->env);
  $

  $ find tools/perf/arch  -name "*.[ch]" | xargs grep -w get_cpuid
  tools/perf/arch/x86/util/auxtrace.c:	ret = get_cpuid(buffer, sizeof(buffer));
  tools/perf/arch/x86/util/header.c:get_cpuid(char *buffer, size_t sz)
  tools/perf/arch/powerpc/util/header.c:get_cpuid(char *buffer, size_t sz)
  tools/perf/arch/s390/util/header.c: * Implementation of get_cpuid().
  tools/perf/arch/s390/util/header.c:int get_cpuid(char *buffer, size_t sz)
  tools/perf/arch/s390/util/header.c:	if (buf && get_cpuid(buf, 128))
  $

For 'report' or 'script', i.e. tools working on perf.data files, that is
setup while reading the header, its just top that needs to explicitely
read it at tool start.

Fixes: 608127f73779 ("perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine")
Reported-by: John Garry <john.garry@huawei.com>
Analysed-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: John Garry <john.garry@huawei.com> # arm64
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index dc80044bc46f..795e353de095 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1568,9 +1568,13 @@ int cmd_top(int argc, const char **argv)
 	 */
 	status = perf_env__read_cpuid(&perf_env);
 	if (status) {
-		pr_err("Couldn't read the cpuid for this machine: %s\n",
-		       str_error_r(errno, errbuf, sizeof(errbuf)));
-		goto out_delete_evlist;
+		/*
+		 * Some arches do not provide a get_cpuid(), so just use pr_debug, otherwise
+		 * warn the user explicitely.
+		 */
+		eprintf(status == ENOSYS ? 1 : 0, verbose,
+			"Couldn't read the cpuid for this machine: %s\n",
+			str_error_r(errno, errbuf, sizeof(errbuf)));
 	}
 	top.evlist->env = &perf_env;
 
-- 
2.21.0
