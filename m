Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1720DF4;
	Fri, 23 Aug 2024 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724386197; cv=none; b=Doz/DSPyrCI/MekgUTYEA3JCxtaaGj6F8hqv4i/N0tgIXLwG7aHxiHMI8L/Li55EOSDmW0qL/yMNatMBeqzNi9XJAbgmOJh8AbNiCyAXqtpoQ6A1L3ftKi7tu9uo+BfupB6WVtxIXvaYoarmdyp7k44v7MGmommPACKI/Ru9rKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724386197; c=relaxed/simple;
	bh=pT9uqXYn2KpXAXKCn7T6VWnWSynN3uJMq8rcYtkVK3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g32ermslxfUcSqlx15s2t3KtBXhZDbNNbTu70FlUDUhSGC+c5beIdxIHht/IcakvnHVG8YwezWYnTsvkpSXnq3zncZ3bW1h3vZQirRB4N/Iz+gpY+kWxOfeulaKCM1MRbe46RYWMxd8NiZq5kJrAtsNXjfV+DI7Vu4TxTTeQSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUVGZ9zN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUVGZ9zN"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b47ff8a59aso13249057b3.2;
        Thu, 22 Aug 2024 21:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724386194; x=1724990994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpZDLHPABX8XYAz4LLTVL/cZmCGogxXLhreWDxIqGTw=;
        b=jUVGZ9zND96YoTSsTYN2dn68UGT9kmxll+IGfxmr9HysNrLz41yve8FyCzVyTDxKXJ
         og0R6F++ywsIjH0LeSJ4x22Cw4EMnUcdmcmKpa4sGCMwSc3cLTNrmLZ9oM2/iVfZUEh4
         NY0NRFg4NWYmOxeUDDM0b9h9BNTwzHZcLF2Yms8S76Gzl7dWXYjc1qlp1BcwYKhI0SGe
         h5zHIUE2Hd9yoHlmPYPjr3Qb2guC1cIcNwG1wifLgoIAQZpl2RDLgQooGDrH24b37l6D
         hCf6pfC8OpwwNHrujhlb14zEaO9Mlt7Iqj3yqIFMUmuu5+tv+iA+yOhVsnQQ5CKf9T4p
         QbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724386194; x=1724990994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpZDLHPABX8XYAz4LLTVL/cZmCGogxXLhreWDxIqGTw=;
        b=F+rwF6TH6zgfMtGqZUdMhkqB9JJRVlICBOp8vP/cQdmK5fAgPvj80J9hfBi6/BFWhO
         JfybKUg+CZY9sr8FIrhenU8nx4hJCfKswkeYF/0XypnxTxTV+hTJ9/DpGnN7/nHeNhzr
         uI7ZanoNelreqyVHVpfluAmH1eb2msBl+GgpRihpDTjbDyA706ovBcZVyL4bKdAfw4hR
         ZWiBo7mv+sWIz4dH1uWv1zaV1Cdy8fm9RBNbe+SLnRryUW+QUTd8Pd6pIIHF8RvSkxHY
         diWLp3F/DRVIeW8KLUXfZKWxUeZPAdaMnc6Kcudufbes14Ugvradp6v4MQoRScuFJIQ7
         ue8g==
X-Forwarded-Encrypted: i=1; AJvYcCWImyFaftbDbzBlyDY3OaExNu/Z305FI9MqX1vVqfF23bbXF9RGsWMCxtI2nZOVItuMoOa49oSq1E0u8+ynU8cD8Q==@vger.kernel.org, AJvYcCXszEsFp/JsmXL2YNkJBeP6RxG8Z/Afk78RD10j4dlFVBuPdwNjn3CxPZe1Ud+mKz6XIdaesH3TpLBj6OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgf1uDoxyUqWXoCHt+g9dz4T2qcJPlMHlpYeMFaXPFqmBJdJ6
	fEoYntdcrXhNPZrlJSu2mXlA7SJFLATDa4D/eRmqDLy90MSaai07jXyFEmp936fowPaI5QOalbT
	fpkNlMjLtD9CPmJEdHxBIFtgLuXo=
X-Google-Smtp-Source: AGHT+IFbTnAybcb7YAzS41TU+gvgYt6QOZDdTXtwWTv4tvGkuDoRhAVGPyy2yKZcr1YPqTi144auF1qYgHTwFrjCKHo=
X-Received: by 2002:a05:690c:95:b0:64b:69f0:f8f2 with SMTP id
 00721157ae682-6c62441920amr9805297b3.3.1724386194402; Thu, 22 Aug 2024
 21:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-4-howardchu95@gmail.com> <Zsd6MgrCs0ybQ9EW@x1>
 <Zsd7Ep6H24Qq-h5F@x1> <ZsepEpr-hGXkI8Vw@x1>
