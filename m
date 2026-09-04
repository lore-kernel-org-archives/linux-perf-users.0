Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD74963CB
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547777; cv=none; b=LaUEHj3uizTWjynciB3CzUR3PblkoxmMxFVEHigbSHAhoG3VBfznrbWA3l0vRTxrCBM7jJ1I7nIxbGAeiozbmU5b571rRI9c79U8fmVFRGfR7pYiNrRUicjDKRQa/IrSUAt1xgV4Axlqb2SUCCnxHqCpA3D5Nr+P6mm/UlnS1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547777; c=relaxed/simple;
	bh=KXs2CaBY2B1mYaw/in8v+a9KDumeRR4LuPjqDKBAkL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MhQe94eKh03o8qhyT0M9hfp0MItEpm6vy9+BgNNfZdqYJ9Q4EY/Ig++PnctruBHq7BD7xlDS2sXQ37B1U+ipvgyC+eDVvKzUhfPVEFaLZfLgyBWLO+I7y1kHXmspvDiu4fneejOn4kgo4/BIIo94fwU82vE/voen4s4WmbpjDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwNCACg2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwNCACg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E431F00A3D;
	Fri,  4 Sep 2026 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547775;
	bh=876jfUwnA63N/oO252eGbmnGa6sCQay8TMKrBJD51rM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VwNCACg2nkQnmrYrkBD6qBVGm3b+EemdJggDOHBfmCTlGhusiXAaT2nL1++pVDY9x
	 F+IWyin/06yfL996snFrEBglaqFVPNumGAkaLV2IncPYTli3EF5K+2k1S+yoO8sTo9
	 ULHX1nsde9GcJ6K+Lj3T24hPxamkrwLKzJRHo1ld7wANtVbPzvwfH506tY9xeRag4c
	 UDXtXYm0hbgvhudMPq7YfihTpSiHcFnaaT1LQ0pLG0vxjCwU2b+hgUhgyYpuPXB2xP
	 D7O7oA2O3xL0g0poi60iyOSR17YgfAoUTxSpXkn10RpI593cIGHRC7LoBJDr3qjWD9
	 QViG6I2YjclqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf: Fix null pointer access in
 is_include_guest_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:49:34 +0000
Message-Id: <20260904184935.75E431F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> A typical module unload occurring event when there is an active perf
> connection leads to freeing of the pmu pointer. The call log is something
> like:
>  ..
>  __pmu_detach_event
>  pmu_detach_event
>  pmu_detach_events
>  perf_pmu_unregister
>  ..
>=20
> __pmu_detach_event() sets event->pmu to null. When the perf connection
> finally is closed, the following stack trace is observed:
>=20
>  Oops: general protection fault, kernel NULL pointer dereference
>  ...
> [ ... ]
> Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPM=
Us")
> Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Assisted-by: Claude:Claude-Sonnet-5
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904181625.1394=
082-1-vinay.belgaumkar@intel.com?part=3D1

