Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B745000
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772661; cv=none; b=d4BcEVfKU/NGsztRcMuQx0N02Z9trYgq/rLY3e9Y7eeTT6mSoWv8lVp8ej/i3zqKEPJDEayDeObe2gtYpDn0LEEJodVK0hRQi+QtqsilD2JDcxs69v+9tb8LNb9ylx3JZcWSWY+T49XnTwhJ0H4FAPIYjdPXG3TWBBOKl0iPufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772661; c=relaxed/simple;
	bh=gUjSWFdRVEFZg0pG+oWgq/8MeKA5QnAQmqh+ClWTINQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sLsnXkvKNr4JtfD2ANzqgXCVYelwmp71yd1G/4HAb5mSmGwNUn3V8ZkVPNWvgfoHPNEH+geG4SDf1sFufGpbUp7HdHxX2ErGbjmUBeGBujHqC0xFtwmBxeQ+JQYH+ZblcvrrkilAWfGHQA94fx0dBv4TvbJsQNwDNqz0RGSxpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuwrNboA; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuwrNboA"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e53002bso722393e0c.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789772659; x=1790377459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=26royRNo3tiQaFJpWL3WAZZAFaDwmU13i9Gn7nFpvik=;
        b=PuwrNboAyChbpXy2jWalXaGhw3E0q15yQnTaiyxjfCsB28rjKxHqkhVlQVg+4LaTYE
         dndAV2IaXddDPrMaqbNv9VW4TDzXICxqDnEC/X0oHRLiTsQwKPn2D/dXhXRtdwAzuNAT
         LaajBJ/Eeg5IKUX4ffYwCtY5seoZG2BE99CzUeh4qXD20LwJDvH96ysh2t6eLyq3/nM8
         yC8Cdn1eSMn6HRCMZbokTgONncrlUaspoz0o43hrbX5YPipOhI2FxGeSo3dlfIp8wPyD
         YlB0l3KZrC2M3WLjkwaZHTwXuWVrZsQWa0hxVCO5U7PZptfkIOI/5A6JSvmQNk3U4jLW
         3kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789772659; x=1790377459;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26royRNo3tiQaFJpWL3WAZZAFaDwmU13i9Gn7nFpvik=;
        b=AsnWTsohjc4adItt3Api+G4V9ASlAfGEE502oSrUBxLR4H5nVZix8F9YKOLWtEc3mS
         tVq4yc4FP0rX4a/Usc7HGn6DfY5IdvO2G4CsnNOqMLIQpzEsdDZiTfSqRYWM2B37io/2
         t9Qth3UqPdBWvd8Y1cTvHHfed4VzeQPUQRfsTN4bAgtTj4E24adtq1d0cc+29qMIfdPR
         T6irTHRd+rcefbGaJ1vigGidWtDLtbJi/YQsyvcS7Pd+2ak38ckNTmfAJnky7/rvy0JK
         e4eq1ZAsVlMZvOuNdYPHxjFRWAfAfxxoqToY1CVfIJ+I4JZSLFV0+t33WsOILAMkLX9q
         fFPA==
X-Forwarded-Encrypted: i=1; AKwUvBxU6LMPxu6a0ldBGFIRm9SdhKIMcawRaUcvK31dplFZDrPpZyMY9YXjN163eELPpxFsSZ1X8Haj/VLbOxmc2tbj@vger.kernel.org
X-Gm-Message-State: AFuF++k7WPUEApJr0Z9OggQumN+TA3wUTEfj6wRJfpVynZME5jzFSBaM
	Vqt6YMKmydVu44reH30LghDi2RLGdtPA/by4jLWYr5qSnHy6K7GD0Nfr
X-Gm-Gg: AYBFou3Mp5Q8TWHAAnCq1oxi+MpLR4xEV4JVgEdY8EyMWNUioBb1diIJ/9kEvt6VuMc
	Azd9QIgGsDz2A4OW3BVtRCd2DQDc46baXioTnLB+/WiA41YbY0wZ7dQ/+WZq1SwfRbNkdYynmEf
	vlGMOnyoirinsB9F0TebfGsUBlwNvdu7cZ5FpM6z9Ru8m68NbjdAdPQbBBDD0O0jz5yhD+S8Ff/
	n5yLDpKe3Vci111E12W9pAuH5mmgXQHSb9rRmDyXIpmuHWTXGGFQwTq0OIjsPldK5QA45r/WmpI
	q61dlwxQpVzN2ks/8HrxAdN1uzlQ6dMWhs06ld3k/bHUKEY+Mb5/nWA71KM62HNYg5tGfbsw4QO
	MuUCa0ZnaEtRLZOfYZQ4IMT27gqgDwZrHms9jPa0HDQCzJDH3iutr65taDR+/0J1xp5YsuJdsLP
	ARONA5524ADEjCM6SmqiDLeZrAbYqhTWqBdzOpD6B/fVyBrl+HeoQnogbpBzKmFTQ3AQvuKviBe
	gGdExGOoW4JN2M=
