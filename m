Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569495;
	b=vRZPxrlCS7XNS/p6WKVqVNu9adMhBKEHJJMmBaJ70fnNjwLq7tAaTFYel12pLlKZVHx8
	 ML1dNxBYbZn/cbMZ6yNamr25A6WUeRFNWsRTMEh79CLDLQ3Grm3/nzpHQtvx05J9Y4ThB
	 +CaM//3HpcT1N/SzHcgu81xVeLSMCCDFYlX0hCYmy8yJONDznjvEIGimsf46RpKX7gE3B
	 DL7xZwAc7oza4d/NN8m3TL0DCkNn5YRO2LoBkJYYUl3H9ZLovgq+dMcQ6gIx/xmhuCYow
	 0o7xWewdSWyn1r12ShXBrA/bpGka1G5Z0gYXsBPoSmQxcP61KBGL0dnJv5YqkKFD2xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EzzL6ML2/SNsmeB6+Pz/Z7bmJjdvfo8HB7U/Vy8xZSM=;
	b=U4RmetBOg8t0pcN5uOtemMT4y8UoGU5ACGUto9M0Ub7FFpHM2jCw+51Y/8W0YFE9D6TQ
	 kY+Op3rAbJVJkB0yT1fNgbBS6JRuU5/G6Mru9hXSm6q1/WLbeIpWHx7k1IgWB/TYBQyo4
	 xNUpw4E57OqUtXtA/FsvPrNZDGQk2609gUNaR2+HqjoORhQLnTh7f5vmT8kws+KBSeS9f
	 7ppukIZyEwrJE2upsucQdAhd99faPC4cY/bhI7ZmWDiEzZ+cTMo4y2wOWDcJUUtUchM5a
	 bZCc56wojeAQ1237MsHr68tzz/ogDubjDS5X2lvZhagucenMNzY1NBHAzfmQ2KrWn+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctCeNOQ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D6606A31E;
	Wed, 25 Nov 2026 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctCeNOQ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384DA1F000C6;
	Wed, 25 Nov 2026 01:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569495;
	bh=EzzL6ML2/SNsmeB6+Pz/Z7bmJjdvfo8HB7U/Vy8xZSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctCeNOQ2eWmNVU+B8yVeuo6UhjqXGxiZUXax3LDbauIeX3KOidFjmSnwy9ZT5+oK8
	 iKa2tri+9Vk1O4o4HK6g3ONKJ/44NlUWAl5W0LMeQAj/Z+PcSQGUnlaFbQcw5o9snf
	 tOwBbOjbxqEwREMxziKxEbVdTwTq3zfsQ/1Oeg3cESXc6zzd7FJH9NjEEQEtR6G1G+
	 hCdjlsagqMQ3R17ddMxqfOafXyf6cQTA0IGB5Ga5+O3uAn/mHsExjaWKAT+DPhbrv/
	 WnUrpH987P+oNxh+iycczR/rbClkUVmtV+++O5WQ4OZZpcEDUvu0vMKJ+TGQcvZi1L
	 f2GYfT96qx8sw==
Message-ID: <sashiko-outbox-232322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/19] perf inject: Add --sample-buildids to convert
 samples to build ID + offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261125005108.1020003-17-irogers@google.com>
References: <20261125005108.1020003-1-irogers@google.com>
 <20261125005108.1020003-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 01:18:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf inject: repeated dso__read_build_id() calls on DSOs
  without build ID
- [Medium] perf inject: redundant O(K*M) build-ID map scans in
  inject_bid_offset_tool__sample()
--

commit 2bebd91f8b6cc5fc073599d5f9ff18fadcfbd15b
Author: Ian Rogers <irogers@google.com>

perf inject: Add --sample-buildids to convert samples to build ID + offset

This commit adds the --sample-buildids (-S) option to perf inject to drop
user-space MMAP events and rewrite sample IPs and callchains into build
IDs and file offsets.

