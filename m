Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3112BE639
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505393; cv=none; b=naIOSu2/P+kXt6B2jt4ELpSyz7Hw+UUiMZJAW0i4jStoXUcLjD0WqzhjQZXN/Ca+3sydFZbdGNmQhoEqSFbO6ppZNHks3TiqHpppZyIfrwJxtqSpYHteSU0nU1a4IHPwYyxSFdz+i+3uEi7JRxXaJkq6kWEDAe+L5uOf1ol659E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505393; c=relaxed/simple;
	bh=HcwnEQJ8USliHKefOjgsgq20HgAfT5G92kxCcLANG4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lal/QQYQoCoVodDznS5VpgRcTjcAvJLyA9bnzcfk/LMBPvbMd8dZpON1NznbXyoO3Yq6gqfnmpFYw4Uxz8t65qUW201y78p0JsUdXzdHzGmbrjm0CChz6+Cma1MzCIFb8u5REiKelt+M//BQJCyS1k/BYOZKJFkEPSYzJ2HC6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A82ZPIie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A82ZPIie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286AB1F000E9;
	Mon, 15 Jun 2026 06:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505392;
	bh=RGb8nP4/V0kZCePzSbov/Kqrq+ItnoaNp/rg2HRye0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A82ZPIieaeB/dMCWWZbvsAHBqT/gJjeNoOB5uPC8TZxThRs9HgDNnx3wscNcih4a8
	 82zlr50t7dBdaOJO9ghV2dV8GLL9WDnPrawfrxHVxAND50grfkUZB9qTlUrUqXuloQ
	 vdfX5udD2hb8iAYTsi7MQ7hnrT3xeuqbtDDeI9+uu2W7bE3oLCoMEfs4QOjUfqltHe
	 OXVMwPPqitMBBCmyAR1QNJowofVYcmC9U6lAFTb+emrATlfo/WPFn/v6ODMtpb35F0
	 cV8Yg8IT7+cByyLGn+F1dik7bfOE7zRHDyyIc0DwEjkyFiYSmAUJpUB5FezFkPjIqA
	 6RXCLFWoHjiCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 16/20] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615061631.2382079-17-irogers@google.com>
References: <20260615061631.2382079-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:36:31 +0000
Message-Id: <20260615063632.286AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete implementation: Python API added but consumer scripts=
 were not updated.
--

commit ff9507ce0a8986f66a3d70f2a27f0202d3db6c23
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

Use perf's syscalltbl support to convert syscall number to name
assuming the number is for the host machine. This avoids python
libaudit support as tools/perf/scripts/python/syscall-counts.py
requires.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c5b8b9f1ea4a7..f1230bd222d76 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -3954,6 +3956,40 @@ static int pyrf_session__setup_types(void)
>  	return PyType_Ready(&pyrf_session__type);
>  }
> =20
> +static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args, PyOb=
ject *kwargs)
> +{

[Severity: Medium]
The commit message indicates this change avoids the libaudit dependency
in tools/perf/scripts/python/syscall-counts.py. Are there missing
changes to update the script to use these newly added perf.syscall_name()
and perf.syscall_id() methods?

It appears the patch only adds the C API extensions in pyrf__syscall_name()
and leaves the scripts unmodified, so they will continue to require
libaudit.

> +	const char *name;
> +	int id;
> +	int elf_machine =3D EM_HOST;
> +	static char *kwlist[] =3D { "id", "elf_machine", NULL };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615061631.2382=
079-1-irogers@google.com?part=3D16
