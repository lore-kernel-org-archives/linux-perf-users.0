Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903439;
	b=iO3JA1uO4vhUq2M4PXZiNUroKgUZBhlp3JXAXakDJjVeX4bl/QhV5Q/YmfkYIyjqUioO
	 BWOJUtNhc8ljFUE8+nsROsGuvDCF5Lk0G8R/ZnqwDLpkQS3vuLVeC1l8+UxKuoWfXte2W
	 UeUN8wX9NMjtDQaxp76dKyMLF8jwr8oUBzXCaPG105BfsaVow/eWZLvXUfwZCJXGWAypZ
	 R092/NsxwC1S9GmIL3yrUR+hQ5pyHuLT+mHX7Y54fTntfS+NGEQTB2eZYJO32i0BtsBAo
	 txMU2cPSXc6rGi0Sj+MV8vd1Mp2ckZHR1HWe2vraAjHoclbTc9P7jQrG5TWP/J8NISA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x5d6SYBlXjZlRzlSv5xfu+3xXLsafmzIHR4sM7t1anw=;
	b=VVi41lGkXdLO2pJ1OWPhSkJ2Ps9gO+1bi839qK0fSybfow86Scu5f1a9XqFCm2GPQycZ
	 ACFKXjdwtJEuTPEtJmFVs1fROkGVDjEDzuNMt1qWfPeQenoIcs1anGJxjGOvjRGkBKlYo
	 IFO/A0wS+F6XAKI9wgg+5AKZAGKvKLZSSCOh+OA9ydmtukF2XUX3jTAfNGJCrxD4Oucdm
	 F4h8MPr9aTtag2GngpdBELv2ioEDsxiariQ3A++jRsPwWugIHI7DB6/ldYSEGOBrZXvl1
	 j6eSnRRV0MWQdczAYS/Rz1ChejVfns20EyGYCDz+fam29MWLW8GY7E0Vol6ipuR6CxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDYNjIbU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47493606A328
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDYNjIbU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE61A1F000C1;
	Thu,  5 Nov 2026 18:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903438;
	bh=x5d6SYBlXjZlRzlSv5xfu+3xXLsafmzIHR4sM7t1anw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bDYNjIbURgAzk6ooB71aXEd0rDKcP9fvOuj6B78AGAaTzeRxQETNZ7NBvk92edONO
	 AwvllGHStIj3jbUO0uli5YgTDU/5n2VgPE2+GeX1lGsT7yBD8J5ZcvjC3RaJ0Cz/rm
	 ccTa1sthODbGnv6U1KbtijIJb2GAYkvX8YGnMb/rNqPZ1kGCaVyhEcq8JKLctl3CsE
	 nShOzyq5viLO7EqSL97wl/bodpMG+Pg62kRVPxnyUiOeVt3SABnepp1lrBe0ZWL5XA
	 VjQAgVAhBOCJqmMN3igSgGhlDGU3wj0BDTzQPz6Y/SJdEffrBk4TJJz790j57NK4Hi
	 qmv9whv9+S9Bg==
Message-ID: <sashiko-outbox-199769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] perf annotate: Resolve C++ virtual function
 calls in x86 insn tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105181949.43198-4-yzhao62@ncsu.edu>
References: <20261105181949.43198-1-yzhao62@ncsu.edu>
 <20261105181949.43198-4-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:30:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A C++ virtual function call is an indirect call through the vtable.
> The instruction tracking of the data type profiling cannot resolve the
> callee name for it, so the return type is lost and the type of the
> register holding the returned value is unknown after the call.  It
> matters when the returned value is used directly to access memory, like
> in 'p->next()->val', where no DWARF variable describes the temporary.
>=20
> The vtable pointer and the slot index are known statically from the
> type of the object pointer, so the callee can be found by DWARF.  Track
> the two steps of a virtual call in update_insn_state_x86():
>=20
> 1. Loading the vtable pointer from the object.  When a load from a
>    register with a pointer type hits the '_vptr' member of the class
>    (or one of its base classes), the destination register is marked as
>    TSR_KIND_VTABLE_PTR with the class DIE returned by
> [ ... ]
>   1260:  addq  $1, %rbx
>   1264:  callq *%rax
>   1266:  addq  8(%rax), %r12     # data-type: struct Node +0x8 (val)
>=20
> Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105181949.4319=
8-1-yzhao62@ncsu.edu?part=3D3