> diff --git a/tools/perf/util/inject_bid_offset.c b/tools/perf/util/inject=
_bid_offset.c
> new file mode 100644
> index 0000000000000..c6f80f2a95321
> --- /dev/null
> +++ b/tools/perf/util/inject_bid_offset.c

[ ... ]

> +static void perf_event__inject_sample_buildid_array(struct thread *threa=
d,
> +						    u64 ip, u8 cpumode,
> +						    __u64 *array)
> +{
> +	struct perf_build_id bid =3D { .size =3D 0 };
> +	u64 offset =3D ip;
> +	struct addr_location al;
> +	struct dso *dso;
> +	const struct build_id *dso_bid;
> +
> +	struct perf_sample ps =3D { .ip =3D ip, .cpumode =3D cpumode };
> +
> +	addr_location__init(&al);
> +
> +	if (!thread ||
> +	    (cpumode !=3D PERF_RECORD_MISC_USER &&
> +	     cpumode !=3D PERF_RECORD_MISC_GUEST_USER))
> +		goto write_bid;
> +
> +	if (!thread__find_map(thread, &ps, &al))
> +		goto write_bid;
> +
> +	dso =3D al.map ? dso__get(map__dso(al.map)) : NULL;
> +	if (!dso)
> +		goto write_bid;
> +	if (!dso__has_build_id(dso))
> +		dso__read_build_id(dso);
> +	dso_bid =3D dso__bid(dso);
> +	if (!dso_bid || dso_bid->size =3D=3D 0 ||
> +	    map__mapping_type(al.map) !=3D MAPPING_TYPE__DSO) {
> +		dso__put(dso);
> +		goto write_bid;
> +	}

[Severity: Medium]
Does calling dso__read_build_id() here cause repeated filesystem open()
and mount-namespace setns() syscalls on every sample IP and callchain
frame that hits a DSO without a build ID?

Both inject_bid_offset_tool__sample() and
inject_bid_offset_tool__callchain_deferred() already call mark_dso_hit()
first, which attempts dso__read_build_id() once per DSO tracked in
ibo->synthesized_dsos.  When a mapping has no build ID (such as an
anonymous mapping or a binary built without a build ID),
dso__has_build_id() stays false, so this check re-runs
dso__read_build_id() on every hit, even before checking
map__mapping_type(al.map) !=3D MAPPING_TYPE__DSO.

[ ... ]

> +	ev->sample.header.size =3D (u16)(out - (u8 *)ev);
> +
> +	orig_sample_size =3D evsel->sample_size;
> +	if (perf_event__rewrite_attr_for_build_id_offset(&evsel->core.attr)) {
> +		ret =3D -EFAULT;
> +		goto out_put;
> +	}
> +	evsel->sample_size =3D __evsel__sample_size(evsel->core.attr.sample_typ=
e);
> +	perf_sample__init(&new_sample, /*all=3D*/true);
> +	ret =3D __evsel__parse_sample(evsel, ev, &new_sample, /*needs_swap=3D*/=
false);
> +	if (!ret) {
> +		new_sample.evsel =3D evsel;
> +		ret =3D ibo->tool.delegate->sample(ibo->tool.delegate, ev,
> +						 &new_sample, machine);
> +	}

[Severity: Medium]
Does delegating the rewritten sample to perf_event__repipe_sample() trigger
redundant build-ID map scans via build_id__mark_dso_hit()?

mark_dso_hit() has already resolved the virtual addresses by binary search
and marked the hit DSOs.  Passing new_sample to perf_event__repipe_sample()
runs build_id__mark_dso_hit() on the converted BUILD_ID_OFFSET sample,
which resolves the sample IP and every callchain frame through
maps__find_by_build_id(), performing a linear scan across all thread
mappings for each frame just to mark the same DSOs hit again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125005108.1020=
003-1-irogers@google.com?part=3D16
