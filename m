Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F424A6CD7;
	Thu, 17 Sep 2026 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687429; cv=none; b=JQ76V5jyF6zBBC4Bji7kLkBJLkc2T0jAEbVmKLOhCDI8AiKEmyREDH2RuzFkZsM7u0rgOzaoiYtRcBgavvo88N4jwsh07TR3OkT3/brkXuoQMEfLC+oRz90S2ilQLFzGzIOMnFdQlxSyFAGFte/QJKRTNaO/wFzioFcLIk/xrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687429; c=relaxed/simple;
	bh=poeBL7i/XfNOvFTAMWdyeuhgvF1nE0pmg9AIpWZRfEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jzj3WWS2Qqae6XGuf//qX8DidfVekjpX9zfdtMOkN2NhZhhShBVzyUg0VsJnQhracl0zRxFHkm8LAnaatWCHcjJYYMjzj8yGX+vyitrCHD03VbA69ReAE6jDB7fLvUVQDwAV4qqYJamiT7EMifuNyUJKiuEQqy+qQCglhzNBNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRIyZjQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRIyZjQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7281F000FF;
	Thu, 17 Sep 2026 23:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687424;
	bh=XltSOCPDpFy77pwcczRFMn70xU3ZDNkxzvtHfjgD1ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iRIyZjQ5Xe/f+3HnGONESJY0SRh/tW6eGy7yQyiapBXt0JcZhqmIuwPGUu5lpyjov
	 nEfJS4LjwDX137picCZQo8ZJJEsi3yvYLYmA86nZF16E4I1hpvssLYMazjdIfScp25
	 FzLOujXKgFm2D0BzEWzEGr1wIgeqcHmIgb6bZMI8Neuw0lXwZX06jfEpz0oOumA4du
	 GjOjLgK+Actiaat+6OLrSpFJ81VKbIzBdWgEixRhP/ccRbsBi/1AY0T6ZJq7NnYKU2
	 Kw5UkN8v/+hjtMMuJsZOudLqVJ/r9GtBJMcxPdOiIViivWb0dnHB7Zqk4mBrLEfhFL
	 QM4D34XTHSLBw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/11] ptwrite uprobes: Add support to tracing
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260917230127.924985-5-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-5-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:23:43 +0000
Message-Id: <20260917232344.6E7281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] trace: AA deadlock on event_mutex in trace_uprobe_enable()
--

commit 18294b1032dd2887acf440ab9d7029011a171000
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add support to tracing infrastructure

This commit hooks up the low-level x86 ptwrite uprobes code to the generic
trace uprobes events parser. It introduces a new ptw: syntax to set up
trap-free ptwrite uprobes and handles architectures without the backend via
weak stubs.

> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
[ ... ]
> @@ -1107,9 +1241,26 @@ static int trace_uprobe_enable(struct trace_uprobe=
 *tu, filter_func_t filter)
>  {
>  	struct inode *inode =3D d_real_inode(tu->path.dentry);
>  	struct uprobe *uprobe;
> +	struct file *file;
> =20
> -	tu->consumer.filter =3D filter;
> -	uprobe =3D uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->=
consumer);
> +	if (tu->is_ptwrite) {
> +		if (filter) {
> +			/* PTWRITE probes have no kernel entry to evaluate a filter. */
> +			return -EINVAL;
> +		}
> +		file =3D dentry_open(&tu->path, O_RDONLY, current_cred());

[Severity: High]
Can this dentry_open() call cause an AA deadlock on event_mutex?

If a user creates a ptwrite uprobe targeting a tracefs file (like
events/sched/sched_switch/enable) and then writes 1 to the uprobe's enable
file, event_enable_write() acquires event_mutex before calling
trace_uprobe_enable().

When dentry_open() is called synchronously on that tracefs path, its
f_op->open (e.g. tracing_open_file_tr()) will attempt to acquire event_mutex
again, leading to a system hang.

> +		if (IS_ERR(file))
> +			return PTR_ERR(file);
> +		tu->ptwrite_desc.event_id =3D
> +			trace_probe_event_call(&tu->tp)->event.type;
> +		uprobe =3D uprobe_register_ptwrite(inode, file, tu->offset,
> +						 &tu->consumer, &tu->ptwrite_desc);
> +		fput(file);
> +	} else {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D4
