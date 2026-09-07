Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512423ECBE5;
	Mon,  7 Sep 2026 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754505; cv=none; b=RjyddzfHT7XZIe1Wlppa4F8c3lkXbzOG7XhngGx9l9WPs4Qq+ob1e3QrCR4Hrc/inv1Kq8Z77UTloZBfKrf3FQ/Fw5ZNh0yYQo9cIw6gVzf0E4CKbTei7oqN7zyuMCoK4Kpjg7GESBSTecFseYlHpx5IyF31lcf2hSbVMnqHapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754505; c=relaxed/simple;
	bh=XazVpy3BI36I2veSbZu5faes4u2Zv2dvIhjTDw237TU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ek5JlQht45AtzUzfwY15C6eXk1ZN7N+MD4jvKOsDrlB/TGgo7aAtLgeVRtbun53e7t8UtDP2VP4anEksMammjO3BuHppCt9rOb7SCytk77S2h9j0VR48K4wLHRxTqklN9e57jfV3QJj9iropBheGDCYpIamTJ+z3xwsaNHvZgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVtD/GJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVtD/GJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB71F00A3A;
	Mon,  7 Sep 2026 04:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754503;
	bh=+VvbLVBqAbaddKItPWuNPbZDG0fzUlgimFd59JQMpFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVtD/GJ3YnQH2/KqwviZo+qzcrsZ5caeyMCqmK5lEjYAKS8un7fCJvEYtUhjk0Z+s
	 MkCVkEBH8EKVHYyCidbHdNEo2MkE37ZpFWjvzvCQF59Y8OnYCOXxkxiRM/5VQo1PsE
	 d1ZIdmwXDfBuFAGheXRG2HGKn/g7LYeiLhOKpholXHYhbRrnv/yYdUWrP3so/MiBOO
	 LA5y5l3yzvLXPdq3hSCBLQphY9QvfP3wog/EpGxOBDXnkoVvWFSUNGih23U67rdaLO
	 krNNYT3qYKA5ZZ3T86nSChxs4+S7E+k5InOjkCVpUMWBUSIFuY6gOF2Cp70TCGXjBu
	 291gJnEB28mTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 05/12] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178875283469.93794.8082169522481243792.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875283469.93794.8082169522481243792.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:15:03 +0000
Message-Id: <20260907041503.A6DB71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `readme_msg` in `trace.c` instructs users to write to `wprobe_e=
vents`, but this file is never created.
--

commit 5c44f59e0b2737617a0b5934e625357ecffcc63d
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add wprobe (watchpoint probe) trace event support

This commit introduces hardware-breakpoint-based dynamic trace event support
(wprobe). It creates dynamic events on data read/write accesses using
hardware breakpoints and logs the access context and fetchargs.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a946e0183fd1e..40c3e1543f6e3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4294,8 +4294,12 @@ static const char readme_msg[] =3D
>  	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic e=
vents\n"
>  	"\t\t\t  Write into this file to define/undefine new trace events.\n"
>  #endif
> +#ifdef CONFIG_WPROBE_EVENTS
> +	"  wprobe_events\t\t- Create/append/remove/show the hardware breakpoint=
 dynamic events\n"
> +	"\t\t\t  Write into this file to define/undefine new trace events.\n"

[Severity: Low]
Does this advertise a non-existent interface file to the user?

The readme_msg instructs users to write to wprobe_events, but it appears
this file is never created by this patch.

> +#endif
>  #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS) || \
> -    defined(CONFIG_FPROBE_EVENTS)
> +	defined(CONFIG_FPROBE_EVENTS) || defined(CONFIG_WPROBE_EVENTS)
>  	"\t  accepts: event-definitions (one definition per line)\n"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D5
