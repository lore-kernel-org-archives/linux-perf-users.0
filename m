Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481F331EC4
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607726; cv=pass; b=OUQp54m2D/Hbmu/wIHYqOdcPDmZlzFH7G5kCH7HqYGttQCzpCJgJM00gLs1km440ufoZpODA4dS6pWIsEoC3zh2l3Gnuw2hTKoabZ8fU/KVZCZZ7MvNa8EaczHIXm9JQmoL9HCWieWfNRrUERjLw622esO9N2KG5P76lwCMtZ0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607726; c=relaxed/simple;
	bh=uvpmmf86Ror5+uMf95cqjr/CFnOw56omEVtA2la9oNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EznUSxZhtIQv6qcgg9Qu84EESXi4Is0CoUkVfPKMxkQhqHccIlSue1Ad8vVmeWuH+SG99lWZyKDlzEOaIoeyjdFGZlMwxKTEVmVbZB/tOnAOvgkaHMs7ecr48+a+fz8LsxiXH+ZZ1dNFJ8+Z1eelMx9MkWE50Q7d+T828PKp8bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OT9GnjXX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFpnzVKd; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OT9GnjXX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFpnzVKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783607724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8/MsYd9xv3C+Z/mhrJcgyYrlFsRbHWKRIi/utnxLZA=;
	b=OT9GnjXX+B4F/NBdy23437oASTpqpE0rZBpny/1UDtc+ZhGJcC+HQxrzKfdSIL9LL+SqQV
	j2Gvfzkgdare2r4/aY1chITXaMBahPQeFOXH5hQhii0EXBK4NbNe8p2uyEiJeKVjO1qJ8F
	b7qlqQmQl4kxE0pn36beualvXoGqQ4Y=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-Ty-Ind6lMTa2DpSo-e_69g-1; Thu, 09 Jul 2026 10:35:22 -0400
X-MC-Unique: Ty-Ind6lMTa2DpSo-e_69g-1
X-Mimecast-MFC-AGG-ID: Ty-Ind6lMTa2DpSo-e_69g_1783607720
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848415e9e8eso1693694b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 07:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783607720; cv=none;
        d=google.com; s=arc-20260327;
        b=GwkwEwpHm6xmdZRgb/WJsYQmdpnziDCWb5P6vWUpzILbrTm9s4Z8M4BGhylmEgOBlP
         Oz7z1AlB8gWrmbXQ/ujsKZS58h7xzx2qVhnHMFu+6M3DsKaNm3kjS2c23iQwIFU5BQgd
         2fRSGVC1n0VjvGmBjPsYxb5SuG6Yn+GQ9urx8XUbjcvRWQrsUwJ1hemFMmVR5Ve6W+11
         sv4m1DLAxoEGjUMcdVW/FmPtcmVxd0+Vl5zeFSBVaES+0hATg18UmqTrXPiW69+zEtEs
         oT7i7XnOuJhWZ5rKzZOBoQm6Ap5deeqwGKhSEJTKwr1ZaKhWcpoix3/Y/+mLROykaznj
         mUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s8/MsYd9xv3C+Z/mhrJcgyYrlFsRbHWKRIi/utnxLZA=;
        fh=kZdflkPKVZe4rXfzaI5W4CWDtXUqfxzPD4JaIh2iDwg=;
        b=nkdvCoWkYTBT8Mjm3Xvp8CZoxPkSWzRjV/Oz4MKOO9fm7tRXQxk+F3RU6MxXAc/q4F
         Lc/A/FkCwCFkw9IBU1NS6ofFmblVI/7bfswgbYAajIMBPrbT0e4Djc+LHO2KEL+K1DYG
         +RBD0ZIHX5FtNMEJiRnFH8YPQWd14XwU/CAD+lty9tbkM+sAzqLP49yIirAySNrafwDJ
         7HrCicECnf6z702+LiP+SZU258TAP7xMkCFG3JLS725B67mQriNY4eifdGeY7lZJ6sBu
         hkzIP1ZjWgjSwYzKX/6q198nc8WvaM/gpYryV+IXNEkMBwnB4w8IJq8F/Mxzb8UQjPjl
         Y7ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783607720; x=1784212520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s8/MsYd9xv3C+Z/mhrJcgyYrlFsRbHWKRIi/utnxLZA=;
        b=AFpnzVKd0jBoJQ79DifyfRZMcIhADDHvN9Ki0tqhfrlLMryhzdYWOpBKsM3AYNws1h
         vInImSctOL9MREyxpZz8+bqz4UM3AQv05l3JIfA2UevsSfO9yTyRpiDAlgYZdba8B7oi
         8Y6HwqdryFQ2i9Q4XHrYdAn+73CY3/TDX4snV0nxQb/BvwvWHDQeaG7LucZr8FqCXf6i
         1NDeN+9C6Cdg0ZyTye2RL8FYD9FPjx7FLzYraiXgZflKKewePnOYMLtWJo4Kd/6XxWny
         PUHpBs38Gmb+6pkNQapvTOholsp+JGQUMxJ0QT5gU2m4/vOG8p1/ulO3zJJA2suChrHF
         I+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607720; x=1784212520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s8/MsYd9xv3C+Z/mhrJcgyYrlFsRbHWKRIi/utnxLZA=;
        b=E9GovIPADKPj2+E5TawpbJ2g5qvNrlL5dEXU3+m7rRE+4smzlgqp/dIqvgnnKrJVWa
         Fnvb8WN+gGjjVoB2g5lCn877ySi8r3bGzhkkn8zJQyGWW0SD3jOlzIF2aVDGPnPJ39dW
         I0BOwPSHwQLcZFiRHNxsjkNFWBtk4j06hQWH0Za8nTh/9/H0WTDLTWkMn/z5tT325Pih
         ACoBPIyNAwFYrUEH2NzW48w+JdE+4LvCTVptFTxeXQhInN0pkByZPvFcmUlWy2svfW2N
         iWkshjTQvl+ewzCGYjPv5xJVa5er8RZhByeXHeAaAoC7/XEySftEvANHPJ0OnyQruhTK
         TdGg==
