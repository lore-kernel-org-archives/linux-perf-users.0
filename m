Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECF25785D;
	Sun, 30 Aug 2026 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068182; cv=none; b=oetXmM4RPEi3Kk9z2ZPBiDvWHJihwPunugj2XJodTj0fAZ8LBo1xL5MgwLYbMifuEB9/s+L3QndXrhojxKB1LhPZpoyR2P3UyGMxSGFmqa9adRPgUhS1OordnVAOCbct4UKHjSwRGIHNI0FebmsEk0RZ+UgnVcGnDno7Dygfc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068182; c=relaxed/simple;
	bh=GXDYinhy1ReIzdHSavEFXK4As69kwht4etzenPsKovk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ENrAqdwtJy1PZh+psS9v/Gaa6fLdTWy19K9ZNoNil9qFpmXn5N3dUXvTjnuiy2vyY0cDB71kaSBaxxfPmZ+PqLdoLwD7hMBTJpov3YFzUNMsHfC8tma5KzERTvnTgPKXwkyi/8RE4hcvJgSruFfrKwOtK17yGMQNHWqISUc3uL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj5OBNPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj5OBNPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770921F000E9;
	Sun, 30 Aug 2026 05:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788068180;
	bh=5SpUPc6lpWFq9g8ozhFar0PITb/R1MsKVf+d0+GMV90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qj5OBNPWcoOCN0KtuYPiNexPXZgso4+p/+WGYEh6uw510dnHqn6lKwheH/bMqFNuu
	 40WV1ZJtDVAHkIu2mWYyQceFpebfgiA7+vUqy/kS+Eebg/nXFtcrFtOJ0dxVnXvh3o
	 Dd5/xO03hm5kngNwsnBw4i6RzyEb+Ub+Q3XPMydb3T1GKZPIhLjoPKds5CAJT3OIBd
	 nxPiXvWskokrr++pNaMIe7k5SMyQ2mt4tIh9NAIM8ilcdBpHMPN9DnOwyqlBnoH3ZB
	 CjqtU/1//qCyep/XkNqzNRjuy3tmGrVCMDB5RRt1YxJsq4fPFN5jFgMCrsz2ocQyxC
	 ZtYreG/WPAVQA==
Date: Sun, 30 Aug 2026 14:36:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v13 12/12] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Message-Id: <20260830143617.5edd4b9e94278a941ee6f28f@kernel.org>
In-Reply-To: <20260822095110.0772E1F000E9@smtp.kernel.org>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
	<178739072694.1520941.18132159339101776117.stgit@devnote2>
	<20260822095110.0772E1F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 22 Aug 2026 09:51:09 +0000
sashiko-bot@kernel.org wrote:

> > @@ -990,6 +992,181 @@ static void wprobe_trigger_free(struct event_trigger_data *data)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> > +
> > +static int get_offset_of_field(struct btf *btf, const struct btf_type *type, char *field_name)
> > +{
> > +	const struct btf_member *field;
> > +	int bitoffs = 0;
> > +	u32 anon_offs;
> > +	char *next;
> > +
> > +	do {
> > +		next = strchr(field_name, '.');
> > +		if (next)
> > +			*next++ = '\0';
> > +
> > +		field = btf_find_struct_member(btf, type, field_name, &anon_offs);
> > +		if (IS_ERR_OR_NULL(field))
> > +			return -ENOENT;
> > +
> > +		if (btf_type_kflag(type)) {
> 
> [Severity: High]
> Does this code check the kflag of the original parent type instead of the
> anonymous struct that actually contains the field?
> 
> btf_find_struct_member() can return a field from a nested anonymous struct,
> but if the parent struct and the anonymous struct have mismatched BTF kflags
> (for example, the parent has kflag=0 while the anonymous struct has kflag=1
> because it contains bitfields), using the parent's kflag here will cause
> the bitfield size encoded in the upper 8 bits of the offset to be
> misinterpreted as part of the byte offset.

Oops, that's right! btf_find_struct_member() skips anonymous struct and
get the field directly. Hmm, it seems the same issue in the trace_probe.c.
Let me make a fix patch.

> 
> This can add a massively inflated value to bitoffs and result in a wild
> pointer dereference when the wprobe triggers.
> 
> > +			/* Reject bitfield member access */
> > +			if (BTF_MEMBER_BITFIELD_SIZE(field->offset))
> > +				return -EINVAL;
> > +			bitoffs += anon_offs + BTF_MEMBER_BIT_OFFSET(field->offset);
> > +		} else {
> > +			bitoffs += anon_offs + field->offset;
> > +		}
> > +
> > +		field_name = next;
> > +		if (next) {
> > +			type = btf_type_skip_modifiers(btf, field->type, NULL);
> > +			if (!type)
> > +				return -ENOENT;
> > +		}
> > +	} while (next);
> > +	return bitoffs / BITS_PER_BYTE;
> > +}
> 
> [ ... ]
> 
> > +static int wprobe_trigger_typecast_parse(char **field_str_ptr,
> > +					 struct trace_event_file *file,
> > +					 struct wprobe_trigger_data *wprobe_data,
> > +					 const char *glob)
> > +{
> > +	struct btf *btf __free(btf_put) = NULL;
> > +	const struct btf_type *type;
> > +	char *assign_field;
> > +	char *event_field;
> > +	char *type_field;
> > +	char *type_name;
> > +	char *offs;
> > +	long val = 0;
> > +	int id;
> > +	int adjust;
> > +
> > +	type_name = *field_str_ptr + 1;
> > +	event_field = strchr(type_name, ')');
> > +	if (!event_field) {
> > +		wprobe_trigger_log_err(file, glob, type_name - glob, DEREF_OPEN_BRACE);
> 
> [Severity: Low]
> Will this log message place the caret out of bounds and hide the user's
> input?
> 
> The glob string passed into wprobe_trigger_log_err() seems to be truncated
> by an earlier strsep() call replacing the delimiter with a null terminator:
> 
> kernel/trace/trace_events_trigger.c:trigger_process_regex() {
>     ...
>     command = strsep(&next, ": \t");
>     ...
> }

Oops, strsep modifies the buffer. OK. let me fix it.

Thanks!


> 
> Since glob is truncated to just the command name, calculating the offset as
> type_name - glob can point far past the end of the printed text, making the
> syntax error logs illegible.
> 
> > +		return -EINVAL;
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178739053919.1520941.17662338993878200834.stgit@devnote2?part=12


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
