Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F6345CCE
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096416; cv=pass; b=Xx/ZNZ/0uCSCG+ui3bhnx1LY1XJE9XPOIv9PxIu6goCX+/CARHp4CMsSlSNDJikkoIhHMStUFxWJ3AKPAQDctjJ7Dk7kV9BFZSbURna5l0/Bgq+7P84BiGaV1HFXII/mujnkeZdgWImh+BmACT4Uhjpufk9EvCCOB4UnLz4HDis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096416; c=relaxed/simple;
	bh=Nh11KCvv29s1wzVo2hjgCVz2jvRdnaGOg1wLpMrLhVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ef/xgMaOfqaS6N1NeCctlzSkGXRb8yEEP4JsNsIMql3hyk60VvjLxTUhek+//JxzgIUMik9thVE+Q61PMFvfl0HYBNgSY7JWftUmYwoSOGSRPHrOevnq7JFgmpmt5GFV7jCggi1v4awT5a8oZsvQoJ+SJskrmv8m7Cf1yh5duxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhc3Pn4G; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhc3Pn4G"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53113d72966so2431cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 10:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790096413; cv=none;
        d=google.com; s=arc-20260327;
        b=h57q4BK5v5qbi2fU6oS+qg55AnV9lGIF3kz03LjaJYgCx6vDLX4Rdvp2O8AYRuEPQV
         JGfF6FVKc4GhwnxVAi737YD9AHaPp3qwlZi10AFFc56yNJt+qT7PybJK1tneOZoPravr
         6vwe0wv8gihd806oYb/AHTFNQkCQxXC7xc6FpPm/yt6o5uy7u6vOHgH89W4oXjlD8KC8
         m25W6hXB02yiqJDdXAzm4IBXbVxC7AtKuDj5U5ZLiIoC5DNh1Qp7pxjnrf0nwISZEQIO
         MJ86BzQczWNZZs+8rnvEXYhniR6KhGPrpGZu6Au5CLLpyLPaZ6Qsf1GVpQssmolrOpkW
         PPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HhXuMRWtj4EoahoIpvu3m5yJyJGMHZPq0qdJI+IBC5I=;
        fh=Sl1i+60YrkRhjpLaJ1Se3cJPuxZ33GJzuho0m3FAOUs=;
        b=mu2xZGNDOfwgxOr826gJEU5ySLXVjKsyQnEvPDeUgqJ8/bXsqqzqBg7JPttcOWZP2v
         EZefx9LzbJprLkQkKkEAVjKLHbyVAC+r7EE5nt+jvyZ3cCH6eJ3DFPWyexCcgQjo6F0M
         RY1fGBJwi1+zPxSeb+vGZVn6BD0hEva6bxzUkdKFy1HwJKmlLpwuYk1kpRXHrsWdCgw6
         iYAQ5GB4zUsbaMrB8sqVBmZPOpuoEwqxDF55DsisDBSveW4qwcy56GOyCM5ZLmkwYr6Q
         /w+wTZRs0/fkNs6GmrG2ZNftB+i3LioFrA+zvjkghFCCZQXJmrTZY8ZkLHgq7hMdQEpF
         jfiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790096413; x=1790701213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HhXuMRWtj4EoahoIpvu3m5yJyJGMHZPq0qdJI+IBC5I=;
        b=qhc3Pn4G1bov55QzP9fmVML/eJ+6EFqXCpolstAt26yFMS10M2Ku6NIPUVhlN2r4PY
         JfiVU13R0OdQIyzPGe4kcojq7qD2U9eSq5A1wIoqRkGD6JnwmLRf+dRnYHY6FCRAXQPa
         CCsdHnV8o0MOB4//Bs37393j3/Xar2yKwsfyiKUx/WhJ/AAJZ8zGR1ikmmISEij7oAxq
         oAFpTqEDZ87zbuTkf0zoMPDt1sifh76g+you7Qw/4bh655LypXmDjZEkHU6JS0iPqbsL
         jogjnSpv8czqWn1ejPYBVVBj5lLDis3tlW6ii4LgDKuVhLBoRQG/DmWDf58QN0FKekNZ
         iPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096413; x=1790701213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhXuMRWtj4EoahoIpvu3m5yJyJGMHZPq0qdJI+IBC5I=;
        b=AFIdHZUD2yolu7zB3SNIqr5T14JkWygdYk8NyUPlVtm0JVMSqxHVo3DzJlY+pyFtgU
         pBq9wl01n0pJh/exlN0SrwcNZiatZa30U4FZE9Yu8e9Lx2QBLuAeT1G2+xjcAvoi8tmT
         TAN5Pck3Gv31lo0C0Nw6FAuL9hng4A81+dmOcbrL3xbvEWMv12VE4CyEDIeieQ/4WXgJ
         p+cesGQjK9YUtg2SIql1KAq2Ljf49aerzVQzDTbbPbodamMi4Fc3FEtk8Nz4kCgrnWtd
         4TDQGjE6QBd/JDLb9ncvtgQ/aLgb74dY3iEP27H2MXexq02nGlfrmbfO+/WiBuiCX0VH
         SFGA==
