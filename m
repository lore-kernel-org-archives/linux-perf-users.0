Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587601;
	b=OH0C7H165mkzDoXXbhsNSdrxSBAS3kGhW8J07wGqz5KNh5PqjPc6ESV/in8Wh2z8HAsl
	 go4ysyNxe+G9bk+nwFLgxbqJX4qNOvEJ2tAuz2V1WZZGswhkEQzaXyVH+isrVMkwfoKY6
	 oZ8peGjqxCA2it/VrU2fCh8G035iy4390H7CAHYQW6UqP/iO3TmNBhYmK29NnLo+7m5QV
	 Q9GbfM7I1AYAbTivxjtgHhEusC0Yn1jvgtm3cqZxXV1FtH7Dh2KK8j/W/wzjKYCY73lL1
	 pc8UA5kxZ99BsIymRI06ahfJ99UafPoJEWl7DfkBQktMEF69ysTtITiuWd7ddKSgptw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AdWoW+YMAuhD4166hiUdRwKU0699eDdRXcepk33gue8=;
	b=IpyXLGAD1EQgIIjRoYQ2j0vkiSIra9285zNIih58t54RIymKd4nsi1EhA7d6PLp994W3
	 g/zT1FwLfb8AQKqlCJ9FCsEhxtd90uCKRFnxdzFJiVGKBPmCcoWSvgjyUspQL5Nn15Zov
	 G9lhZIHgCKh0IrKzM3U7x/KIXyIq83brqUmtoNXLLdngUiCJgOC8bc1+TRR5Tv2kSugHc
	 k6WNTfh3iASMrOiT5rUfRA5eRcX/d38Fk3WX42W+hKJxvI4zJ5Oa6MYIr3cFpOwdB7qkP
	 5TlGErKuuZeFUAjltpLwskGaEHmiBloil49Ur7gtSfTzf92groHjB/fiY0QgqSNv6JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YcSpgE7g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BB606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1BB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YcSpgE7g
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533202fe429so424871cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587600; cv=none;
        d=google.com; s=arc-20260327;
        b=Qn00ren+KivnsBgaJ0+cnhVIHyhHeTWmtAqiFmgepIttr3Xz79t/+e2xQVRBsNUk94
         PyS3Ui32VGVWn8YzpAeQWQQ93BZpDVM7JJrspYkDPs8zNe4FnKVsHzctq2dQI77ZcBOs
         ThXuuQrlpLF1Y1KxAwYFh2Fh6O/FRwHe7KJS2H8Ii1/R8P7YhbHFnslvZm3vpLABzke0
         DqSDogdTEYWwHrtBfIRr7nSYXuuMy9zmeA8fFOQ4XwhXBobvr3G3N4ldxAooBKot3G2J
         QGiRKuZRodyAAXeGKGMq6Fy+9SA+Yk3hJ3PGsASByCJjCLCdzzrEWM3oO8RfqC7DaeeU
         KrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdWoW+YMAuhD4166hiUdRwKU0699eDdRXcepk33gue8=;
        fh=M5/xD1NPpf8QX7thOFQnX+vBb3724/veRVFo0Ge1TAA=;
        b=dcuXWz6UDzD1VqowQDcivKFz0OQsgCVQKF4LMFZyA5j2KB7RyD5Ka7pw9Ni/nIXYx1
         pHqvuT1G2xuX2pzwLBPW4y+1XFUP5RjVw+0FssiUwpMhbpeH8UdvtEMyF70Cg2H3BlJn
         mkMUoV0zOaV2BRqZ257CVeiLYt5YGvAbXMSO0ewCJ10pNr57XEZL/BAWWZiWJcdbycx3
         uU7WYPopSZIWJSNhYimzcgSzPUxp+OmwsLOpqHsuWUj3Qk4X+fo6G4s68LXYy9jC4kMu
         aydz5oT4rkbI8ERncZQayrOQJNOUkGLiCu/KqnfzFrk+YhFpLuZabfiPnFjUad27+jsm
         7FKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794587600; x=1795192400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AdWoW+YMAuhD4166hiUdRwKU0699eDdRXcepk33gue8=;
        b=YcSpgE7gf4jdpKyCLLUWz3GIqf43PjzI9Tf0sHKF3DQD1JSIyDYc/KE7dZ/rm18PxX
         hCyuPzMUwRGNk3XiNUXu5wK0lNnZJ/6fHClxg8H8lrHyBJAKhox90eEW7IZvR9A6Zhlu
         lSFYNsMrWMduxzXVOHF/hUEcBdb4Q52fMCZSUnYmXbJWL9sXj3LbiO305yypmQc9ZClc
         JOq8PkYxP6y0pMd91ErNEmyDECv7e8eWr3G0YP04uwzynuwZQJIoq6eikjytPuRyDL4w
         YT/ZWzl6X9P5swNpigfeAIL0kJERDsNXEefvYl//LONc6kDzzkqVJ8sPs5rCQ0luHO4H
         WIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587600; x=1795192400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdWoW+YMAuhD4166hiUdRwKU0699eDdRXcepk33gue8=;
        b=VwxeyErl1/KMrLfj0Yw6NnSpDA4cUv/EoGAWyYWFL6fWzzZQyrGaW01s8WQEYsThyB
         65Tm76OxdoZ62E1n+ztkJ5aiwXFcRr0uM8i+pgpAbyaSiGyOxGtpGEXsoXKb3ezkgzNr
         zPrdT7VU8swdbFNkVvv8XL8Bq5dHBck+c55w8ED/g4ePuL35uJpZOsg4JPXcXLWZtzBC
         ddz05u9HyX9lF0GwH8dbP2okWXH15YgrIRhHhpMCYIK/ev45VKMak+jdxDCFEG82hgEg
         AAwV6TmfO0GIAz0hHNMdsuOJHZVfz2hYdqmla+0fJCcONtpvW+Y07bCAExOSAig4Y9gu
         t1eA==
