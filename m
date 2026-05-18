Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779517BCA
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072652; cv=pass; b=GsyuJ9AqfZFp4E0ZBbdgYxF/vOBK+gihAbgW/fbxOSBqdnVkobpJcd8IhaVmoDSYyMtLovjJ/MaoNcBbJH7oKvZY1lxzxalS1URd6RTy5qdnhvLiS2Of+W0ZqRYDMNJUQbw+/q6Y3l6uZbKtsjK3RlrySyLynhnHtldjlVX9ea0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072652; c=relaxed/simple;
	bh=Ooa7cW2D1IYd9NZSoSPSMtct3nfjHy2qVBuFonf3asI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrJSY7Cpo0IZIyYd4Dxm8VkI0/6NhQ0ICsUMtbQrLXFnFC9yOwyHL8EHpy3NaJZQG+lAvCy6P2JXyyyNIQF/YMxy1AxKQ4JMhVKdWrih0bjYBpCPUtlR1V8NsEk2v/MM6Fg0lXcWWVuWehiGh10mWuvpmSe/ac8mbhBf6aZ6mF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqX8YKKP; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqX8YKKP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b46da8c48eso455ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 19:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779072650; cv=none;
        d=google.com; s=arc-20240605;
        b=RA9t0MJUHDmEw7773pzAzwEGam/tHB1UWtKyCI3ZokhGNdw7fOoerDPwfzm8rnCNaz
         Bl6/OTkROk7ELCbqug3Bua3AMaj8+QZ/zrD4wKrFo+CvzozMXENX+2wiqBqWdNiYHPH6
         Orv7jSFe8abiql/aB6PZ+/ps2P4qbAW6SsNSq6BTPQWw0EKYkA4gTyudJyXhRd5oxj2p
         MUJpgbVe8dElbms2aGTCSxOpaIStCkdpNWtG2snejQdhoRDUZT7yrT6gNc6jjx6hEYZg
         Zjgi0/NplHGygAd7lqxunGxbGzyt2f8D6cmtVAEgVIqFocnmoMgxCQIZWo1tTktF2F2U
         27/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GlQ9sX2+ndV8BDI+ZX/9maNZGwPG1ORF3D1rWw5qgqs=;
        fh=7pAOHTLAVeIRICmah8HCU6NV/33tyThZKRTrPipLVKo=;
        b=OlwUrtAsDcAGGF/3dOMnY0FRc3/Rq8BPDuZDL/CRxCPVN7YFsRer8JxgyfpI3/5khc
         KBY2YqC8QIakTRLOzUN+gPCxfWtYOuRYeK9L9nmEhvoR4jJpWWKEjekS/7MXuzBNOGAb
         8DGRML6v5gfu8IR0fggThJhZgY+Vp7fz2TjuIVFnlGsolTnbRln8+CzHWTe+ZvFHR7y9
         VnmF3Z4d5tu+etCiPeXJU6IhjDTRoAsoVNt8zxMe0VHTqsvAssYZSCLybGrEYQucFq8X
         Vb5CnlcY1Y83ia4bCZ7YwhRYrOrxBHNjNcfNIWlwmJaaMzI2TESAcQzn5MoTq0+2HFba
         hHqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779072650; x=1779677450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlQ9sX2+ndV8BDI+ZX/9maNZGwPG1ORF3D1rWw5qgqs=;
        b=eqX8YKKPAZutACG7bJnDmEJeuLy85BIWejOspQAD9ZKhLyxro09bV8lqVqsfQBmJpU
         loBFNMtDMhl/mxbtfB6DvFlXogCJYq5Ehh9OuFEl3JvPIKz/rwgX0v4wBIu/lxGIfnDi
         r/5ZTKGCgJPYUGi0ngQrvBpVTDAPwBzNIplGcvEBgh03ccLtt+n0JnbiNd1banNilank
         KSpdAlENB2EbpM+vHC+HGa+NoUtey469xo/stGmHoe00q+MDu/ME0Iq2QC0CFxvx92nJ
         e8fOcrnMO4DuCKGkSETAO40t8U6ZCgl/77+sa0qQfUWGmSnuQx0d2VzX+OWpU/f1gg6B
         xrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779072650; x=1779677450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GlQ9sX2+ndV8BDI+ZX/9maNZGwPG1ORF3D1rWw5qgqs=;
        b=WQHXiY+xXsFR6K0YbHuVv3lfSXp3dAjA67clbbZ8jbXjl2IH4VENZKZiD5lp78OQKI
         Q7fSLhYRRwgJLFo7Mx0BTWZNg4fV3BPqkfRoeuuK687zgnTrlz3DsXRSZdQ/n/IwpJlY
         mqERD5GA1FdfR6t1ZC8WKaA0bK4lyDZ2Kf0rGBsLjCMblwJLlEUOr85DwvqrY+IRv3Ev
         gTRRDVVKNSaJfLHgN60jHISTJf/ULm8KNAw3G3UL3SkSfZjzIXkRE1w0oUhcRZjSXx6Q
         FNbGyS8/36SitouppavSynMKa+x02e38Z9odM49B283+qeAuzbHBpBxj+MsgD7PHYaUz
         PgPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ipIYo8xQll9mX/bUiGzymcMS/e35oyuROG98k+c0vjlp27rUgJ5nRuhNxFnVPOoLArDHX5seAZRGkG+Zs3WgL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17CE3nPg0mYv/nMBJmrV0mQOOoVodXzUntWvuRSJ2AN+sjJ6u
	mLMNO40O4gaqywPXPKzkbEH2fXNJczLfYDaT39k8BgTZ3rx2Lw21jD3Q49UE/qdCM06myHoSNrh
	ePbvUpFndYvE2/Fppkvh32tDBbFzeItM8jZdm4B+Um5+z+r4xAhDe3wOU
