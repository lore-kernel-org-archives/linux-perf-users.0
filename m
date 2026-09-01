Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77E30C617;
	Tue,  1 Sep 2026 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788305020; cv=none; b=JXgp0+IaowR3rtHIkA3FmjlIRMOvDfHJpyIURM/xobKmpAM07ce/dOv2KXgZfxxsqnLKxRugIcME19ojL5mUH15jtWF0VZT6Eb9WpRffiylEHqIcpRdooz1stsLp/Q+pFAOlN9z+zNqon+0Hr5/TgSikbjGisxuHg7xx3rgiz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788305020; c=relaxed/simple;
	bh=fc/L5vrioavvnwfpbHYZffAEMQ7zxGRaz75RZilOFxA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ue6rH5Pj/zHCt2fCKRXdSDgqkAWAYa2QfSxElSoyFYgAiztdVBDQK2gSu3OPpqGfZhZah6U+EDxMUDpVFuuBWzyedHNSdsmfS0SbB7GfeUISLpapEEK7iRq3CtW5YxG3nzbxu4xGrD4ukj5zqFZscGtbqJFUWgOWCg49TD00GIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk5MPcXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk5MPcXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D410D1F000E9;
	Tue,  1 Sep 2026 23:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788305018;
	bh=Fhr+9NI7Byya+hvnanRJCc+7UsoeZAsVIqoSoylHTao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nk5MPcXG76BlmXVNyecivr2iaX6aYZQ4vURG0sw1apocPk3Iwq06FmmyA1ECTZjqs
	 Eatz6Vac4TSR9NpVMfh2WrQxXxuVqn7NtTlutq1t/bn00QXolctSkTh5eL1Z+rjxiF
	 9wAR7mWIDZRSgVTZneSGobtiEzbf5wWAtg/HXoHy1EkOP5KUwdo/ppvNfGMDyjPdVJ
	 8cSX/xBKr4hZPOG6pyEgilKVONSICUc83nBs3Rrw/iD+goj1x9wgSWCqKc1ER8B+rr
	 jSfMNABYEe2KMCKR/AP1E+xkz7l2oqEW9SBl5Yrrzt5/GXhndQ0wb1VzXQTabHar+G
	 fSItJQ/MB8ShA==
Date: Wed, 2 Sep 2026 08:23:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 2/3] tracing/probes: Fix BTF kflag check for
 anonymous struct member access
Message-Id: <20260902082332.921e8a1d0ae8a3da6f167d2a@kernel.org>
In-Reply-To: <20260901103725.7ca9629f@gandalf.local.home>
References: <178827248631.123716.2627172171811720261.stgit@devnote2>
	<178827250904.123716.17452648791331881284.stgit@devnote2>
	<20260901103725.7ca9629f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 10:37:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  1 Sep 2026 23:21:49 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > btf_find_struct_member() traverses into nested anonymous structures and
> > unions to find a struct member. However, get_bitoffset_of_field() in
> > trace_probe.c checked btf_type_kflag(type) using the outer parent type
> > instead of the actual anonymous structure/union that directly contains
> > the found member.
> > 
> > If the parent structure and anonymous structure have mismatched kflags
> > (e.g., the parent has kflag=0 while the anonymous structure has kflag=1
> > because it contains bitfields), the bitfield size encoded in the upper
> > 8 bits of member->offset is erroneously treated as part of the byte/bit
> > offset, corrupting the resolved offset and failing to set last_bitsize.
> > Similarly, btf_find_struct_member() pushed anonymous member offsets
> > onto anon_stack without masking BTF_MEMBER_BIT_OFFSET() when kflag is set.
> > 
> > To fix this problem, update btf_find_struct_member() to return actual
> > containing structure/union type via member_type, use appropriate
> > __btf_member_bit_offset() to get bit offset, and use member_type for
> > btf_type_kflag() in get_bitoffset_of_field().
> > 
> > Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kernel.org/
> > Assisted-by: Antigravity:gemini-3.7-flash
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

Thanks! Let me pick those to probes/fixes.


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
