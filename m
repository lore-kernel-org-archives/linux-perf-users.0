From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/21] perf bpf: Include uapi/linux/bpf.h from the 'perf trace' script's bpf.h
Date: Wed,  1 Aug 2018 18:36:47 -0300
Message-ID: <20180801213648.4814-21-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The next example scripts need the definition for the BPF functions, i.e.
things like BPF_FUNC_probe_read, and in time will require lots of other
definitions found in uapi/linux/bpf.h, so include it from the bpf.h file
included from the eBPF scripts build with clang via '-e bpf_script.c'
like in this example:

  $ tail -8 tools/perf/examples/bpf/5sec.c
  #include <bpf.h>

  int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
  {
	return sec == 5;
  }

  license(GPL);
  $

That 'bpf.h' include in the 5sec.c eBPF example will come from a set of
header files crafted for building eBPF objects, that in a end-user
system will come from:

  /usr/lib/perf/include/bpf/bpf.h

And will include <uapi/linux/bpf.h> either from the place where the
kernel was built, or from a kernel-devel rpm package like:

  -working-directory /lib/modules/4.17.9-100.fc27.x86_64/build

That is set up by tools/perf/util/llvm-utils.c, and can be overriden
by setting the 'kbuild-dir' variable in the "llvm" ~/.perfconfig file,
like:

  # cat ~/.perfconfig
  [llvm]
       kbuild-dir = /home/foo/git/build/linux

This usually doesn't need any change, just documenting here my findings
while working with this code.

In the future we may want to instead just use what is in
/usr/include/linux/bpf.h, that comes from the UAPI provided from the
kernel sources, for now, to avoid getting the kernel's non-UAPI
"linux/bpf.h" file, that will cause clang to fail and is not what we
want anyway (no BPF function definitions, etc), do it explicitely by
asking for "uapi/linux/bpf.h".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zd8zeyhr2sappevojdem9xxt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index dd764ad5efdf..a63aa6241b7f 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #ifndef _PERF_BPF_H
 #define _PERF_BPF_H
+
+#include <uapi/linux/bpf.h>
+
 #define SEC(NAME) __attribute__((section(NAME),  used))
 
 #define probe(function, vars) \
-- 
2.14.4
