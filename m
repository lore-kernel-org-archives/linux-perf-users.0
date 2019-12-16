From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/9] perf arch: Make the default get_cpuid() return compatible error
Date: Mon, 16 Dec 2019 17:47:31 -0300
Message-ID: <20191216204738.12107-3-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Mark Rutland <mark.rutland@arm.com>, John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Will Deacon <will@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Some of the functions calling get_cpuid() propagate back the error it
returns, and all are using errno (positive) values, make the weak
default get_cpuid() function return ENOSYS to be consistent and to allow
checking if this is an arch not providing this function or if a provided
one is having trouble getting the cpuid, to decide if the warning should
be provided to the user or just a debug message should be emitted.

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
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index becc2d109423..4d39a75551a0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -850,7 +850,7 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
  */
 int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
 {
-	return -1;
+	return ENOSYS; /* Not implemented */
 }
 
 static int write_cpuid(struct feat_fd *ff,
-- 
2.21.0
