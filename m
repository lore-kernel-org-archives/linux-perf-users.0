Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489B2C029D
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516597; cv=none; b=gHt2qPftVDj8Z3N5Jcl9ubzd3tBLH4CHxnT4TroH/T39nZJA5kH+bY/Eh/w9oLhgmLGHiHebki2oMS5ZiebSf6E1II5S1V+dIclzXr4xOh2nruLk6aPAW5Sco8hWRg5T/RCF4ky45MixoN39tJl70NCafq/3r+Qv1mcyjkG9pJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516597; c=relaxed/simple;
	bh=h3OEVb5/UDhp9TVqt3eZ3Mdi9J1cmSz24Tr4E/JZajE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mnyktTZN0bktUqBTPhXzvzKJxVHHNk2kD86nm9Kv2Q5t14E8a61eaT7ohb7X3uh8XsMOyhtqZ0Vbze7xdRlrjRtIXE7KsNlxsNMQccLtikjANEz8k4+4waVYOv5/g29r/Gb2VnRUt6Lk55F1uMA8+vmNZotGuI8C3Xcp044dsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hso6EX6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hso6EX6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B6AC19425;
	Thu, 30 Apr 2026 02:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777516597;
	bh=h3OEVb5/UDhp9TVqt3eZ3Mdi9J1cmSz24Tr4E/JZajE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hso6EX6AUY4F+6n5WhGZYB7kmK6dHj88jpV31lUXaYQUDKCTzCznqwN3njGdNF982
	 56bt1zqWGlfUrLl6nqLC3n7fgSeOIohz/Lb5/YkGxGzhWgIceUx8vVD4YcohNjLK+1
	 pgsUz8HNtqKFtftkm8m5jXpBsjBM4j5RLTiNtWj/IfFAkU3F7zaxC6lskEnUgnlZRx
	 WEV6bAXiN7kjZZPrK3b6rvq7/7FP139lVjAcQtJf5Y4wdaljRuYCX+jCpyyaHt2wPP
	 u42Vm/A8NG2twQO0MvFJdGk+Qjc7vEJ/SwAqQCb7UgW3hhUGvN0wvvxhL3IJIzJuXm
	 VVSaeDw/Jy9JA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 3/5] perf/x86/intel: Disable PMI for self-reloaded
 ACR events
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260430002558.712334-4-dapeng1.mi@linux.intel.com>
References: <20260430002558.712334-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 02:36:35 +0000
Message-Id: <20260430023637.37B6AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Event PMIs can be permanently disabled due to a stale `hw.config1`=
 state when an ACR group is broken up.
--

commit cfc30b699ff51679e8ae587b226916cfd6fbe7bc
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Disable PMI for self-reloaded ACR events

This commit disables Performance Monitoring Interrupts (PMI) for all events
configured with Auto Counter Reload (ACR) self-reload to prevent spurious
"unknown reason" NMI warnings.

[ ... ]

> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..524668dcf4cc 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -137,6 +137,16 @@ static inline bool is_acr_event_group(struct perf_ev=
ent *event)
>  	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
>  }
> =20
> +static inline bool is_acr_self_reload_event(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	if (hwc->idx < 0)
> +		return false;
> +
> +	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
> +}

Can this cause PMIs to be permanently disabled if an ACR group is broken up?

If the original group leader is closed, perf_group_detach() promotes the
siblings to standalone events, making them their own leaders. These new
standalone events no longer have the PERF_X86_EVENT_ACR flag (as it was only
set on the original leader).

Because they lack the flag, intel_pmu_acr_late_setup() skips them, and
their hw.config1 field retains the stale physical counter bitmask from when
they were in the ACR group.

Since is_acr_self_reload_event() checks hw.config1 without validating if the
event is still in an ACR group via is_acr_event_group(), could a detached
event that gets assigned to a counter matching the stale bitmask incorrectly
return true here?

This would cause intel_pmu_enable_event() to incorrectly clear the
ARCH_PERFMON_EVENTSEL_INT bit, breaking PMI generation and sampling for a
now-normal event.

>  struct amd_nb {
>  	int nb_id;  /* NorthBridge id */
>  	int refcnt; /* reference count */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430002558.7123=
34-1-dapeng1.mi@linux.intel.com?part=3D3
