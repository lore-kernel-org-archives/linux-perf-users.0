Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98C31E882
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040569; cv=none; b=pnCPyffYGfYZW5x+WOqNDFXggJcQNFn7BFo5/2jAUvxsTQxhnI85yV4Ad0AqwGjEcFOhp5/38/8zSGulvSglPGoP9O1eR574rytvrebbxIgqeBdrzPNAKZ1YA4nu5FO0iu6OFkOzeGOFmjVGt/LjTcr7mAXpkMSg0rn1uJ9zGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040569; c=relaxed/simple;
	bh=4It9hgA0WcCACRFuKnTDOioA0zIhniFQfiLDPbq4Au0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVm27++Z454jh5iDdk/fnA4T5Zl65isTw8AZ12k7WeHIhPACQ+fd94An5iEi6oehecOxQgm5cqFv3i+/W4r7HXLnOLQuGgBYOXj5aLutHEMeuHo6locBXnuajauGDYRpVyE/Zq0l2Q0yXFXm9wOn8GaL+1TTGkftNO67cd7QaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZ/gsg+U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZ/gsg+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExxheuDCvJ5hmG5ysaE31TEZsIo0XTc6KH+nLdPXrrI=;
	b=OZ/gsg+UZq9w4wDDuPhMetbiodEbvOFM4Wovc/a5Bcd3gDaJ3nbe6vf/hsQR+sRa6pZu1C
	f9fj1YH3D2yoDczo5ns6I1Qs/YZMN7tfkZ7uk2P1wfv6a3u8zamJRmMJfMFaCljssmnxWg
	bd0aw5N/1pq70c7a/URjqCJf0k9aCwA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-yRIPIbtGNLu4EmjfwG__xQ-1; Tue, 16 Sep 2025 12:36:05 -0400
X-MC-Unique: yRIPIbtGNLu4EmjfwG__xQ-1
X-Mimecast-MFC-AGG-ID: yRIPIbtGNLu4EmjfwG__xQ_1758040564
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-627eaf68bbfso8129141a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 09:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040564; x=1758645364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExxheuDCvJ5hmG5ysaE31TEZsIo0XTc6KH+nLdPXrrI=;
        b=LCGLOWWu6mm1vpHhRAZOBLJo1Hr3caUbRcZquXyfRl4N4blxgrlxm3gGwTRLYgDKHl
         rd68N1Q3lcMOm6Mb+NYGv32nhVC3v79B9oyA07g4N+X98MNE75rYq2y+sdSf6VFjXWje
         4VXNAI3Tuwj30CHGJfRLWFI6ZBWqTtz0Qya/9PrIYGJCHqmxcrtI44lVtukaLoektHB7
         4LONtedtDb7ybjgpw+oZjZ+R7Xb4VtD97+1D/cRyPDbxUre9gpViSnEpeogLBU6DBl1O
         QFWQxOD1X3BIuckFjo+/dCjln6m6SZF4NNw9CNadUub7KzCUgPc6AJBdqHnSHzXcENmC
         IPig==
X-Forwarded-Encrypted: i=1; AJvYcCX78+GYf45YiGgJfd9bomw65AzzjNgMEM15sjPJHeVGhj/1OoQt8VE/CvkYeNE36m+4sWhHJafX+z9Vx5/Ln+/S@vger.kernel.org
X-Gm-Message-State: AOJu0YwABhYKDsvH3O2m+4MEURllOpkNut3eCG8fknsvcE8AC9Dse3Qn
	nX3fOOU79HEejwU8qCPTQOExtYKRbktGD4JZLDYHbyu/M8zxaAaTB87n+gJM/G6rtJjDHLmu73H
	68R4NhFf5pqlLneJti8tKtsx6cQAzDrIjWXstA4rblvoQbTEHLqiDKIJTHDAyUgkngr0V7tK/yU
	1Slkd1UVvjCi0oQu+AX3r+QQ56wANhaaFc5UvTKPU/T4h5Fw==
X-Gm-Gg: ASbGnctw1eVdmSZDhBOq0FF7sovBlr+gsXjjCWp/Cgd3IWwQ8HctLdXmo/2qBsjbImC
	R9WZOdfsdeWDTF5EpKbMewKvdX3/E0DW+uVGrVKWH95G6jybz19yRnPMUlUM7x+ZmvC47Prc9l0
	+2RyMuG1RS73M9pVAkxDMqH9wV85sGLxz2qmzwi9a1dX2yE3Sogj8fKw==
X-Received: by 2002:a05:6402:2744:b0:62f:41d3:ece7 with SMTP id 4fb4d7f45d1cf-62f41d3eee5mr7224168a12.14.1758040564093;
        Tue, 16 Sep 2025 09:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf4k1ER0G70wR3EhyS4r/J9QsEfLCTuBmYEAsNrswh7nQacjmZl4NpNBcuA0KwnOAKwZYiD+4zi5srfQoVYV0=
X-Received: by 2002:a05:6402:2744:b0:62f:41d3:ece7 with SMTP id
 4fb4d7f45d1cf-62f41d3eee5mr7224132a12.14.1758040563175; Tue, 16 Sep 2025
 09:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821165831.184569-2-ashelat@redhat.com> <CA+G8DhK4tqVLMdNhM-bfYSc_8C2PrYeOVEJnGOb2nomHsaAhNg@mail.gmail.com>
 <aMl1JSe9kuZpfVnA@x1>
