Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471492DBF75;
	Fri, 25 Sep 2026 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790307780; cv=none; b=ryvDy2fEBCdHMixQLsbZyP6Lzpz6rbohNv++nlE20FIrPDklpGNfAiOTVuJ7ah/oRfQD/XDWGXNGxuh6xvVIhi+8kGU/RliB6ActesCzakd8yW65V71QyencKD/wobk0VPvjNqRwZsp7AxY8K88yDcI7yp82UJbu2SfeQYleB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790307780; c=relaxed/simple;
	bh=v9FQy+Eqr8/3BtV5iiXjT9mS9FGWCFEh3r6sH3bONPs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rV60Aj+RLNogwLpJAe8GPwHO6pKsZFvHJavUhHTvWiv8dIkFC6rgT4S/NJLlEvr/DWfeFxCs6Eu/2F9lD3umLhI71wuYT0YNGsWWGHgHIm98L8mF1pgvOThADTZa7zZuICfxvhW4IYzZnaYP3bhwqyjbIWTncOi1lftsiwfE/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POY1h4Gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POY1h4Gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D011F000FF;
	Fri, 25 Sep 2026 03:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790307778;
	bh=KMzIltCkgZieJgusHvUws8Lyn8jYikG6NFgi/F4ujfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=POY1h4GhmVrl6dg+UBCvrVo2qKa16MvzyuQElW16pZZh9lZ/TjYLLtHOPIWJFRAmW
	 sQr11J8WuKk9OYOB9Fn7bqKGpT+zR/ZuXFDW53Fnxj2Q6IqJZQBkIE94CygHBEcd9J
	 /kxtbeekz1jlfaV1H0zzE0CXN9dN/GAMqgsjbPlqvfSdt0sKhR7kSA4tdT1WWakDro
	 3S4kxTzmsDgyUjvjF6i15YuuyXcL4wDuINxT0cYTvit3VU4a7bTv4uDfCddRUFJd2h
	 Fqv0Wdd1hZQRrNBSuek4uN2zTfSnAZXXWiP0naWCCRtpLXWRqKEmLGQXm8Xrqon6dn
	 /HTdLbs47vPxA==
Date: Fri, 25 Sep 2026 12:42:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v17 13/13] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Message-Id: <20260925124255.7de8ee833bbbdc24f8ca2a2f@kernel.org>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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
> 
> If the member's kflag is checked instead of the parent struct's kflag,
> bitfield members can bypass the explicit rejection check and compute wildly
> incorrect memory offsets. This happens because field->offset contains the
> bitfield size in the upper 8 bits when the parent struct's kflag is set.

Ah, wait. This names "mtype", but the btf_find_struct_member() returns
the container type to the mtype. So the naming is not good.
See below.

const struct btf_member *btf_find_struct_member(struct btf *btf,
						const struct btf_type *type,
						const char *member_name,
						u32 *anon_offset,
						const struct btf_type **member_type)
{
...
	if (!btf_type_is_struct(type))
		return ERR_PTR(-EINVAL);

	anon_stack = kzalloc_objs(*anon_stack, BTF_ANON_STACK_MAX);
	if (!anon_stack)
		return ERR_PTR(-ENOMEM);

retry:
	for_each_member(i, type, member) {
		if (!member->name_off) {
...
		} else {
			name = btf_name_by_offset(btf, member->name_off);
			if (name && !strcmp(member_name, name)) {
				if (anon_offset)
					*anon_offset = cur_offset;
				if (member_type)
					*member_type = type;
				goto out;
			}
		}
	}


member_type does not get the actual type of member, but getting
the container structure type. (typically, it is @type)

Thanks, 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
