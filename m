Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39451C327
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547140; cv=none; b=K3n3051zp853Z4dTScKe6WMb9uK2iyeZQTT90UpmybpTzGItNuicIeHLApJJUG1/w6NawOTA8tLT0UtA1DiAiDqpcmtMiVoS361G5mZY6Lwk5lMJvjEw0H94twnEcy2EC6ZHewMtceFxDUwb5Zoh3MmTcgFMgAabibJtx/dxq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547140; c=relaxed/simple;
	bh=HFgwg3Ci9tqk1JfklyeazNiaBrmHWzdOd84vg1iLfK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TCm2U3z34OcfyYOr4XEdny1rCH0ASGpeSW4tSRgY8XId8AapA3r1ymkpjfqg1oI1WEhnMX4V/O9P5nZ2OElmDl58swPqWsQo2OLq9UOaLG25221vkyHEsEZsasmyG6m+pkBNZyzMfHQcDlGcP1ku7QeO/kzF3ypEAP7/LpyXLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ7xT2wW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ7xT2wW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68D61F00A3D;
	Fri,  4 Sep 2026 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547138;
	bh=HFgwg3Ci9tqk1JfklyeazNiaBrmHWzdOd84vg1iLfK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZ7xT2wWA06PfKtaitTKJKLHC4/kFBvUysGfk+z2BVB9oxjEaorJ3hPAyo04qIV+z
	 /9GQZSeN8VYkoHo2T6zQPf0KwQB+UX172suLHkuci5ogB7CWYaOdBFb37PESZBybjO
	 D8RNrYgiQkSsGBBLFQlltXaqT+u3hBR+hHyKu4TAi+OxL/AhHv7ZUR5fpaYpbQRcyk
	 bAm5MHZ+Y32bJl78w33f0IAc3dZBkqRf2tvEOndcewcMOp0PwLK+Dzw385TymndGse
	 ynPtFOVJwqIk8SgTW0tVvEdOLaovzT7VxLza0Lxrhr/YFl3tEDbSJExtR6an90+aRH
	 ljpsRnZw3DAuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf: Add checks to prevent null ptr access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
 <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:38:58 +0000
Message-Id: <20260904183858.A68D61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko recommended some additional checks to prevent null pointer
> access. Check for revoked states inside perf_event_read_local(), as
> the pmu event may have already been freed at this point. Add a null
> check inside __perf_event_read_cpu() as well before accessing the pmu
> ptr.
>=20
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904181625.1394=
082-1-vinay.belgaumkar@intel.com?part=3D2

