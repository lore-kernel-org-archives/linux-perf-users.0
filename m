Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E40244EA1
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485238; cv=none; b=jFcUhbDjUMOYAmeiddyuFh9H1XL3+ynqjg7JJSbOMrl9qxTYS4skO7oSungoduf0ycpy17XeigEqeziCN7pIVjMKc57xzWUfxkk/Nia3qf97tm7eEo7PbkGYFLT1P29AJC0KfgreEJde/JbLiI68WBUouSlwJb8ZQBcc4Kp7fNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485238; c=relaxed/simple;
	bh=xXV+mD9P20qcxx12jKhuzGdRXrAXqtIKrJ86d1mcirE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3vANssZSqoqPi/lOP6csTMpf3bLWiyjWzVabDEZQrpDiQH1bOrwicbExONiWZw8CnjyyxWyzEhkVYlhGRA4R2QdiyQntvFCjAfiQ34d++5Mqtm0eGyZyPhkUPs4JJC8wbfX1QJWBOQJ/Y1goXmJ5RAdMEAW5WCl2fH+vxtW4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbRcXTf1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbRcXTf1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754485234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=648BoZ6XUs9/Wk59p7dCoGBCyNzwgD9DBIqZM2kcsG8=;
	b=NbRcXTf1VsZP0XDfJ9oPR07M7OKpQ1qmAr7fp0Np7rDPoyc/zycpub1Kovz9ZzDi22AlOM
	KDndv606KiT0qccVsSkTbXGAscW2Bf2pNB7EH0HmVapJ20Hxj/HdXwSclD7HX+XnjxxXrt
	tnUYhFcMLbLvNu528txVXbnv2g+gpAY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-BoG8oBp8NTiQfPY65IM34Q-1; Wed,
 06 Aug 2025 09:00:31 -0400
X-MC-Unique: BoG8oBp8NTiQfPY65IM34Q-1
X-Mimecast-MFC-AGG-ID: BoG8oBp8NTiQfPY65IM34Q_1754485227
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB054195419D;
	Wed,  6 Aug 2025 13:00:26 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BABE3000198;
	Wed,  6 Aug 2025 13:00:22 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	howardchu95@gmail.com,
	jbrnak@redhat.com
Subject: [PATCH] perf: use standard syscall tracepoint structs for augmentation
Date: Wed,  6 Aug 2025 15:00:17 +0200
Message-ID: <20250806130017.541416-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Replace custom syscall structs with the standard trace_event_raw_sys_enter
and trace_event_raw_sys_exit from vmlinux.h.
This fixes a data structure misalignment issue discovered on RHEL-9, which
prevented BPF programs from correctly accessing syscall arguments.
This change also aims to improve compatibility between different version
of the perf tool and kernel by using CO-RE so BPF code can correclty
adjust field offsets.

Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
The issue was encountered on RHEL-9 by failing trace enum augmentation tests.

Before change:
113: perf trace enum augmentation tests:
--- start ---
test child forked, pid 92876
Checking if vmlinux exists
Tracing syscall landlock_add_rule
[syscall failure] Failed to trace syscall landlock_add_rule, output:

---- end(-1) ----
113: perf trace enum augmentation tests                              : FAILED!

After change:
113: perf trace enum augmentation tests:
--- start ---
test child forked, pid 98369
Checking if vmlinux exists
Tracing syscall landlock_add_rule
Tracing non-syscall tracepoint timer:hrtimer_start
---- end(0) ----
113: perf trace enum augmentation tests                              : Ok

 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 58 ++++++++-----------
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    | 14 +++++
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index cb86e261b4de..de397b3b0776 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -60,18 +60,6 @@ struct syscalls_sys_exit {
 	__uint(max_entries, 512);
 } syscalls_sys_exit SEC(".maps");
 
-struct syscall_enter_args {
-	unsigned long long common_tp_fields;
-	long		   syscall_nr;
-	unsigned long	   args[6];
-};
-
-struct syscall_exit_args {
-	unsigned long long common_tp_fields;
-	long		   syscall_nr;
-	long		   ret;
-};
-
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -115,7 +103,7 @@ struct pids_filtered {
 } pids_filtered SEC(".maps");
 
 struct augmented_args_payload {
-	struct syscall_enter_args args;
+	struct trace_event_raw_sys_enter args;
 	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
 };
 
@@ -135,7 +123,7 @@ struct beauty_map_enter {
 } beauty_map_enter SEC(".maps");
 
 struct beauty_payload_enter {
-	struct syscall_enter_args args;
+	struct trace_event_raw_sys_enter args;
 	struct augmented_arg aug_args[6];
 };
 
@@ -192,7 +180,7 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 }
 
 SEC("tp/raw_syscalls/sys_enter")
-int syscall_unaugmented(struct syscall_enter_args *args)
+int syscall_unaugmented(struct trace_event_raw_sys_enter *args)
 {
 	return 1;
 }
