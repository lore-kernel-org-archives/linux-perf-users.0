Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6992941A
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786173185; cv=none; b=apjhblpPb9d4qpchodn7j4gJvLwtku3c6+utrVoI5EV2uLGt12ijVGJ5cuBkFYL4Pt6iBa572ceUj/Z5vB3/7st6OBqqn+7lUaOkaHXo6OHRL/ksiNYZWcL86GydFilXgc37aOd98juSy5eLJ3+qoQSEQMXQmHTwTd+wHsOQnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786173185; c=relaxed/simple;
	bh=WShhZOO6rBO403kqNc/EfiNvrkAhtdojjfEmKtjd1sU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oKjNBrxqsBn6f1UFnsOvqzu0ujjiCXwCYpasYgEnf36k+57gKbz+TPusQjSFLFHnJV8oRK4qaA3VGtarKwKP5woTA8UARYYbkcv6ztLLQfEinPYHLBvUAul7p35Al0W9y9vVrrIVyEvTk84eHTaw5eQhXZRgd+jTgRn15N9mDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+J8G2Nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+J8G2Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A489E1F000E9;
	Sat,  8 Aug 2026 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786173183;
	bh=zzKzhJCB5es9MsV0Ej3KdXyGf6zxA8clhAPiy12X2nI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+J8G2Nj0HuanY+QihaWVaxuglfSAOVmnkgKi5gk/jn3N009HelmX8uM9aUurUKzX
	 B+qoAtMkHwRVNEzF7kT5IRU7goAWna95ARuRVxqRVtNf09wCImdhlafPz2ztEp7c4j
	 rwkrTGo1jrOcLqAQeLhla8PU/CbZ79epkH4VTpARnY/LLgYTB7GtGNdlnBukaf29jl
	 C0e4gNLZyoxocXot8BSYDgVzpuZe2FMu2WHj/EMTUagsxN7gMIC6Z3XwggtB6H+nuq
	 BahnapDbysVZf8QGZek2xs4yTyGC1JHVlCA6pAHxTpv9EqBkCneBaSVTFkzvvhvspG
	 FxuqeExFfkYkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf python: New treport script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808065743.2328212-2-irogers@google.com>
References: <CAP-5=fU=z8kcY4zjezoxSwYf9vczYzHztiMSBvJxdwwBPVWv2Q@mail.gmail.com>
 <20260808065743.2328212-1-irogers@google.com>
 <20260808065743.2328212-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 07:13:03 +0000
Message-Id: <20260808071303.A489E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The script uses multiple undefined attributes and methods from the=
 `perf` Python module, guaranteeing an immediate crash.
- [Low] Unconditional import of the third-party `textual` package will caus=
e a raw `ModuleNotFoundError` stack trace if it is not installed.
- [Low] Extracting the event name via hardcoded string slicing on the strin=
g representation of an object is extremely brittle.
- [Low] The commit message demonstrates usage with a path that does not mat=
ch the actual location of the script.
--

--- Patch [1]: [PATCH v2 1/2] perf python: New treport script ---
commit c8886e7317972e7aa7d9b4370a2487dc827a9013
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf python: New treport script

This commit introduces a new textual-based application, treport.py, which
displays the results of perf sample processing in an interactive tree forma=
t.

> With perf script treport:
>=20
> $ perf record -e cycles:u -g perf test -w brstack
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.008 MB perf.data (57 samples) ]
> $ perf script tools/perf/scripts/python/treport.py

[Severity: Low]
This isn't a bug, but the commit message demonstrates usage with
tools/perf/scripts/python/treport.py, while the patch creates the file
at tools/perf/python/treport.py. Could this cause confusion for users
trying to copy and paste the command?

> diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
> new file mode 100755
> index 0000000000000..528a640e4d356
> --- /dev/null
> +++ b/tools/perf/python/treport.py
> @@ -0,0 +1,207 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: MIT
> +"""treport.py - perf report like tool written using textual."""
> +from typing import Dict, Optional
> +import argparse
> +import os
> +import sys
> +import perf
> +from textual.app import App, ComposeResult

[Severity: Low]
Would it be helpful to catch the ImportError for the textual module and pri=
nt
a user-friendly instruction to install it? Currently, users without this
third-party dependency installed will hit a raw ModuleNotFoundError stack
trace.

[ ... ]

> +class ProfileBuilder:
> +    """Constructs a profile tree from a stream of events."""
> +    def __init__(self):
> +        self.root =3D ProfileNode("root", parent=3DNone)
> +
> +    def process_event(self, sample) -> None:
> +        """Called by session.process_events to update the profile tree."=
""
> +        ev_name =3D str(sample.evsel)[6:-1]

[Severity: High]
Does the perf Python C extension currently expose the evsel attribute on
sample objects? It appears this might raise an AttributeError at runtime
since sample.evsel doesn't seem to be implemented in tools/perf/util/python=
.c.

[Severity: Low]
Also, is it safe to rely on hardcoded string slicing [6:-1] here? If the
string representation format of the event changes slightly, could this rigid
slicing fail to correctly isolate the event name?

> +        ev_root =3D self.root.find_or_create_node(ev_name)
> +        ev_root.process_event(sample)

[ ... ]

> +    input_file =3D args.input or "perf.data"
> +    if not os.path.exists(input_file):
> +        print(f"Error: {input_file} not found. (try 'perf record' first)=
", file=3Dsys.stderr)
> +        sys.exit(1)
> +
> +    profile =3D ProfileBuilder()
> +    try:
> +        session =3D perf.session(perf.data(input_file), sample=3Dprofile=
.process_event)

[Severity: High]
Are perf.session() and perf.data() supported in the current python API?
Looking at the existing perf python bindings, it doesn't appear these
methods are implemented. Will this unconditionally crash with an
AttributeError when executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808065743.2328=
212-1-irogers@google.com?part=3D1