X-Forwarded-Encrypted: i=1; AHgh+RqNkH3KKDgIMSMysAL0T0KpN8rJtwI1WZnl+R5TlhLDPhhP0f9am7borEe+bbHwJSD9KPsgBe1cr8WF479I6ej7@vger.kernel.org
X-Gm-Message-State: AOJu0Yybm/5BsrbnX/ciSYT6K1W7UiipopOHNqWe1Dx8Q4K/rVI0Ip7V
	QLClTkNWeHsTRNJA70YQD//d/m/nn9AsoQ3QOc+KKfpS8rW2bvcIGcMAoCgVtXBl5rCuBjttFHc
	Sk+C+3GbP96BMod9nDIWyzZq7kQIiezcAuLMeRfUoUEc2Ar8ZUfb0gdsyvMnPF1ntYfBy7bQFBl
	ltAfsf49ToPFqiz01tNZdrIpN2qyYLSZ5V2K2r3VSRUPkLIw==
X-Gm-Gg: AfdE7cntG4/OzVy1VqBFAvEZw3a43FcO+zVic9cdumaIrJ/A9vaf33VAiC5MhJRQDKP
	BboKdCVrO6fte67kKr1WYI+nzxcIoWAjZpqpEFCEip2sUAo6ziq649VNRZd3rd6hjQr4Y+WTdLh
	Y6gRia9K7+SJlTjiNGM+tS6j7n4DVptsR6PpkW3lu5J/kuH0RQ19MhS4uxWK8rlOjCpwam3JHeM
	FKsJcaKFL9/YUHq0TK91MRnyjN50Q==
X-Received: by 2002:a05:6a00:945b:b0:848:4c0c:59b4 with SMTP id d2e1a72fcca58-8484c0c6fb6mr5295655b3a.64.1783607719535;
        Thu, 09 Jul 2026 07:35:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:945b:b0:848:4c0c:59b4 with SMTP id
 d2e1a72fcca58-8484c0c6fb6mr5295614b3a.64.1783607718871; Thu, 09 Jul 2026
 07:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701062321.517351-1-omosnace@redhat.com> <20260701064301.GH48970@noisy.programming.kicks-ass.net>
