Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF72E06EF
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707603; cv=none; b=m1H0Xi5DgIiNRiEEMGt+yto89bD39zXTvQSLMcGbeMxS7VZypmuT/g/vZSOta1SdcY28LlX3IKxPa9DapjtDAm/RbbGq1ck5rbNiXoowZ7Ge6mQyDuQk7XcuMMpIO7map1w9zPAk412BxQflRLhjLIrv2KJzvQzqx9G/Rn6ipf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707603; c=relaxed/simple;
	bh=wk/U3dHAEePSVR50U9ZPQgOqEQ3Cf4TaLxuV1TFcjHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F9bT94gYAiL3Y82trI599eZaCFwRgK4ILO/mIC0ndNaWTlhTVfl6wMZaA2y3ZNHxIdtPr+AJJl0h2AT443JZkQsXavUSVLMO9RV9NhC8Ldmpi1uP1eDd8WOimh8C32ow2fx1mZ9ycK21EoFc4VtUxM4oGRKj+wi3qIGfU0eaOZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwN4tLYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwN4tLYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092BE1F000E9;
	Wed, 17 Jun 2026 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707602;
	bh=6ZB6+Llhj8gW87tTKQSmsVvZrZZR+Dm+HyGkO/c4NPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwN4tLYpXDQ93hNpfSP2NZBtz2sllaUFjC/ck6o/RBUzUCRI1Rn/JoISRek/KExJM
	 /xL5NvQLsJlUUIRbB+U5v8DQHWlxn4vdeUN8mMbRe3ITyflkVuYSKy4yP5gvdZd85g
	 GeztQZ/wg9o63AZg476Inb9I1LgKqhxE6zjQ/dY4Jwt59tOr+4RXsKBXOK/8rhwzg5
	 468YLbZdl8cP3ifIttTLD71pwsScx7OkUZKjVRX0TkzGY1RMiWOWyjV93VjIF7sCul
	 rUpaQcPBTL+qsMgFbpWUyoVm7id4kuOxR30DLIaPt7obHPWY+gXdLOlHKrrxHkgwLm
	 s9hsEXTV7H8UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf scripts: Add configurable sorting option to
 powerpc-hcalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivani Nittor" <shivani@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260617144011.17359-1-shivani@linux.ibm.com>
References: <20260617144011.17359-1-shivani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:46:41 +0000
Message-Id: <20260617144642.092BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `--sort` argument value is not validated, leading to silentl=
y ignored user intent and misleading output for invalid keys.
--

commit 1aa1f92efbcdcc2ec41737225787d40ac02abf40
Author: Shivani Nittor <shivani@linux.ibm.com>

perf scripts: Add configurable sorting option to powerpc-hcalls

The powerpc-hcalls.py script currently prints hypercall statistics in a
fixed sort order based on the number of hcall occurrences. This patch
adds a --sort option to runtime-configure the sort order (count, min, max, =
avg).

> diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scr=
ipts/python/powerpc-hcalls.py
> index 8b78dc790adb1..e5b0c1bee65fb 100644
> --- a/tools/perf/scripts/python/powerpc-hcalls.py
> +++ b/tools/perf/scripts/python/powerpc-hcalls.py

[ ... ]

> @@ -158,10 +159,45 @@ def hcall_table_lookup(opcode):
> =20
>  print_ptrn =3D '%-28s%10s%10s%10s%10s'
> =20
> +def sort_output(opcode):
> +	stats =3D output[opcode]
> +
> +	if sort_key =3D=3D 'min':
> +		return stats['min']
> +	if sort_key =3D=3D 'max':
> +		return stats['max']
> +	if sort_key =3D=3D 'avg':
> +		return stats['time'] // stats['cnt']
> +
> +	return stats['cnt']
> +
> +def trace_begin():
> +    global sort_key
> +
> +    i =3D 1
> +    while i < len(sys.argv):
> +        arg =3D sys.argv[i]
> +
> +        if arg =3D=3D '-s' or arg =3D=3D '--sort':
> +            if i + 1 >=3D len(sys.argv):
> +                print("Error: -s/--sort requires a sort key argument")
> +                sys.exit(1)
> +            sort_key =3D sys.argv[i + 1]
> +            i +=3D 2
> +            continue
> +
> +        if arg.startswith('--sort=3D'):
> +            sort_key =3D arg.split('=3D', 1)[1]
> +
> +        i +=3D 1
> +
> +    print("SORT KEY =3D", sort_key)

[Severity: Medium]
Will this result in silently falling back to sorting by count if an invalid
sort key is provided?

If a user runs the script with an invalid sort option like --sort=3Dlatency,
trace_begin() will assign it to sort_key and print "SORT KEY =3D latency".

Then in sort_output(), it will fall through the conditionals and return
stats['cnt'], leaving the user with output sorted by count despite the
printed sort key.

Could we add validation for the sort_key argument to error out if it isn't
one of the expected values (count, min, max, avg)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144011.1735=
9-1-shivani@linux.ibm.com?part=3D1
