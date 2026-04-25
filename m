Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33738CFED
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158561; cv=none; b=U33u6ZjFBYAJ4OmXI7N1fLqXNVdhBj5wsKlDebMHK9dcm7AwBl2T5SKD14ZDTPG2KbIAT2YyI4Bxe7AQ2A1a445G+n0b9POjapWjkPJ8ApX3AU6nKDG31C4f3uuSU6XMfur2nirZgSWoxe90DaketENSZT29O2sMcaCrxKbF0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158561; c=relaxed/simple;
	bh=Jfxphv2UkqyAtGQMQl25wujHls9GrbQcUcahZyMRjAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HTc8czBy38jIVzMSeM7nTPKdLzd6cFdWLMYJCKFffyzLFH4o9eH0p96tn6EJUmV0nsGWAYieyiJ/rehecSrAul6qaT3zjtJfGvaiA7hOuNsUjvYQayA/0ys+d3gkNS67nTcjOIqUfUofADKbDT3oCiqwDcodjsLZVFHH8jh+xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIuwXXNB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIuwXXNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D130C2BCB0;
	Sat, 25 Apr 2026 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158561;
	bh=Jfxphv2UkqyAtGQMQl25wujHls9GrbQcUcahZyMRjAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EIuwXXNB6LhGvRqEZR2J5XdFuUCmS01TMV9QDWG966ZZWrg/F5G7SqWzcbYYpuZ06
	 jKEyfuf6BHky3qPNNWK8uKRtSb5dm374Vxdcsm6nz6DnjG+ncl61GYzEwoSqnkPyy8
	 L0WAHLbyFwmcCcFMNT8B7M6mSO/qTMNbB9h22905hpKfaq0MCDX18zyg5Lz9ZbhSAn
	 1eri3kJAensONTVXY3co3Ir++iOFyfi//k8aYoaC9JeGbskPJzEzl6TEyLcM2CqY9C
	 eP6tKSBfL/QJFaIuTUtzBvXZ+pjySt4Pyp9EsU60pxBp97PrGz4llDptMUAifYONs+
	 PXz/uRnpUmjnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 30/59] perf flamegraph: Port flamegraph to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-31-irogers@google.com>
References: <20260425224951.174663-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:09:21 +0000
Message-Id: <20260425230921.7D130C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Fallback symbol resolution incorrectly assigns `None` to the node =
name instead of `"[unknown]"`, breaking the generated JSON.
- [Medium] Sequential template string replacements allow untrusted input to=
 corrupt the generated HTML file.
- [Medium] Path evaluation mismatch causes unintended network access instea=
d of reading local files.
- [Medium] Interactive `input()` prompt is written to standard output, corr=
upting the generated flame graph when stdout is redirected.
--

commit f4e070e566d630118a5c68aeacf90a2bc934cc23
Author: Ian Rogers <irogers@google.com>

perf flamegraph: Port flamegraph to use python module

Add a port of the flamegraph script that uses the perf python module
directly. This approach improves performance by avoiding intermediate
dictionaries for event fields.

> diff --git a/tools/perf/python/flamegraph.py b/tools/perf/python/flamegra=
ph.py
> new file mode 100755
> index 000000000000..b0eb5844b772
> --- /dev/null
> +++ b/tools/perf/python/flamegraph.py

[ ... ]

> +        else:
> +            # Fallback if no callchain
> +            name =3D getattr(sample, "symbol", "[unknown]")

If sample.symbol exists but evaluates to None (for example, if the symbol is
unresolved), Python's getattr() will return None rather than falling back to
"[unknown]".

Will this cause the node name to be serialized as {"n": null} in the output
JSON and break the d3-flame-graph rendering?

> +            libtype =3D self.get_libtype_from_dso(getattr(sample, "dso",=
 "[unknown]"))
> +            node =3D self.find_or_create_node(node, name, libtype)

[ ... ]

> +            use_minimal =3D False
> +            try:
> +                if not template:
> +                    use_minimal =3D True
> +                elif template.startswith("http"):
> +                    with urllib.request.urlopen(template) as url_templat=
e:

If a local file happens to be named in the format of a URL (e.g.,
"http://example.com"), os.path.isfile() checked earlier will return true, b=
ut
this block will still pass it to urllib.request.urlopen().

Could this cause unintended external network connections instead of reading=
 the
intended local file?

> +                        output_str =3D "".join([l.decode("utf-8") for l =
in url_template.readlines()])
> +                else:
> +                    with open(template, "r", encoding=3D"utf-8") as f:
> +                        output_str =3D f.read()

[ ... ]

> +            elif template_md5sum:
> +                assert output_str is not None
> +                download_md5sum =3D hashlib.md5(output_str.encode("utf-8=
")).hexdigest()
> +                if download_md5sum !=3D template_md5sum:
> +                    s =3D None
> +                    while s not in ["y", "n"]:
> +                        s =3D input(f"""Unexpected template md5sum.
> +{download_md5sum} !=3D {template_md5sum}, for:
> +{template}
> +continue?[yn] """).lower()

If the script is invoked with standard output redirected (for example,
"flamegraph.py -o - > output.html"), will this input() prompt be written
directly into the HTML payload and corrupt the output?

Additionally, would the script appear to hang since the user won't see the
prompt on standard error?

> +                    if s =3D=3D "n":
> +                        sys.exit(1)
> +
> +            assert output_str is not None
> +            output_str =3D output_str.replace("/** @options_json **/", o=
ptions_json)
> +            output_str =3D output_str.replace("/** @flamegraph_json **/"=
, stacks_json)

If the untrusted perf.data file header contains the string
"/** @flamegraph_json **/", it will be injected into options_json during the
first replacement.

The second replacement will then substitute stacks_json inside the newly
injected placeholder within the options string literal.

Could this result in malformed JavaScript and cause a SyntaxError in the
generated HTML?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D30
