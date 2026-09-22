Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70641F3B85;
	Tue, 22 Sep 2026 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052212; cv=none; b=sL97AAAhp8wVxBgEOSivrs7l62pQzD4DhBvuBYeLBQqxm3AB0LS9rH1kWmfBTZrJu2gs5Caa3RR6VbOOfAAUJdBpSiGY5UfgHBM58xa/1JG1FaiNnCyMD3g5F/qmaKeBSKmFsP7r4aWW/8LkbNFe9oJAGkERY7f8NHvOqX+mH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052212; c=relaxed/simple;
	bh=p6LiLT4k8KxfHwiOIg8YH2vQC03GDDaEIpIJQj6Hw/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bji662VM06FrWPNxmIZtw8l3DDXSGuu6V59j+iTdcOWoelQ1W94vpmuAEp7S899w4UAA94fFMN8kNP/72XektpYfyokDXk1Ly99L2LHzOBNGdeVFemqyt1yDp1ea+JHng6ZE651b8YCJtTUEpxs9NyniQoaUDNfQobdOHx1p500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDcQbD5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDcQbD5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB901F000FF;
	Tue, 22 Sep 2026 04:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052211;
	bh=l7xbQbSyK+hMJedOeFVJ7HE/nZ7PeG57XNuW6CnoDPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oDcQbD5TYrFIwbRGAlRnmyxYXEtfVaX2reqYkxAXGljtwwigyQQT8L7eOuf+mZKpz
	 5xifdLzJZ6zwRWzQKl7BBcn6KFKbPBp73R3L99efHblyFzPtxX3Y7JFq8Pj1B+RwBn
	 2Tmp+VJ5iRN1/Yx9ZPW4lFNVFgAK9UOXH+b3dYw5vQZ7GPZ5tOLksWbu/astYeqtFF
	 641UIgIhqarxQZlV/lDcMaJcaFNn845ix0QciKsQSjjQe3vHRm4Q2py6vIDFGngMkf
	 EJAILHmCA4LkTWQ1RHqSIIMuKk4Uzb4XVuQMlrMUaiQtkIOf3Khq3SohIPTCy8/9Wn
	 A0l00G657ONQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 13/13] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179005123942.388919.17930857651144049898.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005123942.388919.17930857651144049898.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:43:30 +0000
Message-Id: <20260922044331.1EB901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] trace: incorrect BTF kflag check in get_offset_of_field() allows=
 wild offsets
--

commit 3bc53bf9a42b7270af7bd91985c43e9cafe48496
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger

This commit allows the set_wprobe trigger to use BTF struct offset
resolution to specify the target address field.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index f1d6aa320f213..121310b72522f 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> @@ -1165,6 +1166,213 @@ static void wprobe_trigger_free(struct event_trig=
ger_data *data)
>  	}
>  }
> =20
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +
> +static int get_offset_of_field(struct btf *btf, const struct btf_type *t=
ype, char *field_name)
> +{
> +	const struct btf_member *field;
> +	const struct btf_type *mtype;
> +	int bitoffs =3D 0;
> +	u32 anon_offs;
> +	char *next;
> +
> +	do {
> +		next =3D strchr(field_name, '.');
> +		if (next)
> +			*next++ =3D '\0';
> +
> +		field =3D btf_find_struct_member(btf, type, field_name, &anon_offs, &m=
type);
> +		if (IS_ERR_OR_NULL(field))
> +			return -ENOENT;
> +
> +		if (btf_type_kflag(mtype)) {

[Severity: Medium]
Is it intentional to check btf_type_kflag() on the member type (mtype)
instead of the parent struct type (type)?

If the member's kflag is checked instead of the parent struct's kflag,
bitfield members can bypass the explicit rejection check and compute wildly
incorrect memory offsets. This happens because field->offset contains the
bitfield size in the upper 8 bits when the parent struct's kflag is set.

> +			/* Reject bitfield member access */
> +			if (BTF_MEMBER_BITFIELD_SIZE(field->offset))
> +				return -EINVAL;
> +			bitoffs +=3D anon_offs + BTF_MEMBER_BIT_OFFSET(field->offset);
> +		} else {
> +			bitoffs +=3D anon_offs + field->offset;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D13
