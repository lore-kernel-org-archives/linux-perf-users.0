Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B313B1034;
	Sat, 22 Aug 2026 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391304; cv=none; b=P3hhk7qsMG3bngxtdehV85mF1Gvd2XOn48DQgkzffzHjQrpbrYlSxutkFY+u6ZDvchCCiP5Qmmvc/heQpqcNFRzXmt6fcmyB4iQJp1ncoLwE0ikOQzvrfb1I4GcLBdq0PnVFHywbqEgS2WFAxq/4HeYWW4kR6qkqziVDxbv0iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391304; c=relaxed/simple;
	bh=Y+TIUR2YOYjxvCOTRJUZoxpwKaGabbYnt19ZX6mkAu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=toL9jI3VjyldDBedQQv4YOQd6XBq4HcpzEP1CXguMXTphvjLmp+hsV+RfrVfV/IdXXFMyHeYC9C5K+81E7GTeufPFlCb7EWNLu6V73juoguAA7VjeH1RuGyGqWWFSYwRRIHT9lcYEvMa/tZGgTKQACseSBfhHZwTdB70ItHrekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhKYRz3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhKYRz3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C1B1F000E9;
	Sat, 22 Aug 2026 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391303;
	bh=7iPg/cga3QIB7Oxy/nlBlq5FrCzAIgZZQ2HmjcKoPOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhKYRz3dA3egkJm8zF0VLV5sX8P/6tx1mgn2L/l3HxU7Oc4Bl8ZQFQw1QdjeNHvAy
	 uiUz+R2izOcYceAdOK+/CNN1fDE/otlqav8kbYLXOdgrKauC8gFGfph8wDRa+ngpbW
	 lFZZN85Qdubni/GqHDeZA2pD6XbVAuLSwRRsWLOWQ6ag5Mp1RHePrgX1JM4ubcrJXN
	 trfZI2bMOXlDCF+8LrPGzx1YAOj2b/p5WrUlOpn7StZH2e6Irw/a8rSH4Hx3kb8aN2
	 3GyB9FGxcs2d53WxWcsgYuJjfVaXR5U1WSYTDt10PAPhO7lu3U/q3SKj5g09EBkTGx
	 xKq6QMvh+BUbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/12] selftests: tracing: Add syntax testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178739068097.1520941.17014781036682940369.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739068097.1520941.17014781036682940369.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:35:02 +0000
Message-Id: <20260822093502.C0C1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The test comment `# BAD_ACCESS_ADDR` does not match the actual erro=
r logged by the kernel, which is `BAD_PROBE_ADDR`.
--

--- Patch [8]: [PATCH v13 08/12] selftests: tracing: Add syntax testcase fo=
r wprobe ---
commit fc72e33e91d484bd38ebdde9110dabef02740205
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: tracing: Add syntax testcase for wprobe

This commit adds a new testcase, wprobe_syntax_errors.tc, to verify the
syntax error handling of watch probe events.

> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_synta=
x_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax=
_errors.tc
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_error=
s.tc
[ ... ]
> +check_error '^w'			# NO_ARG_BODY
> +check_error 'w^10 w@jiffies'		# WPROBE_NO_MAXACT
> +check_error 'w ^symbol'			# BAD_ACCESS_FMT
> +check_error 'w ^a@symbol'		# BAD_ACCESS_TYPE
> +check_error 'w w@^symbol'		# BAD_ACCESS_ADDR
> +check_error 'w w@jiffies^+offset'	# BAD_ACCESS_ADDR

[Severity: Low]
This isn't a bug, but should this comment say BAD_PROBE_ADDR instead of
BAD_ACCESS_ADDR?

Looking at parse_address_spec() in kernel/trace/trace_wprobe.c, when the
offset fails to parse, it logs BAD_PROBE_ADDR rather than BAD_ACCESS_ADDR:

    if (kstrtoint(off_str, 0, &offset) !=3D 0) {
        trace_probe_log_err(off_str - _spec, BAD_PROBE_ADDR);
        return -EINVAL;
    }

Could the comment in the test script be updated to match the actual error
constant logged by the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D8
