Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457143B42EE
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789769264; cv=pass; b=NTfkbz+OV5ySjCKk52py/har5zszLCp3vJlDgXyamB2F7aCBlMKaD08J/p5Hd35rQkgXwiBYeM1VRnxj4P+boJg1KDTFKFQ7bOqnSZjy/XgUvPavUhRkk+CLW4bTR1HJcKzjH/az8QpJod8w34SiRqzJVyMQdPJmO8/8rclI1TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789769264; c=relaxed/simple;
	bh=GwyXYFIMoMYyu8c15amZzUEca1lf8mlHFfUbGqIp2+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGfHF+CU9oCH6ukLQOEzhVAkUVTUIkAEf93Bl86siiaYndU7vSKmFf4Jh7slcDCFMtu8cHOtJt54TMDt+o/9ur7+ySx6aUp12FQeqoKel3Mpiv0pt+Djx8U6aznQ0ecEM12Ylra5fgBQZVI0ek5cVJZwj5oBUdzLW1hDcioCFXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqgNl9Eg; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqgNl9Eg"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-530f6bcc301so74651cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 15:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789769262; cv=none;
        d=google.com; s=arc-20260327;
        b=gJtmhRoVYksaxg7Xdp6T41u/wGGF79WUsCB2soqDUwryI/kyiGiGFAnHLV7yUTJgEf
         MtYpXJr3jGr30nsY0h+x+z78wSoggrAq3kjgm7hnGxwnuncI7OmoEQvz0a/M26/z7koM
         B7a02C3Nli36GeM//D7qtaPB2IfVOhDm8frWimXaqlP4K+AORAcmHavSE7vOF6RqO3+d
         gOSv14HZptcG3NXzh1MCxMkbTsfWsm/cjJL88QMAMBu9PZQrVc+uHwMejPsrKqMlZtZD
         2YIiJscp/oXrDjF+oEs6IlOek8rTxrWxrcfS0sRMmxtuNbIlJ6pZRTmgLX25qbeCerzc
         oQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rjv8U4gDsHE9830l1vKgA0MFHzJlm/5bZViULOdwUo4=;
        fh=MqAIB48u85pCD0tXoEzXt/uxj4IWT7+ubrZILS4SYWc=;
        b=X5yTXY1cn8oUa5lsYvmsDRhE7N1uBkPlBq3wxTW0CchTgdmc6GjQElKsmorBRs6RyR
         fu4WDzPcabY3jrijpntJkWCuWI+pVm2mGFUdrB96ve/zyK2KVCU7cDM7HTvVM1Z+6gjh
         WvgRYatF4aA+OLdpLeq9a2YGdHtjYH6AeEzGQcD+5zvg1IkLwXpYVrZYClHQTSbTh3Az
         bVu5Kx+DhdekNcIakRFlQA5f8wk50Ohcd8Ir/36+c/BHbMYMRqnMBTiQrkcCZh9QDfFp
         1QeAugB0BMjQ3bODso3WhaFFBeQUdeNLqJJwIlOt09DsBCuc6zw9rg/atA+Mf1omdx8t
         u5JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789769262; x=1790374062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rjv8U4gDsHE9830l1vKgA0MFHzJlm/5bZViULOdwUo4=;
        b=SqgNl9EgKhDLvxC38SW8t1bV+SuY3EnuB5W5x+sGr4f8F1FbeTo7Y2AOL+48Es9EJj
         ZdiJF1xGeMs3Yod7Ce9TXM4oV38R283sHPl7LcZ8c9x4GUNF2NTFZq/MVGqFn7o1yVNg
         Qb8j16BAj4pEcfC7jNlpsQ4NqvaXo1ridXKB9ned3YY+3+Gq7XyySF1uZOvoqOmPDvc4
         mZ6FKg4cIApM9zb+Yie8EFUu/mIZdVHdheG9RUvk/tq0mdF42Bod5eRE89J+X9YuXg8u
         mS547TQaJkDQLD2/rAOj5o/TuddlEawn9MYRbgqGQRdkFjcPh4NSAy4tgxqACBK3Qs62
         buyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789769262; x=1790374062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rjv8U4gDsHE9830l1vKgA0MFHzJlm/5bZViULOdwUo4=;
        b=VcOqshFMF/k7eLbJBXBOtd+2AuamJsJGxYcteEOZ6MtSA+8I+q541bqdLw5wVOTSY2
         qJ+YY+0BYNR2NoUvx+X1FbTmhd6oNMwmDPVM7oKkSdBOt+k6EC1z8eARk+62Oj+VwE+b
         E2RDPN0+tdhbgYEN8IifkZaokqUeKa9Vpc0yEhNjdo1R+yk16N2R/0d1Ciec1ISpO8Bs
         ikJtmDCNp9yDFQNBnt2V3QVWXDNTdCvHeNuO855844s1I7oMcdkWtU4bdSkrS9685RNg
         Ml2x1Xv/wkEdMKCyJyZGAxCDs4E0btdW1a+yZPRZK2VBoftjytZeTBA502Zm1rx/yECq
         hMjA==
