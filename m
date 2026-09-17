Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051937F321
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611082; cv=none; b=gNfqhzl2FCEM6rAm28Qj0ZfTeTmzdtkkMA6TnfGUjWZLE4AcUc0Uczi7q/w4WsCBDgHbTBQCArj8uNmcTCv8W0rzr8PYi+mBvfvAhF0mZy7WLwk3l1qJFlYvKrWNEEJ9ik0vc7S3kpXYgbQeFul8VDJK1U5dTmzkJMCmIOWsreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611082; c=relaxed/simple;
	bh=dgYqRFtiM370BkNp3nD7SZFN1mEo2p4J4amrOmk8wqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=en4KyQUndIkUQ3MODz2T+hJgYhE+LkHVEkeSgHhFesnDe7+9C2cRv2+V4gcLgiBrK/lpqJhj1TokYCVhENHlMUaaAw3qrBMraJXYarRuYwAM2BKijbfFmhtr1bK7XYvXvXLxb22ImwNDo5DaZZisI4hXyBB5o893x/54dmnUVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+jYM4JJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+jYM4JJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5A31F000FF;
	Thu, 17 Sep 2026 02:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611081;
	bh=dgYqRFtiM370BkNp3nD7SZFN1mEo2p4J4amrOmk8wqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+jYM4JJpTqDb+6cJO6M1LTkQCkKQJIAH63wb8K5nd+dK3QyLapbGOuh0J1JiLHRV
	 I0wtLoeh+a1J9hd44OY+E+0snc2ZcsxhBd5YwsK8HbDMwwY3gACdpCFOyg/Rf6HXzs
	 gr52P4ZO9KpLfU2JzXoa84tg+0x6Oea8R3maG/I+05F7+1zn7Pk0gA+Bm11b/qMgKg
	 6km7mCUtQQ50bQtzDAWfTD4CnEDaEuHIlPJJLTwD89HMHrQWR/KsXkzQPbME6CCbp4
	 +zayMwESV//yOs89EbC4HCtWb9+wZMduGbtfbTv0dONe8GMl3J41mf2J3fQwdKpwuS
	 kHNb3Yn7iVH5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] perf/x86/intel: Delete dead NVL PEBS data-source
 init call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-9-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:11:20 +0000
Message-Id: <20260917021120.CF5A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Nova Lake now uses the OMR data-source table for PEBS data-source
> decoding and no longer depends on the legacy static pebs_data_source[]
> mapping.
>=20
> Remove the dead intel_pmu_pebs_data_source_lnl() initialization call
> for NVL.
>=20
> Fixes: c847a208f43b ("perf/x86/intel: Add core PMU support for Novalake")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D8