In-Reply-To: <aMl1JSe9kuZpfVnA@x1>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Tue, 16 Sep 2025 12:35:51 -0400
X-Gm-Features: AS18NWDUpAM1DjhGcEgLSVpYC2uTTFiCmIeZmBtLrVgjC5bS0gvcWm8Lxe4GIHE
Message-ID: <CA+G8DhJq4ZJ9Xfp7Aw7hOPW3XOyKyxmwbzkH8KxpK=-kh_AoFw@mail.gmail.com>
Subject: Re: [PATCH] perf trace: don't show comm/tid for regular syscalls for
 single-pid traces
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: mpetlan@redhat.com, namhyung@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think actually the test may have to be edited. Namhyung is right,
because unless "--no-inherit" is specified the trace needs to show the
comm/tid field to keep track of different processes in case the traced
program forks. Please disregard this change.

Thanks,
Anubhav

On Tue, Sep 16, 2025 at 10:34=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Sep 11, 2025 at 11:27:15AM -0400, Anubhav Shelat wrote:
> > pinging
> >
> > On Thu, Aug 21, 2025 at 12:59=E2=80=AFPM Anubhav Shelat <ashelat@redhat=
.com> wrote:
> > >
> > > Previously when attaching perf trace to a specific pid the output wou=
ld
> > > look like this:
> > >
> > >          ? (         ): vest/616160  ... [continued]: clock_nanosleep=
())                                  =3D 0
> > >      0.041 ( 0.013 ms): vest/616160 fstat(statbuf: 0xfffff2c60038)   =
                                     =3D 0
> > >      0.073 ( 0.008 ms): vest/616160 read(buf: 0x3bede330, count: 4096=
)                                    =3D 17
> > >      0.090 (1000.095 ms): vest/616160 clock_nanosleep(rqtp: { .tv_sec=
: 1, .tv_nsec: 0 }, rmtp: 0xfffff2c601d8) =3D 0
> > >   1000.210 ( 0.136 ms): vest/616160 openat(dfd: CWD, filename: "/tmp/=
something.txt", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) =3D 3
> > >   1000.361 ( 0.004 ms): vest/616160 fstat(fd: 3, statbuf: 0xfffff2c60=
088)                                 =3D 0
> > >   1000.375 ( 0.018 ms): vest/616160 write(fd: 3, buf: SOME TEST STRIN=
G\10, count: 17)                     =3D 17
> > >   1000.395 ( 0.072 ms): vest/616160 close(fd: 3)                     =
                                     =3D 0
> > >   1000.476 (         ): vest/616160 exit_group()
> > >
> > > which would cause an error in the perftool-testsuite since the comm/t=
id
> > > shouldn't be in trace lines for regular syscalls. With this change th=
e
> > > output looks like this:
>
> But it is still appearing in some cases, no? The first one and the
> exit_group() ones. Can you please try to make it be suppressed there as
> well?
>
> - Arnaldo
>
> > >          ? (         ): vest/612038  ... [continued]: clock_nanosleep=
())                                  =3D 0
> > >      0.039 ( 0.012 ms): fstat(statbuf: 0xfffff8e94cb8)               =
                         =3D 0
> > >      0.069 ( 0.008 ms): read(buf: 0x3b997330, count: 4096)           =
                         =3D 17
> > >      0.086 (1000.436 ms): clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nse=
c: 0 }, rmtp: 0xfffff8e94e58) =3D 0
> > >   1000.545 ( 0.136 ms): openat(dfd: CWD, filename: "/tmp/something.tx=
t", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) =3D 3
> > >   1000.700 ( 0.006 ms): fstat(fd: 3, statbuf: 0xfffff8e94d08)        =
                         =3D 0
> > >   1000.720 ( 0.024 ms): write(fd: 3, buf: SOME TEST STRING\10, count:=
 17)                     =3D 17
> > >   1000.750 ( 0.073 ms): close(fd: 3)                                 =
                         =3D 0
> > >   1000.833 (         ): vest/612038 exit_group()
> > >
> > > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > > ---
> > >  tools/perf/builtin-trace.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index fe737b3ac6e6..4cc38ee6aad9 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -2955,11 +2955,17 @@ static int trace__sys_exit(struct trace *trac=
e, struct evsel *evsel,
> > >         if (trace->summary_only || (ret >=3D 0 && trace->failure_only=
))
> > >                 goto out;
> > >
> > > -       trace__fprintf_entry_head(trace, thread, duration, duration_c=
alculated, ttrace->entry_time, trace->output);
> > > -
> > >         if (ttrace->entry_pending) {
> > > +               if (trace->opts.target.pid) {
> > > +                       if (trace->show_tstamp)
> > > +                               printed =3D trace__fprintf_tstamp(tra=
ce, ttrace->entry_time, trace->output);
> > > +                       if (trace->show_duration)
> > > +                               printed +=3D fprintf_duration(duratio=
n, duration_calculated, trace->output);
> > > +               } else
> > > +                       trace__fprintf_entry_head(trace, thread, dura=
tion, duration_calculated, ttrace->entry_time, trace->output);
> > >                 printed =3D fprintf(trace->output, "%s", ttrace->entr=
y_str);
> > >         } else {
> > > +               trace__fprintf_entry_head(trace, thread, duration, du=
ration_calculated, ttrace->entry_time, trace->output);
> > >                 printed +=3D fprintf(trace->output, " ... [");
> > >                 color_fprintf(trace->output, PERF_COLOR_YELLOW, "cont=
inued");
> > >                 printed +=3D 9;
> > > --
> > > 2.50.1
> > >
>

