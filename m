Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950F44CAE6
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625219; cv=none; b=ti2q4r2LHqy5x2qwiNJm4s+whrpsgJYJzBuEBmlZXMTGs5EF5kbBA/QwnHu+oPMKe/1806/CqardbFvGVi/2e38+p3xtN64ljcx0GeETqlrpjfKe+g/yJlvzsNAK0k7YSOpTagyFqsW+2pYdNRxOGIsGYu8qY43qkPBSH4XLooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625219; c=relaxed/simple;
	bh=R5Tua9/+v9DtY9Vg47VoMQ45gSOImRyZQss7VMKCxgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gXXU1rrFT51g/LDwn5ytxcvyrSdExeyVBBojiwC6pyfpKzOiFUYHeNplYmX2q+Q7v6XmSnqJrwgoaUExiMWu/LWE0gbtYptz8Ag7CuyHAsKSAsvj8UWZK9v/KX39vOFSDimAAGfJfAE9j6U8ZklDngk7DgGzN7s5U0T9Ay8O4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1M9Ke8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1M9Ke8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969D51F000E9;
	Tue, 16 Jun 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625218;
	bh=lVF/PKyx3WI1FWtFjdtNNKAVWFVNzDOHb2HmTt/GYzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1M9Ke8yANASUWdBl21gRpQptMflX9yPeZbDZOr/Zhi4ZVNRB5Gxqe8rgxQPLexm5
	 iMNLFbKlSJUsBU4/LVdjYZkQr5ZwGgnKgSAbf55CWcjZhKSof/hFLrl87m1sWjHa0+
	 AOsCGnI+vCXlgCIrguz0Su0e7dzuK7ojOi+Ve0i9JrqvXZtmCCphbLsKoU1BdJnLdI
	 o4Qvj0C3F9IBoEkEb8YxgmTjoy/eCfh1lTxCQX4p56QeewSlWFZjEwbetQW4yjlbpi
	 OEravAoplGUzZRDI554F718zWBlsUwY3RAMo2CMo/gjWNkErlnrh3jhgkMLMYDpI+Q
	 hiKjmzmP5GVdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] perf machine: Propagate machine__init() error to
 callers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616153920.6852-2-acme@kernel.org>
References: <20260616153920.6852-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:53:38 +0000
Message-Id: <20260616155338.969D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized stack variable `vmlinux` is used in the error clea=
nup path.
--

commit 8e1583abbdee63a3ce3ab81325d341791cab8d7a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Propagate machine__init() error to callers

This commit updates machine__init() to propagate memory allocation errors
and adds return value checks to its callers across the perf tool and tests.

> diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlin=
ux-kallsyms.c
> index 7409abe4aa369..e88e7b2a82c5c 100644
> --- a/tools/perf/tests/vmlinux-kallsyms.c
> +++ b/tools/perf/tests/vmlinux-kallsyms.c
> @@ -203,8 +203,10 @@ static int test__vmlinux_matches_kallsyms(struct tes=
t_suite *test __maybe_unused
>  	 * Init the machines that will hold kernel, modules obtained from
>  	 * both vmlinux + .ko files and from /proc/kallsyms split by modules.
>  	 */
> -	machine__init(&args.kallsyms, "", HOST_KERNEL_ID);
> -	machine__init(&vmlinux, "", HOST_KERNEL_ID);
> +	if (machine__init(&args.kallsyms, "", HOST_KERNEL_ID))
> +		goto out;

[Severity: Medium]
Will this cause a crash in the error path?

If the first machine__init() fails here, execution jumps to the "out"
label before the stack variable "vmlinux" is initialized.

In the cleanup path in test__vmlinux_matches_kallsyms():

out:
        machine__exit(&args.kallsyms);
        machine__exit(&vmlinux);
        return err;

Calling machine__exit() on the uninitialized "vmlinux" structure might atte=
mpt
to free or clean up garbage pointers. Could "vmlinux" be zero-initialized
when declared, or should the cleanup path be split to avoid this?

> +	if (machine__init(&vmlinux, "", HOST_KERNEL_ID))
> +		goto out;
> =20
>  	maps =3D machine__kernel_maps(&vmlinux);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616153920.6852=
-1-acme@kernel.org?part=3D1
