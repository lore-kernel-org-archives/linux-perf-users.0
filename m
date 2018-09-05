From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/77] perf trace augmented_syscalls: Rename augmented_*_syscall__enter to just *_syscall
Date: Wed,  5 Sep 2018 19:03:46 -0300
Message-ID: <20180905220440.20256-24-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As we'll also hook into the syscalls:sys_exit_SYSCALL for which there
are enter hooks.

This way we'll be able to iterate the ELF file for the eBPF program,
find the syscalls that have hooks and filter them out from the general
raw_syscalls:sys_{enter,exit} tracepoint for not-yet-augmented (the ones
with pointer arguments not yet being attached to the usual syscalls
tracepoint payload) and non augmentable syscalls (syscalls without
pointer arguments).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-cl1xyghwb1usp500354mv37h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index bfa28eaf27b3..253b3ccbd17d 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -32,7 +32,7 @@ struct augmented_filename {
 	char	value[256];
 };
 
-#define augmented_filename_syscall_enter(syscall)						\
+#define augmented_filename_syscall(syscall)							\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct augmented_filename		filename;				 	\
@@ -60,7 +60,7 @@ struct syscall_enter_openat_args {
 	long		   mode;
 };
 
-augmented_filename_syscall_enter(openat);
+augmented_filename_syscall(openat);
 
 struct syscall_enter_open_args {
 	unsigned long long common_tp_fields;
@@ -70,7 +70,7 @@ struct syscall_enter_open_args {
 	long		   mode;
 };
 
-augmented_filename_syscall_enter(open);
+augmented_filename_syscall(open);
 
 struct syscall_enter_inotify_add_watch_args {
 	unsigned long long common_tp_fields;
@@ -80,7 +80,7 @@ struct syscall_enter_inotify_add_watch_args {
 	long		   mask;
 };
 
-augmented_filename_syscall_enter(inotify_add_watch);
+augmented_filename_syscall(inotify_add_watch);
 
 struct statbuf;
 
@@ -91,13 +91,13 @@ struct syscall_enter_newstat_args {
 	struct stat	   *statbuf;
 };
 
-augmented_filename_syscall_enter(newstat);
+augmented_filename_syscall(newstat);
 
 #ifndef _K_SS_MAXSIZE
 #define _K_SS_MAXSIZE 128
 #endif
 
-#define augmented_sockaddr_syscall_enter(syscall)						\
+#define augmented_sockaddr_syscall(syscall)						\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct sockaddr_storage			addr;						\
@@ -128,7 +128,7 @@ struct syscall_enter_bind_args {
 	unsigned long	   addrlen;
 };
 
-augmented_sockaddr_syscall_enter(bind);
+augmented_sockaddr_syscall(bind);
 
 struct syscall_enter_connect_args {
 	unsigned long long common_tp_fields;
@@ -138,7 +138,7 @@ struct syscall_enter_connect_args {
 	unsigned long	   addrlen;
 };
 
-augmented_sockaddr_syscall_enter(connect);
+augmented_sockaddr_syscall(connect);
 
 struct syscall_enter_sendto_args {
 	unsigned long long common_tp_fields;
@@ -151,6 +151,6 @@ struct syscall_enter_sendto_args {
 	long		   addr_len;
 };
 
-augmented_sockaddr_syscall_enter(sendto);
+augmented_sockaddr_syscall(sendto);
 
 license(GPL);
-- 
2.14.4
