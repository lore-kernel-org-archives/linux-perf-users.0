Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656485;
	b=m/g6mxZ7UkHhXo5K84UZZxcM5R5/6tis+C80YXd59UNps5uY98uu6tUTMt4faDj/A9tN
	 o74rA5R+Dphc+Y+E0MASBrUm+lrKegxR3pNWFlTRf+Td71iE2lLd4j0mTn5MGRnQ7p2VI
	 7D+daAYJwFp8Qmt5SozfUOpx5cySzec8ZeY8uYAILuLSWmI67QPSKWu0TD0HmSUG6n5dK
	 UYKrkD8kAX7RuHsLCPhroRY3njxid9638rvDM9NAIcf/1+VFFxd3AW4wfZa2mNPIZO3wZ
	 dMeHT+KBzOSzLw4rp01WLWkbRC4efnko5pCxzpw9UOgrWqzi2/VpiIREB4vfDhoeQnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TD7mFiK+/4sH/8jSpbYU4MGgs4Oq6d4kgcTO/B/Eslk=;
	b=oo1AuHI7nk53vfrj6oWTuVSPC790/x2rgkMMJcqxk/CE9J2iYFLxXjdzINed8/iwH9yi
	 7sHx99A/fK1oXQuglQIJc1vf4oV1NA2TXF/g9tfp9xkyarBuqvYbuOMSnnlSaHMvD033F
	 l6FfHSXC//15FimakQEqa5Qop+JbIN+wKTFCHwuu+ixtx4cYd95xhC5V7XjV2Gs9Slr7P
	 wwICtKtHtl0HMuL1pU7Ugb/dIRTpi4H/nGiiui+DqWqlmlXl/8Xmn5vo+8GGC91VZj7vV
	 eeMJ7kXzWAGkXSpvXIC781kwVvXsEz+ZxWpWnNrow1n4oOu06P3QtSD0YOH8tOlLSwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keF9oilH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83E606A327
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keF9oilH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B129F1F00A16;
	Mon,  2 Nov 2026 21:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656484;
	bh=TD7mFiK+/4sH/8jSpbYU4MGgs4Oq6d4kgcTO/B/Eslk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keF9oilHttcHsGhmaWTGOK1oFd0PeCCHhQ/ujDa4gmJuMqlgMYGIYIic9t2HBtjES
	 GLhcZav24JnscnGIHfeEyLvVGJ6cAwsXwwBJqL9ANFJAwTgIPTiIM2PQeEiiivGex9
	 kor83QZpvrARzG8wX6/wDLri95Z4Jdje7dV0uQzEjV57SHaqTDsIxXTLvdj0IuskeD
	 BylPXIzdyBuYe0DddqN+fSLMOo5eTV+0RRfFvz5eZGTkMeVJ6gU7WogM79rcYhTIqn
	 kdwAxK4hDhckWUOu61ai9E3CuyRBpT3/q9gNOtEYCLRkQWnKTk8kYd+BeQ9Ns1kJXE
	 d2+2cVPxGDMsg==
Message-ID: <sashiko-outbox-194241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 09/10] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-10-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-10-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:54:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] perf tests ftrace: tautological stack check and leak in test_column=
_layouts()
- [Low] perf tests ftrace: leak of out_buf on error return in test_column_l=
ayouts()
--

commit ef1b99782fcc250d9ee67d7316134fcbad8982cb
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support omitting execution duration in function graph tracer

This commit adds the noduration sub-option to --graph-opts in perf ftrace
to omit function execution duration from function_graph tracer output by
setting the kernel's funcgraph-duration tracing option to 0. It also
updates the inline decoder and tests to handle trace lines without the
duration column and rejects combining noduration with the profile
subcommand.

> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index 900f5390141ff..ec3c26a01ef94 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c

[ ... ]

> @@ -875,6 +951,28 @@ static int test_column_layouts(void)
>  		out_buf =3D NULL;
>  	}
> =20
> +	/* Test noduration IRQ markers do not pop active frames from tracked st=
ack */
> +	memset(&ftrace, 0, sizeof(ftrace));
> +	ftrace.use_inline =3D true;
> +	ftrace.graph_noduration =3D true;
> +	ftrace_cpu_states__clear();
> +
> +	out =3D open_memstream(&out_buf, &out_len);
> +	if (!out)
> +		return TEST_FAIL;
> +
> +	ftrace_process_fgraph_line(&ftrace, " 0)  root_func() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " 0) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
>", out);
> +	ftrace_process_fgraph_line(&ftrace, " 0) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D", out);
> +	ftrace_process_fgraph_line(&ftrace, " 0)  } /* root_func */", out);
> +
> +	fclose(out);
> +	ftrace_cpu_states__clear();
> +
> +	TEST_ASSERT_VAL("noduration irq markers preserved stack",
> +			strstr(out_buf, " 0)  } /* root_func */\n") !=3D NULL);

[Severity: Low]
Can this check in test_column_layouts() actually detect whether the
interrupt markers popped root_func from ts->stack?

Because ftrace is zero-initialized with no machine set and no inlined
frames are pushed onto ts->stack, ftrace_task_state__inlined_depth(ts) is
0. When ftrace_process_fgraph_line() processes the exit line for
root_func, extra_indent evaluates to 0 whether match_idx is found on
ts->stack or not:

tools/perf/util/ftrace.c:ftrace_process_fgraph_line() {
	...
		if (match_idx >=3D 0) {
			...
			extra_indent =3D ftrace_task_state__inlined_depth(ts) * 2;
		} else {
			extra_indent =3D 0;
		}

		fprintf(out, "%.*s%*s%s\n",
			(int)(pipe_char - line + 1), line,
			leading_spaces + extra_indent, "", func_start);
	...
}

As a result, the output line " 0)  } /* root_func */\n" is emitted
identically even if ts->stack was cleared by the interrupt markers.

> +	free(out_buf);

[Severity: Low]
Does test_column_layouts() leak out_buf if the assertion above fails?

open_memstream(&out_buf, &out_len) allocates out_buf on the heap, and if
the assertion condition evaluates to false, the macro returns immediately
before reaching free(out_buf), unlike the earlier loop in
test_column_layouts() which frees out_buf before returning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D9
