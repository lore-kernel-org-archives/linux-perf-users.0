Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2A37A83F
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991216; cv=none; b=QkCfSoRoAi1PjugsDM8O6k8WmUG06WxQahh7fFEMWyX2U9DhcADYJuQR0wceYNQBFCqYAXImx8T4tDCHTYOdK1ibCQAyK5LfhOWDVnEZKloBjeCYSECahu1q9tY/ssBpEhs14EsklVWKimNTP08xdyQqbHNm7F34GWHkSL0jJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991216; c=relaxed/simple;
	bh=WM4yZIvJ6OCJ0pBnwsUGUxk2MufRn71/tK/p1Npl/Hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F92ItVAUvbOtxruvS3FeUj80sOR/cQfKkUZPnIX70rL5j5z2TqNOQobEhiSrsBPTHc5hLXF9NBPzcZdXP35BZyWShcQZtGF3NJk9R9TCnxfxcLanIB3ji3ApqsPWATR8aTG8gIGIFMMOsE93cnVEnlW7vCEm64Z8/oraHcqYom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBrAtthn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBrAtthn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6A71F00899;
	Sat,  3 Oct 2026 01:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991215;
	bh=Ou0FkaB4B/7X3rkByWQKyjkTcxAsXCmcSGuw8xbh9e4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBrAtthnWR3Ar6wklZX18QLpJ1+sdaX21/ZmHBS9DSeAYhdZALk7qkYK8exOY+DgU
	 XfVVvKxjiziYdD0yyLPqqgjnH+G5g3KzPiXmu+vSWUwc2Jow16VWCswQTEQ2USAVi/
	 O43X8xj3G3vUIUS33YWsxG7CtxOUj1wOaLP5z4QEDhne0Br/6wUMKNWIIIufcLHBwg
	 Tq3AXVXV7cWS9j0oQXAp9SpVWRsz7zOBoKQixtd2ifq8dq3VFv5pDphlPEr0D9TqE3
	 fLoQCYnfQUIlkLZ5YLip2Qo6H51g6lBACKF1ATeVl/e/3bOc00n/+I0+kV/q+LYMuM
	 loKEPKNYrh7yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/13] perf timechart: Add a --live mode to the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-13-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:35 +0000
Message-Id: <20261003013335.6C6A71F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: missing close for live mode pipe fd in ttimechart
--

commit dd0096e018bbc0f7d639c04dde6e4a581907e0c1
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf timechart: Add a --live mode to the TUI

Add a --live option to perf timechart and ttimechart.py that runs 'perf
record' writing CLOCK_MONOTONIC scheduler and power events, or I/O
syscall events when -I/--io-only is given, to a pipe and displays them
in the TUI as they happen.

> diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimecha=
rt.py
> index 34ecf84e68c1d..61176aca2cf6e 100755
> --- a/tools/perf/python/ttimechart.py
> +++ b/tools/perf/python/ttimechart.py
[ ... ]
> @@ -1727,52 +2110,329 @@ class TimechartApp(App):
[ ... ]
> +    def start(self) -> None:
[ ... ]
> +        self.data_fd =3D self.proc.stdout.fileno()
> +        self.grow_pipe(self.data_fd)
> +        if output:
> +            # Save the data as it is passed on to be processed.
> +            tee_r, tee_w =3D os.pipe()
> +            self.tee_thread =3D threading.Thread(target=3Dself.tee,
> +                                               args=3D(self.data_fd, tee=
_w, output),
> +                                               daemon=3DTrue)
> +            self.tee_thread.start()
> +            self.data_fd =3D tee_r
> +            self.grow_pipe(self.data_fd)

[Severity: Medium]
Does this code leak the file descriptor for the read end of the pipe?

When running in --live mode with an output file (-o), tee_r from os.pipe()
is assigned to self.data_fd. While self.data_fd is later passed to the C
extension (perf.data(fd=3D...)) where it is duplicated:

tools/perf/util/python.c:pyrf_data__init() {
	...
	fd =3D dup(fd);
	if (fd < 0) {
		PyErr_SetFromErrno(PyExc_OSError);
		return -1;
	}
	...
}

the original file descriptor is never closed in the Python code. This causes
the original tee_r (and potentially proc.stdout.fileno()) to remain open for
the lifetime of the TUI process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D12
