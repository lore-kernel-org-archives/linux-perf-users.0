Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E983381E8C
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572358; cv=none; b=QzPXSLMoNJ6FkskIXSQfydoOvbqIeU3+I9eVot9F33i0dsfGmAewXz50CIgiPyHQ2Q3QHNbdeDp4+35gAvc1L6E5j9ZU+Er0nD3mVP9PJ/PIZi9BMa95ARp7vZnTeo3U2VEZoC9L0DbzTZrYirH54Nolln52cUX2NhdzyRWe0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572358; c=relaxed/simple;
	bh=MUwT80gOWfAvuW29q252L7dGK6/yoX9ij9iHwsuwjqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikIlIOsQM/tBbKNnP2dEXjGKw1P8oerZr0+3/njC+07HTHhnfNm4IDK4MCSyl2sx7jieLxyrLn0hTuksc15tRqeD86PAS4PTg2gst/D1OzfIUGOe+I6wP8s86kxbeoWXLyAazGSiXzx2ZiSq/GABXTCZVKDxIiOnD0W4s0lD2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs3oe+qs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs3oe+qs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so1453065e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2026 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791572355; x=1792177155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pJrTXNnvNyxoPy6a05idwZooJz9oMMxcUiIT8xGCw0Y=;
        b=Gs3oe+qsaAo6Qyb+uYz8NIy2rJdxahxKqbuXgczFYkOCY/Ta/j7CweECUa6PHIr4UH
         CDzGNqMOibkOXYfbhSDtAL6hIXjDj4yBbm/tIKvFRjyRNSC6iK0Un2Z8NwNoF0IkNPJe
         s+Q6qwLB6smocAz9Lpq7CvG+OrSmMSN/IigspZv5Cl5/82BNpLv+mkQU4tOhIoN4cxhP
         LgJhYWNQyTD3vLPlOr+EAt2Yp8liPhI1VH6ZVEnFQK4c4JUf+dwpfYYU1yia5A34O7Cf
         9DCmbiYJyWF9Em9gtkOkpEFW/G+ib+tIt+kiA3zbFEz4mCK0yMH+thWieK+osjleSYPS
         E7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791572355; x=1792177155;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJrTXNnvNyxoPy6a05idwZooJz9oMMxcUiIT8xGCw0Y=;
        b=Au/YvpKdZOhkHxQ+blW4F9DVu4MrN6J5Re3QBx8csVmHkgAoODZo1xMDYmKU5Hm7xB
         3lx8O0JG0RHA1/9BuShl5v7hVhKQ5k/hlBSdBfc6k+6Zv1gZ/tNROUNAytEXNXUEqVOS
         fn+h5uzSHo3AOzwCQkFxHonGG3CPc2REO1KHDZbZYci+VwlMCAB4MvIkwA4JUSt8Jh6B
         fbMup8iAiEWtsTeBj7i0U6X9k/x2balco/RqEZWUbt+FRS17DGHR+sT/rBtgJp4Wl6Gs
         /aJha/hOFJFjQk5wIppPCfCzsOE+3ZYCLbmULvp16bDIuNRBy0Fp/R11tnGD7tgD8mY+
         H5ow==
X-Forwarded-Encrypted: i=1; AKwUvBzWQQJVrKEcQzuFfCCf6Rxz9IIaEOmeZrsYP5lVrUp8MFISCcBz9Dfo/wJXj31UEbAhkJFWBZNQUrxbnny6wCM8@vger.kernel.org
X-Gm-Message-State: AFuF++nXFTu6DfqkDMDuHkwxitaLUiRSM/PFuwv+TerqVwVgyACaUFMF
	NKWBP6WtO3jaUKrc/8+AAa17s8vdkqC08x1jVpj09V2MHtD2fD8nIasN
