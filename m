Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051935;
	b=2D20ZQUusAacaZSgi5hsy7awrwoo/6n3wPqtAyUkjd2o2VGCB0RYaOrH44nLcSafG7Qu
	 8daATiFseYuK9GvzmVWs0W1aJYTlFw8xIvGC7ysZRmylm3sNZc6kFvTa9mJvtrK8ydCx/
	 j1UGdRXfAG21EjYshh/CHUE9uQZgrIU2Phi15M26b8oitv7ACCAYVDYNZHphT6uQMn4Ff
	 GQe1yispjkTsG2SpBV1IvLj6AQSkmrLbPQ3HUutebm1BPsij+HsGTg5JqnxVZUv1drFD9
	 +CzynxpeiOif5Opa/G9q36a/eZDdpZBU/5bZ53YwTgTDlHFpJKE8kT4Q4U8Ky3eUHeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051935;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+5Rlbgu4q4C6Xebd2PlI3gcqETDMCWbW6so/ifyJrk0=;
	b=Kekc/BB66uRIyjydILwCbomYDBheRh01Wu/mLonwLzCtPUFsCBvQhuIyBwP6CIpcBszw
	 edwL6Uax1NXmztANZXHlVz3zQEWJCuYITRGkNVdmXHQpydeOeP49p24dEpQsTm3nIViar
	 cCAFXPRtPkodcFGMtXU33kojc7K9wzbQNdk/SPPf3H8F0ngf8V64mKX2eBo0i8IAlYU4X
	 jA4nfBJPYCOJ9TwAe6nY/3LpKOsecDM9EGzK8gt9mgIMgt9DKTlWn1njgYVCXd27Kal74
	 JAhZ8UDFbZ/dtI8f+LD4+rIg61NsU8At0HSkucXkRlQUOvXN1ghGzXXIxxvTVQO+Ifg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0MLxcaU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD1606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0MLxcaU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EA91F01825;
	Mon, 26 Oct 2026 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793051935;
	bh=+5Rlbgu4q4C6Xebd2PlI3gcqETDMCWbW6so/ifyJrk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E0MLxcaUY2jLVniU8zEJlZa21Kqg63r2mI6Hcjr9pJL18AkKBp9yhHrpjGmJDUynC
	 M50z2pJsr2ckAYAwI9dUkgmPi1u7M6cLqKY3EshkZ55H898jtmtCPJcRoWWFAG+mvM
	 pKKPQ2vbczaxO3UiJQKWEiZmijY65QV4whcA5IONchHwqw54V9Mqrv84Hljj++WLLT
	 RmsMhSwYMFF0dV8p96QIKsEKZS7EANKlkAeDzqXuH6nA41gGfRyDC6SI+Of+/qBvOk
	 +S0NLTB5F9BO7mBiOmJJRbqDpp/NhpFvuN7yIdyFurWGL5vkV0PYgeiGDOEVytvyUX
	 UNoXlQ1k3xdNg==
Message-ID: <sashiko-outbox-185771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/10] perf/core: Don't unwind the user stack
 without an mm
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-6-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-6-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:58:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> get_perf_callchain() only checks is_user_task(current) when the regs it
> is given aren't user mode regs. However, BPF's bpf_get_task_stack() (and
> bpf_get_task_stack_sleepable()) pass task_pt_regs(current) when called on
> the current task, which are user mode regs for a user task, even if that
> task has already gone through exit_mm(), e.g. when called from a program
> attached to exit_files() or to the dying task's final sched_switch.
>=20
> perf_callchain_user() then unwinds the user stack without an mm. That
> access does not reliably fail: the user half of the address space
> belongs to whatever mm happens to be lazily loaded, if any, so the
> unwinder may read another task's memory. This affects e.g. arm64,
> riscv, loongarch and csky, whose perf_callchain_user() doesn't check
> current->mm itself. perf events themselves are not affected, as
> perf_callchain() already clears the user callchain request when
> current is not a user task with an mm.
>=20
> Check is_user_task(current) regardless of the regs' mode.
>=20
> Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D5

