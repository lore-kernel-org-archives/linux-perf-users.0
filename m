Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952242;
	b=h5kiH7pEgLdVJS648KNHSPlrgrlTHE6djzSNrRh+tMGJb3rUsins8Kqu2BkhpxL2xtJF
	 7I7sCz91Nhp4/kkPTGSGQMIJTaq5U1v+U/tHsw+qDT4+z1XjFiZ9HfMo+IMh6ECo2Gkrq
	 RNRiDWfifKSuJdZl9f42yxqCj4iA1/RHhZPftv59lV+LLTLnBbJzz4nDrvu1K1q99ki5O
	 RA+sBSK+6YhqZ4ev78u6C/1GzkNCEOR55rdl/ZY5YZ3Q5GCIup+4cdAwDy/oULrLySrqW
	 x1X+eMwAxWPiD0E3w3aRkY25C3nvd8ONcyGxnMREtZqpu8+fwfqNiSpZ/aIvgPwJmyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g74ZBp8VLNuAp0jHNvWu2yhVskJl6eYznm2CFWIZACE=;
	b=iorLjm3lYUqrxZAfTqSD5jiBgncmj6lA8uA/oUkQwBkx7oC6VwSq3l9+YiFLvg6OIA2M
	 jGBOaxOMail1nLITm14eajVyq2mj8klxVaOdEAW1Jhu233MojltQ7q+8RPvD3FuRYHJXT
	 yMKVr18C1bYNQDzjflbmhZK5UWXIHzOTWAmhYazJKpjYy8mvgs4r5q2+apStCh6hAgQaJ
	 Ndu1c+XIrqyBrdytpu+frjI99Nd7jQNQ8rUHsPvZGn5d5AifeXwghA9u8BPI27opa70iF
	 jTVYpwendRlRMzGQ+7sg5VZkHwsDWZgOp3b7SOaEzuR40fbkqUxeBgKzDVvAGxHEbUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktBKzmGK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E0606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktBKzmGK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A286C1F01825;
	Sun, 25 Oct 2026 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952241;
	bh=g74ZBp8VLNuAp0jHNvWu2yhVskJl6eYznm2CFWIZACE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktBKzmGK+mDKe6mzkVC9vB3Xq3fBOrVsgndBRaX881G+iWFJuk0pEdMxXJRazMali
	 pu8DtuIQZUnqubtILbZZOGX8cB2oQykx2mbADNXoT6fRbU6KS9nUEYEqlySmlv07Hz
	 /9QhcLUyBSIdkxWkvyMn16zGFpHCuKEF7TG1cub5IGWb8l2XlqLGq7gY8OHvpZdl8q
	 ty631vDniAADg95xFK6xcarQ2itDB6l/KkOHeo0Q9YPHP5TMSM6CCX5/VhTWM7fIVF
	 sbRQWXMdmFMsxHnKCw/hwILibZ/G+fNH/ItpY26m7wAXsccKoLnWfj39b+etTWx0fO
	 HC723pmsjqoRA==
Message-ID: <sashiko-outbox-184320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 02/10] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-3-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:17:21 +0000
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
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D2

