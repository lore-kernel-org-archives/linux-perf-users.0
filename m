Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC04EDCC3
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995215; cv=none; b=F+bXg4u+vIFOqkJmphJK0ycKv2RlIii6Vj9bX3I+83JrjdmTqEHMTCHbMXqBrylGDm3Nb0VcFJLnf+4xsNCIMBHG8gq5VRw+aLrX3hGret3e36Mr4qrfkE2qZUR/QsjvZykXvMLRXx7CLS2HvriX0sJ+Q0KE9emkHzeLDpo0SUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995215; c=relaxed/simple;
	bh=Uhg9HTgTJHgydzvAaYWB2nLsRZQGxBvNvs2Yk02ueiQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kFkx17Fxtb5tfYgZbsckNTcsklg4r12OsKobcFvAWW6T/HbluFd52DEefAYFKiAxl6TbVGufkSJvQWEsVWkLVQpInteYYmUPTmmZ6rzA9gJRePY51aQ6no+ckvejztIaMVvG+byeoD851Gzy4KR5z6BXpLbVP9fQoxErXtaWJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUJrDZfF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUJrDZfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A601F000C4;
	Wed, 14 Oct 2026 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995214;
	bh=4Rp7WbvYCwyLXLWmOF9igTLOeLDBcnAukZmGks78Hxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUJrDZfFsdLRaU5R8rlNNJozMAruLRb+FnvTS4HYQLyUPPS6twJFMdACujIRZm8lV
	 73GJbULmxlhw0Eu+lr0HG94P3ceFCrE4l1LhKcQ5p5EDZQVcwD0On7qFb2waLLkZul
	 TQcjILvV8BsRqf8FLmjEOMKkxNJvYzUMB30VMfqEp81NogPa3a9EDod874Un6jhPI3
	 s3mjAeJU+R5ckKyFP0f/ckNRgtTmHF6ylgKFkW04BwATl4NvOIW6laNZBnpDI/iEyJ
	 Nvs+kJz4jh4aCAiJpgxlWjG0j6iYt319CNxfOugo3vWsjQA2DpfDMN/y6d9lUc1cal
	 WjQBzQtcA6p6Q==
Message-ID: <sashiko-outbox-171530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 1/5] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014161457.373253-2-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:26:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: premature termination on EAGAIN during ftrace polling
--

commit 0da8f6d83b353c321a754b6791e275b195595b54
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming

This commit optimizes __cmd_ftrace() by replacing a fixed stack buffer
with dynamic heap allocation and a strbuf to accumulate streamed characters
into whole lines. This reduces stack usage significantly and adds error
and EOF detection on stdout and the trace stream.

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6017493ff1797..efd5343dc9adc 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
[ ... ]
> @@ -810,20 +822,30 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  			break;
> =20
>  		if (pollfd.revents & POLLIN) {
> -			int n =3D read(trace_fd, buf, sizeof(buf));
> -			if (n < 0)
> -				break;
> -			if (fwrite(buf, n, 1, stdout) !=3D 1)
> +			int n =3D read(trace_fd, buf, TRACE_BUF_SIZE);
> +
> +			if (n <=3D 0)
>  				break;

[Severity: Medium]
Since trace_pipe is opened in O_NONBLOCK mode, can this lead to premature
termination of the perf ftrace tracing session?

If a spurious wakeup occurs for poll(), or if a non-fatal signal interrupts
the syscall, read() returns -1 with errno =3D=3D EAGAIN or EINTR. Unconditi=
onally
breaking out of the loop here stops tracing instead of retrying the read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014161457.3732=
53-1-atomlin@atomlin.com?part=3D1
