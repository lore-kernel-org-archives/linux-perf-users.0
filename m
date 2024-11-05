Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011318C93B;
	Tue,  5 Nov 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795243; cv=none; b=uidqlUARFsd5tOR/aGlkASsEbA9rMQdr3TFI95MCy4yqCP8zHaIfb08jm+obiFYeoWACFq+37rB79STlwPZfPdztUhSrFvi/NFhBbEYChJQqk8zbeXa/NQZAnlsTKZxnqMTu9/t3NXjjvGGh4EyNSbogyVt9Hr0M43DKdGpCSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795243; c=relaxed/simple;
	bh=hLMfl3hW/+09JrNz2Nj8Tf7VWOLtmcZNq27hi91zz+o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MKENHBOVvzTNtYIP3UuB5dAtYzTSC83eBKS7tn5T9pEj5MD3xIRbYVHV5QhF+yByvWJV/Ddo9oPxqHgips+T74Jq0ifG9alIJEmM+kFE2zdENpzOH80JD1iriwno1mujDH5oIpGdqMIPkPF3JaIWAzE5slbEOAQ2S/ILonzaF2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgrMOohF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgrMOohF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7328FC4CECF;
	Tue,  5 Nov 2024 08:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730795242;
	bh=hLMfl3hW/+09JrNz2Nj8Tf7VWOLtmcZNq27hi91zz+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TgrMOohF2fjSG52ZeIT3y9SJtB8BRHFEnTSPhlwT/O3NQr1sBf9TYiK0yUsm4nHmy
	 3j7wn8hWpqzAlX4NLqHiGnCIGldHsGaQvUOioXuohZ4TZWbJyfI5hkjE8eAnWRm6BL
	 yQB0mkgvmTru/ANr5LazxVUGf5cNPokxEOTbdeiqvPEbmM8pS0R41DJdm97bTYpScB
	 71we34sWT4LhWQ7HrmAYqW3/+cQMhUDVXo/4h6XB0MHunv7jTQeOiAjt1Krh4m0u9Y
	 icJOkTaRQU2FcyB9LvT8k2KFPJZ6zGWs3k2Ya09uN9vsunfSBNC3BUh4YCWtMh57bh
	 T4qqZVHlRz9sA==
Date: Tue, 5 Nov 2024 17:27:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Ian Rogers
 <irogers@google.com>, Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf-probe: Replace unacceptable characters when
 generating event name
Message-Id: <20241105172719.ae199c4674526752a394ddd3@kernel.org>
In-Reply-To: <Zykv2CdUbDIpTkrX@x1>
References: <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
	<173073706473.2098439.14379969075482451249.stgit@mhiramat.roam.corp.google.com>
	<Zykv2CdUbDIpTkrX@x1>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 17:34:32 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Tue, Nov 05, 2024 at 01:17:44AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Replace unacceptable characters with '_' when generating event name from
> > the probing function name. This is not for C program. For the C program,
> > it will continue to remove suffixes.
> > 
> > For example.
> > 
> > $ ./perf probe -x cro3 -D \"cro3::cmd::servo::run_show\"
> > p:probe_cro3/cro3_cmd_servo_run_show /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3:0x197530
> > 
> > $ ./perf probe -x /work/go/example/outyet/main -D 'main.(*Server).poll'
> > p:probe_main/main_Server_poll /work/go/example/outyet/main:0x353040
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c |   37 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index bcba8273204d..27698b9a8c95 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2729,7 +2729,7 @@ int show_perf_probe_events(struct strfilter *filter)
> >  
> >  static int get_new_event_name(char *buf, size_t len, const char *base,
> >  			      struct strlist *namelist, bool ret_event,
> > -			      bool allow_suffix)
> > +			      bool allow_suffix, bool is_C_symname)
> >  {
> >  	int i, ret;
> >  	char *p, *nbase;
> > @@ -2740,10 +2740,24 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
> >  	if (!nbase)
> >  		return -ENOMEM;
> >  
> > -	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
> > -	p = strpbrk(nbase, ".@");
> > -	if (p && p != nbase)
> > -		*p = '\0';
> > +	if (is_C_symname) {
> > +		/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
> > +		p = strpbrk(nbase, ".@");
> > +		if (p && p != nbase)
> > +			*p = '\0';
> > +	} else {
> > +		/* Replace non-alnum with '_' */
> > +		char *s, *d;
> > +
> > +		s = d = nbase;
> > +		do {
> > +			if (*s && !isalnum(*s)) {
> > +				if (d != nbase && *(d - 1) != '_')
> > +					*d++ = '_';
> > +			} else
> > +				*d++ = *s;
> > +		} while (*s++);
> > +	}
> >  
> >  	/* Try no suffix number */
> >  	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
> > @@ -2832,6 +2846,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
> >  				       bool allow_suffix)
> >  {
> >  	const char *event, *group;
> > +	bool is_C_symname = false;
> >  	char buf[64];
> >  	int ret;
> >  
> > @@ -2846,8 +2861,16 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
> >  			(strncmp(pev->point.function, "0x", 2) != 0) &&
> >  			!strisglob(pev->point.function))
> >  			event = pev->point.function;
> > -		else
> > +		else {
> >  			event = tev->point.realname;
> > +			/*
> > +			 * `realname` comes from real symbol, which can have a suffix.
> > +			 * However, if we see some glab-like wildcard in the symbol, it
>                                                    "glob"?
> > +			 * might not be a C program.
> > +			 */
> > +			if (!strisglob(event))
> > +				is_C_symname = true;
> 
> 				non_C_symname would be a bit more clear,
>                                 i.e. inverting the logic, as a C symname is
> 				valid in other languages :-)

