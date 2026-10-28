Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211724;
	b=H42r4PXbJcLBcOBMXR0+4w94hlvH3+bSiW7g1Sa5zPCm9h/zJCWE/fw6TvrabhqF3hZP
	 wNu+w4ZDbpBa/8B+PAQxWdvO49HPMnW100EUd+Vgn62SWe85xUcCTqK9ZBQIN/wzx5Fhp
	 /zRTWbZydMe8COocc9yfHPvK0ikgB0IXGO9dpU6EriNt4bJ+8u/8cLxomvrI0kB6f68zv
	 hCEcx3hD8kwskwhafiDHauf+X7LSs/7q4euTzEZI6dN2IvrlGmOKnm62K+NFSM44NqDnu
	 gF/K9f9BkTZiOq+RnzLO8iFb9Pt3ZMNxHxgcOMYp5EWsG+ASBnaPbpiUlvQUMiUwdQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211724;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fzZ5/pxwnA/44iySuYyO0anoTiZGXF5ODEy0IhAZNXM=;
	b=Zzzf8d77brUrkYc1xssPjUbb4qz9h5fDzmEv1dGKmRSWTQ/pOhYU949BbhSadBioHuDb
	 p2DmWKzoKjLeV2EI2YgT9rq4DdXAKpYt4zY7clwiCTtKscThhfYBvaCDes1UDNyzF83+9
	 cBVRggBbqArC+zH0zR3NRp4rauCyzDd+eymqW007GdxWvUhAR0Zz+z0P13mjfG35sec0d
	 2oWNbAJE8dokWLIYmXxK5g9RztWC/nMpyvMwIBNdsuSwYmYiKgR5C5PU5j01RAfKcBIP9
	 YpVCs/ZtpijpgAKQIWtzDKaN4JkljmuF2fGa7a3RQAEF7l8vWOyMJa+da+fP8xr1sGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jt0Our6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397C60A5BE3
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jt0Our6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936301F01828;
	Wed, 28 Oct 2026 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211723;
	bh=fzZ5/pxwnA/44iySuYyO0anoTiZGXF5ODEy0IhAZNXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jt0Our6FXpcawditvkhvzZpRcA5sfvj0hkzxNLzPdDvJX9ALdrW11dnfuikO9zFFi
	 4AxK8D24E1EmUw5boQAqcmEH6P6X94CkialeQe18EwWwaLSI2MA0S6loat4WE4XG/e
	 kUMdLnooG2UPQE5qnRvJQWnHHY8+byaWZNFupyu/7r3Raj60YmiaGlstzqlCmYpnl3
	 fjYwL7DZPyeqW/iW/0qxCtmDm+OMCSxbPLTGKiADTprwfWMSCdYBwCG7m8bLcSwHRv
	 UsXlB5c9vmt1kiduA5vSKhyp/2hV5oZS0IGUPP+08qrTiO6WOjRKANKroRlA3r/2oG
	 vjWKIoc+40GWw==
Message-ID: <sashiko-outbox-188276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf alpha: Decode ProfileMe raw samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-perf-alpha-profileme-v1-1-f46c1938d001@gmail.com>
References: <20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com>
 <20261028-perf-alpha-profileme-v1-1-f46c1938d001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:22:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf alpha: unaligned 64-bit loads in evlist__alpha_sample_raw()
- [Medium] perf alpha: missing endianness conversion in evlist__alpha_sampl=
e_raw()
--

commit 4908934f82190e0ae8b17e86168bc2a37ca70554
Author: Matt Turner <mattst88@gmail.com>

perf alpha: Decode ProfileMe raw samples

This commit adds decoding support for Alpha ProfileMe PERF_SAMPLE_RAW
payloads in perf report -D and perf script -D, along with a copy of the
uapi asm/perf_event.h header defining struct alpha_profileme_sample.

> diff --git a/tools/arch/alpha/include/uapi/asm/perf_event.h b/tools/arch/=
alpha/include/uapi/asm/perf_event.h
> new file mode 100644
> index 0000000000000..0cb7d6f3cb154
> --- /dev/null
> +++ b/tools/arch/alpha/include/uapi/asm/perf_event.h
> @@ -0,0 +1,27 @@

[ ... ]

> +#define ALPHA_PROFILEME_SAMPLE_VERSION	1
> +
> +struct alpha_profileme_sample {
> +	__u32 version;
> +	__u32 reserved;
> +	__u64 pmpc;
> +	__u64 i_stat;
> +	__u64 pctr_ctl;
> +};
> +
> +#endif /* _UAPI_ASM_ALPHA_PERF_EVENT_H */

[ ... ]

