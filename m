Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C14B7A21
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661286; cv=none; b=lkJIbzz94eS9ZHjda1BJdXUue9CuWCkjlFikD7MkPL+bs4rnQCbPXavNlaDflvfqVpQdiH0WRRjuOAQShRKBW7qBEi8s6zTtnbfHrqjOD6pRDOzCjFR2ftQurFL2ba5DJAvSZkCp4RMuQtM/W/+y+QKHgt/06QI5s7sK679V4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661286; c=relaxed/simple;
	bh=SQ3eEcujQK0Tn0C6OI7jx9fM180gzye+vIqNGpvzvTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JlDf7Ym7nT7sH6NFv93QDtZ7cFHmUnhyK+SzUcaO6ul74hoj9M05mV8B156gKmGLErP6k+qrB7lRwT9LXE3nZ6IKJLlgWnMDYKBZ1tDe+bv+Re14EhaiPb6ZNhuoFC7nufs3m89YR0f/pi8aFeYGEgIRXbCg9xtdhtdcjd+NFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1w9iZB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1w9iZB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD4E1F00898;
	Thu, 17 Sep 2026 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661285;
	bh=Xf0xe5Zq/00fTxl0JoLBMxUuHJvXowOHdgm4GvvH6V0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l1w9iZB3Qdp0eGslC67AXK69ep37fGQz2AE2lRsLk80lzijMdVVBePimRJdtQo1dP
	 W6D4uWaA4GbAyjEnravdPCzIchGIVcJKYc0gQbAzOv/TzBX8Ypu9qtgt07k8L/JUTy
	 pZ4oCSwdnzItMj9d5ieG/QP3V5QjJP45NNPDPCHpS9wCMGFGrvY20jDyvxNkZYLAcD
	 UlFHrF9MgoeRaUaNaOzGhp1iAFja8TSoMapDAlRb8hn5sNGsEqM6RWWkN9n1csTT+q
	 yqBbgl2ShijBHRaF9Nw+cmGjbbHTcVqRfX+50Ra7ZugjxBSZlp2ZW+ZWRFfpBC7jVV
	 jBSOR4pfnazyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] perf symbol: Fall back to fetching the vmlinux by
 build ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-7-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:08:05 +0000
Message-Id: <20260917160805.8DD4E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A profile recorded on a kernel that is no longer installed, e.g. one
> processed on another machine or after a kernel upgrade, cannot have its
> kernel symbols resolved: /proc/kallsyms does not match it and the
> build-id cache may carry only a kallsyms copy with zeroed addresses.
> Fetch the vmlinux keyed by the build ID recorded in perf.data, using
> debuginfod, as a last resort when no local source was found, honoring
> symbol_conf.ignore_vmlinux and ignore_vmlinux_buildid like the other
> vmlinux sources.
>=20
> The fetch runs with dso->lock dropped, like dso__debuginfo(), and the
> file is loaded with the lock held again, only if no other thread got the
> symbols meanwhile (dso__has_symbols(), not dso__loaded(): the latter is
> set even for failed attempts).  With the lock dropped two threads can
> map the x86-64 entry trampolines at once, so that mapping is now
> idempotent.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D6

