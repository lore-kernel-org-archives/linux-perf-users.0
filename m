Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E0185E53;
	Sat, 24 Aug 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517214; cv=none; b=kqY7A1avMOHzKlcqYbIXCL7jiRGWcfaSlleuqQh7YiE5GXjAZCv0oPpVv4KF3SgMAoqd3JUb1bdnmxmSm1brhzNhXhRSNwRVARfuG+Y9HvXW3jgDO4xg9rmtcT/832G1/5IXQ7Ezia++fti49uSWfiRRb8CSOVaohMlDTi75xAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517214; c=relaxed/simple;
	bh=s3ocW7p8o8fMIFld2ntXVxBjJaRPHURemAYfEmJpX4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFvLAdwA/KRDiwpwROZJEeY30TH7IW6uuNCsUqN24CrtlyWePDf2CjTzNiHPYwk7LJJPXeT/BHnUA839yArJjKEKeR1sQqEyMcc7oSE3rZReSdeuWIeuYwMl1/Qraj/biEiEsGjukvTYjKaQ6/5ZUm1m+FWQ2KWCZxDXvgvhVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtlcDwKG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtlcDwKG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so2022634a91.3;
        Sat, 24 Aug 2024 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517211; x=1725122011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXkhCNs+00zgE+sU2FTtlRZdxAHRx5jTB0KnVpppN/I=;
        b=XtlcDwKGpUq7u/bDWbf3CdvHMydpuxU1vICc3fHrv8GUC3EaNh6GXTa4IrEhrX52Tz
         lpQbdJ7UwSIX/KfZgyzD6WxBQe5QAj2nc1OSX09s82x10YYaJMKbeVaGMy/mHVYWstYs
         C1Qe9mrcADeEQBd6qU5Oh8Oc1EmFXk1s3J7nwxXBeCTEolBxxWWod+OQFrK9JxyZvWHH
         n353qrgeQ7dPxZyv7LDgpmSSYkGqkFUdkcjTdkl42KWAt7jmBfdZFDbTYHBGntN8sXx7
         02ltsKKgCZkxD9TGxoiHP+1lkV0sZUg883hmVQf44i9+HvxG0oMPSP2sEwAeIQeKXvc5
         GZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517211; x=1725122011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXkhCNs+00zgE+sU2FTtlRZdxAHRx5jTB0KnVpppN/I=;
        b=vPwmrDJo9P4pV+sIr72VYROymlq4d8Gsj3ChakYueCTNuu2EyVAHD12S7XOZEXRl1n
         sRdp2TIqWFZc2aLa18w1qVwiH3Ip9WbAQlDw3qtZw0nPip7MudOdJhTpLFA3SSeCfbNF
         JFEPLB9NkFsuvlXGvavey5q7p7fca/2e2ltjPPWB+nV5/cYZRddsY24iSQmU08R4iTDS
         dGKdlDcOYt/IqkiYrquBRqj9owIF8SeNI6VOJ1jWmGP6rcE10m2FCjdxpRuo5IZ+VCO0
         5IkZXSlE/NjlC1UkFtNQY1KnACBnh8SAzsf0wfKHtsOD+1rKqC2HyPj20vAVXxUXQzCt
         /Jyw==
X-Forwarded-Encrypted: i=1; AJvYcCVKYdDG09UAtoouOZBKvbPV2HUVDshIQFu6U/XXEelYZ7Qe8eV2Or44G2obCYCtBJ03Y7k/6Vwot7nSVbO/7YqBZA==@vger.kernel.org, AJvYcCX8kJm3Hi+y6LTzPHECFkSwex8mP1gtbQAQWtdFhSZRM82vqQAersHP/Yj4AdoHuYH/tzrLsYIZuyYJp6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfwzD+YKma5lJu0rpmemVN/3XFGn3uNZze+oTTCJl37KKv7CVg
	aDEaPYcNHoUToTVx1me92LMkgd9IosSp7Fxhvo2Xgb/J4c7mSj0w