X-Forwarded-Encrypted: i=1; AL+hErFG+ySf25TZ6b4oFfzf/n8/ISQFfwkji1zlQucHmfsaqhspt6x66nOlbRko4HtMk4NDrOWg7TERJM4G64BTROay@vger.kernel.org
X-Gm-Message-State: APuU4Z+fgpl4sfD0Q82eRU2DTz/b6sKwXzi8Iad9teQZrc4DJwxigIbU
	nvzttoaZZAHKW2cvb1Ban7t6BP32L6kTIYUcpcGn878rEY7z5vBtNziDsuxuBLp9+Zl8oheJooJ
	FgsW+a7drOlWkVr42GdcxLBZOanpmN9VKAMT797gl
X-Gm-Gg: AYBFou3+DV87mPJ8u8UqBxY5dtOn5zuMv4I47UcgMPdJBuzcDAhRSUl2l2gN5ZD/0fO
	eJ8qLgdunOH10ROgt+fZNSk9WoEQkWNxurmWJUTfGeTSMwI5K+o32QPTQMXUDtGBW81L5g1zvCu
	JrnOtaxdTZY48cQrISt7tcVrvcfjz2jGYW++l+cyvpqcUp4tP/4sElgnc8ssXISk9vl7BENxUAD
	xxcLhcMHf+Zvndl2plX4x7ZjKZY9VJhDjqe1pEVe4Mjv8XLL1ph8Tw8cAj9svErfR5d5RkiCR0y
	QcrIqHp2ayHM2RqPuJdQsnHCcliTqAM5+OyM/rzWbwCNhzLAHPx/3tx0YCPWYTo6vAjBBkab6mS
	UBkeg+5RXfOIYtcLZqStjm2PIpqZU+Wf8JOur9RyprMRKkEepCAXpy89e0UJ6TgNv8go=
