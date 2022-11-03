Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0476C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 04:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKCEzY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 00:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiKCEzO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 00:55:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0817E1E
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 21:55:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3697bd55974so8558307b3.15
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 21:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+kjIEex1IOYklacrKrannRwY39rvITMzPAwz++9RgI=;
        b=MbZZjsEj3+nFozyRBV019hV+y7Be8O3uF+CKCcqtsrqy27tDZlQtVy5xGmpuE4sxQr
         RcWvOZrouGE58XuTg9LRy5Ry96JSoAtsD3bWe+ir4DpZ+CjmF8MQVmYxxNitL0J+8I32
         rtYVCyV/H6PsZ8rN4U2y5Wjcxxi8rMElcx3y4uaqv5jZXnbv42X8Zwy8G5D7tMf5+Je5
         gG71UwrCBg0wr+C1cvunD6WWaDQxdkGUuODvKNvuVffSEL2MHbpYxMQY1lj6Zp7439nt
         RP75mbPe86+o4fWsMvIjP4csuuRqXhxHEJz8xH/VSyaqVx/jali+oZEwThtoh9z4B8by
         n4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+kjIEex1IOYklacrKrannRwY39rvITMzPAwz++9RgI=;
        b=s38YmNufJf6ghWQOvyGRpiTGW0qnqH9593D3V3T9y8s22/ajxrJBLZOxSzfWcNJ+Hf
         lNKEnA9kaSDplMmEyPhqnY60QtZz2ARO/r2WPdV6iWqYszc2ACQRoDCIyw5flh094mwC
         vGvzgNa5Pt73Y86WIZapNdTtJ9xA41oKMQJCZKvoUHUm7s5UQ/gukYEKNVCOPkX4Mnjt
         WDA2nvUXbEqCND0hGNWu2VVGdnzJtDgoBansADzv6tdq6riJctIKXMXYvB+Lc6ygXEAB
         JrB9yB5yECNzF4PTjRfrJjYxJYgPJsw1vq8dtcQ+6FaXqduVs/uLqbGj1z/GET5rCEbs
         xxNA==
X-Gm-Message-State: ACrzQf3qP1G5A3DQbdtnP77olgnsfYgk6SsO+bFb4JEhWdZl50/ZWacx
        DQwogeLrogdz0h4oOXhC0HlVJqoVTa8x
X-Google-Smtp-Source: AMsMyM4iIn9a02aMdt6yZsX7DM1HL5tNqHhhuvpC8PkwISePPR39xcxiulhZgC0WZUUsv8vdSfkf2rcek0s5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a0d:d84c:0:b0:36b:40f4:7989 with SMTP id
 a73-20020a0dd84c000000b0036b40f47989mr26806136ywe.432.1667451311498; Wed, 02
 Nov 2022 21:55:11 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:33 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-4-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 3/7] perf trace: Augmented syscalls fix libbpf 1.0+ compatibility
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Don't use deprecated and now broken map style. Avoid use of
tools/perf/include/bpf/bpf.h and use the more regular BPF headers.
Add "< 0" checks to fix BPF verifier failures about potentially
negative values being passed to bpf_perf_event_output replacing an
existing mask. Add a raw_syscalls:sys_enter to avoid the evlist being
empty and causing perf trace to exit during argument parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 58 ++++++++++++++------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 524fdb8534b3..a809e1eab95d 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -16,11 +16,17 @@
  * contents of pointer arguments.
  */
 
-#include <stdio.h>
-#include <linux/socket.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <sys/socket.h>
 
 /* bpf-output associated map */
-bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
+struct __augmented_syscalls__ {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, __u32);
+	__uint(max_entries, __NR_CPUS__);
+} __augmented_syscalls__ SEC(".maps");
 
 struct syscall_exit_args {
 	unsigned long long common_tp_fields;
@@ -34,6 +40,12 @@ struct augmented_filename {
 	char		value[256];
 };
 
+#define syscall_enter(name)						\
+	SEC("!syscalls:sys_enter_" #name) syscall_enter_ ## name
+
+#define syscall_exit(name)					\
+	SEC("!syscalls:sys_exit_" #name) syscall_exit_ ## name
+
 #define augmented_filename_syscall(syscall)							\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
@@ -42,18 +54,23 @@ struct augmented_enter_##syscall##_args {			 				\
 int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 {												\
 	struct augmented_enter_##syscall##_args augmented_args = { .filename.reserved = 0, }; 	\
-	unsigned int len = sizeof(augmented_args);						\
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
-	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value, 		\
+	long size;										\
+												\
+	if (bpf_probe_read(&augmented_args.args, sizeof(augmented_args.args), args) < 0)	\
+		return -1;									\
+												\
+	size = bpf_probe_read_str(&augmented_args.filename.value,				\
 						      sizeof(augmented_args.filename.value), 	\
 						      args->filename_ptr); 			\
-	if (augmented_args.filename.size < sizeof(augmented_args.filename.value)) {		\
-		len -= sizeof(augmented_args.filename.value) - augmented_args.filename.size;	\
-		len &= sizeof(augmented_args.filename.value) - 1;				\
-	}											\
+	if (size < 0)										\
+		return -1;									\
+												\
+	augmented_args.filename.size = size;							\
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */	\
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 		\
-				 &augmented_args, len);						\
+	return bpf_perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,		\
+				 &augmented_args,						\
+				 (sizeof(augmented_args) - sizeof(augmented_args.filename.value) + \
+				 size));				\
 }												\
 int syscall_exit(syscall)(struct syscall_exit_args *args)					\
 {												\
@@ -106,7 +123,7 @@ augmented_filename_syscall(newstat);
 #define _K_SS_MAXSIZE 128
 #endif
 
-#define augmented_sockaddr_syscall(syscall)						\
+#define augmented_sockaddr_syscall(syscall)							\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct sockaddr_storage			addr;						\
@@ -115,14 +132,14 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 {												\
 	struct augmented_enter_##syscall##_args augmented_args;				 	\
 	unsigned long addrlen = sizeof(augmented_args.addr);					\
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
+	bpf_probe_read(&augmented_args.args, sizeof(augmented_args.args), args);		\
 /* FIXME_CLANG_OPTIMIZATION_THAT_ACCESSES_USER_CONTROLLED_ADDRLEN_DESPITE_THIS_CHECK */		\
 /*	if (addrlen > augmented_args.args.addrlen)				     */		\
 /*		addrlen = augmented_args.args.addrlen;				     */		\
 /*										     */		\
-	probe_read(&augmented_args.addr, addrlen, args->addr_ptr); 				\
+	bpf_probe_read(&augmented_args.addr, addrlen, args->addr_ptr);				\
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */	\
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 		\
+	return bpf_perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,		\
 				 &augmented_args, 						\
 				sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);\
 }												\
@@ -166,4 +183,11 @@ struct syscall_enter_sendto_args {
 
 augmented_sockaddr_syscall(sendto);
 
-license(GPL);
+struct syscall_enter_args;
+
+SEC("raw_syscalls:sys_enter")
+int sys_enter(struct syscall_enter_args *args)
+{
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
-- 
2.38.1.273.g43a17bfeac-goog

