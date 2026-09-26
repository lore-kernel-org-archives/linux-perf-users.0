Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61D388866
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403995; cv=none; b=XPJAR9YVmndi8G+8nV0gRfbck8uoWkcLA+pwr4yZ3AOW8HYjtWPlHmrgFWxEjR+5a9tt19HE6w2BhBbO2zBtxYNR7LicFzFRnYZaEUniQHoe3071p6NGDVpAGDDy5UKtwc8Cm6Q1tdi2aALvcErDkO1qVwzHcFAWYrweokfvW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403995; c=relaxed/simple;
	bh=1A2aRKaeG1PbDPY6txkuvNUrxyftqcujj5TRzyH3MfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=djiBFKF5NLjPbjl8JSsKK8X2Edww48UEAN0zm6KFrD1I5JoOZgcCCfAO5zzzN688YC/tbmT5ZQyj6MkJqYIaSABOcQZ5GVqI+Zj1nt/KCR4siYd8qKg6b26fhczQXuc4vQx2p+ILQhYObSPqQ3nQmYYlN0INT8krsNdvecqqJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYnfuU9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYnfuU9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEE51F000FF;
	Sat, 26 Sep 2026 06:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790403994;
	bh=cpLddbQqg4UlXCyZaDcFjBDpS2Bl/gjQoiHUT/d6eGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CYnfuU9UvdOnrMODXwCP2eLQpD2LEL9Znx6MffSjETF22CAYSbNwEEJOPRElFBRnl
	 7z4q/iw8wJilmZKNx+R+LL07pFdwO34J9gIavFZ1bBF/slKlnx2MGivtvTqOIG/ID6
	 wbVxz6Yuul2it0+MY1RKDduZTVKE4P4unFuGFslmdjDFddIIKkZ5jGttD0ZacVF3/q
	 3XWjCOas84VBDZiI5GoL4Li/20XW4ReQzvOCIk9CRbIvS2zVVIhWuz1c+htuPPPHze
	 ZxBLaJv8bCsnrV38+DzaDJogBD2kD1U3nEbNPyD6pF+czWiYymXR2omfWHFnbzHnfO
	 WlMatPo2xb07g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/49] perf python: Improve perf script -l
 descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-8-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:26:33 +0000
Message-Id: <20260926062634.2FEE51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add module docstrings to counting.py, tracepoint.py, and twatch.py. This
> satisfies pylint's missing-module-docstring check and prepares these
> existing standalone scripts in tools/perf/python/ for the later commit
> in this series ("perf script: Support standalone scripts and remove
> embedded scripting"), which updates 'perf script -l' to scan
> tools/perf/python/ and display each script's module docstring:
>=20
> ```
> $ perf script -l
> List of available scripts:
> ...
>   counting
>     Example for counting perf events.
> ...
>   tracepoint
>     Example showing how to enable a tracepoint and access its fields.
>   twatch
>     Example to show how to enable a software event and track
>     context switches.
> ...
> ```
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D7

