Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E320264F9C
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842920; cv=none; b=rir6oFBpRKvwNsrOtKjKWAp9VGW2Xr2ElExebG3hM1N95TUR899r7gO0Y0l3sxsuhW3DQAYK4XXSx8bb5Wr19v4E64pUygtkpYZkVJPeAJbzyc40/dXKgMIzrIR+nTszFXMg4oFgOmvE5t52CapMyOLBpJRcmovurWJuAL6MDr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842920; c=relaxed/simple;
	bh=p14RUDeAUGxmUyMq3WOavZ7XrOgeM8GVTwdiO+BNbys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmxXGA8gsZvgN1zbW2QaPY+xSOL/aL5jurjemJ82bLzlcpyNm1i83qPvV6NaeAD+C7SSTYTAbY4If9JQZrETT04cecnbqn2QXrc13pX/3H6DEgdQa2d12Oami+7/F6kLEfjQMB5pE88SXv4slE21XX67aXPRHYoxxhSEQEhnQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-932c247fb9aso611938241.2
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 09:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842918; x=1762447718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hreLLxVwoZIv1vtrLF1uQpFX+MBHZRjdsbs+eOIPXhU=;
        b=hekHUr2iWNwv89nD5W7OkTFngu5/i7/SXt52dfjKKXLYxBcyEaNtkOU7ud6x674OZA
         2f7CbMqtQCeHGEf847qdu9zFsRiHEaYNwL8UpEGIgKrbVjcEiw7ZluLtV0d7cIDYWJKL
         BZtkKkr8nS5beYa8r8n1fMIRK4tLmY2AHsUoXU3mhYinrB1AeTQDSzrOih5kKDBjgb6L
         pw0PXuePQkqUVfWYiO1vfd4o9oFVX8AkzP+l3OQDbiQOLwyhbobOf62kFtkolXNYIzSn
         52OeSr41+hrVoz6gkKkcmQbgphuAG992wZKdLIJVzMc4Gf7TNsSGR4IkIo+qBsaJLPqT
         eINw==
X-Forwarded-Encrypted: i=1; AJvYcCXZpYFK/wKQMEbszAqFxReB4vIW4iQhivQsInkAoVp3hUoJEIjfv7+hhUm4GGUKxW6ZFxl0G+iKTBjHWaXZ7lF/@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtGq1UNYIhUifBj/Utp0p63g+lTPWt1OKWyf2D56TV0WjPDZ2
	ZsGEpOKg6FjUVMwaNBS2rUdFfITvfU4I2t0u+AHk7AeDS1TMHNQi2lvvL39A1g==
X-Gm-Gg: ASbGnct9tIiapOTqHieXcKvVLuDlgQ5PkrBhobc4Hd7OGwzbOYgAxos3lAorJuIAjIy
	FX7GggpqPbDOBPlk+ctMjBKAMA3zZPm9x4y9paKo0QW2MF9BtF5TouR8OjwzBigOrcn0LFjQQ8R
	/c4cQSbluIMCuv7y+7nPcWPc52llJhCJ5yk67+Nf2In3SBGwTf9WM+QVcnJoE3JlxbJtKBnFxj8
	6xEp9o94p7tzSqTNxJ6zdU3NdtHmoq9ESZz3OHPohhK6fML6ycfnTIgwSYuDC5+s1wRBYFCl/fs
	8Ru8dhkUCmf6NiFjCdwtDt0o9zNaPnfkPmUNCjNGmpoFGMPqk/ZTDCYzrkKI4OH4m4gWERnlxGg
	dLqcJEW99Wvgyv7uw3YF6sXz2z32n8nWd9Og78+8gmr2azE1x9rMyPJMv8LwOzXZJxftWcp3Q7f
	+NBywe3lLSN2PG00wsuqQITVP81iUckQOKcOztox1wXHSD6rFSUPQ=
X-Google-Smtp-Source: AGHT+IFC96+nq1yvJCr+EQKNNHBeWhUrgNta0dBFvEzeeOcUBcR/EHUDS/9ncLsRCBu+0PIllMDsfQ==
X-Received: by 2002:a05:6122:1d53:b0:557:16bd:4e52 with SMTP id 71dfb90a1353d-5593e2c530cmr259441e0c.6.1761842917608;
        Thu, 30 Oct 2025 09:48:37 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb3004bsm6704964e0c.11.2025.10.30.09.48.37
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:48:37 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018ea5625so668954241.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 09:48:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBWTFV8UEV2aywxXV9mZP8MYiyIC93xRa+fubgejJ2SzxqK6RT9zU/qRB0fa+2aBua6Lw0NBnarlMls8P6eLpI@vger.kernel.org
X-Received: by 2002:a05:6122:8c0f:b0:54c:da0:f711 with SMTP id
 71dfb90a1353d-5593e2ffd39mr273505e0c.7.1761842917258; Thu, 30 Oct 2025
 09:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr> <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 09:48:50 -0700
