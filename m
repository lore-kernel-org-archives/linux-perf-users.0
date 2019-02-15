From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/43] tools build feature sched_getcpu: Undef _GNU_SOURCE at the end
Date: Thu, 14 Feb 2019 21:45:39 -0300
Message-ID: <20190215004539.23571-44-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <jakub.kicinski@netronome.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since this feature test is included in test-all.c, the feature detection
fast path compile/link phase, it can't leave any defines behind, as it
can affect the tests included after it, so remove it.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-lg3kpd9tzypc797vb1f42u6k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-sched_getcpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/build/feature/test-sched_getcpu.c b/tools/build/feature/test-sched_getcpu.c
index e448deb4124c..48995ac7911e 100644
--- a/tools/build/feature/test-sched_getcpu.c
+++ b/tools/build/feature/test-sched_getcpu.c
@@ -8,3 +8,5 @@ int main(void)
 {
 	return sched_getcpu();
 }
+
+#undef _GNU_SOURCE
-- 
2.19.1
