Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD073F5BDA
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785001465; cv=none; b=nmibJkkHh/J6GTLpkmwskx6cr3FCnNJ6LHyM1IdAtNbDJq1LltIMct3qSclLZ665XhnJ2yhrn7XK2pf5xjVCT1wWJVRYbIUbpPVJdh1CmvWER09rTPVEDoW1sfz10cnqz2mXguL7NS1s466a/nfz8+7LIVXjf2kBagk8gkM18fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785001465; c=relaxed/simple;
	bh=HYhgINFIyqfS5Tk6mCzySZQTedUAld3vMuvxpljd1ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gQXjsPCxZI/ZvCvoc/OVgG2+PjgqX2vml8AoGEqOuMztp85ais2Z55X702N1EeFX7FYus39QJkSwhrlNKQVsqIEE62bcpu3a+YaaQUiVuE0JRsGimx8hp2OcS4lsNF97gjHMxoLmt8i4jNir48dSSDXW6eTbgxB8/ZaOx2rcVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ont/+qoG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ont/+qoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDB51F000E9;
	Sat, 25 Jul 2026 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785001462;
	bh=0Tv/b+nOc3VPb7qBdfju8R4iJhMlZerz54UJgpX+Hvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ont/+qoGuwSebQJuVSJYVDt7rvDRSbkxL8m3PVvwWBw69Kr9spbBokmQECa08iCyX
	 yM+E8hz2cmOzfS90q8BpKHj3Hv8ebqRH45/JhSEkZMWzd9woF/R3/qOWbEhZuy7ypw
	 OEjryh3ZcxpCYOfVXqVj8m0ZknE1JJYBbsQKiLAZVdW0xKeaakMd+560E4Kc12wLQE
	 zzG++KWKj1o+lgx2/DBqVkKlpdKK05/sLDLpd7NP5bbED9mUczLboSvkOQuHcF+JcG
	 lntm1ZEk1tkKYCE7PVg6alLIeEruVfMONoamtzXMQHVs3dT2xJ6QBmv3am0NBjYH+V
	 UDfBo8FGdclgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf sched latency: Add histogram and time
 interval options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725173341.679782-4-atomlin@atomlin.com>
References: <20260725173341.679782-1-atomlin@atomlin.com>
 <20260725173341.679782-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 17:44:21 +0000
Message-Id: <20260725174422.3BDB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Global latency histogram incorrectly includes idle thread ('swap=
per') events, causing mismatched totals and percentages exceeding 100%.
- [Medium] The `--time` filtering option corrupts task state and records fa=
lse 0-latency samples for tasks that cross the time window boundary.
--

--- Patch [3]: [PATCH v2 3/3] perf sched latency: Add histogram and time in=
terval options ---
commit bb3a51b49ab123e7a4b3ab24f406cc892cd975b4
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched latency: Add histogram and time interval options

This commit adds a --histogram option to perf sched latency to display a vi=
sual
bar chart of CPU wait latencies across buckets. It also adds a --time optio=
n to
filter trace event processing to a specific time interval, and a --hist-mode
option to configure logarithmic or linear bucketing.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 00ff5abb08b57..e3051e6f7b1aa 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -1169,6 +1291,10 @@ add_sched_in_event(struct work_atoms *atoms, u64 t=
imestamp)
>  		atoms->max_lat_end =3D timestamp;
>  	}
>  	atoms->nb_atoms++;
> +
> +	b =3D latency_bucket(sched, delta);
> +	atoms->hist[b]++;
> +	sched->global_hist[b]++;

[Severity: Medium]
Will this unconditionally include 'swapper' events in global_hist?=20

Later in output_lat_thread(), 'swapper' threads are explicitly excluded fro=
m=20
sched->all_count:

	if (!strcmp(thread__comm_str(work_list->thread), "swapper"))
		return;

	sched->all_runtime +=3D work_list->total_runtime;
	sched->all_count   +=3D work_list->nb_atoms;

Since sched->all_count is passed to print_latency_histogram() as the total=
=20
count, including idle events in the histogram buckets but excluding them fr=
om
the total could cause percentage calculations to exceed 100%.

>  }
> =20
>  static void free_work_atoms(struct work_atoms *atoms)
[ ... ]
> @@ -1313,6 +1446,9 @@ static int latency_wakeup_event(struct perf_sched *=
sched,
>  	u64 timestamp =3D sample->time;
>  	int err =3D -1;
> =20
> +	if (perf_time__skip_sample(&sched->ptime, sample->time))
> +		return 0;
> +

[Severity: Medium]
Does unconditionally skipping samples outside the time window break the=20
internal state tracking?

If a task wakes up before the time window starts, its wakeup event is skipp=
ed=20
here, preventing its wake_up_time from being recorded.=20

When the switch event later occurs inside the time window, the task might b=
e=20
treated as newly seen or stuck in a sleeping state, potentially resulting i=
n=20
false zero-latency samples or dropped tracking. Could we maintain the task=
=20
state machine even for samples outside the window?

>  	wakee =3D machine__findnew_thread(machine, -1, pid);
>  	if (wakee =3D=3D NULL)
>  		return -1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725173341.6797=
82-1-atomlin@atomlin.com?part=3D3
