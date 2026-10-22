Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636646;
	b=bJSbd79Rf769W58UplB4XDeiPj+qgbIqDglJDWKoOaiUKod3f6Vst/WdMX6+siZjg5AF
	 xEbVE2oU3hRktnTV3lxYicRXqGcfzDx21hLg4kxE/uh4m5pfBS+xqFYUpm1BCEwvk0ZEb
	 djXRQ6Xi1My91I2mwQNkNXwBYM7vp3tG4+n+Sr5z6rfbCOilE7dYQY/zCaq+y7EH9/P0m
	 kB3jWtfFL29P7WagLexbDbKtmd5turYlQ7kWCB1WI21e4ugDsapCJy5Svpmo/pdhcVwMS
	 x0qWWeWcacPu7oyioibHayJ0VQWIW1KjVz7klmV2zf93de0nE/3HTyemMuTSKWMPV3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636646;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mu0ZdecmwjeGyJjNTgvVUayi9FotXs8zWmgYmq7DBn0=;
	b=OeR3gNFxYARYvKuUdVlvXcp/l7OdzKK2jbid6AjlWWIOkImLmL4Gg/gvHpEw5qb97DcK
	 xGQQLtkN1mxLHmXz4ujugrQx+W8BAE/sAPjJI9kzmZbxw7S5+fw8QA2cf0kUr86ZeEgRh
	 7Hdxfh5HxgFNVdEa/efuxhnNEybMfLMu/a9ffmABuNB2jA0rEa7lmN2ggli026rBrd2Sz
	 6QUvMCKSmtMMNWi8hb6t3A0suB9fgXn87nxm5ckaOzT3QpGh4ztPxhGd74hS2godcQF4j
	 ys9WcV82xX53J92KmOnKN0s63H+3kuQo3YimEcGFRxVuME8HIK7YpvOHxR5+vBDXuYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiRT+YNx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C332606A319;
	Thu, 22 Oct 2026 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiRT+YNx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF71F000C1;
	Thu, 22 Oct 2026 02:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792636645;
	bh=mu0ZdecmwjeGyJjNTgvVUayi9FotXs8zWmgYmq7DBn0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TiRT+YNx/lgHQ1yXQxr9QPqsiqcs+RLqLTMqj2gxU/1W5Zq1oC8HSQb/69DNXic4G
	 y18it3L5P5PBtzxYvtYioketNnsK46pvwXIpWdnns//glGGPHZ9KnOcy9cZoYhQ9mK
	 cg8/qoKwkO7sywYEq6QsVPannc9U9DlUryBm+aEnLogO3Tt0N12awaZH6+flVWLLme
	 sVVRCrXQ/U62zZGm9LN2l69bSIxozwgCAk2Lyz3sj9S9SkNohwXqdC1/CyYFWpmi+y
	 mRRXhg9ZhsBtwFbXQqIXvKhOwIhftUL7/Kmi1PEAkrIcV9VCL+Y/UCy/2qefrn71sB
	 iehmc92NUKGgw==
Content-Type: multipart/mixed; boundary="===============0611072890556344315=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cc14f512d55c6d2db491abe7d6021daee3866b53a4b4dd8659c6d8c3800f4d97@mail.kernel.org>
In-Reply-To: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized probe can't be written
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,oleg@redhat.com,peterz@infradead.org,mhiramat@kernel.org,jolsa@kernel.org,akpm@linux-foundation.org,liam@infradead.org,ljs@kernel.org,surenb@google.com,david@kernel.org,vbabka@kernel.org,jannh@google.com,hughd@google.com,kees@kernel.org,mingo@redhat.com,tglx@kernel.org,x86@kernel.org,linux-trace-kernel@vger.kernel.org,linux-mm@kvack.org,linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 02:37:24 +0000 (UTC)

--===============0611072890556344315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> uprobes/x86: Don't WARN if an optimized probe can't be written

TL;DR: Commit message only: it says all callers handle the error, but
handler_chain() ignores a failed unoptimize on UPROBE_HANDLER_REMOVE, so with
the WARN dropped that failure goes unreported.

>     uprobes/x86: Don't WARN if an optimized probe can't be written
>
>     __arch_uprobe_optimize() and set_orig_insn() do WARN_ON_ONCE() when
>     uprobe_write() fails, and user space can make it fail:
>     - -EINTR from get_user_pages_remote() when current is being killed.
>     - -ENOMEM when COW can't be broken, since memcg is at its limit.
>     - -EINVAL from __update_ref_ctr() when the process cleared the semaphore
>       of SDT probe.
>
>     Kill the processes that call probed nop10. It warns in 8 of 8 runs:
>
>       WARNING: arch/x86/kernel/uprobes.c:1186 at arch_uprobe_optimize+0x291/0x3a0
>        uprobe_notify_resume+0x1c3/0x4c0
>        exit_to_user_mode_loop+0x63/0x4e0
>        exc_int3+0x1f3/0x250
>
>     The next patch calls set_orig_insn() from fork(). Kill the processes that
>     fork and keep mmap_lock busy, while a trace event on nop10 is enabled and
>     disabled. The kernel with the next two patches and without this one warns
>     in 3 of 3 runs. The whole series in 0 of 3:
>
>       WARNING: arch/x86/kernel/uprobes.c:1161 at set_orig_insn+0x161/0x170
>        register_one_mm+0x154/0x180
>        uprobe_dup_mmap+0x61/0xb0
>        dup_mmap+0x149/0x9f0
>
>     The callers handle the error. arch_uprobe_optimize() marks uprobe as not
>     optimizable and byte 0 stays a breakpoint. set_orig_insn() returns
>     the error. Drop both WARNs.
>
>     This depends on the previous patch. Without it WARN was the only sign of
>     the bytes that set_orig_insn() cannot restore. Hence no Fixes tag.
>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This isn't a bug, but the changelog says "The callers handle the error".
Is that accurate for every caller of set_orig_insn()?

set_orig_insn() is reached through remove_breakpoint(), and one of its
callers drops the result:

kernel/events/uprobes.c:handler_chain() {
    ...
        if (!filter_chain(uprobe, current->mm)) {
            WARN_ON(!uprobe_is_active(uprobe));
            unapply_uprobe(uprobe, current->mm);
        }
    ...
}

unapply_uprobe() ORs the remove_breakpoint() result into its return value,
but handler_chain() ignores it.  So if a consumer returns
UPROBE_HANDLER_REMOVE on an optimized nop10 and swbp_unoptimize() fails
(-EINTR, -ENOMEM or -EINVAL as listed above), nothing is propagated or
logged on this path once the WARN_ON_ONCE() is gone.

The other path, register_for_each_vma(), does propagate the error.

Could the changelog say that handler_chain() treats the removal as
best-effort and ignores the result, instead of saying all callers handle the
error?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39710454342
--===============0611072890556344315==--
