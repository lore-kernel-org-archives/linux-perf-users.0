Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CB2D24BC
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720285; cv=none; b=IGDpk2dxmAv3MjAxwlzTHIQM/Aip9Q8uehGYoddo5CKYyF/J3kUDnafK/yB3CIuLyV06nwjrqUSsoPVCBfJ3I4eUbU9xaQUzHIEKqdw1ZVt89cZs8cfNwV4GpcLbgPj0ggJ+sEEg2zc7filtqrPumU6j0Una1IAyMsV8UDBMFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720285; c=relaxed/simple;
	bh=6pVtrWMsaJ8JDXcXtDpTy0joPHwG9CohFEl2B5kzkxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUzHqhJdDbj7tyuje+KDyR14LEIBj7IPhXfAa9vdKXF9a+da7f5u0Ig9tWzHHGd0oERXYvrgi0P2s/Oj5RbGarkxnqWoXpaUKEEnLdq8j6AtVKqnuCc+0y0hvcbs5kawQtewsdY+ohX0UIiDBq1DBsgIwQO0jjGbzbS7FqFb5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNzXeKQ4; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNzXeKQ4"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-59447ca49afso2703802e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 02:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763720280; x=1764325080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI7R5JR6LvOSOTt8EPeR1Vhhb84RYSq1hj60XILhUzM=;
        b=eNzXeKQ4GNr95xA8cnlyyJwvxtcFGDtfMZNgM5RL3BA5ie9iuK9cGPvwWIEe6tvAmQ
         pXYAnwAq6p8S3ImgXCOmEpbeq3970e6XsA3aXZwn6pffkfZeytkKMLEJ9hDFXy4u0N55
         VmJibVaeXqsk43rjNSedaxLTaMfVW6+XUqJO+wGeJQxv8z+RfjHSP6CCnEljBod3OW0V
         liasFArUKrTPHmwjpmrfP8UPiDa8G81DOwvnAnsqv0TBAlYjboXg2Gp08FodUvGiKg3x
         Jl2Fnn/cSEtyJv7FoPm3Gfw0QEAUgkv8z32j1qF0+6GBmB+NqieI2cC52i54OctRwHE7
         jdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763720280; x=1764325080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BI7R5JR6LvOSOTt8EPeR1Vhhb84RYSq1hj60XILhUzM=;
        b=Bz06XkAN9htuVQopfo0rvkJErLFrdrOUGDO7N056rww8UU7jUETDD4uNijK3Ahbxo8
         pdgyggwHZrqpIUpfiU/zXMz0HyHiK3GTcyhv7cTtWKOn0SN2beyUhYcCg/y43gYODKJk
         1WRBMmGTqKEwoChzNgpzIaPn5KKlgJPkXfWZQGSVy98/xv2GLgyAkjrOIyorEPFjieEA
         IUD0FCs6QO2Zv2oczHajMa9qQXZDS4/NbSnUtTgQx6YIsZlvsMUVfqzgiGFQV1tXbum3
         86EX7cxpQOjnJi1xWjvuMmHmt/hr1Py+/iZ+Li6l2W2gawtubZ34juHa83h2CLlgZuZp
         OHRw==
X-Forwarded-Encrypted: i=1; AJvYcCVNxFVRSoRqvouSnLYZKTnMI2oqhUhRmolZtzDJSmiKOzjhmYihhMPGA5ClZa9bQKD6zI1zC1kSr+kpvUUMHNWI@vger.kernel.org
X-Gm-Message-State: AOJu0YwstV526fiejWlSj3vipZayq6vZI1raa1IU2SN0wxW0mq3lwct+
	l6iGnsPykwm9Hk1N+EJi2SJVuv/W8fPWc/DvKKwRD81vlJomA0U1hXONgoo8XgYb28EuzcRGFc1
	vwpj25TontGKMLNdEEGVxz91C9BRQzHI=
X-Gm-Gg: ASbGncsFguvPgjd9AjLyd69tyR1mzMsox/9oCythjgYIOrlIllNtdmcMXh5EulUNllh
	M9z/xmXegaS2SfFMg7EJ5Kvep7xciWd1HFaAsvXc24JG/ptk/um+O4bwZWQrQNAvea7DggTFgWz
	eMKn7j7iOR3zg24/th+f2Q/pbnUhXFtAQDMbrHDMapPsBDnCT0KLyqqBirUVMM+8b7+aHFzjJts
	TK5fvoq3O+pzU7p+Oggs3c/HOyHmZHlOSfC+fxmg+/LWhg+RuFBMXTZkrmpV9mP+WFuuwk=
