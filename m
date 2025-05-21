Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC7261588
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849239; cv=none; b=nbSWVQ0+PvuQoEacd9RSeAT/HA3DsxCN7YBCmDfOm4ETmGWkcN2bOL0n64PYQ+VdsnaCPsobTj69peyvcN31rr8ENxdQppITpIeV0YNIF0uiOFKd9zUmeuuYH4SJWInk+alfv8BTss9fV4xdbfKM5CN0qDJrBo31MYM5sYuhJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849239; c=relaxed/simple;
	bh=PTXGIeTnGMX3g14xDrtXMvbBpa+Qj89XVKtEUS0m+gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1KA10adPuhpWFaU7Pt1FFtfoBbDABF2akJOyUmEcS1Tkb9/kSkIP+5PqjYr9fI4ZWBNA8ANI4Vl6r0iNyc+98kehO48Dvjm/UDy46Y/mKT4k1iXx1AqkziucjxtpQnnHZJSGuAPfNiDKvrb5081mwjL8Sgw3Y7/8KabhHkC3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iPFubfBF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iPFubfBF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso88345225e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747849235; x=1748454035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1jGbAJIfAmBuq60m9cLcCzR1qg6oy8JqAOHCwyna+M=;
        b=iPFubfBFq1U7+lyjpkYEKj1r+LqVAb7glIITTdRy35gmwA2px1XD43X0lpxFzg81fw
         0RIZqf7oF8U+XkUtHIENECUt+EOcXS4k61apboclbgcGX8boybD+cUY/Yn1K+7vGzTuT
         ri5fbAVmuUkPdKLAybvIaLJrt7wAH+tOOajtWPQtRn7hH4oZe/qsEvPiPdJ4wSIdZNwx
         rWTdosydmbQ/0Hzu/qEH8b5g1qjUC8E2MlqslBYh4QgD6eHzAAfvQZIdYyELd6+xKD07
         jqoNoWKbYLTav3a0LzH9gWotqtVRRcsyjA/KqEc3Ix6Odz9z/KbPRs3iefqpgPnTX6PF
         x9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747849235; x=1748454035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1jGbAJIfAmBuq60m9cLcCzR1qg6oy8JqAOHCwyna+M=;
        b=fwzxDjrDWLE6prDq1m9/Ws6RgkqmNk0AXaXvw5bj7/u7tEpRjtBOzvj3w5hQc94eqa
         6O2OMz8hLL39+kYwQRtNButjGJi/auBKPE91N6XU5CDiqKgGk+86COJAZyouysrEmx+t
         NDEQJyDBUVXO/nDxsCdirAP7NbSo6rtvYfi3U6z5zApNB9DQSzI+i/8Fwl8zi+8HQZZE
         Az+QZY/nK697ooI2/IjWbOOw6Lsrwh9iGsSYY/jznG2VdKkFMk5QwgAIjB/2ExZIXemh
         YSXnNnqw5HEEJQbLa8bv4zP+E5iCN4KSv2UQHOqD5Tb03wpu8pIj4z6yB5GdZEyO0iSo
         nX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbZ+fRIqjDQZ64V4AaBtfVf5XKEgSYQ2jBD8hWBaArt7z2HJL33wcfYOM6tkvUsXwH1NW2N/Zb9VK529D0Iy1M@vger.kernel.org
X-Gm-Message-State: AOJu0YyEabWpbaKeoCk3PKAhMKm3M9EXC/PNV+j1rnJbVlrw7h8sPWch
	JerUmfF1yYyoO99vzsdxtf7Nhu6o074CSVyanRvlrp/VEJpB+nNOk0tgRcxHlqY90oHZkm0beOG
	oI81L/gNkVxySfTaHO2lc3O7moFQ1obq3kITPvZif9PJDVbsSQ6ochqw=
X-Gm-Gg: ASbGncsvh0PvS+uzt/n/wNQViFnJQ1yowZNNJBnWWo+uDFYzEP0zIMn4yr6K9Qbga12
	jNyGC+9hg/s7SPChg4ww7tsLzopsS4Zc2bgcwsUxa5EO345GMxzE3qZwIpiUf9tmbuvFSyp4tru
	k/aBUQd7fikMfmBUUxdmcGHaFQS35hbaQwUss6P8o8dIE94E7i/okwMfaVUhAXuYUJqg==