X-Gm-Gg: Acq92OEqVZHgHBa74EDJf6F7BCxwgG2umXYj3JbYALG31OyFSPtS85DBLF51G/fq7/T
	/0Ltw4GYDC7cXHNS045mlCVM8QBR9G0Q7DB0UluqiN9mJG1gbKi6quSiyUjRN2tMb2asMjXnbKS
	qhlio56659v7KCBAzUpQRaesQGfIXNqnOzscL974gXAUIAphLIWOVWhkh5NSGg3BkEqhLBgEaGI
	sOnv+qRB0qDpSXg8LG5Azb97OM5m7lCdgbUsvnQ31JfRxIdMUYZurfXdF1fGi7jfx+A/Rg+3fa7
	xPavjwR2FaiJgBGoPbw=
X-Received: by 2002:a17:902:ebc2:b0:2ba:73c3:49b0 with SMTP id
 d9443c01a7336-2bdb03acb3dmr1784335ad.14.1779072649647; Sun, 17 May 2026
 19:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515193314.1593560-11-irogers@google.com> <20260515195854.1A3C0C2BCB0@smtp.kernel.org>
 <CAP-5=fXM_bGY8uiVa-U9SiFrwY+Dxkrt=s66dfoL9YR7=14Edg@mail.gmail.com> <agpuOvZvo_HNnYsr@z2>
