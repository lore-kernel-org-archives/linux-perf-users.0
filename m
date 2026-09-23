Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866F4F7CC2
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188594; cv=none; b=aplA/uu3jwr5diJYogKdxCKwa983Mbn5pTqhj2DC4VkOG58/Q2UplfOuD+sIHXysIx9kql37zLZuBGwjHhlmBO9xJYQoGWuGLGBcm1aJnuSabfG2Ya8Ofr1TM70Axanz47epyjz9X3gKrqRbDPnILtH3OZ7+O34E8s+5efimrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188594; c=relaxed/simple;
	bh=Dl0Ey53sJS+lBzQqSgsUqiPcIWWOUDCtbOVa1ylmdp8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OkwvB33ucaBhQZL5Z2ufsFNzvzjm1qjffQofwS4oN4nicjuFTq8ADQ0gPX0BJnQvtRyTbf7Q+mQjjNljrKHWY/ZRhwpDAguV6L+vKj9h37wHivsT+unmrOc1s/0nwKm5wjHsr4LNh3VL+3uPsCW3UPwB4q66l3TheMyAFYjEd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxBH1zjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxBH1zjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8BD1F000FF;
	Wed, 23 Sep 2026 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188591;
	bh=5a810KZU/LRpD+H3QbX7R++nDt7uRX1pupI8YALUJ/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxBH1zjvnmviNrx0DmwNmo0wFCsmRyIZB6T1HLSEQ82FRMuFXVI/hq8kbZKlxHm1U
	 elLwmaSKvAFncJaoUszQJuE2cE7+NfnHNADCbptBIX72FtJA484BM386iixWF1B7H7
	 hWY9w7b572B41T0vIvFd49wtYaH+vI3GTT+NG7jJoAHiyeZwCmbuWpeDsNSnKcQw6H
	 DQEPYramA40qlVVcR+Rq5H4k3A+A0wB0GrggAqkyx3xShzsQa9TUxrLnn1yns4IaOJ
	 iHAUuUUz+S2X6Bzsz+nA8SriddsGgFahnDzrEfmQWCNOqyAUrNisPcMGmA0wueGTe0
	 F35v+LMoVJjag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 28/49] perf python: Port rw-by-pid from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-29-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:36:31 +0000
Message-Id: <20260923183631.AD8BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rw-by-pid.pl with a standalone Python
> script in tools/perf/python/rw-by-pid.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Convert unsigned 32-bit and 64-bit error return values
>   (0xfffff000..0xffffffff and >=3D 0x8000000000000000) to negative errnos
>   so failed read/write syscalls are recorded in the error table rather
>   than inflating bytes_read / bytes_written.
> - Add argparse CLI support (-i/--input) and full type annotations.
>=20
> Add a shell test
> (test_rw_by_pid_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D28

