Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A21A683E;
	Fri, 25 Sep 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790305208; cv=none; b=iit/RXBej3fZJ+hAA5qzXy1v47tvt/TK3l3jmLWafmXz5W/Kfn1+z/dOlwYo0liARakT1+2xw0OwcMu7OPfykgTr0M0cjNChwmdniS4igtr/gzQgJDaWi83iK7wTYIxYhwiHCuHLS/Q1qo2N2X/Xgh4VllO8FtjABN+k87wdTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790305208; c=relaxed/simple;
	bh=5rmfYaGINJ/VuePjbpT1uaCwRMKMO2sSoGuVdwCS+5s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fIa3xJGMQAq7vZNch3SBl4haNVBJlWzl02YEfwdFrfuvIONB0HAuGA+ro7xaiVTYPX4TpFXbgC+xSW8NaG07t7gtqqELMi2xr/f0Vh72kKfq+kG0q8Trbz4GrJBf8bleWW09UqksrVLSVAnEyQZ/ZfbQM6Z2a9uDIaW0WWAfdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON1Z6auH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON1Z6auH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567091F000FF;
	Fri, 25 Sep 2026 03:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790305206;
	bh=Tr1nw+NGjFDcIfdU/bYk0r7LrX+jhAPSXpBCk1FzwQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ON1Z6auHobCB4vhnxx4TrrPV9dzR2u3AzGGz4TPitmbf3fCB1r5LAbI9F0bHddksa
	 NPUV/1r2rMI+niGrydiVdhgvor3HGDvZwpxAwVvlZtRoAOdPRyEiXojkNyl4cZSqv2
	 QtJktFO9dYVCnx+ZdjQz4/EENah41clBMA0BYXr08XZinM/QHpZhsXcz8sIct1ILbV
	 s38b/RSzOGG64E1Nd9PNr5gO4slg7unHHluHYjZ5TOhLXkYxsR3Ovkpf1yGwKWlioE
	 6jQoAGkBDFjv9vv+gstoCHQcXVx+ts8mzqiG4wrAlD28J3sqc0gDgoaSa95iV3wS56
	 O9ndU3oiBsptw==
Date: Fri, 25 Sep 2026 12:00:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v17 13/13] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Message-Id: <20260925120002.521be50edaa0e144dbcc97c8@kernel.org>
In-Reply-To: <20260922044331.1EB901F000FF@smtp.kernel.org>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
	<179005123942.388919.17930857651144049898.stgit@devnote2>
	<20260922044331.1EB901F000FF@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 22 Sep 2026 04:43:30 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] trace: incorrect BTF kflag check in get_offset_of_field() allows wild offsets
> --
> 
> commit 3bc53bf9a42b7270af7bd91985c43e9cafe48496
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger
> 
> This commit allows the set_wprobe trigger to use BTF struct offset
> resolution to specify the target address field.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> > index f1d6aa320f213..121310b72522f 100644
> > --- a/kernel/trace/trace_wprobe.c
> > +++ b/kernel/trace/trace_wprobe.c
> 
> [ ... ]
> 
> > @@ -1165,6 +1166,213 @@ static void wprobe_trigger_free(struct event_trigger_data *data)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> > +
> > +static int get_offset_of_field(struct btf *btf, const struct btf_type *type, char *field_name)
> > +{
> > +	const struct btf_member *field;
> > +	const struct btf_type *mtype;
> > +	int bitoffs = 0;
> > +	u32 anon_offs;
> > +	char *next;
> > +
> > +	do {
> > +		next = strchr(field_name, '.');
> > +		if (next)
> > +			*next++ = '\0';
> > +
> > +		field = btf_find_struct_member(btf, type, field_name, &anon_offs, &mtype);
> > +		if (IS_ERR_OR_NULL(field))
> > +			return -ENOENT;
> > +
> > +		if (btf_type_kflag(mtype)) {
> 
> [Severity: Medium]
> Is it intentional to check btf_type_kflag() on the member type (mtype)
> instead of the parent struct type (type)?

Oops, I thought I had fixed this issue...

> If the member's kflag is checked instead of the parent struct's kflag,
> bitfield members can bypass the explicit rejection check and compute wildly
> incorrect memory offsets. This happens because field->offset contains the
> bitfield size in the upper 8 bits when the parent struct's kflag is set.

Yeah, kflag is the attribute of the  parept structure's type.

Thanks,

> 
> > +			/* Reject bitfield member access */
> > +			if (BTF_MEMBER_BITFIELD_SIZE(field->offset))
> > +				return -EINVAL;
> > +			bitoffs += anon_offs + BTF_MEMBER_BIT_OFFSET(field->offset);
> > +		} else {
> > +			bitoffs += anon_offs + field->offset;
> > +		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/179005108298.388919.4535333252892590932.stgit@devnote2?part=13


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
