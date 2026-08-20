Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE683BB106
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261128; cv=none; b=XwgNLae1Z1zd6G+uH/b9tJQ52UValh8wI/hAQh9JAP4ouK9exz791YIP9lAey1EGPPLONPoNZkYWzFYaZL3P0kHGAMaKxrrmhLjfisOI3cnxGUJDHoC/V3uW5mqWDNbhsD5O2rbH13HeUb0r9i4qJglQ3FxBxPiHhgEhStjhkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261128; c=relaxed/simple;
	bh=p3of+0RQmE4vAjYQJiGWLk1fa/npa5erAqHJz4MwxEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NY9w8qBZGYAi0STEkACPpro1tDLxY11GeD5qqZt2nHDfvwDtbsdHdFR2jP7nDnEpaCCj5uUk4CFfkA5hhuoMX6K1GV5Ax+A5wQrVSrxKoScARGKSgAYGuzyYYtpcDnKfsDFdqdSexxAGbSal7WjNxe9KYhv/xYloz9n7lveP4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR8LTR+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR8LTR+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A7C1F000E9;
	Thu, 20 Aug 2026 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261127;
	bh=p3of+0RQmE4vAjYQJiGWLk1fa/npa5erAqHJz4MwxEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SR8LTR+KROkWDM+bOTp2YTcHrZjnS6EFLRQkjAvXhinY2zHEFGqD9HirrwGbhLa/A
	 4T4OMbMpqukh1fxYurjFlp+Iw2SfBJG6xxoU873agd5k2wjI6LBofoyAD12jBZ6oKO
	 dwavGIDwG+rzU7fwBVg26x1G1GfeLSnHyggVYtpNQnwUy/Zij3k0uqoTPm9RMiZD7p
	 Emvvck4JnYFfUfIPnJm/9JNkTzVm5SpRTqK9Eb4pZIBkcnF/p+Cv3q+hPRoqVcGe+i
	 4O51dcyjWK5C1dgc3QlVSSehlKGG5I6mc332e2pJPwuaQZsbRXOlZdzrmsHswYI3A2
	 FySnBgN019WFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 3/4] perf trace: Enhance BTF type
 formatting to symbolise kernel function pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260820211100.649142-4-atomlin@atomlin.com>
References: <20260820211100.649142-1-atomlin@atomlin.com>
 <20260820211100.649142-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:25:26 +0000
Message-Id: <20260820212526.D8A7C1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820211100.6491=
42-1-atomlin@atomlin.com?part=3D3

