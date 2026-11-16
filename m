Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794795336;
	b=BvYHAHn4cT41Dp1uYyKcbI+A1NtBhmhDhm29U05vwGbOqGuxSOhec260tPLf0jlryDLw
	 TVjwRDxzMCbvyEBDLvTlw1nHLzUmV0iSPFQT2qZQGTNUEMwTBe6C7t9St//jv55DlbN4O
	 iuVld8y47w8z2rezRvPx7vCnQe5tKQXfkaVly14+96knVECRZP7uhvRjE621jijv4qYkg
	 fKYKXsEUGj0aIG5X3KhhNBkt4C48w24HkPM4qb6ZBhnMzBTk3RGS785UFN/C3ds54cgSt
	 KRaPACt4ZOC3Tb5X65M76FDalOUmtWx1hMJvw1MlmRf4fYzHZvfDy52SzEXM5B6HkjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794795336;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wZItRaySY14g5BVC2viKZy/bcmMP3lZf5uclPF7bOgQ=;
	b=ZCYqnpHQ7cKO8XDWRB7S6c58VZ3Bwn4Xjqvt5h0Z4yJShpoSp38ZLrsoSOQ6u8gsM79I
	 N60UDe9/FzBPzcET78jAaH8zy8qfTO3ZPsPne5tvusuk23j8IEawa/+Z/lkhaat2iUTnv
	 fq0v5zPptvE1qQTgl24dm94MCNPOtzqwdsYPUtxZCaXsfX9jhF4X50OnWLmAtpiMgG3LE
	 nkibcKEbzFgO7bgMyPJJ79hgtNpKWObLLp2B99qKT7+YrDFTNlRv+EJQrMAk3igV1eKQM
	 H7kGaMwZFsUQOSG1RFxn7vDhJJr+A3WDecDK4yAKFi9mX205KZIxg7bxbCLlvtBsaVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+SASHCL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1128606A31C;
	Mon, 16 Nov 2026 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+SASHCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BAF1F000C4;
	Mon, 16 Nov 2026 02:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794795336;
	bh=wZItRaySY14g5BVC2viKZy/bcmMP3lZf5uclPF7bOgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d+SASHCLD8J4UyxeKcK5oLKoxcClXd8k5ryvD/8KFbfu+YIKJ2OFjkOVuo1Wt6+4E
	 m8y9bvEo/UOhwCNw341Wd91Spx6B86BfiIeLpuuCluMfauvIF431hg5kEY/ErDd+N5
	 EI7vwGGAkH6ZC9iVa+DrJQEH34oa2uUaEnAQ/7LoO7LfvD5ijMntJWLcEjku70yip2
	 ywJV8kjZttCIMz0dAoYg+2izpohn2AUUyoyTx8q1AX59mRWU3/GzmGuOoKx8n6BOko
	 33cfOspRIROCSX/OwzfZkDBZYFIhU3JucE2ekUkxLFzTymB0+xk+FwcKPxgCo8t68s
	 pWGrplZc9XcHw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: mhiramat@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v19 04/11] tracing/wprobe: Add wprobe (watchpoint probe) trace event support
Date: Mon, 16 Nov 2026 11:15:31 +0900
Message-ID: <undine-1794795331149989582-cc3cda1a799c5477@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <179101398088.22872.14081308855446744398.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2> <179101398088.22872.14081308855446744398.stgit@devnote2>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sat,  3 Oct 2026 16:53:01 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
> @@ -0,0 +1,775 @@
> +	if (system && strcmp(trace_probe_group_name(&tw->tp), system))
> +		return false;
> +
> +	return trace_probe_match_command_args(&tw->tp, argc, argv);

Oops, this wrongly checks the command argument and targets.
The argv[] is originally something like this:

argv[] = {"w:[system/event]","<target>","<arg0>","<arg1>" ...}

Since the dyn_event_release() passes `argv+1` to .match() function
(original argv[0] is already parsed as @system and @event), 
@argv[0] = "<target>" here, and trace_probe_match_command_args()
only for comparing {<arg0>,...} parts.
So wprobe need check "<target>" part by itself, and pass the
@argv+1, @argc-1 to trace_probe_match_command_args().


> +}
> +
> +/*
> [...]
> +
> +	for (i = 0; i < tw->tp.nr_args; i++)
> +		seq_printf(m, " %s=%s", tw->tp.args[i].name, tw->tp.args[i].comm);
> +	seq_putc(m, '\n');

This patch adds `FETCH_OP(BADDR, none)` to `trace_probe.c` for
`CONFIG_PROBE_EVENTS_DUMP_FETCHARG`, but `trace_wprobe_show()` is missing
`trace_probe_dump_args(m, &tw->tp);` before `seq_putc(m, '\n');`.
(Yeah, this debug dump was introduced recently. I missed it.)

Thanks,

> +
> +	return 0;
> +}

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

