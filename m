Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1D22D7B5
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860663; cv=none; b=dfuyW9VKyRtvL0gZwLlDdvzQachsNDWqDYUg+KGUOHDY2LC031HDx8ad0F1LGuIx9l6p18LlLLO/CcQU7KVCJ/XcxMmTBGzCHBxgPgcjaNAKIrEUq+sRMMo4hugBO3JyvbAMrbWnTazjASf0lg3S1MBLmDk7RP+b69pWIeAJfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860663; c=relaxed/simple;
	bh=ZeXiHDdkFTyro4m7D8rDRiv+zdFWHvj8rUH/gYwzb8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k85vZfRdw20eyMzH7NsDvayKMsagpKVayELCyy9A+YZjbqr4NkwWiYCOVI5EIQouQ7pv1HeWbAbs9fGrMhjy6fDRrV63r60XGghQjrHiEitCKoECjaHTQJxhh9GySYMucrEuaT8cBizNgkvJVer3xThlXdBi+0LeCDJR+IS7vhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBxVUYZW; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBxVUYZW"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-37777912161so33951301fa.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760860660; x=1761465460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrZ+RYXA/gbsIxlipZ39/D3iY8XlMP2fmr07JQCelQo=;
        b=gBxVUYZWUODalB7m5eGxDnApG808Hm5kr8A0WMvQq5n2TFPfEZqHbRUmt82n8EHfAm
         xW7mAjoBSzJR8VgX149TKIPpFxUurIJMbw0AkcErp7weg6fr6Owv7n2shsS4g4S7xVS4
         MNm2uytdX/ktpCREAP6gf7X304Bs3T77vSNRwYrffEDlmNd1Zn4OGqzan+3zKWY4xxkF
         CLN2TSO+eaIhUTCU0gT68spxC6gtcssraFZAOpbtt7TH3uQi95niqBvEy6WycrOvqj7s
         uojZeiCeTNb/X6GzHpvqdjYCht2Wfp40V0IkHHsWmQ3wkKWp2GoKR+AFsbJXj0BTy0A/
         bPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860660; x=1761465460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrZ+RYXA/gbsIxlipZ39/D3iY8XlMP2fmr07JQCelQo=;
        b=Dkh5Zb0bXl13ZDez/FWPzDl8qNkO/qRg5zJg4fJS0jpJM3yTmAsjtNQ3NhLtpK9cRf
         j1aiBuxp8LWWOdcLNXIJ/FXTUcqtl+/JVn8NAfrsw5y2nslfN7YJVUPcgAjH9FAP/OFo
         w4HaojpYaiQmuScmUnsbV6xn9WEMYkbghOZhCzka4il25/SbZHU8yw6ckEAblcTtau/8
         P6+ilcd/ikL6WjR4RFcDgWKRKl/u7H0+B/Vti007a9LG1beFBNlv57OYV69vY1z7HV7C
         qeyNTT6c+xkE9qL+ci70FZsOMYAKPixOHM6Wkn1i+wVklLoqHUo4Fb1b+vMZb5zKPzIx
         9jjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZKNuxMIr3U1+f4t+BU7zrPQTFyx9EwZ4sY5ZAphyVm5rCjW+7JaZTte2dlyEQ48xnpVppANIxbX2yPK95DM/I@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/6vj3vnJ8UZ2ZZcAKWV1todRFxpm/KllOSI9fEGjctwLW9WY
	2Yg1lt1Suhq4U44QoNx3DYvK7aRw7HQycGLm4jWV69EVui57+VlAZetf3cmwS7GNn8IcYPJjhfi
	JrY1WlGA8j0z0VzJxBkjFmQLLuWmrICQ=
X-Gm-Gg: ASbGncuEtjqxrwltY29pCszby8+GZ3YQQ6CexQcKsrk0CfcYZgmNt3uxwT+MWkL5Ibo
	gZFB44pYG3CxBhf1TAOlhs7fsVrsurj6lmmSLOPnVDf0zWbRFXJjqDAhMEDMPMeRdOhEGBuc/Q/
	y5+4xIJQz/GNPATN/UYgLKcXgvJWz+JDAEaOZo6IDg4ae1sOEqPVll9i0fXs7SqOni0wyMU4Bka
	nsECWJ+/VhAIXLhlUSbBlgeb/AwDRipLMb0q3sGfQt1rtVaaV3eLeS/qAL97sG+AqLDNlc=
