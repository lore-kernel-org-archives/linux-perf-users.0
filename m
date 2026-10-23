Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788677;
	b=1X592fmCC1jCZGXfwnZlGA9lLKlujrmxbSpfpnoZkl4iIN2v4Syd/EXKQQEmlbk01Vab
	 +hYXmPUGz8kFpndRG4CuNUJbco8N953nNj90OsmTxsg/hfhiBtK3FI7h0vGWYRBTaV7Qo
	 M1erbg9sWcujdkUeN8TpYxQ7As2DBw3u6qWlBElOs2WahuI9g4PxQy+Ed0ktHEg/WSTeZ
	 mfg7DNQDBET3Vg8CqbwXdaInmhgjYzmKzBLZPMA66/YJv+3AVWmwCav5yI5Yejoz2Jig7
	 dUyPPloDYpsM3GZ2wDbaEMXH6Fxgw4f0l4cX3aHkckkxxW/2LsS1sq/cQMnn6kjozug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788677;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/OcUX/aLlPX2c4N33EvgPxJCYKMlff+nB//66pDqPWY=;
	b=OvkvAvrt51Y5H05bAAezXYQl70TzjT+//kwRuAkMStUZ4jggpwsAb19HrLsp5JFvmbmF
	 lNpgZhZfyDPEo6hSPe20OZsnx9hj5Iqed2ZUrP+dxB+Xp0bUDP4hfkH9K8+JtmV4kVjbo
	 F4bGk4DH4pYs929eIF0l4oZIVv/P5teCh2RJU7gYK5AozRXsJiibdQXswQnptHI+bBx6N
	 LBaGksKC7pHxia8V7u970VBzFHZyF4Y9KH0uXY0YWImohewajP67GhYtLb9jZBuJ1eINL
	 HJ8VZm5ZG4JRN/u9v9Cj/xDlNFpwH4d8Jnlj14OLC84WrPTG/HdAJo7sQj4Et0pI4xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9VRqbQ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5F606A31D;
	Fri, 23 Oct 2026 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9VRqbQ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3FA1F01825;
	Fri, 23 Oct 2026 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788677;
	bh=/OcUX/aLlPX2c4N33EvgPxJCYKMlff+nB//66pDqPWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N9VRqbQ5AeurshupeTXKA3/1KTdV7whk+bpY0Iy3pEyWOK1ty/CMmfo2uV7fE3ScG
	 cp9sKV9g602uNUtO0K74gWDNg7pDioLgUXkx1n3+2Yk0w3bnQWXMY2syuSAU8jAMiz
	 fzSsPz/P6NT9F/TC51Pk9KmLrxYYXTOde3KuwPymGNKpCTrbdmEROFCvxbN+vQZV+V
	 17i29HBRZnqU+9y1fPvomjjLz+nJACiK6VD9SO9aSxYjE7qXdObynBo4UaJTlAmAKw
	 WGrONQFE5rS3hSZ/9e/hlwLhZtzEpw7yCs6X6iNiCMM+CKFUka3EPWOwje3Cn1u42q
	 V4Xd3NZPSjMhQ==
Message-ID: <6f1bd275-6751-4931-b996-b1c8ee6e4629@kernel.org>
Date: Fri, 23 Oct 2026 22:51:06 +0200
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/9] uprobes: Don't sleep on mmap_lock with
 dup_mmap_sem held in dup_mmap()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, oleg@redhat.com, peterz@infradead.org,
 mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org,
 liam@infradead.org, ljs@kernel.org, surenb@google.com, vbabka@kernel.org,
 jannh@google.com, hughd@google.com, kees@kernel.org, mingo@redhat.com,
 tglx@kernel.org, x86@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/26 03:57, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> dup_mm() takes dup_mmap_sem for reading and then dup_mmap() sleeps on