X-Gmail-Original-Message-ID: <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
X-Gm-Features: AWmQ_blRN2P8E4UpSirTqfChk89fbu3buxosHqC3dg5TrVhE_4RGdVBUnlMBtXE
Message-ID: <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Peter Zijlstra <peterz@infradead.org>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
> > I've been following the SFrame discussion and wanted to share some
> > concerns about its viability for userspace adoption, based on concrete
> > measurements and comparison with existing compact unwind
> > implementations in LLVM.
> >
> > **Size overhead concerns**
> >
> > Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is
> > approximately 10% larger than the combined size of .eh_frame and
> > .eh_frame_hdr (8.06 MiB total).  This is problematic because .eh_frame
> > cannot be eliminated - it contains essential information for restoring
> > callee-saved registers, LSDA, and personality information needed for
> > debugging (e.g. reading local variables in a coredump) and C++
> > exception handling.
> >
> > This means adopting SFrame would result in carrying both formats, with
> > a large net size increase.
>
> So the SFrame unwinder is fairly simple code, but what does an .eh_frame
> unwinder look like? Having read most of the links in your email, there
> seem to be references to DWARF byte code interpreters and stuff like
> that.
>
> So while the format compactness is one aspect, the thing I find no
> mention of, is the unwinder complexity.
>
> There have been a number of attempts to do DWARF unwinding in
> kernel space and while I think some architecture do it, x86_64 has had
> very bad experiences with it. At some point I think Linus just said no
> more, no DWARF, not ever.
>
> So from a situation where compilers were generating bad CFI unwind
> information, a horribly complex unwinder that could crash the kernel
> harder than the thing it was reporting on and manual CFI annotations in
> assembly that were never quite right, objtool and ORC were born.
>
> The win was many:
>
>  - simple robust unwinder
>  - no manual CFI annotations that could be wrong
>  - no reliance on compilers that would get it wrong
>
> and I think this is where SFrame came from. I don't think the x86_64
> Linux kernel will ever natively adopt SFrame, ORC works really well for
> us.
>
> However, we do need something to unwind userspace. And yes, personally
> I'm in the frame-pointer camp, that's always worked well for me.
> Distro's however don't seem to like it much, which means that every time
> I do have to profile something userspace, I get to rebuild all the
> relevant code with framepointers on (which is not hard, but tedious).
>
> Barring that, we need something for which the unwind code is simple and
> robust -- and I *think* this has disqualified .eh_frame and full on
> DWARF.
>
> And this is again where SFrame comes in -- its unwinder is simple,
> something we can run in kernel space.
>
> I really don't much care for the particulars, and frame pointers work
> for me -- but I do care about the kernel unwinder code. It had better be
> simple and robvst.
>
> So if you want us to use .eh_frame, great, show us a simple and robust
> unwinder.

Hi Peter,

Thanks for this perspective=E2=80=94the unwinder complexity concern is
absolutely valid and critical for kernel use.
To clarify my motivation: I've seen attempts to use SFrame for
userspace adoption
(https://fedoraproject.org/wiki/Changes/SFrameInBinaries ), and I
believe it's not viable for that purpose given the size overhead I
documented. My concerns are primarily about userspace adoption, not
the kernel's internal unwinding.

If SFrame is exclusively a kernel-space feature, it could be
implemented entirely within objtool =E2=80=93 similar to how objtool --link
--orc generates ORC info for vmlinux.o. This approach would eliminate
the need for any modifications to assemblers and linkers, while
allowing SFrame to evolve in any incompatible way.

For userspace, we could instead modify assemblers and linkers to
support a more compact format or an extension to .eh_frame , but it
won't be SFrame (all of Apple=E2=80=99s compact unwind, ARM EHABI=E2=80=99s
exidx/extab, and Microsoft=E2=80=99s pdata/xdata can implement C++ exceptio=
n
handling , while SFrame can't, leading to a huge missed opportunity.)
