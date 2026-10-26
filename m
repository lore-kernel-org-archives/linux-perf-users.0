Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051966;
	b=iPLRYfyUp7BbtsdMqKkgV5BcpEgaXAn7FJGa542nHFcgeN7PO7hiFyi3U9uhr6axJuZw
	 2abOFB3Ot5L4UJ8YobEzh+DBZj6TJXtBMwTJY6Xv17ctsxcwSItdQDVYxAbkIpT7bXudB
	 KGmcs15nTZXiA2qdIE+AsgnoGVJ7Pd8fE18YNLlWM1oMdvXsUPW5IZHLNZqmgHkpz30mL
	 EGOOlkms+u60qtileOC61VGzXHiBzGymAllx2Oyh+zsBO/QE5Sr6c1feHCuNOBcbupdpW
	 m5c313J7cpok4p8qArVTQ2M4yp8Wwuzgqyl/pECUr9zOfdYsxbJwbHTaqDa+Kjnt83w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gQsH/zy6udEOoBExel9KZqNwLi84gNI+G0wOA5pCaHM=;
	b=Fh/H1pADaCQLRjGPTQnHmcNFDWovlyewxw/xUqzigbUZhBYjJsS/fFumZQnSSSl4Z8Xb
	 b1NMfQyvlRS02vV6lH1lXrQp7zFFSkRTGdI0WrC9QKvlryAmMzrjsbhUUqHf6FSaE75cI
	 aDyl5HnMfV6PWR/I/CCRvSks/frNEuU8D3RotI+xpb/YfHNZi7oKiM8S6AgsSxCrDfx+i
	 HsgjU0b0Y2K2r+i1HRBS4Rg2K+7B9HUOgyzIBUfRWgUARWbq74VywxLSsCxbdzFVBbZmf
	 44pW2jT1CVQ+4hgH/dA3+EA2Vvbj6azC6Xond8mAlFL0tewIstjV7qrowniV+QSLoow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPVS5uOs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17759606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPVS5uOs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819951F01825;
	Mon, 26 Oct 2026 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793051965;
	bh=gQsH/zy6udEOoBExel9KZqNwLi84gNI+G0wOA5pCaHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WPVS5uOsurYi3cqnwcUH5tC3k93+cXBAJ/tOuWYInDc1Hh9oO5DuY8MUc/b55h9PR
	 GvbXKIfXPRSZwhpQ/Y4SpMOkaKEid5o2oJOKK5dS6WW28EMmOghWRwoD6XkiF644xY
	 NMvg6ADEf3jMK0ih1yVEOhctbUsR+hwNxpyQh6gjLoNAf4haV8/NCbONxo2DL9Fx5h
	 ArQ11U/XlkmJQkInqg8juNqyLzLWXYns0oenZEnLQ+bh6qmftYZJ2C4L5G9mW3apde
	 J8fe31d0XcBllrNgEYDGviiz3W6+lmdmZOyhLt+6cCYWreyYOjmJVfxRWB2WXynYup
	 i6Ec62o4+e8qg==
Message-ID: <sashiko-outbox-185772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/10] stacktrace: Don't unwind the user stack
 without an mm
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-5-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-5-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:59:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> stack_trace_save_user() only refuses to unwind the user stack of tasks
> with PF_KTHREAD set. That doesn't cover all tasks without an mm:
>=20
>  - A user task that has already gone through exit_mm(), e.g. when an
>    event fires from exit_files(), exit_task_work() or the final context
>    switch in do_exit().
>  - PID 1 before it execs init, and usermode helper children before they
>    exec, which are created with user_mode_thread() and don't have
>    PF_KTHREAD set. E.g. booting with trace_options=3Duserstacktrace and
>    an event enabled with trace_event=3D unwinds PID 1's "user stack"
>    during initcalls.
>=20
> With the ftrace userstacktrace option enabled, the architecture
> unwinders then read the user stack without an mm. That access does not
> reliably fail: the user half of the address space belongs to whatever
> mm happens to be lazily loaded, if any, so the unwinder may read
> another task's memory.
>=20
> Use is_user_task() instead, which also checks current->mm, as perf
> already does for the same reason since commit 76ed27608f7d ("perf:
> sched: Fix perf crash with new is_user_task() helper"). This also stops
> unwinding the user stack of PF_USER_WORKER threads, which never run in
> user space, matching perf.
>=20
> Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D4

