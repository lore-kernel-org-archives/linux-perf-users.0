Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31054652
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645181; cv=none; b=ECv9FW49zXcWOWX2nE7ebdkOT/leAf/4E83V7XHkUgtA/Ys9ClhYylz7aYapTnvrdiMy4sy6XKCyxzPce11iuPyK0QpEWS8powUb9ZY3YwNQLXdkdshqszKbWRcQ0AYb6nWtykCqkA4x+q97x+L1oTMmAUh+MnIgkIozUiJ+MPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645181; c=relaxed/simple;
	bh=PEP78inPiyb3Y/Fd7YgKt5ksGnbhGhtU+FBji7jGsWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fVOUWZQP03OzQXnoWf4xEnB/KSimtZt9a+K40Pkm9mYB2I7rI0QbxVKbvgSYMK4dH1VVmCF5h9a7XqCdmeck8Rmzffz9c8YUhqkw4WFj0asea0XLX6HfkXm5ABYLwCJAj5Y5pvVc3AxAmoWp41nF9K7k41Hew0NQi9oRz1DpLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byd/ghkb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byd/ghkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D88C2BCAF;
	Mon, 20 Apr 2026 00:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645181;
	bh=PEP78inPiyb3Y/Fd7YgKt5ksGnbhGhtU+FBji7jGsWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=byd/ghkbIU02gAtKMJv6PRB4FNfZcTE3GuWN0sHt7JRE3b0UABLC5b6cvrChD39p1
	 i8nujskbdr6VBxg/CWMdxxj6FJEPcooIdQHjfRtv1VUXAD/7yvfeaaKtvdDNpOyjHZ
	 r8WdK0X5xBfRr299yFYYN2URU9duL+ybiI/HhNPHGWs8OvpSaf/8RX6lnTN8pFMfAS
	 440g3pNFqdvPlIPJP5wFhzbbWZVsLAytyDvN4vhkm/vqHTmSmngFB+/2kUVajVVEgo
	 FYUaE+98cm7N9VgPoFxjxjcjalAoKR9uoQRgeMaCkxbpDqhjYNLaLB3xQVFxxIig68
	 JtmAn+ffspHgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 44/58] perf sctop: Port sctop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-45-irogers@google.com>
References: <20260419235911.2186050-45-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:33:00 +0000
Message-Id: <20260420003301.20D88C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Silent data loss and missing output in offline trace mode due to i=
ncorrect background thread synchronization.
--

commit 49888999983c8368caac2c5b2d68dc07aa8060d6
Author: Ian Rogers <irogers@google.com>

perf sctop: Port sctop to use python module

This commit ports sctop.py to tools/perf/python/, refactoring it to use a
class-based structure and the perf.session API. It also adds support for
live mode using the LiveSession helper when no input file is specified.

> diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> new file mode 100755
> index 0000000000000..6daa5f0a3b218
> --- /dev/null
> +++ b/tools/perf/python/sctop.py
[ ... ]
> +    def print_syscall_totals(self):
> +        """Periodically print syscall totals."""
> +        while not self.stop_event.is_set():
[ ... ]
> +            for syscall_id, val in current_syscalls:
> +                print(f"{self.syscall_name(syscall_id):<40s}  {val:10d}")
> +
> +            self.stop_event.wait(self.interval)

Does this code drop the final batch of accumulated syscall events when
running in offline mode?

When process_events() completes, the script reaches the finally block and
calls stop():

> +    def stop(self):
> +        """Stop the background thread."""
> +        self.stop_event.set()
> +        self.thread.join()

Setting stop_event causes stop_event.wait(self.interval) to return
immediately. The loop condition evaluates to false, and the thread exits
without printing any events that were gathered since the last loop iteratio=
n.

If the trace file takes less than the default 3 seconds to parse, would the
script exit silently without producing any output at all?

[ ... ]
> +    try:
> +        if args.input:
> +            session =3D perf.session(perf.data(args.input), sample=3Dana=
lyzer.process_event)
> +            session.process_events()
[ ... ]
> +    finally:
> +        analyzer.stop()

Also, since process_events() parses the trace file as fast as the CPU allows
during offline mode, does relying on a wall-clock wait() mean the interval
sizes are dependent on the host's parsing speed rather than the trace
duration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D44