@@ -204,7 +192,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
  * filename.
  */
 SEC("tp/syscalls/sys_enter_connect")
-int sys_enter_connect(struct syscall_enter_args *args)
+int sys_enter_connect(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *sockaddr_arg = (const void *)args->args[1];
@@ -225,7 +213,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_sendto")
-int sys_enter_sendto(struct syscall_enter_args *args)
+int sys_enter_sendto(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *sockaddr_arg = (const void *)args->args[4];
@@ -243,7 +231,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_open")
-int sys_enter_open(struct syscall_enter_args *args)
+int sys_enter_open(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *filename_arg = (const void *)args->args[0];
@@ -258,7 +246,7 @@ int sys_enter_open(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_openat")
-int sys_enter_openat(struct syscall_enter_args *args)
+int sys_enter_openat(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *filename_arg = (const void *)args->args[1];
@@ -273,7 +261,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_rename")
-int sys_enter_rename(struct syscall_enter_args *args)
+int sys_enter_rename(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[0],
@@ -304,7 +292,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_renameat2")
-int sys_enter_renameat2(struct syscall_enter_args *args)
+int sys_enter_renameat2(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[1],
@@ -346,7 +334,7 @@ struct perf_event_attr_size {
 };
 
 SEC("tp/syscalls/sys_enter_perf_event_open")
-int sys_enter_perf_event_open(struct syscall_enter_args *args)
+int sys_enter_perf_event_open(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const struct perf_event_attr_size *attr = (const struct perf_event_attr_size *)args->args[0], *attr_read;
@@ -378,7 +366,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_clock_nanosleep")
-int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
+int sys_enter_clock_nanosleep(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *rqtp_arg = (const void *)args->args[2];
@@ -399,7 +387,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_nanosleep")
-int sys_enter_nanosleep(struct syscall_enter_args *args)
+int sys_enter_nanosleep(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *req_arg = (const void *)args->args[0];
@@ -429,7 +417,7 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
-static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
+static int augment_sys_enter(void *ctx, struct trace_event_raw_sys_enter *args)
 {
 	bool augmented, do_output = false;
 	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
@@ -444,7 +432,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 		return 1;
 
 	/* use syscall number to get beauty_map entry */
-	nr             = (__u32)args->syscall_nr;
+	nr             = (__u32)args->id;
 	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);
 
 	/* set up payload for output */
@@ -454,8 +442,8 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	if (beauty_map == NULL || payload == NULL)
 		return 1;
 
-	/* copy the sys_enter header, which has the syscall_nr */
-	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
+	/* copy the sys_enter header, which has the id */
+	__builtin_memcpy(&payload->args, args, sizeof(struct trace_event_raw_sys_enter));
 
 	/*
 	 * Determine what type of argument and how many bytes to read from user space, using the
@@ -515,14 +503,14 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 		}
 	}
 
-	if (!do_output || (sizeof(struct syscall_enter_args) + output) > sizeof(struct beauty_payload_enter))
+	if (!do_output || (sizeof(struct trace_event_raw_sys_enter) + output) > sizeof(struct beauty_payload_enter))
 		return 1;
 
-	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
+	return augmented__beauty_output(ctx, payload, sizeof(struct trace_event_raw_sys_enter) + output);
 }
 
 SEC("tp/raw_syscalls/sys_enter")
-int sys_enter(struct syscall_enter_args *args)
+int sys_enter(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args;
 	/*
@@ -550,16 +538,16 @@ int sys_enter(struct syscall_enter_args *args)
 	 * unaugmented tracepoint payload.
 	 */
 	if (augment_sys_enter(args, &augmented_args->args))
-		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.id);
 
 	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
 	return 0;
 }
 
 SEC("tp/raw_syscalls/sys_exit")
-int sys_exit(struct syscall_exit_args *args)
+int sys_exit(struct trace_event_raw_sys_exit *args)
 {
-	struct syscall_exit_args exit_args;
+	struct trace_event_raw_sys_exit exit_args;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
@@ -570,7 +558,7 @@ int sys_exit(struct syscall_exit_args *args)
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
 	 * unaugmented tracepoint payload.
 	 */
-	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
+	bpf_tail_call(args, &syscalls_sys_exit, exit_args.id);
 	/*
 	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
 	 */
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index a59ce912be18..b8b234726863 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -212,4 +212,18 @@ struct pglist_data {
 	int nr_zones;
 } __attribute__((preserve_access_index));
 
+struct trace_event_raw_sys_enter {
+	struct trace_entry ent;
+	long int id;
+	long unsigned int args[6];
+	char __data[0];
+} __attribute__((preserve_access_index));
+
+struct trace_event_raw_sys_exit {
+	struct trace_entry ent;
+	long int id;
+	long int ret;
+	char __data[0];
+} __attribute__((preserve_access_index));
+
 #endif // __VMLINUX_H
-- 
2.50.1

