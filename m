Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8A29D288;
	Fri, 21 Aug 2026 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279566; cv=none; b=j5FcfBcC2EG3fLPH8ft9XJlEsJYwfEcGqpZL1UPmGPOCbUjUaD7itdV1+KgwJ/Qd7bNLrseptWHEQATDCKRxKvZCYcVG2xvO8+YT0VfcYAHJyutlG4Awds0AzHjw53rQelph+1gSKYBof73XFqqtdTiyBOe7+T6BYAMEmw7ITrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279566; c=relaxed/simple;
	bh=cv0qD6cuAPOR4oVc+l9cq2nNzMHpnMYQpOrykZjjDXA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bj2Z7dCdpRZtKXnvEhZTKDzRAsDI8olB+vJdPDuSoJp5MolGA0hit4tek1wYbi1PUJrHN9TywBunH6/TqD2cuJVb4iTYvy52k8vQDz4w2RnX/Aa7eQ5gY5ia/jNr6MUqQLLh/Y11barkBKZe3jSQtE3CMsLVCFA/2fAzNh6597U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf8T2l8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf8T2l8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058101F000E9;
	Fri, 21 Aug 2026 02:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787279564;
	bh=oIYdPIsa1yHw4YcSQlyJ7OAKiCfgQ6xlum8LonMt0jo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bf8T2l8p2dNTOVICkeIH/0rk98gIkErznti9g27kzj+QxXBpWXkeqpw2uTil3DJ+o
	 Y2Ym1NXEdz1QehvWSeh6cLxPphtTfC6udtVOK1YZD8Qajrm89pV8W+q5Th78113v3U
	 7SdKM89MDMPlnQAb8TkpnMPzm7xm+LtYEiB0ieg2UCmRlgh8pg7jhkLVcylUw4Pa3o
	 2HqZyukmAWy+2je0yiQ86vlwYTb//3STwsiOe+pw7mnu8L+dtG7YZ0gB38wI1eZW3E
	 U+nkjT2nycBBPAr9WagXGFeeXh1/Dre4Bv4zscsRVJxUSzLwQ5wEDhXVwV37Ea9jFG
	 phHPt1tZYkDyw==
Content-Type: multipart/mixed; boundary="===============0871903515966817128=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <092049279b8456492ee51b43f97926a94ebec32c3477ac6ce1758324710fc1e5@mail.kernel.org>
In-Reply-To: <20260821014210.18681-1-kartikey406@gmail.com>
References: <20260821014210.18681-1-kartikey406@gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
From: bot+bpf-ci@kernel.org
To: kartikey406@gmail.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,olsajiri@gmail.com,irogers@google.com,adrian.hunter@intel.com,james.clark@linaro.org,kpsingh@kernel.org,matt@bobrowski.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kartikey406@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 02:32:44 +0000 (UTC)

--===============0871903515966817128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit ba658ac0ee57b66edf6626745df8d57173c68285
> Author: Deepanshu Kartikey <kartikey406@gmail.com>
> Date:   Fri Aug 21 07:12:10 2026 +0530
>
>     perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
>
>     During fork(), perf_event_alloc() reads parent_event->prog locklessly
>     which can race with a concurrent bpf_perf_link_release() clearing and
>     freeing the prog via perf_event_detach_bpf_prog(). This can result in
>     a NULL pointer dereference or use-after-free in bpf_prog_inc().
>
>     Fix by holding bpf_event_mutex when inheriting the BPF program during
>     fork(). Make bpf_event_mutex non-static and declare it extern in
>     perf_event.h so it is accessible from kernel/events/core.c.
>
>     Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")

The Fixes tag points at commit 85192dbf4de0 ("bpf: Convert bpf_prog
refcnt to atomic64_t") by Andrii Nakryiko, which only converted
bpf_prog->aux->refcnt from atomic_t to atomic64_t and made bpf_prog_inc()
non-failing.

That commit's modified-symbol set is entirely in kernel/bpf/,
include/linux/bpf.h and various net drivers, and it does not touch
kernel/events/core.c or perf_event_alloc() at all.

The unlocked read of parent_event->prog in perf_event_alloc() predates
it and was introduced by the commit that added BPF overflow-handler
inheritance to perf_event_alloc().

Should the Fixes tag name the commit that introduced the unlocked read so
the fix is backported to the right stable trees?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32437947108
--===============0871903515966817128==--
