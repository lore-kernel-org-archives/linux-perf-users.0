Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54049379ED2
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426451; cv=none; b=Wt4TJlUVoT0e0blulvTUkumjuHdxYiPf9iSJ31Lkm7vcbKuWT/ZLSS7P2gI7Z/NgJh57i7z83aH3/gyoRvFNCYx3dJBIvSx2ve8UF3lulqiWdjIJxGkQWxbOQ88lUJKbnmdKGICAb/WQn4AOjoaoiR9K1/vcdbIXzziUsjh8Lxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426451; c=relaxed/simple;
	bh=RXH5Unsvj1QZOdRxYa5dNIKJCVnWGVO+o0N4vsrqqtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AMMAMmvKIL/+SNYHI1qrsCukX8+AQeOiht8MBhGPKJ5FgSnCGuAQo+dgC/3tW6FMCgpOQiEqdc7stG1UbZGhx/PLJkbnqGOE2Y/aodeXFQzO4VqZgqlfUZHoAQRuP5WaM+5uJUdW0skDB52CVD6EuNe1SiT+XDM1lX3jI6R4cQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3g6Yoho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3g6Yoho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9541F000FF;
	Mon, 14 Sep 2026 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789426449;
	bh=hWLgA97UYi7sR2a6GCPBadij+FIpX2dkXgDOSwLiK8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3g6YohoFDDurMgo1ao9VnutSH+7pnHcoqe4D8Xr/jHe816AjTDh+YYZNFDNKtYcl
	 IGwdmBrXGlbm7AbLId6UeoRGFXKZ6qamYSBxIxhUJwvo4wdDAWPp+Uog7cok3G2OVp
	 slZAnaBhb6xZEO3NprCaG9F5VWPrhltqhJiz3ahPFHLCS7NWWiqUabcp6wTmgRZgaU
	 P/UOVpto/GSzN7Y2ZU3NIXuw8I2m/IAkD5Nhqoz8u9h0Kwdt/n/fIWebaJhtSOQiH6
	 eluQ1jBdMKlyHcEBDRXb0bc5O1VfOicjt7bCqV1m3/frVP0oACtPrXGHtp1vKOVE9H
	 r9PmSmXv3kXOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914224650.52982-7-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
 <20260914224650.52982-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:54:09 +0000
Message-Id: <20260914225409.BF9541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Print memory range data in perf-c2c subcommand. Only available in stdio
> mode currently. If memory ranges are not supported or present, print
> nothing.
>=20
> Example output of perf c2c report --stdio:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                   Memory Ranges
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id =
0, remote region id 255
> Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id =
0, remote region id 255
> Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id=
 1, remote region id 255
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914224650.5298=
2-1-thomas.falcon@intel.com?part=3D6

