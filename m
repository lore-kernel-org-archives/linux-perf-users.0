Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82591358378
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080226; cv=none; b=MOwIHWZD8ruxvYDY+bjXDTmSi4FPWQwQLSpzoKlu5KVGC5pdB3zKd4WyNEqITwM/CUQ5oWfNYL4LaEO3sVDYQ1S2HBveTN/vnhvcATx00lP2FhjdlI2RNPE7GX2fw1h7BUgektKRBunHcLxtPhJTHx/D1sAe5Qx0Zzg5Gj1eaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080226; c=relaxed/simple;
	bh=k0ujdDEp9s/4s6lTdd6rK5Pw8erPqHAW9cYRx/PsE4k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rZaTkPXMEYjFCrOwLPps/Hrt34cnbj5TnbBI1N1DRT7+fdlZY//VjTsobvg+l8N5bcKrUsMiEuhcikANtK/JfHY8meiaxr5WaeARd5K+zPW1WXi1gqiA/JCC+tLTtEo8WKBbpcrds6ZB0n6d4E4thd/ZXxDJhkNWHmZpqv3/zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLEuY1CG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLEuY1CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40CA1F000C4;
	Thu, 15 Oct 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080212;
	bh=k0ujdDEp9s/4s6lTdd6rK5Pw8erPqHAW9cYRx/PsE4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fLEuY1CGsD2C7t08TAqQgqrH0dV8m7PCBAUrTz5mLeFbi8ZwUCYFSTl1q4qcmZ51B
	 NEuD8MiHg1+tlYjtcUX8W+t8JYMNvjBM5e5rENeWfgk0TBb7x04a+R9DTgN7KQ7Tob
	 JzEZrdSaDFlKzOBF15aty6WKNMQefLnsNrooEFyyXSj+a+9k4xoitiSTlPXA5icyL8
	 MXw9pMdakbt+ldLBlsexXbs+ruK6QU6/M0h6kmeLvLMV9tdkMm3H9mHVisabk6NaF9
	 pPCDlOLUQetii2BZ5/8CuxvJg4FyYD4ZC9rX4zrCfAm5h2b8jdqVUZnhT6IRGXUSp3
	 EL/xVj0RQNbrg==
Message-ID: <sashiko-outbox-173126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf: arm_spe: Order padding before publishing AUX
 head
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015-add_barriers_for_perf_aux_output_skip-v1-1-5847d0578859@arm.com>
References: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
 <20261015-add_barriers_for_perf_aux_output_skip-v1-1-5847d0578859@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:03:32 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The driver fills alignment gaps and calls perf_aux_output_skip(), which
> publishes the new aux_head without a memory barrier. A userspace
> consumer on another CPU can therefore observe the new head before the
> padding stores become visible.
>=20
> Add smp_wmb() between the padding stores and perf_aux_output_skip().
>=20
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical P=
rofiling Extension")
> Assisted-by: LLM
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-add_barrie=
rs_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com?part=3D1

