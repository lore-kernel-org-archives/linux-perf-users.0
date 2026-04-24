Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332B3E1D16
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051363; cv=none; b=gni3ENAbNOLSiaT+sDPQX3WCVQAYZCBPSLahQLh6E6d75dtGhy/uGa2mm/UEuDoaric73K/Q10kvtaJly6+V+SViHSnJGiniLNjK0pNGU2p6WZWxDUFh/tmcJcJi5CdW/vV0AtIHBNH1yvpvIEqsKQwu5YbBqana9o4OKqzOMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051363; c=relaxed/simple;
	bh=z1wcnK4sP6OI2f2g9PMynjIzO4rQdykV4MkF/HeP+8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m9IAFz88EUdlSKB2k76xSHWle7u4fetH369dct9r31AVnzPVyIxv/eIojd9JnAUe+X0sGqdezgNj2BijxaDFAAHKtEj57MDCiWwImDUCR2w7OctqytEfCbR1YmeaBIzbzhLHL421fXJ9UVVVcNaPsSpe6NntsncqpiF/V83otKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEgK/Nsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEgK/Nsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86306C19425;
	Fri, 24 Apr 2026 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051363;
	bh=z1wcnK4sP6OI2f2g9PMynjIzO4rQdykV4MkF/HeP+8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tEgK/Nsp1yYwFqfC6vs1H6JPY0A/m35MuBwQQJJrwvH9fbCjRbiS0EieOuzSi7OBd
	 OomkBHoVRQCed/GmTA4xL2Xr4FFqJCy7xvssH3j6dg4e8ES9FTOPQuMcfLeziz4FjB
	 rxDuyRV5wkMXTD4yAEmLnqXHRmm9ku+ThtqZObf38EgpLt89Qj/0yD6KoN3ZyS2gD4
	 BH0jHXGWHAmsTgsAvklWO+LX2XC5Xd/ICV117/S+IczISKFS9XhgJ1AIqpJh3aIUUL
	 YKwX9Jp0t/5Vh267+VLm9PYYxlwGZXH4EVxMlDjxLCHyNTTOwDHxTNBv2pHNzzE/4B
	 C3B+iLslKhwXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 30/58] perf flamegraph: Port flamegraph to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-31-irogers@google.com>
References: <20260424164721.2229025-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:22:42 +0000
Message-Id: <20260424172243.86306C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Event name filtering drops all events due to incorrect string comp=
arison.
- [High] Unresolved symbols evaluate to `None`, producing invalid JSON that=
 breaks the flamegraph renderer.
- [High] Printing unverified template content via `input()` enables termina=
l escape injection attacks and corrupts output streams.
--

commit d0a67ce7c1166e1b17cbdca7797edc5df205918e
Author: Ian Rogers <irogers@google.com>

perf flamegraph: Port flamegraph to use python module

This commit adds a port of the flamegraph script that uses the perf
python module directly. This approach improves performance by avoiding
intermediate dictionaries for event fields.

> diff --git a/tools/perf/python/flamegraph.py b/tools/perf/python/flamegra=
ph.py
> new file mode 100755
> index 00000000000000..f3f69e5a88c249
> --- /dev/null
> +++ b/tools/perf/python/flamegraph.py
[ ... ]
> +    def process_event(self, sample) -> None:
> +        """Process a single perf sample event."""
> +        if self.args.event_name and str(sample.evsel) !=3D self.args.eve=
nt_name:
> +            return

Does this comparison drop all filtered events? The Python extension's
implementation of str(evsel) returns a string formatted with parentheses,
such as "evsel(cycles)".

Comparing "evsel(cycles)" to the provided event name like "cycles" will
always evaluate to false, causing the script to silently drop events and
produce an empty flamegraph.

[ ... ]
> +        else:
> +            # Fallback if no callchain
> +            name =3D getattr(sample, "symbol", "[unknown]")
> +            libtype =3D self.get_libtype_from_dso(getattr(sample, "dso",=
 "[unknown]"))
> +            node =3D self.find_or_create_node(node, name, libtype)

Will getattr() return None here when a symbol cannot be resolved? The C Pyt=
hon
extension explicitly returns Py_RETURN_NONE for unresolved symbols.

Since the symbol attribute exists but evaluates to None without raising an
AttributeError, getattr() will return None instead of the "[unknown]" fallb=
ack.

This None value propagates to the node initialization and serializes as null
in the JSON output. The d3-flame-graph frontend expects the node name to be=
 a
string and throws a TypeError, breaking the UI.

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

Does printing output_str here enable terminal escape injection attacks? When
the downloaded template fails its integrity check, the unverified payload is
embedded directly into the prompt.

Because input() inherently writes its prompt string directly to the termina=
l,
any malicious ANSI escape sequences in a compromised payload will execute
before the user can even answer the prompt.

Additionally, if the user redirects output to stdout using "-o -", does this
write the interactive prompt directly into the output payload while hanging
the script indefinitely waiting for stdin?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D30