OK.

> 
> 				Also since we _can_ know if it comes
> from a C, as we have:
> 
> root@x1:~# readelf -wi /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux | grep -m10 DW_AT_language
>     <12>   DW_AT_language    : 29	(C11)
>     <2b0a5>   DW_AT_language    : 29	(C11)
>     <2f3a4>   DW_AT_language    : 29	(C11)
>     <573b0>   DW_AT_language    : 29	(C11)
>     <6dd73>   DW_AT_language    : 29	(C11)
>     <879eb>   DW_AT_language    : 29	(C11)
>     <8c094>   DW_AT_language    : 29	(C11)
>     <9ce09>   DW_AT_language    : 29	(C11)
>     <9d8fb>   DW_AT_language    : 29	(C11)
>     <b877a>   DW_AT_language    : 29	(C11)
> root@x1:~# 
> root@x1:~# readelf -wi /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux | grep -m1 -B5 DW_AT_language
>    Unit Type:     DW_UT_compile (1)
>    Abbrev Offset: 0
>    Pointer Size:  8
>  <0><c>: Abbrev Number: 246 (DW_TAG_compile_unit)
>     <e>   DW_AT_producer    : (indirect string, offset: 0x4edb56): GNU C11 14.2.1 20240912 (Red Hat 14.2.1-3) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mindirect-branch-cs-prefix -mfunction-return=thunk-extern -mharden-sls=all -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu11 -p -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fcf-protection=branch -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fpatchable-function-entry=16,16 -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -ftrivial-auto-var-init=zero -fno-stack-clash-protection -fmin-function-alignment=16 -fstrict-flex-arrays=3 -fno-strict-overflow -fstack-check=no -fconserve-stack -fno-function-sections -fno-data-sections -fsanitize=bounds-strict -fsanitize=shift
>     <12>   DW_AT_language    : 29	(C11)
> root@x1:~#
> 
> 	Wouldn't it be better to use that to decide how to deal with
> symbols in a CU?

Yes, it also works, but only with debuginfo. Maybe we can use
this as a hint flag to ensure this is non-C.

> 
> 	The advantage of using just the symbol name and that heuristic
> about finding glob characters in the symbols is when we don't have
> access to the DWARF info, having just the ELF symbol table, when we
> don't have the lang code for the CU.

Agreed. So if we can use DWARF and found the DW_AT_language, it will
be passed as a hint flag which ensure that this code comes from C or
not. BTW, Rust is 28 and C11 is 29, thus if the compiler supports the
newer version of C, it will have unknown code. So the hint flag should
be "the source code is a known C version".

Thank you,

> 
> - Arnaldo
> 
> > +		}
> >  	}
> >  	if (pev->group && !pev->sdt)
> >  		group = pev->group;
> > @@ -2858,7 +2881,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
> >  
> >  	/* Get an unused new event name */
> >  	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
> > -				 tev->point.retprobe, allow_suffix);
> > +				 tev->point.retprobe, allow_suffix, is_C_symname);
> >  	if (ret < 0)
> >  		return ret;
> >  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
