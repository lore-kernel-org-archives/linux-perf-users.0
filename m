Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00692253FC;
	Wed, 13 May 2026 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702991; cv=none; b=ZModoc53hpZp+gc06qJdrhIXNnTLJTHWUoGRSl93VjBsSiRpDeq9KjA3s3jw8jtI03Li5maoiJjRNUxLhNJETajVPEf+oeBPOecgV1bMUnJggA0Z7Verz/DOptiGzIHMxfsu5XC4qW6bizWiIUsdU7jMQx1i5z2RpSQHNq1SUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702991; c=relaxed/simple;
	bh=YyH2OLhw8dwTWO6Tt6Ii5AYul7IZoLkiSlvqlcbYaok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lpcPOJbY+U5ukZFVv88jaJnrdbtekjPJTLOia9dScz7iXCBffL2aYbHi8T6RiDTbpokR3uPgGCIgd+j/AAPrcffSQzpdNSVNloeMZI+n7QKGJ1PAn35xdVzuOZih4mzQQttSFdmHrLCx/+uAHwv9RguvEBKnVEevN2QgXomLpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pky+8HDY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pky+8HDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EBAC19425;
	Wed, 13 May 2026 20:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778702991;
	bh=YyH2OLhw8dwTWO6Tt6Ii5AYul7IZoLkiSlvqlcbYaok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pky+8HDYEMbUnkNEibhmNSUfZ7G9l8ndmsOIFX7qin2a5cRQ1/La/Raw9GDaUAwC+
	 JIh6Q5xq1JWhLGTE7y9FolhpxEHE4aOhFH8ljaEXdzRZlf58a8n6UDw0SKK4e782p2
	 9nX3/KzQDi9UbhQovFfBdJzrN/E8klyiy33Qfjgtdx9AlCflbBiUhVZmvNjS5SVlrX
	 U/XPNURL+BG0J1vvD0Ry88dJDT2gKW0aAAKxuilncU+RpcjWaA7fC3kNa0VjqJ34Dw
	 x2y5Bc0172uvHZ6rz4tXePvGh9UdkGbppBoBH3WmhU+Dx8MPMMWBEdx/OksikhgcHS
	 E9EeGs/xzhDEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/14] perf build: Encapsulate vmlinux.h and bpftool
 in bpf_skel.mak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512053539.3410189-7-irogers@google.com>
References: <20260512053539.3410189-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:09:50 +0000
Message-Id: <20260513200951.12EBAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete variable renaming breaks `make clean` for BPF skeletons =
on systems without BTF.
--

commit e42b6c2f3098a5301a43fefe8d2fed01aa6814b7
Author: Ian Rogers <irogers@google.com>

perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak

Currently, bpftool and vmlinux.h are prerequisites of the top-level
prepare target in Makefile.perf. This unnecessarily blocks the massive
parallel C compilation of libraries (perf-util, perf-ui, pmu-events) during
the initial startup phase.

> diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
> index bcb704d5af32f..ded578b9570cc 100644
> --- a/tools/perf/bpf_skel.mak
> +++ b/tools/perf/bpf_skel.mak
[ ... ]
> +ifeq ($(VMLINUX_H_FILE),)
> +  ifeq ($(VMLINUX_BTF),)
> +    $(error Missing bpftool input for generating vmlinux.h)
> +  endif
> +endif

Will this unconditional check break make clean on systems without a
BTF-enabled vmlinux?

If a user runs make clean CONFIG_PERF_BPF_SKEL=3Dy on such a system,
VMLINUX_H_FILE is left empty because the fallback assignment in
Makefile.perf's NON_CONFIG_TARGETS block still sets the old VMLINUX_H
variable instead of VMLINUX_H_FILE.

Since bpf-skel-clean invokes a sub-make to bpf_skel.mak, and
CONFIG_PERF_BPF_SKEL=3Dy is passed, the skeleton block is processed. Because
VMLINUX_H_FILE is empty and no system BTF is found, the error check
above is triggered, which aborts the clean process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512053539.3410=
189-1-irogers@google.com?part=3D6
