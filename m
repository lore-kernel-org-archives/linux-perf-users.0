Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0D468C28;
	Mon, 31 Aug 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196420; cv=none; b=LeWvlh94SXLjnmtVBY6/0rowmvSBrWIv3HPgBvdmZBmMmhkLeVAg7wd3WNwB/qt4ZUgXexG+rDnXhtoHL/tb+n46TlvTCfbz69dhY/ioFOajBYbv3ooQb9Px63Va4qtxzCBwvo59Njx8PZoChxp/IP6VCB8XrixEokPPCxjx9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196420; c=relaxed/simple;
	bh=KTJu/kjJxksqIgM6W7l40pfwtu9qTxLS8TUVQjcOX/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTrsH8gjeDh96uhllZckiYo/G19FZDpOdtXYZfHxVXEJrovp670f5ZSWdN3M5umQG86Tsh45Jgpxf9K0PqHiCeqPa1gf40xlDta7eMYoZxRjak8VdwuhjbZxum4TG3n3H60SIL1owvQzjHOqVMk6lYZ94BM1+g+1bnB2gdk3Hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=3ChZsEk2; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="3ChZsEk2"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1E43C1C0AA5;
	Mon, 31 Aug 2026 17:13:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id DD2A630;
	Mon, 31 Aug 2026 17:13:32 +0000 (UTC)
Date: Mon, 31 Aug 2026 13:14:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/probes: Fix BTF kflag check for anonymous
 struct member access
Message-ID: <20260831131429.0c949991@gandalf.local.home>
In-Reply-To: <178818877624.104360.10938474138218043559.stgit@devnote2>
References: <178818875393.104360.1469039168635349344.stgit@devnote2>
	<178818877624.104360.10938474138218043559.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qkcgswixxk1xf51ddgqwr5gctckf9ahf
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DD2A630
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/UFD8goJsadzEunf2mjYFyH4I5BI2DOcc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=dZikL9fK9cf5YVH6B4xPPjKZ0oFUBJT7ZPBvy1fSxLg=; b=3ChZsEk2lnPWSPYgqTGsnrwEZwA38MH4mCFJdSZ3/Ubbk4+CCQt4Nwe5+3DeWoqOr7Q6wqIMDUkLlCj59dCosMg5T91LcBeBh6VWDbeWv6059pwVULEcXRJc8Iejt8yjeTeOlSQHoKiWOTYwLZsTtvH1ckqkmyDfS/KDeci6R9o=
X-HE-Tag: 1788196412-118431
X-HE-Meta: U2FsdGVkX1/MOib4Vh0/nc0IypkRyowKuc6rBLPhUJPSJFN+i3pUPytbbdnPBORdjH/9ks8nrwpwVc4BXEd2OggCI6ebhIN2xfgMNObe+a13gvUSAjPn+Tw5386J96z6yiFHtKI8exqR2Cpo71SKTtGQh8SBgUhzONnppsa1N51dwADK+VqNTfeKxecUw9u/0FtF2j1tNr1i+IRLJMy/yvBJy9sAbrO8CPp/+n5RTW39TDLGvgwNjUQwGRA44ZWE3XpaF5IyjTmUZYrPZ224F2EhxkZsWp74aRId7dYixRQxVzv3hWNOsgDENXdimuWkwitoAP0EBQVFtiExZKdXP+3oO6xsP8/w

On Tue,  1 Sep 2026 00:06:16 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
> index 4bc44bc261e6..4bd26bceae23 100644
> --- a/kernel/trace/trace_btf.h
> +++ b/kernel/trace/trace_btf.h
> @@ -8,4 +8,5 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
>  const struct btf_member *btf_find_struct_member(struct btf *btf,
>  						const struct btf_type *type,
>  						const char *member_name,
> -						u32 *anon_offset);
> +						u32 *anon_offset,
> +						const struct btf_type **member_type);
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index c4163904ba74..ce2a7bb00d28 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -625,6 +625,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
>  {
>  	const struct btf_type *type = *ptype;
>  	const struct btf_member *field;
> +	const struct btf_type *mtype = NULL;

Why initialize mtype to NULL?

>  	struct btf *btf = ctx_btf(ctx);
>  	char *fieldname = *pfieldname;
>  	int bitoffs = 0;
> @@ -640,7 +641,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
>  
>  		anon_offs = 0;
>  		field = btf_find_struct_member(btf, type, fieldname,
> -						&anon_offs);
> +						&anon_offs, &mtype);

If mtype is not set here, then field would be either an error or NULL.

>  		if (IS_ERR(field)) {
>  			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
>  			return PTR_ERR(field);

If field is an error or NULL, it exits out early.

> @@ -653,7 +654,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
>  		bitoffs += anon_offs;
>  
>  		/* Accumulate the bit-offsets of the dot-connected fields */
> -		if (btf_type_kflag(type)) {
> +		if (btf_type_kflag(mtype)) {

mtype should be guaranteed as set here (maybe set to NULL, but set regardless)

Now, if btf_find_struct_member() did not set mtype, because this is in a
loop, in a second iteration, mtype would be stale.

So either set it to NULL at the top of the loop, or don't set it at all.

Or am I missing something?

-- Steve



>  			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
>  			ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
>  		} else {
> @@ -661,11 +662,11 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
>  			ctx->last_bitsize = 0;
>  		}
>  
> -			type = btf_type_skip_modifiers(btf, field->type, NULL);
> -			if (!type) {
> -				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> -				return -EINVAL;
> -			}
> +		type = btf_type_skip_modifiers(btf, field->type, NULL);
> +		if (!type) {
> +			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> +			return -EINVAL;
> +		}
>  
>  		if (next)
>  			ctx->offset += next - fieldname;

