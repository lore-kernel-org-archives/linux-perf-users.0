Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F936682A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140748; cv=none; b=VHm90GYjozwmVDBht8LpsPRJpEnQJ7Ks9dTwY0SHv3XdyJnzJ8ow78BzHA5BCntNBVr3mXb+c1AgJOLK0I7VRdEKGGPODnDqE5sZeuU279WzzzvPR2kaFyw3kaZD/3Pf8YjYRsHMxIle6t4iStXJhUhRirYJ3kII62VelrEoNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140748; c=relaxed/simple;
	bh=r50LlRjMqWovKV0rrbn5hOkN3CViZ05sxVzK/pv/gJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NOpBilMhaq0NT3sgAvRneRWBMsPul/rL2a5qZwUK/NxJ/f/hefnxATwV2CwrUHyKcyAcsnpFZ7PYKMRUt6RAGtimzoL/ye+wEeCw4bSY0vtWo8Jus9YcTGx08W+OCfLD3oW1wchr5cgYZttkOZkwFjReyOd3YTPP+zHjvIyXhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfGh0fnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfGh0fnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF72C2BCB0;
	Sat, 25 Apr 2026 18:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140747;
	bh=r50LlRjMqWovKV0rrbn5hOkN3CViZ05sxVzK/pv/gJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gfGh0fnZJ+Z5370XnXztvwvD7UvdovTuHtQ8ygNpQoTXNYQbWNomGD3h8Ud2UnsQE
	 cEeTp1SzniKtn04yATjA6T6OYys1QQxs7CkwNkxdEwnGkouI4CtyGpgaFPTyYPOmdz
	 uAGyAdw0wLJw276eX6yGYjFg6s7hFW0mJw/Pz6K27usU0qJ/DIBwrkxsfECA6rtnKT
	 Tk7jV+5yDUDQRtlbKavkx4WDnBrhyadZX8tb/iRfG0eh+9LczKNHPqLn6i8E3Ja0Lh
	 Kye/PW+iG8PSTnukhoPU0u12KxAtBTVQTzBtz3f8Z9kKLbtNkybUOQYw2OkBXm1KXN
	 lemI0RZnZGuOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 30/59] perf flamegraph: Port flamegraph to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-31-irogers@google.com>
References: <20260425174858.3922152-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:12:26 +0000
Message-Id: <20260425181227.7EF72C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Python 3.9+ typing syntax will cause a TypeError on older Python=
 versions.
- [Medium] Template injection vulnerability due to sequential string replac=
ements.
- [Medium] Fallback symbol name resolution evaluates to None, breaking the =
JavaScript UI.
- [Low] Missing space in minimal HTML fallback warning message.
--

commit 9130218bfb555360e9c6970e0bf2a82c681c5bc2
Author: Ian Rogers <irogers@google.com>

perf flamegraph: Port flamegraph to use python module

This commit adds a Python port of the flamegraph script that directly uses
the perf module. It avoids intermediate dictionaries to improve performance.

> diff --git a/tools/perf/python/flamegraph.py b/tools/perf/python/flamegra=
ph.py
> new file mode 100755
> index 000000000000..b0eb5844b772
> --- /dev/null
> +++ b/tools/perf/python/flamegraph.py
[ ... ]
> +class Node:
> +    """A node in the flame graph tree."""
> +    def __init__(self, name: str, libtype: str):
> +        self.name =3D name
> +        self.libtype =3D libtype
> +        self.value: int =3D 0
> +        self.children: dict[str, Node] =3D {}

Could this typing syntax introduce a regression on older Python versions?

In Python versions prior to 3.9 (like Python 3.8), built-in types like dict
are not subscriptable. Because there is no
"from __future__ import annotations" directive, these type hints are
evaluated at runtime during class definition, which might prevent the
script from running entirely.

> +
> +    def to_json(self) -> Dict[str, Union[str, int, list[Dict]]]:

Similarly, does using list[Dict] here cause a TypeError regression on older
Python versions?

[ ... ]
> +        else:
> +            # Fallback if no callchain
> +            name =3D getattr(sample, "symbol", "[unknown]")

Is there a regression here where getattr returns None instead of "[unknown]"
when the symbol is unresolved?

The symbol property on perf.sample_event (defined in
pyrf_sample_event__getset) returns Py_RETURN_NONE when a symbol cannot be
resolved. Since the property exists on the object, getattr() would
successfully return None.

This None value would be assigned to the Node and serialized by json.dumps
as "n": null. The d3-flame-graph JavaScript library strictly expects the no=
de
name to be a string and throws a TypeError when rendering, which would break
the flamegraph UI for unresolved symbols.

[ ... ]
> +            if use_minimal:
> +                print("Using internal minimal HTML that refers to d3's w=
eb site. JavaScript " +
> +                      "loaded this way from a local file may be blocked =
unless your " +
> +                      "browser has relaxed permissions. Run with '--allo=
w-download' to fetch" +
> +                      "the full D3 HTML template.", file=3Dsys.stderr)

This isn't a bug, but there's a missing space between "fetch" and "the" in
the warning message above, resulting in "fetchthe".

[ ... ]
> +            assert output_str is not None
> +            output_str =3D output_str.replace("/** @options_json **/", o=
ptions_json)
> +            output_str =3D output_str.replace("/** @flamegraph_json **/"=
, stacks_json)

Could this sequential replacement introduce a template injection regression?

The options_json string includes user-controlled fields, such as the --event
argument or the perf report header. If a user inputs the exact string
"/** @flamegraph_json **/" into these fields, the first replacement injects
this placeholder into the JavaScript options array literal.

The second replacement would then substitute stacks_json (which contains
unescaped double quotes) into this string literal, breaking the JavaScript
syntax and preventing the flamegraph UI from rendering.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D30
