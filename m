Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D02135CB
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824453; cv=none; b=OpRUZV0g8X3EWyMbxVD3RkicPe6CFXXTkjjcnA2cLLieS7duNKtzb9uP9Dmne5plROQN6FAwXomLrZHQGqi+NbPpH4fiuhQyD6TE3DY/YSt4G7m0f2DmvaR+aTlUfvkLUXK+Nyn/2s3YrOJiqNP56OtEAvVXETUud4aE/7zla3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824453; c=relaxed/simple;
	bh=BbxlfG89R+9CWGmNVrpafcf2XFd18slMK57tLjE9zkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcDKq8KiuBVhsOCiXGvTCdN460QIOyupXREyJ0Cy0L4YAmj59tFb2QMJWh3QLe/BnC6Hq+qxxQ/+caABjHBYvLiuWuMGhsxY4SbL0+2YBbjoL/lvh5yD9vosfoyyZ9jKXXYg9WVkDt0AwiIBOhTw3I6hr29I0VXW0+3Jy7dj9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kFl3WIKn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kFl3WIKn"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a3681aedf8so3475162f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747824449; x=1748429249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuPh8lUlczaY3BGjlWUSLoXDI89Tgqqt75TgaRLFcUw=;
        b=kFl3WIKn1BluDXChLwDtpVdJDjEr2NVYZTTiwy+EAMMGaeSh7uzY0vCHTadnIEl36p
         7Rvq21tp4hukHNQpVg60gcTDMf8Pvu41SLI0aTiNa4bRCofLfa4kyJMhPmU3KqXTvi7g
         SCO40AMUGvhkgK5SOtr8EqJ8DTF2v7ySMAaLtq2dLh7zGqLZZoj8H9XWi/ljrY9IesDn
         MAn/Y1d5+niGKzEYuD2t9MjzCYG4GY9MiARGcGgMf4LSspkYRE4zktoyb2hUyH5N9cFU
         v1JbRFyAJXHr580CT71VwGX4fUc4VfVRh0jjmhrQx5f+OZSLfqINnqgPUC04RVQJ+MiZ
         QB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824449; x=1748429249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuPh8lUlczaY3BGjlWUSLoXDI89Tgqqt75TgaRLFcUw=;
        b=jnW2BlcsNLhRn1vpaIAmGqs6qU2dYBMnakEmYWwgz71iP7IrnxFinTK+9MNlE0Pg7D
         9CNRo+hRyzx4EvcM2Kaja62sJzfzvo+UlIJDewA0iTbUk8vhL8fnQmK9r5UoF8O+9/jA
         gBGA1ewcbo1RYd6XOpoSW/voXIK1AUVavr+qTYIhbBP+33zFcwVvDGuO1q0BeGBriEih
         /tZihAA9x1wYRny18A+DGL2U4bhmyAAXWTFLSype9eK4g7OFhmNFpD7ldEFkdakJSd+o
         mYaMD7u8iTHukaurn9bjxJXeJdhx7IxdMtx2l635dVXaBkzi69eVtOnNXBVxGJQNAIEA
         rY1g==
X-Forwarded-Encrypted: i=1; AJvYcCWi7jojUFQnKR6GDhbFI5YsDVzGYixZMUMbjD/jX+kgeleJhKJdw0ewpcotlF2FTF64B/yQ9WO6leDsSihrq9oV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/9Li/J2cMitCwJv6ARgcGuOUQx5i/zywHTZ3DAZzvZVal5wY
	FzHGUOvsoHMbC/GWWfWGhYqmrQShc9FKy7iHEZK9WcWZfsGm27sggnsIFrz2HpaXTj6uJVhMUOp
	i1qGoPupZr83nfTMcl4KzAz54ttLqMgkLEQ8b2AxwmA==
X-Gm-Gg: ASbGncuLclq/cA5Fm0OY2AFgn8q7FSgAewPVYYk/ISFsJ1oCNyNKHKgutp+QQd3u45f
	i0bEy7iOwbfmb+d0Ljnjqt8A0UMKQTwFao00EIzUXGvy0hLrR6hT/HMh284KldpAtnv4UBLkhAt
	NKROWeyQZNm6UrhglWK6fnM75X/ttOuUSLFPwq/LCYJoxHZ3Pe5npQdtYPsiNFmsL03w==
X-Google-Smtp-Source: AGHT+IGWLqIKvXp7uTTelzRMHmTQzbuuwrui/N/uxywbrLDDyPwY7Oe/OpLTj407ZB5WzuCvFYwjCBz9VDD0W0w8LJM=
X-Received: by 2002:a05:6000:420c:b0:3a3:7709:3038 with SMTP id
 ffacd0b85a97d-3a3770931fdmr7245809f8f.38.1747824449047; Wed, 21 May 2025
 03:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116230955.867152-1-rkanwal@rivosinc.com> <20250116230955.867152-2-rkanwal@rivosinc.com>
 <CAP-5=fU9ovvb-JopPqQfNaj6xtL=u_WZO-b56RdhBmUw4mY0ZA@mail.gmail.com> <CAECbVCvX8St8sXh9pTnyO_94-cJT_DB4MyggtS_-PXqWNtXDXw@mail.gmail.com>
