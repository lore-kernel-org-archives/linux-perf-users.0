Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C84121C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUalMXV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3015C433C8;
	Tue, 17 Oct 2023 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697547189;
	bh=sCVSBncrC5i0GYEhpxlxlXa2wh6iMdOP1tIgkqX072Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUalMXV8bFNbfyg2W86Bldn7S37B+o2YNQQ/y8NohBDXgSzLqUsp4+fM8xChaaUr/
	 9HNuA4fL4kS9EmkOHwRXjvVVcift4EfOq+LcAwEmfmQTwbm7wvruA5WGOAbpTqy8Fd
	 YuYd8/5IHPBsxqHNxKATJO7aXxRM2GpZGOb5njfZy5GJsU7HG2Fz5K2gMCZwJ6tFR0
	 EqXALEt8gvabo3JG5u7rOdrFF9V5qctsavx8jXkvHEOzwh9X6Jm3vG+0KaLpl402Yl
	 MXUiQhjhZd36CVKrmKogVDzLm2G2lhjbD9TDfcjRNQC5My7O2UFhfAQGhxmU1zqGc2
	 yXiYA58cBxZmg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 6877A40016; Tue, 17 Oct 2023 09:53:07 -0300 (-03)
Date: Tue, 17 Oct 2023 09:53:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Guilherme Amadio <amadio@gentoo.org>, linux-perf-users@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, robert.richter@amd.com
Subject: Re: NMI received for unknown reason when running perf with IBS on AMD
Message-ID: <ZS6Ds+rB2IwWmXML@kernel.org>
References: <ZS0l-k1MASK3547Q@gentoo.org>
 <ZS2vu8bSBS1/zseZ@kernel.org>
 <9d885140-f952-0018-304d-fbc1e15c33a7@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d885140-f952-0018-304d-fbc1e15c33a7@amd.com>
X-Url: http://acmel.wordpress.com

Em Tue, Oct 17, 2023 at 01:31:30PM +0530, Ravi Bangoria escreveu:
> Hi Arnaldo, Guilherme,
> 
> >> [443324.404938] Uhhuh. NMI received for unknown reason 2c on CPU 9.
> >> [443324.404940] Dazed and confused, but trying to continue
> 
> This is a known hw bug in Zen2:
> https://lore.kernel.org/lkml/e08e33d5-4f6d-91aa-f335-9404d16a983c@amd.com
> 
> You won't see it on later Zen processors, or at least the possibility of
> hitting it is very less.

Do you think we can detect that it is a zen2 processor, that it has this
problem, and then the tools can just avoid using precise_ip != 0? I.e.
"cycles:P" becomes plain "cycles" and asking for, say, "cycles:p" states
that this isn't possible on Zen2?
 
> > (gdb) print perf_evlist__first(evlist)->attr.precise_ip
> > $4 = 2
> > (gdb)

> > So it seems to be using IBS:
 
> Correct. More details below.
 
> > Humm:

> >> # cpu pmu capabilities: max_precise=0

> > For me:

> > [root@five ~]# perf report --header-only | grep "cpu pmu capabilities"
> > # cpu pmu capabilities: max_precise=0
 
> Although confusing, this is technically correct because AMD core pmu
> does not support precise mode.
 
> However, as a special case, 3 core pmu events: cpu-cycles, r076 (same as
> cpu-cycles) and r0C1 (micro-ops) are supported with attr.precise_ip > 0,
> and they are forwarded to IBS OP pmu. All other core pmu events with
> attr.precise_ip > 0 fails with -EINVAL.

If we can programatically detect that IBS is present we can add a note
right after that 'perf report --header-only' line with this information.
 
> > [root@five ~]# cat /sys/devices/cpu/caps/max_precise
> > 0
> > [root@five ~]#

> > Ravi, this probably is the max_precise for the "core" PMU, but the "ibs"
> > one, that gets used when :pp and :p (but not :ppp) is used, i.e. that:
> > 
> > +++ b/arch/x86/events/amd/core.c
> > @@ -374,7 +374,7 @@ static int amd_pmu_hw_config(struct perf_event *event)
> > 
> >         /* pass precise event sampling to ibs: */
> >         if (event->attr.precise_ip && get_ibs_caps())
> > -               return -ENOENT;
> > +               return forward_event_to_ibs(event);
> > 
> > Thing..
> > 
> > Shouldn't we have some sort of max_precise cap for IBS so that we could
> > use it and not have this confusing "max_precise=0" for the core PMU but
> > accept attr.precise_ip = 1 and 2?
 
> Unlike Intel PEBS which provides levels of precision, AMD core pmu is
> inherently non-precise and IBS is inherently precise. So max_precise value
> is irrelevant for IBS. I mean ibs_op//, ibs_op//p, ibs_op//pp and
> ibs_op//ppp are all same.

This part can go to the man page, where :p, :P is documented.
 
> Thanks,
> Ravi
 
> PS: I don't know the history behind not supporting attr.precise_ip = 3 when
> event is forwarded from core pmu to IBS. This check was added long back in
> 2012. Robert might know.

Robert? 
