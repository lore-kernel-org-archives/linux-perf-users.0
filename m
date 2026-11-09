Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215176;
	b=g9+WK777HmDtqrc4JiseSaJQDyFMJTOfohPQOQB9yDij15QKzMXGK9rM9FLiPADYA4Rd
	 gdTg9YjOJrI5spRZEmhm6DxjPvaNv5vgeXiSqTP3osF5sOoNOHiJGXu9CXNtOPB9jhjFg
	 mu5MsXei0bDbQ0V5ix18u0p81zndUe5JSbK+bXu8HVdYgpimw/TfAjb3LEk5odWmwGe4l
	 zB3EV0raSzqSOlSt3et2/V15oFjK7qwzp7slOBU0hD3VbHsN8A+rRukrMs7pZZZkymoFX
	 sD1wIhdHPUspuQAaujgCXApLGKMo3pY68Ki+trmOL0Db1JEkwex4xfm6QROlTyRkRDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yGfd67TEK9V4Fftf7t1aMz+cdyiwp7+2eRd8Ijh3QqQ=;
	b=ht0Z5knzLQ/xT+KTlnD6PTzoaRY59zojJ+h4uzd6XWfkRzg4apz75zTg3FkEVTaZucOu
	 U4jzbZFiA4zM97rRz5gkxB3c2WmW/eWcYJPCxSMIxiWS46Bo8SYbaLnv9bGXMBNpOuJjo
	 Ustu4X8d6htqTrTpfzPiq3OOKOUo1dcsBxOMDrbdpMlWv+kpF7Dg+uO5M+Qh81Sk8tML7
	 SazwbZiklf4+kfdC+mshb0uZrU9MZAbWzqN7XDOaUn92ZHgORNd71fix0Q4OE1O8/7WaB
	 ZdWPWnF2GcO6f5yeFZE9Kgm/hXoG9Dfc0caYy8Wmtz4yZIt0crIsadXy0sXReQw1eSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgpOB8ci;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A2606EE80
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgpOB8ci
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5565E1F008AB;
	Mon,  9 Nov 2026 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215175;
	bh=yGfd67TEK9V4Fftf7t1aMz+cdyiwp7+2eRd8Ijh3QqQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YgpOB8cix5tqsGMNzRdTLHoP4hpNe/AWnDxzLv7PRROkmfsi1PEiVAgEL1feAQDyr
	 /Fj4+sby02TrGE+5MRXLjtBfGE/EqGrxaTy0yuc4aY819DghZGZeuVvr7SMCR5qrxr
	 nT7Dp4HL3+BnyyrJ5hsOaaYsvjGoiOFF6AYms77D1H5cCW2+P9UW6Mols26lZ/kOwE
	 oYQKq9QwE2QMAJk41628+3nKJpmXU0A1szruBxzs7ZA4kyyYWU+TqbtduhWuKLOq1P
	 Wfm7A0Im5ifGSW/k5Sw51S0jVkzxnefPgJSaaGNJFHQIppmPo9dkfJvdXnNTRMwTiV
	 LS4NDTjbj0EiQ==
Message-ID: <sashiko-outbox-204667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH, next, v2] perf iostat: Release the port list if command
 allocation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261109090143.1749-1-lirongqing@baidu.com>
References: <20261109090143.1749-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:06:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> iostat_event_group() takes ownership of the root port list and frees it
> via the err: label on both the normal and parsing-error paths. When
> calloc() for iostat_cmd fails, however, the function returns -ENOMEM
> directly, leaking the list, its pointer array and every port in it.
>=20
> Route this failure through the existing cleanup path instead. At this
> point no port has been transferred to an event yet, so
> iio_root_ports_list_free() releases the whole list, and the trailing
> free(iostat_cmd) is a no-op on the NULL pointer.
>=20
> Fixes: f9ed693e8bc0 ("perf stat: Enable iostat mode for x86 platforms")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109090143.1749=
-1-lirongqing@baidu.com?part=3D1

