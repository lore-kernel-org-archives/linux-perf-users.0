Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C410F2
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779603794; cv=none; b=fbwq7ae/D3YGLtQBfkNZU11FEU/NJIY5asjp2T+jXIoQF9G5FUcX7i/1ihyWZXBaN5QcG4AJZAS2bnXCH/9Q88Yr3WabZ886lcbO1ZBmX/3VwhfgpsRX8zYpxcDDtTIL0PsE0yP6pK6TDTZuMT2W97qjXWwRIF2XrdyjsaEng94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779603794; c=relaxed/simple;
	bh=riILPKl9Hpbw8wEACKQvGqHkQhfbY5Ss8YjYCNH7Pmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YbICEngbx9FdqYFz43Aho8PcuPmS95SRIJ5KssYzdQkL+B1v2qT7JHiFCPagwtoAR7jWKUZEOB/ajjUAusjXXfsDtBNhPtvBK0WB0e9z0OmrPbhUOqAQvUTLe0z2fqhu2zib4OQAfq3kY16aqN5BC76PeyzM0K4U2PF1qYLTrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlAeCeKt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlAeCeKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC22C1F000E9;
	Sun, 24 May 2026 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779603792;
	bh=4pzUJ+7YlYawZF27lQJwR5WLLyxNpT7EnQIS5XFZB6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AlAeCeKtDvnh80KfSJFMLw47KNnYIywH6JEFfhbKmvC0UQ4zUjTlLvd9NsORA1+aP
	 b40v5EoIjpuVYJ6FArFrprldzXMsXf+bD02yX4T4p7p6JfSr//e4ecPYGRMRcaqq+v
	 DJHURxmC/hTZazO0mTiFpkogJluFDUNzep7fyrLDj6TRg5l0CiwNt2mZoarskzRaUL
	 Iqbm0kPa+PXf3/WB4WGW9igFBe6nzycqnTJTVWmuXKD5dNSaJ3kcATuV9dSJ9uuy56
	 sJywrzgqK9fF55A+1iYZ7Tor8tRTXSHs0yrrHt8vhcAiwzRpHw5jEUSTqkOR9cEKY5
	 0PJIcLv62nEGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/29] perf session: Bound nr_cpus_avail and validate
 sample CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-27-acme@kernel.org>
References: <20260524032709.1080771-27-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 06:23:11 +0000
Message-Id: <20260524062312.AC22C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Aggressive global clamping of `sample.cpu` to 0 destroys valid eve=
nt data on systems with large CPU counts.
--

commit e0720e6d1df18694dab6abee90c753e65bca2269
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Bound nr_cpus_avail and validate sample CPU

This commit introduces a bounds check on sample.cpu before calling tool
callbacks to prevent out-of-bounds access in downstream consumers. The
validation caps the CPU limit at MAX_NR_CPUS and clamps any out-of-range
CPU values to 0.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index cb1d851686d9c..69eb404f805d8 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c

[ ... ]

> @@ -2099,14 +2099,100 @@ static int perf_session__deliver_event(struct pe=
rf_session *session,
> +		/*
> +		 * Cap at MAX_NR_CPUS for the bounds check =E2=80=94 downstream
> +		 * consumers use fixed-size arrays of that size.  Keep
> +		 * the true nr_cpus_avail in env for header parsing
> +		 * (e.g. process_cpu_topology) which needs the real count.
> +		 */
> +		if (nr_cpus_avail > MAX_NR_CPUS)
> +			nr_cpus_avail =3D MAX_NR_CPUS;
> +		if (sample.cpu >=3D (u32)nr_cpus_avail &&
> +		    sample.cpu !=3D (u32)-1) {

[Severity: High]
Does this global clamping destroy valid event data on systems with large
CPU counts?

If a system has more CPUs than MAX_NR_CPUS, capping nr_cpus_avail here
causes legitimate samples originating from CPUs beyond the maximum to
be evaluated as out-of-bounds. This permanently overwrites their CPU
telemetry to 0 for all subsequent event consumers, even those that
dynamically allocate arrays and do not require this limit.

> +			/*
> +			 * Warn rather than abort: synthesized events
> +			 * (MMAP, COMM) lack sample_id_all data, so
> +			 * parse_id_sample reads garbage from the event
> +			 * payload.  Clamping to 0 protects downstream
> +			 * array indexing while keeping the session alive.
> +			 *
> +			 * Preserve (u32)-1: perf script and perf inject
> +			 * use it as a sentinel for "CPU not applicable."
> +			 * Downstream array users (timechart, kwork) have
> +			 * their own per-callback bounds checks.
> +			 */
> +			pr_warning_once("WARNING: sample CPU %u >=3D nr_cpus_avail %u, clampi=
ng to 0\n",
> +					sample.cpu, nr_cpus_avail);
> +			sample.cpu =3D 0;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D26
