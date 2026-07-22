Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F37440A2B
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763066; cv=none; b=lRld4npnC4bq0fFDudo1gkJ7Wn02e4A1M9tDunDO4bt/vYeYEuy9dTiSfnCAWGmkKyecGAuKibFSxqF4+H6dWiHpZtDwwsfhCYipjErKz8xrdQx03xSGK3DKokyOMCfo4I+AVx+pMgOAgxMgZHBCOAdOxKA3eXHKfDrJ6fxjBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763066; c=relaxed/simple;
	bh=gUkXMxcUXaHXYF3FYZQFCuCX2ZhAwiEIf6u5wpLx5Bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fI5EoWtUeMOSxOBONRq7wCfkiR81qW+hef3H0ZhYXLh56MKnKcHjRTMGHVfmoYbaj1+cMkXTmQsoCp3cQBoYBiC810WUrSHu/sNZU7yc8ibWJLn2hrLkQ1xh98ObWGvUSVJizcW5PiUFwLVqkrlwiBHjr5BAAOOwXlyrwjka1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTB4AVL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTB4AVL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A9E1F00A3A;
	Wed, 22 Jul 2026 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763064;
	bh=aScD+C4T6AyXZPWV1cPEyiq0OQJm2dNJN7x0D7J1V4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FTB4AVL1R7dQK2X7jOY+yYiuEiRArUUaRwIpwxDdFh3Sp7N8RVPM69jjwKnQahAFt
	 OvFNoB/lNjz4iMjtehfcFLoFa9O9jM7VVczcSAJi960aHX3oAy0U0aPYmP43CHLqhK
	 hjLUDt4qUwL7usIzVxB3e3DWsQGcuKhfMP7dcgW3xWsRNYgeVG6McIT+5U9TY3qgIl
	 EkmFzhwQh6w9lB/EniHfSNljg/3r84SEKoQzm2acr4C5uZR2e/mPfDTMMxkSykjDu2
	 MI3SBvOOqCc6tq/MfbrhPuE38CQLdsMF7tumTMUg4WLlvzIqtT86BStUlLDDPLjx/C
	 0MC9L1hLbuIsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/11] tracing/wprobe: Support BTF typecast in
 wprobe trigger command
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178476147632.26117.14371948325944867725.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
 <178476147632.26117.14371948325944867725.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:31:04 +0000
Message-Id: <20260722233104.70A9E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect BTF kflag check in get_offset_of_field() falsely rejects=
 nested structs and computes massive out-of-bounds offsets for bitfield mem=
bers.
--

--- Patch [11]: [PATCH v10 11/11] tracing/wprobe: Support BTF typecast in w=
probe trigger command ---
commit 61f26bb67fea52d49bbb314e0a53092298348830
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Support BTF typecast in wprobe trigger command

This commit extends the set_wprobe trigger syntax to support automatic=20
BTF-based offset calculation. It allows symbolic watchpoint placement at=20
specific struct fields by resolving the offset of a member within a struct=
=20
type using BTF, avoiding the need for manual numeric offsets.

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index 1edfdddf241de..2926eabfe3c1d 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> @@ -925,6 +926,143 @@ static void wprobe_trigger_free(struct event_trigge=
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
> +		type =3D btf_type_by_id(btf, field->type);
> +
> +		/* Reject bitfield member access */
> +		if (btf_type_kflag(type))
> +			return -EINVAL;
> +
> +		/* add offset for anonymous struct type */
> +		bitoffs +=3D anon_offs + field->offset;

[Severity: High]
Does this code in get_offset_of_field() incorrectly check the child member's
type instead of the parent struct?

Because the type variable is updated to the child member's type before
evaluating btf_type_kflag(type), it seems this check will fail to reject
bitfields (since a child type like BTF_KIND_INT doesn't have a kflag).

When a bitfield is not rejected, field->offset (which contains the bitfield
size shifted by 24 bits for structs with kflag=3D1) is directly added to
bitoffs, producing an out-of-bounds byte offset for the watchpoint.

Additionally, could this falsely reject valid accesses if the target member
is a nested struct that does have its kflag set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178476134787.26117.=
10094977293012760490.stgit@devnote2?part=3D11
