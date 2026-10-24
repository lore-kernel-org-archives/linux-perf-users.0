Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878485;
	b=P9c/UtCyQiRPtPDWqQH9eU1KpHKjP+CsHNfz1F0RT2MsiiZq88WZiTZ1SJpmmoEV/e/P
	 S8afekOl3M0AKGrGwapcq13h6w/koYfxwBi87jyUZXtR6ZV7VHEUrZrfhc/97nAlSr3lB
	 uyXMuCvC1RfK0ujVqFVh87x1kaiVWd4j0sJEfPjNPZ//LaH2cXqe4h9zDsA+2fj5kZbBl
	 G4aEYYqwTyAnI23OveLeEJB+i+dvyogUxgqBc0FS5sy973i89mDDHATgszypk2aoCVq8h
	 i8Ti8qeQ9oct4uAXu1IdE8gaaCEGcNMM/w8bVe2ahEl/RgJG83wYltJ1T+wdh9yW/gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JmD212dqiCvy6tSTM23Qs2hPsr1vYiQbhUa6mJU4vUA=;
	b=mh5s5E/h2vqt0cNA/BkdF0FXRMpSmuYGBOorDnO2ghIvBSyD2enNZBSsOH0v9hIbc2+B
	 5UuXQGV8bpOc7Mu2mMzBG60zutexk4Jb9sVwa/Lb4+WyF5IxXcgCt17yxmn8Q9iWTRkfh
	 auFYw8Go7m0q/T25fJQIa2xLdR4p4yb+x2nTH0piEJK/Zh8j2ywgv6GO6tOJ/2ezGdeh6
	 EyQYyq/w+KBbO7Z/KyPFgKzMNCJWuYB7eTOcbYL9uKsMkkczaZAHmrKv3zDcZEoa9m0qM
	 Rd7F9kdoQEfRenehkHwFmWk8UP3U3Iu3znyosno9b1uk6MxNco9gmYIMEq8MzLN1lag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7pEVGc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58E606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7pEVGc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AB21F01825;
	Sat, 24 Oct 2026 21:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878485;
	bh=JmD212dqiCvy6tSTM23Qs2hPsr1vYiQbhUa6mJU4vUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7pEVGc8NRPgg3S7fhLksLGaARQ9YF7EOz1FIlh5zriZjUc3jeD/4TblnKenNVRGs
	 uvRo+UPVjgxp2UE74AbEiaFXv36xdViBB/FH4kDjgi3AnU7QLN5Ws3jRi8owJJVSnr
	 OIm5/nnwxlZDsGEoHO9AI56zKx8diyeYPkGkfG4SmDJlcPxSwDHfnyBGvxNNExYrn5
	 giC2LZGPc47E0yVCzBJ6eM2J1fXRUlSh4yb6LS24nv3y6JlfQeuwwcYx49wUqK9K9A
	 pPBvzrE1n47Zl0YZ9+uS66GKrKIDgf1jxI/Sz7yZ+f71949dB5kwBKc69Bhq9/qHN/
	 i4NzlBbTshiBg==
Message-ID: <sashiko-outbox-183902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 02/10] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-3-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:48:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In __cmd_ftrace(), incoming trace data from trace_pipe was historically
> buffered in a fixed 4096-byte array allocated directly on the stack
> frame. Furthermore, reads were written directly to stdout via fwrite()
> in arbitrary chunk sizes, rather than as discrete, well-delimited
> trace lines.
>=20
> Refactor __cmd_ftrace() to employ dynamic heap allocation for the read
> buffer alongside a dynamic struct strbuf to accumulate streamed
> characters into whole lines. Pre-allocating the strbuf ensures that
> line processing incurs zero heap reallocations during steady-state
> polling, whilst the stack frame of __cmd_ftrace() is reduced by over 96%
> (down to ~160 bytes). Emitting complete lines provides discrete records
> necessary for subsequent call graph parsing and inlined function
> reconstruction.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D2

