Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444140EB8E
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924098; cv=none; b=WmO4FOB15/gJxIiByp1qZenwYi1syAGQJQg7B+k0kbsRmJ+76XcZ1dBj4YgwOHIqmuZSP8T7SeOnzemS1lNkPxxXCUaLWdHAaZ+P1WpWkX5VDKAa9U7XQXw5ybFMlblWQOFhc/rRfazwgOnRWf2IgyfrdcB6skgLRUkXFIRJZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924098; c=relaxed/simple;
	bh=rHmBf/qUFb97VwsNbQMtVRtXzU8md133Mj4GKesN0jU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z8mY+68FE+MPCNXO4IHtWtglJHW0ypvNmYw48z9HruEH0VjNeAffcFXSDeYr5B3W9ml8rFmTtVCeaZ9uTuaQ/J/XTx8RewOZ4JvCvc9Vt7e5eDgbWcHwq+HZfp/FzRIraeIaMPc4z5acR13xDOH73sgcZDfUB4cdLXju8vytF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jv83o5mr; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jv83o5mr"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1493b09d6bbso3418837c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790924096; x=1791528896; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PhCPPQy6IciDdKP83gowChF0t2PFkHd1JM+aCRaprW4=;
        b=jv83o5mriYgKZ1SaDWooSGTtq2o9pVP0VKryZnurI7px8gywVuaJiP65KuIujxXCcv
         bPhCOtRT+1QoXBC8UDC0tNF+kCoTbwKhqwWZP072dLzVgl8q0/FSLvsPnblUqNXrOTWQ
         Wz4yqBEnkWnNC+LGNynWigJPYnQ5W94aE27HyA3hW8dNyQHJBKVJmr4+qNMX/CFzs3H1
         sP7xhJz4qgT3HLhjM0+KeImGG7CdZARCKXjSwqwqCdpQz+UINLRKVKkexYzHQXnqJPbH
         5v649ltLmzdZyWUbUFr2UB3umEwtLbmV9HBGi/c6mKIPxSZ0Jn1FraoQLv53jvUs9ggA
         2dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924096; x=1791528896;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhCPPQy6IciDdKP83gowChF0t2PFkHd1JM+aCRaprW4=;
        b=CMLh1KItzbKmP5ciNjEjHeRvcIRy8qc8pBIpwMmdaAEF5veOz4UyvS33cImj0viqfB
         2fVEKYAX/A8u83lYNPBXfW0BbvFkXAO1hiF6cD1MpNBEqiivQMBJBWWJcemSCzZuJPtw
         1EHA1bmw3vNT6y9rQ6RJ5k6BZghg+o9kylArcjQ02gwTFpGCZ4NUHnD9FJBngWWYS5/a
         ME9Lo7B9MSt9DJo9W1vj7ve2IkHPcuFMg26nMwy/wI9akE3ta6kW0Ac7aiRH8IFWf7vO
         kmbyUdmNqouGjSMsisJUhWMN5KaoM49Jmpi0pgjdQAmn+fOMGmhUYA5sifIBC52F2Chu
         NDFg==
X-Forwarded-Encrypted: i=1; AKwUvBwhdGthpb8VUMMcStLbCU7V6Mdx2igb22Fd+q27wLrQfJ34swF+2m6B1FyHG217PPr/3cuVuXnGEA2KyeTeEM+I@vger.kernel.org
X-Gm-Message-State: AFuF++naH7PgbPulEwjVT0Sw01Q1C7dxFO9hIzCyMq+y+RDL0AuHLUBI
	+5RA3iJ9bQyvD+dW3Tki5bRk1I9zcdBZd4NKjH0CbJuVZ4QbZyLFLsc4zqQ268rZOzzEdb+Tx0M
	dEX0Fnv/c6Q==
X-Received: from dlbrd11.prod.google.com ([2002:a05:7022:f10b:b0:14c:5add:b3d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:798:b0:14d:c7ae:85dd
 with SMTP id a92af1059eb24-14f5b50b67fmr2908519c88.7.1790924095513; Thu, 01
 Oct 2026 23:54:55 -0700 (PDT)
Date: Thu,  1 Oct 2026 23:54:40 -0700
In-Reply-To: <20261002065440.2781176-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ar6nzTSj17IxCy0j@x2> <20261002065440.2781176-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002065440.2781176-2-irogers@google.com>
Subject: [PATCH 2/2] perf trace: Increase TRACE_AUG_MAX_BUF to 128 and
 document beauty_map encoding
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com, atomlin@atomlin.com, howardchu95@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jbrnak@redhat.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

With sockaddr arguments copied as buffers via beauty_map_enter, the
32-byte TRACE_AUG_MAX_BUF limit only held 2 bytes of sa_family plus 30
bytes of AF_LOCAL sun_path, truncating longer socket paths such as
"/var/run/.heim_org.h5l.kcm-socket".

Since struct augmented_arg already reserves PATH_MAX (4096) bytes,
increase TRACE_AUG_MAX_BUF to 128 (SS_MAXSIZE, the size of struct
sockaddr_storage), which covers all 110 bytes of struct sockaddr_un
without changing map sizes. Also document the 1-based negative
-(arg_idx + 1) encoding used in beauty_array for paired length
arguments.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                            | 8 +++++++-
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 8 ++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c34c9f129836..4094141461f9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4174,7 +4174,12 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 				continue;
 
 			bt = sc->arg_fmt[i].type;
-			/* Copy a sockaddr as a buffer sized by the next argument, e.g. addrlen. */
+			/*
+			 * Copy a sockaddr as a buffer sized by the next
+			 * argument (i + 1), e.g. addrlen. A negative entry
+			 * -(j + 1) encodes the 0-based length argument index j
+			 * as 1-based so arg 0 is -1 rather than 0.
+			 */
 			if (strcmp(name, "sockaddr") == 0 && field->next &&
 			    strstr(field->next->name, "len"))
 				beauty_array[i] = -((i + 1) + 1);
@@ -4210,6 +4215,7 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
 				     (strstr(field_tmp->name, "len") && strcmp(field_tmp->name, "filename")))) {
 					 /* filename's got 'len' in it, we don't want that */
+					/* 1-based negative index of length arg j. */
 					beauty_array[i] = -(j + 1);
 					can_augment = true;
 					break;
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 0b2ef9541f84..28ebb9a72776 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -28,7 +28,7 @@
 
 #define MAX_CPUS  4096
 
-#define TRACE_AUG_MAX_BUF 32 /* for buffer augmentation in perf trace */
+#define TRACE_AUG_MAX_BUF 128 /* for buffer augmentation in perf trace */
 
 /* bpf-output associated map */
 struct __augmented_syscalls__ {
@@ -514,9 +514,9 @@ u64 ZERO = 0;
  * value in the beauty_map. This is the relation of parameter type and its corresponding
  * value in the beauty map, and how many bytes we read eventually:
  *
- * string: 1			      -> size of string
- * struct: size of struct	      -> size of struct
- * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
+ * string: 1			          -> size of string
+ * struct: size of struct	          -> size of struct
+ * buffer: -(0-based index of paired len + 1) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
  */
 static inline int augment_arg(struct syscall_enter_args *args, int i,
 			      unsigned int *beauty_map,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

