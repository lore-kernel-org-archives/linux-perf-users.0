Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77535476F1
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922904; cv=none; b=AT8ywIoX3ZTN40fOp9cDrh9WzbMBxRRoKnXYVQ1uf/rs3kWI4q+zKducgHMcOgfIluj8SVqDumlDiisHsM3r0ZcYMhAoQDcyWRepwaAU63QO/333VszD1p1s8k+K3WCQTE0xzSZTm27939cjGLdxAhFNgeeDurg4dNrBuuS/ZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922904; c=relaxed/simple;
	bh=AZBdUf4V8+iw85J0Y/qZfKAtWdqOqEPRw32MXV8GI1c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Sw7k1EKs6i21qHIPM+jIdvScZ6FZqLHXxyXSfUdl7HVWUCEg+zqK4UoeLpXZBQnGYiW82fQo0C9yF5bV6MrNihh2JL+sMHHlCSOSvYLDbU8mFKv7zIeOGTO2bGCi1xW7GP3MfzKLIufKxV04fOR68d5khxOtBBse2jlkc7hJxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpHGv/eS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpHGv/eS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60E41F00893;
	Tue, 13 Oct 2026 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922896;
	bh=Wu25UOa92jhW0TGVk0UPMNF8cpJ3GRnIl1vbNeF6tFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TpHGv/eS8pdQjGPV52oO/VaPeUDsNrbcHFfLLKkNow3RsBWPE92ShTBKZ7ZdJfFBq
	 HMvo1zNVliMq1oQXQrEy1NeKl8APY7XeO0M9wIm2ZVLYUObl79W9VmF3GC88OLjkbe
	 Cwtkm8+yORDAA+dgFFc5iQMiqwtJtrtYsfaVVCQ4zQl/2CETivLiVtxD3kz6i9G7Gk
	 0wBjx6l5X/LdrHZF1C1TRk/dTRsF79TQLz2LCyx6VPen3FxvrM7dLElT+GYUBGdkO+
	 V//+z99F5E/WnWbtcc1DLR/Q0IobDk1E0Hb3x8a5u6nNkmJlLAv8Akt+cF/Euj2XRS
	 lh6raDe2mv6tQ==
Message-ID: <sashiko-outbox-170447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/19] perf test attr: Leave out the events of the
 other core PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-13-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:21:35 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> On a hybrid machine the default stat metrics are opened on each core PMU,
> and the events of the other one have their own encodings: on an i7-14700K
> cpu_atom (type 10) opens UOPS_RETIRED.ALL, config 194, which the
> expectations, written for cpu_core (type 4), don't name:
>=20
>   expected type=3D4, got 10
>   expected config=3D209|391, got 194
>=20
> The test already masks the core PMU type out of 'config' for the legacy
> events, but raw events keep their type and encoding, so leave out the
> events of the core PMUs no expectation names, like the dummy tracking
> event.  Core PMUs are found as perf finds them: 'cpu' or 'cpum_cf', or a
> PMU with a 'cpus' file in sysfs.  Nothing is left out unless an
> expectation names a core PMU, so single core PMU machines and the tests
> with only legacy expectations are not affected.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D12

