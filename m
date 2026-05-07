Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331F23AB87
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187613; cv=none; b=tuOlfgMa73pgfJmwtFM0B4LXSIE4XV8h9zOD5PX16wSeReID9cKYGmh0EyKGFfcbdhL+uBfh3x7nuZ1NB3biDN8dEQ1pQRWNZ2XbnYujxDpCTBuMx7AHitKky93RMuczc76LhJJoEHLvCY4Ovuq1QMSMqbpdsRldpu0iRss4+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187613; c=relaxed/simple;
	bh=LtxaPIFzx58AE9CjfOC3VYhHyn7r14GPlRvfOkvm1/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MraLWFvESnPQFiiLfyLfNuIJw0/fIM/ZuQSjDx5OBwc/jxjmLJl9gyR/+mheY9l6bLQz85hqZ1FcbCOEaP3R1rpvPhNW6VP7x85FseqXOdxgVi2dvQFdWW81useo17w8huMekt1PHrYzjodtU1f6wUrxUD9UEq9aF9Al9skvjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkDhnL9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkDhnL9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B726C2BCB2;
	Thu,  7 May 2026 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778187612;
	bh=LtxaPIFzx58AE9CjfOC3VYhHyn7r14GPlRvfOkvm1/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SkDhnL9gEkEvv2pHI2LdzdbwVnD2RiMCV8JcvITE3kP7PIPoWE4klYH5p7bTlXadd
	 C4vYgbgXXVVZekAwUwWD39KjX9tmg6Hl6ECIqEzXUyGViuvjMDIWPe7510Pa/b0kXM
	 ZAveVK+YoHvr6s1ktxfImrjhlGQZCUIbCbbxwNK6ckuLh2zQs3BFOAm7rj47Nty3qn
	 +U2uUwL/iAsoHhsntIwqykwtdmC+h9NF49Xr5cIXd13+FEOPMv6aWp70Sfly9MP3V/
	 kY/kM8e4YY+yzQwgP4RkQ3SkwSzLp8dP+JULm2MZ/U8x8eKhbSSCgkHo22VpXnlJKl
	 B2dXSMhG5IaYw==
From: sashiko-bot@kernel.org
Subject: Re: [RFT PATCH v2 3/7] perf-x86: iostat: Move iostat arch-specific
 implementation to util
Reply-To: sashiko@lists.linux.dev
To: "Yushan Wang" <wangyushan12@huawei.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507063737.3542950-4-wangyushan12@huawei.com>
References: <20260507063737.3542950-4-wangyushan12@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 21:00:11 +0000
Message-Id: <20260507210012.5B726C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `iostat_prepare()` contains a Use-After-Free vulnerability if the =
caller's evlist already contains events.
- [High] The cross-platform iostat reporting feature is fundamentally broke=
n and causes a NULL pointer dereference crash during `perf stat report`.
- [High] `iostat_print_metric()` uses the `die` ID as an index into `evsel-=
>counts`, leading to an out-of-bounds read and write.
--

commit 71baa44353cfb70e43c580f7cf17077a33f1197a
Author: Yushan Wang <wangyushan12@huawei.com>

perf-x86: iostat: Move iostat arch-specific implementation to util

This commit renames the x86-specific iostat implementation and updates the
build configurations. The goal is to move the architecture-specific iostat
implementation to the utility directory to support cross-platform
recording and reporting.

> To support cross-platform iostat capabilities, like record/report on
> different platforms, architecture-specific implementation of iostat
> should be moved out of arch directory to get built. Build scripts are
> changed accordingly.

Is this cross-platform reporting capability functioning as intended?

If a user runs perf stat --iostat report, it appears iostat_prepare()
is never invoked since cmd_stat() calls __cmd_report() and returns
early. This leaves evsel->priv unpopulated.

When __cmd_report() later processes events, iostat_print_metric()
unconditionally executes:

u8 die =3D ((struct iio_root_port *)evsel->priv)->die;

Could dereferencing this unpopulated pointer cause a crash during reporting?

Additionally, it looks like the implementation still strictly depends on
reading the local host's sysfs topology. Does this prevent the
cross-platform capabilities from working?

[ ... ]

> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/util/x86-iost=
at.c
> similarity index 100%
> rename from tools/perf/arch/x86/util/iostat.c
> rename to tools/perf/util/x86-iostat.c

This isn't a bug introduced by this patch, but could there be a
use-after-free in iostat_prepare() if the caller's evlist already
contains events?

If evlist->core.nr_entries > 0, it calls evlist__delete(evlist) and
reassigns the local argument parameter. Because the pointer is passed by
value, this reassignment is invisible to the caller.

Does the caller then continue to use a freed pointer, potentially causing
a crash in subsequent functions like iostat_list()?

This also isn't a bug introduced by this patch, but does
iostat_print_metric() read and write out of bounds?

It retrieves the die ID from the root port mapping, which can be greater
than 0 on multi-die systems, and passes it directly into the
perf_counts() macro as the index.

Since uncore events typically monitor exactly one CPU per die/PMU,
evsel->counts->values is allocated with a size of 1. If die is greater
than 0, does this index out of bounds when reading the value and updating
prev_count->val?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507063737.3542=
950-1-wangyushan12@huawei.com?part=3D3
