Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55152E62A4
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917669; cv=none; b=qLvg0F//hRpdBj36m/esV2BLKbjFLs0V14kVovYYSdsrSc7adFt5CCVPGKEdytXZkIBfIIVlm2zB1vE04QdPXOmGxe+AjoZAdKXBBQR8HAH0BTa4RigoLNpdYo0b7tozPLf29n80HT4ZQJMcve5/ZqtRHLs5t+SSkDrAvEbPP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917669; c=relaxed/simple;
	bh=FsqhBHw3bL5srHVlKU4UgZJzRJ3NlHY/oZGK4GTtE+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hUhOBQTK9Kw1RFJ5t1iosEn7IkmlVGeGEnKsZcApGi+eldZdyaJH1DgxVdL+hTxHb32r+3rDp6qa355oGvgenQ9pENykRyRGLqLviY5N+uBBqSdv3mtd+kjtPwt5egZE+VdtmGnN+T0l5w7RlPI/6iDgAZ7ZjbKwcnfoMrZSL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqJXiZjp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqJXiZjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A279EC2BCB2;
	Thu, 23 Apr 2026 04:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917669;
	bh=FsqhBHw3bL5srHVlKU4UgZJzRJ3NlHY/oZGK4GTtE+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gqJXiZjpLGvqmyFIEy5WL2ftFBKKk4gw+2tbJp1mDWdUB9Wcc/FabHcpOsDuS0HCM
	 HEMGzHDglRFz6dMNzPE802atIm/Rzf7aSbQFTiLp3Ihc1EN/L/m9MrU73Yh24H0CFs
	 x4xNnVr+4uo5Y+NdzTZei4IEISB1MhaYStpjhu8BWGurDxFA8zgEbe3VRZ2eqxeEwl
	 JmoirE8wIzKPwsvM0bPs5HfPS5pXBDkASS76zwBLwFG8RbKW7kXylaO2wYohP+g6UH
	 jdRATQuRWzmADQPtcmSCuV9C9M72w7ae6hbFTIiyLwB0790qcWpAMoy7KTh9+ktBWg
	 iRwZhjZDEuiCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 30/58] perf flamegraph: Port flamegraph to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-31-irogers@google.com>
References: <20260423035526.1537178-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:14:29 +0000
Message-Id: <20260423041429.A279EC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] The `--event` filtering logic is completely broken because it comp=
ares the raw event name with the stringified `evsel` object, which are neve=
r equal.
- [High] The fallback logic for missing callchains incorrectly resolves the=
 missing `symbol` property to `None` instead of `"[unknown]"`, injecting `n=
ull` strings into the output JSON.
- [High] The type annotation `list[Dict]` causes a `TypeError` at module im=
port time on Python versions older than 3.9.
- [Medium] An MD5 mismatch on the downloaded template prints the entire HTM=
L file inside the user prompt, causing severe console flooding and a potent=
ial terminal injection vector.
- [Low] Local custom template files whose names start with 'http' will fail=
 to load, erroneously treating them as network URLs.
--

commit 6b91c1b1c1fbf8eb29a0d7bb8458776c8e77b1bb
Author: Ian Rogers <irogers@google.com>

perf flamegraph: Port flamegraph to use python module

Add a port of the flamegraph script that uses the perf python module
directly. This approach is significantly faster than using perf script
callbacks as it avoids creating intermediate dictionaries for all
event fields.

> diff --git a/tools/perf/python/flamegraph.py b/tools/perf/python/flamegra=
ph.py
> new file mode 100755
> index 0000000000000..f3f69e5a88c24
> --- /dev/null
> +++ b/tools/perf/python/flamegraph.py

[ ... ]

> +    def to_json(self) -> Dict[str, Union[str, int, list[Dict]]]:
> +        """Convert the node to a JSON-serializable dictionary."""

Can this type annotation cause issues on older Python versions? On Python
versions prior to 3.9, the built-in list is not subscriptable, which causes=
 a
TypeError at module import time.

[ ... ]

> +    def process_event(self, sample) -> None:
> +        """Process a single perf sample event."""
> +        if self.args.event_name and str(sample.evsel) !=3D self.args.eve=
nt_name:
> +            return

Is the event name comparison correct? Since str(sample.evsel) typically
formats as evsel(name) via the Python C extension, wouldn't comparing it
directly to the event name string (like cycles) always fail and discard
all samples?

[ ... ]

> +        callchain =3D sample.callchain
> +        if callchain:
> +            # We want to traverse from root to leaf.
> +            # perf callchain iterator gives leaf to root.
> +            # We collect them and reverse.
> +            frames =3D list(callchain)
> +            for entry in reversed(frames):
> +                name =3D entry.symbol or "[unknown]"
> +                libtype =3D self.get_libtype_from_dso(entry.dso)
> +                node =3D self.find_or_create_node(node, name, libtype)
> +        else:
> +            # Fallback if no callchain
> +            name =3D getattr(sample, "symbol", "[unknown]")

Does this correctly handle missing symbols?

If sample has a symbol attribute but its value is None (which
pyrf_sample_event__get_symbol returns for unresolved symbols), getattr will
return None rather than [unknown]. This would result in null in the JSON
output.

[ ... ]

> +            use_minimal =3D False
> +            try:
> +                if not template:
> +                    use_minimal =3D True
> +                elif template.startswith("http"):

This isn't a bug, but if a user provides a local file named something like
http-template.html, will it erroneously be treated as a network URL and fail
to load?

> +                    with urllib.request.urlopen(template) as url_templat=
e:
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
> +{output_str}
> +continue?[yn] """).lower()

If there's a checksum mismatch, this prints the entire downloaded HTML stri=
ng
inside the input prompt.

Does this flood the terminal with thousands of lines, making the prompt hard
to read? Also, could printing unverified network content directly expose the
terminal to ANSI escape sequence injection?

> +                    if s =3D=3D "n":
> +                        sys.exit(1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D30
