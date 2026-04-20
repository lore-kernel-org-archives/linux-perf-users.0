Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBEF6BB5B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644409; cv=none; b=M08Nj84o9UsWmKPPdvhwHTq22uIXEgU5muk5IsrA7fPJKOxjSe+4JmcOGd/nPNMGF+j02sid2ACZcpR6mJOwj/w5Z1t7DB4fdpX/djDi3hKQ7onssa4EHWoAkn9HvicTJizkdUcv9Hoo5o3H7S7qnfwBMpTXfPpzPpLl8ktY2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644409; c=relaxed/simple;
	bh=Wr5ia+KfehPmuSGH8K4+iIzCsHKoxPlizXF8k9MsJn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RPceVIQj9NW4lfn2LvaVgbYs4ZUv3Cv+mJdDGCTLmSskeICv2iLYWPLt7sbwuihfH87Q3Ub3WJBDpj4uiF9Xabf0ZzTzhgOFVODG5BLNzvDKyFl8iLc0AMiRqM10kU6sbERg3GXLzQc5xQmGnvXPWNdKkFYuIlHy3JVfBeQTiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHIXrL6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHIXrL6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DD5C2BCAF;
	Mon, 20 Apr 2026 00:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644409;
	bh=Wr5ia+KfehPmuSGH8K4+iIzCsHKoxPlizXF8k9MsJn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fHIXrL6X4a3UHf4zrFhS7+xcR1YVJYUS3T70444wkwR9C6C3ZDoHrccTn9Cly8XHs
	 kcnWRZaJ3ywscTdRCjgUAh3/RKczhM4tXF5mIDQQCC122wtNq+mUX0634NJJ5yH7kW
	 rXtmmvh+ofBH60R9cOtD1RnGVeAF4hG+YHhPsgy6RfMQfjAvj0nJ/ccGcmgWaIuYK9
	 uCDc+Su5A8YM6gBRrkhgRvQ2hiHlrPMkHZeVxEeJ9hFqRC7wucrSNTsdzyB78Xm3SM
	 CYAQKjhlmPKgDNbqer05WsP6/9F1Fy7mhzvZkD7kDdziF/VBBojQKk6f/ZXuOls6N8
	 5V5Nrui1yLIyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 31/58] perf gecko: Port gecko to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-32-irogers@google.com>
References: <20260419235911.2186050-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:20:08 +0000
Message-Id: <20260420002009.52DD5C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] The HTTP server binds to all network interfaces, exposing the curr=
ent working directory to the local network.
- [Medium] Unresolved symbols are formatted as literal 'None' strings inste=
ad of the intended '[unknown]'.
- [Medium] The script uses a hardcoded port (8000) without handling 'Addres=
s already in use' errors, causing silent hangs.
- [Medium] Using `uname -op` crashes the script entirely on non-Linux platf=
orms (e.g., macOS).
- [Low] Race condition between HTTP server initialization and browser reque=
st.
--

commit dc4b7f657c6a2aa78c3372c06ef2745b8abfea67
Author: Ian Rogers <irogers@google.com>

perf gecko: Port gecko to use python module

This commit adds a port of the gecko script that uses the perf python
module directly. This approach is significantly faster than using perf
script callbacks as it avoids creating intermediate dictionaries.

> diff --git a/tools/perf/python/gecko.py b/tools/perf/python/gecko.py
> new file mode 100755
> index 0000000000000..5d55bcb8ac012
> --- /dev/null
> +++ b/tools/perf/python/gecko.py
[ ... ]
> class GeckoCLI:
>     """Command-line interface for converting perf data to Gecko format."""
>     def __init__(self, args):
>         self.args =3D args
>         self.tid_to_thread: Dict[int, Thread] =3D {}
>         self.start_time_ms: Optional[float] =3D None
>         self.session =3D None
>         self.product =3D subprocess.check_output(['uname', '-op']).decode=
().strip()

Can this crash on non-Linux platforms like macOS or BSD? The -o and -p
options are GNU coreutils extensions and might raise a
subprocess.CalledProcessError on systems where they are invalid.

[ ... ]
>         else:
>             # Fallback if no callchain is present
>             try:
>                 # If the perf module exposes symbol/dso directly on sample
>                 # when callchain is missing, we use them.
>                 symbol =3D getattr(sample, 'symbol', '[unknown]')
>                 dso =3D getattr(sample, 'dso', '[unknown]')
>                 stack.append(f"{symbol} (in {dso})")

If the C extension explicitly returns Python's None for unresolved symbols
rather than raising an AttributeError, will getattr successfully return None
here? This would cause the f-string to evaluate to the literal string
"None (in None)" rather than the intended [unknown] fallback.

[ ... ]
>     def _write_and_launch(self, profile: Dict, filename: str) -> None:
>         """Write the profile to a file and launch the Firefox profiler."""
>         print("Starting Firefox Profiler on your default browser...")
>         with open(filename, 'w', encoding=3D'utf-8') as f:
>             json.dump(profile, f, indent=3D2)
>=20
>         # Start HTTP server in a daemon thread
>         def start_server():
>             server_address =3D ('', 8000)

Does this configuration expose the current working directory to the entire
local network? By binding to an empty string, it listens on 0.0.0.0 (all
available interfaces) rather than restricting it securely to 127.0.0.1.

>             httpd =3D HTTPServer(server_address, CORSRequestHandler)

What happens if port 8000 is already in use by another process? It looks
like HTTPServer will raise an OSError, causing the daemon thread to crash
silently while leaving the main thread trapped in an infinite while True
loop.

>             httpd.serve_forever()
>=20
>         thread =3D threading.Thread(target=3Dstart_server, daemon=3DTrue)
>         thread.start()
>=20
>         # Open the browser
>         safe_string =3D urllib.parse.quote_plus(f'http://localhost:8000/{=
filename}')
>         url =3D f'https://profiler.firefox.com/from-url/{safe_string}'
>         webbrowser.open(url)

Is there a race condition here where the browser might attempt to fetch the
profile before the newly spawned server thread has actually bound to the
port and started listening?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D31
