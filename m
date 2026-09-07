Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD88B67E;
	Mon,  7 Sep 2026 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754238; cv=none; b=K4mMmwSXMQ1b+D4ee+j/oRjhhJzbGRLow/bvZL1vjPc2KVs76qlzTMecbfIPc9ABGMexpGYo9DcuIrAtc5GetvfNk/2ewPtc/NnG/NshmPKJEa+8o9Uike9N91LzgOWg4+Ei9+NtfnwlpcnXcCu7H4Nna+iIOTlHRO6wEJQLks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754238; c=relaxed/simple;
	bh=seIcMBkWP1l3PxPPfabRd4knhHuwYJ6H7sObXRjQbSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JinFQdfBg5ZFrgTdqjx8I3aVfOyIsI6AW1wHpI8fY9Av1E0qubs3vU4taU+Kwnx6APSBREefjoMjQiYLJFSoca/HSVTR0vzlLZ43LT8Fma51ZR7MkYkjFEIHxEPU7AFbedmf5xH8x4t2+hmIGY7lRjX5QG20x9ibyf189dUAG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekir/EK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekir/EK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9C41F00A3A;
	Mon,  7 Sep 2026 04:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754237;
	bh=IwOFndAAoDXlhweigOAZ8CpA8PraOblv6wb0k8qfTdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ekir/EK1Mj6Tf6eJpz4A+tGEMSPJE5ac7k4PYZ/ULw+Ckz+KXdC61mCPWI72wvKGh
	 DKeFvDbQfrk56X+GAaYyXk4U+zrAC3KJA/8zNGPTH0FdqXNpWZhkvrs/T5TO/kdiJc
	 77Mk/EJZOSbYSOQO/p23zJlFT7/P4TjLdssJGvdJ06HcRf7gsMhxBSFfFftHW3IIhR
	 9SgWF6UUQtVCgjMTPGzgruVvqaZC7zOkr6ot3h8zqXbvVgkYMbyfmNFo6/dSja3GF0
	 x4kSD+ZGJhMiYseEhcKp1q/Ybfvs/+YdpYN6ajuEoVsm8OVbi0hGgzCQTaLnx8Q6f5
	 5et7ZHPcyWZDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 09/12] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178875287944.93794.8914114071047199197.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875287944.93794.8914114071047199197.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:10:36 +0000
Message-Id: <20260907041036.DA9C41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] clear_wprobe incorrectly rejects legitimate fields starting with=
 "unlimited"
--

commit f87f4797ae7a52cd2de4840afea59fb8bb8bbaf6
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add set_wprobe and clear_wprobe event triggers

This commit adds the set_wprobe and clear_wprobe event triggers to dynamica=
lly
attach and detach hardware breakpoint address monitoring based on event fie=
ld
contents.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *glob, char *cmd,
> +				    char *param_and_filter)
> +{

[ ... ]

> +	/* clear_wprobe does not need field, but can have optional field. */
> +	if (!clear) {

[ ... ]

> +	} else if (param && (isalpha(param[0]) || param[0] =3D=3D '_')) {
> +		if (strncmp(param, "count=3D", 6) !=3D 0 &&
> +		    strncmp(param, "unlimited", 9) !=3D 0) {
[Severity: Medium]
Will this substring comparison mistakenly intercept legitimate C-identifier
field names that start with "unlimited"?

If a user passes a legitimate event field name like "unlimited_size" to
clear_wprobe, the strncmp(param, "unlimited", 9) !=3D 0 check will evaluate
to false. The parsing logic in wprobe_trigger_cmd_parse() will mistakenly
assume it is a count parameter, skip the field parsing, and pass the string
to event_trigger_parse_num().

Since event_trigger_parse_num() attempts to parse "unlimited_size" using
kstrtoul(), it will fail and return -EINVAL. Could this prevent users from
using clear_wprobe on any valid field beginning with "unlimited"?

> +			char *offs;
> +
> +			field_str =3D strsep(&param, ":");
> +			offs =3D strpbrk(field_str, "+-");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D9
