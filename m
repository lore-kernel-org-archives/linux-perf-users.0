Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636648;
	b=RBKtrcbJjhjrEpwrJ3ey3NCjYyes1TLbKE+fkV9osHHXztSaFEORdNJGwOhMFf4WCSR+
	 GRwRoqhr000xbGQEfF3iMHARIdhYaen515k4NBJykndqIG6XFfKSXZnSvpWAnHAmEgBzL
	 lLnnXz+7WRChRaHd0legOebUJ8CZv0Z8wYYGo7VRpJsE4tbMrR0ueiC+WZSEvsmGDxDhX
	 G+IqqX09CX9qOkQLNJd9p2SfM/MoJfWQOZu7MbyrfJWugl7HLlMjOUTLK5iSPbBmJQhzD
	 0LIqndpFqGjX84sJn553A7k36mNrV7uhDLmh08lXsE8J4lk00rUEwiCvWKKIC+XCtaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636648;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=s7IDBrOb09HW515M8YqXw6KmuJ850iUtgqwrNUNLuDg=;
	b=X5z0tf/3UgTJnmCjolFPHrhC+wEkkxRk7N41Ohg5bhrln3RWEYZvoWZ+zW9qdBoq0/qi
	 zXJNbx1b8qpbQ4+7gFSLpTZp+TJP6JhNVbhwHwJkV6n6YgF7zhSIQ4zAbrepeuq0S0VVi
	 7BdDFdC5Qwk/JPB8uMC9AvuPOH+qCm8Kri/Sr2xCG21P/i+QG2XIgQPzLJKrDJh0bDpnv
	 x1YBzA2sQrJhXYIHu8FqDx9FrSTLnooccUb1vUbGHB6848P6SFYJ3Iedi59lO6cD2oDPc
	 jDUieeuu2TDtUxB485Myg0J7xSNjj/5BAYdJAwqOTLObJtRwqs101UXz7bqQ20Ml3Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UBj46MA/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722A606A31A;
	Thu, 22 Oct 2026 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBj46MA/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297771F000C6;
	Thu, 22 Oct 2026 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792636648;
	bh=s7IDBrOb09HW515M8YqXw6KmuJ850iUtgqwrNUNLuDg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UBj46MA/XvLQQfLFsLil3VhVenGPTNYAHO7gSbNprUyfFTL2s6qWEds468MJVOjdm
	 smVFX909FQ8UhUydSfAxnVXetgyA89WIxf4P/DK5PcF4MsPgtsiJP8wPMinaeLZyZL
	 7P3pgAqPGISjeo0SfgqEwINhoOJImeM9VkTOgOY2pCGZ9Gw9vRCXioUBcXXiMDIoJJ
	 hgRLfO9d91u3UrBt+VkhaUGj8poZCFY0KJaNyQe9pTOwrAl0LTzS9ye40teAW3CE6B
	 eeHcDQWbOKCYS6+7mE3PWmnbBxWkheL5OrfdOkIuApNuMolgY5KvW7+GptMJWjCn38
	 uqVckgRXYkvIA==
Content-Type: multipart/mixed; boundary="===============8781031005950137975=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6d62321ca2f86cd19e5dbe9bac70a6c964c208e72c8fcb756fd4e12a94edad95@mail.kernel.org>
In-Reply-To: <20261022015712.1297331-10-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-10-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 9/9] selftests/bpf: Test uprobes and fork() with busy mmap_lock
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,oleg@redhat.com,peterz@infradead.org,mhiramat@kernel.org,jolsa@kernel.org,akpm@linux-foundation.org,liam@infradead.org,ljs@kernel.org,surenb@google.com,david@kernel.org,vbabka@kernel.org,jannh@google.com,hughd@google.com,kees@kernel.org,mingo@redhat.com,tglx@kernel.org,x86@kernel.org,linux-trace-kernel@vger.kernel.org,linux-mm@kvack.org,linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 02:37:27 +0000 (UTC)

--===============8781031005950137975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test uprobes and fork() with busy mmap_lock

TL;DR: Nit only, in the new uprobe_busy_mm selftest: the local now_ns() helper
duplicates the existing get_time_ns() from testing_helpers.h and could be
dropped.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c b/tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c
> new file mode 100644
> index 000000000000..30614e8b92cd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c

[ ... ]

> +static __u64 now_ns(void)
> +{
> +	struct timespec ts;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &ts);
> +	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
> +}

This isn't a bug, but could this use the existing get_time_ns() from
testing_helpers.h instead of a local now_ns() copy?

Both read CLOCK_MONOTONIC and return tv_sec * 1000000000 + tv_nsec as a
__u64.  test_progs.h already includes testing_helpers.h, so get_time_ns() is
in scope here, and now_ns() is called about ten times in this file.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39710454342
--===============8781031005950137975==--
