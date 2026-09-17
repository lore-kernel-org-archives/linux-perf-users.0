Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFF38E5C5
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669526; cv=none; b=uhWQmBPztcZCtx22RP8oNtR0KxJbd7cDx2Xxw0nXOQccaOcPk3D8PrZwM2ZXvzO0T+KyBclacBbv2BVAN4ti5qSdU3wA6JXma1ih/UDouQXrRwFbnwp0OtOaMs+cg8YGqB3T9MNrXoG7ERObLOjjzYFfZmLCwpz2B2DMtx+GGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669526; c=relaxed/simple;
	bh=rQmaFv9nWA5VMoO7otlRirjae7XAMSj0+K00oQOTnO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rZnBJvhMhGvJB9FluRXn4u00H/e/LgHYR3VrSjgAK5kplM8XSY++pWxlS1pItIEhxj19yXypKuW3utt6jn9C1pYVtGsAo7hjvCV5fTPnFM5WbE7eX2iUWJmBRCLSDsmBZb53ZaaM1BbJBTEm3xAR1lCJlqtKIaZ3njQN0pOcN1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntk9I7Pd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntk9I7Pd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE801F000FF;
	Thu, 17 Sep 2026 18:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789669525;
	bh=KMjs/DMf2ywpTUvw4wrNcjeullGJeCoEGSVE6wXPQ4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntk9I7Pdx6y/IbGf5XZYidWOHcKRTAuFh9HnxyDOEcIYW0iU/Rj0I62j9OrpoxXaZ
	 3z4PyIH8889x47NLIzuI/OCGqjXQhgHrRAius+KwpTfa3lgI2VrSa6abvdMBb8Aabp
	 9e5seCl1JW2Aqoxwp/HypuA3Uq4LTOZ9FySo7eWWXgI/bdm1wF9TgLLN2H/ETcS1l9
	 ruqq0lOmgYi4XiHF1VFFoZTOyBYVbYlEyyHLT6HzyGnOq6v8qssjscbnzjDKtG/5Wf
	 yPMR0DR+gb+R5O2KrpkHLiuSjDMfQNv//LjjowWq0EE0sKbxFPNHhHRKmKmj/QjEn3
	 33Ph/Ddx7/Dzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917181016.381994-1-zide.chen@intel.com>
References: <20260917181016.381994-1-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 18:25:24 +0000
Message-Id: <20260917182525.3DE801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> arch_is_topdown_slots() requires config1 =3D=3D 0, so it misidentified
> "cpu/slots,metrics_clear=3D1/" as not being the slots event, and an
> additional slots event gets inserted, which fails event scheduling
> since the group now needs two fixed counter 3.
>=20
>   $ perf stat -e "{cpu/slots,metrics_clear=3D1/,cpu/topdown-retiring/}" -=
- sleep 1
>   WARNING: events were regrouped to match PMUs
>        <not counted>      slots
>      <not supported>      cpu/slots,metrics_clear=3D1/
>        <not counted>      cpu/topdown-retiring/
>=20
> Drop the config1 =3D=3D 0 check from arch_is_topdown_slots(). This is
> safe: config1 has no bearing on the event's identifying config value
> (TOPDOWN_SLOTS, 0x0400).
>=20
> The attr.type =3D=3D PERF_TYPE_RAW check is what actually matters: only t=
he
> core PMU is registered with PERF_TYPE_RAW, and on x86, 0x400 is
> guaranteed to be slots event on core CPU.
>=20
> arch_is_topdown_metrics() keeps its own config1 =3D=3D 0 check, since
> genuine metrics events have no "metrics_clear" and config1 remains 0.
>=20
> Add a test verifying that an explicit "slots,metrics_clear=3D1" event in
> a group does not trigger an extra slots event injection.
>=20
> Fixes: 5b546de9cc17 ("perf topdown: Use attribute to see an event is a to=
pdown metic or slots")
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917181016.3819=
94-1-zide.chen@intel.com?part=3D1

