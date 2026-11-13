Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604915;
	b=fFfqVajdiTsANW9YKQLRCoix3zSH6i+jjXGZ6jQsZhGnvNyo63pDd0LmeUmv/+SkYSHi
	 HZRN2y10mj+z27X2CK37fsIuCg1djs4F6sjsJWFgMLI2kYAUjs8xzA9tVzC5l476gutw/
	 N5UL+amBlrtVikrUj8WJxJZLG47UAHVDCoIs9UWZEZWxQ441KA89+ZBa9+NxCpXbtvj2R
	 LulU0h+H8p1Vvw28Js4Cj4BMfE4e2mRK80ShjConQzCnTB2SeDOxsSLpsxspjTkVPK9lD
	 yusZNgq8ojqGOlOHkAmMLe021HGhMXY6j19Xyc4hMlYnAQJoRYf6Bq+A+mTduHXoSBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zzf3M9ufpI7hqWjXCHdlmz91yc6TJWq+H5iQaAg1UYs=;
	b=pZrN+o9Z7I+mdaMZkDxNNeZ+DRI2OFYy98uOJKq3/jN9jrw3Z+9o+mRM9o6W079Zl0Fp
	 ysdLwOjpdidb9gGaBLTqST/aVy4se6Gk4ZAi7mjOLP/kYJQh+rmWrFyq1OWuOJfUwuab+
	 BxKe9hChrUYxuQeG/WM6dFwJZBztgLRh9ceA4NzD3Q6dB6jRQy41L2OYAaCtN1xOM0f65
	 esvX4tdmJKpi7W4gKT5oag8AUNkAvsLpcLD/4lD7R1szK7EIh3uc85y6zozEylwBUB8PA
	 OqJ1gvU+Qk1XUB22+qoCBKGvvgr4msJbyyV/RRIz8xjHuDirjHc4HyFJCfYQrxfJaKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=je3Oec+9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC529606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=je3Oec+9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6661F000C4;
	Fri, 13 Nov 2026 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604915;
	bh=zzf3M9ufpI7hqWjXCHdlmz91yc6TJWq+H5iQaAg1UYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=je3Oec+9RviVne8N4nzR4EHJccm6KYChiizUf8M/wge7WtJFHI4GonrYFH2V8CtSi
	 8+0tQRPjUZm4y4weh9CFnZzhRNwvWfydRfVVe5sFBFpbG6FXsChpG2gq1dPZQ7ToKo
	 8X6roh7xYwitpVRmEt/J8vagsGISyI4BbTsO9k9ZA9Gueb9fyvjD6TjHC4AAfcfFRy
	 SY7oF/I/UxzzRGYMGWJcI4tVukpTJolxp5wbb9dXevF8zIasG918MV0yK/I5L0IdCa
	 TuLgPCiCJayoiqmLaGE9ZVShPT0/ov5Xawh69G6ZWZfgQMdNoYvNbwV3J1VsFPdP35
	 YDelAALGVoNQw==
Message-ID: <sashiko-outbox-213712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] perf jevents: Store raw bytes in BigCString
 instead of C-escaped strings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-2-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:21:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf jevents: incompatible pmu_name redefinition breaks mypy
  build
--

commit cec20814c29173c92160614f78f6888af106102a
Author: Ian Rogers <irogers@google.com>

perf jevents: Store raw bytes in BigCString instead of C-escaped strings

This commit changes BigCString and _metricgroups to store raw NUL-delimited
UTF-8 bytes instead of C-escaped strings, escaping them into C string
literals only when emitting C source.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 080e04b51b8c5..0721c8b2551c3 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py

[ ... ]

> @@ -556,11 +550,12 @@ def print_pending_events() -> None:
>  static const struct pmu_table_entry {_pending_events_tblname}[] =3D {{
>  """)
>    for (pmu, tbl_pmu) in sorted(pmus):
> -    pmu_name =3D f"{pmu}\\000"
> +    pmu_name =3D (pmu + '\0').encode('utf-8')
> +    pmu_comment =3D bytes_to_c_literal(pmu_name).replace('*/', r'\*\/')
>      _args.output_file.write(f"""\t{{
>  \t\t.entries =3D {_pending_events_tblname}_{tbl_pmu},
>  \t\t.num_entries =3D ARRAY_SIZE({_pending_events_tblname}_{tbl_pmu}),
> -\t\t.pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
> +\t\t.pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_comment} */ }},
>  \t}},
>  """)
>    _args.output_file.write('};\n\n')
> @@ -612,11 +607,12 @@ def print_pending_metrics() -> None:
>  static const struct pmu_table_entry {_pending_metrics_tblname}[] =3D {{
>  """)
>    for (pmu, tbl_pmu) in sorted(pmus):
> -    pmu_name =3D f"{pmu}\\000"
> +    pmu_name =3D (pmu + '\0').encode('utf-8')
> +    pmu_comment =3D bytes_to_c_literal(pmu_name).replace('*/', r'\*\/')
>      _args.output_file.write(f"""\t{{
>  \t\t.entries =3D {_pending_metrics_tblname}_{tbl_pmu},
>  \t\t.num_entries =3D ARRAY_SIZE({_pending_metrics_tblname}_{tbl_pmu}),
> -\t\t.pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
> +\t\t.pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_comment} */ }},
>  \t}},
>  """)
>    _args.output_file.write('};\n\n')

[Severity: Medium]
Does reassigning bytes to pmu_name in print_pending_events() and
print_pending_metrics() break the default mypy build target?

Earlier in both functions, pmu_name is assigned a str value:

tools/perf/pmu-events/jevents.py:print_pending_events() {
    ...
      pmu_name =3D event.pmu.replace(',', '_')
    ...
}

Rebinding pmu_name to bytes and passing it to bytes_to_c_literal() and
_bcs.offsets[] causes mypy to fail with incompatible assignment, argument
type, and index type errors, breaking git bisect until the later commit
"perf jevents: Store PMU names as string literals in struct
pmu_table_entry" removes these assignments.  Using a separate variable name
such as pmu_name_bytes (like mgroup_bytes in preprocess_one_file()) avoids
the type conflict.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D1
