Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05023DAAB8
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329826; cv=none; b=MW1lRMwL5I1QUJoGh1+6sB4Yhh3617HE87jVbuPbOUKzFawdqBTXQQdoZAbLzOuIWt7C+c0pRhVjIeouTbemBuw4uvR9sz5Quq7WjhiF0lfmS2gTC7dLfEm4f7AIWSefuWtSSe/769KKQVuZ6lBYvQAxWCJTdGLhDs1nUbjaCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329826; c=relaxed/simple;
	bh=hemHzZ9zC57+ewLzRD3CjK1nji0K5bz3k75LxKUXmBk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=drcRs2nVCoEzkwrYuhaK1DWVmdd7MQmM8ia2Qbmg46anmwzHaBW2q68otyZslfDtlqo/K8g+x8WDBczQgF195KY6PltFAqMsQsPgJg5l/UzQsMHnSZuYomzhjJUv+XSshC2R9xEleOX0FjedX5AeZhw+mum9G0ikx4DZKkEep0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bznsdojl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bznsdojl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7021F0089B;
	Tue,  6 Oct 2026 23:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791329825;
	bh=JUDuEl1OW5jct81skQ85nkYERrgru2r9/NC4VbWn5ZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bznsdojlXCyqsfg3bZx9DmAXZNMxf15I7fhtjGlgqQMmQR+ExnzLWlPao5T8guci7
	 sIqMa4sv7WbnQX7Y9tbKHU0QmxfNFc5szcRwABM10AoxZyi1rW/z/O8T93ILfJrhyJ
	 JULuLiFx2ucOTcoAIvlp2i0tpx+MBH91B3iPk3sbiNp3kHNGSDDqb9AOtt2H55sOmw
	 w8lz18k4gMZESSTySa254WRlC1FANgU026IQHWBA0CPjQN5ut38FzcfwVl3yP1bMdw
	 0os6UHeUpVjnqycV8W9OJYJ30OWRyJbd0jRbWSp8K9RG4QYRqfx1gEMuqnOGopBMY/
	 WVTKfTT9b3Clw==
Message-ID: <sashiko-outbox-162514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v2 2/4] perf ftrace: Support filtering
 return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006232756.65620-3-atomlin@atomlin.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
 <20261006232756.65620-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:37:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/ftrace: memory leak of trace buffer on error paths in __cmd=
_ftrace()
--

commit 473e334ba892f3b7d5261168be5e86956a4de438
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support filtering return address comments

This commit introduces a feature to filter out return address comments from
the function graph tracer output in perf ftrace. It implements parsing and
filtering logic, adds a --filter-retaddr command-line option, and includes
unit tests for validation.

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -827,6 +827,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  				break;
>  			for (int i =3D 0; i < n; i++) {
>  				if (buf[i] =3D=3D '\n') {
> +					if (ftrace->filter_retaddr)
> +						ftrace_filter_retaddr(linebuf.buf);
>  					fprintf(stdout, "%s\n", linebuf.buf);
>  					strbuf_setlen(&linebuf, 0);

[Severity: Medium]
Does __cmd_ftrace() in tools/perf/builtin-ftrace.c leak the allocated buf
and linebuf on error paths?

Looking at the initialization sequence, buf is dynamically allocated and
linebuf is initialized:

	buf =3D malloc(TRACE_BUF_SIZE);
	if (!buf) {
		pr_err("failed to allocate trace buffer\n");
		goto out_reset;
	}
	strbuf_init(&linebuf, 512);

However, if get_tracing_instance_file() fails or trace_fd fails to open,
the code jumps to out_reset:

	if (!trace_file) {
		pr_err("failed to open trace_pipe\n");
		goto out_reset;
	}

The out_reset label is located after the cleanup for buf and linebuf:

out_close_fd:
	free(buf);
	strbuf_release(&linebuf);
	close(trace_fd);
out_reset:
	exit_tracing_instance();

Will this bypass the free(buf) and strbuf_release(&linebuf) calls, causing
a regression where these resources are leaked when early error paths are
taken?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006232756.6562=
0-1-atomlin@atomlin.com?part=3D2
