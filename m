Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773E217F27
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897071; cv=none; b=S3bevAVS0CQE/LtqNMZGsqtsrIh9H6JjiC4qWphOv42cL3J6cCdCp3ZkjLTXJP//rPg1HPWRI4JLC4qVj+8tbjPX/pD8u2mz9nMBsT7JldAfZQgKWCbaDoVLjxy2dWz9NP86rL9nXfclerdnYIZFgWzZGyryVPHwDz/DumA2Mu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897071; c=relaxed/simple;
	bh=fJw9pCo77lKC0NdVF8cUo7RPug6kkE4rHMIEfImfyKg=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=m6xTdWG8zWG4HzneRwK/3BHZFp5M3UkzhhoIHy39I9yRxyqDh3BEpBku/n+EoXs90VqdTb+ebqJwzykR3CERVsvKGPXo01R9uzdyRBuZRbdMu5CCGulFEWWHgdg3nr1W6IZye81FsEJsNd/ZmyT53mpcBGGVPUcqdS0LajpvAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gePKYdQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gePKYdQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9631F000FF;
	Tue, 13 Oct 2026 13:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897069;
	bh=3NMKRPr3cwb4+AaNwirKqYh/oOwYl+JzkqrnZLuauH4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gePKYdQpD9HQfgyNHijcPZkvio6iCCUXlaXi/XvIFNIsnTxl/4ZhHgN16Fs8p5rGQ
	 Z8PEsOJ6cM48MOCIxXpfCYcWACjY1z2qtw0zADvg+GXrxCqldjxZRv7CV2GwCMJ/TB
	 /crNfmwMyOH4nWcRlZ17G7hB/mw594rIYtEpAuTXhDnH2n4ryRalC1jDJDne5NPyQT
	 6zhEu5qfVnuILRvun9Q4cwUBTIBsG1cyqgXh8ooHUBni8XAv0GDtdwXCdPp1uXCXOD
	 EpYdAdTS6bbAqZvG2DdL8ZuNAPWWWTMRVGbiuh5hGDRB0lDlh4A3yLFRlRA3FIANw1
	 AekzurJL4Ad+Q==
Message-ID: <sashiko-outbox-169780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: skip unnecessary userspace map synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Max Kellermann" <max.kellermann@ionos.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261013130052.3012773-1-max.kellermann@ionos.com>
References: <20261013130052.3012773-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:11:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Reading `/proc/PID/task/PID/maps` for existing processes is expensive
> on systems with many processes.  `perf record` already allows skipping
> these reads with the `--synth=3D` option, but `perf top` has no
> equivalent option.
>=20
> Skip userspace map synthesis by default in `record` and `top` when all
> events exclude userspace and no sample feature needs user mappings.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130052.3012=
773-1-max.kellermann@ionos.com?part=3D1

