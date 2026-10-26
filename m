Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006876;
	b=lCIZWOvSBlENcfgk/SaGZ8jLwHmZJmIb8YK0zZ5dRV0qXE1YXlCYB5keQZucApq4LdEC
	 3sAnlGNVyHr/1rjMEsL/GarKnReDBkNCpIw2qFJbEHDJts7/wPTzKfOl6Hc4jqBG2Y88w
	 FmjAEpho9nyKRortYn5gR+X8+6HzX/yQQQBNWw/SqtQ9ZetQbK8OxlM44OGaXZNshkx+Q
	 688r3dO/6thp+G7mO6t6aw823keveSFsxQSkOU+QW9DFvoXtqj199IsHLgJF40PeN1ZS8
	 8CP6WEfO6bj/bxf4+y4zzSflyOUgoEt+KO3Ugl/vid5+tLfj88bpiV6cYinUdpPgL+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b4ABgCz4pAghF26Nk7C9bweEoTGMfkRGOJyuPLMwkeo=;
	b=u4V+5yn2fYf6sg8J51D9JutgJPowUG6RM0G8r45tq7vi24zo2LrKx1NVDzqeLhMx6Wwz
	 HXs22Yt9kNpFnkn/zQiOPpJCEdP88LdqPQE4+/gwdJxyxZNUrkpsrAEAnAlfGm/N2FROp
	 XIoDH4DrOXHSKYjcDMEZvZQ8J+XNNjQW2OdXQpgk8PwIMEo12XuC/27kW5+jByEoVujYQ
	 VGB+1xzRTNT95ZKd2N2ABjrMA/hSRJUJ8Qtr4azrE9zGN4aR18EVLY/u1C5nqhtH+eeYk
	 0bFvYc7tFIBfvNKSPyXurSHQVtdhip7PYUbUMskOk9nWPlbKBERe3fumf0R94HsDDiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwLXQeu3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC9606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwLXQeu3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934EE1F01825;
	Mon, 26 Oct 2026 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793006875;
	bh=b4ABgCz4pAghF26Nk7C9bweEoTGMfkRGOJyuPLMwkeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwLXQeu3cy9OIUMkjS7WMMl8YH3Zbf8KukGbuOpDlL8NQ2Pmdp2YWew/9s0oXCbUu
	 bhN8vtw8eB4dCms+ma1RigmALJPMfmqNvYd14jXV9HPjDvQgqhGlvQcLLczTfbMpPe
	 zMuxUB9RVhq1BC/1ClOBRuMm5I/op4xZ78+fAnMsvnlu1PuV5gc5tJWqBXh0HUYDYn
	 N7f4pxE/+EvgLgv8mtOBKJ9RJrqa7XdqhaJbz3CjYgDjMe7IXiredQghWW6z9gJt5R
	 Mlb3liizXfDoUvXRmV5BnxpXaJVK0LZXZMpXR8cRvbrttl96PWaELLeczbXcqrC4Y/
	 Tn/LEGsiZwTqQ==
Message-ID: <sashiko-outbox-184788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 02/10] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-3-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:27:55 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D2

