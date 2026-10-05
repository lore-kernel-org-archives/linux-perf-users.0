Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBC4A3F1B
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210269; cv=none; b=psM67WQxO/w3pDhpicar5J9THyzEVcsAL0BzLqSkpsRwt7qwMsr1gWGHdRRUzrC3OAk16D5uwSI37Y6YIAYD48PVqQmM/f5tt46mPsDNaxhpjUwDjpi1p6cBEAtKK4Ig/zECz+bWMP5GXUh0CWNJtOOpcy1rLLL0vFvgr0NNe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210269; c=relaxed/simple;
	bh=gwhCXMYhiCPtKLq6QKErho4WX6qR+iwKs83+Emu3sfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nb4NDNmPCm1b77I+BW+PThDkfDWYHbfElDmuIrevHpfW4YhEMXdqpZSH3RNJnXbMbLny+D5hV084Y3dp4Zsx1amKHV+ALbW/TfDThqswXb4HZ4KN9BNLGc4zGf0gUgDX4drEiJ+VRTua86W/AMM74Gew79iKy+fo1EYPHHpXCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfpncdhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfpncdhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0281F00893;
	Mon,  5 Oct 2026 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210261;
	bh=gwhCXMYhiCPtKLq6QKErho4WX6qR+iwKs83+Emu3sfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WfpncdhSiIs2DFVFiQIdVbfR/wapbPc228LypYYvcl9C/P4/0BsqDKtVLw/NC8tSO
	 uoDdX30KBWmtM1cmHi3WiZ04Y0f3yBAGeInChiVQ0lRRRumGCTC3AS5f6LG719TwOv
	 kF4LlZ2XhAyremRoCCJX3FDH5UOBfoV4lW4r8y+IBbzZhGojvJ8P1bWCceuf//aVIG
	 PyY8kU5hfDp03Eovqu/WxNZtlfzJQLxeDt0PDvPdDb6A8h53rBcmuQii5CMfooUXds
	 Mzb045BgV2LItbdyG+neTErwslSNgC57TzYAA3AResbjNDPfjYFOTXZ4mtGAGX96p+
	 m+B6GPJTRid5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf/arm_cspmu: Add Arm system PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <222d98feab5ca2836fdef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com>
References: <222d98feab5ca2836fdef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 14:24:21 +0000
Message-Id: <20261005142421.AE0281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Arm's latest Compute Subsystems and SoCs are using a common PMU block
> in various places which can mostly just be driven as a generic 64-bit
> CoreSight PMU, but does have an IMP-DEF register for additional
> filtering. The details of event and filter encodings depend on the
> particular PMU instance, so are left to the higher level Arm Telemetry
> Solution tooling.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/222d98feab5ca2836fd=
ef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com?part=3D1

