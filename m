Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B3145355
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111924; cv=none; b=qCqCGUK3U54KBiLGw5gYesvBMltHqbntXBEXxmp9LCJJ/IF0hEJtcoK99rx0g2tf/JZsqowmtevw55fRqcuU5EXwVwyLBPMqMm76BIyu3KuM+hmavFrVYR8slWtcxcw6NiDaSBiAsu4ZiAm2th2TDHm9ql2RQU0/BmRtJ2bxSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111924; c=relaxed/simple;
	bh=7FlrQV27nwMEgW47jqmu7FUz85/Qc5X6yLv7sh6GhWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IS41dm6A+v2dcjoWvw27MZI6tmexQWcvCoPX/TAesQ5h2nVScJhIVTzuOkF17wkkS00FtzRbjOgVUSshCRu6Vzw26jb1Ce9HOl2Wx12cTxcRJbwxkHNwfnbUGZVKEhjpD5lmnaamJ/u1sgWEQrYFQNlOcW3fakLHZ9vyI175Fq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFEj/g6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFEj/g6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F441F00893;
	Wed, 10 Jun 2026 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111922;
	bh=+ccuW1iIfL2C9ip2orTNF8wOoVGUMbezpFTOFjm2FZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HFEj/g6pGROJXqSzZ63GYgdoHV4DMh3auNxlRjId4Jg8FelsSMOmcq0rIu267L45X
	 tWg4B0FrCzHRCUYLqVQAleonmxdCZHWIqaUFax53t//+QoFX05JRbhKNAr6KUyXgq7
	 c4yBBWo84W8MPDF8VQ+2Rv8g+CRpQuWQSZULGuoyWepdIW9a6aOU+9dBfM8p7orEL3
	 hKn0LPRX1O5pAxaMJQyLGFwVa6d1+CzA2xZgsOMX7DGobNA4Sjzm6NGfrz99yYADE1
	 i+9TLY/RFeKtUc2P66g0SACGShp1ec3dbZxDVSje7YIOYNYUvkgJdMzKO3cA9a//rg
	 dsSFTIkxppyZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] perf bpf: Use scnprintf() in snprintf_hex() and
 synthesize_bpf_prog_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610165207.2077258-9-acme@kernel.org>
References: <20260610165207.2077258-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:18:42 +0000
Message-Id: <20260610171842.87F441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check for the result of `btf__type_by_id()` in `synth=
esize_bpf_prog_name` leading to a potential NULL pointer dereference.
- [High] The `synthesize_bpf_prog_name` function dereferences `func_infos` =
unconditionally if a BTF object is present, even if the BPF program does no=
t have function info.
- [High] Unsafe use of snprintf in length accumulation sequences leads to s=
ize_t underflow and stack buffer overflows in `perf_pmu__for_each_event`.
- [High] The `bpil_offs_to_addr` function translates offsets to addresses w=
ithout bounds checking, allowing out-of-bounds reads from malicious perf.da=
ta files.
- [Medium] Leaked `info_node->metadata` on the error path where `perf_env__=
insert_bpf_prog_info` fails.
- [Medium] Leaked BTF and rodata objects in `bpf_metadata_create` when `bpf=
_metadata_alloc` fails.
--

commit 7fa567954fb3de5f92865c25d5e803bee0ef956a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()

Both functions accumulate formatted output via snprintf. This patch switches
them to scnprintf() to prevent buffer size underflows and write overruns
when accumulating the output length.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index a27945c279efb..2c09842469f1f 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c

[ ... ]

