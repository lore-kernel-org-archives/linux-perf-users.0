Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FF501F3B
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633669; cv=none; b=fII7cAuUTotqPuB+t5znJ60zsuOU62F1pRb9eWAAJtAH/R3yaw/gXVCzcQkGuP2yKsYsgux2fqaV8dkaAXKEWxZuJyQBZ4O4c/4GbLJXJwrT6Asr+Li/fDsKfj/0pSVj64C+Q96EXkv5gGNAW/7noif7XuQlU69FkBk1Bhm9cb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633669; c=relaxed/simple;
	bh=0RTgIIvAm87DIj/nmPDIlBxSarX2L0sgQsU1Mki6Kaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2JAOXz+Zkk/fc4lWxjOww77NCcfuIGDFqzLP+9Xr6yzApXRMw5R6fxB7wVOR8L+0AXxhCZFEpjlDStVi57DZRontOh0l/vJ0IJmYS9EcjWeqCAbr9tngZwFJdFEe8KsaRouMlPmqXNdUBBuQB8+30awSxeM5t8R9wapQsPKwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOGtxpY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOGtxpY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAA71F000FF;
	Mon, 28 Sep 2026 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790633668;
	bh=Wwe1rDYNmrBOwnbXQkA5SYFFRXXFh3LCneADD6ASSQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOGtxpY5ChlguFGxpdWrZzMYbTjYww4p9jmIVQ+Tk8j0RYBml5b+i+ENzwFdtrHh5
	 Z7zyFF8WH9ktdI0d+NMxGwJL6eFQTP/7K1GT/NXbdIZo/QYUazxTpLYEbiHCziyaPR
	 xtmVAszYKunM/sCujkV9Hl38HwD4smAyjjZ9px81AXv+OjA+YU4FkqFVVXEXWODSy7
	 xZwo6L+C+deOMpeXc8JaEvVnuNcYEoeiUPMgDYXEca2Vwjf6f8skZywFk/umn1I4z0
	 8jJD1qQcYQlJ3i0BRKaIejeUPbge1LEMMoOJZiDA4QlT/Dm91rc7culWEo3zEjuhKZ
	 ubj/QQirvMd6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928220634.2451784-5-acme@kernel.org>
References: <20260928220634.2451784-1-acme@kernel.org>
 <20260928220634.2451784-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 22:14:27 +0000
Message-Id: <20260928221428.4CAA71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf test: fs_reader padding calculation ignores implicit padding
--

commit 3c1c77347e93202ea6f68ec871d8e60e5a4defed
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Add false_sharing workload exhibiting cross-CPU false sharing

This commit adds a 'perf test -w false_sharing' workload that hammers a
shared struct from several CPUs, shaped as a TCP connection. The workload
creates threads sharing cache lines to test the data type profiler's
ability to resolve false sharing.

> diff --git a/tools/perf/tests/workloads/false_sharing.c b/tools/perf/test=
s/workloads/false_sharing.c
> new file mode 100644
> index 0000000000000..12e10d10b87e0
> --- /dev/null
> +++ b/tools/perf/tests/workloads/false_sharing.c
[ ... ]
> +struct fs_reader {
> +	pthread_t	thread;
> +	int		cpu;
> +	unsigned long	sum;
> +	char		__pad[64 - sizeof(pthread_t) - sizeof(int) - sizeof(unsigned long=
)];

[Severity: Low]
Does the manual padding computation in struct fs_reader ignore implicit
compiler padding?

On 64-bit architectures, there are 4 bytes of implicit compiler padding
required between the 4-byte cpu and the 8-byte sum. As a result, the struct
fields occupy 68 bytes before the __attribute__((aligned(64))) rounds the
final struct size up to 128 bytes, effectively doubling the intended footpr=
int
and wasting 64 bytes per array element.

> +} __attribute__((aligned(64)));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928220634.2451=
784-1-acme@kernel.org?part=3D4
