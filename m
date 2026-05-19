Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5314A4CC
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779165447; cv=none; b=Jx/hg7H474oIxsqvfWYDhg4U22HSi3Uy9m/YI+wYXsQQgZR41TKRLEmQGlvyGtOxtpEsmXvyjsxkqGo7U4jyxgg9NqmnN2bndHg+WscgxhDI1aMl7MjONu4Z2of6aJQ8LzYGUBUKGc7VaGABFOPE0u6VSivAaOfl/5hcMZOne4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779165447; c=relaxed/simple;
	bh=i0SST1+rdr79Ho6HvpvA1HlH2j/AvnvIWBDHRuvaIY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jK+OQE3dY9bnPk1cc9bSEUOzdqcl5iuMW7D6z1z5gApVTNoXOs1bUJT+yl+MBBXMAi35Ayn7rOpXenPcNK+vjEg30/bphXqZdhQ+rdRnPparrmVbE9uTCN4HXzlTXjUIFlTtVyfLhlFRr14ogazNiB29XgIVfqMtSjBWUZKPIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0oU6Kj5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0oU6Kj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3737AC2BCB3;
	Tue, 19 May 2026 04:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779165447;
	bh=i0SST1+rdr79Ho6HvpvA1HlH2j/AvnvIWBDHRuvaIY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=P0oU6Kj5vI90CPc7PH7ai2oKQEYGW4AhoXx4PnU7zFrMTzNKKVigJIWm5FI0ivbK/
	 sRw9C1GZRD0+FFz9+sY6VNfeywuzsgf1zmLxf217yQQetigVx1e9Fb7BMlWYpLXG+4
	 MbyurMP4uXaxZ3nxlxTEmKm7FCaUdn9JPk6ES8xvXRIDdjjgEqCGS6nz5zbmv6LOV7
	 j20mzFwn5DS6VUMPdC3hFzHQsshZSbxTUVB99j5tVenwWh1zb+dzcNH4l8sWPA5Y/6
	 jH8R2OpJfXxuPo3P/Hn/ttHswy3h3N9CfJqrqWoZAtCjzRhP/FCThwvcrBRlrT+n1m
	 8wKsFA3Rmfhtw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] perf/x86/amd/uncore: Convert AMD driver to
 common PMU helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519033225.1479907-3-liuqi@hygon.cn>
References: <20260519033225.1479907-3-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 04:37:26 +0000
Message-Id: <20260519043727.3737AC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Failure in module initialization leaves registered PMUs active wit=
h dangling pointers to freed module memory.
--

commit 1da22dd6a76f69c0499311126ce80bcfeb22b09d
Author: Qi Liu <liuqi@hygon.cn>

perf/x86/amd/uncore: Convert AMD driver to common PMU helpers

Use the common uncore PMU helpers for AMD uncore event handling and
per-CPU context management. The AMD-specific DF, L3 and UMC discovery,
event encoding and PMU setup logic remains in the AMD driver.

> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c

[ ... ]

> @@ -1137,7 +702,7 @@ static int __init amd_uncore_init(void)
>  		BUG_ON(!uncore->move);
>  		BUG_ON(!uncore->free);
> =20
> -		uncore->info =3D alloc_percpu(union amd_uncore_info);
> +		uncore->info =3D alloc_percpu(union uncore_common_info);
>  		if (!uncore->info) {
>  			ret =3D -ENOMEM;
>  			goto fail;

This isn't a bug introduced by this patch, but could this error path leave
registered PMUs active with dangling pointers to freed module memory?

If initialization fails later during the setup, such as if
cpuhp_setup_state() fails, the error handling path rolls back the hotplug
states and amd_uncore_cpu_dead() frees the per-CPU context memory.

However, the fail cleanup block doesn't appear to unregister the PMUs
via perf_pmu_unregister() or free the uncore->pmus allocation:

amd_uncore_init() {
    ...
fail:
    for (i =3D 0; i < UNCORE_TYPE_MAX; i++) {
        uncore =3D &uncores[i];
        if (uncore->info) {
            free_percpu(uncore->info);
            uncore->info =3D NULL;
        }
    }
    return ret;
}

Since the module initialization fails and the module memory is unloaded,
would any subsequent access to these PMUs from user-space (e.g. via
perf_event_open()) dereference pointers to the unloaded module's functions
like .event_init, .start, and .read, resulting in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519033225.1479=
907-1-liuqi@hygon.cn?part=3D2
