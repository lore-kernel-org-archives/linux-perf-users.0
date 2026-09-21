Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C153F5BE3
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005094; cv=none; b=WVEJG0x8g0h7ksmzxpR8EHlOikyBWls5Fyjjc5w8MkvVWb5bKQmsfJQ3/oQ8ektbSKnMd/ElIPfsVqU6UqiN2pALlO0nbHQGDNHdUmHF1Kb+cUa65TUOsO9W9qqZa+tlfWhySyy41UXVH29DFJFPvDEhfU06BLZPfsdjlTVrppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005094; c=relaxed/simple;
	bh=W0hXbwTOnCltm87ZwLv7HgPGIffvJHMLc6/tpgq3UQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CJ+mU5LG+2F49pgaLKc9M31nfswVtJfbKAmsnBDXv6YadpK2yUfcD/+ir0kxfuc5dxnIzVdceNa8+nKZr1TQG7/sWTvcJRjZaHsBCdM0x1rimzGeNrjKPAHDD5jPkKtsZO6whcgzKUohoLLXfJG9hzREZ5V84pFYtDl0cqlz3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH1CEHyw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH1CEHyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8BA1F000FF;
	Mon, 21 Sep 2026 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790005093;
	bh=W0hXbwTOnCltm87ZwLv7HgPGIffvJHMLc6/tpgq3UQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HH1CEHywQKA0ykaBKFesV37qQ+eFyC04yzFF5Y6OyEJmRFP8zYiUjMXFMG7IS9lH1
	 K81A1R/i1qs1SdB4smJSMczYNjsSg8RmVi3Djf0oGqvmYQlH/ZBEsrszaaAjyo4iFx
	 GYTQRTBzopuPBAlkuZOyER9fSqwnWyFUGJTjCVzDjZKihN+igHT3IZX3OxsJm+DHte
	 pYuBvLp2/M4zT+5S7Y9EICnDEBB8xCm6Y+HDO2KDVdGZECcZNhsFPEzuyt6mdqtrPj
	 cJob/k5Pm1XrPl+LMFaoWxCpxCWfIQqkwmxdUB3F7tPlQY+72qlMoilQIOrKyB649c
	 TIb/GHM4h7XAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/x86/amd/uncore: Free counter slot by index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Usama Arif" <usama.arif@linux.dev>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921153108.2713179-3-usama.arif@linux.dev>
References: <20260921153108.2713179-1-usama.arif@linux.dev>
 <20260921153108.2713179-3-usama.arif@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:38:12 +0000
Message-Id: <20260921153813.1B8BA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> amd_uncore_del() scans ctx->events[] from slot zero and attempts a
> compare-exchange until it finds the event.
>=20
> amd_uncore_add() records the slot it claimed in event->hw.idx. Perf
> calls ->del() only after a successful ->add(), and the driver never
> moves an installed event between slots. The index therefore remains
> valid until deletion.
>=20
> Use the recorded index directly and retain the compare-exchange
> ownership check. Warn if it fails, as that means the driver lost track
> of the slot.
>=20
> Deleting all events from a full PMU with N counters now requires N
> compare-exchanges instead of N * (N + 1) / 2.
>=20
> On a host running a production workload in the Meta fleet, amd_uncore_del=
()
> was called 56,575 times per second from mux rotation.
>=20
> Cc: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921153108.2713=
179-1-usama.arif@linux.dev?part=3D2

