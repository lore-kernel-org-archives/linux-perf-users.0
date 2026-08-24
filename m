Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7873546F2
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553628; cv=none; b=jyd2T1feHaKsP8OHlWjxa4EphDWWZw8ipoMZ/oE0FIxMVJN6JUYfqfO1ccEUrqNnVtnDVjNu8k1hg6/7u7MuY3J64Hd86VTyzRWVmTridokFTeaEnGKyYgJ8d9sNws1p6kz1OkYb20woPBawG5dUWaX4l3hlcUX04Ig0Q5flb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553628; c=relaxed/simple;
	bh=R0mBUmZ+oRy07lR0xs3GWAFi9Q+3LfRamdgnQ768PFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=siJ2oGGdaYA62zE6CNpehzTgcuhxoaeVDUwpekE72uy/HfFyzrw1HD77sBCFNmfzJ65EdrEix/n1SbpGI/o/IQ8Ssb7VJdcRhtYP0exbVthTbd10f+LPj7Had2UcMuVMMLCmS5vCYOJa1mBsYxbpeUshh2aoFXupiR124FwcDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyrhcym3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyrhcym3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AB01F000E9;
	Mon, 24 Aug 2026 06:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787553627;
	bh=R0mBUmZ+oRy07lR0xs3GWAFi9Q+3LfRamdgnQ768PFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyrhcym3aLytDKfaQgeI5ukYkIG/EvpTyEF2hqoMIX4lcgPjMplvK7W5BJkUKNZ47
	 CyZ1NgcVzf0JfrKOZxa8m+THkXymwpc7YO09hLheKb6lH6cHLwAfiIsaJi84nV/IYr
	 +LdWDsdzq+phoQXOW+ciPGQPTHaoOGeQeuLDM6QK5wW+M9lNYWS8vruyQOl84K5AvT
	 mOcBaShUCC12mkm0qb09SafhXtOHtyi5nlj5L+2OTMYa+qpdCMdvbMJXdGB5XNbIfq
	 JdTXAT/NkvMky2dTorKdxadJFlGOvDVBUgc/NJKeWD/Ev0+nBvKO4n6BOOVvQRolgz
	 zvMbCrEfPG/Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/7] perf Documentation: Add tip for hybrid event
 merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824063744.1533837-6-irogers@google.com>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:40:26 +0000
Message-Id: <20260824064027.48AB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add informative text outlining the IPC imbalances associated with
> merging cross-hybrid core events like cycles.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824063744.1533=
837-1-irogers@google.com?part=3D5

