Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB8342509
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051105; cv=none; b=EacKUzvQo1an6922ReOMod7xJ0F7dxivnhaFZHlLg0zB3/EoI2LQ2yeW99utLphTkscnfH7NnSYL/6KAFq/sILlcksSfXHT7MFp6GVCeUuGupvYkZu0FKMghdiH/1LBlTRpvem6ZCSelVc7kngZnQPqKMT15ByekEhr8hjbqmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051105; c=relaxed/simple;
	bh=arPzT2aYHZp9RaGKBUndLwXHx/iuCiDF9o/SR9Qn4jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nopSvL0fw0TxISr436mFP/2UyoZHluMmaLC0gNlt5vOuh3c9M91XlnLTubrIX5M08D8C4rmgavdZr4InJw5CL8+HcocG0DtQGThFKqn6h/l36cIIi0uQhaFTn4uOj5i3Aowb3Vo9mVxTmF+gR+w9iWVfAdiz/lL3TiUoC2fWOSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJbFCIn0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJbFCIn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B92C19425;
	Fri, 24 Apr 2026 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051105;
	bh=arPzT2aYHZp9RaGKBUndLwXHx/iuCiDF9o/SR9Qn4jQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CJbFCIn0XTAEEljn7mwtbnJjwi5MYnr8H745OrT6GkMOFYAmqrARtp54itKrAUbQt
	 kyH8FPqfGMbQ+r0/qjlFV3XylcP2WLzfDcnyscbeienZuCRj0NyFPnYcN9KHtCPwml
	 QzpoNKSYuaZ+V77z51C30VQBLkNhr4sMP6hcTxJ5AIBlA+gCruXvh6ylDzJwUBHISR
	 KLoTf+ek5rvjBGyUsnfFT5+eY0rInfrUFGanGSmiUhWfPlF5giXO/DwhmOQsQMvQFM
	 irYn5iGD0nmHXZ1Vdd53WHKPLtun++FgdQberjlwCTKArZ93F7ENrV5swvV6+CCrT/
	 5N4O7PP21o8xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 31/58] perf gecko: Port gecko to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-32-irogers@google.com>
References: <20260424164721.2229025-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:18:24 +0000
Message-Id: <20260424171825.07B92C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The local HTTP server exposes the entire current working directory=
 to all local users without authentication, creating an information disclos=
ure vulnerability.
--

commit b7680d27af3c4275fc4b69c75f01dad80db621ee
Author: Ian Rogers <irogers@google.com>

perf gecko: Port gecko to use python module

This commit ports the gecko script to use the perf python module directly.
This avoids creating intermediate dictionaries for all event fields, making
it significantly faster than using perf script callbacks.

> diff --git a/tools/perf/python/gecko.py b/tools/perf/python/gecko.py
> new file mode 100755
> index 00000000000000..cbcde6ec3c8b1d
> --- /dev/null
> +++ b/tools/perf/python/gecko.py

[ ... ]

> +class CORSRequestHandler(SimpleHTTPRequestHandler):
> +    """Enable CORS for requests from profiler.firefox.com."""
> +    def end_headers(self):
> +        self.send_header('Access-Control-Allow-Origin', 'https://profile=
r.firefox.com')
> +        super().end_headers()

Does this local HTTP server expose the entire current working directory to
all local users?

Since CORSRequestHandler inherits from SimpleHTTPRequestHandler, it appears
to serve all files and subdirectories of the current working directory by
default on the local network interface.

If the script is executed as root from a sensitive directory, could a local
unprivileged user on the same machine query the ephemeral port on 127.0.0.1
and download arbitrary files while the server runs?

Also, does the CORS header unconditionally allow https://profiler.firefox.c=
om
to read any files served from this directory?

[ ... ]

> +        # Create server in main thread to avoid race condition and find =
free port
> +        server_address =3D ('127.0.0.1', 0)
> +        try:
> +            httpd =3D HTTPServer(server_address, CORSRequestHandler)
> +        except OSError as e:
> +            print(f"Error starting HTTP server: {e}", file=3Dsys.stderr)
> +            sys.exit(1)
> +
> +        port =3D httpd.server_port
> +
> +        def start_server():
> +            httpd.serve_forever()
> +
> +        thread =3D threading.Thread(target=3Dstart_server, daemon=3DTrue)
> +        thread.start()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D31
