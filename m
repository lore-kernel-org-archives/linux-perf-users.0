Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0E4266AE
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516455; cv=pass; b=G8+GP+DAQQ3nSxOOBSgt+LrOiVw5JQwgc4DDBVq7HdJfywUsaZtX1r6GO1UV3M1dOqM3ma7EZz3FeuIOo8719bBvdTsXimgWR3XtvRQCadMim07LVyIHKlf9KYttCvC4qO5DVTEN8DapbQDYsillp0ngONPZ/7NJETCoktRYCbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516455; c=relaxed/simple;
	bh=fq2Ai4WcxbGwkTN7PXC8BGmDjaKXz46Ccz1irxh3nJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/ULOWgd71iTLNvyyhgcHlcLII3X8qnXs1gRPJvEZ43RkorXtYLqsXJOx8KAuDLV6IOak+kMBicT0vLzK5+CghKKDvjO22YTiL8GZxukOlcl9gjXoGWcHFBChwAUeVPukqMKMo6LXVjKYeXWUfsdFu20hrJzDFqUUEhBZYR7nNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sYwEkZIT; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sYwEkZIT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso875ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 09:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778516454; cv=none;
        d=google.com; s=arc-20240605;
        b=GK4OvXCfUMmVAFv3EPX+rcdOrBCxFLf6p40XVATQdxxPsuNW63HK02kkz1jhgy2oAy
         GPqvIKjb2u3h6I61WuQDWDTanTfUNgjWKa+F//z2rID3bZgPn6fv5FiYLzuP/AFgjxJg
         vdXEqS051G2Y5mck4SOBoEyLEsZiL8Kaz/N+0IZA+IruTt8NlWLmCPERqZ75vA/buVWX
         i4cBYGf/cxj9cswy8ubUvlztw1BGz+QGRpgRqeNe8WuQ9K2tZWyx7DPepfsavjA5rCX9
         pKrI4tAuAfQx0Ie10fOQGuIkOdHz0MmWmc+QShiURjuPTIGTgFbg070rU3KxvG+5MxrJ
         iwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PvEvtdFY5ghOdqCADYDX8FFT4I10hTRam2EHdeelhm4=;
        fh=aAPgaO97fZ+ZN+zsIAOZVr/rk0MlaXq3B0GOMoIrfqM=;
        b=hURBplnXMoVBVmOcs9FbJ5K9j4n74/l7iYCuB2i6t9xeIZqJ3sn/hUwam4+x7xH/sL
         h5WB0gT+j4fsvRByDGzvH2cGd7GAjzZnPu8gO8RqcZg8YDwCEoX9/c4FuKyUbWj3Hedo
         wzBV9LNfw54am1AB33OQViYdF6p3gn++RNH/sH79gs9C+mDosYI6OpccH6qo5xjYHagZ
         5q9ZYwsR0NnbmE5Lzh+o5MnKVWqXc3s2S7lKQNFJ4l5KLgU60O277C175V4hQDdtFs/I
         4pZMk0tDj+JGoYnIYr+XBem0Jp0rYDaq4f4psB7FVtgZQ5DQ/0h+d4z8fTYrYD9YLs+o
         lfrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778516454; x=1779121254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvEvtdFY5ghOdqCADYDX8FFT4I10hTRam2EHdeelhm4=;
        b=sYwEkZITug6/eq5ned1YRgtjfMxiqbbVkUh3yNS0RVj9k5UYcBBHeyFe9ixjDaZnq8
         N/xUjkJxY4OGZ4n4NKo8Q+DgQ0JH3DTO+TEO45fq3PkBP4h5PHuIOVj6X8t60ih5vRSn
         k3gEcD6eFWKIZdcgBsKQp0qjWwicrqgbnwVaXiTtAyWpFVKlnfbnFDGNePV4aYa5FdPZ
         zfEB/WxW+ehqd5fwyZ8YJBMq9qFwtYb4TaUvPc7F2cNoGV3e0XQUf+wcFWPJP0maK7Rv
         PiAwLLvGYHLUoxXftxHdR0FQTmplFa+ZbCnDj2Avk/OJDKFfvrMrNbQYI73PhdCQ/0bk
         xxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516454; x=1779121254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvEvtdFY5ghOdqCADYDX8FFT4I10hTRam2EHdeelhm4=;
        b=X0scKjIHbJxwZ8bstSOu3INGravnIt+IcEAaMd/O6vM38Fi50rQn67c2nYad/K/CEb
         TxIA6Sq/LH6D3BE1VQKWQi7QY0AJasUnykagWBjwvs9u1XZVQUqjHFg6NTH3ISChA+GG
         0HxIZ01GAVlkPoKiB6rWXxMadF1KLmOscOF3mmRtZLC3PffuL98q4G02PKxI+3jTH78F
         Jkx5SyA2PsdqE9NI86de98tVm4WBgm1ptpG6ZggvwP2KQKscNfi35s2D8AbkmBoNRndi
         FI2DCeDEzVUW8lL3hLZviYFxo/rU1Y4z+p/4KQemBJIV41ikJutvNk2W5oq0JzWWwl89
         FWUg==
X-Forwarded-Encrypted: i=1; AFNElJ9kWKTjlnT3o0Wr1QUOKFNdiwwsD5uu4KKC9Ch5toDXFdF9ZXIRqBiHCAK4ZycpstBaju1cLe9/FONmOXfa2U1I@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpubyy7mPhu5VWaSiBK8k/NqpQaWMrsn9JurWjv1tJpaz5RCf
	dWXHrAR7/mRhv2tfEJnFv3y5Dtfn87tpQ1D/aTnJtrvKZ3AYhIEa9mJ6kKHR/x+lzTJ/UruDVni
	6kuz9keLgFoHenjvCqtlIy/LWkeHUxeRbkD2cEsoz