In-Reply-To: <ZsepEpr-hGXkI8Vw@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 23 Aug 2024 12:09:43 +0800
Message-ID: <CAH0uvoigqSHEcC0+BUkdGMq5ODhJXh_JSjNB0d+-mf2UUkYfzQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] perf trace: Add trace__bpf_sys_enter_beauty_map()
 to prepare for fetching data in BPF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:09=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 02:53:22PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 22, 2024 at 02:49:41PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Thu, Aug 15, 2024 at 09:36:19AM +0800, Howard Chu wrote:
> > > > @@ -3624,7 +3719,9 @@ static int trace__init_syscalls_bpf_prog_arra=
y_maps(struct trace *trace)
> > > >  {
> > > >   int map_enter_fd =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
nter);
> > > >   int map_exit_fd  =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
xit);
> > > > + int beauty_map_fd =3D bpf_map__fd(trace->skel->maps.beauty_map_en=
ter);
> >
> > > At this point we still don't have that, right? I.e. building with thi=
s
> > > patch, without the ones following it in your series, I get:
> >
> > > builtin-trace.c: In function =E2=80=98trace__init_syscalls_bpf_prog_a=
rray_maps=E2=80=99:
> > > builtin-trace.c:3723:58: error: =E2=80=98struct <anonymous>=E2=80=99 =
has no member named =E2=80=98beauty_map_enter=E2=80=99
> > >  3723 |         int beauty_map_fd =3D bpf_map__fd(trace->skel->maps.b=
eauty_map_enter);
> > >       |                                                          ^
> > >   CC      /tmp/build/perf-tools-next/tests/code-reading.o
> > >   CC      /tmp/build/perf-tools-next/trace/beauty/clone.o
> > > make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.bui=
ld:105: /tmp/build/perf-tools-next/builtin-trace.o] Error 1
> > > make[3]: *** Waiting for unfinished jobs....
> > >
> > > So we need to squash the patch that introduces beauty_map_enter in th=
e
> > > augmented_raw_syscalls.bpf.c file to this one, so that we keep things
> > > bisectable, I'll try to do that.
> >
> > So just this did the trick, I'll remove it from the later patch in your
> > series:

Okay, making every patch buildable on their own, I see, didn't know
that's the rule, sorry (separating hunks is a little too hard for me).
Will do that in the future.

>
> But then you added syscall_arg_fmt__cache_btf_struct() ifdef'ed by
> HAVE_LIBBPF_SUPPORT to then use it on trace__bpf_sys_enter_beauty_map())
> that is ifdef'ed by HAVE_BPF_SKEL, so when building with
> BUILD_BPF_SKEL=3D0 we get this splat:
>
>   CC      /tmp/build/perf-tools-next/builtin-trace.o
>   AR      /tmp/build/perf-tools-next/libperf-util.a
> builtin-trace.c:930:12: error: =E2=80=98syscall_arg_fmt__cache_btf_struct=
=E2=80=99 defined but not used [-Werror=3Dunused-function]
>   930 | static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_f=
mt *arg_fmt, struct btf *btf, char *type)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   GEN     /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux=
-gnu.so
> cc1: all warnings being treated as errors
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
05: /tmp/build/perf-tools-next/builtin-trace.o] Error 1
> make[2]: *** [Makefile.perf:762: /tmp/build/perf-tools-next/perf-in.o] Er=
ror 2
> make[1]: *** [Makefile.perf:292: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> I'm moving syscall_arg_fmt__cache_btf_struct() to the same block where
> trace__bpf_sys_enter_beauty_map() is.

Yes exactly, I did it in my branch as well.

Thanks,
Howard
>
> > - Arnaldo
> >
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/to=
ols/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 0acbd74e8c760956..c885673f416dff39 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -79,6 +79,13 @@ struct pids_filtered {
> >       __uint(max_entries, 64);
> >  } pids_filtered SEC(".maps");
> >
> > +struct beauty_map_enter {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, int);
> > +     __type(value, __u32[6]);
> > +     __uint(max_entries, 512);
> > +} beauty_map_enter SEC(".maps");
> > +
> >  /*
> >   * Desired design of maximum size and alignment (see RFC2553)
> >   */
