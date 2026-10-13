Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D375437FB
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921729; cv=none; b=gaR0PxCdT5Z1cgyHXnga2ONQOFL1Zu5Q5krLwuVsEBtiPRn4XfdEfOKr/Xk7StdW4BXCYl9Boaib9Xf0GNacVh++zRHY+qDTAScuh4MP/3nUn4/pig4ecwAB477Qd1FnsnDXPcGk/WkIf5+1vv24ljpOLT/GAp93LycLt7+XaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921729; c=relaxed/simple;
	bh=ftFzQFHCbjrZNiPleOQP4MGOXX7BY30wZozFURSN4Eg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u/QdoB89UGSsbxh7sQDX9hiptgTxB1fLk5PZksaCNaN/bIxDui+WH92mhsAnlqmqVzlbO6DNOXDdD1jg3i0yeGlgFIIMsqdqcH0WePrmM2HJHonaRhxA6h21W0W/Q0f6mjofPEJYw5cSeh6wjNT4VSbCbgaZzv+ug7CUj08JkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMxGEOFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMxGEOFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3761F000FF;
	Tue, 13 Oct 2026 20:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791921728;
	bh=ftFzQFHCbjrZNiPleOQP4MGOXX7BY30wZozFURSN4Eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lMxGEOFMRCuA3OMiZkE8L+P1zFoTuGthrP05y+G3Px1XappMO9McOfyu5xoRlw17g
	 olpG0f8wRUbUiHyQbHGmTcHmFmksRHZM3T4TXR0DEGVeOS5s2fAetR0AwxLCSY7RCO
	 qAdkE5CRC24LyK4vTqa5yEbUGdjOdFIiJomxGhZhFnJhEBbCAE2d99N72nUzkh6Xoo
	 VJStWB1kPzjEBK/dSwdVKL/xwgw/Pd9Qxz6Yg7RIKYJfIvakyq0D3ysgswuRyNxYgE
	 rETvar8A+hlZGAGXKDzMOekLVDyMMH1EmSwsRUyLpOWVBq4+lnk1HLYnLqdtiw8sR+
	 rMJZDencRWOgg==
Message-ID: <sashiko-outbox-170434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Add Granite Rapids CMS PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013194005.96615-1-zide.chen@intel.com>
References: <20261013194005.96615-1-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:02:07 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add support for the CMS (Common Mesh Stop) uncore PMON unit, shared by
> GNR, SRF, GRR, and CWF. One CMS box exists per CHA box, at a fixed MSR
> address: 0x3400 + 0x10 * unit_no + <reg offset>.
>=20
> CMS is not enumerated in the discovery table, so it is added as an
> extra MSR uncore type instead of going through the normal gnr_uncores[]
> array. Since the CMS unit numbering matches the CHA unit numbering,
> build the CMS box rb-tree by mirroring the discovered CHA (die, id)
> pairs, ensuring CMS boxes only appear where a corresponding CHA exists.
>=20
> Make generic_uncore_msr_ops global so the CMS type can reuse it.
> Opportunistically add the intel_ prefix to match the naming convention.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013194005.9661=
5-1-zide.chen@intel.com?part=3D1