X-Google-Smtp-Source: AGHT+IGxfcc5l5KQQOWN0RevjKY3b/BSjYrwRUYSA2YjiFwjMNuumeoghswiBLAvt25WHNXlgwxVkQW8W/HLrpgsLmM=
X-Received: by 2002:a2e:a553:0:b0:372:99ba:c28e with SMTP id
 38308e7fff4ca-37797a7483bmr26383751fa.36.1760860659906; Sun, 19 Oct 2025
 00:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com> <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com> <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
 <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com> <aPRNSgunb8K9boWx@google.com>
In-Reply-To: <aPRNSgunb8K9boWx@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Sun, 19 Oct 2025 15:57:27 +0800
X-Gm-Features: AS18NWAg9-jBAfSX3OHLuzE-MfKsHu3RnTMDUGFD5GkY6E_1R4r3CDQEfYZw9GA
Message-ID: <CADHxFxQ5ph5P+ihVw2Qm-f1T-OFUQziyc8fi-k+q3-YgL-XCMw@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,
Thanks for your reply.

On Sun, Oct 19, 2025 at 10:30=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Sat, Oct 18, 2025 at 06:05:03PM +0800, hupu wrote:
> > Hi Leo, Ian, and fellow maintainers.
> >
> > On Wed, Oct 15, 2025 at 7:47=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> > >
> > > Hi Leo,
> > > Thank you for your reply.
> > >
> > > On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wro=
te:
> > > >
> > > > Have you installed the GCC cross packages ?
> > > >
> > > >  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> > > >  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarc=
h64-cross
> > > >  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-=
cross
> > > >
> > > > My understanding is arm64 cross compilation tries to find headers i=
n the
> > > > path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/De=
bian
> > > > distros).  After install GCC cross packages, the headers should app=
ear
> > > > in the folder.
> > > >
> > >
> > > I hadn=E2=80=99t installed the packages you mentioned earlier, but af=
ter
> > > running the installation commands you provided, I was indeed able to
> > > successfully build perf.
> > >
> > > In fact, I=E2=80=99m currently working on creating an SDK package, wh=
ich
> > > includes a cross-toolchain that I built myself using crosstool-NG. My
> > > initial idea was to install certain third-party libraries (such as th=
e
> > > packages you mentioned) into the cross-toolchain=E2=80=99s sysroot di=
rectory.
> > > With this approach, even when developing on different host machines,
> > > we could simply specify the header search path (pointing to the
> > > cross-toolchain=E2=80=99s sysroot directory) during compilation, and =
the build
> > > should succeed without requiring any additional package installation
> > > on the system.
> > >
> > > Based on this, I think allowing users to extend some options via
> > > EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
> > > However, this is just my personal thought and might not be entirely
> > > correct, so I=E2=80=99d like to hear your advice.
> > >
> >
> >
> > Although installing the GCC cross packages allows me to build perf
> > successfully, I still prefer to be able to pass additional Clang flags
> > via EXTRA_CLANG_FLAGS, as this approach feels more flexible to me.
> >
> > I look forward to continuing the discussion on this topic.
>
> Doesn't EXTRA_CFLAGS work for you?
>


I=E2=80=99ve tried using EXTRA_CFLAGS and confirm that it doesn=E2=80=99t w=
ork. When I
build perf with the following command, it still reports errors:
  make perf ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE
EXTRA_CFLAGS=3D"--sysroot=3D$SYSROOT"

In fact, by checking the code in tools/perf/Makefile.perf, we can see
that the EXTRA_CFLAGS variable is not passed to Clang at all:

$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinu=
x.h
$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3Dbpf \
  $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h=
 \
  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@


As shown above, EXTRA_CFLAGS only affects the GCC cross-compilation
process and has no impact on the Clang build process.
That=E2=80=99s why I proposed introducing an EXTRA_CLANG_FLAGS variable to
provide a way to control Clang=E2=80=99s compilation behavior more flexibly=
.

Thanks,
hupu
