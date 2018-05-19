From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/18] perf bpf: Fixup include and examples install messages
Date: Sat, 19 May 2018 07:55:05 -0300
Message-ID: <20180519105507.16450-17-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

  INSTALL  lib
install include/bpf/*.h '/home/acme/lib/include/perf/bpf'
  INSTALL  lib
install examples/bpf/*.c '/home/acme/lib/examples/perf/bpf'

After:

  INSTALL  lib
  INSTALL  include/bpf
  INSTALL  lib
  INSTALL  examples/bpf

Reported-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: dd8e4ead6e98 ("perf bpf: Add bpf.h to be used in eBPF proggies")
Fixes: 8f12a2ff00e5 ("perf bpf: Add 'examples' directories")
Link: https://lkml.kernel.org/n/tip-icljqe87e8pak8mu6mkki9d4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c63a3971d719..ecc9fc952655 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -770,9 +770,11 @@ endif
 ifndef NO_LIBBPF
 	$(call QUIET_INSTALL, lib) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, include/bpf) \
 		$(INSTALL) include/bpf/*.h '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
 	$(call QUIET_INSTALL, lib) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, examples/bpf) \
 		$(INSTALL) examples/bpf/*.c '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
 endif
 	$(call QUIET_INSTALL, perf-archive) \
-- 
2.14.3