X-Forwarded-Encrypted: i=1; AKwUvBwP44IhyDGOn6JD0o67qeDz4rrnmj/Ew96N6mgno2TS9v+1DCsK99Ojwqq52N0kNxbxFnmALFFeKQVxQX+XSG7l@vger.kernel.org
X-Gm-Message-State: AFuF++kFKRZrieoAuXnL4wLzDv04s1ZRkEH8Slm6k1n/1Q3XG9Lr2LvG
	P9/ywkoqTDPnOpYYx6J7chWjsNXC1iCsFv4QqpI4XSVt2idXFqEGMmFehAE0eB1uscOqIIr9uJf
	ihanER++VUOECFS+PwGrfQrMSgwuxakT8fQU0Nb8j
X-Gm-Gg: AYBFou3JzOf3hPxtSeczngY0uXu93rzfXor2zOLbDKZLBd2tOrxSeyq/U2f4HKoQQuU
	bl9At8k4POESi1fV+q36eF8VkIMnUKAv5EYHla7r4+bHaNXHNsOQqKWPf5zdFVajghhhbtXrYgg
	++xA0M1T6VSznWnfqeOXtmIvzuGAVMSHjL+pCc41d/P93dnHjiSNVLb+Dxhqa2tpwe7zuHBhJ6u
	LYLz/j1PzJ+JVL3gDYA62C8PmhiEIhnbscuZpboXuvh4YZ9RvBnWWjE+9ZC7Z1Mt+PS3/HsGdaI
	cMT+dMCFz4F9ymLrp1gDXKgHJbAQIcJTR6Hz9+PobjIUVSfgFW1/xg+HnPt9ABjS7V+hH9i32xP
	Ler8cr7l9D9dcYNErUpcn
X-Received: by 2002:ac8:5d08:0:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-532b099561dmr1781291cf.11.1789769261431; Fri, 18 Sep 2026
 15:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
 <aq2hq_Fw6fn0rGkm@x2> <aq20APrOz60O4n8B@x2>
In-Reply-To: <aq20APrOz60O4n8B@x2>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Sep 2026 15:07:30 -0700
X-Gm-Features: AcwNN1XupbNEAkqoFCSQpRGKuYf88RlP7rsf12hbz_l0pZHUujSiI81NadjVu78
Message-ID: <CAP-5=fWVgNCD4FAA=xRJ75s31T=0dkn-3AM-v_FszP0yAMopGQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] perf report/top: Add opt-in --hybrid-merge
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:58=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Sep 18, 2026 at 05:40:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Sep 16, 2026 at 10:06:59PM -0700, Ian Rogers wrote:
> > > On a hybrid machine a wildcard event expands to one event per core
> > > PMU, so "perf record -e cycles" records cpu_core/cycles/ and
> > > cpu_atom/cycles/. perf report and perf top then show one histogram pe=
r
> > > PMU, and a symbol that ran on both kinds of core is split across them=
,
> > > with each percentage relative to its own PMU's total. There is no way
> > > to ask for the single combined profile.
> > >
> > > Add --hybrid-merge to perf report and perf top, which merges the
> > > histograms of the events that came from the same wildcard into one,
> > > with percentages taken against the summed period.
> > >
> > > Merging is opt-in because it isn't always the right thing to do. The
> > > cores differ in performance, so a merged cycles count mixes work done
> > > at different rates and a merged IPC is not the IPC of either core
> > > type. perf-tips notes this. When merging is possible but wasn't asked
> > > for, the TUI says so, rather than merging silently.
> > >
> > > core.hybrid-merge in .perfconfig turns it on by default. As a default
> > > rather than an explicit request it yields to the command line: with
> > > --hierarchy it is ignored with a warning, whereas asking for both
> > > --hierarchy and --hybrid-merge on the command line is an error. For
> > > the same reason it is silent when there is nothing to merge, so it
> > > doesn't warn on every invocation on a machine with a single core PMU.
> > >
> > > perf stat is deliberately untouched. Counting already has its own
> > > merging options, and this is aimed at sampling.
> > >
> > > The events to merge are found with first_wildcard_match, which parsin=
g
> > > fills in. perf report reads events from a file rather than parsing
> > > them, so there the wildcard grouping is recovered by matching event
> > > names, and core PMUs are identified from the perf.data header topolog=
y
> > > so that a file recorded on another machine is read correctly.
> >
> > Thanks, applied to perf-tools-next, for v7.4.
>
> I tried 'perf top --hybrid-merge" on this machine:
>
> acme@x2:~/git/perf-tools-next$ grep -m1 "model name" /proc/cpuinfo
> model name      : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
> acme@x2:~/git/perf-tools-next$
>
> That is hybrid and it didn't merge anything, just told me that:
>
>                        =E2=94=8C=E2=94=80Warning:=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                        =E2=94=82--hybrid-merge: no events to merge across=
 core PMUs=E2=94=82
