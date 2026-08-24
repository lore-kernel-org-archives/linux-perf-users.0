Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4903ED5C5
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561712; cv=none; b=M7KThx99P2kgBNr2TF+ufmgF2c+HKFTmWe+MVJ47TKgOISv2szPA5fUvZ6WQUFj4L4SfEtaRUjCYE3DQ/z+vMmoouzcNHq9EKcClQYhLov519fNAZF/JrewpTQorrrUS0kr4YD+GBwkgtD5nJgE3pU3TEKloBNmdSUqZIkO8ME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561712; c=relaxed/simple;
	bh=bBicGiSuKvOXDoLC0BGJMs8m3oWG9GwADqF98/UAC84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZiXRC0RpQN9swgf0bnz87H0LxcwDc6PMFVwGbV59uhT7H1NM+PUzRydhbShXhVF0PEd+p4tb6d3I/JTaANfAz2A5YYAnpnFfZOAhq94qBvXeNucOqE8RFpnk/dl6ECl6I7qCLqrCin/4x8hWJ7arIr98OUoSWkxI9TTelagGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVKP2mLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVKP2mLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4911F00A3A;
	Mon, 24 Aug 2026 08:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561710;
	bh=bBicGiSuKvOXDoLC0BGJMs8m3oWG9GwADqF98/UAC84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVKP2mLKaKHAlYr1kAY1gcugm3NPlFybnVDpJgOdErhB0JzP3smysTctgq4nPFVl9
	 wARt4l+zQeWxEituAjigWxsbXAavDaPg3nXDTfAlWmGtq76s3mJPFcnPlRAulAHG9+
	 G4Ayoba+CZchKL+4fBWlnmUTBGpCv+1oYs8KeVqEv8EabQIc7Ci/azHQnqBDDlX6E3
	 aASkVHRhwPR+LtTyTVR7L+DOMqnkU5QfT+mUAoGlOntfulpOqNKWFzlWEZT6J6lzrI
	 4rjtAp5nyk41MTdyDlYrLQ+fehEJ5wneuZkuvYWwztt1ve/TZHOo6dB4MqkpFXCFcm
	 4k38BnX3jYnew==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 14/23] perf/x86: Support YMM sampling using
 sample_simd_vec_reg_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-15-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:55:09 +0000
Message-Id: <20260824085510.3A4911F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Support sampling of YMM registers via the sample_simd_vec_reg_* fields.
>=20
> Each YMM register consists of 4 u64 words, assembled from two halves:
> XMM (the lower 2 u64 words) and YMMH (the upper 2 u64 words). Although
> both XMM and YMMH data can be retrieved with a single xsaves instruction,
> they are stored in separate locations. The perf_simd_reg_value() function
> is responsible for assembling these halves into a complete YMM register
> for output to userspace.
>=20
> Additionally, sample_simd_vec_reg_qwords should be set to 4 to indicate
> YMM sampling.
>=20
> YMM sampling will be enabled in a subsequent patch that sets
> PERF_PMU_CAP_SIMD_REGS.
>=20
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D14

