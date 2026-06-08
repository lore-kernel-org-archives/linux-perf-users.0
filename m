Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CA39903A
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951855; cv=none; b=KynBqTof0IEY5E3cZSiqLD/shSEUTt+0pv/E8yYvo/ozdbtCHiV0gzO2BOyu18kwA/6E9cdJJYtHdqDf71z1ghD9gpmXpybi2dwkAe8ftPs9BWrePfTFd7vHAa3tAPnEJ7tDcOAI4A8T4JcPDEfWKsCMka1dsHR4Ms4dM0nKYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951855; c=relaxed/simple;
	bh=myK6xLetDDhxm3ixyyyARIb6UEL9Jq9cPXuFlBTKrrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aVKu7cTF339NveOp6aAqi2HzGI56kPQe+3Z4hBamV3igP9Sn3zFTu8pT0cvt2g6EGh98l/8N227Ac1hRGPxny7UBuszATvuBtPtNM9aiu3uAPnICYRq0JSIVvZjqQ5b3aH51F+WsMf4GJ6pC0ifBD2wmO/co4N77hr7eZWXlOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKtsdVwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKtsdVwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1981F00893;
	Mon,  8 Jun 2026 20:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951854;
	bh=b13pIFJ1xZtyYoC9uydyG7J+FlggJeohHPw2Rb76R14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKtsdVwL/i8aWz4xNo9YYi20FjWuHdvzVbArQ7W0ElM4DS+tyA5VdghEoHt4533AS
	 LgmjOXkcwNIPpr0c1kN0uzEXOwtxI/5J1ye4DKyhtQJavX+3H/6nEa2XL708s6onTN
	 HDEG3tk/zvzP3ufoFejoZYB20G1aHVhRqC52B+HF4CiM9MP47fZoj/GntpgfQMcQh0
	 ioQ/9uSadG7JjrDnn68bOUguU8EbyKQzTjzRNQAe/Y62sHg+mlZZysAMm264Y9BWIZ
	 uiKrF1H/OsF9ZxWOSDUqXNs6H7YqmCNc2E6AeSCbsIqVstI4W1rnI16QWfE2Ek8L/3
	 TyiCHxHg6LBCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] perf bpf: Use scnprintf() in snprintf_hex() and
 synthesize_bpf_prog_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608201753.1979464-9-acme@kernel.org>
References: <20260608201753.1979464-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:50:53 +0000
Message-Id: <20260608205053.ED1981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds and presence validation for `prog_tags` and `fu=
nc_info` array offsets allows arbitrary out-of-bounds reads when parsing un=
trusted `perf.data` files.
--

commit 9c1b3631942199b0637789f3499c7dffed3b90c6
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()
   =20
Both functions accumulate formatted output via ret +=3D snprintf(buf + ret,
size - ret, ...). Switch to scnprintf() which returns the actual number of
bytes written, making the accumulation safe.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
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

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for the
unconditionally dereferenced prog_tags pointer to trigger an out-of-bounds
read when analyzing untrusted perf.data files?

When reading perf.data files, bpil_offs_to_addr() in
tools/perf/util/bpf-utils.c adds an offset read from the file directly to
the heap allocation pointer without bounds checking against data_len:

bpil_offs_to_addr() {
        ...
        offs =3D bpf_prog_info_read_offset_u64(&info_linear->info,
                                             desc->array_offset);
        addr =3D offs + ptr_to_u64(info_linear->data);
        bpf_prog_info_set_offset_u64(&info_linear->info,
                                     desc->array_offset, addr);
        ...
}

If the PERF_BPIL_PROG_TAGS bit is missing from the arrays mask, info->prog_=
tags
remains untranslated and points to whatever attacker-controlled value was
provided in the file.=20

When synthesize_bpf_prog_name() dereferences prog_tags[sub_id], could this=
=20
leak arbitrary memory into the output buffer? Does this require bounds and
presence validation for the prog_tags offset during parsing?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608201753.1979=
464-1-acme@kernel.org?part=3D8
