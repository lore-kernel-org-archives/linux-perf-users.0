Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53596374A0A
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123840; cv=none; b=NawYCFshusNaktF1LrLeK5TAfH2ucNqT+yI/TYfEmIs6tQMXzWe5VYjMycQc8o8Rq3b/YMhDbD39PaMyOlk2UOH/wGgBJoRGiHJ2NsPZKRuxRdN5cazYno8R/kojPRsmZCxY42iv3ChOdOCZQAIPG7OtKYurfNBBDglDyuDeqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123840; c=relaxed/simple;
	bh=Bypz4QTv16sKRE/3SLNL3NVz/VxIetXOXnbhexD0IHE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Oa2X2RGmj1VOypI32rRlGnj8ev9xcEel9Row2kjkVfUtRG0EzQPC9euG/nCq80GEaXCzUJKyMVoY9ajjBOtpfnxDRD3IlkFZ5vYO9s4W/oFdbaPtcSHTIsAkZY7OaJqbeYRjxL/ZQmBEGQIqaR0BkBwK8+QV5SMcxBRTlLG/wd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKgFM6kI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKgFM6kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F181F000C4;
	Fri, 16 Oct 2026 04:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792123838;
	bh=Bypz4QTv16sKRE/3SLNL3NVz/VxIetXOXnbhexD0IHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FKgFM6kIQs5tCxKpzvZTW4jSZp+ZwdZpYiN9FiIW5yid9pf/sUQ274itTBpRBBk/J
	 TLQnEwqpow3O3v3Acr5qjz+mtrSVwzwn4cdly0kE3ftl7B/BeV4a/Cjpkwox6tiM2Z
	 O7UPRugw8ssjkc2xN1+wTgZC2UGoSfmXD1bdfXVo//5ASYY43KdBe5yPgDl1HN5Qa7
	 +80PzFA9wG3QnTXklnXGMlrqOVHZ3tSfrvH7Y/pblaR8/Jalva9h05VEsQM4z+dgUD
	 vkeZkktro/g8EJ52/qHuTBCiEHi9+YY4v1vsCe5XrZQlomWbMRKAraBTCxhjnA1EgQ
	 jrJXO1h5/6C5w==
Message-ID: <sashiko-outbox-173732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 1/5] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016040310.482876-2-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
 <20261016040310.482876-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:10:38 +0000
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016040310.4828=
76-1-atomlin@atomlin.com?part=3D1