X-Received: by 2002:a05:6122:6b94:20b0:5c9:c435:e927 with SMTP id 71dfb90a1353d-5c9c435e942mr38411e0c.1.1789772658690;
        Fri, 18 Sep 2026 16:04:18 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:451c:6a2d:9d31:3221])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-984d52bcbeasm913403241.3.2026.09.18.16.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 16:04:16 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:04:12 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: namhyung@kernel.org, ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 0/9] perf report/top: Add opt-in --hybrid-merge
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fWVgNCD4FAA=xRJ75s31T=0dkn-3AM-v_FszP0yAMopGQ@mail.gmail.com>
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com> <aq2hq_Fw6fn0rGkm@x2> <aq20APrOz60O4n8B@x2> <CAP-5=fWVgNCD4FAA=xRJ75s31T=0dkn-3AM-v_FszP0yAMopGQ@mail.gmail.com>
Message-ID: <E4B5E312-BD1F-4C33-A5F0-36813AA4E391@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 18, 2026 7:07:30 PM GMT-03:00, Ian Rogers <irogers@google=2Ec=
om> wrote:
>On Fri, Sep 18, 2026 at 2:58=E2=80=AFPM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> On Fri, Sep 18, 2026 at 05:40:15PM -0300, Arnaldo Carvalho de Melo wrot=
e:
>> > On Wed, Sep 16, 2026 at 10:06:59PM -0700, Ian Rogers wrote:
>> > > On a hybrid machine a wildcard event expands to one event per core
>> > > PMU, so "perf record -e cycles" records cpu_core/cycles/ and
>> > > cpu_atom/cycles/=2E perf report and perf top then show one histogra=
m per
>> > > PMU, and a symbol that ran on both kinds of core is split across th=
em,
>> > > with each percentage relative to its own PMU's total=2E There is no=
 way
>> > > to ask for the single combined profile=2E
>> > >
>> > > Add --hybrid-merge to perf report and perf top, which merges the
>> > > histograms of the events that came from the same wildcard into one,
>> > > with percentages taken against the summed period=2E
>> > >
>> > > Merging is opt-in because it isn't always the right thing to do=2E =
The
>> > > cores differ in performance, so a merged cycles count mixes work do=
ne
>> > > at different rates and a merged IPC is not the IPC of either core
>> > > type=2E perf-tips notes this=2E When merging is possible but wasn't=
 asked
>> > > for, the TUI says so, rather than merging silently=2E
>> > >
>> > > core=2Ehybrid-merge in =2Eperfconfig turns it on by default=2E As a=
 default
>> > > rather than an explicit request it yields to the command line: with
>> > > --hierarchy it is ignored with a warning, whereas asking for both
>> > > --hierarchy and --hybrid-merge on the command line is an error=2E F=
or
>> > > the same reason it is silent when there is nothing to merge, so it
>> > > doesn't warn on every invocation on a machine with a single core PM=
U=2E
>> > >
>> > > perf stat is deliberately untouched=2E Counting already has its own
>> > > merging options, and this is aimed at sampling=2E
>> > >
>> > > The events to merge are found with first_wildcard_match, which pars=
ing
>> > > fills in=2E perf report reads events from a file rather than parsin=
g
>> > > them, so there the wildcard grouping is recovered by matching event
>> > > names, and core PMUs are identified from the perf=2Edata header top=
ology
>> > > so that a file recorded on another machine is read correctly=2E
>> >
>> > Thanks, applied to perf-tools-next, for v7=2E4=2E
>>
>> I tried 'perf top --hybrid-merge" on this machine:
>>
>> acme@x2:~/git/perf-tools-next$ grep -m1 "model name" /proc/cpuinfo
>> model name      : Intel(R) Core(TM) i7-8650U CPU @ 1=2E90GHz
>> acme@x2:~/git/perf-tools-next$
>>
>> That is hybrid and it didn't merge anything, just told me that:
>>
>>                        =E2=94=8C=E2=94=80Warning:=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>>                        =E2=94=82--hybrid-merge: no events to merge acro=
ss core PMUs=E2=94=82
>>                        =E2=94=82                                       =
            =E2=94=82
>>                        =E2=94=82                                       =
            =E2=94=82
>>                        =E2=94=82Press any key=2E=2E=2E                 =
                  =E2=94=82
>>                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>>
>> What am I missing?
>>
>> I merged this, so we can continue from there,
>
>Are you sure it is hybrid?

You're right, this is an older machine, the hybrid one needs repairing the=
 screen and I'm using this one that indeed isn't hybrid, sorry about that=
=2E

It's pushed already, I'll be traveling tomorrow but will continue processi=
ng patches=2E

- Arnaldo

