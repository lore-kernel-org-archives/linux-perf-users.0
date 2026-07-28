Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667B381B10
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256993; cv=none; b=nUZYSrG9mglol3AcvZqB88KUOQfhJu+TjYiTmTUFWRvCKiMc5l4+wzuZGkO4T/waksc0ImpRZ/nTXXptI13wESYcDVai2eSIHQk5LnKw1yEVL3eeXtSCJigVSc5pXW+ONCDsyvTSGiMn9sZJhnkB2EtKzKIYLrkWlUBguTsGABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256993; c=relaxed/simple;
	bh=OC3DVI+VZ0LSkHbqCluJwYYXrSbP3201CGLUIXJm9Sc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTN9bZimsriV5TuK6MoodA6+FWA4S0y7UfXqqeEH5j8Eu4aemhpGrBkQXp8n4+00ZPrBeBSGd841D6FFwMBQlg7nZexWwt66ILIj/ynlj/Gdzfx+wvNbESUeWtAyyYF5DyT1nj+/5Fo+jkMNq33NeYkCV4DFxTq79avGQag0Ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MieSEd48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MieSEd48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7DC1F000E9;
	Tue, 28 Jul 2026 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256992;
	bh=LrE+nas6asHQzr3nu7FXnzGprvttfmsA1LXaOEQe00A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MieSEd48TIiOEzgoRy2+D6LN/gH74OnB33o62QH4QvpOlevbeNWatyHDu90SeSArf
	 vdL9+FjkbODIx55+xZQ6IDP+uK5kACVEHjgUKI0QaGC1bpJhvA91MAeCJby1glW8vv
	 DK4QhGTHzNoGifiHF/4MV+Slez8TdlaBA0JTzBoARBlKqM9hASuLOk9EptlVwlCTIj
	 AgX/5y+DNCEz3eSaRHlImyOXkvzTOk6MRIYP5qTBElZAkHQaXM42MHuSC54pNI1OsD
	 paGsm9NOvqffEqdqco7iEhMKN9QpKnqEj2AI/5Eua9N9AhbhLHwQwleCG9h/10UYgI
	 CDJPZ4GOx82bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] perf/arm-cmn: Plumb in new filter types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <90465c737b71be5d39c3662c7ba07ab6a1326009.1785252273.git.robin.murphy@arm.com>
References: <cover.1785252273.git.robin.murphy@arm.com>
 <90465c737b71be5d39c3662c7ba07ab6a1326009.1785252273.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:43:11 +0000
Message-Id: <20260728164311.AE7DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced filter types (SEL_EVICT_STATE_SEL, SEL_ENHA=
NCED_HBT_LBT_SEL, SEL_SNP_VC_SEL) are not mapped to any hardware bitmasks i=
n `arm_cmn_filters`, causing them to be silently ignored when programming t=
he PMU hardware.
--

--- Patch [4]: [PATCH v2 4/5] perf/arm-cmn: Plumb in new filter types ---
commit b05e0afda744759b2e246b65abc52e94120966e6
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm-cmn: Plumb in new filter types

This commit adds logic to handle events with upcoming new filter controls,
special-casing the EVICT_STATE_SEL events which require HBT_LBT_SEL as a
secondary filter.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 6536f0ec699b7..9d5833f8cff2b 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -284,6 +286,9 @@ enum cmn_filter_select {
>  	SEL_CBUSY_SNTHROTTLE_SEL,
>  	SEL_HBT_LBT_SEL,
>  	SEL_SN_HOME_SEL,
> +	SEL_SNP_VC_SEL,
> +	SEL_ENHANCED_HBT_LBT_SEL,
> +	SEL_EVICT_STATE_SEL,
>  	SEL_MAX
>  };

[Severity: Medium]
Will these newly introduced filter types be silently ignored when programmi=
ng the
PMU hardware?

It looks like they are not mapped to any hardware bitmasks in the
arm_cmn_filters translation array:

drivers/perf/arm-cmn.c:
static const u64 arm_cmn_filters[][SEL_MAX] =3D {
	[FILT_NONE] =3D {},
	/* DVM etc. */

Because missing entries default to 0, arm_cmn_set_event_sel_hi() appears to
bypass them when preparing the register payload:

drivers/perf/arm-cmn.c:arm_cmn_set_event_sel_hi() {
    ...
		for (int i =3D SEL_OCCUP1_ID; i < SEL_MAX; i++) {
			if (filter[i])
				reg |=3D field_prep(filter[i], dn->filter[i].val);
		}
    ...
}

Should the arm_cmn_filters array be updated to include bitmasks for these n=
ew
selectors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785252273.gi=
t.robin.murphy@arm.com?part=3D4
