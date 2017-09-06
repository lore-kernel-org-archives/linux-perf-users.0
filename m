From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf tests: fix compile when libunwind's unwind.h is available
Date: Wed,  6 Sep 2017 17:02:09 +0200
Message-ID: <20170906150209.12579-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

When cross compiling perf and I want to link against a self-compiled
libunwind, I usually make the custom path where the libunwind headers
exist visible by adding the libunwind prefix to the include path when
compiling perf, i.e.:

~~~~~
$ ls $HOME/projects/compiled/other/include/
libunwind-coredump.h  libunwind.h         libunwind-x86_64.h
libunwind-common.h  libunwind-dynamic.h   libunwind-ptrace.h
unwind.h
$ make EXTRA_CFLAGS="-I$HOME/projects/compiled/other/include/
~~~~~~

Note the `unwind.h` header from libunwind which leads to compile
errors when compiling tests/dwarf-unwind.c, since it shadows perf's
util/unwind.h:

~~~~~
tests/dwarf-unwind.c:41:32: error: ‘struct unwind_entry’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
 static int unwind_entry(struct unwind_entry *entry, void *arg)
                                ^~~~~~~~~~~~
tests/dwarf-unwind.c: In function ‘unwind_entry’:
tests/dwarf-unwind.c:44:22: error: dereferencing pointer to incomplete type ‘struct unwind_entry’
  char *symbol = entry->sym ? entry->sym->name : NULL;
                      ^~
tests/dwarf-unwind.c: In function ‘unwind_thread’:
tests/dwarf-unwind.c:92:8: error: implicit declaration of function ‘unwind__get_entries’; did you mean ‘unwind_entry’? [-Werror=implicit-function-declaration]
  err = unwind__get_entries(unwind_entry, &cnt, thread,
        ^~~~~~~~~~~~~~~~~~~
        unwind_entry
tests/dwarf-unwind.c:92:8: error: nested extern declaration of ‘unwind__get_entries’ [-Werror=nested-externs]
~~~~~~

Fix this compile error by specificing an explicit include of perf's
unwind.h in the util folder.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/dwarf-unwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 2a7b9b47bbcb..9ba1d216a89f 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -6,7 +6,7 @@
 #include "debug.h"
 #include "machine.h"
 #include "event.h"
-#include "unwind.h"
+#include "../util/unwind.h"
 #include "perf_regs.h"
 #include "map.h"
 #include "thread.h"
-- 
2.14.1
