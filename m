Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382840756E
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764260; cv=none; b=SjMoCNnazwcStjDSbjyRzJK+GMVL+ku0xuwFY6+rNoZIj6S1Ccd3cEjQGOTCpWh4TPLTNxPN5NBlIppt2ea34zCDMSVrsRdYL8TzCiZ2y5lzE1kQuo4obYIe4y7MzQXze5I1Y/y46EtVlCkEpt86NsrebwnsdAmfkoZ9nGcPC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764260; c=relaxed/simple;
	bh=+vrMEDInlSW24aQwO8Cu6jUxPCZ0UKClOvcAnVz22hQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/M8lHU4cJeatQyJ96RgcAab1OcoCXLtTneWLpz1Kc9Ouf1wVE4DoHmXPESSkp7WeifcZJKZ5q8p3TbYDhsAQy4rgBgvYkxeSr60Xo71JqH+L3LrzxfLTefGhpTGj4JUoJXuccAY9QxGQW1q9Va6QIOS4fwLKzOj3nxhqTdX/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZvfisgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZvfisgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800381F000E9;
	Mon,  3 Aug 2026 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764257;
	bh=9MjMxt9CRiUp4bEAvvBSBnNbFGdLxx7PHpozG3sqGpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZvfisgWAno8/eUm3TMh3p2J6KM7fdju5yldDiL7gYtwuQOtL9CP2dY4ehzsvARa3
	 Ag3rn2AZbQf9TfQ0OKhgRjz0pK0OrmgOb5OA/xv1nK9vp+PkiaMjIhqtGiNYJWGwjL
	 K46/GFh+W8W2C0plYQYMsx0j0D4sW0zsGXWeHN8Xea7+hSMEMajiTYm3VxLGot1HcL
	 xPx515n9fFAc+UDa7+1dKbHW8v63JpPFiQe4JUnUujaJZizJcYlP+ZNqKzHzODBOqG
	 2YbOmTH17tRNMsgtcVfkJHWh/r1pIfBgGTKmeG5Oss0QFoTDCBBCFqXIn/MLw4u8Ud
	 zk049nNZ/4h3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf tools: Fix double free and memory leak in
 kvm_events_record()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michalis Niarchos" <michael.niarchos@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803-perf-kvm-fixes-v2-2-1b337189fffc@gmail.com>
References: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
 <20260803-perf-kvm-fixes-v2-2-1b337189fffc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:37:36 +0000
Message-Id: <20260803133737.800381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch addresses an array-mutation bug in `kvm_events_record(=
)` but leaves identical instances of the bug unfixed in `__cmd_record()`, `=
__cmd_report()`, `__cmd_buildid_list()`, and `__cmd_top()`.
--

--- Patch [2]: [PATCH v2 2/4] perf tools: Fix double free and memory leak i=
n kvm_events_record() ---
commit de06a9553df4c03dc3591b78a5d37cfb9f36b1e0
Author: Michalis Niarchos <michael.niarchos@gmail.com>

perf tools: Fix double free and memory leak in kvm_events_record()

cmd_record() reorders the contents of the rec_argv pointer array, causing
an issue where pointers are freed twice and others never freed. This patch
fixes the double free and memory leak by referencing literals directly
instead of duplicating them, removing the need to track and free each entry.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 44c6998f2ee5d..45c92ab74fdd6 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c

[ ... ]

> @@ -1717,9 +1717,6 @@ kvm_events_record(struct perf_kvm_stat *kvm, int ar=
gc, const char **argv)
>  	record_usage =3D kvm_stat_record_usage;
>  	ret =3D cmd_record(i, rec_argv);
> =20
> -EXIT:
> -	for (i =3D 0; i < rec_argc; i++)
> -		free((void *)rec_argv[i]);

[Severity: Medium]
This is a pre-existing issue, but does this exact same array-mutation bug s=
till
exist in other functions within this file?

It looks like __cmd_record(), __cmd_report(), __cmd_buildid_list(), and
__cmd_top() all have this identical cleanup loop:

	for (i =3D 0; i < rec_argc; i++)
		free((void *)rec_argv[i]);

Since these functions also pass the allocated rec_argv array to command han=
dlers
that use parse_options() (which consumes options in-place and shifts non-op=
tion
arguments forward), do these other commands also suffer from a double-free
and memory leak?

>  	free(rec_argv);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-perf-kvm-f=
ixes-v2-0-1b337189fffc@gmail.com?part=3D2
