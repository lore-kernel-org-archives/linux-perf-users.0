Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF075390CBF
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789769517; cv=pass; b=TJYwyzB27qvGaUO7j/a6eN57wlUFurVa38YqJrjvXrwyYfDi+p+ZzPZfoIINaOhKKExjGi2WI4QyVvVmQ6BenIQrBIstmOKHkqutFS9pYlROq16Oh7UzmELInTlvVYcUP7Iq/9eZZf/eBfVSqofsoGEfsq2o+5nCEdJdhCFsriY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789769517; c=relaxed/simple;
	bh=kH/5H7wHVaTfyhLr+jCv2ICNbgd320NnUaMIklfh2vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmvgnupOAqp40lk7ogBmMGf/4ldlAUKetQIzo3Fgof3qUzC1NqoZBnaIALkpl3oOvA4vTYVJyGP7bil6ND6sgYgp4vYjrzi1TES49ypFjBYYGXHcW7k8BVkXS6HNwvA1cAg6R82P7ogEwCKQ1RGl08G+Noc2GBRlrHG+PDEMw8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uzcl+/8l; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uzcl+/8l"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53113d72966so36921cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 15:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789769515; cv=none;
        d=google.com; s=arc-20260327;
        b=MDKzE/4qo/na7d0fdxwxonmj8f1CT55cMA1h/OaEmDdlMemE/rreC3qP0havurtztz
         XHcH+SGykwRKHMXRbff47k7EOW5z0urzCfhQdzjdXwI8Sz6z1Hz9RWaMztHsAthxONmo
         MQ8/1rApbYG+vr8adNRklhYl8SYhq/Yo2pd3EpZPRq/C6rHt25D+QC4zxwBdww0FdgxH
         htq5qv9D/hPMM08cTL0rlQnnDNajIDjXgfhrl1TDS6ArpLfUEPSikcWP7vJU7WAzIphG
         zkGSCkfZnosy2b4ZtuEoAEClHFQDmmKhJ7NEmet6A/ZErGAAamfxR8lS4e+NIBpRVu3F
         Ou7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3w8yPxnoH+MaPX/teja8tKZWHTNqwthcQOYMTttGn9I=;
        fh=8nRAWMt3732clF2ehHmjz/bPwfQInQmnDDr6UpFggN8=;
        b=qEfOU+BGDbGm/03gxQ+XqGcf3cw9N8VwSFDOSXcqN11MGKyqQ9EUttcwFAl6x5jnAQ
         0lYqnDZxuqpIbyjgacFpKpbuulxTaXLJAv1btkUgv06P57WUOkUtOxWjRQ6b+d7B7nzZ
         n/3yGx2R0P3dB1dlHTvtJfYkVrqOucij2OtyGBMwCVnDskHalTo8PyNoilRR+dm2wVhc
         E3MVbKk8rvp3pyWkD3WoipReQ/1q8PKCaeian9NxxXn5RfXwgwZCWZbUmbSnBJnuL+qM
         YP7z83D3Zs9OFymP1BJODp4/g2bxqCJPQx9pPxbgDSlFjc7xhBwAyiDJFf0zzbYtI2iu
         UmHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789769515; x=1790374315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3w8yPxnoH+MaPX/teja8tKZWHTNqwthcQOYMTttGn9I=;
        b=Uzcl+/8lbx21fhBfI5ylt8oalnHL90tgq5LSB2Q67ZlCNxCjagpGeU92lBv2V9z1Op
         XeVn7XtOfN2OvqKJn2wI2vhgKoBcvN9jtvHUkhx9ab6ovHsIJ3/dDp/xI04I9FkRpiZJ
         lRaDORN0amKY9khIBprQWbadcsE45FevnEcWLpuUFtRqIAMGbot4smJ12+r6Rkt5MAc2
         8mpQOuw6ThUebxm4XEVnPZQnz9eJh1qpmRG4zblhh3HK7xxzJh7Z+FBjznO+Kzf3+pPk
         N0bTkiwecggUQF4ziTg9zbJ+jkaU8SJY8H1wk1iQUNt/NP5ncICko2NpoVMwhaAtPmqm
         9TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789769515; x=1790374315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3w8yPxnoH+MaPX/teja8tKZWHTNqwthcQOYMTttGn9I=;
        b=ims/hnfGYOTB4FMgAMsC5AX7LOuHdHz1qTGDV/IfIwLKVm4cfQLLdiouA2389k9ERo
         OfIZvXMadTRMY7aznwvIZZSUCeYa56/PXMf9RP0fGYhyc9nq6faKQHleqByFor9HXRPp
         0Nj0Hxskv1t56EJmfWVFrlqBTFqaZHdGoVRVGGJuAP/0qxboP0UpwLylp0J5n4k8lUX/
         SetybPdEvsoUenvty7RQ6jSgnPz5uWFh1LNGTp7yXRmQPlb/YODCNWgUutLEhgj2hyOD
         BeZL9hPOh5HmB3YNdIpGFajK+nhj+ITL/brUzaTwkc8jtngRbqS4g7xauXXd8J4UEG4U
         9h9A==
