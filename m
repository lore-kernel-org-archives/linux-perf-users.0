Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229839CD14
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741342; cv=none; b=CsexWgkIcYMQHlV2+k3CDOF7kAquEPD5tYsSOp0pf9r6mjWkn7JSQfUyca5IusNCoEU6nrmvM6V+nzYg4IvpVUEiYK1FueLbD3rtYrenvy8LDDaj1qJrLmdEuwi5yJGnWLBtNLmcWZCjYmvLEKyOr82UoIN+tOY14/a+WKDGc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741342; c=relaxed/simple;
	bh=4KgXHAFZRVMO456vA2xo1PrM3Bbca0VkWN5qO1VgHHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UN6Ka7CsOzkQmXPy2DpZpN8uW3SVwK6Kb35/TocACempFZty3k8BaMbd2S0444fqHecpUnJV+sZs8Ppj0SDXcRPYpsulCWgjNTfY4JRLuJq8big+Dx+DjBeajpxhs5RWBtufc3EVprqrw5LiodkmfTG+mDh80hiL4fP7rYnACAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTSsp7ZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTSsp7ZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7F61F000FF;
	Fri, 18 Sep 2026 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741340;
	bh=4KgXHAFZRVMO456vA2xo1PrM3Bbca0VkWN5qO1VgHHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hTSsp7ZKHsmgcqtomU7m7DPHudxyfMx/RJrCO4TWRBDXyJINhqflAyVrjhgk5jITr
	 q/k1AcYuU8iFt8QNsxqJ/KKElD+FlqxtyLHqwInWkn3zIDL5ToHAKHJy82aW5I/4Zi
	 SmzI0Z4/N3qM2igJd0sC04dBctZ+tDthN1vqo2F2OByMnVleGMTefWM7MUrFBk0YtN
	 RDna2nM1ifaBwpS1wBougth1OGeMXbRAyTtn8YXBWTpQyUCJBYTQdAfw7nFpPChdqA
	 jmoxYg5V2NWeXBinkZWNnLsOpMo+q+cf1V2D3dz+deSfSIwIaHh43+L+p7jy740NKP
	 lYe6/CYABV2yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/16] perf trace: Free the whole evsel_trace in
 evsel__put_and_free_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-3-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:22:19 +0000
Message-Id: <20260918142220.9F7F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Every evsel->priv in builtin-trace.c is a struct evsel_trace, allocated
> by evsel_trace__new(). It holds a syscall_arg_fmt array in its fmt
> member, which evsel__syscall_arg_fmt() allocates on demand for the
> syscalls:sys_{enter,exit}_SYSCALL tracepoints and for every other
> tracepoint that gets its arguments pretty printed.
>=20
> evsel__put_and_free_priv() only did zfree(&evsel->priv), releasing the
> evsel_trace itself and leaking that array. Use evsel_trace__delete(),
> which frees fmt first, exactly as the out_delete path of
> evsel__syscall_arg_fmt() already does.
>=20
> The current callers are all error paths that run before fmt can have
> been allocated, so nothing leaks in practice today, but the helper is
> the obvious thing to reach for whenever an evsel is discarded and it
> should be safe for that.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D2

