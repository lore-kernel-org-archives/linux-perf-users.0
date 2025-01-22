Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56C214204;
	Wed, 22 Jan 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573286; cv=none; b=DRebIZGGPWZZh+WI4aMly2q5hRe4UEeoVjyWGrOBZ1ryrZJTfYGPgOZaxea4k0u2sS7pZOfGziBNscCDGazy92vfUF/Cghq91SV9M2Vtn+QPhxBOlC2I4BNHPd8Na3eTub64u/3A3s3dSS+V+qWYHo7O8VBPyDA56s8pNedcbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573286; c=relaxed/simple;
	bh=hzA+ziV7rYAO+UjpPoA2DTlYDO+5kD71dwUb4EGod/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mktxBH8fFASUOk9p4Lf2tfwnuaYwIsh/h72/YR+6k1/AcC70DiXKShZv1uAEBNHXGNZowQTZA4xoJ2Yx+z8LB9R1bE9iVOECh2yOX6g4DAx+Uxuo0FxlCQjEhBz9Bj8SKTLs1Tj2mAkjg0U+KTU2L6BZS98iDYM9SZX6rCndK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnBcVcEd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnBcVcEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AFAC4CED2;
	Wed, 22 Jan 2025 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737573285;
	bh=hzA+ziV7rYAO+UjpPoA2DTlYDO+5kD71dwUb4EGod/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnBcVcEdwVoI1bDTIrRwD0/4I1n9te0LeF6tNVmwmmpIN0aZNsZlK19qiTvCehMno
	 ZK50Wzdm9W4YeA7Xgg/wKXO7tfVtWq1Ai/WcQkiXLxnvc7V0dTMmnTqDK1pYjKFeVu
	 hIX8X+P05zVbJ7eWCjFoA91+8DWqHX9tf7GWYoj61G7BHk/3DI17QwUTweuna5VKaD
	 c3tiShouFmie1Y5Q902roiFVd+dQHASjc3fDBIdHy2wn7nsJo4avfoNOwI4IAN/K2Q
	 VsEGWdIXf2obqpH2zUa/Ry+rQdmsx0gW45jZVCRZ8Lbgf3LBhQeixl2qaywfAuxmC0
	 Wb1XMy7oKkMog==
Date: Wed, 22 Jan 2025 11:14:43 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Skip syscall enum test if no landlock syscall
Message-ID: <Z5FDoxySjntN_PBP@google.com>
References: <20250122001741.714400-1-namhyung@kernel.org>
 <CAH0uvojiJjwPH5na-RBZi9O=TKtLcdFCXQDjYfd9T9bnoycX=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojiJjwPH5na-RBZi9O=TKtLcdFCXQDjYfd9T9bnoycX=w@mail.gmail.com>

On Tue, Jan 21, 2025 at 04:44:49PM -0800, Howard Chu wrote:
> Hello Namhyung,
> 
> On Tue, Jan 21, 2025 at 4:17 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf trace enum augmentation test specifically targets landlock_
> > add_rule syscall but IIUC it's an optional and can be opt-out by a
> > kernel config.
> >
> > Currently trace_landlock() runs `perf test -w landlock` before the
> > actual testing to check the availability but it's not enough since the
> > workload always returns 0.  Instead it could check if perf trace output
> > has 'landlock' string.
> 
> I remember doing the landlock syscall nr ifdef checking and returning
> -1... Somehow it's not there... Sorry.

That's ok, we can fix it later. :)

> 
> >
> > Fixes: d66763fed30f0bd8c ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/shell/trace_btf_enum.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
> > index 5a3b8a5a9b5cf296..e57ad6913f3e9316 100755
> > --- a/tools/perf/tests/shell/trace_btf_enum.sh
> > +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> > @@ -27,7 +27,11 @@ trace_landlock() {
> >    echo "Tracing syscall ${syscall}"
> >
> >    # test flight just to see if landlock_add_rule and libbpf are available
> 
> Wonder why I put 'libbpf' here, can you please change this comment to
> '# test flight just to see if landlock_add_rule is available'
> If you find this change appropriate?

Sure, will update.

> 
> > -  $TESTPROG
> > +  if ! perf trace $TESTPROG 2>&1 | grep -q landlock
> > +  then
> > +    echo "No landlock system call found. Fallback to non-syscall tracing."
> 
> I wouldn't say it's a fallback, because the non-syscall test gets run
> even if the landlock_add_rule syscall can be invoked. Why not say: 'No
> landlock system call found, skipping to non-syscall tracing'?

Ok.

> 
> > +    return
> > +  fi
> >
> >    if perf trace -e $syscall $TESTPROG 2>&1 | \
> >       grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
> > --
> > 2.48.0.rc2.279.g1de40edade-goog
> >
> 
> Other things LGTM.
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks for your review!
Namhyung

