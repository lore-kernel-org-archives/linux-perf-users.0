Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039394;
	b=sECdFGskj3d0w0QIPiSyQjxEydszdNM2Owj1W9/mghMDVn0YfmuMgB0OeuqTz+c9HS7Z
	 dCeXDnbolXeDRKDNu4quKzCc0+YZ9hJKqWOO48Y4w9HQ6jyv5PTZxAhO+NJ3tl5hNYvt5
	 smheLH8r9hnsPZQ5+N/l99MVnIpPqjQYAv7fHO8HeMPfKRvXNzz+RJSjEUslpKlMfdGQo
	 LBIZ99jW5mo8g7x1lyxM3vTOhca9suVj10dh7o1MjWUlrlkYyfC71lm5HoIq1vLldm4hD
	 uQLkvZBeW2agtyeOkH+JF12WGLGhJAqNNhcECmZ9zwjCSAO2QIQ27zIGpZ/ZYo7WnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039394;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UAh2nMxTgcJUIrrgzUN+hZTQ7iiD5gVTsdmv8B5IWOU=;
	b=NOAK+l0jdHyUgs3QrcdSs9d9zrRq1U0n4hegVfm1w+2Bq8IbjgIB6m1sYMCFbr7DEYDO
	 FWT1l6lBR0TeRBd/PtdmK6+8mriSClwZ/o5r94jVfkVXz9hezyhJRswuuMhzuHhocDqTZ
	 BL+DEB2JNBuKMfSILxBQHAXtuy5ljGxkQdsFrGIRQFQf6r8BhviB+gqe+w+UwepNtplw5
	 B/PA0WhkO+hPZKNDbJAaPluM/dBo2sAyaiTPfxITKl/gzUrBSdXNpBYy6QvZHv60Ew4+t
	 dC5wvS/qEU8N7cg6P92f6D0nQexsElhmZzGRKUxgZ46RLd8cepNweqrcigppNL3QYSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCXbgJU7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53838606A332
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCXbgJU7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D507C1F000C4;
	Wed, 18 Nov 2026 22:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039394;
	bh=UAh2nMxTgcJUIrrgzUN+hZTQ7iiD5gVTsdmv8B5IWOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCXbgJU7+5ixDvhIya8jF9vsUYoe/yAKBkax7K9tS1ZScFWPaphQ1RpNjJm9vLhdi
	 W3DeTkHdAURrWq7w+mBjLAC3fAWQYBosK+5Qq9wI+aUenaxquDcBHdYO+OR0ic6wDY
	 QKXPJWkJEJbwwbj7lusT7k5o3XB6NU+OK6clAJjXgzm8Y88H5NDiSxFgbD0HG33SuF
	 XgDVQRGiyaarwwafuHAHbAs0vEYZdLJej6k4xW9Zk9zmWdmeREhkD1pdR6IZzqyt0D
	 BNri+BBNMvhl6ufPX8oBVlkcUm+Rn1HzAtwoevVAHwAp2EHJSIlyTjq3xUV1EFEodK
	 u2VPMd3PaoSCg==
Message-ID: <sashiko-outbox-222069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/13] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-12-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:03:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> On an Intel host the virtual LBR check failed with:
>=20
>   Warning: Processed 29 samples and lost 100.00%
>=20
> The record leaves the buffer sizes to the tool defaults: the data ring
> follows perf_event_mlock_kb, and the runner's small value left a single
> page, too small for the AUX samples.  Pin 4 data and 64 AUX pages, so
> the test does not depend on the host sysctl, and give the AUX ring room
> instead of the single page the tool sizes to the 4 KiB snapshot.  Both
> fit in the default mlock allowance regardless of the CPU count.
>=20
> Also require the Python perf module to export session: a perf module
> without it, like the distro's python3-perf, made the check fail instead
> of skipping.
>=20
> Fixes: 915d6b14dc0c8971 ("perf test: Migrate Intel PT virtual LBR test to=
 Python API")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D11