X-Google-Smtp-Source: AGHT+IF7t556SFgYKCEZNLGSlvhLTbE8zyePAWqPOGCGeXQD0OKNEoiW7nBffL6Xodz6FR//5os8RUXoFUs57s9QzV4=
X-Received: by 2002:a05:600c:154f:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-442fd664a29mr161787315e9.20.1747849235122; Wed, 21 May 2025
 10:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116230955.867152-1-rkanwal@rivosinc.com> <20250116230955.867152-2-rkanwal@rivosinc.com>
 <CAP-5=fU9ovvb-JopPqQfNaj6xtL=u_WZO-b56RdhBmUw4mY0ZA@mail.gmail.com>
 <CAECbVCvX8St8sXh9pTnyO_94-cJT_DB4MyggtS_-PXqWNtXDXw@mail.gmail.com>
 <CAECbVCui6ZgHBXBr3LdVGd16ERe0GgAnA1zy_zOQZVTU3bPoWw@mail.gmail.com> <CAP-5=fUy0QfmazuNq1yJzAxsuM7wD3zD=KAVMGHuw0wXvez1ww@mail.gmail.com>
In-Reply-To: <CAP-5=fUy0QfmazuNq1yJzAxsuM7wD3zD=KAVMGHuw0wXvez1ww@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Wed, 21 May 2025 18:40:24 +0100
X-Gm-Features: AX0GCFuGfEgMYyqBQoNOMkZCo0wBsBMY3yB9bZY3USVl_oy_pisRJUdYTWzGPgk
Message-ID: <CAECbVCtCDrXu4w5s=3o85GVKRb9o566W-v04wWMO=VgjOOpRHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] perf: Increase the maximum number of samples to 256.
To: Ian Rogers <irogers@google.com>
Cc: ak@linux.intel.com, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ajones@ventanamicro.com, 
	anup@brainfault.org, acme@kernel.org, atishp@rivosinc.com, 
	beeman@rivosinc.com, brauner@kernel.org, conor@kernel.org, heiko@sntech.de, 
	mingo@redhat.com, james.clark@arm.com, renyu.zj@linux.alibaba.com, 
	jolsa@kernel.org, jisheng.teoh@starfivetech.com, palmer@dabbelt.com, 
	will@kernel.org, kaiwenxue1@gmail.com, vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am not sure tbh. I have never worked with this part of perf tool before.
I think someone else with a deeper understanding of perf can answer
this better. I will also try to go through it to build some understanding.

Also, I think this can be done as a new work item/series. Currently I am
just trying to increase the number of entries the remove_loops function
can process. Going through the commit description now, I feel like
I have not done a good job of describing the change.

Basically when I use --branch-history option on report cmd to
add the branches to callstack, the remove_loops logic complains
about the size of the sample and discards the sample as
corrupted sample because it's been hardcoded to process
maximum of 127 entries.

Here is the patch that added this option:
https://lore.kernel.org/all/1415844328-4884-3-git-send-email-andi@firstfloo=
r.org/T/#u

Thanks
Rajnesh

On Wed, May 21, 2025 at 4:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, May 21, 2025 at 3:47=E2=80=AFAM Rajnesh Kanwal <rkanwal@rivosinc.=
com> wrote:
> >
> > On Thu, Apr 17, 2025 at 1:51=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosin=
c.com> wrote:
> > >
> > > + Adding Andi Kleen.
> > >
> > > On Thu, Feb 20, 2025 at 6:51=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Thu, Jan 16, 2025 at 3:10=E2=80=AFPM Rajnesh Kanwal <rkanwal@riv=
osinc.com> wrote:
> > > > >
> > > > > RISCV CTR extension support a maximum depth of 256 last branch re=
cords.
> > > > > The 127 entries limit results in corrupting CTR entries for RISC-=
V if
> > > > > configured to be 256 entries. This will not impact any other arch=
itectures
> > > > > as it is just increasing maximum limit of possible entries.
> > > >
> > > > I wonder if rather than a constant this code should just use the au=
to
> > > > resizing hashmap code?
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/perf/util/hashmap.h
> > > >
> > > > I assume the value of 127 comes from perf_event.h's PERF_MAX_STACK_=
DEPTH:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/include/uapi/linux/perf_event.h#n1252
> > > >
> > > > Perhaps these constants shouldn't exist. The perf-record man page m=
entions:
> > > > sysctl.kernel.perf_event_max_stack
> > > > which I believe gets a value from
> > > > /proc/sys/kernel/perf_event_max_stack, so maybe these should be
> > > > runtime determined constants rather than compile time.
> >
> > While working on this, I came across the following two patches. It
> > looks like what
> > you have suggested, it was tried before but later on Arnaldo reverted t=
he change
> > from report and script cmds due to reasons mentioned in the second patc=
h.
> >
> > https://lore.kernel.org/lkml/1461767472-8827-31-git-send-email-acme@ker=
nel.org/
> > https://lore.kernel.org/lkml/1463696493-27528-8-git-send-email-acme@ker=
nel.org/
>
> Thanks Rajnash, agreed on what you found. I wonder to resolve the
> issue we could add a header feature:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/header.h?h=3Dperf-tools-next#n21
> for max stack depth.
>
> Thanks,
> Ian
>
> > Regards
> > Rajnesh
> >
> >
> > > >
> > >
> > > Thanks Ian for your feedback. I am not sure if it's feasible to use a=
uto
> > > resizing hashmap here. On each sample of 256 entries we will be doing
> > > 6 callocs and transferring a whole lot of entries in hashmap_grow. We
> > > can't reuse old hashmap as well. On each sample we bear the same cost
> > >
> > > But I do agree this should be more dynamic but the maximum number
> > > of entries remove_loops can process is limited by the type of chash a=
rray
> > > here. I can change it and related logic to use uint16_t or higher but=
 we
