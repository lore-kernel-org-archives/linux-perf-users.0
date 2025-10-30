Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5382D4B57
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804289; cv=none; b=T6/mqKGll4sg11cMAHRJaPcltREwYnU7jaRK2/RTJk27pE/FcU/mlwO5LnH99f9WVg6HztabaPGBPjHJORzD3Eim6LeOtkWWEpn5Ut6mAwFDnD+0XKPitY+I7B7ugTr1Zy1ZwWrIe8c2WZiLgg/D23HsMO8GngRejNyEX6IRQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804289; c=relaxed/simple;
	bh=ypv3xB5mcI3OLqy0zGi57V5CMm2FjIzu1JAajaSWGmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDgeW3fN0ltXqT+BcGQ79vMenqTvQVOtuhMovEGdrxC6dPlZYSpcd+WW2TS1KdWR8BEv3cBXT7TbTxjTl81Tigyj8O7uEbJZVPkUeHwzL2pAfRHDG2z0i4oAoUavF6/21EQ6i4+t0/Rpnqiir7WuQLRxQFi6OzRVuoWFj2xamrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJLKF4Ju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJLKF4Ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625A2C4CEF1;
	Thu, 30 Oct 2025 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761804287;
	bh=ypv3xB5mcI3OLqy0zGi57V5CMm2FjIzu1JAajaSWGmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJLKF4JuPUfaEwxVllRAP1zS+n/bqeflV/+ctBqi12UUuSe9ym7xmDk7pvoS7p2Fx
	 YTHi9lIDvFbwk0p6Yz0XTSMiFoEsqgaXzOClCqBYIsngtmnTRWIDrPVhK2GLuBz0DF
	 aBT/0xBNMxZyLPffgAhG1Sj0NyIyik+dnSysLboytuPORY+nNoaINhaayDiDqqVMxV
	 uFR84pMvPZTetMrN2zBMSY27hXb20ePUpXcA5g/3WRCT3q7JGFmSo1pkc6AyGv7iEc
	 O+Vu8aj6uBCbyRZQ1I9gRkGlrq8qbrWpXPDXmGMtH42PyC9cJ34MqmX0FRNbDV8O2t
	 106YM+jT0oyIg==
Date: Wed, 29 Oct 2025 23:04:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Jan Polensky <japo@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [linux-next] perf report runtime extremely long
Message-ID: <aQL__CvbnNHw_bXV@google.com>
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
 <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com>
 <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>

Hello,

