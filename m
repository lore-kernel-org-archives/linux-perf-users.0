Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52C41684B0;
	Sat,  3 Oct 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014408; cv=none; b=l1UhBh2mtvp+ylp462tImfzG+VYnTQ1FMEu48rEIoaYmzsGF41vhlPQKNYKmWNDJcIf8yBHMOA7YbAzhWFiue6TyUJgmB1K3mXpW8eW1mr2yL9x3Yt1Y0x3U8dOF5DWFZx/1tYuq9akceXIHi+1mEKb4fXT7acPJHlxfpYNbHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014408; c=relaxed/simple;
	bh=/dRXzTmntNxBzedj4yQUyIfSI2+Tw+u7SsNEin0q1iE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dgy2caat8rRmT30Xyi7RGsw49JNLefR93LcXzMPaWl2Y9XcIG2xT/q3Q2sydhmeYYUi5bJW5HEStCqqH7vdVDpqybV4mBclshqH7hcWTOCGH0ePU/r8nu3ygLuYLP3eEji2utVO4g0qRE+NKFEfaHNX1H3IcIsOaKnLOvLaSE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpG+BmLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpG+BmLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3A11F0089B;
	Sat,  3 Oct 2026 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014404;
	bh=/dRXzTmntNxBzedj4yQUyIfSI2+Tw+u7SsNEin0q1iE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YpG+BmLD0lCUb3DTM77tCmo7ohXQc3GSXm1kowaDVO+z/K/JrfsUF3JzMSUwBub8q
	 J2YEgcbO7yTnGQY1vQwohykq7U0+vg7rPrGHLx9zxzOHbA8PwK6s0qIHz6yutv/4iN
	 l0ZfU1f36NwbFL5aHd+2SYf9hGbAFRP33mGQ/fgwKWPXpB210vvIdUNeaVfyWn4LRj
	 k27oMuvWPysNidmdyzmt+CxHvM+lR8SUxLXglxgXGZrULgPOEbHtvcHEISlUSKPJkw
	 3HZzeM3j1oWRRirnAT4xKlkG18GZ2u5nlswJVg57L+xIMBH5NiTCdMBaK01u/GxQUg
	 FNSVUvOJPxaow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 05/11] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179101399190.22872.11292367896204285487.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101399190.22872.11292367896204285487.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:00:04 +0000
Message-Id: <20261003080004.AF3A11F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> on that architecture fires after the target memory has been modified.
> This is currently x86 only behavior.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D5

