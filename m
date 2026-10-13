Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D822519DE1
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923056; cv=none; b=TyIztu2wVH4deGRpomUYcfuueljqg7rroPaHXSGh7T7QTeT8I6uNO6KIeTsPiw1rS0f9Mai6zIbStVZ25KXy6WoIadH9BF4YRSqxL4iIZ4kuTFrEzZ+4ol5pMkUWqluQVlKQ7+sx636HQrMO9IyLVVgvMoX01j121uOqfTog0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923056; c=relaxed/simple;
	bh=iEGSUFX+PGi47WsbiOc98YvP3Dq3r0JeYkw4ZjT59Bs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Q62rrw9lSSg3poMaxR1tlYFwJKKIu9YC06UlNysmeWoko219eHRBtOjV/09F0uYGTRy7q6XbjGLH+LWyfAnSJPMNvZD+FjYkHEELR+6LwP1f+/R9fcHoLoS5rP2rg3RbiCXks8xEn3tW4bYX6LdQdH3JlL5sDj+3NBOZVrOcWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmZVDno/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmZVDno/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6831F000FF;
	Tue, 13 Oct 2026 20:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923054;
	bh=Ndu4C+VRwh147A+FVdUnkjfY2PYF4p+gj2ebtY40a/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmZVDno/otfy403wNA2FK9UWeO4TbkB+wcEQT+Fp6ADRvjgjO+OKZwPEUuGhAIef/
	 +OICB46HdRmPbnBv6I+eBbOcof8hj9eoXda+A8j0SsEHQuUPCAADOa3HYAX5Lm27Em
	 Z/BaEIA/6qxF2ZuqIv4xQ/+TqWLkN/6AUDNGcV3jo8Rnku62QDrM0wwNEH5/D0Sdy4
	 ZbWZq3QC0FGTOPDusXyX+2FzNxBdWrMlhBuJopx0n07bhQHZN4jMKTLDIVP044CweF
	 2kwFuCiD+oPcN+JvDh2HSnyPCKUC86PG6qxgwHsyqaoDnFeyURSK2e4BFd9gBQmyYP
	 kZz1t+zjK14uA==
Message-ID: <sashiko-outbox-170455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/19] perf test attr: Accept either sample id bit
 perf asks for
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-11-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:24:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> evlist__config() asks for a way to tell the samples apart,
> PERF_SAMPLE_IDENTIFIER where available, PERF_SAMPLE_ID otherwise:
>=20
>   bool sample_id =3D opts->sample_id;
>   ...
>   if (opts->full_auxtrace || opts->sample_identifier) {
>         ...
>         use_sample_identifier =3D perf_can_sample_identifier();
>         sample_id =3D true;
>   } else if (evlist__nr_entries(evlist) > 1) {
>         ...
>         use_sample_identifier =3D perf_can_sample_identifier();
>         sample_id =3D true;
> [ ... ]
> of which side is the one perf recorded to take the bits out of the right
> side.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D10

