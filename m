Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C431E85E;
	Tue,  1 Sep 2026 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271246; cv=none; b=oQHI27Ih56AZzEc6SU2+i5sJEfOYDgU0SzCcKEsAU1qVTLKOG/KvyZ4cakXEvL5bwN1499U2A97Pt6YOOnwn2FEObZLLfgRRPbYvnBxUgKpiCUAe3AsWL1j+6GUweKKVC2GHeIrIXvbYfZ54RF3mXTQDo9Yfo67mIq0rpijNj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271246; c=relaxed/simple;
	bh=ZgsBwpg411JJNZ4embw4wLigS9kwzzvokWpoFKgkcyY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RtJOlASm7y8UlBumN3500FBBKkQ6C6a0Bv3hEKYy6/1UekArRs+Qo9imbxK86xy72tmy6z8OShnqPvuyaWErtcoNEAB4IxsP3NAmQvxv5sMPtLD3D9Uhwz0aVSdBfTWqsmtho4gtuOX+YPq40hxGv5WgZkuiGj5jfxzRTdRgLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhz2FrhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhz2FrhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3E41F000E9;
	Tue,  1 Sep 2026 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788271245;
	bh=blOwsfAdeVNIhFbf25w6vatwg29Ryi252r/5Grzq3b0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lhz2FrhVD2k4wd/Ss/pLlDoG0wJSmMd8G/z2Pj1RdsQgqw8B9OrDhQqpVRFarIvn3
	 U7Oy1Yc+DJMsf6TStk/Ux8H0n+PcsD62qTCPdSJh/XOi3ULjP4iLjlOUSHQQbrFBm1
	 OqSsa8L8EfEcSDAaB/nx//tN93E7vG6+WWie8//PdL6OTZ5r2T8srkGlq92wb44ac+
	 5i6K1Vi2Tt8Q7S4dkmtUYwcqswyQUMv1eymwqw6mRiof947QVpZuJOMRm2cm6ri9vM
	 RdluK/DrCVDoZmAZxgG/Wi5H9lwuIgFRDXrBtLH8ig10lYWJYIYeCbeE0FIIItnC5F
	 xyOGtNFfiJyyA==
Date: Tue, 1 Sep 2026 23:00:39 +0900
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
Subject: Re: [PATCH v2 2/2] tracing/probes: Fix BTF kflag check for
 anonymous struct member access
Message-Id: <20260901230039.8b4ac66d0d38f68b500a154e@kernel.org>
In-Reply-To: <20260901090442.7cd378dc@gandalf.local.home>
References: <178822361441.115597.11442662641658772793.stgit@devnote2>
	<178822363712.115597.2744784023996949800.stgit@devnote2>
	<20260901090442.7cd378dc@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 09:04:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  1 Sep 2026 09:47:17 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > btf_find_struct_member() traverses into nested anonymous structures and
> > unions to find a struct member. However, get_bitoffset_of_field() in
> > trace_probe.c checked btf_type_kflag(type) using the outer parent type
> > instead of the actual anonymous structure/union that directly contains
> > the found member.
> > 
> > If the parent structure and anonymous structure have mismatched kflags
> > (e.g., the parent has kflag=0 while the anonymous structure has kflag=1
> > because it contains bitfields), the bitfield size encoded in the upper
> > 8 bits of member->offset is erroneously treated as part of the byte/bit
> > offset, corrupting the resolved offset and failing to set last_bitsize.
> > Similarly, btf_find_struct_member() pushed anonymous member offsets
> > onto anon_stack without masking BTF_MEMBER_BIT_OFFSET() when kflag is set.
> > 
> > To fix this problem, update btf_find_struct_member() to return actual
> > containing structure/union type via member_type, use appropriate
> > __btf_member_bit_offset() to get bit offset, and use member_type for
> > btf_type_kflag() in get_bitoffset_of_field().
> > 
> > Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kernel.org/
> > Assisted-by: Antigravity:gemini-3.7-flash
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> 
> 
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
> 
> Is this just to fix the indentation? If so, can you make this a separate
> patch? We don't need it to be part of a patch that gets backported. It may
> make it more difficult to do so.

OK, let me split it.

Thanks,

> 
> -- Steve
> 
> 
> >  
> >  		if (next)
> >  			ctx->offset += next - fieldname;
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