X-Forwarded-Encrypted: i=1; AKwUvBz2PeXZf9WdIr/zP1DEV2chpn4bLPmJinRcR1uADO/41B4xUNBwkCywnekwXeCk9BGVeYpa0YvyIgra/h8JD+WS@vger.kernel.org
X-Gm-Message-State: AFuF++m7rBWZoj445jxFxe6FAkOF6COFHSxQIDBkW48aF9mhvv8uY8Cz
	8mecAgwLo+2wA2Q2w88xyk9GIobaERTuS0pfyjbprDowLq8LEUya973RobZvvar5v/ap70DH9Mc
	2yOWH6OttdkfpQCC/rez74TkUZa3XxPBHGsTPnV49
X-Gm-Gg: AYBFou34cSCPSZMHYAxN/h+fpDCki8Oiij0E44rFALvH4WfKBNZyEpUpLkr1JUcDfxf
	W1b6XglMPR8l2qUw2xIDiGyuujgfmTDyUJ/ha1qeDeMamAqYkeHmjueIAdbG4fwqWacJDg6iLj4
	VS8HO7NT5UkBSs3CZuGCp3ZWwKQs89t7ahO84TeZT9VSz1ug6szzSYt41F7PXRCpWP3WgqILSuV
	yOtoaZmUK3pOPEaSa+MzfVXp/RRQNIHErACexkbc3WIU7yoBEIAhzPGI17sST/4wmvlsuk+k3WT
	I4qZlVgEb/Jhuh7rLafCkQGa7S7GPMALgk0WO8xxq0y3owKIuTEhbl3yK86mZ2vl3YmxJldUFXX
	V0Le7x227uA==
X-Received: by 2002:a05:622a:480c:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-532af5c84ddmr5911441cf.10.1789769514153; Fri, 18 Sep 2026
 15:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
 <aq2hq_Fw6fn0rGkm@x2> <aq20APrOz60O4n8B@x2> <CAP-5=fWVgNCD4FAA=xRJ75s31T=0dkn-3AM-v_FszP0yAMopGQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWVgNCD4FAA=xRJ75s31T=0dkn-3AM-v_FszP0yAMopGQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Sep 2026 15:11:42 -0700
X-Gm-Features: AcwNN1V-m-8R4zViVFhjvp_lL3WaIWQsckUP7YKPFMVJaxOFzntk5TbFMyKcyPo
Message-ID: <CAP-5=fXoti3ZeSmxzeLcCReqb+6ws0vfOJgvMm9KvKScFsAzmw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] perf report/top: Add opt-in --hybrid-merge
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 3:07=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Sep 18, 2026 at 2:58=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Sep 18, 2026 at 05:40:15PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Wed, Sep 16, 2026 at 10:06:59PM -0700, Ian Rogers wrote:
> > > > On a hybrid machine a wildcard event expands to one event per core
> > > > PMU, so "perf record -e cycles" records cpu_core/cycles/ and
> > > > cpu_atom/cycles/. perf report and perf top then show one histogram =
per
> > > > PMU, and a symbol that ran on both kinds of core is split across th=
em,
> > > > with each percentage relative to its own PMU's total. There is no w=
ay
> > > > to ask for the single combined profile.
> > > >
> > > > Add --hybrid-merge to perf report and perf top, which merges the
> > > > histograms of the events that came from the same wildcard into one,
> > > > with percentages taken against the summed period.
> > > >
> > > > Merging is opt-in because it isn't always the right thing to do. Th=
e
> > > > cores differ in performance, so a merged cycles count mixes work do=
ne
> > > > at different rates and a merged IPC is not the IPC of either core
> > > > type. perf-tips notes this. When merging is possible but wasn't ask=
ed
> > > > for, the TUI says so, rather than merging silently.
> > > >
> > > > core.hybrid-merge in .perfconfig turns it on by default. As a defau=
lt
> > > > rather than an explicit request it yields to the command line: with
> > > > --hierarchy it is ignored with a warning, whereas asking for both
> > > > --hierarchy and --hybrid-merge on the command line is an error. For
> > > > the same reason it is silent when there is nothing to merge, so it
> > > > doesn't warn on every invocation on a machine with a single core PM=
U.
> > > >
> > > > perf stat is deliberately untouched. Counting already has its own
> > > > merging options, and this is aimed at sampling.
> > > >
> > > > The events to merge are found with first_wildcard_match, which pars=
ing
> > > > fills in. perf report reads events from a file rather than parsing
> > > > them, so there the wildcard grouping is recovered by matching event
> > > > names, and core PMUs are identified from the perf.data header topol=
ogy
> > > > so that a file recorded on another machine is read correctly.
> > >
> > > Thanks, applied to perf-tools-next, for v7.4.
> >
> > I tried 'perf top --hybrid-merge" on this machine:
> >
> > acme@x2:~/git/perf-tools-next$ grep -m1 "model name" /proc/cpuinfo
> > model name      : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
> > acme@x2:~/git/perf-tools-next$
> >
> > That is hybrid and it didn't merge anything, just told me that:
> >
> >                        =E2=94=8C=E2=94=80Warning:=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> >                        =E2=94=82--hybrid-merge: no events to merge acro=
ss core PMUs=E2=94=82
> >                        =E2=94=82                                       =
            =E2=94=82