In-Reply-To: <CAECbVCvX8St8sXh9pTnyO_94-cJT_DB4MyggtS_-PXqWNtXDXw@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Wed, 21 May 2025 11:47:18 +0100
X-Gm-Features: AX0GCFuAJ7CTZOCLEIx1J9F8NwWg5BFa7WW9XLKJsd7oIYnChaTtfUeId9q8_es
Message-ID: <CAECbVCui6ZgHBXBr3LdVGd16ERe0GgAnA1zy_zOQZVTU3bPoWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] perf: Increase the maximum number of samples to 256.
To: Ian Rogers <irogers@google.com>, ak@linux.intel.com
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	ajones@ventanamicro.com, anup@brainfault.org, acme@kernel.org, 
	atishp@rivosinc.com, beeman@rivosinc.com, brauner@kernel.org, 
	conor@kernel.org, heiko@sntech.de, mingo@redhat.com, james.clark@arm.com, 
	renyu.zj@linux.alibaba.com, jolsa@kernel.org, jisheng.teoh@starfivetech.com, 
	palmer@dabbelt.com, will@kernel.org, kaiwenxue1@gmail.com, 
	vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 1:51=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:
>
> + Adding Andi Kleen.
>
> On Thu, Feb 20, 2025 at 6:51=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Jan 16, 2025 at 3:10=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosin=
c.com> wrote:
> > >
> > > RISCV CTR extension support a maximum depth of 256 last branch record=
s.
> > > The 127 entries limit results in corrupting CTR entries for RISC-V if
> > > configured to be 256 entries. This will not impact any other architec=
tures
> > > as it is just increasing maximum limit of possible entries.
> >
> > I wonder if rather than a constant this code should just use the auto
> > resizing hashmap code?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/hashmap.h
> >
> > I assume the value of 127 comes from perf_event.h's PERF_MAX_STACK_DEPT=
H:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/uapi/linux/perf_event.h#n1252
> >
> > Perhaps these constants shouldn't exist. The perf-record man page menti=
ons:
> > sysctl.kernel.perf_event_max_stack
> > which I believe gets a value from
> > /proc/sys/kernel/perf_event_max_stack, so maybe these should be
> > runtime determined constants rather than compile time.

While working on this, I came across the following two patches. It
looks like what
you have suggested, it was tried before but later on Arnaldo reverted the c=
hange
from report and script cmds due to reasons mentioned in the second patch.

https://lore.kernel.org/lkml/1461767472-8827-31-git-send-email-acme@kernel.=
org/
https://lore.kernel.org/lkml/1463696493-27528-8-git-send-email-acme@kernel.=
org/

Regards
Rajnesh


> >
>
> Thanks Ian for your feedback. I am not sure if it's feasible to use auto
> resizing hashmap here. On each sample of 256 entries we will be doing
> 6 callocs and transferring a whole lot of entries in hashmap_grow. We
> can't reuse old hashmap as well. On each sample we bear the same cost
>
> But I do agree this should be more dynamic but the maximum number
> of entries remove_loops can process is limited by the type of chash array
> here. I can change it and related logic to use uint16_t or higher but we
> will still have a cap on the number of entries.
>
> PERF_MAX_BRANCH_DEPTH seems to be denoting what remove_loops
> can process. This is being used by thread__resolve_callchain_sample to
> check if the sample is processable before calling remove_loops. I think
> this can't be changed to use perf_event_max_stack. But I can rename
> this macro to avoid confusion.
>
> I didn't notice PERF_MAX_STACK_DEPTH. This seems to be defined in
> multiple places and touches bpf as well. I agree that we should avoid
> using this macro and use runtime determined value instead. Tbh I don't
> have super in-depth perf understanding. I will give this a try and send a
> patch in the next update. It would be helpful if you can review it.
>
> Thanks
> -Rajnesh
>
> > Thanks,
> > Ian
> >
> > > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > > ---
> > >  tools/perf/util/machine.c | 21 ++++++++++++++-------
> > >  1 file changed, 14 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 27d5345d2b30..f2eb3c20274e 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -2174,25 +2174,32 @@ static void save_iterations(struct iterations=
 *iter,
> > >                 iter->cycles +=3D be[i].flags.cycles;
> > >  }
> > >
> > > -#define CHASHSZ 127
> > > -#define CHASHBITS 7
> > > -#define NO_ENTRY 0xff
> > > +#define CHASHBITS 8
> > > +#define NO_ENTRY 0xffU
> > >
> > > -#define PERF_MAX_BRANCH_DEPTH 127
> > > +#define PERF_MAX_BRANCH_DEPTH 256
> > >
> > >  /* Remove loops. */
> > > +/* Note: Last entry (i=3D=3Dff) will never be checked against NO_ENT=
RY
> > > + * so it's safe to have an unsigned char array to process 256 entrie=
s
> > > + * without causing clash between last entry and NO_ENTRY value.
> > > + */
> > >  static int remove_loops(struct branch_entry *l, int nr,
> > >                         struct iterations *iter)
> > >  {
> > >         int i, j, off;
> > > -       unsigned char chash[CHASHSZ];
> > > +       unsigned char chash[PERF_MAX_BRANCH_DEPTH];
> > >
> > >         memset(chash, NO_ENTRY, sizeof(chash));
> > >
> > > -       BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
> > > +       BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
> > >
> > >         for (i =3D 0; i < nr; i++) {
> > > -               int h =3D hash_64(l[i].from, CHASHBITS) % CHASHSZ;
> > > +               /* Remainder division by PERF_MAX_BRANCH_DEPTH is not
> > > +                * needed as hash_64 will anyway limit the hash
> > > +                * to CHASHBITS
> > > +                */
> > > +               int h =3D hash_64(l[i].from, CHASHBITS);
> > >
> > >                 /* no collision handling for now */
> > >                 if (chash[h] =3D=3D NO_ENTRY) {
> > > --
> > > 2.34.1
> > >
