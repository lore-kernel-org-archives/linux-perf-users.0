Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEC3B4EA9;
	Sun, 30 Aug 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100741; cv=none; b=VXBXP6XWSx4WGIuSSanljMYuqWbHa/spKQc+7i+N5CtKGqiIuKVYZl0i04OyXMCd0RNN4fqMeTEMnDCMc17VXUTyy6IhjPugW5DdEIv12x3BNsCZd3QjSpu/jbhAnmpG5li4A4N0Mw6bjVOXjHniZaiAb7T4SA34cqyCPMzVq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100741; c=relaxed/simple;
	bh=27pj09OGZZXn+a3tCKx1zb3quhK9oD1BFPV7vd67Umk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Amf7wMQa2n30ZUpz4V/1iMZp+AG66aqFqs8S1VGS9N1ksId4vahZzmBbQa0O1RI5XHli6z+MRM51JMQ+Yskb8tMFwVejLTV3R0aHlreH2abi5jis29ImCpKUdHUUC0l0OMfv4BNyVg9ELVsLKUDnaqufvrbNdlp4A2N6pjmr/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpuZgbwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpuZgbwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56991F00A3D;
	Sun, 30 Aug 2026 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100740;
	bh=khfDKxc4FNw0kj4iUfwIE/RULQ1f5T07PbkJcRDOyA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DpuZgbwY+Fz9CTbAQqsW4X8yhVc8NvlJ15Gg5fsA+ueqH+e5Hq8retxMQ59RuKWtZ
	 EohRQDEqjfUxOnX5h+c0Hp6zXyNUBUWuz4ovQJRqTya62FhbtvJPReHofCYQmH1nYQ
	 gKud1sszpZBzuGlMzrBM157TEcmrzed9498wRe+F/xhm5Jd3u9pfIyLEKdOtBZI9r7
	 vrxPcQGhLH7iJwMA/o6C85CuHKVv6kT4eLEImGxUTyJUhQ1uvuT3AvjzGIhhYYsfux
	 FuOC/xtGrjzHHiognkyc8cV8HaqdjU9Q9XxHmP9YmXvhMzt/WJGL24ZVznsyLUIhB/
	 VBCBYGMO04ncw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/14] tracing/probes: Fix BTF kflag check for
 anonymous struct member access
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178810003326.64882.5820404025124695636.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810003326.64882.5820404025124695636.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:38:59 +0000
Message-Id: <20260830143859.D56991F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unnamed bitfields break nested anonymous struct resolution in btf_=
find_struct_member().
--

commit 20a606aa6d4e155be5a531c5d52d78c34205c0b4
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/probes: Fix BTF kflag check for anonymous struct member access

This commit fixes how BTF kflags are checked when traversing nested
anonymous structures and unions in btf_find_struct_member() by using
the actual containing type.

> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c

[ ... ]

> @@ -91,17 +92,23 @@ const struct btf_member *btf_find_struct_member(struc=
t btf *btf,
>  	for_each_member(i, type, member) {
>  		if (!member->name_off) {
>  			/* Anonymous union/struct: push it for later use */
> +			u32 m_off =3D btf_type_kflag(type) ?
> +				BTF_MEMBER_BIT_OFFSET(member->offset) :
> +				member->offset;
> +
>  			if (btf_type_skip_modifiers(btf, member->type, &tid) &&
>  			    top < BTF_ANON_STACK_MAX) {
>  				anon_stack[top].tid =3D tid;
>  				anon_stack[top++].offset =3D
> -					cur_offset + member->offset;
> +					cur_offset + m_off;
>  			}
>  		} else {

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for unnamed
bitfields to break nested anonymous struct resolution here?

Since unnamed bitfields (like int : 5) also have name_off =3D=3D 0, they get
pushed onto anon_stack alongside actual anonymous structs.

Because anon_stack is processed in LIFO order, an unnamed bitfield defined
after an anonymous struct will be popped first. When it is popped at the top
of btf_find_struct_member():

retry:
	if (!btf_type_is_struct(type)) {
		member =3D ERR_PTR(-EINVAL);
		goto out;
	}

Does this cause the scalar type check to fail and abort the entire search,
preventing the earlier anonymous struct from ever being searched?

>  			name =3D btf_name_by_offset(btf, member->name_off);
>  			if (name && !strcmp(member_name, name)) {
>  				if (anon_offset)
>  					*anon_offset =3D cur_offset;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D2
