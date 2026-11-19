Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091276;
	b=Gw4bzbOKrO/aCdYMWsIFvOMsQNBvJIcXH0wlNURtLFR9N1EuQ7dq3DuGySq1j35mA3PB
	 Fq07Zz90eRzDYGqDeq9RY6Yx382ILCN7g/ztDeA8qazQsGvtY7bjRv9WyFEGl7+IRtXPN
	 35FwmTocZ01ciz8dEdZDHrse0Rj9ZYhYnawfLObhCiCd4Gvs3oqxhQHALrtU4ak3iZX+f
	 2f+OIXA2vP2o/6WoYEczD2GP3c46vIqFBc9yOL2POxIoMeRHdRwJQae0L0GLAp9YyQh7l
	 A2IKqg2gxUxTfUoU8mhZjee12Q/xwXKcVuv1ZJfLkjGNx0CaSriBfw31hz9M5LFtJAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091276;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wEsl0e7EZ+4DcCQjK4UXmN0cJzWY8UTpp2jBDMS6U70=;
	b=3qukoYIJ3dbIbROjyeEn6JtyIhy12oOJk93WgixmPMoo8WdK403Fs/IyiUWS3n7luBpx
	 AagVgj2UX+3EwuGG+d/Mb7uHZ+rA+xHls8KtcNuQP4rDI6BfWhAiueuujf7u7tyPQ0m63
	 ix3QmBZDmc1xGLfHT4E0W1C1RBYx0S/885OfDliu+ya0c2jffjwc5RgHcV22tFNm43TQ1
	 W03alf0EjLDdSTV3xyZuY45JQjmkGzTXNo1GNJGgiMuWgJVAmmlu2nU2LtoPq+2b/3ujh
	 7r5d4kA+EojU7uimEoZoKbzUK3T+F+E6oPI8QAJ4p38ZGooXeB1fRygbL3+kkF3yfjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUHD2YV9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6B606A331
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUHD2YV9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267611F000C5;
	Thu, 19 Nov 2026 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091276;
	bh=wEsl0e7EZ+4DcCQjK4UXmN0cJzWY8UTpp2jBDMS6U70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dUHD2YV9lDgFJYk/TyY0/IElz2zWXQLgXp5VhTrdC8KlPDEw2vqMrTI1Z2jMv2H0x
	 NtmXDIhCfM1S44y1kT/dlPgjPMkSphsoDPRUVLON7oglAjmGqm78Bs4VVnIBx5QIa/
	 YZ24wVJEpXeBRpTlUWXYm00AqZ2KWbfATqZhzYf5Vv/1OcfGjFN6yIw9Let5rpqI5a
	 bfp3mIMkTkfekV4RI/F37FbS752yrFWhcNhFhv7xLAK3pxmVahWDouJLPSfYUDWK62
	 IFdKNmimlAJOwmrd8j8XIUMGqBnUvFVtn4r24CPGqRacG/MbZ7knltY3YS8i2kITog
	 U2vTd8b2Mhguw==
Message-ID: <sashiko-outbox-223083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/11] riscv: mm: avoid enabling interrupts for
 nofault page faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-18-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-18-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:27:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> RISC-V enables interrupts in handle_page_fault() before checking whether
> the fault occurred with fault handling disabled. A nofault access from an
> atomic context can therefore run tracepoints and open an interrupt window
> before reaching the exception-table fixup.
>=20
> Handle an exception-table entry before entering the generic fault path wh=
en
> fault handling is disabled. Also keep interrupts disabled until such a
> fault has been resolved.
>=20
> On 32-bit RISC-V the vmalloc mapping must still be synchronised into the
> current page table before that fixup runs: otherwise a nofault access to a
> not-yet-synced vmalloc address would take the exception-table fixup and
> fail spuriously instead of being resolved. Order the vmalloc
> synchronisation ahead of the nofault fixup. That synchronisation only
> copies an already-established kernel mapping, takes no locks and waits for
> no I/O, so it is safe in the nofault path; if the mapping does not exist =
it
> falls through to the existing no_context() error handling. This early
> return skips the page-fault tracepoints, as before.
>=20
> This makes RISC-V consistent with the expectation that an in-atomic
> nofault access does not enter the normal fault-handling path. It also
> removes one source of re-entry when perf sampling is delivered through an
> SBI Supervisor Software Event (SSE).
>=20
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D5