X-Google-Smtp-Source: AGHT+IGTfJT+1rBShA36qvM8tH5+R+Ak5XJKKwn2ncKhwZHu9PI4PT7NCJFWKn6dK7cj2KprjelctQ==
X-Received: by 2002:a17:90a:ac17:b0:2d3:b8eb:9c3c with SMTP id 98e67ed59e1d1-2d646b9083cmr5042254a91.2.1724517210891;
        Sat, 24 Aug 2024 09:33:30 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:30 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 6/8] perf trace: Collect augmented data using BPF
Date: Sun, 25 Aug 2024 00:33:20 +0800
Message-ID: <20240824163322.60796-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824163322.60796-1-howardchu95@gmail.com>
References: <20240824163322.60796-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include trace_augment.h for TRACE_AUG_MAX_BUF, so that BPF reads
TRACE_AUG_MAX_BUF bytes of buffer maximum.

Determine what type of argument and how many bytes to read from user space, us ing the
value in the beauty_map. This is the relation of parameter type and its corres ponding
value in the beauty map, and how many bytes we read eventually:

string: 1                          -> size of string (till null)
struct: size of struct             -> size of struct
buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_ MAX_BUF)

After reading from user space, we output the augmented data using
bpf_perf_event_output().

If the struct augmenter, augment_sys_enter() failed, we fall back to
using bpf_tail_call().

I have to make the payload 6 times the size of augmented_arg, to pass the
BPF verifier.

Committer notes:

It works, but we need to wire it up to the userspace specialized pretty
printer, otherwise we get things like:

  root@number:~# perf trace -e connect ssh localhost
       0.000 ( 0.010 ms): :784442/784442 connect(fd: 3, uservaddr: {2,}, addrlen: 16)                          = 0
       0.016 ( 0.006 ms): :784442/784442 connect(fd: 3, uservaddr: {10,}, addrlen: 28)                         = 0
       0.033 ( 0.096 ms): :784442/784442 connect(fd: 3, uservaddr: {10,}, addrlen: 28)                         = 0
  root@localhost's password:     71.292 ( 0.037 ms): ssh/784442 connect(fd: 4, uservaddr: {1,{['/','v','a','r','/','r','u','n','/','.','h','e','i','m',],},}, addrlen: 110) = 0
      72.087 ( 0.013 ms): ssh/784442 connect(fd: 4, uservaddr: {1,{['/','v','a','r','/','r','u','n','/','.','h','e','i','m',],},}, addrlen: 110) = 0

  root@number:~#

When we used to have:

  root@number:~# perf trace -e connect ssh localhost
       0.000 ( 0.011 ms): ssh/786564 connect(fd: 3, uservaddr: { .family: INET, port: 22, addr: 127.0.0.1 }, addrlen: 16) = 0
       0.017 ( 0.006 ms): ssh/786564 connect(fd: 3, uservaddr: { .family: INET6, port: 22, addr: ::1 }, addrlen: 28) = 0
       0.263 ( 0.043 ms): ssh/786564 connect(fd: 3, uservaddr: { .family: INET6, port: 22, addr: ::1 }, addrlen: 28) = 0
      63.770 ( 0.044 ms): ssh/786564 connect(fd: 4, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, addrlen: 110) = 0
      65.467 ( 0.042 ms): ssh/786564 connect(fd: 4, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, addrlen: 110) = 0
  root@localhost's password:

