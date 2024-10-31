Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB91CCB36;
	Thu, 31 Oct 2024 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408270; cv=none; b=MY7a85b7hOWyl4SCu4G4fYp3BhVoYE1uZf5Idp3yz1+RSz9kPl1GTT0ijQxycCf2pL4cSKjUYwizbQKjHa1OyqrD9MH79BdfO2a84pqeqdRW1tLuH5y1cr1d+pj+tpJYVA6bz5/+LXFtpcs/UiFyomzGrFX8oKdB37Xqbfj3nHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408270; c=relaxed/simple;
	bh=d4yg9w/9Vw56lhG9Ydt399PjnwVlOwH171Y4XyoU32I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHlnad1iYDGVnGGPXz5lZoYgK/h2tijCrVREu3tYH7hfKTkxqZrJQVGI5netbDflk8WREjwxN77wgwSElCakUdYlmXfLYt2TS02Up5BWbn5p46j9e+PXg+ttzmtOLj6FugvDSmtw23YZSBRF9QPWwIA/FMbKECwEBFUAi4+ExKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3bEnjPU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3bEnjPU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so1516053a12.2;
        Thu, 31 Oct 2024 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730408263; x=1731013063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygzEaG0i+IFdhWqyLLqbh8SUXHugvUXiylqcsVNMp68=;
        b=l3bEnjPUkoJd7CZohYFpHbJ8FxodYponcFM/CkYCDc8zD6SSB9cRcyfKBYpbdQ4ZjS
         NVsZWmicpyNTm3sEC3+LR6tvHv+3nMvW7rJwpshwtBwiXA9YlWCfNS04IltHOOSyPUvt
         Dh+G8OinOA3g04ycRKuP+d73my5uTE8GTrzfPGaYDeWAECExpEfz4+UMf1khtxTe1oTH
         MpxvzcMGhcie+3+6Wc8BFqBUoxGitqAvYUVhtg+8noWsw+U7p6IXKWZe9clJE/GOd5dq
         yUx5FZGML6CIPRKE6IEkYrgmjav1y37AblJs9GTS2npDLgHMupUOvFGINVqJvMQjAg1E
         7CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408263; x=1731013063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygzEaG0i+IFdhWqyLLqbh8SUXHugvUXiylqcsVNMp68=;
        b=h2ozZDfhdPFHG+1Mx/FmHXIz7H7mh+wjv3nxpVL2P+TL9aoKB+NiH10cex3jJBm/a4
         DpHc+RJkhLDfZmdddrlktFoq5cbt4T8EtDyDUezur1t1pgPSx5OWmZQWmVqSlvvc6Nl1
         YBrPvYMzpxsKQhqnEr7eXxvetHnHhKc+CQqU0xbOaVm/cKbPJkJWkbBb/NOwZMePOE4N
         uKZ5wFjFAOaXi3PRvkWIMr4yF8eJb72oFi++tOMwIytkNAnex4H8TAPvtHQoeYoBdnXJ
         Pxlr4Jpyk+TbzyAA9xkIZPFEbxnbMDq7wDrIXWQ3POEHf6XJmnNHZxFmL2xRAEfj4EEF
         E5rw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Bsr+5BSps0MraqMZQaTmuc1vLaoVgk2MuvnFMXlz4PTjMkcQLKhnnSNDUgR8ExtHC6I/nbaXRaN7pT4V9LsYFw==@vger.kernel.org, AJvYcCVIOrjcudhJtt9L1xW0gj+i5n13ssrSWbNFFY2rn0mGDKw3LlYVgh1bddBhh2V6a3L1F8vJlzJHZhoDQF+qT6TLgg==@vger.kernel.org, AJvYcCXogRhBGX3kOvMOQkpM3KoOZQbhNdODnS4vZTd8qMvrtUwVxQj57l4N4ZdYbLcpMc4WnGQwni0PBeJnqt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyc90yGHR1nakWdQhweLLCVXtI/mtdOb22cgdCD1ajavrbkaFh
	HHLMNIzT2kQqLbcvfwSXMETliBiKTpR/FNwL2PBpWwWGZoBZuuaxLEXIrcNu3ez1NlhK2ND5Fke
	c1WRfn7oJqZUhtTZFW0Jc+5o5reU=
X-Google-Smtp-Source: AGHT+IHw2sp6E6xFgIKGilk2LAD/nLTHzg3NWYpmsoprLayI+JRpSVwQL1nl0nBLIDEYZjZAgd1AY/9F8bHDgQTTuQg=
X-Received: by 2002:a17:907:1c29:b0:a99:e67a:d12d with SMTP id
 a640c23a62f3a-a9de61ce61bmr2021732766b.48.1730408262602; Thu, 31 Oct 2024
 13:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com> <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
