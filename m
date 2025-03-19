Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1119D060
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397984; cv=none; b=l3lBdBJCaB2Bhu9eSg7vJH76jRAxKAgDHDW5x18Qa/wNN/DUXhxGILqy0liKmNsi/qXsrYw3401Sk8hxhp4zBeYl619rssu3EwLWsBKWGDZrBWeKzW7ldUyL9k3Vxu6jOPQhPchIbxbsoTtq1pkbFcksEsx/VXyiaC5B6GrJ6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397984; c=relaxed/simple;
	bh=TJc6GEdzfrQTXrQb+nB6Ax7HL4bpylZDVIOcRc0/Ggg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8Rhgmi0H2U0EmjHfmVlL51bgRvyXNsNoeXN7DIGrxkZtawIlCo5oriqW4+LpyO5SV9vtnTUCqEUix5mL5Oa1EfXAEnvajdAL0MC32nAOJRRAmGYkfs3LQtgGDdPED2o9kIAH3A7Re2aCQU9aeXmlGRZYob2swVYvRdfQb8SJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvAWOivU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvAWOivU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2242ac37caeso161125ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742397982; x=1743002782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYaF0ff/Yi3Ale9Nu1xalogAPL2g2IBAsiVN/ev7Ku8=;
        b=KvAWOivUf9NuQDoqqDGjCksLTI6ldsHYgw6fETv1prLvG6Tr6Q3iUIDo43Gn4zu2OS
         /HTkptDAC+Sgc/2aheZU8+LWnUaE0FTJ4Fwe3HguUtVaXjeqYdt+lKS07uzlMfNlsyBY
         Nw5ZCvKqSwSW44DlsGbJw4m0Na0pz9psDzi5/BWUCb+yF5872VERBNNSDHTvTH/nG6XN
         bvqdyZtB6wIro2EQf1aeBUZnJdojZFRJI1vCEX3LA/0/wmwuoGU+0wvnzutmP3p1ODIt
         +5jIgJSlziGPwxSFCveJYpKoBJj6FLNrlqVQT74VRZSgFTFGYuFmJjqhz8lPvpFejZuA
         uK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397982; x=1743002782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYaF0ff/Yi3Ale9Nu1xalogAPL2g2IBAsiVN/ev7Ku8=;
        b=mbRGuDkbBend6m49jv2t7MH/O4rCxqJ662S+U/mRz8PrJhLgoZlxHifqs8rKHlbFID
         NRnTDSPQVXEy9vAuhtcOAWVu5g/l5G2WuELrepWrCSeVasX4P4ybkGFPV9PyllA31TNe
         Z1zvfPNaWOlcP9cVDsugTtYwM0i6TKhgTcF5m3Rgh85N8ONI3kSqlu3aoFSCREokccfS
         v8/a7wKk2bsN87hojSnejVGgPbchqGXpjz3RFyyDWVHtV0Ig4o1HhCinrRYTjDXQeNah
         j4+0rrFP87bgrjyEX+esCzJ7jx2IX1NsjZ/Ml0DsIymDqFSHyXfVQcRIBA3wFlG2QdYH
         bciw==
X-Forwarded-Encrypted: i=1; AJvYcCWN+765onDLNfXIDNKIw4JGo5I0nJR1BB+Lz5nFwt2WqspChoWDcNWGF1v0cMgLWCoGHpiEbBPtvrq/ezBzLazS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3Pq6y3fRQNExJCsoPrGeNFSJQ8s1XRxOh3MBiTisQf5MaMn+
	tQ3VjuhBurwEMiYV6XB2H/37gmvDUBnBdtRyUIQF7022qkhJSYeua8Mi7u28U/Ha6CpkvR5RJYo
	3pwJ7y5v2djq9VK/lh039U/gLYjXkDpw3aNHO
X-Gm-Gg: ASbGncsagbehiYz01iS5pPBFUFkDmI9eUsIwYDnyoiyXEVxmiTJW6bZ3U6yCtMigH8j
	L5fv6KgLpeGfJ2966MbstkVRDgVOXitBEOxA+CVSHdfC2RVMLOKt96R+fZVPS+adDa995FAOgx8
	h6+OjFdTW2tjuiLuGMCjBkuQn+/XruaalAq5I/Rqrlu7W+vltfmfvA5A==
X-Google-Smtp-Source: AGHT+IGQmQvzCBQcZf/PLZrr52Zl8i9GSp7lUOU21uxYRVAyqe/D0zvnh5WwPiFqu1nkpy9F7XwyowyAFm/ndngRTek=
X-Received: by 2002:a17:902:e5c6:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-2264c444e7dmr1793975ad.0.1742397982247; Wed, 19 Mar 2025
 08:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319110454.3230687-1-leo.yan@arm.com> <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
 <20250319133055.GA3249206@e132581.arm.com>
