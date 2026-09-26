Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4E390226
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404505; cv=none; b=h5hHiyKO/hIbF1cGciXFlEYDRzqt4JX18OioFL4shT6LHZO/xiIfzGACbdYzb8l2RqFAcpfmu9g8NYlFWOTbEgYaoxGjYyOQWk8dwRvME/y/LmCyrxm0w9mv6OP6O88tEqwv4RE2cvuW49zCFxGq8z/SDPwMZwT8hd7uFoE3rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404505; c=relaxed/simple;
	bh=dSPj7R8PITUCz3H6aWXHKRNfBZxQx54SzUN7dR9So6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vln4HhXa7iin/YaZCjHhD9kLfCrgD57lKE1ssuM7bWTBjhsX39GgKSe1dhb6TC8JLSzdrHXpMhSYbFBfTZpopzwExOFgSDRVLhayQIO9p7WANJUOo8/f9L9u1QhPMJFKAiOlhXqihhLxMfLZ1hdzhGD8aR4bzRrUTduIgqniRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6XngSsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6XngSsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1F21F00893;
	Sat, 26 Sep 2026 06:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404503;
	bh=QxUDlqp/G+MrH0leBTv9baiGgckh8qKOaiZ06CRMkVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6XngSsDwvqXM8Hj1hoDpru0n5jqUsJ1TrWKwnybZvPYF6T0kzdTE2k6elWsFBgTj
	 fpKch2osUxU5dWLIq7Em2bR2pLYalvBY13y4g+q1GlWT/SARzD3YwzWYjPGji2yLC2
	 ia/Ayrmuww6bRpRXuXGz/Nh3DGs7zFLf7Dyedy4tGu5BfekfPfGnU2nSLGTWzM0/pC
	 5YYA7Fvd7EVUAIlavFBFADBdkOox46HUHmmlKAwgpI+ptiN1IhJ+/OWky5hj7ESFmz
	 ctn3ugLTrFSOvITunQ5a0JqkdFvYjwqw+E/lTeyE4teQmtZ02bLRKbeZTSyz1RxAYg
	 VsZXryvOKju/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 29/49] perf python: Port rwtop from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-30-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:35:02 +0000
Message-Id: <20260926063503.3B1F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rwtop.pl with a standalone Python script
> in tools/perf/python/rwtop.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Support both offline perf.data files (via perf.session) and live
>   recording (via LiveSession with --live), driving periodic interval
>   summaries from event timestamps rather than wall-clock SIGALRM timers
>   so both live and offline runs produce deterministic output.
> - Convert unsigned 32-bit and 64-bit error return values
>   (0xfffff000..0xffffffff and >=3D 0x8000000000000000) to negative errnos
>   so failed read/write syscalls are recorded in the error table rather
>   than inflating bytes_read / bytes_written.
> - Sanitize non-printable characters in /proc/<pid>/comm to prevent
>   terminal control sequence injection.
>=20
> Add a shell test
> (test_rwtop_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D29