In-Reply-To: <20260701064301.GH48970@noisy.programming.kicks-ass.net>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 9 Jul 2026 16:35:07 +0200
X-Gm-Features: AVVi8CdnMfLqhIKvy56o8_SD9Qocw-Nxoh5cQ002HONZLt_pbLrPSx5HiVvWMOE
Message-ID: <CAFqZXNu+oea=wQ8PQRK4VzmEVQTjyVwjYO2FfkB_RgUrAr02Mw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Jul 01, 2026 at 08:23:21AM +0200, Ondrej Mosnacek wrote:
> > Making [parts of] the heap executable is dangerous and is blocked by
> > SELinux on Fedora/RHEL even for an unconfined user. Replace the malloc(=
)
> > + mprotect() combo with just mmap(), creating a private anonymous rwx
> > mapping, which only requires the more commonly allowed "execmem"
>
> I do not understand. Ultimately malloc() will have to use mmap() to get
> the memory too. So how is malloc() + mprotect() considered more
> dangerous?
>
> > permission under SELinux (things like JIT or regex compilation need it
> > as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
> > begins on a page boundary, so the result is equivalent to the original
> > code even without a memset() or the page-alignment dance.
>
> I would argue that having RWX is a problem, you really want RW->RO->RX
> transitions, so even with mmap() you want to combine with mprotect().
>
> Obviously this doesn't matter for this test case, but any halfway sane
> JIT should really avoid keeping RWX mappings around.

You're right, an RWX mapping in the heap range isn't really worse than
an mmap()-returned anonymous RWX mapping. I think the key difference
is that executable ranges in the heap are much less common, so can be
treated as a sign of malware and denied more strictly in the policy.
The "execmem" permission is triggered on any anonymous executable (or
file-backed private writable-executable) mapping, which would apply
even for well-implemented JITs and thus can't be restricted as
broadly.

So the point is just to not do the more weird thing (which will get
you blocked under SELinux even under unconfined_t), so that the test
can be run on a SELinux-enforcing machine without workarounds. In
hindsight, I should have thought about it more deeply and phrase it
better in the commit message, sorry.

>
> > Verified that the test still passes on a machine with an AMD CPU that
> > has the "ibs" CPU flag.
> >
> > Fixes: 35db59fa8ea2 ("perf test amd ibs: Add sample period unit test")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> The patch is obviously good, simpler is more better and all that. But
> the justification really smells.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> If and when we get AMD to support IBT, this thing will need more
> changes, but alas.
>
> > ---
> >
> > v2: fix mmap() failure check (found by sashiko-bot)
> >
> >  tools/perf/arch/x86/tests/amd-ibs-period.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/ar=
ch/x86/tests/amd-ibs-period.c
> > index 6a92b3a23ed7a..32713f8fcd5c8 100644
> > --- a/tools/perf/arch/x86/tests/amd-ibs-period.c
> > +++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
> > @@ -46,7 +46,6 @@ static int dummy_workload_1(unsigned long count)
> >  {
> >       int (*func)(void);
> >       int ret =3D 0;
> > -     char *p;
> >       char insn1[] =3D {
> >               0xb8, 0x01, 0x00, 0x00, 0x00, /* mov 1,%eax */
> >               0xc3, /* ret */
> > @@ -59,18 +58,11 @@ static int dummy_workload_1(unsigned long count)
> >               0xcc, /* int 3 */
> >       };
> >
> > -     p =3D calloc(2, page_size);
> > -     if (!p) {
> > -             printf("malloc() failed. %m");
> > -             return 1;
> > -     }
> > -
> > -     func =3D (void *)((unsigned long)(p + page_size - 1) & ~(page_siz=
e - 1));
> > -
> > -     ret =3D mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_E=
XEC);
> > -     if (ret) {
> > -             printf("mprotect() failed. %m");
> > -             goto out;
> > +     func =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE | PROT_EXEC=
,
> > +                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +     if (func =3D=3D MAP_FAILED) {
> > +             pr_debug("mmap() failed. %m\n");
> > +             return -1;
> >       }
> >
> >       if (count < 100000)
> > @@ -93,7 +85,7 @@ static int dummy_workload_1(unsigned long count)
> >       }
> >
> >  out:
> > -     free(p);
> > +     munmap(func, page_size);
> >       return ret;
> >  }
> >
> > --
> > 2.54.0
> >
>


--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

