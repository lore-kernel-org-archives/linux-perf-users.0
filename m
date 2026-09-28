Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5C84349B4
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583148; cv=none; b=CcpBxsSSiU2JLV38ds7m9Ug542ch2SsL/lhemT75woRjPtTSyAxHH8HYAs2iAk5zqvfQ043tBf72s/50eh26hdfDp5zaYyNy5fqVtSU1EXJQDv8kxFGA1WpWKI+n4UGPyuu3OAHJXZl87BU4X9WZNMx7hKwh3wt7LULBRIRX6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583148; c=relaxed/simple;
	bh=H6Zje2J5uvzzPGWGY52hAfjA8LCromUrEQK/iPh12TI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gv+S26dJUjCVyqSKa0liEpiLQW6KwwtK7+BmG/uA/KXBfTpHCkpM2B0pSrF1k4bKsUiHV3mcBbkTqpS4Qj+swoLP8PjFciKUg6b3i5wN3aC3TWKkQZindlGgbCiVf35bnqsjXZVeYglvwYowtKgoh/SissVekEhBrGqZO650E6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZFtzQWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZFtzQWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C71F000FF;
	Mon, 28 Sep 2026 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790583147;
	bh=PLY7OIGvx48RNycnIZ4z6T2qDAXHQwiZBU2VNNTrfqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZFtzQWPPwEpCfY3OJaAA6YdqnmIfl+fleF1XlF/8/LgJIVvY4IhGAD8aJpoAUTHD
	 M7J+0FxDcH2DxHNcKiIzto/geumQiYgkX5yccuWoFbm+Id/I8F08T1ig2jGxtL9x84
	 Yy5rcRkfF7podThPS1WU9h2O1FgsaKef95rZSnIksL6/ySlFUDsP28/LpbKK0l/JyK
	 M/hL0cRI9IgWRGhUYyd6mv/Blp5cjeUyOl4pKxviUvFGnzLB6iho+0wokDOzsCJ0+5
	 DNC/yD9rM/FMLElpkFdMInTFmM82neR0iWBV8daIZXQUKdUSlEWhbvN2Wfr940hQCq
	 gP432MOkcVgJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] perf/x86/intel: Allow Topdown metrics with a
 non-leader slots event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-16-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-16-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:12:26 +0000
Message-Id: <20260928081227.314C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: lockless sibling traversal and modification in intel_pmu_hw_=
config()
- [Medium] perf: state leak on active slots event if metric event allocatio=
n fails
--

commit 35318b4bb32158e6a24c6de2f1ef286a1ed4b438
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: perf/x86/intel: Allow Topdown metrics with a non-leader slots event

This commit relaxes the requirement for the slots event to be the group lea=
der
for Topdown metrics, allowing metric events to validate constraints against=
 a
valid slots sibling instead. It incrementally validates groups and sets
reliance capabilities so detaching a non-leader slots event triggers depend=
ent
metric events into an error state.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 6cc1462c9c82d..9025f29f625d4 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
[ ... ]
> @@ -5300,30 +5300,53 @@ static int intel_pmu_hw_config(struct perf_event =
*event)
> =20
>  		if (is_available_metric_event(event)) {
>  			struct perf_event *leader =3D event->group_leader;
> +			struct perf_event *slots =3D NULL;
> +			struct perf_event *sibling;
> =20
>  			/* The metric events don't support sampling. */
>  			if (is_sampling_event(event))
>  				return -EINVAL;
> =20
> -			/* The metric events require a slots group leader. */
> -			if (!is_slots_event(leader))
> +			/*
> +			 * intel_pmu_hw_config() cannot tell whether the current
> +			 * event is the last one in the group. Require the slots
> +			 * event to appear before all metric events.
> +			 */
> +			if (is_slots_event(leader)) {
> +				slots =3D leader;
> +			} else if (leader->nr_siblings) {
> +				for_each_sibling_event(sibling, leader) {

[Severity: High]
When a user calls perf_event_open() to add a metric event to an already
active hardware group, this is executed without holding the group leader's
ctx->mutex.

Does traversing the sibling_list without the context lock here cause a data
race? A concurrent thread closing a sibling file descriptor triggers
perf_group_detach(), which mutates the list and could lead to list
corruption or a use-after-free.

Additionally, since for_each_sibling_event() invokes
lockdep_assert_event_ctx(), will this trigger a WARN_ON_ONCE because the
required lock is not held?

> +					if (is_slots_event(sibling)) {
> +						slots =3D sibling;
> +						break;
> +					}
> +				}
> +			}
[ ... ]
> +			if (slots =3D=3D leader) {
> +				event->event_caps |=3D PERF_EV_CAP_SIBLING;
> +			} else {
> +				slots->event_caps |=3D PERF_EV_CAP_RELIED_ON;
> +				event->event_caps |=3D PERF_EV_CAP_RELIANT;
> +			}
>  			/*
>  			 * Only once we have a METRICs sibling do we
>  			 * need TopDown magic.
>  			 */
> -			leader->hw.flags |=3D PERF_X86_EVENT_TOPDOWN;
> -			event->hw.flags  |=3D PERF_X86_EVENT_TOPDOWN;
> +			slots->hw.flags |=3D PERF_X86_EVENT_TOPDOWN;

[Severity: High]
Does locklessly modifying the active slots event's event_caps and hw.flags
cause issues for running events? Setting PERF_X86_EVENT_TOPDOWN on a
running event changes its NMI read path to intel_update_topdown_event.
Because its saved_slots was uninitialized (0), this could subtract 0 from
the raw MSR value, resulting in double-counting the event.

[Severity: Medium]
What happens to these modifications if the new metric event allocation
fails later on (for instance, in perf_allow_cpu(),
security_perf_event_alloc(), or perf_cgroup_connect())?

Since there is no rollback mechanism in the error path to restore the slots
event, it appears to permanently leak state. Being incorrectly flagged with
PERF_EV_CAP_RELIED_ON and PERF_X86_EVENT_TOPDOWN permanently alters its
NMI read path and breaks its sampling capabilities, even though the
dependent metric event was never successfully created.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D15
