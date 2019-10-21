From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 54/57] libbeauty: Make the mmap_flags strarray visible outside of its beautifier
Date: Mon, 21 Oct 2019 10:38:31 -0300
Message-ID: <20191021133834.25998-55-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can later use it with the strarray__strtoul_flags() routine
that will be soon introduced.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vldj3ch8su6i20to5eq31e8x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 859a8a9db2c6..9fa771a90d79 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -33,11 +33,11 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 
 #define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot
 
-static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
-{
 #include "trace/beauty/generated/mmap_flags_array.c"
        static DEFINE_STRARRAY(mmap_flags, "MAP_");
 
+static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
        return strarray__scnprintf_flags(&strarray__mmap_flags, bf, size, show_prefix, flags);
 }
 
-- 
2.21.0