> mmap_lock of the parent. When another thread keeps that mmap_lock busy
> register_for_each_vma() waits for the reader, and every other fork() in
> the system waits for the writer. The parent doesn't have to map the file:
> 
>   A thread 1:  mmap(MAP_POPULATE) -> mmap_read_lock(A)
>   A thread 2:  fork() -> percpu_down_read(&dup_mmap_sem),
>                mmap_write_lock_killable(A) sleeps
>   tracer:      percpu_down_write(&dup_mmap_sem) sleeps
>   others:      fork() -> percpu_down_read(&dup_mmap_sem) sleeps
> 
> dup_mmap() needs both locks. Don't sleep on one of them while holding
> the other. Sleep on mmap_lock and trylock dup_mmap_sem. If that fails sleep
> on dup_mmap_sem and trylock mmap_lock, and so on. Taking mmap_lock and then
> sleeping on dup_mmap_sem is simpler, but then all threads of the parent
> wait for mmap_lock as long as the writer holds dup_mmap_sem.
> 
> Both are taken in dup_mmap() now, so release dup_mmap_sem there too.
> Commit 8ac662f5da19 ("fork: avoid inappropriate uprobe access to invalid
> mm") moved that to dup_mm() to hide the child from uprobes until mmput()
> when dup_mmap() fails. Since commit 43873af772f8 ("mm: change dup_mmap()
> recovery") dup_mmap() removes all vmas of such child before it drops
> mmap_lock.
> 
> dup_mmap_sem is released before dup_userfaultfd_complete(), so the monitor
> that doesn't read UFFD_EVENT_FORK no longer blocks every fork(). During
> that wait register_for_each_vma() can find the child, while no task points
> to its mm. The next patch deals with that.
> 
> Thread 1 of process A loops over mmap(4G, MAP_POPULATE) and munmap().
> Thread 2 calls fork() in a loop. Nobody maps the file. Process B calls
> fork() in a loop. 32 cpu VM. Median (max) of 15-25 runs, msec:
> 
>                          the longest fork() in B    attach
>                          before      after          before  after
>  uprobe_multi, 1 uprobe  206 (219)   0.10 (0.30)       220   11.7
>  uprobe_multi, 4 uprobes 208 (428)   0.08 (0.32)       219   13.5
>  perf_event, 4 uprobes   419 (424)   0.10 (0.44)       632   11.4
> 
> During detach: 265-293 -> 0.19-0.37.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/uprobes.h |  5 +++++
>  kernel/events/uprobes.c |  5 +++++
>  kernel/fork.c           |  4 ----
>  mm/mmap.c               | 19 +++++++++++++++++--
>  4 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index d34dbc0fbbfe..6d74efa80d04 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -211,6 +211,7 @@ extern void uprobe_unregister_sync(void);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
>  extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
>  extern void uprobe_start_dup_mmap(void);
> +extern bool uprobe_try_start_dup_mmap(void);
>  extern void uprobe_end_dup_mmap(void);
>  extern void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm);
>  extern void uprobe_free_utask(struct task_struct *t);
> @@ -277,6 +278,10 @@ uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end
>  static inline void uprobe_start_dup_mmap(void)
>  {
>  }
> +static inline bool uprobe_try_start_dup_mmap(void)
> +{
> +	return true;
> +}
>  static inline void uprobe_end_dup_mmap(void)
>  {
>  }
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a9274016c55d..92ccb730278f 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1927,6 +1927,11 @@ void uprobe_start_dup_mmap(void)
>  	percpu_down_read(&dup_mmap_sem);
>  }
>  
> +bool uprobe_try_start_dup_mmap(void)
> +{
> +	return percpu_down_read_trylock(&dup_mmap_sem);
> +}
> +
>  void uprobe_end_dup_mmap(void)
>  {
>  	percpu_up_read(&dup_mmap_sem);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10f2d05d816a..8fd6be932afe 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1539,11 +1539,9 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	if (!mm_init(mm, tsk))
>  		goto fail_nomem;
>  
> -	uprobe_start_dup_mmap();
>  	err = dup_mmap(mm, oldmm);
>  	if (err)
>  		goto free_pt;
> -	uprobe_end_dup_mmap();
>  
>  	mm->hiwater_rss = get_mm_rss(mm);
>  	mm->hiwater_vm = mm->total_vm;
> @@ -1558,8 +1556,6 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	mm->binfmt = NULL;
>  	mm_init_owner(mm, NULL);
>  	mmput(mm);
> -	if (err)
> -		uprobe_end_dup_mmap();
>  
>  fail_nomem:
>  	return NULL;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4bf26b0f1e6e..6ce654e33e3b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1713,8 +1713,22 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  	LIST_HEAD(uf);
>  	VMA_ITERATOR(vmi, mm, 0);
>  
> -	if (mmap_write_lock_killable(oldmm))
> -		return -EINTR;
> +	/*
> +	 * Take mmap_lock of oldmm and dup_mmap_sem of uprobes.
> +	 * Don't sleep on one of them while holding the other.
> +	 */
> +	for (;;) {
> +		if (mmap_write_lock_killable(oldmm))
> +			return -EINTR;
> +		if (uprobe_try_start_dup_mmap())
> +			break;
> +		mmap_write_unlock(oldmm);
> +
> +		uprobe_start_dup_mmap();
> +		if (mmap_write_trylock(oldmm))
> +			break;
> +		uprobe_end_dup_mmap();
> +	}
A note that I will have revised fix from Josef conflict with the changes here.
Nothing that cannot be worked around, but the whole "take writelock in dup_mmap"
is shaky as it seems.

-- 
Cheers,

David
