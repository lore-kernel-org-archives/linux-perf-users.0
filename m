Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BA2BEFE8
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982652; cv=none; b=aInK/gMrFmwxalTS2CcOkfb4iwUqtPNzMQiHoU2yZkRPaaJFjjHaLbUnz8jQmP1cydnyCT6esysj8rlfsPmEyyhVWQTpY0QJheq/r5fUfBp2OA00Gw/aPddG/Jjv9oePNlGUNgTessyWDjvJHMA7YRRSwbCBrPWzNZ2YCO1E4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982652; c=relaxed/simple;
	bh=dtd2um2vVFCt5UgQD/udShcBYNrJnqGF1Yqjk7FAtXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=StswO0xOrHeHiGsEEQeu+K2rmji0koZzz5QDmwh9SND/+kz8/QO8qT29US3b+e7qLFF59juS7MtcxdLu9YazpOWMT//Sh7REnmA8ndiMZSgWwK7R2v8hJql4QH6l+JlXcV2P4yaq8WXMR4/Y8ni4h+1mFe9cbIXTh4geA8E3+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+f/XT7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+f/XT7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCD61F00893;
	Tue,  9 Jun 2026 05:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780982651;
	bh=GDCtpi/yN93/+1NWRfgznvVTk+wHd4RIKd3pWzmqYbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+f/XT7MtSGr9/YF7AhdT1ee2jeMQEb6jnCqjYhj+elKhXN6PTHRrK9B3hJhKPJYX
	 tQMO1TOEOuP2LJCOEcsHM2eWuDDY7XdlSVPj97PFerdzwEJqcKW09EsPwjhOs/La/4
	 irHS+QjLTi7muvGw4mRSJUU4ZawUeJ7y2LG+cgw7wCRbYj+uqDVs5oRa1P9naIWq1T
	 CrDBYmCwEXcF6hh+uVJl3E2jLnLpAkO3fP6xpEdTe2z1tt8kaOWKP7Q7Mpkr4+FoAM
	 MUdHDZbcNCPtxEJXXe9IcI8phKbgiZtJnu6+S/mapuEuUVI/ELidpsPe6/zbiB5LCH
	 ZvpEdkuF9U77g==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 9/9] perf/core: Check kernel access when kernel
 callchains are requested
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609050222.2458129-10-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:24:10 +0000
Message-Id: <20260609052411.1CCD61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch breaks `perf record -g` for unprivileged users with =
existing `perf` binaries.
--

commit ac223ffdf5e79c1aa96a91deecdff94004bbe30f
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/core: Check kernel access when kernel callchains are requested

This commit updates perf_event_open to verify kernel access permissions
when kernel callchains are requested, even if exclude_kernel is set.
This is intended to prevent unprivileged capture of kernel callchains.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -13904,7 +13904,9 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (err)
>  		return err;
> =20
> -	if (!attr.exclude_kernel) {
> +	if (!attr.exclude_kernel ||
> +	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
> +	     !attr.exclude_callchain_kernel)) {
>  		err =3D perf_allow_kernel();

[Severity: Critical]
Does this change break perf record -g for unprivileged users using
existing perf binaries?

When an unprivileged user runs perf record -g, the initial syscall
request fails with -EACCES. The perf tool's existing fallback logic
retries by setting exclude_kernel =3D 1, but it leaves
exclude_callchain_kernel =3D 0.

Because this new check enforces the privilege requirement for callchains
even when exclude_kernel is set, the retried syscall will fail a second
time with -EACCES.

Looking at the perf tool's fallback handler:

tools/perf/util/evsel.c:evsel__fallback() {
    ...
	} else if (err =3D=3D EACCES && !evsel->core.attr.exclude_kernel &&
		   (paranoid =3D perf_event_paranoid()) > 1) {
    ...
}

Since exclude_kernel was set to 1 during the first fallback, the tool
cannot handle the second -EACCES failure. Will this cause the tool to
abort entirely with a permission denied error rather than falling back
to user-only callchains?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609050222.2458=
129-1-dapeng1.mi@linux.intel.com?part=3D9
