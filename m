Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A881FC0
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783318; cv=none; b=VPPSUXTy7hLqfLCKpLQEvRJNk6kDWt+BOKVnpOzkS3+5y8Miix87RC58BFBXB/OCMCrNMyt2IlULg8T0/0Xbyt27P+LBgbju9DVanrOCqlj2gxVsrYGrhi4lH++2sZNFCoAGfkgUn5CUtok+uhWjEUieThHsELnsVryrlw+GMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783318; c=relaxed/simple;
	bh=httQejLgpAzMwZN73ObDq2lnPS5hc2VYffmHEakJO9A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lgO91sy3sb6LihC062dBCLHwDVJP8nCVAhs0Al5VwUwQ+X2RCDaPNv0YdPKxaPZ9xJ1HiM2MZsaXIk5Xk/9SKMbJ3FNef/T49XlTiPbm9/qZdBmUNqq/gwoSmo4EsSYJh0l+w5BVT54FT9DSvlP3WVJG1izYz4tOAiebQdUCLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGcmjIN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGcmjIN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342261F0089B;
	Mon, 12 Oct 2026 05:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783317;
	bh=httQejLgpAzMwZN73ObDq2lnPS5hc2VYffmHEakJO9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGcmjIN9iQWIzZXoyjfkCnMMjZpttMs75jm3sDn6wsZY+CIvxJrYby9k5d54yJkCi
	 lwZtQUinE8nCpdsH6iwjtaP4IhVnhQbMziNdbfxgzGdIwLVaGoQU4QP7Uk/Cm3ksAN
	 oigx9PFgRAJeBbM4017BIq6B7lE4GQH1XahJuAnmPWWddJmmwtpZLMjevtI3dYo4LV
	 bXN5quqJ6gwQCyZPyCegaKIUqn6GzsEvPZeU4lSXuVj2bHRePG4r4ASQzwDJIEmlCz
	 P7cMywWgN7rvZBDJmDTFulFMpa6rQu8p7hAdmGnZN/VcUEhBAGH8OYP4JYpCnFQLtp
	 JX8AG0cGkukXg==
Message-ID: <sashiko-outbox-167674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] perf tools: Try linked debug files for DSO
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-3-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:35:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The dso__find_dbginfo_type() should try DSO_BINARY_TYPE__DEBUGLINK so it
> can follow the .gnu_debuglink and find the debug information in the
> separate file.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D2

