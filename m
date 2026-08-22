Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4E3A380F;
	Sat, 22 Aug 2026 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392271; cv=none; b=fGRp97KIbVgdCInOjS/rACYWaN+4xXOO3hqDTt4Wt17UNxWMl8IIp/RQTpbyUIjsHVSTbuZZZabZBAo73bmSyr7rxD8ZpLIdpFfrKGBKl16GecZ5mYWPmZd6oeESzWYvk5b7CkrcarWNAu7fj/Y2b6DB5oQrOC6HYHKePx2rIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392271; c=relaxed/simple;
	bh=4FsIAbiCUY6ZkgqXWKMmj+i/hoHHef5lvtXzj0fOu/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PIn4YB9Yf7KD5Ek6l+IeK7gnnhziaN7r8Tgxekvdj9+7X4CjSKNQ9W6UM/oWbFjaoWVWkIYJ9pDgza7vYA7BbPWkVKgqRUgz00F+opu+2Egn87uk/6ummTFqp0p22uDjKmOnXZMSLOtXx+5QNmRBs1BI22JLne9aK9dZi7b0BBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF7JvL9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF7JvL9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0772E1F000E9;
	Sat, 22 Aug 2026 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787392270;
	bh=MUpcs4p4Kuzy9+neYbRaGt6BANtDkKQzYdyCssXXv4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hF7JvL9nmimzXo5rPMIpqcv2fdVLg9j0p7Wr95bPO/m2IszKt9ftLj4D1U0Li846t
	 iZMj2bSFz1U/y1vdcUXZU1XSPoTl44k4MWFx4AexEOhWdpQ9wD6VufTJczrEWdPaw/
	 mERYCcrtStz6db7hujiVMi/3JZjMXDnS2r54rCqwIemA0Ud66LwCSHPbIvz2McjDHj
	 erHlUuXL4vUi94ejgd0+bvywXVdBGNtMLlHDGFL4obMe9BpLCga2ZhpB/zQqnrL+So
	 cM9UixSfAVD9o8d9alDAOvz/R7wxaySwTGJ7xNq0OgNCYNxlD/lP5tZ3nnYfYab5ec
	 Bx/DkBX2HS1zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 12/12] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178739072694.1520941.18132159339101776117.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739072694.1520941.18132159339101776117.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:51:09 +0000
Message-Id: <20260822095110.0772E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] get_offset_of_field() incorrectly evaluates the BTF kflag of the p=
arent struct instead of the nested anonymous struct containing the field, l=
eading to massively inflated offset calculations and bypassing bitfield val=
idation.
- [Low] wprobe_trigger_log_err receives a truncated `glob` string, causing =
syntax error logs to place the caret out-of-bounds and hide the user's inpu=
t.
--

--- Patch [12]: [PATCH v13 12/12] tracing/wprobe: Support BTF struct offset=
 resolution in set_wprobe trigger ---
commit 1da976d66d95af47e154412d3c1b912f8a6b4018
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger
   =20
Allow set_wprobe trigger to use BTF struct offset resolution to specify
the target address field.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index acb15fd018e80..b513561005dc6 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> @@ -990,6 +992,181 @@ static void wprobe_trigger_free(struct event_trigge=
r_data *data)
>  	}
>  }
> =20
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +
> +static int get_offset_of_field(struct btf *btf, const struct btf_type *t=
ype, char *field_name)
> +{
> +	const struct btf_member *field;
> +	int bitoffs =3D 0;
> +	u32 anon_offs;
> +	char *next;
> +
> +	do {
> +		next =3D strchr(field_name, '.');
> +		if (next)
> +			*next++ =3D '\0';
> +
> +		field =3D btf_find_struct_member(btf, type, field_name, &anon_offs);
> +		if (IS_ERR_OR_NULL(field))
> +			return -ENOENT;
> +
> +		if (btf_type_kflag(type)) {

[Severity: High]
Does this code check the kflag of the original parent type instead of the
anonymous struct that actually contains the field?

btf_find_struct_member() can return a field from a nested anonymous struct,
but if the parent struct and the anonymous struct have mismatched BTF kflags
(for example, the parent has kflag=3D0 while the anonymous struct has kflag=
=3D1
because it contains bitfields), using the parent's kflag here will cause
the bitfield size encoded in the upper 8 bits of the offset to be
misinterpreted as part of the byte offset.

This can add a massively inflated value to bitoffs and result in a wild
pointer dereference when the wprobe triggers.

> +			/* Reject bitfield member access */
> +			if (BTF_MEMBER_BITFIELD_SIZE(field->offset))
> +				return -EINVAL;
> +			bitoffs +=3D anon_offs + BTF_MEMBER_BIT_OFFSET(field->offset);
> +		} else {
> +			bitoffs +=3D anon_offs + field->offset;
> +		}
> +
> +		field_name =3D next;
> +		if (next) {
> +			type =3D btf_type_skip_modifiers(btf, field->type, NULL);
> +			if (!type)
> +				return -ENOENT;
> +		}
> +	} while (next);
> +	return bitoffs / BITS_PER_BYTE;
> +}

[ ... ]

> +static int wprobe_trigger_typecast_parse(char **field_str_ptr,
> +					 struct trace_event_file *file,
> +					 struct wprobe_trigger_data *wprobe_data,
> +					 const char *glob)
> +{
> +	struct btf *btf __free(btf_put) =3D NULL;
> +	const struct btf_type *type;
> +	char *assign_field;
> +	char *event_field;
> +	char *type_field;
> +	char *type_name;
> +	char *offs;
> +	long val =3D 0;
> +	int id;
> +	int adjust;
> +
> +	type_name =3D *field_str_ptr + 1;
> +	event_field =3D strchr(type_name, ')');
> +	if (!event_field) {
> +		wprobe_trigger_log_err(file, glob, type_name - glob, DEREF_OPEN_BRACE);

[Severity: Low]
Will this log message place the caret out of bounds and hide the user's
input?

The glob string passed into wprobe_trigger_log_err() seems to be truncated
by an earlier strsep() call replacing the delimiter with a null terminator:

kernel/trace/trace_events_trigger.c:trigger_process_regex() {
    ...
    command =3D strsep(&next, ": \t");
    ...
}

Since glob is truncated to just the command name, calculating the offset as
type_name - glob can point far past the end of the printed text, making the
syntax error logs illegible.

> +		return -EINVAL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D12