> > > will still have a cap on the number of entries.
> > >
> > > PERF_MAX_BRANCH_DEPTH seems to be denoting what remove_loops
> > > can process. This is being used by thread__resolve_callchain_sample t=
o
> > > check if the sample is processable before calling remove_loops. I thi=
nk
> > > this can't be changed to use perf_event_max_stack. But I can rename
> > > this macro to avoid confusion.
> > >
> > > I didn't notice PERF_MAX_STACK_DEPTH. This seems to be defined in
> > > multiple places and touches bpf as well. I agree that we should avoid
> > > using this macro and use runtime determined value instead. Tbh I don'=
t
> > > have super in-depth perf understanding. I will give this a try and se=
nd a
> > > patch in the next update. It would be helpful if you can review it.
> > >
> > > Thanks
> > > -Rajnesh
> > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > > > > ---
> > > > >  tools/perf/util/machine.c | 21 ++++++++++++++-------
> > > > >  1 file changed, 14 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.=
c
> > > > > index 27d5345d2b30..f2eb3c20274e 100644
> > > > > --- a/tools/perf/util/machine.c
> > > > > +++ b/tools/perf/util/machine.c
> > > > > @@ -2174,25 +2174,32 @@ static void save_iterations(struct iterat=
ions *iter,
> > > > >                 iter->cycles +=3D be[i].flags.cycles;
> > > > >  }
> > > > >
> > > > > -#define CHASHSZ 127
> > > > > -#define CHASHBITS 7
> > > > > -#define NO_ENTRY 0xff
> > > > > +#define CHASHBITS 8
> > > > > +#define NO_ENTRY 0xffU
> > > > >
> > > > > -#define PERF_MAX_BRANCH_DEPTH 127
> > > > > +#define PERF_MAX_BRANCH_DEPTH 256
> > > > >
> > > > >  /* Remove loops. */
> > > > > +/* Note: Last entry (i=3D=3Dff) will never be checked against NO=
_ENTRY
> > > > > + * so it's safe to have an unsigned char array to process 256 en=
tries
> > > > > + * without causing clash between last entry and NO_ENTRY value.
> > > > > + */
> > > > >  static int remove_loops(struct branch_entry *l, int nr,
> > > > >                         struct iterations *iter)
> > > > >  {
> > > > >         int i, j, off;
> > > > > -       unsigned char chash[CHASHSZ];
> > > > > +       unsigned char chash[PERF_MAX_BRANCH_DEPTH];
> > > > >
> > > > >         memset(chash, NO_ENTRY, sizeof(chash));
> > > > >
> > > > > -       BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
> > > > > +       BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
> > > > >
> > > > >         for (i =3D 0; i < nr; i++) {
> > > > > -               int h =3D hash_64(l[i].from, CHASHBITS) % CHASHSZ=
;
> > > > > +               /* Remainder division by PERF_MAX_BRANCH_DEPTH is=
 not
> > > > > +                * needed as hash_64 will anyway limit the hash
> > > > > +                * to CHASHBITS
> > > > > +                */
> > > > > +               int h =3D hash_64(l[i].from, CHASHBITS);
> > > > >
> > > > >                 /* no collision handling for now */
> > > > >                 if (chash[h] =3D=3D NO_ENTRY) {
> > > > > --
> > > > > 2.34.1
> > > > >