That is closer to what strace produces:

  root@number:~# strace -e connect ssh localhost
  connect(3, {sa_family=AF_INET, sin_port=htons(22), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  connect(3, {sa_family=AF_INET6, sin6_port=htons(22), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=0}, 28) = 0
  connect(3, {sa_family=AF_INET6, sin6_port=htons(22), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=0}, 28) = 0
  connect(4, {sa_family=AF_UNIX, sun_path="/var/run/.heim_org.h5l.kcm-socket"}, 110) = 0
  connect(4, {sa_family=AF_UNIX, sun_path="/var/run/.heim_org.h5l.kcm-socket"}, 110) = 0
  root@localhost's password:

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240815013626.935097-10-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 114 +++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 0acbd74e8c76..f29a8dfca044 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -7,6 +7,8 @@
  */
 
 #include "vmlinux.h"
+#include "../trace_augment.h"
+
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
 
@@ -124,6 +126,25 @@ struct augmented_args_tmp {
 	__uint(max_entries, 1);
 } augmented_args_tmp SEC(".maps");
 
+struct beauty_payload_enter {
+	struct syscall_enter_args args;
+	struct augmented_arg aug_args[6];
+};
+
+struct beauty_map_enter {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, __u32[6]);
+	__uint(max_entries, 512);
+} beauty_map_enter SEC(".maps");
+
+struct beauty_payload_enter_map {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, struct beauty_payload_enter);
+	__uint(max_entries, 1);
+} beauty_payload_enter_map SEC(".maps");
+
 static inline struct augmented_args_payload *augmented_args_payload(void)
 {
 	int key = 0;
@@ -136,6 +157,11 @@ static inline int augmented__output(void *ctx, struct augmented_args_payload *ar
 	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
 }
 
+static inline int augmented__beauty_output(void *ctx, void *data, int len)
+{
+	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, data, len);
+}
+
 static inline
 unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
@@ -372,6 +398,91 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
+{
+	bool augmented, do_output = false;
+	int zero = 0, size, aug_size, index, output = 0,
+	    value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	unsigned int nr, *beauty_map;
+	struct beauty_payload_enter *payload;
+	void *arg, *payload_offset;
+
+	/* fall back to do predefined tail call */
+	if (args == NULL)
+		return 1;
+
+	/* use syscall number to get beauty_map entry */
+	nr             = (__u32)args->syscall_nr;
+	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);
+
+	/* set up payload for output */
+	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
+	payload_offset = (void *)&payload->aug_args;
+
+	if (beauty_map == NULL || payload == NULL)
+		return 1;
+
+	/* copy the sys_enter header, which has the syscall_nr */
+	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
+
+	/*
+	 * Determine what type of argument and how many bytes to read from user space, using the
+	 * value in the beauty_map. This is the relation of parameter type and its corresponding
+	 * value in the beauty map, and how many bytes we read eventually:
+	 *
+	 * string: 1			      -> size of string
+	 * struct: size of struct	      -> size of struct
+	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
+	 */
+	for (int i = 0; i < 6; i++) {
+		arg = (void *)args->args[i];
+		augmented = false;
+		size = beauty_map[i];
+		aug_size = size; /* size of the augmented data read from user space */
+
+		if (size == 0 || arg == NULL)
+			continue;
+
+		if (size == 1) { /* string */
+			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
+			/* minimum of 0 to pass the verifier */
+			if (aug_size < 0)
+				aug_size = 0;
+
+			augmented = true;
+		} else if (size > 0 && size <= value_size) { /* struct */
+			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
+				augmented = true;
+		} else if (size < 0 && size >= -6) { /* buffer */
+			index = -(size + 1);
+			aug_size = args->args[index];
+
+			if (aug_size > TRACE_AUG_MAX_BUF)
+				aug_size = TRACE_AUG_MAX_BUF;
+
+			if (aug_size > 0) {
+				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
+					augmented = true;
+			}
+		}
+
+		/* write data to payload */
+		if (augmented) {
+			int written = offsetof(struct augmented_arg, value) + aug_size;
+
+			((struct augmented_arg *)payload_offset)->size = aug_size;
+			output += written;
+			payload_offset += written;
+			do_output = true;
+		}
+	}
+
+	if (!do_output)
+		return 1;
+
+	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
+}
+
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
@@ -400,7 +511,8 @@ int sys_enter(struct syscall_enter_args *args)
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
 	 * unaugmented tracepoint payload.
 	 */
-	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+	if (augment_sys_enter(args, &augmented_args->args))
+		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
 
 	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
 	return 0;
-- 
2.45.2

