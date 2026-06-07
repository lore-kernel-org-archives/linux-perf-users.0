Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B132B13F
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875987; cv=none; b=oO81fBfiV+F+/MPI8ssO6y8J1t82FVCgJ/lozehljmsfWtkpqJN3JkR5yn+vIzPXPZw+AqXoM561m9mRWwNPqInOihRQSGD1SlJ/RMyM1fPFTwLU/E9n/xWdi8HVeupk8WlW1x8bxbAbIT59fFlaCBJW9cBcc/OzNlRaS1wR2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875987; c=relaxed/simple;
	bh=9TtHuH8hF2zcuU4j7fE+dDaqayHMSQn8XDnvjMUYQJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfIOIA+/S+HzNgBANQbGza+JkrKqywThOvh5oUhnvlsE5IM6fOpJoHqZ9dpJ/IAvOJk2j3rjvNCa1MnVxFGnJLSzrxKy3Yl9fhv9PrAaoog4cedDXLMYdqgLU6oB1nVk11769ZxKYjKI0lmvHNSB1SNAlzIkjy2oxuEjUstLL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK8RFYQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK8RFYQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418F51F00893;
	Sun,  7 Jun 2026 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875986;
	bh=gOz+3WQCQIDls78HXDtKN2blTSWxOtpst2gddDzbTDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FK8RFYQ+KhaFMVNW+aP9F8fWss4SVvwA4W+h8oimMqKeELaHzkGkVj2AB0/6hwvBm
	 rIWCQNsOHZ6SHXmvlYmQXjCwRdTOvm472c1mgs8ZYkfAXgfvNOBCdg4Kmq6ca2+lKf
	 D2GfKAASstBRbBG+J81uchl0hf086MxXh5eeUl1a7DBD8Z5hUGRNFWYcyFDNt8ZHeD
	 6r7y9kX1u9Sxty0xLH/omlLjt5H96b7asLxS0Pr4pWzOGw8yaf46pkem1hdW6QBpHn
	 Q73CtGYVXt1ntXTmN9LWGEZJ/f1N8fLsunaDmkXwkps5n9e3l+CEKGUuuAVPVms4ei
	 56udIH9FB9biA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] perf bpf: Use scnprintf() in snprintf_hex() and
 synthesize_bpf_prog_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607232925.1935819-10-acme@kernel.org>
References: <20260607232925.1935819-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 23:46:25 +0000
Message-Id: <20260607234626.418F51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Buffer overflow in `hwmon_pmu__for_each_event` due to unsafe `=
snprintf` accumulation.
- [Critical] Buffer overflow in `perf_pmu__for_each_event` due to unsafe `s=
nprintf` accumulation.
- [Medium] Missing validation for `btf__type_by_id()` return value in `synt=
hesize_bpf_prog_name` leads to a NULL pointer dereference.
- [Medium] Missing bounds checking when accessing BPF function info and pro=
gram tags allows out-of-bounds memory reads.
- [Medium] Leaked `map.btf` and `map.rodata` in `bpf_metadata_create()` on =
error path.
- [Medium] Leaked `info_node->metadata` when `perf_env__insert_bpf_prog_inf=
o` fails in `perf_env__add_bpf_info()`.
--

commit 36b9c4933bfd61cb63ed28852ac600bdb93eebb7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()

This commit fixes buffer overflows by switching from snprintf() to scnprint=
f()
when accumulating formatted strings. This prevents writing past the end of
the buffer if truncation previously occurred.

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

While reviewing this function, I noticed a couple of pre-existing issues
just below this diff hunk:

tools/perf/util/bpf-event.c:synthesize_bpf_prog_name() {
        if (btf) {
                finfo =3D func_infos + sub_id * info->func_info_rec_size;
                t =3D btf__type_by_id(btf, finfo->type_id);
                short_name =3D btf__name_by_offset(btf, t->name_off);
...

[Severity: Medium]
This isn't a bug introduced by this patch, but does calculating the finfo
pointer using the unvalidated info->func_info_rec_size from the untrusted
perf.data file allow out-of-bounds memory reads?

[Severity: Medium]
This is a pre-existing issue, but btf__type_by_id() can return NULL if
finfo->type_id is invalid or out of bounds. Will accessing t->name_off
immediately after cause a NULL pointer dereference here?


Additionally, I noticed a few other pre-existing issues in the perf tools
codebase during this review:

tools/perf/util/bpf-event.c:bpf_metadata_create() {
...
        metadata =3D bpf_metadata_alloc(info->nr_prog_tags, map.num_vars);
        if (!metadata)
                continue;
...

[Severity: Medium]
This isn't a bug introduced by this patch, but does this error path
permanently leak the memory allocated for map.btf and map.rodata by
skipping the bpf_metadata_free_map_data() cleanup?


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

[Severity: Medium]
This is a pre-existing issue, but does freeing info_node here without freei=
ng
info_node->metadata leak the dynamically allocated metadata?


tools/perf/util/hwmon_pmu.c:hwmon_pmu__for_each_event() {
...
        len +=3D hwmon_pmu__describe_items(hwm, desc_buf + len, sizeof(desc=
_buf) - len,
                                         key, value->items, /*is_alarm=3D*/=
false);
...

[Severity: Critical]
This isn't a bug introduced by this patch, but it is a similar issue to the
ones being fixed.

Does accumulating the length from snprintf() without checking for truncation
cause sizeof(desc_buf) - len to wrap to a huge value, leading to a stack
buffer overflow in subsequent calls?=20

Note that this issue was not fixed by the later patches in the series.


tools/perf/util/pmu.c:perf_pmu__for_each_event() {
...
        buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
                        "%.*s/%s/", (int)pmu_name_len, info.pmu_name, event=
->terms) + 1;
...

[Severity: Critical]
This is a pre-existing issue, but does accumulating the return value of
snprintf() into buf_used risk truncation wrapping?=20

If buf_used exceeds sizeof(buf), sizeof(buf) - buf_used underflows, leading
to a stack buffer overflow on the next write.=20

Note that this issue was also not fixed by the later patches in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607232925.1935=
819-1-acme@kernel.org?part=3D9