>                        =E2=94=82                                         =
          =E2=94=82
>                        =E2=94=82                                         =
          =E2=94=82
>                        =E2=94=82Press any key...                         =
          =E2=94=82
>                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
> What am I missing?
>
> I merged this, so we can continue from there,

Are you sure it is hybrid?
https://www.intel.com/content/www/us/en/products/sku/124968/intel-core-i786=
50u-processor-8m-cache-up-to-4-20-ghz/specifications.html

$ sudo perf top --hybrid-merge
```
Samples: 43K of events 'Merged hybrid events { cpu_atom/cycles/P,
cpu_core/cycles/P }', 1250 Hz, Even
Overhead cpu_ato cpu_cor  Shared Object                                 Sym=
bol
   3.92%   0.00%   5.84%  perf
 [.] rb_next
   3.50%   0.01%   5.21%  perf
 [.] __symbols__insert
   1.94%   2.20%   1.81%  libc.so.6
 [.] __memmove_avx_unaligned_e
   1.18%   0.56%   1.48%  [i915]
 [k] fw_domains_get_with_fallb
   1.13%   2.43%   0.50%  chrome (deleted)
 [.] 0x000000000c462020
   0.83%   0.00%   1.24%  libc.so.6
 [.] __strstr_sse2_unaligned
   0.78%   0.01%   1.15%  perf
 [.] str_isascii
   0.74%   0.02%   1.10%  libc.so.6
 [.] __strlen_avx2
   0.63%   0.00%   0.94%  perf
 [.] rb_insert_color
   0.61%   1.11%   0.36%  libc.so.6
 [.] __memset_avx2_unaligned_e
   0.61%   0.09%   0.86%  libc.so.6
 [.] _int_malloc
   0.58%   0.73%   0.50%  [kernel]
 [k] audit_filter_rules.isra.0
   0.51%   1.11%   0.22%  chrome (deleted)
 [.] 0x0000000007139cca
   0.49%   0.66%   0.41%  [kernel]
 [k] kernel_init_pages
   0.47%   1.03%   0.20%  chrome (deleted)
 [.] 0x0000000007139cd4
   0.47%   0.52%   0.44%  [kernel]
 [k] __sched_balance_update_bl
   0.46%   0.00%   0.69%  perf
 [.] dso__load_sym_internal
   0.45%   0.79%   0.28%  [kernel]
 [k] __schedule
   0.44%   1.21%   0.06%  chrome (deleted)
 [.] 0x0000000007139dbe
   0.41%   0.00%   0.61%  [kernel]
 [k] damon_ptep_mkold
   0.39%   0.56%   0.31%  [kernel]
 [k] __audit_filter_op
   0.38%   0.00%   0.56%  libstdc++.so.6.0.35
 [.] 0x00000000000c61cb
   0.37%   0.00%   0.54%  perf
 [.] rust_demangle_legacy_dema
   0.35%   0.01%   0.52%  libc.so.6
 [.] __strncmp_avx2
   0.34%   0.00%   0.50%  libstdc++.so.6.0.35
 [.] 0x00000000000c61ee
   0.34%   0.24%   0.38%  [kernel]
 [k] _raw_spin_lock
   0.34%   0.64%   0.19%  [kernel]
 [k] psi_group_change
   0.33%   0.00%   0.50%  libstdc++.so.6.0.35
 [.] 0x00000000000c61e4
   0.30%   0.70%   0.10%  chrome (deleted)
 [.] 0x0000000007139db3
   0.28%   0.38%   0.23%  [kernel]
 [k] __update_load_avg_cfs_rq
   0.28%   0.40%   0.22%  [kernel]
 [k] native_sched_clock
   0.28%   0.00%   0.42%  libc.so.6
 [.] __libc_calloc2
   0.28%   0.00%   0.42%  [kernel]
 [k] page_vma_mapped_walk
   0.26%   0.00%   0.39%  perf
 [.] symbol__new
   0.26%   0.54%   0.12%  [kernel]
 [k] enqueue_task_fair
   0.25%   0.00%   0.37%  libstdc++.so.6.0.35
 [.] 0x00000000000c86f8
   0.25%   0.07%   0.34%  [kernel]
 [k] __list_del_entry_valid_or
Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)
```

Thanks,
Ian

>
> - Arnaldo
>
