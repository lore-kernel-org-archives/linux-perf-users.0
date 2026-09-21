Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D12356771
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969111; cv=none; b=C6qAGRs94i9nxEOdLc3r8a4fGEovVWr4H1A+HxVigiJAIuOjEx+raV8GM8AOYO9Ev0tXVaGoyJNc590HJ0Oww/oX+e+h/NSKDgJizP94XlIsjarLEa9gpujG1a7jqDmdbY+LGD9jHsbU43aGcwrCcwM1Z6+PK/wzai+k23dyBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969111; c=relaxed/simple;
	bh=or8j3KrP9ZRu6FtuApEFjDeFoW9cdTH8pE/6dhwBRlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W0DTO11ze+OHHPartmrtpVlWsXgVTeFyRGHfvxGhmUmg22pPAARELGRIiwiZMBoTYEgd7AYguI1cuZkpHFFnMxCX6aT+631IPgsdJ42IC6Rx1oFzBADcMneYKhhW/o4b8xOxHv1aXC/ir4RIYN9c96WlatKIeYgUons1UG1okBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja8DS86k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja8DS86k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B14F1F000FF;
	Mon, 21 Sep 2026 05:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969110;
	bh=n0VZQkWUXb4DPFNz4x8TNPlqslX32WmmF6XM6FlsOPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ja8DS86kytZnFsCOK/OK3cWyeJVFeLhVsGtqwEr5Pqxn6eLwYLQ8FaGBFdCIluUAY
	 5wzoqX9lXV1UD84it6C+oBvCRKJSSeJad8PDn+MwWEa9hfj///mkllB6zoOJ5f3U0h
	 5MMtPdiyQkatGxUiRbKp/1ytj+U8/6Qw4IqgnLc/d6I3UIYKq301UGVX697yxXE06b
	 htRHSRt2kds241Y81N+ms0iAAEdKBLBDyh8nN3i8luIhK5UD3EN5SmvQxsDRUADr58
	 oOz9eh3leUC1xBEqUqK9RMEOomJRiJah3y+peBYGFasbAWeS4mVzHxsZclCeWEYAAD
	 L+lUcloVSshwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 28/49] perf python: Port rw-by-pid from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <edd0103cb3e315e6cba47113c0196ca569e3acf5.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <edd0103cb3e315e6cba47113c0196ca569e3acf5.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:38:30 +0000
Message-Id: <20260921053830.9B14F1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D28

