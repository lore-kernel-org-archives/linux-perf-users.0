From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/28] perf augmented_syscalls: Remove needless linux/socket.h include
Date: Thu, 22 Nov 2018 00:35:46 -0300
Message-ID: <20181122033611.15890-4-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Leftover from when we started augmented_raw_syscalls.c from
tools/perf/examples/bpf/augmented_syscalls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: e58a0322dbac ("perf examples bpf: Start augmenting raw_syscalls:sys_{start,exit}")
Link: https://lkml.kernel.org/n/tip-pmts9ls2skh8n3zisb4txudd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 2feb00018f79..ec109c12ff24 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -16,7 +16,6 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include <linux/socket.h>
 
 /* bpf-output associated map */
 struct bpf_map SEC("maps") __augmented_syscalls__ = {
-- 
2.14.5
