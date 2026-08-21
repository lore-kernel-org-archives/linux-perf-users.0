Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CE2ED84A
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346470; cv=none; b=EeRNQExbswPS/zi6sHk9RKRiQd1zwGV7kxShDwgOxAEUZ50uyPa7qUR0i8RjhZvVDw6vX2mJpNVlAv6LTXWG1YvuEoOBvtX62/Ip7iJpWD/319zYODxfcjXZJZXsD7qjnAuNCRYn4xubBGRWcGIaAt01OQju3VzRBxv/VGAPvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346470; c=relaxed/simple;
	bh=Nxf+t49quaXACiIPS5avJNPsoImqI+rDiVoxFPKozjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xh4TNhfgEtjHgBK4ZA0crbPCDnbAlYJHJ+CK7dpRC0JdZBSaboyQLh2aPuXKZSvXvHm+A+FRCaeZUTd8YWVBtAfwfndZ7i0UKx/CKIFCQTBD/oWBKC33Bapys/3nW8BA+ZuNCICVBUdsV52ZCYNrmENltgrHBEJvE2w51lCr8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjEWgbiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjEWgbiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FA31F000E9;
	Fri, 21 Aug 2026 21:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787346468;
	bh=Nxf+t49quaXACiIPS5avJNPsoImqI+rDiVoxFPKozjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gjEWgbiJbG4K+KXK9xGIwqx2oRZe7/ogDEwS5tMmK5wYyY/99sqnJt3GYZ77ovPC3
	 X+nKuiUnRdUOzrL1sCh+OtxrqutZlhwmaltMn6Cies+ogH791Tp9FifOb1Q6yWSZbC
	 77owxTuzA0gUzXYMGUN1jB01mtaHcQ2q+EdeMhyIorWBUiNKDx4JLLWg5DhMM93BEG
	 Y2Fh50ZiehHUk0MRLQAS8d5uHWzutHL3HrZB7KRJHUPVYA6GkGbVBpq++vxXYBQ0AS
	 SZZGJ83WxuqI5oGnDW/DRMW+SjIUh666cXH4gf15t0JnzfJQulaLsrqefhIZ2yYvyB
	 7Utq0sxfYgvew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 3/4] perf trace: Enhance BTF type
 formatting to symbolise kernel function pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821204930.679027-4-atomlin@atomlin.com>
References: <20260821204930.679027-1-atomlin@atomlin.com>
 <20260821204930.679027-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:07:47 +0000
Message-Id: <20260821210748.73FA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When BTF (BPF Type Format) metadata is loaded from vmlinux, 'perf trace'
> can inspect the precise C types of tracepoint and system call parameters.
> However, function pointer arguments are currently not recognised during
> BTF pretty-printing and default to hexadecimal output.
>=20
> Introduce btf_is_func_ptr() to inspect BTF type hierarchies
> (i.e., traversing pointers, typedefs, and type modifiers) to determine
> whether a parameter resolves to a function prototype
> (BTF_KIND_FUNC_PROTO).
>=20
> Generalise BTF type caching via syscall_arg_fmt__cache_btf_type() to
> handle structs, unions, enums, and function pointers alike. When a field
> is identified as a kernel function pointer, trace__btf_scnprintf()
> routes its value to syscall_arg__scnprintf_ksym(), enabling automatic
> zero-config symbolisation of kernel function pointers whenever BTF is
> available.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821204930.6790=
27-1-atomlin@atomlin.com?part=3D3