In-Reply-To: <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 31 Oct 2024 13:57:10 -0700
Message-ID: <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:53=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Tue, Oct 29, 2024 at 04:32:40PM -0700, Andrii Nakryiko wrote:
> > It feels like this patch is trying to do too much. There is both new
> > UAPI introduction, and SFrame format definition, and unwinder
> > integration, etc, etc. Do you think it can be split further into more
> > focused smaller patches?
>
> True, let me see if I can split it up.
>
> > > +
> > > +                       if ((eppnt->p_flags & PF_X) && k < start_code=
)
> > > +                               start_code =3D k;
> > > +
> > > +                       if ((eppnt->p_flags & PF_X) && k + eppnt->p_f=
ilesz > end_code)
> > > +                               end_code =3D k + eppnt->p_filesz;
> > > +                       break;
> > > +               }
> > > +               case PT_GNU_SFRAME:
> > > +                       sframe_phdr =3D eppnt;
> >
> > if I understand correctly, there has to be only one sframe, is that
> > right? Should we validate that?
>
> Yes, there shouldn't be more than one PT_GNU_SFRAME for the executable
> itself.  I can validate that.
>
> > > +                       break;
> > >                 }
> > >         }
> > >
> > > +       if (sframe_phdr)
> > > +               sframe_add_section(load_addr + sframe_phdr->p_vaddr,
> > > +                                  start_code, end_code);
> > > +
> >
> > no error checking?
>
> Good point.  I remember discussing this with some people at Cauldon/LPC,
> I just forgot to do it!
>
> Right now it does all the validation at unwind, which could really slow
> things down unnecessarily if the sframe isn't valid.
>
> > > +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> > > +
> > > +#define INIT_MM_SFRAME .sframe_mt =3D MTREE_INIT(sframe_mt, 0),
> > > +
> > > +extern void sframe_free_mm(struct mm_struct *mm);
> > > +
> > > +/* text_start, text_end, file_name are optional */
> >
> > what file_name? was that an extra argument that got removed?
>
> Indeed, that was for some old code.
>
> > >         case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> > >                 error =3D RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> > >                 break;
> > > +       case PR_ADD_SFRAME:
> > > +               if (arg5)
> > > +                       return -EINVAL;
> > > +               error =3D sframe_add_section(arg2, arg3, arg4);
> >
> > wouldn't it be better to make this interface extendable from the get
> > go? Instead of passing 3 arguments with fixed meaning, why not pass a
> > pointer to an extendable binary struct like seems to be the trend
> > nowadays with nicely extensible APIs. See [0] for one such example
> > (specifically, struct procmap_query). Seems more prudent, as we'll
> > most probably will be adding flags, options, extra information, etc)
> >
> >   [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-3-andrii@=
kernel.org/
>
> This ioctl interface was admittedly hacked together.  I was hoping
> somebody would suggest something better :-)  I'll take a look.
>
> > > +static int find_fde(struct sframe_section *sec, unsigned long ip,
> > > +                   struct sframe_fde *fde)
> > > +{
> > > +       struct sframe_fde __user *first, *last, *found =3D NULL;
> > > +       u32 ip_off, func_off_low =3D 0, func_off_high =3D -1;
> > > +
> > > +       ip_off =3D ip - sec->sframe_addr;
> >
> > what if ip_off is larger than 4GB? ELF section can be bigger than 4GB, =
right?
>
> That's baked into sframe v2.

I believe we do have large production binaries with more than 4GB of
text, what are we going to do about them? It would be interesting to
hear sframe people's opinion. Adding such a far-reaching new format in
2024 with these limitations is kind of sad. At the very least maybe we
should allow some form of chaining sframe definitions to cover more
than 4GB segments? Please CC relevant folks, I'm wondering what
they're thinking about this.

>
> > and also, does it mean that SFrame doesn't support executables with
> > text bigger than 4GB?
>
> Yes, but is that a realistic concern?

See above, yes. You'd be surprised. As somewhat corroborating
evidence, there were tons of problems and churn (within at least Meta)
with DWARF not supporting more than 2GB sizes, so yes, this is not an
abstract problem for sure. Modern production applications can be
ridiculously big.

>
> > > +       } else {
> > > +               struct vm_area_struct *vma, *text_vma =3D NULL;
> > > +               VMA_ITERATOR(vmi, mm, 0);
> > > +
> > > +               for_each_vma(vmi, vma) {
> > > +                       if (vma->vm_file !=3D sframe_vma->vm_file ||
> > > +                           !(vma->vm_flags & VM_EXEC))
> > > +                               continue;
> > > +
> > > +                       if (text_vma) {
> > > +                               pr_warn_once("%s[%d]: multiple EXEC s=
egments unsupported\n",
> > > +                                            current->comm, current->=
pid);
> >
> > is this just something that fundamentally can't be supported by SFrame
> > format? Or just an implementation simplification?
>
> It's a simplification I suppose.

That's a rather random limitation, IMO... How hard would it be to not
make that assumption?

>
> > It's not illegal to have an executable with multiple VM_EXEC segments,
> > no? Should this be a pr_warn_once() then?
>
> I don't know, is it allowed?  I've never seen it in practice.  The

I'm pretty sure you can do that with a custom linker script, at the
very least. Normally this probably won't happen, but I don't think
Linux dictates how many executable VMAs an application can have. And
it probably just naturally happens for JIT-ted applications (Java, Go,
etc).

Linux kernel itself has two executable segments, for instance (though
kernel is special, of course, but still).

> pr_warn_once() is not reporting that it's illegal but rather that this
> corner case actually exists and maybe needs to be looked at.

This warn() will be logged across millions of machines in the fleet,
triggering alarms, people looking at this, making custom internal
patches to disable the known-to-happen warn. Why do we need all this?
This is an issue that is trivial to trigger by user process that's not
doing anything illegal. Why?

>
> --
> Josh