> >                        =E2=94=82                                       =
            =E2=94=82
> >                        =E2=94=82Press any key...                       =
            =E2=94=82
> >                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> >
> > What am I missing?
> >
> > I merged this, so we can continue from there,
>
> Are you sure it is hybrid?
> https://www.intel.com/content/www/us/en/products/sku/124968/intel-core-i7=
8650u-processor-8m-cache-up-to-4-20-ghz/specifications.html
>
> $ sudo perf top --hybrid-merge
> ```
> Samples: 43K of events 'Merged hybrid events { cpu_atom/cycles/P,
> cpu_core/cycles/P }', 1250 Hz, Even
> Overhead cpu_ato cpu_cor  Shared Object                                 S=
ymbol
>    3.92%   0.00%   5.84%  perf
>  [.] rb_next
>    3.50%   0.01%   5.21%  perf
>  [.] __symbols__insert
>    1.94%   2.20%   1.81%  libc.so.6
>  [.] __memmove_avx_unaligned_e
>    1.18%   0.56%   1.48%  [i915]
>  [k] fw_domains_get_with_fallb
>    1.13%   2.43%   0.50%  chrome (deleted)
>  [.] 0x000000000c462020
>    0.83%   0.00%   1.24%  libc.so.6
>  [.] __strstr_sse2_unaligned
>    0.78%   0.01%   1.15%  perf
>  [.] str_isascii
>    0.74%   0.02%   1.10%  libc.so.6
>  [.] __strlen_avx2
>    0.63%   0.00%   0.94%  perf
>  [.] rb_insert_color
>    0.61%   1.11%   0.36%  libc.so.6
>  [.] __memset_avx2_unaligned_e
>    0.61%   0.09%   0.86%  libc.so.6
>  [.] _int_malloc
>    0.58%   0.73%   0.50%  [kernel]
>  [k] audit_filter_rules.isra.0
>    0.51%   1.11%   0.22%  chrome (deleted)
>  [.] 0x0000000007139cca
>    0.49%   0.66%   0.41%  [kernel]
>  [k] kernel_init_pages
>    0.47%   1.03%   0.20%  chrome (deleted)
>  [.] 0x0000000007139cd4
>    0.47%   0.52%   0.44%  [kernel]
>  [k] __sched_balance_update_bl
>    0.46%   0.00%   0.69%  perf
>  [.] dso__load_sym_internal
>    0.45%   0.79%   0.28%  [kernel]
>  [k] __schedule
>    0.44%   1.21%   0.06%  chrome (deleted)
>  [.] 0x0000000007139dbe
>    0.41%   0.00%   0.61%  [kernel]
>  [k] damon_ptep_mkold
>    0.39%   0.56%   0.31%  [kernel]
>  [k] __audit_filter_op
>    0.38%   0.00%   0.56%  libstdc++.so.6.0.35
>  [.] 0x00000000000c61cb
>    0.37%   0.00%   0.54%  perf
>  [.] rust_demangle_legacy_dema
>    0.35%   0.01%   0.52%  libc.so.6
>  [.] __strncmp_avx2
>    0.34%   0.00%   0.50%  libstdc++.so.6.0.35
>  [.] 0x00000000000c61ee
>    0.34%   0.24%   0.38%  [kernel]
>  [k] _raw_spin_lock
>    0.34%   0.64%   0.19%  [kernel]
>  [k] psi_group_change
>    0.33%   0.00%   0.50%  libstdc++.so.6.0.35
>  [.] 0x00000000000c61e4
>    0.30%   0.70%   0.10%  chrome (deleted)
>  [.] 0x0000000007139db3
>    0.28%   0.38%   0.23%  [kernel]
>  [k] __update_load_avg_cfs_rq
>    0.28%   0.40%   0.22%  [kernel]
>  [k] native_sched_clock
>    0.28%   0.00%   0.42%  libc.so.6
>  [.] __libc_calloc2
>    0.28%   0.00%   0.42%  [kernel]
>  [k] page_vma_mapped_walk
>    0.26%   0.00%   0.39%  perf
>  [.] symbol__new
>    0.26%   0.54%   0.12%  [kernel]
>  [k] enqueue_task_fair
>    0.25%   0.00%   0.37%  libstdc++.so.6.0.35
>  [.] 0x00000000000c86f8
>    0.25%   0.07%   0.34%  [kernel]
>  [k] __list_del_entry_valid_or
> Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)
> ```

Listing the PMUs would be useful:
```
$ ls /sys/bus/event_source/devices/cpu*
/sys/bus/event_source/devices/cpu_atom:
caps  events  freeze_on_smi               power  subsystem  uevent
cpus  format  perf_event_mux_interval_ms  rdpmc  type

/sys/bus/event_source/devices/cpu_core:
caps  events  freeze_on_smi               power  subsystem  uevent
cpus  format  perf_event_mux_interval_ms  rdpmc  typ
```

Thanks,
Ian
