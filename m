Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05D279DB6;
	Mon, 31 Aug 2026 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788139481; cv=none; b=BxYP6fJ5chp1xy65CPIUiKoama1lzTDoV6LDWjQSkC7reyGshVSPdOR3iNwcnKbCf9v7d0cwZI/+FYlFl67oImeywnrdMbTYaTLjdNCEhU5k9YwPdukOT5pxmVoTbXf7Ycfgm/TqeS2pfHPuYCoPJZqjKh8IuzqW0tjelXIrI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788139481; c=relaxed/simple;
	bh=uU6Bu64/mCOOmpJUmAsElEOXt1HEW/clGBxYxKaC7os=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EpmayShdRSdFHg06nTrlMZuNU/46tv9yhuNT4WcUnUxYhRTj7VzXP5bv9hCBvC9m/YC6/XEgHa6oeJir9W9MEavMemWDsz8iTc3nIpt8QLv1x0sxgZmc2yn2234bOOCvawZPp2UVEiBdgKb0SXMhZo9q1cqgKwUN75kj4vfsYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGSa1x0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGSa1x0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086761F000E9;
	Mon, 31 Aug 2026 01:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788139480;
	bh=2+UGWvmVaFyFlmCIpKD8Agf97VAFFZ31rHeCyDj3PFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RGSa1x0+ejGLYOCgPe3qpZXEkM9Euxu6HL65bI7lHnCvoxV0lsf1LYnLE1iMZ8RTh
	 ZMLA0M/Fyuv2pIZCxlaBb4rn8rWSfeen0WUhYrf5bRqp+ay5ORTQYfQbakCwwEOc0R
	 GJnCv4Ckieed95CuIsrLRMQpMXD56Mda9jdwYq9Eavub6k0JMhHJPuB2MBLK7EcPpM
	 4mmLuJ46rLWezDNVGIcIYgEYDAy+LkXH5lWBJsqiPPQmpETYJlNPUpiRMz5eu8Fxlp
	 8Ij7hNdEUDYHMjvphdG5BUOSpIHoYi6Hhczqiw/O12lz1CF2chWtYDAgpBMGw6DdAb
	 xSvNBc3uZ5RMQ==
Date: Mon, 31 Aug 2026 10:24:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v14 02/14] tracing/probes: Fix BTF kflag check for
 anonymous struct member access
Message-Id: <20260831102437.7af7f7a28a8f34ff79655e07@kernel.org>
In-Reply-To: <20260830143859.D56991F00A3D@smtp.kernel.org>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
	<178810003326.64882.5820404025124695636.stgit@devnote2>
	<20260830143859.D56991F00A3D@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 14:38:59 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unnamed bitfields break nested anonymous struct resolution in btf_find_struct_member().
> --
> 
> commit 20a606aa6d4e155be5a531c5d52d78c34205c0b4
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/probes: Fix BTF kflag check for anonymous struct member access
> 
> This commit fixes how BTF kflags are checked when traversing nested
> anonymous structures and unions in btf_find_struct_member() by using
> the actual containing type.
> 
> > diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> > --- a/kernel/trace/trace_btf.c
> > +++ b/kernel/trace/trace_btf.c
> 
> [ ... ]
> 
> > @@ -91,17 +92,23 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
> >  	for_each_member(i, type, member) {
> >  		if (!member->name_off) {
> >  			/* Anonymous union/struct: push it for later use */
> > +			u32 m_off = btf_type_kflag(type) ?
> > +				BTF_MEMBER_BIT_OFFSET(member->offset) :
> > +				member->offset;
> > +
> >  			if (btf_type_skip_modifiers(btf, member->type, &tid) &&
> >  			    top < BTF_ANON_STACK_MAX) {
> >  				anon_stack[top].tid = tid;
> >  				anon_stack[top++].offset =
> > -					cur_offset + member->offset;
> > +					cur_offset + m_off;
> >  			}
> >  		} else {
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it possible for unnamed
> bitfields to break nested anonymous struct resolution here?
> 

Oops, unnamed bitfield.... I didn't expected that.

> Since unnamed bitfields (like int : 5) also have name_off == 0, they get
> pushed onto anon_stack alongside actual anonymous structs.

OK, I got it. This function only expects anonymous struct/union, not
anonymous bitfield.

> 
> Because anon_stack is processed in LIFO order, an unnamed bitfield defined
> after an anonymous struct will be popped first. When it is popped at the top
> of btf_find_struct_member():
> 
> retry:
> 	if (!btf_type_is_struct(type)) {
> 		member = ERR_PTR(-EINVAL);
> 		goto out;
> 	}
> 
> Does this cause the scalar type check to fail and abort the entire search,
> preventing the earlier anonymous struct from ever being searched?

Yeah, this is wrong. it should check this is the last anon_stack entry
and retry. Maybe we should make it a loop.

Thanks!

> 
> >  			name = btf_name_by_offset(btf, member->name_off);
> >  			if (name && !strcmp(member_name, name)) {
> >  				if (anon_offset)
> >  					*anon_offset = cur_offset;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178810001186.64882.2161016469449127450.stgit@devnote2?part=2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
