Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374F3A9D8C
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577786; cv=none; b=hCNqAZLkdubsgqtP7+ux0ANoxPkPVsA9NDoxntCxHrPZotBWT4cHl20DYaUl452MTEfy658Co+TgZgNdXE9tg+D8ULjZjqLbxaaTxX0mLw174XAulpwZywwTrYuFFPn28+m6lWhlb1hXIKlTKD8Jc9FE1w7cvKpgT7Sxb/uUvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577786; c=relaxed/simple;
	bh=7q9M13J0DpGElgicznzAwWL6yAgPM4Fwb/Ck1VHrIu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z3WuFvyx4NnNkbpq0Nf58Z+dUKcPNuB23ZqeAMl/8VB8muuAEhgZGbGB7HPATe3R5QebWiV2/fQqKUEwT3GqqY/BrvVS7K+lIM+LkO6twfOPvhwqjfKJLyVeUnpkUAgh4UGNr7toTSSk4OG9l4IZjtfMo/2RawhstoRVTZFP+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsSWFtjw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsSWFtjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924261F000E9;
	Tue, 16 Jun 2026 02:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577785;
	bh=sI49DsP3gk/FKzQl/+eMFG+ikhjrxoWhBgvJnM9Idwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsSWFtjwlnDtfAYb0zJKZd18sV3FmBMUOgEYps4GeQ/gUMm5fbFMaFL+eRXkMIDi3
	 HiVWvt1PbdZtWB6nUv1sFscnZJO/7wNMjWKzCrjlmqL1L0nWeWdN/KIc52szuuMrNI
	 iPgpPhv40QpaRnYy+aWJlctcc/WI0QzwF+cDwbtDRSS3phLWV0hYaKQcot3hIdyu6X
	 72MlW4Z9Mrti027DDdGnQGPeavu2wmqaBW/t5Sq63eUEzadUVkK/NNLUaU8emYwaH/
	 BGzUpl22k5Ys7gQytWzjbZZnhDuRda4vUtgIq8gM1vFyGtkSrcu2cGNKZ1E/k1x7/G
	 Of7fFUaWDIxBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] perf cs-etm: Require full global header in
 auxtrace_info size check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616022715.5739-5-acme@kernel.org>
References: <20260616022715.5739-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:43:05 +0000
Message-Id: <20260616024305.924261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Unbounded memory accesses during per-CPU metadata parsing and pr=
inting allow out-of-bounds reads on maliciously crafted perf.data files.
--

commit bac918b1be09ad8eb36712cc82561391a2657983
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Require full global header in auxtrace_info size check

cs_etm__process_auxtrace_info() checks that header.size covers
event_header_size + INFO_HEADER_SIZE (16 bytes total), but then
accesses ptr[CS_PMU_TYPE_CPUS] at offset 24 from the start of the
event.  A crafted 16-byte auxtrace_info event passes the size check
but reads out-of-bounds.

Include CS_ETM_HEADER_SIZE in the minimum size check so that the
global header entries (version, pmu_type_cpus, snapshot) are
guaranteed to fit within the event.

> diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
> index 4abe416e3febd..aebef71d3a0a1 100644
> --- a/tools/perf/util/cs-etm-base.c
> +++ b/tools/perf/util/cs-etm-base.c
> @@ -170,7 +170,9 @@ int cs_etm__process_auxtrace_info(union perf_event *e=
vent,
>  	u64 *ptr =3D NULL;
>  	u64 hdr_version;
> =20
> -	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE))
> +	/* Ensure priv[] is large enough for the global header entries */
> +	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE +
> +					  CS_ETM_HEADER_SIZE))
>  		return -EINVAL;

[ ... ]

>  	if (dump_trace) {
>  		num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>  		cs_etm__print_auxtrace_info(ptr, num_cpu);
>  	}
> =20
>  	return cs_etm__process_auxtrace_info_full(event, session);
>  }

[Severity: Medium]
This is a pre-existing issue, but does this still leave an out-of-bounds re=
ad
if the event size only covers the global header, and the parsed num_cpu val=
ue
requires more data?

Looking at the dump_trace path above, cs_etm__print_auxtrace_info() uses=20
num_cpu as a loop boundary:

tools/perf/util/cs-etm-base.c:cs_etm__print_auxtrace_info() {
        ...
        for (i =3D CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
                ...
}

Could this read and print memory out of bounds if the remaining event size
isn't checked to ensure it contains all the variable-length per-CPU=20
parameters?

Additionally, in cs_etm__process_auxtrace_info_full(), num_cpu is checked=20
against the total size:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
        ...
        if (num_cpu > priv_size / (int)sizeof(u64))
                return -EINVAL;
        ...
}

Does this check only guarantee a single 64-bit word per CPU? If=20
cs_etm__create_meta_blk() later consumes multiple words per CPU and=20
dynamically advances the stream offset based on untrusted payload counts li=
ke=20
nr_in_params, could this also result in reading past the end of the event=20
payload before the final size match validation catches it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022715.5739=
-1-acme@kernel.org?part=3D4
