Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550908;
	b=4haG464QEjwRxsgYknX9cOBFQYWFOhYlxlmCbX+YA7G1HiI3FWqOPz+Podyi5GjF29On
	 hVY751Caw8jk/dgp6Zk8I7xrOM6x+2dA7WX8GyAUDG07o1iN/R6gVXe4yJ7o2XOkiXoLQ
	 wn9KzghEdUAd+qrjNtxw/h9gC+VCgCoqmzQpz64SEC1A1K/alJ3adMn7mVpvANyYXUwhp
	 PKBW5ZWbiz9UGkmlSuma9dsCh8QuwrTA8qt9UOJTHeB7JRTKlQnJ8U/c0pMWL6LuCjmyM
	 387/d9Je/MdcsL8y1F9ejEQBh9knRuVcEugVAvaSR2Yhx1VH9V8g3OdVBiSIDqLhNIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rCylkUImsycsivPZAsEK2+DuH1APlrJrm2+wwho5AjI=;
	b=XuOxEEyfVIc9+kfWqKgjaC3/l9rjpBewGT+Q3b1gyrzz2tEnWL6KzVvO2vuYfrm1eoZ7
	 SPx2Dv8lM1bcTxUg/UOeh/n4EmjSNoDb/WBzCfPJGGi5zIXXLhCKB78O0I0Iqvbmrm4Ro
	 D2HT9Kp8IwPYCcmbmBwcdLKTmmTFgnh/YKaooGtJhwYaNAmHuYfaBP3XOcgfu/HF0nq0m
	 c3Fb1aj1B9xn9rhLC/I4GX1TFuteO5X1oBylJTIDYWkDwWPp4Eqoz+wLZifWF720fr8XO
	 raeQSUgb77Cv2Tf7htijvYNkv0TGH6OxQnxB8jlV78unwAQUXQ+lNSjgv9UQ0xV6pdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtgxPjUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A641606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtgxPjUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3631F000C9;
	Wed, 21 Oct 2026 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550908;
	bh=rCylkUImsycsivPZAsEK2+DuH1APlrJrm2+wwho5AjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gtgxPjUpqTr5d/HC5oKRLku/jwzLTFZhtJ0Qy2/sZXh4IOG5P+jXHcTs4XuTMLRPt
	 Hajg1cp4kfXqk1xq2lhKRFxJO4VKW4pxsSTbwTn9HSOZswZJl+5QImNRiDatpwdRMm
	 /zX0Nh2hZTfTokcnKYwdo+tKggrejkAc2HpHKMLVEi1nSLjaC81p05Q3KR1ify+ZbW
	 rhfb4VmJgmGxorcIPg/y2PPoFgtf3QkkPCoLOs+36pwj9xwaE0KH55vFiX9ejdvU8n
	 swXmCq/Obgid9BJNeoBaloc4eyyA7vf+8YwtKN9jl7zDELZAAiy9xk9LNqgJghqY9E
	 p0JoZ4XcSl23w==
Message-ID: <sashiko-outbox-179715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v9 1/6] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021023337.809936-2-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:48:27 +0000
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
> polling, while the stack frame of __cmd_ftrace() is reduced by over 96%
> (down to ~160 bytes). Robust error and EOF detection on stdout and the
> trace stream ensures polling terminates cleanly upon pipeline or pager
> exit, while retrying on non-fatal EAGAIN and EINTR conditions prevents
> premature termination on non-blocking reads or signal interruptions.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021023337.8099=
36-1-atomlin@atomlin.com?part=3D1

