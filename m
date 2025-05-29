Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21F1DF73C;
	Thu, 29 May 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748501743; cv=none; b=NKAtfVpj+doGEFwWsp4RN0C1Tjf+NMQ9N9vOilxXgLf5zLEY9IsFw/1Do7Z3boG7LZGqeXf7+NpppCVHTDerf/R24ZKqo/I5oZsY9Tbg3KOjOFCjzDXhbcXWHj3zNdIhAw1BBNnacZmcveuKCbe4Sryfo5JaP3qKYh/SBSjIeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748501743; c=relaxed/simple;
	bh=Ic3ge/A40lmJt9jmM2mNXrqmYWfBwRDGfc35/Hm2voM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XReEKvuSgITzWOAynlkGIPZhIDQd6pg7cPJCJ9k+/fEgYuIObQlPP4EMS6Z4rqaI76XXx00E5aJnoz56pLZS28pugd5IiMBvK+prwc04Cs+I1t0E5qV9WIr8TWmP23JG61l4R0RV3rM8dWHb8KxiclUJkQg+4QagQ9KLg+8987c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNRty/Zy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNRty/Zy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-310cf7f12e8so391834a91.2;
        Wed, 28 May 2025 23:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748501740; x=1749106540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BD+qAir3J3wEsfcmlmLlq3A1DJAYrekg3jdwRWctrKQ=;
        b=BNRty/ZyxhOsJ0+4xk5hQXwES7hR3I6jqbc0KhNqYhkHkTjWyb1UUJYMn6ThspgHsV
         qAddHD9uCGB8WPb7hg1c+u5rGfMEusyvkDoOPHUz0EbYopLQLiU2NSxE1U8YNTjVQIY6
         FuGf+A6QIa+Y724Zdjv2GVDYlr20d4HapFNXqk2SzUC1pmfcUC9W2HAdBts0lZ7dsgrG
         DFDLkSryLv4kvmxIzanbp84cCiH3kI1Mfmmy6qq8s6RQio0y/6S4wxzXfk/pz8eXzN2P
         1DVYT4cEysmNdpdTx3S10AVuZ/IE+qqPhWio/0RcKODzZOD9TpDl2bdD2lTlyfw4yGLU
         7bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748501740; x=1749106540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BD+qAir3J3wEsfcmlmLlq3A1DJAYrekg3jdwRWctrKQ=;
        b=prEM8BvSUbuUPMuO2snf/GWMAavgsltxT2YkrOeOI1ruceLltYKDGZ/cMfPoBtRvgf
         X2kxvcfJbYN5jrpldDkl3hD0IIfmCr5pSr/TLPuinto6AYF2dA/pox5aeL6pLTXoJ/IR
         M/EjsT41N7kzlDGjbOSvZP2b7fINVj25TQOaprbUR5gzUnIHliTitnf335D6B9nA10gk
         BGQllT/05nijyHWp0ZQfhxr18WxivebmNL831/iCcfBNXduqZ+I/Hncbx0XfYf9eW+ZU
         8EHg3qh5iZpUPDPzSff+vGO3SvkrTv6XdDZWT69H2wYs4NL6n2HjmdM+KWzoShZ3ZVNz
         x2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw9YC6fLZKgbiLDtzA0AwCijB+iDzZs8GbrBZxw/A+Hm1VnnDA5jWPy008YZhjsanHEJGqFKxlkNBUyuE=@vger.kernel.org, AJvYcCXAp3QCQXNWc+80zYgtsEK4DCq3z3W9bwqwOidiH3H74vBXc5uE7TPF4T2X8FUuABd9QS6+bVE9aefjepMNK1IKvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ76a5kxyo7ARuBbYCe/Zo5ESBHjUWnuZKOj3rmfCQPM1rDj9u
	IXjMwmYrfpYspAjbAwJG/fdM2FJkn+kacLqj4iddSgY9WQQfuzpqIOj0
X-Gm-Gg: ASbGncuFFWo0uqZY7E7P0Z79T3Pq4rd6AjLd80uiG8FSx91upd2TpYdwddrFe6kW+Ff
	gcJ4k3piON0MMDfPHJKn5+9Mk2mcCeo08JNv6lbGwJ0d0WYx88AlRNFq1EqyeWgVRj+SvSf5EgR
	xFyApT8V+38KXbqwZcBRQYRSuGgc+vvZwcBx9VmM4SGnmZPHvOp6rTKBB9EoXswHQ/2K8OFC7Fo
	rb6WKkMvyLeoZqTR3ALzMAvUM3dJrICgOIjl/OVDxPshufWCbhZ7Q9svV8G8lAUG7XS3tvvFiLg
	w5WJlTuHhmpjyZ23jg9AnElB4y7S8tb1xnk1jLuY7dy6lTTHqhERDHUAwYtKPiQKMTrPyA8rUhk
	9akprxVC071Q=
