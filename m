Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98D47DF9B
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188340; cv=none; b=su6lmP8Nnd9C44YQWCyoZAvCUoWSO5Ip463cINrZom8wb0/7uOBVqT2Bx+EHzWmgMTwdKN2ejgFzmKn6NrLzC+2s9WV2pytQz2B08dUs+z3dxJZ5HmslLK9/xk3PvRFiq42KHGjoMa4jEeIuMgdtDOtuGkRUYb/TLpg0GgARr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188340; c=relaxed/simple;
	bh=2kM2H1vErooTHUfOffX/J5U5L0xKwzFLknhBqIYxwpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LcdZdzR/G8nb0GTgpEBn90Pv0n3wDP1fohNBu5pEhlkr8Zpoh9frgGdxNAqLAIm5E1clAeGkMnihzbrwtvjQMs7oblxsDL8ovrBSXc08M4DRW6gKmoIfoJcRnM0jb8jYpiUx7o1XMQMKpFp/rfP5XFty7ZHP66J2RFNhmJM+43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmPKqWv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmPKqWv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E651F000FF;
	Wed, 23 Sep 2026 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188336;
	bh=9Ba1SZmxqxrphLvpGCZPA0+QsAmhTqzAZNcXuqOQ3FM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmPKqWv7iW/Ewp6iNOuAtKYnzMJKJvZ010c4OHCtyqVurBTKj2qPct6dw/qcOAM5f
	 QSN/bhtj+rhVF+6YcQDhdhjxpW6Pp5Wz5eH8K/QZI3B6JxksObeoMpKRvFnGJ+XhVa
	 /ufddy4RBg7Lt0OyLm1KA02OJnjvEAqqXm/7iBw1V9hoeTgewIpP5wXoN92AzKqdto
	 rIJty0M1T1++TesNhG800Vxs52rbOhXTm2BMSwddnxahp690JINC4m49V7de37ouPq
	 r3/LVDTF/iUTG68t9CxlUespcBYlQrMfN2EcM8vtZ0mLA2ScZ4OvSq7CdBEY92iGim
	 IgGqW1IMRX6gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/49] perf python: Port gecko to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-21-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:32:15 +0000
Message-Id: <20260923183215.D0E651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port gecko.py to a standalone script in tools/perf/python/ that uses
> the perf module directly to convert perf.data profiles into Firefox
> Gecko profile format.
>=20
> Improvements compared to the legacy script:
> - Encapsulate profiler state in GeckoCLI and CategoryData classes with
>   full type annotations, removing global variables.
> - Harden the local HTTP server in _write_and_launch(): write the
>   temporary profile to an isolated tempfile.TemporaryDirectory() with a
>   randomized UUID filename instead of the current working directory,
>   bind HTTPServer exclusively to 127.0.0.1 on an OS-assigned ephemeral
>   port (0), restrict CORS Access-Control-Allow-Origin to
>   'https://profiler.firefox.com' instead of '*', and restrict HTTP GET
>   requests exclusively to the randomized profile filename (returning
>   HTTP 403 for directory listings and any other path).
> - Add -i/--input and -e/--event CLI options via argparse.
>=20
> Add a shell test (test_gecko_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D20