On Wed, Oct 29, 2025 at 09:47:00AM -0700, Ian Rogers wrote:
> On Wed, Oct 29, 2025 at 9:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > On 10/29/25 09:03, Thomas Richter wrote:
> > > Hi all,
> > >
> > > has something changed recently in perf report in linux-next repo?
> > >
> > > I run perf report -i <file> -D | grep something
> > > on s390 with 2 different kernels:
> > >
> > > master 6.18.0rc3:
> > > # uname -a
> > > Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 CET 2025 s390x GNU/Linux
> > > # ll /tmp/perf2-eSso2q-2
> > > -rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
> > > # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
> > >
> > > real  0m22.262s
> > > user  0m22.068s
> > > sys   0m0.200s
> > > #
> > >
> > > This runtime is ok for the perf.data file size.
> > >
> > > linux-next:
> > > # uname -a
> > > Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc42.s390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
> > > #ll /tmp/perf2-eSso2q-2
> > > -rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
> > > # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
> > >
> > > real  2m53.601s
> > > user  2m52.938s
> > > sys   0m0.575s
> > > #
> > >
> > > Same perf.data file and run time increased from 22 seconds to nearly 300 seconds, roughly 14 times longer
> > > for the same input!
> > >
> > > Has anybody similar observations?
> > >
> > > Thanks a lot
> > >
> >
> > Ian,
> >
> > sorry sent button pushed too early...
> >
> > here is a second try without option -D.
> >
> > This is much better:
> >
> > root in 🌐 s83lp47 in ~
> > ❯ ll perf1.data
> > -rw-------. 1 root root 99692290 Oct 29 16:17 perf1.data
> >
> > root in 🌐 s83lp47 in ~
> > ❯ time perf record -- perf report -i perf1.data  > /dev/null
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.027 MB perf.data (246 samples) ]
> >
> > real    0m1.097s
> > user    0m0.082s
> > sys     0m0.167s
> >
> > root in 🌐 s83lp47 in ~
> > ❯ perf report --stdio
> > # To display the perf.data header info, please use --header/--header-only options.
> > #
> > #
> > # Total Lost Samples: 0
> > #
> > # Samples: 246  of event 'cpum_cf/cycles/P'
> > # Event count (approx.): 307500000
> > #
> > # Overhead  Command  Shared Object        Symbol
> > # ........  .......  ...................  ..................................................
> > #
> >      9.35%  perf     perf                 [.] reader__read_event
> >      4.47%  perf     perf                 [.] perf_env__arch
> >      2.85%  perf     ld64.so.1            [.] _dl_relocate_object_no_relro
> >      2.44%  perf     ld64.so.1            [.] _dl_lookup_symbol_x
> >      2.44%  perf     ld64.so.1            [.] do_lookup_x
> >      2.44%  perf     perf                 [.] down_read
> >      2.03%  perf     perf                 [.] hists__findnew_entry
> >      2.03%  perf     perf                 [.] perf_hpp__is_dynamic_entry
> >      1.63%  perf     [kernel.kallsyms]    [k] __s390_indirect_jump_r14
> >      1.63%  perf     [kernel.kallsyms]    [k] format_decode
> >      1.63%  perf     libc.so.6            [.] cfree@GLIBC_2.2
> >      1.63%  perf     perf                 [.] evsel__parse_sample
> >      1.63%  perf     perf                 [.] map__put
> >      1.63%  perf     perf                 [.] sort__comm_cmp
> >      1.63%  perf     perf                 [.] thread__put
> >      1.22%  perf     [kernel.kallsyms]    [k] folio_add_file_rmap_ptes
> >      1.22%  perf     [kernel.kallsyms]    [k] get_page_from_freelist
> >      1.22%  perf     ld64.so.1            [.] _dl_name_match_p
> >      1.22%  perf     perf                 [.] dump_printf
> >      1.22%  perf     perf                 [.] evlist__event2evsel
> >      1.22%  perf     perf                 [.] hashmap_find
> >      1.22%  perf     perf                 [.] perf_session__deliver_event
> 
> Hmm.. for perf_env__arch we could probably cache better:
> ```
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index f1626d2032cd..2591f71c7c42 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -593,17 +593,27 @@ static const char *normalize_arch(char *arch)
> 
> const char *perf_env__arch(struct perf_env *env)
> {
> -       char *arch_name;
> +       if (env && env->arch && env->arch_name_normalized)
> +               return env->arch;
> 
>        if (!env || !env->arch) { /* Assume local operation */
>                static struct utsname uts = { .machine[0] = '\0', };
>                if (uts.machine[0] == '\0' && uname(&uts) < 0)
>                        return NULL;
> -               arch_name = uts.machine;
> -       } else
> -               arch_name = env->arch;
> 
> -       return normalize_arch(arch_name);
> +               if (!env)
> +                       return normalize_arch(uts.machine);
> +
> +               env->arch = strdup(normalize_arch(uts.machine));
> +               env->arch_name_normalized = true;
> +       } else {
> +               char *normalized = strdup(normalize_arch(env->arch));
> +
> +               free(env->arch);
> +               env->arch = normalized;
> +               env->arch_name_normalized = true;
> +       }
> +       return env->arch;
> }
> 
> #if defined(HAVE_LIBTRACEEVENT)
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 9977b85523a8..da20bc3810bd 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -61,6 +61,7 @@ struct perf_env {
>        char                    *os_release;
>        char                    *version;
>        char                    *arch;
> +       bool                    arch_name_normalized;
>        int                     nr_cpus_online;
>        int                     nr_cpus_avail;
>        char                    *cpu_desc;
> ```
> or just force the normalize before assignment.
> 
> For reader__read_event and the perf_env these changes may be relevant:
> "perf sample: Remove arch notion of sample parsing"
> https://lore.kernel.org/r/20250724163302.596743-21-irogers@google.com
> "perf env: Remove global perf_env"
> https://lore.kernel.org/r/20250724163302.596743-20-irogers@google.com
> 
> I wonder if for some reason the env is NULL in your cases, so we go
> slow path a lot.
> 
> The histogram stuff, Namhyung may know more.

There only 2 entries for the hist code.  The hists__findnew_entry() is
expected as it's the main routine to aggregate the samples.  But the
perf_hpp__is_dynamic_entry() is strange.  It should be very small and
fast.

But I guess the actual problem is when you use -D in perf report.  And
it doesn't show hist related functions IIUC.

Thanks,
Namhyung

