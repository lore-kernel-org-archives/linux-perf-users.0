From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/12] perf beauty sockaddr: Fix augmented syscall format warning
Date: Thu, 16 Jan 2020 10:48:12 -0300
Message-ID: <20200116134814.8811-11-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Cengiz Can <cengiz@kernel.wtf>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Cengiz Can <cengiz@kernel.wtf>

The sockaddr related examples given in
`tools/perf/examples/bpf/augmented_syscalls.c` almost always use `long`s
to represent most of their fields.

However, `size_t syscall_arg__scnprintf_sockaddr(..)` has a `scnprintf`
call that uses `"%#x"` as format string.

This throws a warning (whenever the syscall argument is `unsigned
long`).

Added `l` identifier to indicate that the `arg->value` is an unsigned
long.

Not sure about the complications of this with x86 though.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200113174438.102975-1-cengiz@kernel.wtf
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/sockaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index 173c8f760763..e0c13e6a5788 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -72,5 +72,5 @@ size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg
 	if (arg->augmented.args)
 		return syscall_arg__scnprintf_augmented_sockaddr(arg, bf, size);
 
-	return scnprintf(bf, size, "%#x", arg->val);
+	return scnprintf(bf, size, "%#lx", arg->val);
 }
-- 
2.21.1
