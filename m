Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41429B795
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792309696; cv=none; b=UIowaQ3po1Exi+Gpu+sRnhOk8r4wHJXkX9t06+eY9oQg90B5/WAWyVa7OoD0zi90dvFHdJAQRsFHtZsk8oCh6hvlDAx9T0YNAvhbQVwNyoGIpeJyXe+MMhwi/5gtakVGfLDMBrd4LLVjk4ZE7vOimYPHC6vZLBFS+xXQ+V+7PNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792309696; c=relaxed/simple;
	bh=Zjd9BhRSCM44CmENuEQXq12aMOePyMjcS6cJG407SjE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rx3DYahNw1gP5WGvqA0r3YFpeJY4tD6akoB+QYMGyAdDsaRXGeDQ8UAhrC1f5vTJe8X6SJ6humGLvTPYNopurCMRe7bNyzmiYrNUTqy2WjUX/4A3TAWqaiqb4akTv9CdXU4V2a6nk+L239m73SegifT6/WowbrJ7HVXg5arAKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el37+aJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el37+aJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DB81F000C5;
	Sun, 18 Oct 2026 07:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792309695;
	bh=Zk5v88r8OLWXaEzlbd0fqVzwX1hEDn2C01xH+bZ7zYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=el37+aJ9gwoiLOsfBQUq0PvMCkgVDoqSaBpj0JiiX4zbGk6NEd1mLNlg6H5fTjrjC
	 j14Llx0aD1331R9qHVx3xu23xGm5XRcfvo+9MxgoOATwg0Up2pwsxIjWX3qIECG+b3
	 REVjQOWSGQGxon8D7xItlGpyjm836s0oSA13hcRnBEFgdaAhF6liuS1frSDheM3/GZ
	 p34yG/g7H/axbFHADYsXf99utrBTOA8O6OCvY4WULYQj8wJF7g0N+3u0+oWYJmX9gV
	 +PvFTBiLeR6bF7WIydQsMJvWxc1IDMTOTCQTRVK0y5lv2Uo9dIAv3+UnQjP2XHmju8
	 det5m1T3LF2Bw==
Message-ID: <sashiko-outbox-176006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf python: Accept events larger than union perf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lalit Maganti" <lalitmaganti@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018074528.974953-1-lalitmaganti@gmail.com>
References: <20261018074528.974953-1-lalitmaganti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 07:48:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Samples recorded with --call-graph dwarf carry a copy of the user stack
> and are larger than union perf_event, so session.process_events()
> fails on the first one:
>=20
>   $ perf record --call-graph dwarf -- ./workload
>   $ python3 tools/perf/python/stackcollapse.py
>   ...
>   TypeError: Unexpected event size: 4168 < 8424
>=20
> This makes all the standalone scripts unusable on such recordings.
>=20
> pyrf_event__new() rejects events larger than union perf_event, which
> guarded the copy into the union that pyrf_event used to embed. Since
> commit 2c672ffdad4b ("perf python: Lazily copy events and samples from
> process_events") the event is borrowed, or copied to a buffer of
> header.size bytes when a callback keeps it, so nothing depends on the
> event fitting in the union any more. Remove the check.
>=20
> With this, stackcollapse.py and flamegraph.py process a DWARF recording
> of a two-thread workload, with the same per-symbol sample counts as
> perf script, also when the callback keeps the events after returning.
>=20
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018074528.9749=
53-1-lalitmaganti@gmail.com?part=3D1

