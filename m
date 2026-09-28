Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57D400967
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582693; cv=none; b=frvTahFXIne3zKXpW5sqeyJI9acerIvqLNOdLusGaqjUkyfUGEvuRQkYFRFNNIxTSEu3v3m3oLrlSYn8dPhOy3acaZ8ubUxmpv8Un4sHwWO+MjFgL8Dt9hfapVaPPNkQR6JeRqrrKeDwkpvLsOBOzildowtfmDGNIpFRnkYPcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582693; c=relaxed/simple;
	bh=R6jkZd4Z/jyc23Tj9L4CrkNHmgMiKCStrxUN4TeJ+pA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fK1em8jCkcLP1ubwye8U5GRSeVWZV4aHUnbJLKss/GNQ3mI3L8fy4S7n8nmA9zlXrtByOrC1zfW7Gp1NRXOHtb60Ont4nNpbKQGYKTKpCJn0t7azp5YqaW51CWKGQkD1JIFtVgHvN5/UP55FsUwal5I9MQEc8Rbp2ddoerdEj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBBq3i9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBBq3i9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9139A1F00893;
	Mon, 28 Sep 2026 08:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582691;
	bh=X5+AzO8GWnv0t2+cQeDNbYaGWRM3Mtj9j2Kz+v8+Q/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UBBq3i9FsDVhzF+ilD1JyaV56/ga2fF0sd8oKgjoZUf98ypsAEURsspnQj5HNKVI/
	 Td89A63BoKK66EWS2g8Z+w6ULYe9+fKDN4L4wLJFdpO3/yUhxp1O0Hp2PbGueXM9AK
	 x77rIMLS6is1DX04fbPzSd3Qd3vxbxc2at46xfOWGqeChUf+tKEx0M1Cu3/DO/qler
	 3adKPhPirlu/vJ/jICSTH4F1Iwj1LbDX4YP+ppreX1qydS2x0r/r6H7YvuQ77eo7GT
	 K67e5+4qhdzqjMjuwudvu0ksLabV9NZcqfRnhH1Vxkw9Gskl/r8HZPG1sHd4ilRtsH
	 bw9vODuugzL+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] perf/x86/intel: Reject SAMPLE_READ for
 no-counter-snapshot ACR events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-8-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:04:51 +0000
Message-Id: <20260928080451.9139A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/x86: Validation bypass for SAMPLE_READ on ACR events via so=
ftware events
--

commit cc3bcd9a57c859b5993ae9c14bd06faec36a3c33
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Reject SAMPLE_READ for no-counter-snapshot ACR events

This commit restricts the use of PERF_SAMPLE_READ for Auto Counter Reload (=
ACR)=20
events to prevent perf from reporting invalid counts. It ensures that=20
SAMPLE_READ is only permitted for PEBS-backed ACR events with counter snaps=
hot=20
support, as non-PEBS events can be auto-reloaded before software reads them.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 377ff39124206..3fc3795534bf7 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -5184,6 +5239,10 @@ static int intel_pmu_hw_config(struct perf_event *=
event)
>  		if (hweight64(cause_mask) > hweight64(hybrid(pmu, acr_cause_mask64)) ||
>  		    num > hweight64(hybrid(event->pmu, acr_cntr_mask64)))
>  			return -EINVAL;
> +
> +		if (!intel_pmu_allow_acr_sample_read(event, has_sample_read))
> +			return -EINVAL;
> +

[Severity: Medium]
Does this validation fully prevent PERF_SAMPLE_READ from being applied to A=
CR
groups?

Because this check is inside intel_pmu_hw_config(), it is evaluated when the
x86 event is initialized. If a user creates an ACR hardware event group
initially without PERF_SAMPLE_READ, it will successfully pass this check.

What happens if the user subsequently creates a Software PMU event (like a
dummy tracepoint) with PERF_SAMPLE_READ set, and attaches it to the existing
ACR hardware group using the leader's group_fd?

Since perf_event_open() allows software events to be attached to hardware
groups without re-invoking the hardware PMU's validation callbacks for
existing members, it appears intel_pmu_hw_config() won't be re-evaluated
for the hardware events.=20

When the appended software event overflows, won't perf_output_read_group()
read all siblings and still capture the imprecise auto-reloaded values of t=
he
ACR hardware counters?

>  		/*
>  		 * In the second round, apply the counter-constraints for
>  		 * the events which can cause other events reload.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D7