In-Reply-To: <agpuOvZvo_HNnYsr@z2>
From: Ian Rogers <irogers@google.com>
Date: Sun, 17 May 2026 19:50:37 -0700
X-Gm-Features: AVHnY4Jksalie_5MKvIzN7MMZ2hXiEY_ggE5_dwHwA_XCUpwR3bvH9_CRgzrGBs
Message-ID: <CAP-5=fUfUzKVsrOLUZ7d0FsMcWc=vp5hfmL7Yymnj7Zd9L2tWw@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] perf pmu-events: Split big_c_string storage into
 standalone compilation unit
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 6:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, May 15, 2026 at 04:25:29PM -0700, Ian Rogers wrote:
> > On Fri, May 15, 2026 at 12:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote=
:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [Medium] Incremental build breakage and partial clean failure due t=
o Makefile dependency chaining and Python file closing order.
> > > --
> > >
> > > commit 6c014984ddc9092cbb7ef975a3904baefa427ed5
> > > Author: Ian Rogers <irogers@google.com>
> > >
> > > perf pmu-events: Split big_c_string storage into standalone compilati=
on unit
> > >
> > > This commit splits the large big_c_string literal into a dedicated
> > > pmu-events-string.c file to allow parallel compilation during Kbuild.
> > > It updates jevents.py to output both files and adjusts the Makefile
> > > dependencies to ensure jevents.py is only executed once.
> > >
> > > > In jevents.py, defer closing output_string_file until
> > > > the absolute tail of main() to guarantee identical modification tim=
estamps
> > > > with output_file, preventing redundant rebuilds during incremental =
runs.
> > >
> > > Is this guarantee accurate? Since output_file is never explicitly clo=
sed
> > > in main(), it gets flushed and closed automatically during Python
> > > interpreter shutdown, strictly after main() returns.
> > >
> > > Will this result in pmu-events.c having a slightly newer modification
> > > timestamp than pmu-events-string.c on filesystems with nanosecond
> > > resolution?
> >
> > So previously we were worried about the opposite scenario. Using &:
> > for a group of generated files solves the problem but Linux builds
> > only require GNU make 4.0 not 4.3, which added this group construct.
> > We may need to drop this change as I don't see a way to satisfy
> > Sashiko.
>
> Isn't the message at the end a proposed solution by Sashiko to satisfy
> the problem?  See below ...
>
>
> > > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Bu=
ild
> > > > --- a/tools/perf/pmu-events/Build
> > > > +++ b/tools/perf/pmu-events/Build
> > >
> > > [ ... ]
> > >
> > > > @@ -224,6 +234,10 @@ endif
> > > >  # and inputs are dependencies.
> > > >  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
> > > >       $(call rule_mkdir)
> > > > -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARC=
H) $(JEVENTS_MODEL) $(OUT_DIR) $@
> > > > +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARC=
H) $(JEVENTS_MODEL) \
> > > > +            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
> > > > +
> > > > +$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
> > > > +     @:
> > >
> > > If pmu-events.c consistently ends up newer than pmu-events-string.c
> > > due to the Python teardown order, won't Make permanently see
> > > pmu-events-string.c as out-of-date?
> > >
> > > Could this silently trigger redundant recompilations of pmu-events-st=
ring.o
> > > and relinking of perf on every incremental build?
> > >
> > > Additionally, if pmu-events-string.c is deleted while pmu-events.c
> > > remains up-to-date, Make will execute this dummy recipe and then atte=
mpt
> > > to compile a missing file. Does this pattern handle partial cleanups
> > > gracefully without creating a build regression?
> > >
> > > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-even=
ts/jevents.py
> > > > --- a/tools/perf/pmu-events/jevents.py
> > > > +++ b/tools/perf/pmu-events/jevents.py
> > >
> > > [ ... ]
> > >
> > > > @@ -1476,6 +1488,8 @@ struct pmu_table_entry {
> > > >    print_mapping_table(archs)
> > > >    print_system_mapping_table()
> > > >    print_metricgroups()
> > > > +  if _args.output_string_file:
> > > > +    _args.output_string_file.close()
> > > >
> > > >  if __name__ =3D=3D '__main__':
> > > >    main()
> > >
> > > Should _args.output_file.close() be added here alongside
> > > output_string_file.close() to ensure their final filesystem writes ha=
ppen
> > > simultaneously before interpreter shutdown?
>
> ... here.  Or, maybe you can call os.utime().

Let's give it a try.

Thanks,
Ian

> Thanks,
> Namhyung
>
