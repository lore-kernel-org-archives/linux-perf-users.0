Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D381D52B
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B65187;
	Thu, 26 Oct 2023 07:59:32 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so1510861a12.3;
        Thu, 26 Oct 2023 07:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698332371; x=1698937171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zqVne5kt5gdp1Lm2joR84aZ94MORpFkf1BW3//kdMk=;
        b=Is8Ny08Q6Cla/8/h3MLekcRpaoyX5FBhJoGV8FWGY5eq6JI1dCBvGDt4uzDENn9Fqw
         WybNJdJuXCRmPOgQzqeDom4cOj8RouzFjDyxLuRFLY+IZCyLXT3hiv5PGNoGxxx14p9O
         opGLCgdD2pY7dR2BTuRx7Gdg7WEd6t3fd3IRuQelLqKmjyKeLLH7hDKKAGILd3ikpByO
         0IpcnP8D/k7ZQTGZPBuTJ+rHG55CPeUZ9RMK0a+GJJvWPCNXlCKflrkDUHOzbsefmSTY
         mFuhKwxE62IY+Mv4UfBuRh1PQJR/j/xJ7WoTlx4KBKDvquNnjUw1z4kXxzlr1eouIDVW
         4L9A==
X-Gm-Message-State: AOJu0YyXpLdk8bEd8wSEj8f9fLPnvHo1K3EqZcG9K+1CfDUEeZwAz0d3
	udkVCjN/bJZ+ahrEWyC9gR4CsgVB24+npYIb7Qk=
X-Google-Smtp-Source: AGHT+IHLg8ZbKdKeQ7Sbgl7WtbZtflsd3XeCqa50alQqc122ppmD9DEO8sF9qLZcg/WlezBTDxe5EA==
X-Received: by 2002:a17:907:9618:b0:9a2:139:f45d with SMTP id gb24-20020a170907961800b009a20139f45dmr13995455ejc.43.1698332370519;
        Thu, 26 Oct 2023 07:59:30 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906039800b0098669cc16b2sm11654840eja.83.2023.10.26.07.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 07:59:30 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so1517352a12.1;
        Thu, 26 Oct 2023 07:59:30 -0700 (PDT)
X-Received: by 2002:aa7:d394:0:b0:53f:f908:eda8 with SMTP id
 x20-20020aa7d394000000b0053ff908eda8mr45086edq.4.1698332370208; Thu, 26 Oct
 2023 07:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com>
In-Reply-To: <20231026145659.7063-A-hca@linux.ibm.com>
From: Neal Gompa <ngompa@fedoraproject.org>
Date: Thu, 26 Oct 2023 10:58:53 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_ncGOFXVWHztqoZZUJqu+UR_U_WWwPgnhzOUqNWOkwiQ@mail.gmail.com>
Message-ID: <CAEg-Je_ncGOFXVWHztqoZZUJqu+UR_U_WWwPgnhzOUqNWOkwiQ@mail.gmail.com>
Subject: Re: s390x stack unwinding with perf?
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andreas Krebbel <krebbel@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Davide Cavalca <dcavalca@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:57=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
>
> On Thu, Oct 26, 2023 at 02:30:41PM +0200, Daan De Meyer wrote:
> > Hi,
> >
> > As part of enabling frame pointers system wide for Fedora to get fast
> > system wide stack unwinding, we're now looking to do the same for
> > s390x after previously enabling frame pointers for x86-64 and aarch64.
> > From what we can find, on s390x stack unwinding is done via the
> > "-mbackchain" compiler option. However, from some early experiments
> > rebuilding a small part of the distro, this option alone does not seem
> > to result in usable stack traces in perf (perf record -g =3D> perf
> > report).
> >
> > Are there any other compiler options that need to be enabled in order
> > to get usable stack traces in perf for s390x? Has anyone managed to
> > get this working before?
>
> So, are you saying that you want to enable "-mbackchain" for whole user
> space for Fedora? If that is the case, what certainly is missing is kerne=
l
> support to unwind user space stack frames from the kernel, since until no=
w
> no distribution had user space where it would be possible to unwind the
> user space stack from the kernel; which is the reason why this was never
> implemented.
>
> If this (or some other compiler options) will be enabled for user space, =
we
> need to add kernel support in order to make this work.

Yes, the idea is that we'd want to have this supported in Fedora to
match all the other architectures where "-fno-omit-frame-pointer" is
used.



--
Neal Gompa (FAS: ngompa)
