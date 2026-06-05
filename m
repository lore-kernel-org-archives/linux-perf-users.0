Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0540212566
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641110; cv=none; b=Ah5roBBRAv6ZIV11UMfMTVvnfBrrWs6kiXFxFyVGhN4TjvK+dKbiK4uYpDTdIMbHP7M/+8L4v4jqAkAs8t6X1Hb45e/H3TNdyykqmPSG7ucyeZz21DVMgyxOgwFSBaR3YGcBhkYcrmnVYHOjGYIAe8smuC2P+cnhQuFVwFF/gjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641110; c=relaxed/simple;
	bh=lEbAlMMXOgxEtbBinXq5G0HDQaNwfyqjgugK/TtUj60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z16WvD53Mz2A7DO7b9V4QiYJddSze1CM+3SwGg9hM0MlLE0RwuVZFcszYvwN/IwrVzi5KqSN7ViOZ4+FNdNU77uiB4oOF69XHOIIfYtMuIk1KQkBpKhNxOq0kIqbYvQc6PzoCYdydc7GXZE/fGdooI3dPc1N4HgR/Lv+ksKhlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtubK6dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtubK6dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2541F00893;
	Fri,  5 Jun 2026 06:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641109;
	bh=jMaXzgQz54k8lOFT3F9AxcH/3ATKW31Th6CcaicqVzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtubK6dqPGp/zRfYqjI/9nb0ZxqJxISoUBUYsBMuCRgy7pcmasdQuuDG3LX/4FKSy
	 sUogUIpcflBlJ0ltNG19qjzOkD0uTLsZvnDIpNw3o7WYna6i7h9tYN/ymJwgmaAZpC
	 IOyOdZdFRnkf1dGeaAfFmXNGF5YwevWWytwb06q8wEopa5yYMazg86zhv7yzMNzTgm
	 5Li6Gcow0OhYZaanZi6AVWieBNaHob79+sn7tohfCgQxcOihaaAA2kBYDn/mBRs2UF
	 AFr++N0gppRLk/dSiY8CTQMVCvXCJg49I+QxpKf5scqSkuRnv3+KJQdvXa1JHkGI3e
	 UgEl5BH3mI4wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf scripts: Add configurable sorting option to
 powerpc-hcalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivani Nittor" <shivani@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605062717.24982-1-shivani@linux.ibm.com>
References: <20260605062717.24982-1-shivani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:31:49 +0000
Message-Id: <20260605063149.6E2541F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The argument parsing loop in `trace_begin()` will crash with an =
`IndexError` if `-s` or `--sort` is the last argument provided.
--

commit e3cf27646cdda0e6126f0f6cde0a6fdbb2db8e8c
Author: Shivani Nittor <shivani@linux.ibm.com>

perf scripts: Add configurable sorting option to powerpc-hcalls

This commit adds a runtime-configurable sorting option to the powerpc-hcall=
s.py
script. It parses sys.argv to allow users to order hypercall statistics by
count or various latency metrics.

> diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scr=
ipts/python/powerpc-hcalls.py
> index 8b78dc790adb1..df7b83ab0b6e0 100644
> --- a/tools/perf/scripts/python/powerpc-hcalls.py
> +++ b/tools/perf/scripts/python/powerpc-hcalls.py

[ ... ]

> @@ -158,10 +159,42 @@ def hcall_table_lookup(opcode):
> =20
>  print_ptrn =3D '%-28s%10s%10s%10s%10s'
> =20

[ ... ]

> +def trace_begin():
> +    global sort_key
> +
> +    i =3D 1
> +    while i < len(sys.argv):
> +        arg =3D sys.argv[i]
> +
> +        if arg =3D=3D '-s' or arg =3D=3D '--sort':
> +            sort_key =3D sys.argv[i + 1]

[Severity: Medium]
Does this code risk an IndexError if the script is invoked with -s or --sort
as the very last argument?

If a user fails to provide the actual sort key value at the end of the argu=
ment
list, accessing sys.argv[i + 1] will be out of bounds and crash the script.

> +            i +=3D 2
> +            continue
> +
> +        if arg.startswith('--sort=3D'):
> +            sort_key =3D arg.split('=3D', 1)[1]
> +
> +        i +=3D 1
> +
> +    print("SORT KEY =3D", sort_key)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605062717.2498=
2-1-shivani@linux.ibm.com?part=3D1
