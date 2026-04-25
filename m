Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D9183CC3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158415; cv=none; b=c7CBkCbdCq2SJ447RwKrS7i+66pb9IpvhfeC46QuLRCdSFS8H/KqY4EAaX/U4GeANa9/tZCmYf8/ZcQj/hBBxQku8IGR55zSNCgIS9ZCM4tIwlYCytE/3jvV/eRNWdx5qUZMt7CS6jpHbhrXX46eK/tFh9V9dyO45TwPKLyU3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158415; c=relaxed/simple;
	bh=b6p5QyAuZuwKggwsYUuptBzd5nM1ZAysP+/audmHxmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BWVXXbeSagTx2Uj/x2Xee+yvL0t0X4gOEcGU0EZr2clKpl1fdhMvMAztU6zBw+1acMRaPadWhQrG70u3pqPd85Oilq6S7vrYyKvs43QoPCVrzZAyQ0K4zIXAzxFHWq5ghfRSgQtPRn064XBUq6EPk7EvcA5mY8UUOaC4aGKSegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWqJIUn8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWqJIUn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920E2C2BCB0;
	Sat, 25 Apr 2026 23:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158414;
	bh=b6p5QyAuZuwKggwsYUuptBzd5nM1ZAysP+/audmHxmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WWqJIUn8nXZ04mdRkDmiua578veY+0ismrCYU3T+P9nZgy0VmNeAhHk3nvYTC9Sc/
	 ZMTDeq8rWnEMkK9Wndhp2M1UCMD54HjrxOT2evFY6i1lVVNl6Kr54H6y0UZ2RW49tL
	 0lKwE6f3mzrfeZjfGIA2Do+w3KSqaIOZD6sQz+VbBFIsMSI673ZDa6xH2KhMQm5wLt
	 Pf6fW4ZAMGw2pFfvkf2VKV/LI7zRNf33xF6huZXCRjGGuCEw3ltwBN9AwMZ+XvFSYD
	 FuczX3T8r0H8ywX+YqwX/Vxk/W8DDTaWMTKDKVPJqFMqMW4dD7xSe5BVkiCctC+z8U
	 s4qnPTJR+Getw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 31/59] perf gecko: Port gecko to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-32-irogers@google.com>
References: <20260425224951.174663-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:06:54 +0000
Message-Id: <20260425230654.920E2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Unchecked return value from `self.session.process_events()` mask=
s processing errors.
- [Medium] Generated profiler URL is not printed, breaking usage on headles=
s environments.
- [Medium] Local HTTP server uses a predictable filename, allowing local in=
formation disclosure.
- [Low] Unreachable `except AttributeError:` block in `process_event`.
--

commit 280d1922588c70d042653eee3d46f2293162d4af
Author: Ian Rogers <irogers@google.com>

perf gecko: Port gecko to use python module

This commit ports the gecko script to use the perf Python module directly.
It replaces perf script callbacks with direct event processing to avoid
creating intermediate dictionaries and improve execution speed.

> diff --git a/tools/perf/python/gecko.py b/tools/perf/python/gecko.py
> new file mode 100755
> index 000000000000..01e9052f225e
> --- /dev/null
> +++ b/tools/perf/python/gecko.py

[ ... ]

> +    def process_event(self, sample) -> None:

[ ... ]

> +        else:
> +            # Fallback if no callchain is present
> +            try:
> +                # If the perf module exposes symbol/dso directly on samp=
le
> +                # when callchain is missing, we use them.
> +                symbol =3D getattr(sample, 'symbol', '[unknown]') or '[u=
nknown]'
> +                dso =3D getattr(sample, 'dso', '[unknown]') or '[unknown=
]'
> +                stack.append(f"{symbol} (in {dso})")
> +            except AttributeError:
> +                stack.append("[unknown] (in [unknown])")

Because getattr is called with a default value like '[unknown]', it returns
that default instead of raising an AttributeError when the attribute is
missing. Does this make the try/except construct unnecessary and the except
block unreachable code?

[ ... ]

> +    def run(self) -> None:
> +        """Run the conversion process."""
> +        input_file =3D self.args.input or "perf.data"
> +        if not os.path.exists(input_file):
> +            print(f"Error: {input_file} not found.", file=3Dsys.stderr)
> +            sys.exit(1)
> +
> +        try:
> +            self.session =3D perf.session(perf.data(input_file), sample=
=3Dself.process_event)
> +        except Exception as e:
> +            print(f"Error opening session: {e}", file=3Dsys.stderr)
> +            sys.exit(1)
> +
> +        self.session.process_events()

Is the return value of process_events() intentionally ignored?

If the underlying perf_session__process_events C function fails due to a
corrupted perf.data file or a parsing error, will this script silently
continue and generate an incomplete profile without notifying the user?

[ ... ]

> +    def _write_and_launch(self, profile: Dict) -> None:
> +        """Write the profile to a file and launch the Firefox profiler."=
""
> +        print("Starting Firefox Profiler on your default browser...")
> +
> +        with tempfile.TemporaryDirectory() as tmp_dir_name:
> +            filename =3D os.path.join(tmp_dir_name, 'gecko_profile.json')

Serving a predictable filename like gecko_profile.json on localhost could
allow another local user to quickly port scan and download the profile data,
which contains process names and memory trace data.

Could this use a randomly generated token in the filename to prevent local
data leaks?

> +
> +            with open(filename, 'w', encoding=3D'utf-8') as f:
> +                json.dump(profile, f, indent=3D2)

[ ... ]

> +            # Open the browser
> +            safe_string =3D urllib.parse.quote_plus(f'http://127.0.0.1:{=
port}/gecko_profile.json')
> +            url =3D f'https://profiler.firefox.com/from-url/{safe_string=
}'
> +            webbrowser.open(url)

In headless environments or remote SSH sessions, webbrowser.open(url) fails
and returns False.

Because this return value is ignored and the target url is never printed to
standard output, how can users on headless servers discover the dynamically
assigned port and correct url to access their profile?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D31
