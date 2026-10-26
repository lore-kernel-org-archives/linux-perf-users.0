Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053039;
	b=eq8Cd3HBlZaKHn21uDotfUPcCVNFuXKRg3pXnNffmhpYpuUGC1E34aJfcEX90iyXTWyU
	 AvgapzgGuLKV9c0FMVSW04r34ADDrLqIglaPA5q2IFvj9FCfdzLgICh42A7CiFftmKk6j
	 h4XjvxTDEh4EsYDvgEtGqzqpKQLCRSIZqEx9tmow7XCXF6MmYTBThefHfXBxEwd38JnU7
	 cm7s6CUjVvxVuY4e2cxrgrKoYpiXF4XMVWVB3zJ6AzcCqPOxdPBUTD8RZxxj2PSFLTYEb
	 iFlYgJe6PzIXr6tDBgj4Z16eC1JWQNUVZIlD8OqMPkJdwZX5wdl6/x42u6Ml24zRUmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053039;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ein7yFaT1ug4D2Lva4/9u3q+1buWdrJgJyVbN+MweBw=;
	b=QYmzvzjJL7iTsXN2XbpPgubfGGQkDhaq+4BtOerK5528maVUKpp4PhZmJlMpNbUY9MZH
	 UhqyGfL3x3/t9G6jBr8QmOdypoEiLhJyENNXIwwpJZ+30QmHNzWgw65nlwkVqmywQwjVj
	 /ZTn3LwsL3MBh9JGf0tDF9lFaGm1mov17W9s4pFS3d+S1sSK7SD7uOFtfhrdCLczEWPko
	 wouZWCvob0XCLrEdO4Sv6ALVnbBOfCGyZTklg3wl0tqOrVp7TmyOhroOn/++LOHKC8AHG
	 P/Ias/gV6QDT3AJOG9kp0VuYtejVYgbdVDh42kpa04bvYj8itjbdi3fC47aOpW84tbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUbF5PUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9656606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUbF5PUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792DB1F01825;
	Mon, 26 Oct 2026 22:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793053038;
	bh=Ein7yFaT1ug4D2Lva4/9u3q+1buWdrJgJyVbN+MweBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OUbF5PUpkhGUNhwV//N7cBAKIoe2ogDzvDjeDta2ebaznVAdhEJ4D0WQUKN1gpcQ1
	 F/r0/kLgUBoNRrN2FBgy6L/dNkFIvo4BgRoM/pfmrt+fddvkizFBGNLeON8qGvcCu5
	 URbco0BbO4kfBWSYNskKXQCdCiwYX5bjj7fo3SYh1baQe0pGf4g6pW8/UhqVknigdV
	 LY0Zr1zFVPz+7uxkxIhHZ7uSIEFzWMH/NPWsp4kZ9mVx4qNWl+44FINbeIlXWpVL3+
	 1CnKGvkNkJH/QKqjjHyIj1MmnBjEdLinsH2X7QoKtTu3LLSm24bvm5hIN+MjvTjnqk
	 33M9aoGshjhbA==
Message-ID: <sashiko-outbox-185792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user
 memory when canceled
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-2-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-2-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 22:17:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> scsi_bsg_uring_task_cb() copies the sense data to the submitter's
> response_addr with copy_to_user(). It runs as io_uring task work, but
> io_uring may also run it with tw.cancel set from other contexts when the
> submitting task can't run it: from a kworker when the submitting task
> has exited (io_tctx_fallback_work()), or from io_cancel_local_task_work()
> when a DEFER_TASKRUN ring is torn down.
>=20
> In a kworker, current->mm is NULL, and the copy does not reliably fail:
> the user half of the address space belongs to whatever mm happens to be
> lazily loaded, if any, so up to max_response_len bytes of sense data may
> be written into an unrelated process.
>=20
> Don't copy the sense data when the task work is canceled, and complete
> the command with -ECANCELED.
>=20
> Fixes: 7b6d3255e7f8 ("scsi: bsg: add io_uring passthrough handler")
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D1

