Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FF1A704B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644839; cv=none; b=iZwdDAAiWDWNhlcRy0a40rb1u5G5OjNRnCnRQl0UXC2E5TrK8c9AySopTqjWjV6HCeTd2AmX8gChWBFOI36jFb15wEioOaO8xZQyus9I7Pe0chemhrxosnfZfCDbobQ5tCzE0vzG0NdzzmgIbD9eIFK0oRrhgSHqRRtYFV18/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644839; c=relaxed/simple;
	bh=sYen9QpCie9AuisOQEfNvlH1Y7e87GzxfwSqZuB1n5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nXGGFKkP2gg8LqWQxi6CvZVQoaM8ifjZyUVBZ4pSWTX5BPJALLMdysXCOoD8iU0MDyVzCsZl0yCdhkNiLZahz13NuWi+I2tUdO4JPMUpSgsjQSFCNX5rWznVJlU2aFLU6qplZQCbTJP7kzS/U+I4t34Y7rMTSEtg/ny4oSQptaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6//UR78; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6//UR78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA21C2BCAF;
	Mon, 20 Apr 2026 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644838;
	bh=sYen9QpCie9AuisOQEfNvlH1Y7e87GzxfwSqZuB1n5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=f6//UR782b6hMaGMhUO+5Nuu4kBJsyKFeFOAO5Y3UA/5CNJOcRJWJHZUwDEXQZdBk
	 sM8mXkubD+Csn8nHITu7dC/dn7Avw9yWd8/3AjeAxGWTneVg9zZ1fJ1kvqVQZ+Sfz7
	 wX7fzvBS7hnXLYDFlC/r2cBHExXzNqDD/wlJu4Cq0O301XKUBRM62RpR+CsupRyFRF
	 NK4q9L+MnGy+2zSgTt45DIpi1SsY70KtPjLFA0h4RFd3HCBSDEw3nk7mjQ21y6ooWD
	 IF4xeAx0ZhYR/YchQlLke0vfc4Xs7IGiyk2F1xgMP7w1ZiUy41wo3BouWGwK6XontG
	 KcEDh5HCq+61A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 30/58] perf flamegraph: Port flamegraph to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-31-irogers@google.com>
References: <20260419235911.2186050-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:27:18 +0000
Message-Id: <20260420002718.ACA21C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 9 potential issue(s):
- [Medium] Python 3.9+ type hinting syntax `list[Node]` and `list[Dict]` ra=
ises TypeError on older Python versions.
- [Medium] The `--allow-download` flag logic is broken and inadvertently pr=
events downloading the template.
- [Medium] Faulty handling of custom HTTP URLs passed to `--template`.
- [Medium] Informational minimal HTML fallback message is printed to stdout=
, corrupting data streams.
- [Medium] Unsanitized JSON data injected into HTML `<script>` tag allows L=
ocal HTML Injection / XSS.
- [Medium] Missing fallback logic for samples without callchains.
- [Medium] Terminal escape sequence injection during MD5 checksum failure p=
rompt.
- [Medium] Algorithmic complexity bottleneck in `find_or_create_node` cause=
s O(N^2) performance degradation.
- [Low] Weak cryptographic hash algorithm (MD5) used for template integrity=
 verification.
--

commit fddc7fd3e79b699ace56746bc19782f556d9736d
Author: Ian Rogers <irogers@google.com>

perf flamegraph: Port flamegraph to use python module

Add a port of the flamegraph script that uses the perf python module
directly. This approach is significantly faster than using perf script
callbacks as it avoids creating intermediate dictionaries for all
event fields.

> diff --git a/tools/perf/python/flamegraph.py b/tools/perf/python/flamegra=
ph.py
> new file mode 100755
> index 0000000000000..090e07a0992d5
> --- /dev/null
> +++ b/tools/perf/python/flamegraph.py
[ ... ]
> +class Node:
> +    """A node in the flame graph tree."""
> +    def __init__(self, name: str, libtype: str):
> +        self.name =3D name
> +        self.libtype =3D libtype
> +        self.value: int =3D 0
> +        self.children: list[Node] =3D []

Will this script raise a TypeError on older Python versions? Using
list[Node] for type hinting relies on PEP 585, which requires Python 3.9+.
Could this use typing.List instead to maintain compatibility with older
environments?