X-Gm-Gg: AYBFou2L41anoNRMPiDjSo5PvvIyRZ1FvpMkMB4BxJUB7kV+bloaOhTJDVu4CPVVbTp
	dr6exbD8L0lKaFZwqd2CDM0uJDp6CBECR7DeNe6oCNpnD+cns9i8sWx5ugFWE2ZzbtcsPybQzsA
	bjVZcAnnHcQjfGRup2C3tjYYzrBoBa//RHAecveMQpbGdD7ARCCmRVd9shMR+RVap6m3SfLd1Ha
	+LvRc53BOsYF9Yo91B5M6RwowfBjAaAlMwPuG12Ie54iEJ1MnkjmJ0Ny9Nvtt+RR6CWqC+41r/t
	K0IQDonNQtZwWJf6H62FP+xUsDoqlmXRsw7C0sONahKENlva5ZsqDz7GFGdPRWpE9nf9t5QHUU7
	+ZRMCGEmgM9l7T7pdM+jeZjKjJokDzNQFVrPxRj21xyB7xIj9Qh5pSt5ynFVghBQUBrWrlmcHG5
	W9O+0bW7DzBvjVwhAUsXbb1X8RkWy/L8e/Y0dLDGFz5KBnZRYXDKY8nIq0jGwwWZfwqaAXJpGz9
	BeXDnGBDZkoOKznxjMeqU608MBdfyQvAu2HzTHjDyBafq0XW1378Oi5ui32ryFv8F9rheLfJOBM
	jEBIMrnfNDEtPZbw4MQYTUHSnI9xlVlZTNNviYxaMqalguBY1CSMc3ZllIRpH57H/6KvKDvSGLz
	olQ==
X-Received: by 2002:a05:600c:8708:b0:4a1:7b05:3a6d with SMTP id 5b1f17b1804b1-4a18e49881amr52257515e9.8.1791572355206;
        Fri, 09 Oct 2026 11:59:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm122222075e9.8.2026.10.09.11.59.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 11:59:14 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	mpdesouza@suse.com,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	martin@kaiser.cx,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 5/7] riscv: stacktrace: switch to frame-pointer based unwinder
Date: Fri,  9 Oct 2026 20:59:04 +0200
Message-Id: <20261009185904.82385-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260914092648.51254-6-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com> <20260914092648.51254-6-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On Mon, Sep 14, 2026 at 05:26:46PM +0800, Shuai Xue wrote:
> +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
> +				      void *cookie, struct task_struct *task,
> +				      struct pt_regs *regs)
> +{
> +	struct kunwind_consume_entry_data data = {
> +		.consume_entry = consume_entry,
> +		.cookie = cookie,
> +	};
> +
> +	kunwind_stack_walk(arch_kunwind_consume_entry, &data, task, regs);
> +}

Hi Shuai Xue,

With this patch and FRAME_POINTER enabled, return_address() returns the
caller one level further up than asked for.

return_address() in arch/riscv/kernel/return_address.c skips level + 3
entries from arch_stack_walk(). The arm64 original skips level + 2. The
third entry exists on mainline because the walk starts inside
walk_stackframe() and first reports the return into arch_stack_walk().
With 5/7 the walk starts at the caller of arch_stack_walk(), so
level + 3 now skips a real caller. CALLER_ADDR1 and up are built on
return_address(). The irqsoff tracer and the preemptirq tracepoints use
them.

A KUnit test that calls ftrace_return_address() from
leaf() <- middle() <- outer() <- check() returns:

             af32da41b032   with series   with series, level + 2
  level 0    middle         outer         middle
  level 1    outer          check         outer

The change to level + 2 has to depend on FRAME_POINTER. Without it the
series keeps walk_stackframe() and the result is the same as on
mainline. There, level + 2 makes return_address(0) return an address
inside return_address().

The same extra entry makes stack_trace_save() start one frame too early
on mainline. 5/7 fixes that. I have a small fix for it on mainline,
meant for stable kernels, which conflicts with 5/7. I would post it with
you in Cc. Tell me if you would rather take the return_address.c change
into 5/7 first.

Tested with clang 22 and the series applied on 52318cf0fa6e. The
"with series" column is the same on QEMU's virt machine and on a
BeagleV Ahead (TH1520). Everything else ran on QEMU only.

Karl
