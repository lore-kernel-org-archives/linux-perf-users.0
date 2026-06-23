Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94943B102F
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251218; cv=none; b=mpJDJEMTjJZXKzqgZIbdxkqefpj/NOpaVg0qzGqqRWIOIAz00M5O0ZE5zdpp4idyVc1kTi/nXC+D9DllpRAC27W+TZjbcvz0mj8V9PbLR0BeSjLfQeGnO/l6IXyueLdZZwWFOIuMTSArw0v/mWrJIAamZgx1WpkHcSs7iL3sBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251218; c=relaxed/simple;
	bh=JXgxWQa95XIvCphWzvEbtA6e/RopWT1PDUGRYNBthcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tmZpLb9zJlrjzv3zdW3odWuX8hheelPgVmtHNBNRAcTqp/BQME1/814NAJ3uVQUkgtvY5uVRnLr8BAoD+8fVtUOJoKVj50EoTM8Y1nlMyZixFZ2IMsQXzzo7uh+4xxYim99Tn3/WKlOBJ5GpBwvtvf1ZNGf82+Npvxf+Jroohc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISiS3b88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISiS3b88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E522E1F000E9;
	Tue, 23 Jun 2026 21:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782251216;
	bh=NliGj/nFWfb+7WeHEeLqJHTzSUW6uWRjKDfqfFfHw6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ISiS3b889cicbswXQHPYWZfSGeeArOnWkAoje0RaPZnGJZFPIx7cG0pidERABlQ4P
	 dsrA9QbvPSMMEBBk8d6RIDI1W0BT1nnTaUVIzexmps6ghcR862ABy2FcU4aWZZM/YW
	 iohJU1a/ZBa39wu15e90bifPNB/dF9jywcj/lZOmpACWNJ9R0Kl3pzKOSCW86/fw49
	 DLvZJbVu2dxrHM/Jh0O1XQZddSL+UV+UtvGIHCqpPibTXXk1WzepBE+s4pXNH/e5Oi
	 DqP9I26eDk7VZlLvZ3Pd+1MwQF1F+Ftt2rVtrtvirUrCZSgsEUq6NqI/LKxn+Cc7ej
	 7mh0zwFoaFz/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] perf kvm: Do not copy filename string
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623191439.3621593-5-namhyung@kernel.org>
References: <20260623191439.3621593-1-namhyung@kernel.org>
 <20260623191439.3621593-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:46:55 +0000
Message-Id: <20260623214655.E522E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The error checking logic for `get_filename_for_perf_kvm()` is unrea=
chable dead code.
--

commit 0b8de0bac81d07f5d9beff7d22b8144187910bab
Author: Namhyung Kim <namhyung@kernel.org>

perf kvm: Do not copy filename string

As it removed STRDUP_FAIL_EXIT(), it no longer calls free() for elements
in the copied argv.  Thus, the filename should not be allocated as well.
In fact, it's a pointer to string literals and should be fine to pass
the pointer.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 278543ca66a37..021af3c64acd0 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -607,11 +607,11 @@ static const char *get_filename_for_perf_kvm(void)
>  	const char *filename;
> =20
>  	if (perf_host && !perf_guest)
> -		filename =3D strdup("perf.data.host");
> +		filename =3D "perf.data.host";
>  	else if (!perf_host && perf_guest)
> -		filename =3D strdup("perf.data.guest");
> +		filename =3D "perf.data.guest";
>  	else
> -		filename =3D strdup("perf.data.kvm");
> +		filename =3D "perf.data.kvm";
> =20
>  	return filename;
>  }

[Severity: Low]
Does this change leave unreachable dead code in cmd_kvm()?

Now that get_filename_for_perf_kvm() returns static string literals, it can
never return NULL. However, its caller cmd_kvm() still checks for NULL and
returns -ENOMEM:

	if (!file_name) {
		file_name =3D get_filename_for_perf_kvm();

		if (!file_name) {
			pr_err("Failed to allocate memory for filename\n");
			return -ENOMEM;
		}
	}

Is it okay to clean up the redundant NULL check and error message from
cmd_kvm() since this allocation failure is no longer possible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623191439.3621=
593-1-namhyung@kernel.org?part=3D4
