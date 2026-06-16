Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFC37C92E
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575186; cv=none; b=tIOWZfLx6Qm5Sc1PxZKJKxs4x87Yf4bxIZCnAGtHftnGotwbqodHBTWkU/wxmwCrHUbaIN0f/tWLt5KEaeNt5SJDWK+x97iflBvKxzfTRV5OELuxYsamfTL8PdiVe4FGo1gPVWKhfvB5+aoNeWy+2fBlzgfQOryS+NPFydAST6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575186; c=relaxed/simple;
	bh=Cgd4Q5G3ZejkPrHpNVeeMr1mVSAa36foAp8rg5koC5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OkUAcuie1EOIcm5vaDdRSHOk7RZU8QmNPKAcUqphh/nqXQBHvtxvQ5LB+svCjV4hu5ZOEM1uJw07TzkHzgE/fWcHBKQHO8hHmmjx/jypggY03kPwnC04E47S6utQc2bs6ZzjePUItC03UnE//iN5d/9sB1FrMA/MjpMGSpdL4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtBzISzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtBzISzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522511F00A3A;
	Tue, 16 Jun 2026 01:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575185;
	bh=zMsa1durl2B5NnXUqB3ZF8DHXEkVnEc/rjQ71BP0XOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EtBzISzVkWyq7LGuI+J9vctDML0aVev6yDRH40HvyoCme6XbzQKd9gpqpKjXkPp6A
	 ujbbcR52ghyKbqxl/wUEENT/dz/hnQoy+vn3s8dNYqA411GLYKJ/CpU6ObgxeI/wa8
	 5olcSk9G0PhuJv4Pm1lYPlKorNg46GMPTSZSOzpf2vy+q8Z6LVmVN/c8shOxZKB1Ax
	 esos/soZFtcNagbPwRa2OLPT4dMiP+D4UIir9DIN9uf6RV2MUFmntJxBnCv1CO9fh3
	 HmEVgyuSxQ8nZTXnahEbd3BRYDUTqn/AhAo/wptloIrSDan9thvOhs1rXxKQ0P10vB
	 Se5VMhHKcZp1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 16/21] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616011543.4037138-17-irogers@google.com>
References: <20260616011543.4037138-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:59:43 +0000
Message-Id: <20260616015944.522511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces `syscall_name` and `syscall_id` to the `pe=
rf` Python extension explicitly to avoid relying on `python-audit` for `too=
ls/perf/scripts/python/syscall-counts.py` as stated in the commit message. =
However, the patch series fails to actually update `syscall-counts.py` or i=
ts utility libraries (`Util.py`) to use these new functions, leaving an inc=
omplete implementation and a mismatch between the commit message and the ac=
tual code changes.
--

commit 5f14858d1e943fba0e189e558464ae637b5fb965
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds syscall_name and syscall_id methods to the perf Python
extension to map between syscall numbers and names. The commit message stat=
es
this is intended to replace the libaudit dependency in syscall-counts.py.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -3990,6 +4026,18 @@ static PyMethodDef perf__methods[] =3D {
>  		.ml_flags =3D METH_NOARGS,
>  		.ml_doc	  =3D PyDoc_STR("Returns a sequence of pmus.")
>  	},
> +	{
> +		.ml_name  =3D "syscall_name",
> +		.ml_meth  =3D (PyCFunction) pyrf__syscall_name,

[Severity: Medium]
The commit message states that adding these methods avoids the python libau=
dit
support required by tools/perf/scripts/python/syscall-counts.py.

However, the patch doesn't appear to update syscall-counts.py or its helper
modules to actually use these new methods. Should the script update be
included in this patch, or is it planned for a later patch in the series?

> +		.ml_flags =3D METH_VARARGS | METH_KEYWORDS,
> +		.ml_doc	  =3D PyDoc_STR("Turns a syscall number to a string.")
> +	},
> +	{
> +		.ml_name  =3D "syscall_id",
> +		.ml_meth  =3D (PyCFunction) pyrf__syscall_id,
> +		.ml_flags =3D METH_VARARGS | METH_KEYWORDS,
> +		.ml_doc	  =3D PyDoc_STR("Turns a syscall name to a number.")
> +	},
>  	{ .ml_name =3D NULL, }
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.4037=
138-1-irogers@google.com?part=3D16
