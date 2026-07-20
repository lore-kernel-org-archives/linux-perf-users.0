Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94A345753
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546461; cv=none; b=LF0fP59mk8UM8FiGTMMKq42T69MJPRRR79W9bcBQkgAp/ABGnvp5CprLFTfI6CgUimhkfaJQ1cdDtpdJEFWj/R5/QXfGRTSrNpjzBeyTRl27PvANRsPJdwJ+IrusCLAdw0npmecBByX2AWDvQ+U31tGHepOK0OhPTexnTGhGKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546461; c=relaxed/simple;
	bh=tDwgD2OBDwpU1bE+arAh1o93+EZaHwSCr9tMuQfPuHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Drw3aON6UD35bF+eRB6NnitX407xL8VJ2S7h5jQneUwPSopzThtlIY1HzI48YhnVveUHqmvM9pWQl3FL8pJ1HDNESv4btpcHWxUfQkbovOBcrGNH4iC+f9vqxLUq4xIMb8UQAXT+7z2rgj4Ft8Hcp/dlImjhDOX7kXR9z1vq+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk38EOrE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk38EOrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB20E1F000E9;
	Mon, 20 Jul 2026 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546460;
	bh=TffaWfgTxL5Z31KGGNfboSe5oboB3R7AntW6DVEVDTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gk38EOrEKrAUtcuLdRQPxnXhzD7lp4xvD/kydNHBOX2zgDFOEkxzwIj0tE0cuXbLr
	 H/lKAPg8ti91qzoRhWYqMTI8chkOldPxt0G4edeI+tS5cE/Sdzlm7VEyG29bb1CrO6
	 RfqhJ6fHGe6dgFQQMNhuXuP9WYCmloLu1eIcr0tdRobSfbMVmXPej8F9vJZgY891Qj
	 Picv0Osk1XUwjPXPTzXKux5C8VZMIFzm3YoVQ4PBCkoZ1JfPddXhQjqfqHltwGBl9P
	 UsFOQweFJuQS8FC4XZ2D9iuwIEqXcvzbu0r5jZHZ4SEO1z1Df56lMSjNMIS35tEH0O
	 U6sUu+/hb57qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/6] tools/perf: Add AUXTRACE recording support for
 powerpc HTM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720105218.14277-3-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-3-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:20:59 +0000
Message-Id: <20260720112059.DB20E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized auxtrace_info->type causes perf.data corruption and =
breaks bisectability.
- [High] aux_watermark is set to the full size of the ring buffer, risking =
trace data loss.
--

--- Patch [2]: [PATCH V2 2/6] tools/perf: Add AUXTRACE recording support fo=
r powerpc HTM ---
commit 90e77eef6274098986791263120e8c79ee34c0b9
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add AUXTRACE recording support for powerpc HTM

Adds powerpc perf tool support for HTM PMU AUXTRACE recording. Introduces
htm_recording_init() and related auxtrace callbacks to create
PERF_RECORD_AUXTRACE records for HTM data. Updates auxtrace_record__init()
to detect HTM events.

> diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc=
/util/htm.c
> new file mode 100644
> index 0000000000000..07b496e4be2fb
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/htm.c

[ ... ]

> +static int
> +htm_recording_options(struct auxtrace_record *itr __maybe_unused,
> +		      struct evlist *evlist,
> +		      struct record_opts *opts)
> +{
> +	struct evsel *pos;
> +
> +	opts->full_auxtrace =3D true;
> +
> +	if (!opts->auxtrace_mmap_pages) {
> +		opts->auxtrace_mmap_pages =3D KiB(128) / page_size;
> +		if (opts->mmap_pages =3D=3D UINT_MAX)
> +			opts->mmap_pages =3D KiB(256) / page_size;
> +	}
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (!pos->name || !strstarts(pos->name, "htm"))
> +			continue;
> +		pos->core.attr.aux_watermark =3D
> +			opts->auxtrace_mmap_pages * (size_t)page_size;

[Severity: High]
Does setting the watermark to the full size of the ring buffer risk hardware
trace data loss?

By setting the watermark equal to the entire buffer size, the wakeup only
fires when the buffer is 100% full. Because scheduling the user-space perf
tool and reading the buffer introduces latency, any hardware trace data
generated during this window might be dropped due to a lack of buffer
headroom.

> +		pos->core.attr.freq =3D 0;
> +		pos->core.attr.sample_type |=3D PERF_SAMPLE_RAW;
> +		pos->needs_auxtrace_mmap =3D true;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int
> +htm_info_fill(struct auxtrace_record *itr,
> +	      struct perf_session *session,
> +	      struct perf_record_auxtrace_info *auxtrace_info,
> +	      size_t priv_size)
> +{
> +	struct htm_recording *htm_r =3D container_of(itr, struct htm_recording,=
 itr);
> +	struct evlist *evlist =3D session->evlist;
> +	struct evsel *pos;
> +	int n =3D 0;
> +	int expected_n =3D htm_nr_events(evlist);
> +
> +	if (priv_size !=3D HTM_AUXTRACE_PRIV_SIZE(expected_n))
> +		return -EINVAL;
> +
> +	// To set: auxtrace_info->type
> +	auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] =3D htm_r->evsel->core.attr.t=
ype;

[Severity: High]
Does leaving auxtrace_info->type uninitialized break bisectability by
generating corrupted perf.data files?

Because the type is left uninitialized (defaulting to PERF_AUXTRACE_UNKNOWN)
before the auxtrace info data is written to the stream, this might create
trace files that cannot be read by `perf report` at this commit.

> +	auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] =3D expected_n;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720105218.1427=
7-1-atrajeev@linux.ibm.com?part=3D2