X-Google-Smtp-Source: AGHT+IGI2Uv0Eoh2SPkDQf7TIkmxw23EFGm9NI4uzvhhxvbI+H3V/8YYGq0T0XR3YyKDHHtfAbnWdg==
X-Received: by 2002:a17:90b:1c0c:b0:312:29e:9ec9 with SMTP id 98e67ed59e1d1-312029ea2b7mr5715627a91.24.1748501740083;
        Wed, 28 May 2025 23:55:40 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121bdc3efcsm713803a91.45.2025.05.28.23.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 23:55:39 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf trace instances
Date: Wed, 28 May 2025 23:55:36 -0700
Message-ID: <20250529065537.529937-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf trace utilizes the tracepoint utility, the only filter in perf
trace is a filter on syscall type. For example, if perf traces only
openat, then it filters all the other syscalls, such as readlinkat,
readv, etc.

This filtering is flawed. Consider this case: two perf trace
instances are running at the same time, trace instance A tracing
readlinkat, trace instance B tracing openat. When an openat syscall
enters, it triggers both BPF programs (sys_enter) in both perf trace
instances, these kernel functions will be executed:

perf_syscall_enter
  perf_call_bpf_enter
    trace_call_bpf
      bpf_prog_run_array

In bpf_prog_run_array:
~~~
while ((prog = READ_ONCE(item->prog))) {
	run_ctx.bpf_cookie = item->bpf_cookie;
	ret &= run_prog(prog, ctx);
	item++;
}
~~~

I'm not a BPF expert, but by tinkering I found that if one of the BPF
programs returns 0, there will be no tracepoint sample. That is,

(Is there a sample?) = ProgRetA | ProgRetB | ProgRetC

Where ProgRetA is the return value of one of the BPF programs in the BPF
program array.

Go back to the case, when two perf trace instances are tracing two
different syscalls, again, A is tracing readlinkat, B is tracing openat,
when an openat syscall enters, it triggers the sys_enter program in
instance A, call it ProgA, and the sys_enter program in instance B,
ProgB, now ProgA will return 0 because ProgA cares about readlinkat only,
even though ProgB returns 1; (Is there a sample?) = ProgRetA (0) |
ProgRetB (1) = 0. So there won't be a tracepoint sample in B's output,
when there really should be one.

I also want to point out that openat and readlinkat have augmented
output, so my example might not be accurate, but it does explain the
current perf-trace-in-parallel dilemma.

Now for augmented output, it is different. When it calls
bpf_perf_event_output, there is a sample. There won't be no ProgRetA |
ProgRetB... thing. So I will send another RFC patch to enable
parallelism using this feature. Also, augmented_output creates a sample
on it's own, so returning 1 will create a duplicated sample, when
augmented, just return 0 instead.

Is this approach perfect? Absolutely not, there will likely be some
performance overhead on the kernel side. It is just a quick dirty fix
that makes perf trace run in parallel without failing. This patch is an
explanation on the reason of failures and possibly, a link used in a
nack comment.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c   | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index e4352881e3fa..315fadf01321 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -546,13 +546,14 @@ int sys_enter(struct syscall_enter_args *args)
 	/*
 	 * Jump to syscall specific augmenter, even if the default one,
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
-	 * unaugmented tracepoint payload.
+	 * unaugmented tracepoint payload. If augmented, return 0 to reduce a
+	 * duplicated tracepoint sample.
 	 */
-	if (augment_sys_enter(args, &augmented_args->args))
-		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+	if (!augment_sys_enter(args, &augmented_args->args))
+		return 0;
 
-	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
-	return 0;
+	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+	return 1;
 }
 
 SEC("tp/raw_syscalls/sys_exit")
@@ -570,10 +571,7 @@ int sys_exit(struct syscall_exit_args *args)
 	 * unaugmented tracepoint payload.
 	 */
 	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
-	/*
-	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
-	 */
-	return 0;
+	return 1;
 }
 
 char _license[] SEC("license") = "GPL";
-- 
2.45.2

