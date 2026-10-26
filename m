Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051976;
	b=gTNyy9NzZrrC5ysZfw1WGsMkHb/PUo6iWaMCo+cDC26payKZn/tqyAKeIZMkSWH1SYVz
	 61+e2oOnLu6HTRaiVfvk6TpZnT/b7V0TglgN0YoGRNhT7rAh5Y2OnCMP510DHCJU8M1tz
	 kOFadvB1h9xb85Ysn92HgrZ5PuXcYn94Omu65vAQd/tKHd5tQFyxahYfm5IdSUaVUf2Xm
	 /4bdh9cW0BAF9Mz8rk+KMMJSwF2lm/ONO/2Us2yyRj4g5AuLvmwLLghz7BNg3OFhLBb/8
	 6gDXcj1SD8UetTBIcjftWvixWvKbQNRvju/FoB5rt3lWngZRyIKsPedD8eG9MuVnAcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=24dicYlwsy8HWTs3fdRJWEemOK7GwTB8JFwDgtrqfYQ=;
	b=XtEJmn/shwBsxJIHZb6GhDIM44jd5Z09JyI5TzZrOvxYH2IMAmCJ0H+GuI0hFsS6Bli/
	 11KdGKVwvRF4xEG+5TkO5Ul5I4ueS7jQhpq1s5HO19tMNiTIn+5dzgBsJDJh6XwjkxH1k
	 JTsCZaNesFuftArGjjggcq8K8ZO48ZGQGtTcL+pnQEuzx4GoN66c3+BwfaKhpfFQyUHDq
	 kBkFALVtagXmtpXZpNu4q4sISYNQ41XqwfhQ1pumJxylJunVvIEnYw6ltHmG0ptNDyd1w
	 msT32i/I37F0c5Jr1PntechwatwlFRuPGP2/igDX109SggNLgM8E1xsDMmKMtLFzzZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kn9pfmSM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D3606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kn9pfmSM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8561F01825;
	Mon, 26 Oct 2026 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793051976;
	bh=24dicYlwsy8HWTs3fdRJWEemOK7GwTB8JFwDgtrqfYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kn9pfmSMop+NpV+CV+ysPIwULFaOWUv0fMke7adNeKCwuU77SpH8GrMXnCgnSzv8D
	 Ioqn+BAY4GzMP+aZ9/VDRM5R6zEMHmyeF1HbG4l63FKHFnc4RcdHkPkVM0BXBOMkCW
	 kWvqXjfUbkE8TNlrjF0z74cicdInjZOrD+2tjGysCHogZo2Kce36Nat28un8ecZt1F
	 BvotW+a3zmAWDaMEep4YbWvve9/dqsi//91gOjIUQgsIEpxUm8cPy5rNCsHKfbVMbO
	 G1OHBrFOXJfOCcjRgeoV5fHkDwuQBHGE5GIT3gs6w5XsmaRHEdGQ67UpqBgMlSlfEO
	 WsvtNdui2wgkQ==
Message-ID: <sashiko-outbox-185773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/10] bpf: Fail sleepable user copy helpers when
 current->mm is NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-4-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-4-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:59:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Sleepable BPF programs can run on behalf of a kernel thread, or of a
> task that has already gone through exit_mm(). For example, bpf_wq
> callbacks always run from a kworker, bpf_task_work callbacks queued
> late enough run from exit_task_work(), and lsm.s or fentry.s programs
> may be attached to functions called during exit_files(),
> exit_task_work() or from kernel threads (e.g. security_file_release()
> from a kworker running delayed_fput()).
>=20
> In such contexts, bpf_copy_from_user(), bpf_copy_from_user_str() and
> bpf_copy_from_user{,_str}_dynptr() (when reading from the current task)
> call copy_from_user() or strncpy_from_user() without an mm. That access
> does not reliably fail: the user half of the address space belongs to
> whatever mm happens to be lazily loaded, if any, so the program may read
> another task's memory.
>=20
> As there is no user memory to read from in this case, fail with -EFAULT
> without attempting the access.
>=20
> Fixes: 07be4c4a3e7a ("bpf: Add bpf_copy_from_user() helper.")
> Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
> Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D3