> +
> +    def to_json(self) -> Dict[str, Union[str, int, list[Dict]]]:

Similarly, does using list[Dict] here cause compatibility issues on versions
prior to Python 3.9?

[ ... ]
> +    @staticmethod
> +    def find_or_create_node(node: Node, name: str, libtype: str) -> Node:
> +        """Find a child node with the given name or create a new one."""
> +        for child in node.children:
> +            if child.name =3D=3D name:
> +                return child
> +        child =3D Node(name, libtype)
> +        node.children.append(child)
> +        return child

Could this linear search loop cause severe performance degradation? For
exceptionally wide call graphs with many unique symbols at the same depth,
iterating over node.children for every frame could create an O(N^2)
bottleneck.

[ ... ]
> +    def process_event(self, sample) -> None:
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
> +        node.value +=3D 1

Does this skip adding sample details if the profile was recorded without
callchains?

If sample.callchain is empty, the script skips the frame processing loop
entirely and only increments the root process node, which might result in
flamegraphs that only display process names. Could it fall back to the
instruction pointer or symbol?

[ ... ]
> +    def run(self) -> None:
[ ... ]
> +            template =3D self.args.template
> +            template_md5sum =3D None
> +            output_str =3D None
> +            if not os.path.isfile(template):
> +                if not self.args.allow_download:
> +                    print(f"Warning: Flame Graph template '{template}' d=
oes not exist.",
> +                          file=3Dsys.stderr)
> +                    template =3D (
> +                        "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1=
.3/dist/templates/"
> +                        "d3-flamegraph-base.html"
> +                    )

Does this logic inadvertently prevent the template from downloading when
--allow-download is passed?

If self.args.allow_download is true, the script skips updating the
template variable to the CDN URL, keeping it as the non-existent local path.
This causes the subsequent open() to fail and fall back to minimal HTML.

Also, can this overwrite a custom HTTP URL provided via the --template
argument?

Since os.path.isfile() evaluates to false for HTTP URLs, providing
a custom URL without --allow-download causes the script to warn that the
template does not exist and silently overwrite the user's URL with the
default cdn.jsdelivr.net URL.

[ ... ]
> +            if use_minimal:
> +                print("Using internal minimal HTML that refers to d3's w=
eb site. JavaScript " +
> +                      "loaded this way from a local file is typically bl=
ocked unless your " +
> +                      "browser has relaxed permissions.")
> +                output_str =3D MINIMAL_HTML

Will this print statement corrupt the output stream if the user specifies
-o - to output the data to stdout? Writing informational warnings to standa=
rd
output instead of standard error might cause downstream tools or browsers to
fail when parsing the resulting HTML or JSON.

> +
> +            elif template_md5sum:
> +                download_md5sum =3D hashlib.md5(output_str.encode("utf-8=
")).hexdigest()

Is MD5 robust enough for template integrity verification? Since MD5 is
vulnerable to collision attacks, might it allow a maliciously modified
template to produce the expected hash?

> +                if download_md5sum !=3D template_md5sum:
> +                    s =3D None
> +                    while s not in ["y", "n"]:
> +                        s =3D input(f"""Unexpected template md5sum.
> +{download_md5sum} !=3D {template_md5sum}, for:
> +{output_str}
> +continue?[yn] """).lower()

Can printing the unverified output_str directly to the terminal inject
malicious ANSI escape sequences? If the downloaded template from an untrust=
ed
source fails the checksum, embedding the raw payload into the input() prompt
could manipulate the user's terminal emulator.

> +                    if s =3D=3D "n":
> +                        sys.exit(1)
> +
> +            output_str =3D output_str.replace("/** @options_json **/", o=
ptions_json)
> +            output_str =3D output_str.replace("/** @flamegraph_json **/"=
, stacks_json)

Does embedding the JSON directly into the HTML script block allow for
cross-site scripting or HTML injection?

Since json.dumps() does not escape HTML special characters like < or /,
could a maliciously crafted process or thread name prematurely terminate the
script block and execute arbitrary JavaScript?

> +            output_fn =3D self.args.output or "flamegraph.html"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D30
