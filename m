Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6050129C
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661354; cv=none; b=nPRbbv+UBzKf80LcUbpSK+JHl76EOvdFEGzxC9IFQlcCeDvwta+2ooBxcrQ5T2D8CC4Dv5wuasf1V639F7ETrKPxrl+qJhEZtPKZXGBrOCZmwSyha82PI1TXYMOBg5KOu2VexOtOxR1CYOSPdCdC2A1aQYWBlbiKLtssoQ1QyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661354; c=relaxed/simple;
	bh=/pi/23jD2bhiAz+WxDt5VZtOSId2o5FsnxBxLqv6Xcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0+NMs1Ifn7h5kTsZ9cHrbPhihA26IGIieDBwN3O8sAFiPfVvuVMHhVDu1DGOqmrVDYVczqLf/bSikYf37yE/Sn1WGrRhLtltNJeQgF/u81lJV4/0L6K9lg/HsInrMplCekdQlk25Fh7aFxJlY/p8ZkzqLEpA6iyVqoefxiGbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXgDIxfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXgDIxfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C831F00893;
	Thu, 17 Sep 2026 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661352;
	bh=GY65dehWfbQEOPneiETPT0OuH5myYXUPZljGY/tthoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXgDIxfn2lX01aZFzl1zLK81P9UwOdPB1ACUzZ9+wJWw4UK0aK/dBb9VupANGMrCk
	 3DMxD2TYhEikgDo8ytIiHa8eVAf6mwSC7R7SViHV0jPaxavUewEp4azeqhgbBWqgKW
	 kZSRq6qvTMvMTjdmOke4be5QkgNnRA19INtC1k/7q5D4p1syfSq7ypoIWNzS4Awz//
	 HzECAyRkLAmuU8sSDhhj+tCIR7ydFV/H+om8zCjNWlaHfMLiW4N2t/PdqHfxIx8bh+
	 7st5JB9WWB1tTPHFsBSzqJsWMzunDS+SIAmeHroJf5PPkX+Y/dn9Ddb/2ttPHA4lFq
	 5Z1RfqQ3pvtFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-16-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:09:12 +0000
Message-Id: <20260917160912.95C831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> IBS events with exclude_{user,kernel} bits, as used for per-thread
> recording when kernel samples are not allowed, are rejected by the
> kernel on hardware without the privilege filter, so per-thread 'perf mem
> record' fails on AMD:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
>=20
> Kernel v6.14 added swfilt, a software privilege filter exposed as the
> 'swfilt' format term, making those events usable per-thread:
>=20
>   $ perf record -e ibs_op/ldlat=3D0,swfilt=3D1/ -- true
>=20
> Give the ibs_op memory events a name variant with the swfilt term, used
> when the PMU exposes it, even when the record ends up without exclude
> bits: 'perf record' adds those bits itself when the first open fails,
> after the name was built, and that retry needs the term.  This makes the
> per-thread 'perf mem record' the data type profiling shell test does
> work on AMD kernels with swfilt, and the test's event regex is adjusted
> for the added term.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D15

