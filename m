Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11537F32C
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063344; cv=none; b=NwaehmWdswmwSTS++3x75VrC8DRdvHgIbQQtBqMVnf3EpblFKXBBz+ToI5hsY9ZFzxm7DJ7uqMkCyghYFKlVECo1i6v09/8Weo1waEqrM+F2zzasyhRUEw0YAOKlQ4TQdwUOzMzwWntfNOpqVMchuWyV764zw63VzQBVU2zc2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063344; c=relaxed/simple;
	bh=N4iAXSUHmzHTiiasauQa+zUO/lUAUmdh1ALM2ShQa1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j0KuqOVui5I4Mxb5xnsynPGJ7NUTGARH4Pm+PoEFlZXA89r324bhxqGnfS/h5ESM+RukdL4PYpgm2ODc6K8QdhmKTFxivODQExR4rkw84ppSktSLBAqpEVtTuChWsarl8+gme5wzUebjYJAQ7wlFNEL6vszPCsa9wnow1hEmIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfQpx5kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfQpx5kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639F51F000E9;
	Tue, 18 Aug 2026 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787063342;
	bh=5iiQ2FYPbWo0c/W7OW1xdMhMlqCw+1yEYYFQ6nGQhkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfQpx5kxb0EIsOu9JAa0EQIimlo5aS5Er0Rf1JR5hv9K4qTOnGgOKDUh5HpNgIeBM
	 6i40F8zvNgqpmFPXw3syeIINUasnNSASov3kI+yT0xLakluS30Ed96FyEW1SZHgIQZ
	 p0Fr0p6bOWmlZwI9vwqWES9twecDv6W1KM3aToQJ3ZPp5BEF6Vw/Fks8m1XiFCkNpZ
	 A0cIWroeUjh6MYbUlOhXqZDDhGI1M3BFz1ZcEdfa6mL76YqrS1pDBUzhP2PDRfjmVf
	 Uj6sB8WiYygXtfMwpclIcIlBr82hzBKnWxcjeu4GDEvZkZvyjbGKb/MUup/2XjbEDM
	 00w0X6DNBsh7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf unwind: handle allocation failure in
 libdw__get_entries()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818142400.729633-1-triet.hoang.dev@gmail.com>
References: <20260818142400.729633-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:29:01 +0000
Message-Id: <20260818142902.639F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of `ui` structure upon `dwfl_ui_ti` allocation failu=
re.
--

--- Patch [1]: [PATCH] perf unwind: handle allocation failure in libdw__get=
_entries() ---
commit cfa13e49d271d0f1a99af3ba9b78fd579579b1d0
Author: Triet Hoang <triet.hoang.dev@gmail.com>

perf unwind: handle allocation failure in libdw__get_entries()

This commit adds a return value check for zalloc() when allocating the
dwfl_ui_ti structure. It returns -ENOMEM upon failure to avoid a NULL
pointer dereference.

> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 7f35042be5677..ff36552ca1759 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
[ ... ]
> @@ -379,6 +379,9 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *ar=
g,
>  		dwfl =3D dwfl_ui_ti->dwfl;
>  	} else {
>  		dwfl_ui_ti =3D zalloc(sizeof(*dwfl_ui_ti));
> +		if (!dwfl_ui_ti)
> +			return -ENOMEM;

[Severity: Medium]
Does this code leak the previously allocated ui structure?

Earlier in libdw__get_entries(), ui is allocated with:

    ui =3D zalloc(sizeof(*ui) + sizeof(ui->entries[0]) * max_stack);

Returning directly here bypasses the cleanup path at the out label, which
normally calls free(ui). Should we free the ui structure before returning
-ENOMEM?

> +
>  		dwfl =3D dwfl_begin(&offline_callbacks);
>  		if (!dwfl)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818142400.7296=
33-1-triet.hoang.dev@gmail.com?part=3D1
