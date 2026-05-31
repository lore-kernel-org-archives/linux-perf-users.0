Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0235979
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210018; cv=none; b=hr6MdketJi0jJ1sz4+qPmiP4m7XfLo50yRTXR03sn2r3+jbtBHSaVtE28EwjzxYZIvOUwzRhAAf9BM/iEufAXswyJZog1nxKWLC/UUuTGY5LHAnLXGcJHb4S/vevvIAgcxVMMEHKHKna7Yxn8rQ93DAuJxjbLRsRmvDdq/gESzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210018; c=relaxed/simple;
	bh=N+h1kGFivxZ+k8C01DE3BuS7jV/u5uvPAa5tKf90TMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VIE35qBv53yMHu3P2knZErtzb2og6RhQedZBpjE4WCkurnQJClJ7+QiQkv9YGNEKm0GXbpIziEW7B+9Iia9Vq7Yyz6izYgm2m7PSFlQS4mZ1VYo1xJfSDuxv9JueRxSyEk9U8hO0mvNt+d3dFlxp3yjQLh279KYf5SC8YcWlBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo53WBDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo53WBDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0251F00893;
	Sun, 31 May 2026 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210016;
	bh=CSncC/dlco/2p/I0NJznkEUd197WvBAOuVC960DHv9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zo53WBDttg54mmUHH31slNCP+XRcWe2T4UAgUVC09wQp1xIU+Scmd8ssAc8AyJxq5
	 oxT0xqOqPt9Dch2MliiCka0n4dQYhg5VzbO83GEi/D2dbL2AHV/tIFhoivaO+E4jtM
	 4AC1SrlVv9pYN6xpEbKCk0erB4jvB8YF2tigcX5ZL15SoIW2qguenqhGGCBybNuqcc
	 kXY2b0ie+H6geurrBCVenH/Gu6IxEj49sXE6ozD3kBJ7mjFMJDbtuRWRkJQc5Q0XDj
	 SC/c4v3ZVjIwl2x5oBoZijLv/1L3L8jOoBJvt1bB0xSaCma32wp9ATyySiyMLbE0ha
	 noS5ks0j54WiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/14] perf jevents.py: Make generated C code more
 kernel style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531063736.871777-2-irogers@google.com>
References: <20260531063736.871777-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 06:46:56 +0000
Message-Id: <20260531064656.BB0251F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `/* clang-format off */` directive in generated split C fil=
es, leaving an unmatched `/* clang-format on */`.
--

commit 69b593c82711e122a96b992aa3098ed70fbdacb2
Author: Ian Rogers <irogers@google.com>

perf jevents.py: Make generated C code more kernel style

This commit updates jevents.py to make the generated C code comply with
kernel formatting tools. It adds clang-format directives to bypass large
generated tables and fixes indentation and line length issues.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 7344940e776a6..6f80f937f9f94 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -1466,6 +1463,7 @@ struct pmu_table_entry {
> =20
>    _bcs.compute()
>    if not _args.output_string_file:
> +    _args.output_file.write('/* clang-format off */\n')
>      _args.output_file.write('static const char *const big_c_string =3D\n=
')
>      for s in _bcs.big_string:
>        _args.output_file.write(s)
[ ... ]
> @@ -1487,6 +1485,7 @@ struct pmu_table_entry {
> =20
>    print_mapping_table(archs)
>    print_system_mapping_table()
> +  _args.output_file.write('/* clang-format on */\n')

[Severity: Low]
If _args.output_string_file is provided, we skip writing the initial
/* clang-format off */ directive in the block above. However, the=20
/* clang-format on */ directive is written unconditionally here.=20

Could this result in an unmatched formatting directive when outputting to=20
split C files, potentially breaking clang-format checks instead of bypassing
the large tables as intended?

>    print_metricgroups()
>    _args.output_file.close()
>    if _args.output_string_file:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531063736.8717=
77-1-irogers@google.com?part=3D1
