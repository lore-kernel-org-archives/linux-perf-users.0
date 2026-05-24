Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17612571DA
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595495; cv=none; b=bBln/y5yHNBX1hWN+mlbTHdoLMq17vnW2QNlb0Qok3HnVaV/8igPf0zBf67gZ54YLnD5vzAd61TmnA/Wx/Ik4enhNOk/SsgsqY3osCexuVsOp9hb17tZ6FZOQvw/bPRzaorx6sZ949HyGpZIgsfupyWVPokpLGYMrCdBqhHrDV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595495; c=relaxed/simple;
	bh=dldFMbWOQblgTfXnrNPIOWDzr1Ug7ERHWhE5TIDO1TE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P13ErbRYs6ibUpuXSIQCQFgjY/JMfmxIo6iPSclUZck7CscJjo2Q2CSmgCyW4r0zYtBiV7aQ2UK8Bzwsv8Z43oG0cabokAJsUYm+PVQB7c5R0L46Lc6bChVloKNlq/cS6SJ+ZABobh3JrKegS6PkPROPpwPOVADyBGYmStUkn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi5FWY4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi5FWY4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434BE1F000E9;
	Sun, 24 May 2026 04:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779595494;
	bh=6wrt/z63eU/rVxYGGbWUM8fdyAu++NALzhu9h08buUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yi5FWY4y2/oIXK6Fmj14sGudIDBMcTecwZEbiFM0PKWWeyqkCAyRTc/VkzhTOZzya
	 zNDoLIsHhwAY3eZ9LyYGLvo8pVrjgo61V1SfcD9lPC+hNEx36OBxof3hVysdRkOvvW
	 G2TnVy7LMMa8SbcpCa7Mpo0HNCjYD5xzcBZMTct2XoWEmtJ7QY3xtUY9duU2C/Z9po
	 9r187fDM/WcYSmUoaFNazHLq/NQ5kDjRq9kZloePHm18ZO2a4TJ6xa5C0shWuVxnr1
	 IhqE+fmfph3xnyIYu2rZllaoFG4Mf62WDsyyKleB53neg4Cm85Onufcv97/QUaZrgX
	 EQZV3eCaLG/gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/29] perf cpumap: Reject RANGE_CPUS with start_cpu >
 end_cpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-14-acme@kernel.org>
References: <20260524032709.1080771-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:04:53 +0000
Message-Id: <20260524040454.434BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to fix a TOCTOU vulnerability by using READ_ONC=
E() to snapshot array lengths (`nr` and `mask_nr`), but fails to validate t=
hese snapshotted values against the event payload size. This allows a malic=
ious FUSE-backed file to bypass upstream validation and trigger severe out-=
of-bounds reads into memory-mapped data.
--

commit bcd1cf5db2746962453dca0e2d28fab14111bfc9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu

This commit adds boundary checks to cpu_map__from_range() to reject
inverted ranges and clamps any_cpu to a boolean. It also hardens
cpu_map__from_mask() to reject unsupported long_size values and snapshots
mmap'd fields using READ_ONCE() to prevent TOCTOU vulnerabilities.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 11922e1ded844..b1e5c29c6e3ec 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
[ ... ]
> @@ -64,24 +66,27 @@ static void perf_record_cpu_map_data__read_one_mask(c=
onst struct perf_record_cpu
>  }
>  static struct perf_cpu_map *cpu_map__from_entries(const struct perf_reco=
rd_cpu_map_data *data)
>  {
> +	/* Snapshot nr =E2=80=94 data is mmap'd and could change between reads =
*/
> +	u16 nr =3D READ_ONCE(data->cpus_data.nr);

[Severity: High]
This is a pre-existing issue, but while we are snapshotting nr to prevent
time-of-check to time-of-use re-reads, do we also need to validate the
snapshotted value against the event payload size?

If the underlying file is on a FUSE mount, could an attacker pass the
initial upstream validation in session.c, and then maliciously increase
the value before this READ_ONCE() is executed?

Since the snapshotted nr is used as the loop bound below, could this lead
to severe out-of-bounds reads into memory-mapped data?

>  	struct perf_cpu_map *map;
> =20
> -	map =3D perf_cpu_map__empty_new(data->cpus_data.nr);
> +	map =3D perf_cpu_map__empty_new(nr);
[ ... ]
> @@ -93,11 +98,21 @@ static struct perf_cpu_map *cpu_map__from_entries(con=
st struct perf_record_cpu_m
>  static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_=
cpu_map_data *data)
>  {
[ ... ]
> +	mask_nr =3D READ_ONCE(data->mask32_data.nr);
> =20
>  	for (int i =3D 0; i < mask_nr; i++) {

[Severity: High]
This isn't a bug introduced by this patch, but a similar question applies
here.

Is it possible for the snapshotted mask_nr to exceed the actual event size
if it gets modified after the initial event validation?

Does this need a check against the event payload limit before we iterate?

> -		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
> +		perf_record_cpu_map_data__read_one_mask(data, i, local_copy, long_size=
);
>  		weight +=3D bitmap_weight(local_copy, 64);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D13