X-Forwarded-Encrypted: i=1; AKwUvBxICF5FnXUipJZDb0kJueHKlXhw6oL6/W2ev+83yyr1R6oa/gKamKZJpIjnD/I+SPyE6rJfBVAlUDSs9mxOVRFH@vger.kernel.org
X-Gm-Message-State: AFuF++mfFlIQXY4fT+ydyoQCNF3CEPH1UZA6dGczfiT8vjQfPcc79xhg
	x3LP4LFVcMTfLCAFWyEi33ONI2hiIW4eCLEEl+E+a7t7qMoLD/aOUzG9lrb03pOmyS3tPEYbc8x
	bR5Gk08NjN5PaSysXbdVS6sGUj8cuUuEyERsBkcK6
X-Gm-Gg: AYBFou3M6Y3mswGIDdwcND3jVAu7+XQYdd6MmpkNp4JFaLBtonjhJ/VX6QaDaogyOi3
	LOeDalwlNucON9VohUwLI1t5NKi3gBQk432sbtJ/9jzOIuJDTTMmcaWx9FtPvRb4Z85mwzVvXm1
	qRufUB/Ej9JUeIVQ/Y1FXrFgnegE9nOfMqJj0+MmLEAth9eCAmQ2VqZvWXnI9T2mFa/Xjv2hYSV
	rS/e947zlqv7xzWU6Fg/v1JoDi7Tx7WJcTcquISX39fj5P7p5P//M1TZmnQt35yqwMxZYfkQdq7
	1Yp2blvxqP3CFQt6C/r6v7eCGrJ7VAUIa7DZIo+eNq9ZLINd9AybkLeJv4eCP6/Pf9PXLVBR+H4
	k9QkmMG/mR/2SWZzG3Q==
X-Received: by 2002:a05:622a:4d09:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-532ebb77793mr114661cf.4.1790096412307; Tue, 22 Sep 2026
 10:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <b1d417e1f28afa565fa01b4997e3c31140e4772d.1789966896.git.irogers@google.com>
 <8e3ed898-5134-40df-84b0-b7cdaa777731@linaro.org>
In-Reply-To: <8e3ed898-5134-40df-84b0-b7cdaa777731@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Sep 2026 10:00:00 -0700
X-Gm-Features: AcwNN1UI-VG5bkPxC40nmqZB4RtDB35hxd84ZBx_ZtNi24VFwq2lDUI0HWTpv5E
Message-ID: <CAP-5=fUxfMNAaScod0YBXf3ThZ1rbwA1AEhhvBVFFqDR6H6Ang@mail.gmail.com>
Subject: Re: [PATCH v2 09/49] perf python: Add Intel PT call_return and itrace capability
To: James Clark <james.clark@linaro.org>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 6:11=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 21/09/2026 06:06, Ian Rogers wrote:
> > Add support for Intel PT call_return events and itrace options to the
> > perf Python extension so standalone Python scripts can decode and
> > inspect low-level instruction traces.
> >
> > Specifically:
> > - Add a call_return callback parameter and itrace option string to
> >    perf.session, treating explicit None (Py_None) callbacks as omitted.
> > - Expose the perf.call_return object with db_id, parent_id, insn_count,
> >    cyc_count, comm, pid, tid, call_time, return_time, branch_count,
> >    call_ref, return_ref, flags, and call_path (resolved as a
> >    perf.callchain ordered from outermost caller to callee).
> > - Export perf.CALL_RETURN_NO_CALL, perf.CALL_RETURN_NO_RETURN, and
> >    perf.CALL_RETURN_NON_CALL flag constants.
> > - Expose session.e_machine and session.is_64_bit properties, preferring
> >    recorded thread ELF machines (perf_session__e_machine) over perf_env
> >    so pipe-mode traces do not prematurely cache host bitness.
> > - Support optional vmlinux, kallsyms, and symfs symbol configuration
> >    parameters (and PERF_SYMBOL_VMLINUX, PERF_SYMBOL_KALLSYMS,
> >    PERF_SYMBOL_SYMFS environment fallbacks) in perf.session, resetting
> >      symbol_conf pointers and freeing vm_tm_corr_args, cpu_bitmap, and
> >    ptime_range in
> >    pyrf_session__delete().
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/python/perf.pyi |  35 +++
> >   tools/perf/util/python.c   | 624 +++++++++++++++++++++++++++++++++++-=
-
> >   2 files changed, 632 insertions(+), 27 deletions(-)
> >
> [...]
> > @@ -4161,23 +4585,40 @@ static PyObject *pyrf_session__new(PyTypeObject=
 *type, PyObject *args, PyObject
> >   {
> >       struct pyrf_data *pdata;
> >       PyObject *sample =3D NULL, *stat =3D NULL, *context_switch =3D NU=
LL;
> > -     static char * const kwlist[] =3D { "data", "sample", "stat", "con=
text_switch", NULL };
> > +     PyObject *call_return =3D NULL;
> > +     char *itrace_str =3D NULL;
> > +     char *vmlinux_str =3D NULL, *kallsyms_str =3D NULL, *symfs_str =
=3D NULL;
> > +     static char * const kwlist[] =3D { "data", "sample", "stat", "con=
text_switch",
>
> Hi Ian,
>
> This needs to be "static char *kwlist[]" to support older Python versions=
:
>
>    Changed in version 3.13: The keywords parameter has now type char
>    *const* in C and const char *const* in C++, instead of char**

Thanks! Fixing in v3.

Ian

> > +                           "call_return", "itrace", "vmlinux", "kallsy=
ms",
> > +                           "symfs", NULL };
> >       struct pyrf_session *psession;
> >       struct perf_session *session;