> diff --git a/tools/perf/util/alpha-sample-raw.c b/tools/perf/util/alpha-s=
ample-raw.c
> new file mode 100644
> index 0000000000000..22cf95be93e31
> --- /dev/null
> +++ b/tools/perf/util/alpha-sample-raw.c
> @@ -0,0 +1,133 @@

[ ... ]

> +static bool is_profileme_sample(struct evlist *evlist, union perf_event =
*event,
> +				struct perf_sample *sample)
> +{
> +	const struct alpha_profileme_sample *pm =3D sample->raw_data;
> +	struct evsel *evsel;
> +
> +	if (sample->raw_size < sizeof(*pm))
> +		return false;
> +
> +	evsel =3D evlist__event2evsel(evlist, event);
> +	if (!evsel)
> +		return false;
> +	if (evsel->core.attr.type !=3D PERF_TYPE_HARDWARE &&
> +	    evsel->core.attr.type !=3D PERF_TYPE_RAW)
> +		return false;
> +
> +	return pm->version >=3D ALPHA_PROFILEME_SAMPLE_VERSION;
> +}

[Severity: Medium]
When inspecting an Alpha perf.data file on a big-endian host (such as s390x
or big-endian PowerPC), will reading pm->version in is_profileme_sample()
and pm->i_stat, pm->pctr_ctl, and pm->pmpc in evlist__alpha_sample_raw()
interpret the little-endian fields in host byte order?

In tools/perf/util/evsel.c, __evsel__parse_sample() undoes the 64-bit byte
swap on the PERF_SAMPLE_RAW payload when swapped is true:

	if (swapped) {
		/* mem_bswap_64() accesses complete 64-bit words. */
		sz =3D roundup((u64)data->raw_size, sizeof(u64));
		OVERFLOW_CHECK(raw, sz, max_size);
		mem_bswap_64((void *)raw, data->raw_size);
	}
	data->raw_data =3D (void *)array;

Because sample->raw_data remains in the recorded architecture's little-endi=
an
byte order, on a big-endian host a version of 1 (0x00000001) is read as
0x01000000 (passing the >=3D ALPHA_PROFILEME_SAMPLE_VERSION check), and the
register values and bitfields in evlist__alpha_sample_raw() are decoded with
reversed bytes.

Should these fields be converted with le32_to_cpu() and le64_to_cpu(),
similar to how tools/perf/util/s390-sample-raw.c uses be16_to_cpu(),
be32_to_cpu(), and be64_to_cpu()?

> +
> +void evlist__alpha_sample_raw(struct evlist *evlist, union perf_event *e=
vent,
> +			      struct perf_sample *sample)
> +{
> +	const struct alpha_profileme_sample *pm;
> +	unsigned long long i_stat, ctl, pmpc;
> +
> +	if (event->header.type !=3D PERF_RECORD_SAMPLE ||
> +	    !is_profileme_sample(evlist, event, sample))
> +		return;
> +
> +	pm =3D sample->raw_data;
> +	i_stat =3D pm->i_stat;
> +	ctl =3D pm->pctr_ctl;
> +	pmpc =3D pm->pmpc;

[Severity: Medium]
Does casting sample->raw_data to struct alpha_profileme_sample * in
is_profileme_sample() and evlist__alpha_sample_raw() perform misaligned
64-bit loads on pm->i_stat, pm->pctr_ctl, and pm->pmpc?

In PERF_RECORD_SAMPLE events, all fields preceding PERF_SAMPLE_RAW are
multiples of sizeof(u64), and __evsel__parse_sample() in
tools/perf/util/evsel.c advances past the 32-bit raw_size header:

	data->raw_size =3D *array;
	array =3D (void *)array + sizeof(u32);
	...
	data->raw_data =3D (void *)array;

This leaves sample->raw_data at a 4-byte offset from an 8-byte boundary (as
noted in struct perf_sample in tools/perf/util/sample.h). Because struct
alpha_profileme_sample starts with two __u32 fields (version and reserved,
8 bytes total), its __u64 fields (pmpc, i_stat, and pctr_ctl) sit at struct
offsets 8, 16, and 24, landing on 4-byte-aligned addresses rather than
8-byte-aligned addresses in the sample buffer.

Dereferencing those 64-bit fields directly triggers hardware unaligned acce=
ss
traps on every sample when running natively on Alpha, and causes a SIGBUS on
strict-alignment 64-bit hosts when cross-analyzing a perf.data file (in
addition to requiring 4 bytes of trailing padding per sample in the ring
buffer since sizeof(u32) + sizeof(struct alpha_profileme_sample) is 36
bytes).

Could evlist__alpha_sample_raw() copy sample->raw_data via memcpy() or use
unaligned accessors, or should struct alpha_profileme_sample account for the
4-byte PERF_SAMPLE_RAW size prefix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-perf-alpha=
-profileme-v1-0-f46c1938d001@gmail.com?part=3D1
