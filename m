Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039D4A8420;
	Thu, 17 Sep 2026 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687226; cv=none; b=kus0tFQduEe1kerM8FvoZBcxdj51pLM9Lypeizui3ZQ1K5dpVTW+bkusSfEAr1LZnHiu2HqTptcSH7AfM5P72UwHStFMQtNBP00Fp3kuJybL6/Knw0Yx6BMIdUrFMUsgSpSUIH9TdmN9HV77ae+JXqaf5eeLNCF7DfXrcSuzlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687226; c=relaxed/simple;
	bh=QWem72qjwmKB0O3XY14c5S2UFRe6hjbc3nABmDM6yKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sx0v2MEBvM5+YalKQfpeK+Z4HUeNsp7xI1OJPYXq7iE/HZrA/a3Svzwv6BJELnzzIxx0BJkkm3YctO45zexRs6lTRkWiDAtc80KM+MgXta5emPES3/gxGosSPRNaJTe55tQlP0iHNqTUdwHdTQ/RKAx4dsCrx7hsUtWGyEoLzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcKA+IMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcKA+IMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71D21F000FF;
	Thu, 17 Sep 2026 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687222;
	bh=OVIVIFs1zXRGON3X/HBUQkTMWXvFsHVSwpZ5M/dWsLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcKA+IMcT9v2DecgD/3lYx+GNhkCZR10N0PmYrvuqndjJ12hNx2zjKIETVdhL5Zb6
	 mdfIH6wyKWLt2dtWbhbt7TD4ZIfFyPiRwETddi46S3uyJSKNE3wS1RFK9JWpl5Vd+j
	 Il7UIQyk8V9+0lKxzbJ+JjXWEazq/aKegJKwjIgrPcMJNKlrincc95E+WYwtpHGbON
	 726FIXQMpfqL5ZNF7YPzJ7k8+Y2KpUa2s45Utucb1UlpCitQJEMbAc1cEv5KSbqKqH
	 tqBH2XUMw3MV/+wkzL1N4CizLClW2SDFBl5JB6FmDp2ruC13n3UjkaOmAlbalg4AHG
	 e9UjZXZ9LNRyg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/11] ptwrite uprobes: Add a sample module to
 exercise interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260917230127.924985-4-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-4-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:20:21 +0000
Message-Id: <20260917232021.E71D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] samples/uprobe: dead code in parse_probe_args due to loop invariants
--

commit 77dc8c84b5d7c061149ad9471b13f1d9dabd7049
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add a sample module to exercise interface

This adds a test module and userspace target program for uprobes ptwrite.
The module can be configured via parameters to register a ptwrite uprobe at
a specified offset and emit live registers or immediates into an Intel PT
stream. It is intended strictly for testing the interface.

> diff --git a/samples/uprobe-ptwrite/uprobe_ptwrite_test.c b/samples/uprob=
e-ptwrite/uprobe_ptwrite_test.c
> new file mode 100644
> --- /dev/null
> +++ b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
[ ... ]
> +static int parse_probe_args(void)
> +{
> +	char *s, *p, *tok;
> +	unsigned int n =3D 0;
> +
> +	s =3D kstrdup(args, GFP_KERNEL);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	p =3D s;
> +	while ((tok =3D strsep(&p, ",")) !=3D NULL) {
> +		struct uprobe_ptwrite_arg *a;
[ ... ]
> +		if (tok[0] =3D=3D 'r') {
[ ... ]
> +		} else if (tok[0] =3D=3D 'i') {
[ ... ]
> +		} else {
> +			pr_err("bad arg '%s'\n", tok);
> +			goto err;
> +		}
> +		n++;
> +	}
> +	if (!n) {
> +		pr_err("need 1..%d args\n", UPROBE_PTWRITE_MAX_ARGS);
> +		goto err;
> +	}

[Severity: Low]
Is this zero-argument check reachable?=20

Because p is initialized to a non-NULL string returned by kstrdup(), the=20
strsep() loop will always execute at least once. Inside the loop, any
invalid token triggers a goto err, skipping this check entirely. If the
token is valid, n is incremented.

Normal termination of the loop seems to guarantee that n >=3D 1, making this
condition structurally dead code.

> +	desc.nargs =3D n;
> +	kfree(s);
> +	return 0;
> +err:
> +	kfree(s);
> +	return -EINVAL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D3