X-Google-Smtp-Source: AGHT+IHWNzkVLTsYPNpI8IBHbDPwQdzx8SzMb+4ZbN2XMwosPft5t3nI7s2/c5Xq/Ksboti7pft+mdCPOWRP6qvHZV4=
X-Received: by 2002:a05:6512:2354:b0:595:9d90:5dc8 with SMTP id
 2adb3069b0e04-596a3ee6e20mr616667e87.49.1763720280119; Fri, 21 Nov 2025
 02:18:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com> <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
 <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
 <CADHxFxT9fXfKVDXWxoFs0KeG+gssNhZE3y6TGKGtS=AhKPdGAg@mail.gmail.com>
 <CADHxFxR2t4jMmjm3hMdhsxoRjUw+k3CtrG6ZzG39b_BhVzyzsQ@mail.gmail.com>
 <CADHxFxROMe++VB17J3UgOxSoEhJ7bNagBHO6gRQQPpAELc1ocw@mail.gmail.com>
 <CADHxFxTHHT0bWf__dwnZXk6E8Qb2sxL5=L5KDh_Xmzq-hNYs6g@mail.gmail.com> <aR9qkB_XY-elMxSh@google.com>
In-Reply-To: <aR9qkB_XY-elMxSh@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Fri, 21 Nov 2025 18:17:48 +0800
X-Gm-Features: AWmQ_bkO8RPhHxcva_0LhqOPLGW8AR3Lggv3o8JaKvT9OD7YoChp-HarATB5ouY
Message-ID: <CADHxFxQuVjh4zVtVhjim1Ppobpb+CyeG1h6bRFFcxTCKpmaHkg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,
Thank you very much for your reply.

On Fri, Nov 21, 2025 at 3:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, Nov 19, 2025 at 05:43:41PM +0800, hupu wrote:
> > RESEND
> >
> > On Tue, Nov 18, 2025 at 3:28=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> > >
> > > Hi Leo and Namhyung,
> > >
> > > On Tue, Nov 18, 2025 at 3:18=E2=80=AFPM hupu <hupu.gm@gmail.com> wrot=
e:
> > > >
> > > > I then added KHDR_INCLUDES to BPF_INCLUDE, pointing it to the kerne=
l=E2=80=99s
> > > > self-contained header directory so that the build prefers headers
> > > > provided by the kernel.
> > > >
> > > >
> > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > index 47c906b807ef..65c6e871988b 100644
> > > > --- a/tools/perf/Makefile.perf
> > > > +++ b/tools/perf/Makefile.perf
> > > > @@ -1202,7 +1202,8 @@ endif
> > > >
> > > >  CLANG_OPTIONS =3D -Wall
> > > >  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TA=
RGET_ARCH))
> > > > -BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_=
SYS_INCLUDES)
> > > > +KHDR_INCLUDES :=3D $(abspath $(OUTPUT)/../../usr/include)
> > > > +BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
> > > > -I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
>
> I think your patch was wrapped around.
>

Oh, yes =E2=80=94 that line was automatically wrapped by the mail system
because it exceeded 80 characters.
I=E2=80=99ve slightly adjusted it so that it can be displayed correctly in
email clients, as shown below:

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..eaccaae87e3c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1202,7 +1202,9 @@ endif

 CLANG_OPTIONS =3D -Wall
 CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARC=
H))
-BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCL=
UDES)
+KHDR_INCLUDES :=3D $(abspath $(OUTPUT)/../../usr/include)
+BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) \
+               -I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE :=3D -I$(srctree)/tools/include/uapi

 ifneq ($(WERROR),0)


> > > >  TOOLS_UAPI_INCLUDE :=3D -I$(srctree)/tools/include/uapi
> > > >
> > > >  ifneq ($(WERROR),0)
> > > >
> > > >
> > > > With this change verified, perf compiles successfully even without
> > > > explicitly specifying the cross-toolchain sysroot in the compile
> > > > command.
>
> I'm not familiar with the usr directory in the kernel source.  Will it
> contain some generated headers?
>

Yes, the headers in KHDR_INCLUDES are directly copied from the kernel
source tree (sometimes with very minor modifications). They are
exactly the headers required during perf compilation.

> > > >
> > >
> > > As an additional suggestion, I=E2=80=99d prefer to keep both the abov=
e patch
> > > and the previously discussed PATCH v3, which would mean submitting tw=
o
> > > PRs. From my perspective, allowing users to pass custom compilation
> > > options via EXTRA_BPF_FLAGS is more flexible than only configuring
> > > headers, so I=E2=80=99d like to hear your thoughts.
>
> Yep, I'm ok with the extra flag variable.
>
> Thanks,
> Namhyung
>

Leo, what are your thoughts on this? I=E2=80=99d appreciate hearing your su=
ggestions.

Thanks,
hupu