X-Gm-Gg: Acq92OELKjjE0hwZ/b6OsPr5VZLo/BReieCzG3S6r7eU6HoEdMLkrItOG/QV3h18KXS
	V/MZArk7Vqk+OQ37nyp4zw4xfUK2+MdXLSKFCBA+ccznAWhTigol5KYzycYdd5hvCJAdLeDdRcj
	vCuaSWm4rXfhOMidEpXMASofsgqASyvhrYDEz5Ig/r8izQAZQLbvLGucnfK7IEDgW66qpD0zBZp
	wg9HuJk+fLquWY+5+Vx/JKTf3d5LnvmtVj5uNwwPoOWbcdKeQWoajafQw2QPxiHkEYBiDP1wi9Y
	e3nduYk6dGO+6cdEy7ywBzuSpVBvO9uwSBq0bPtzjC4NgnJF
X-Received: by 2002:a17:903:94b:b0:2b0:b0c9:96e2 with SMTP id
 d9443c01a7336-2bc786ac4d5mr5000195ad.21.1778516453217; Mon, 11 May 2026
 09:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506000018.3113599-1-irogers@google.com> <20260506041004.3196084-1-irogers@google.com>
 <CAP-5=fUPdg3vu1orm_k9ZTQVgvs+vQa2Q-+gc-TkLPnqEjH7DQ@mail.gmail.com> <afs8FC96SNDD4DcM@x1>
In-Reply-To: <afs8FC96SNDD4DcM@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 May 2026 09:20:39 -0700
X-Gm-Features: AVHnY4J63GgtKgF53HXGYzUkKwTY-87ynT9KAu1D6Xjz27VLdQR6fzMM2c01lnY
Message-ID: <CAP-5=fXVM=ZsPVX1rZJX=5an2QhQaT1Jnmum9U6=XeRXk6G3zw@mail.gmail.com>
Subject: Re: [PATCH v4] perf sched stats: Fix segmentation faults, memory
 leaks, and stale pointers in diff mode
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: atrajeev@linux.ibm.com, james.clark@linaro.org, namhyung@kernel.org, 
	adrian.hunter@intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	venkat88@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 6:03=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, May 05, 2026 at 11:45:56PM -0700, Ian Rogers wrote:
> > On Tue, May 5, 2026 at 9:10=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > The patch addresses multiple segmentation fault vectors, out-of-bound=
s
> > > reads, and memory leaks in perf sched stats by adding bounds checks,
> > > NULL checks, proper error propagation, and robust memory cleanup.
> > >
> > > 1. In get_all_cpu_stats(), added assert(!list_empty(head)) to prevent
> > >    unsafe list_first_entry() calls on empty lists, added a missing NU=
LL
> > >    check for summary_head->cpu_data allocation, and implemented a cle=
anup
> > >    ladder using a temporary list to prevent memory leaks on error pat=
hs.
> > > 2. In free_schedstat(), fixed memory leaks by ensuring internal domai=
n_data
> > >    and cpu_data pointers are freed.
> > > 3. In show_schedstat_data(), fixed a stale pointer issue where ds2 re=
tained
> > >    its value from a previous iteration when dptr2 became NULL, and ad=
ded
> > >    proper propagation of errors from get_all_cpu_stats().
> > > 4. Propagated show_schedstat_data() errors up to perf_sched__schedsta=
t_diff()
> > >    and perf_sched__schedstat_live() to prevent output corruption on f=
ailure.
> > > 5. In show_schedstat_data(), added NULL checks for cd_map1 and cd_map=
2
> > >    to gracefully handle invalid or empty data files.
> > > 6. Added parallel iteration termination checks using list_is_last() i=
n
> > >    show_schedstat_data() for both domain and CPU lists to safely term=
inate
> > >    at the end of each list when files contain a different number of C=
PUs
> > >    or domains.
> > > 7. Added CPU bounds checks (cs1->cpu >=3D nr1 and cs2->cpu >=3D nr2) =
in
> > >    show_schedstat_data() to prevent out-of-bounds reads from cd_map1 =
and
> > >    cd_map2 when comparing files from machines with different CPU coun=
ts.
> > > 8. Added NULL checks for cd_info1 and cd_info2 to prevent crashes whe=
n
> > >    a CPU has data samples but no corresponding domain info in the hea=
der.
> > > 9. Added domain bounds checks (ds1->domain >=3D cd_info1->nr_domains =
and
> > >    ds2->domain >=3D cd_info2->nr_domains) to prevent out-of-bounds ar=
ray
> > >    accesses in the domains array.
> > > 10. Added NULL checks for dinfo1 and dinfo2 in show_schedstat_data()
> > >     to prevent crashes when a domain has no corresponding domain info=
.
> > > 11. Zero-initialized the perf_data array in perf_sched__schedstat_dif=
f()
> > >     to prevent stack garbage from causing perf_data_file__fd() to att=
empt
> > >     to use a NULL fptr when use_stdio happened to be non-zero.
> > >
> > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > This version passes sashiko's scrutiny:
> > https://sashiko.dev/#/patchset/20260506041004.3196084-1-irogers%40googl=
e.com
>
> Thanks, applied to perf-tools-next, for v7.2.

Thanks Arnaldo! I don't see this in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/?h=3Dperf-tools-next
just wanted to make sure it didn't accidentally get lost.

Thanks,
Ian

> - Arnaldo