In-Reply-To: <20250319133055.GA3249206@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Mar 2025 08:26:10 -0700
X-Gm-Features: AQ5f1JpMyrmPYY_Z8298WFyJPIC7vF3DvUH63JKKzbOfSy3d5Xhg2SmQL4sujOg
Message-ID: <CAP-5=fUp492RATRhc-OmikK7knO+PUWAt6Z-60Cax0QOJPrFgg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Restore {0} initializer since GCC-15
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 6:31=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Mar 19, 2025 at 11:19:38AM +0000, James Clark wrote:
> >
> > On 19/03/2025 11:04 am, Leo Yan wrote:
> > > GCC-15 release claims [1]:
> > >
> > >   {0} initializer in C or C++ for unions no longer guarantees clearin=
g
> > >   of the whole union (except for static storage duration initializati=
on),
> > >   it just initializes the first union member to zero. If initializati=
on
> > >   of the whole union including padding bits is desirable, use {} (val=
id
> > >   in C23 or C++) or use -fzero-init-padding-bits=3Dunions option to
> > >   restore old GCC behavior.
> > >
> > > This new behaviour might cause stale and unexpected data we defined i=
n
> > > Perf.  Add the -fzero-init-padding-bits=3Dunions option for entirely
> > > zeroing union structures.
> > >
> >
> > Do we need this? I don't see any unions initialized in that way. In fac=
t
> > there is only one struct initialized with {0}, the other handful are ch=
ar*s
> > but I don't think either are affected.
>
> Though I did not found a straightforward case in Perf for initializing
> union with "{0}", the result I got:
>
> $ git grep -E "\{ *0 *\}" tools/perf/
> tools/perf/arch/x86/tests/insn-x86.c:   {{0}, 0, 0, NULL, NULL, NULL},
> tools/perf/arch/x86/tests/insn-x86.c:   {{0}, 0, 0, NULL, NULL, NULL},
> tools/perf/arch/x86/tests/intel-pt-test.c:      {1, {0}, 0, {INTEL_PT_PAD=
, 0, 0}, 0, 1 },
> tools/perf/arch/x86/tests/intel-pt-test.c:      {0, {0}, 0, {0, 0, 0}, 0,=
 0 },
> tools/perf/arch/x86/util/perf_regs.c:   char new_reg[SDT_REG_NAME_SIZE] =
=3D {0};
> tools/perf/arch/x86/util/perf_regs.c:   char prefix[3] =3D {0};
> tools/perf/builtin-kwork.c:             .nr_skipped_events   =3D { 0 },
> tools/perf/builtin-record.c:    u8 pad[8] =3D {0};
> tools/perf/python/twatch.py:                    print("cpu: {0}, pid: {1}=
, tid: {2} {3}".format(event.sample_cpu,
> tools/perf/tests/code-reading.c:        unsigned char buf1[BUFSZ] =3D {0}=
;
> tools/perf/tests/code-reading.c:        unsigned char buf2[BUFSZ] =3D {0}=
;
> tools/perf/util/bpf_counter.c:  struct bpf_map_info map_info =3D {0};
> tools/perf/util/bpf_kwork.c:    char name[MAX_KWORKNAME] =3D { 0 };
> tools/perf/util/bpf_skel/bperf_follower.bpf.c:  struct bperf_filter_value=
 child_fval =3D { 0 };
> tools/perf/util/lzma.c: char buf[6] =3D { 0 };
> tools/perf/util/mem-events.c:bool perf_mem_record[PERF_MEM_EVENTS__MAX] =
=3D { 0 };
> tools/perf/util/mem-events.c:   char hit_miss[5] =3D {0};
> tools/perf/util/trace-event-scripting.c:        char xs[16] =3D {0};
> tools/perf/util/zlib.c: char buf[2] =3D { 0 };
>
> We can see the bpf structures (bpf_map_info/bperf_filter_value) are
> initialized with {0}.  For a more complex case, {0} is used for
> initialize a specific field in a structure (see the results in
> insn-x86.c and intel-pt-test.c).
>
> > Adding options that allow people to add more non standard code doesn't =
feel
> > very portable or in the spirit of doing it the right way. Maybe there's=
 an
> > argument that it guards against future mistakes, but it's not mentioned=
 in
> > the commit message.
>
> I think Linux perf shares the same understanding with "we do expect
> initializers that always initialize the whole variable fully" (quote
> in [1]).  Furthermore, the reply mentioned:
>
>  The exact same problem happens with "{ 0 }" as happens with "{ }".
>  The bug is literally that some versions of clang seem to implement
>  BOTH of these as "initialize the first member of the union", which
>  then means that if the first member isn't the largest member, the
>  rest of the union is entirely undefined.
>
> So I think it is reasonable to imposes a compiler option to make
> compiler's behavouir consistent.

We have encountered this problem, here is a fix for a case:
https://lore.kernel.org/r/20241119230033.115369-1-irogers@google.com
It would be nice if rather than -fzero-init-padding-bits=3Dunions there
were some kind of warning flag we could enable, or worse use a tool
like clang-tidy to identify these problems. In the linked change the
problem was identified with -fsanitize=3Dundefined but IIRC perf didn't
quit with a sanitizer warning message, just things broke and needed
fixing.

Thanks,
Ian

> Thanks,
> Leo
>
> [1] https://www.spinics.net/lists/netdev/msg1007244.html
