Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28023394D
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291799; cv=none; b=hJJHVJwKBQphn751g6A7K43UtPwjryYbtGxiUt++Dwh/clDK/vTy6REmyy1haBDcxDAto49+oCMcplch3xyOGFuNYekyF3w+xa6rqnN7kaArC9zirm4H1/prGkqQ4u093aDaJ1+jZ4mxSykdyhS+YOo/AOOmXa67JzsSQnmjJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291799; c=relaxed/simple;
	bh=VlKbu+RflhebD52ujLVpwkYsRKC6iyCAMX3SIJMzwSg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MYLlOWcZjUYHegeB3M4cNJrkeFjwFOVSuIXCsdN8VgkuLaXOEjlDFMOKyST/izU+gPmNzILrQaA8eoceuIkwDiIaC3v6QKi8wV2MMA4vXCsJQy6aRCNENLHDOJdpUAqwk2ZmQO8DJ7hYqCxqZ/FDbSeAfFT/BCMN9AaYybN/O1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcat+Q6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcat+Q6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AD11F000C4;
	Sun, 18 Oct 2026 02:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792291798;
	bh=VlKbu+RflhebD52ujLVpwkYsRKC6iyCAMX3SIJMzwSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hcat+Q6HAhlcBM17rtPuOnjUNmDhoYAzqtLS0C09D41ICeOC3TIyl/PRs4RIDj+Cv
	 7fkk42os3/B42Rgu7zws4R6KtIKXXM2tOg7WT5jSux2xtu4Y6YgwJxv+X/0mt+4NU1
	 PS+iqSCVMfeJQgpniQpyAsvh6NnpSUFRZQbbjzaFhHj/tA0z6rwr/J4OZNWq77Z5XC
	 LKztjlpItrOjFlsUbkhMsDB56bhfklqWrZzCRZdDL+GkdtE3Da+MQYYZ2MGAtRfb3/
	 B6YvxI+IzfkcoZrhNota1dq25BiACA5Zm0jb+lFreHasIzJbfBS5Zug+8459f/uCBR
	 vWgal5wvmoS3g==
Message-ID: <sashiko-outbox-175892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v8 1/6] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018023753.584873-2-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
 <20261018023753.584873-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 02:49:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018023753.5848=
73-1-atomlin@atomlin.com?part=3D1