> @@ -140,7 +140,7 @@ static int synthesize_bpf_prog_name(char *buf, int si=
ze,
>  	const struct btf_type *t;
>  	int name_len;
> =20
> -	name_len =3D snprintf(buf, size, "bpf_prog_");
> +	name_len =3D scnprintf(buf, size, "bpf_prog_");
>  	name_len +=3D snprintf_hex(buf + name_len, size - name_len,
>  				 prog_tags[sub_id], BPF_TAG_SIZE);
>  	if (btf) {
> @@ -153,9 +153,10 @@ static int synthesize_bpf_prog_name(char *buf, int s=
ize,
>  			short_name =3D info->name;
>  	} else
>  		short_name =3D "F";
> -	if (short_name)
> -		name_len +=3D snprintf(buf + name_len, size - name_len,
> -				     "_%s", short_name);
> +	if (short_name) {
> +		name_len +=3D scnprintf(buf + name_len, size - name_len,
> +				      "_%s", short_name);
> +	}
>  	return name_len;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but could the surrounding code in
synthesize_bpf_prog_name() segfault if a BPF program does not have func_inf=
o?

In synthesize_bpf_prog_name(), if the program lacks function info, func_inf=
os
becomes NULL. However, bpf_metadata_create() can pass the .rodata MAP's BTF,
satisfying the if (btf) check:

tools/perf/util/bpf-event.c:synthesize_bpf_prog_name() {
    ...
    if (btf) {
        finfo =3D func_infos + sub_id * info->func_info_rec_size;
        t =3D btf__type_by_id(btf, finfo->type_id);
        short_name =3D btf__name_by_offset(btf, t->name_off);
    ...
}

Is it possible that finfo evaluates to an offset from NULL, leading to a
segfault when dereferencing finfo->type_id?

[Severity: High]
This is a pre-existing issue, but does btf__type_by_id() guarantee returning
a non-NULL pointer here?

If the provided type_id is out of bounds, t becomes NULL. Would the
immediate dereference of t->name_off then cause a segfault?

While reviewing these formatting string fixes, I noticed a few other
pre-existing regressions in the perf bpf and pmu utilities.

[Severity: High]
This isn't a bug introduced by this patch, but does the length accumulation
in perf_pmu__for_each_event() risk a stack buffer overflow?

tools/perf/util/pmu.c:perf_pmu__for_each_event() {
    ...
    buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
                         "%G%s", event->scale, event->unit) + 1;
    ...
}

If the snprintf output is truncated, buf_used exceeds the buffer size. The
subsequent call uses the remaining size, which would underflow to a large
positive value. Can this cause the next snprintf call to write out of
bounds?

[Severity: Medium]
This is a pre-existing issue, but does the error path in
perf_env__add_bpf_info() leak the metadata object?

tools/perf/util/bpf-event.c:perf_env__add_bpf_info() {
    ...
    if (!perf_env__insert_bpf_prog_info(env, info_node)) {
        pr_debug("%s: duplicate add bpf info request for id %u\n",
                 __func__, btf_id);
        free(info_linear);
        free(info_node);
        goto out;
    }
    ...
}

If perf_env__insert_bpf_prog_info() fails, info_linear and info_node are
freed, but there is no call to bpf_metadata_free(info_node->metadata).
Should the allocated metadata be freed before jumping to the out label?

[Severity: Medium]
This is a pre-existing issue, but does the failure path for
bpf_metadata_alloc() in bpf_metadata_create() leak the map resources?

tools/perf/util/bpf-event.c:bpf_metadata_create() {
    ...
    metadata =3D bpf_metadata_alloc(info->nr_prog_tags, map.num_vars);
    if (!metadata)
        continue;
    ...
}

If bpf_metadata_read_map_data() succeeds earlier in the loop, map.btf and
map.rodata are allocated. If bpf_metadata_alloc() then fails, the loop
continues without calling bpf_metadata_free_map_data(). Should these
resources be cleaned up before continuing the loop?

[Severity: High]
This is a pre-existing issue, but does bpil_offs_to_addr() translate offsets
to addresses without bounds checking?

tools/perf/util/bpf-utils.c:bpil_offs_to_addr() {
    ...
    offs =3D bpf_prog_info_read_offset_u64(&info_linear->info,
                                         desc->array_offset);
    addr =3D offs + ptr_to_u64(info_linear->data);
    bpf_prog_info_set_offset_u64(&info_linear->info,
                                 desc->array_offset, addr);
    ...
}

The untrusted offset from info_linear->info is added to
ptr_to_u64(info_linear->data) to compute addr. If a crafted perf.data file
provides an offset exceeding data_len, could this allow arbitrary
out-of-bounds reads when the perf tool dereferences it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165207.2077=
258-1-acme@kernel.org?part=3D8
