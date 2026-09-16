Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788E3B1EFE
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560361; cv=none; b=GDC7u7zq4VF9lkbjBPwI7Hkb4w5Q05AujaAd9ZZJE4l53huO994WykfKPW7CqV/kiqsFRjfbzUyB+vMXdFnCntTDuUPWdAfKPoFS4UlUI7CUB/0cjf/Y/dewNjGiZsgu27cpPj+PxhbPQVQmzu6/cr0dMolaNlWlmWlbdomu4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560361; c=relaxed/simple;
	bh=0kv08uSui9A/OrrKj5Z02PlWSU9GYJgFn4nt0QgLjAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JpuTL2lRKOKLHC7r5v7TquHB8fdJW86fuxov20unc0NrC3TTeCHEgMa6CbZ/76Z9mMuuer8h4r+L1tVwNo5f8PBrL5poHdwVfE885cutJjZoZXu6yCkwLBSliW2MWOxuXghjAK43h+hgRjszo/2NF2+fTPurAHBB/jyVFUl7+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh9jzEm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh9jzEm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BE11F000FF;
	Wed, 16 Sep 2026 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560354;
	bh=1dViLppvaxtrTDS/j1vSuNhsnTTTHy36+uMxZk+AKAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gh9jzEm1GwJk1SM/uzQMZZTnz7Q60Gml7K0pfcMTKAwd9qwXymMRUoBG0vAIh0VFH
	 TUMlZxxfZQwnhPUwCCafMJuXh2CkVfbG7IEOmgB8SwepbpjZQ6Cw0nsFubQLHwO1yo
	 6uwwr+2EOlJUaQOC9FPVcXHoUnwbTgyBnU3X1w4FiagBgIS+MmOeTTNy7lJX0IY6zA
	 XFYlRqqBb09rv5d71IOx2n1Uir06OwoasKf2owemXpC1KMX+Qr2G0o2nazH0P1AwQY
	 g5aUx/wG+0Wxfc828KSQGUh3FJD9O+IXkhP6XisDQqpnGRt2LoiTw49i+Mhu4uYTZb
	 xqSwe733E0JLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] perf symbol: Fall back to fetching the vmlinux by
 build ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-7-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:05:54 +0000
Message-Id: <20260916120554.A9BE11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf symbol: NULL pointer dereference in trampoline map adjustme=
nt due to lock dropping
--

commit 54cc3e4d87729d86b17ea862346d56f11117f916
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf symbol: Fall back to fetching the vmlinux by build ID

    A profile recorded on a kernel that is no longer installed, be it
    because the machine was rebooted into a new kernel or because the
    profile is being processed on another machine, can't have its kernel
    symbols resolved. As a last resort, when the kernel symbols can't be
    found locally and the user didn't specify a kallsyms file, fetch the
    vmlinux keyed by the kernel build ID recorded in the perf.data file
    using the debuginfod client and use it for symbols.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 1d70c43bb24ee..ccb6217119416 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -2257,7 +2280,53 @@ static int dso__load_kernel_sym(struct dso *dso, s=
truct map *map)
>  		pr_debug("Using %s for symbols\n", kallsyms_filename);
>  	free(kallsyms_allocated_filename);
> =20
> -	if (err > 0 && !dso__is_kcore(dso)) {
> +	/*
> +	 * The kallsyms may be unavailable or restricted, e.g.
> +	 * /proc/kallsyms with kernel.perf_event_paranoid > 1, try to fetch
> +	 * the vmlinux keyed by the build ID using debuginfod as a last
> +	 * resort, honoring --ignore-vmlinux and --ignore-vmlinux_buildid
> +	 * like the other vmlinux sources above.
> +	 */
> +	if (err <=3D 0 && !user_kallsyms &&
> +	    !symbol_conf.ignore_vmlinux &&
> +	    !symbol_conf.ignore_vmlinux_buildid) {
> +		char *fetched_path =3D NULL;
> +
> +		/*
> +		 * dso__load() holds dso->lock while it calls us, and the
> +		 * fetch below can take a long time, blocked on the network
> +		 * or on the terminal, waiting for the user: do it with the
> +		 * lock dropped, as dso__debuginfo() does for the debuginfo
> +		 * of a DSO, so that the threads that need this dso don't get
> +		 * stuck behind a server round trip.  Nothing of the dso is
> +		 * touched by the fetch, the symbols are loaded with the lock
> +		 * held again, and only if the fetch brought a file back.
> +		 */
> +		mutex_unlock(dso__lock(dso));
> +		err =3D dso__fetch_vmlinux_build_id(dso, &fetched_path);
> +		mutex_lock(dso__lock(dso));

[Severity: Medium]
Could dropping the lock here lead to a race condition that causes a NULL
pointer dereference?

If a second thread enters dso__load() while the lock is dropped here, it
would see dso__loaded(dso) is still false and also enter
dso__load_kernel_sym(). Both threads would eventually return and
consecutively call machine__map_x86_64_entry_trampolines().

Since machine__map_x86_64_entry_trampolines_cb() translates map->pgoff
in place without idempotency guarantees:

tools/perf/util/machine.c:machine__map_x86_64_entry_trampolines_cb()
    dest_map =3D maps__find(args->kmaps, map__pgoff(map));
    if (RC_CHK_ACCESS(dest_map) !=3D RC_CHK_ACCESS(map))
        map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));

Would the second execution fail to find dest_map due to the modified
pgoff, and subsequently pass NULL to map__map_ip(), resulting in a
fatal NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D6