X-Received: by 2002:a05:622a:124a:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-55adbb72c40mr15083541cf.4.1794587599092; Fri, 13 Nov 2026
 08:33:19 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com> <20261111174213.3526604-9-irogers@google.com>
 <avVgPUFGCPycCWSI@google.com>
In-Reply-To: <avVgPUFGCPycCWSI@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Nov 2026 08:33:08 -0800
X-Gm-Features: AclHuK9L-E3dF8YJnLshs1tY7VQqvZTZoGdVDHChKgorJQHTyeGB3QWOADeecfk
Message-ID: <CAP-5=fVy8oN3okjJKHYvtqT0ZWWx=8uT24HkPhgvwwcKzvG4Aw@mail.gmail.com>
Subject: Re: [PATCH v12 08/20] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 10:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Nov 11, 2026 at 09:42:00AM -0800, Ian Rogers wrote:
> > In machine__process_ksymbol_register(), set the binary type of non-OOL
> > ksymbol DSOs to DSO_BINARY_TYPE__BPF_IMAGE (which
> > machine__process_bpf_event_load() upgrades to
> > DSO_BINARY_TYPE__BPF_PROG_INFO on PERF_BPF_EVENT_PROG_LOAD), and update
> > dsos__find_kernel_dso_cb() to skip DSO_BINARY_TYPE__BPF_PROG_INFO,
> > DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
> > dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/dsos.c    | 3 +++
> >  tools/perf/util/machine.c | 9 ++++-----
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> > index 1574c8885d78..fbbf98c4ccae 100644
> > --- a/tools/perf/util/dsos.c
> > +++ b/tools/perf/util/dsos.c
> > @@ -475,6 +475,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso=
, void *data)
> >        * is_kernel_module() treats it as a kernel cpumode.
> >        */
> >       if (!dso__kernel(dso) ||
> > +         dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_PROG_INFO |=
|
> > +         dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_IMAGE ||
> > +         dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__OOL ||
> >           is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMOD=
E_UNKNOWN))
> >               return 0;
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 5eb5efa4eb90..0334cb01349a 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -769,6 +769,10 @@ static int machine__process_ksymbol_register(struc=
t machine *machine,
> >                       dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
> >                       dso__data(dso)->file_size =3D event->ksymbol.len;
> >                       dso__set_loaded(dso);
> > +             } else {
> > +                     dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IM=
AGE);
>
> Shouldn't this move into the if statement below?  At least it should
> check if the ksym_type is BPF.

Good catch. Setting DSO_BINARY_TYPE__BPF_IMAGE unconditionally was done
so dsos__find_kernel_dso_cb() would also skip bpf_prog_* ksymbol DSOs
before PERF_RECORD_BPF_EVENT sets DSO_BINARY_TYPE__BPF_PROG_INFO (or
when --no-bpf-event is used), but that mislabels BPF programs as
BPF_IMAGE.

In v13, I've moved dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE)
into an `else if (event->ksymbol.ksym_type =3D=3D PERF_RECORD_KSYMBOL_TYPE_=
BPF &&
is_bpf_image(event->ksymbol.name))` block, and factored out
dso__is_bpf_prog() from __map__is_bpf_prog() (which falls back to
checking the "bpf_prog_" prefix) for dsos__find_kernel_dso_cb() to use.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                     if (is_bpf_image(event->ksymbol.name))
> > +                             dso__set_long_name(dso, "", false);
> >               }
> >
> >               map__set_start(map, event->ksymbol.addr);
> > @@ -780,11 +784,6 @@ static int machine__process_ksymbol_register(struc=
t machine *machine,
> >               }
> >
> >               dso__set_loaded(dso);
> > -
> > -             if (is_bpf_image(event->ksymbol.name)) {
> > -                     dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IM=
AGE);
> > -                     dso__set_long_name(dso, "", false);
> > -             }
> >       } else {
> >               dso =3D dso__get(map__dso(map));
> >       }
> > --
> > 2.56.0.542.g3ef89b7020-goog
> >