>https://www=2Eintel=2Ecom/content/www/us/en/products/sku/124968/intel-cor=
e-i78650u-processor-8m-cache-up-to-4-20-ghz/specifications=2Ehtml
>
>$ sudo perf top --hybrid-merge
>```
>Samples: 43K of events 'Merged hybrid events { cpu_atom/cycles/P,
>cpu_core/cycles/P }', 1250 Hz, Even
>Overhead cpu_ato cpu_cor  Shared Object                                 S=
ymbol
>   3=2E92%   0=2E00%   5=2E84%  perf
> [=2E] rb_next
>   3=2E50%   0=2E01%   5=2E21%  perf
> [=2E] __symbols__insert
>   1=2E94%   2=2E20%   1=2E81%  libc=2Eso=2E6
> [=2E] __memmove_avx_unaligned_e
>   1=2E18%   0=2E56%   1=2E48%  [i915]
> [k] fw_domains_get_with_fallb
>   1=2E13%   2=2E43%   0=2E50%  chrome (deleted)
> [=2E] 0x000000000c462020
>   0=2E83%   0=2E00%   1=2E24%  libc=2Eso=2E6
> [=2E] __strstr_sse2_unaligned
>   0=2E78%   0=2E01%   1=2E15%  perf
> [=2E] str_isascii
>   0=2E74%   0=2E02%   1=2E10%  libc=2Eso=2E6
> [=2E] __strlen_avx2
>   0=2E63%   0=2E00%   0=2E94%  perf
> [=2E] rb_insert_color
>   0=2E61%   1=2E11%   0=2E36%  libc=2Eso=2E6
> [=2E] __memset_avx2_unaligned_e
>   0=2E61%   0=2E09%   0=2E86%  libc=2Eso=2E6
> [=2E] _int_malloc
>   0=2E58%   0=2E73%   0=2E50%  [kernel]
> [k] audit_filter_rules=2Eisra=2E0
>   0=2E51%   1=2E11%   0=2E22%  chrome (deleted)
> [=2E] 0x0000000007139cca
>   0=2E49%   0=2E66%   0=2E41%  [kernel]
> [k] kernel_init_pages
>   0=2E47%   1=2E03%   0=2E20%  chrome (deleted)
> [=2E] 0x0000000007139cd4
>   0=2E47%   0=2E52%   0=2E44%  [kernel]
> [k] __sched_balance_update_bl
>   0=2E46%   0=2E00%   0=2E69%  perf
> [=2E] dso__load_sym_internal
>   0=2E45%   0=2E79%   0=2E28%  [kernel]
> [k] __schedule
>   0=2E44%   1=2E21%   0=2E06%  chrome (deleted)
> [=2E] 0x0000000007139dbe
>   0=2E41%   0=2E00%   0=2E61%  [kernel]
> [k] damon_ptep_mkold
>   0=2E39%   0=2E56%   0=2E31%  [kernel]
> [k] __audit_filter_op
>   0=2E38%   0=2E00%   0=2E56%  libstdc++=2Eso=2E6=2E0=2E35
> [=2E] 0x00000000000c61cb
>   0=2E37%   0=2E00%   0=2E54%  perf
> [=2E] rust_demangle_legacy_dema
>   0=2E35%   0=2E01%   0=2E52%  libc=2Eso=2E6
> [=2E] __strncmp_avx2
>   0=2E34%   0=2E00%   0=2E50%  libstdc++=2Eso=2E6=2E0=2E35
> [=2E] 0x00000000000c61ee
>   0=2E34%   0=2E24%   0=2E38%  [kernel]
> [k] _raw_spin_lock
>   0=2E34%   0=2E64%   0=2E19%  [kernel]
> [k] psi_group_change
>   0=2E33%   0=2E00%   0=2E50%  libstdc++=2Eso=2E6=2E0=2E35
> [=2E] 0x00000000000c61e4
>   0=2E30%   0=2E70%   0=2E10%  chrome (deleted)
> [=2E] 0x0000000007139db3
>   0=2E28%   0=2E38%   0=2E23%  [kernel]
> [k] __update_load_avg_cfs_rq
>   0=2E28%   0=2E40%   0=2E22%  [kernel]
> [k] native_sched_clock
>   0=2E28%   0=2E00%   0=2E42%  libc=2Eso=2E6
> [=2E] __libc_calloc2
>   0=2E28%   0=2E00%   0=2E42%  [kernel]
> [k] page_vma_mapped_walk
>   0=2E26%   0=2E00%   0=2E39%  perf
> [=2E] symbol__new
>   0=2E26%   0=2E54%   0=2E12%  [kernel]
> [k] enqueue_task_fair
>   0=2E25%   0=2E00%   0=2E37%  libstdc++=2Eso=2E6=2E0=2E35
> [=2E] 0x00000000000c86f8
>   0=2E25%   0=2E07%   0=2E34%  [kernel]
> [k] __list_del_entry_valid_or
>Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)
>```
>
>Thanks,
>Ian
>
>>
>> - Arnaldo
>>

- Arnaldo 
