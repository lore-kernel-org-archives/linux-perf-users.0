Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E3362138;
	Mon, 31 Aug 2026 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215879; cv=none; b=nKuoSycBBXozGrW2of6DpWOKuuPDjA7A0Isy5u3Vt/uLjwtY1xsqLoXxvV+rcKThBOHQEc3b2hO8qfHk/qlRaM4qoTp1hYadDe/Mt6uGdDTZ3mNQWAtla1r+m3st7fNzEZ2bSzhgkmwVy+OOUhqjdB+jaUO7+fUc5udB0Gsm1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215879; c=relaxed/simple;
	bh=OdIEXdDkdDS/PVia3X2NAFYGbeKMhaddRZryWLnLDzQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DUFYN+LzCwTPVYcIm/kKcZUAMxmSfGrGWpuXSDrw1HwkoGyIPFjMwcfsh1gLhVf/NM4T6xMHLKrVpN4JbFnSIz1iG5aGaqeEGDJubTcmGu4xpO0jrX2bFsRvRvtVEnuxLtjJ22yMRVKB4LH1n5lczbXM0JOaEI77zg4n78QfjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs21YVWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs21YVWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5422F1F000E9;
	Mon, 31 Aug 2026 22:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215877;
	bh=aUuYrSBZ336/J97RtA5AvaAES7nKKnIuqwoFvMOu8qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vs21YVWbotF/QUzAzOimb0pVl3ct3PMF3+hEJPbbDJPSptvzkrvSKtSHw+SaQfO/U
	 0x7TQfYUvKZWYHNjlKEIcrbQgtc13DEa5xHhogdLnNrCtCbSfP+D1FbIcfLAKHdhcs
	 z1kzSc0b80/NIOzUWtzH7ZXgPg6G0DkfNWEsG9Ybhl5Kqgch9BSWcvB3b9uU6S2wq5
	 wtKNzvOhvftLc9+AV9t3BPpEb6QGR2cTPovwCGjQC5P490TnFUXAffhfgxGysnZ5vG
	 TBkaVy/x8DmGFEvTi0gDwOj/pxAtu+i1l1a3VJolierj9O7Mtg14Bn6TTO/IXfnKGt
	 +IIzekkjwMi4w==
Date: Tue, 1 Sep 2026 07:37:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20260901073751.aa53249adf57cdbae351a3a7@kernel.org>
In-Reply-To: <20260831131429.0c949991@gandalf.local.home>
References: <178818875393.104360.1469039168635349344.stgit@devnote2>
	<178818877624.104360.10938474138218043559.stgit@devnote2>
	<20260831131429.0c949991@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 13:14:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  1 Sep 2026 00:06:16 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
> > index 4bc44bc261e6..4bd26bceae23 100644
> > --- a/kernel/trace/trace_btf.h
> > +++ b/kernel/trace/trace_btf.h
> > @@ -8,4 +8,5 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> >  const struct btf_member *btf_find_struct_member(struct btf *btf,
> >  						const struct btf_type *type,
> >  						const char *member_name,
> > -						u32 *anon_offset);
> > +						u32 *anon_offset,
> > +						const struct btf_type **member_type);
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index c4163904ba74..ce2a7bb00d28 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -625,6 +625,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
> >  {
> >  	const struct btf_type *type = *ptype;
> >  	const struct btf_member *field;
> > +	const struct btf_type *mtype = NULL;
> 
> Why initialize mtype to NULL?
> 
> >  	struct btf *btf = ctx_btf(ctx);
> >  	char *fieldname = *pfieldname;
> >  	int bitoffs = 0;
> > @@ -640,7 +641,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
> >  
> >  		anon_offs = 0;
> >  		field = btf_find_struct_member(btf, type, fieldname,
> > -						&anon_offs);
> > +						&anon_offs, &mtype);
> 
> If mtype is not set here, then field would be either an error or NULL.
> 
> >  		if (IS_ERR(field)) {
> >  			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> >  			return PTR_ERR(field);
> 
> If field is an error or NULL, it exits out early.
> 
> > @@ -653,7 +654,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
> >  		bitoffs += anon_offs;
> >  
> >  		/* Accumulate the bit-offsets of the dot-connected fields */
> > -		if (btf_type_kflag(type)) {
> > +		if (btf_type_kflag(mtype)) {
> 
> mtype should be guaranteed as set here (maybe set to NULL, but set regardless)
> 
> Now, if btf_find_struct_member() did not set mtype, because this is in a
> loop, in a second iteration, mtype would be stale.

Ah, indeed!

> 
> So either set it to NULL at the top of the loop, or don't set it at all.
> 
> Or am I missing something?

OK, let me just drop NULL initialization because it is a kind of hardening.
(Since anon_offs is left uninitialized, mtype = NULL seems somewhat unbalanced.)

Thanks!

> 
> -- Steve
> 
> 
> 
> >  			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
> >  			ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
> >  		} else {
> > @@ -661,11 +662,11 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
> >  			ctx->last_bitsize = 0;
> >  		}
> >  
> > -			type = btf_type_skip_modifiers(btf, field->type, NULL);
> > -			if (!type) {
> > -				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> > -				return -EINVAL;
> > -			}
> > +		type = btf_type_skip_modifiers(btf, field->type, NULL);
> > +		if (!type) {
> > +			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> > +			return -EINVAL;
> > +		}
> >  
> >  		if (next)
> >  			ctx->offset += next - fieldname;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
