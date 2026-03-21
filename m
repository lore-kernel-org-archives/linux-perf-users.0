Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44C2D23A4
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122596; cv=pass; b=RIRoXKWop//kIFXAmGsLU99BcqosLsQTe1u5jajGpmRhii/r0MofM+DuVRM+eKiPOaJDm5TSzcViPt4g3rmOfRiVDPqmau51evW572v//447kf7LaF4vy5m5oc9psgT+Sa9EDKS6kGaE7WrXOG8j6DWMP9av5AIv6ysZBCq71wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122596; c=relaxed/simple;
	bh=uMl+exZ3dp/41SG+vPFN+zEUkSBKBxqDQ5zP3dLg82w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc6n4g3ZDnG+6j9sMcio8/5AorIvgiYKa/CDD0rvMIY2pafLg9/2Gatd489MJYRLoyj3i73PBnUh1n1c4AN68AKQ1Zyainlec5e5tWgRk3tJ7pB/UrwAn6lakE+FK4Eu9OSMBZUCnwRjD6IZvUIzzmfixlUj/iaLTTdN9J5kNyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRN9RjQe; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRN9RjQe"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b7481f9d3so17430f8f.3
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 12:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774122593; cv=none;
        d=google.com; s=arc-20240605;
        b=dwcRxX/KoqJerGR00sbrbU8F1QXwqhcuRvZpvbGR8z135BGx9Xz+FRfOFLyCvweJkR
         fwM/Eg03b+qRv4KFalfBiLrEXtWfRMjJ4Fg0Sv3dyznVlGDNs5p2JbyMyhYPvdo7CU92
         0l5LQLgUNp3/kpvdW9urrk5+sPjojGJ+nb/8+VPcs0rU7Dj9zqVMUFblSIBzgg900S30
         3+yRoGOtKubx0nlwcj8w+j9IvIhUZ0NnayFbrGRAmkcfPb641PtXFGuA3IFhxR4CmSsT
         txab3wP6BT0WzAOa+Ervd5vlPr5qTKZk8X0/gh24+9DVOl22IHSnNsTKNBD7dJrNhp4d
         sBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DgQxcMvImid4gbeybu26AJE3Y3wBjv+/iITImgADi10=;
        fh=6+kAYdzM2C66JlwfdOxirvBYbfVHmTJY8+Lgk5GA2Tc=;
        b=G9pQ9zGekH4PA59U1UeZzz0af3Zl/oqp+cGTwMP4iAQrFY+xBHa5J4j0lkyv+K6PuR
         iJtL5is6uqWJq7QepvWD9V/SQkwkykcDM1Fo14JjMuahXMINs1jCWIRDgpWevcVBcOor
         aSi6Zj4KFcfiEhlY6yhTmImalXbN0HBxBhswIybbcFMzU2Trh/CO9paUQDJQRyvq8tgB
         7+FtENokfheG6BnkWgD9aYQjZy0AyMtcVhn9a7BMUFpdAjIdD2sAt1umbG807vIRP2BZ
         /dp2x52s6KIFM3gXDQaqSGtvZSypOrjIVja5N9+nIkH2/cPaQ+kVTkjljDsI1zt2jm+1
         9+BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774122593; x=1774727393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgQxcMvImid4gbeybu26AJE3Y3wBjv+/iITImgADi10=;
        b=QRN9RjQeQo308gn/OdZJyYZwjgSjvmjGlQmTEdz5l6ht6GOFYr15WoedaKmr8TVQY9
         WryYIzUwZeMrA2doSKvrGvMI0MMi2/jWAsUTwAHHQ4mVVpkjrHtADlNluCSy5MVEIh1N
         Sn6lKOurLkFfV/L5e/Q0aVzpmEnTF/rdSNvrSRfE+bEHjgHEmHFqi6sDfAhkUwAt24By
         9e6YB3dme4mRWxNUB3YO8VHenEG43wsc8RlwhzpHDjUxQtq0359+PlUlzwSbZv4eLceu
         NZHElS0VIqj1yvBQhVTeiSHgoY9RfnmozTpA5/8qQWSCvIfIbOiGxAb/yNIOxdxvNs7V
         aWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774122593; x=1774727393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DgQxcMvImid4gbeybu26AJE3Y3wBjv+/iITImgADi10=;
        b=o7BbHN7HUNdvHlo6WbnBgolXavsLKjIMJAsv36k0qIj5STmz0He1qc4geUC7fEN/vI
         GvEMEI1Ie7HK+x15Mk+2eVXHKlc++51Dd5eDfsqOBgsM+tq4m17pjacplMCP9ps3FDyR
         d9ezst81yLwtonMEN44IQ4QmpU2DPBrciXiE6jYLoqRjD/PiKqL7MbOr+ajbr1yMlPHR
         kEab8jc7pCkNXlifgUKBJ5jLMS1yCULVwB0MXlqBg8uoIWURtvDBY4TkzbVpEfB8EDoP
         Jwz//hwZKQOSgIGPdwI/aN5tMuOKn90gAONazkyiiQjKjISHYLfzhGPJEvrIF53f6fRB
         jJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmG0f651iX3axm2HJ9E5GUxYZAZewJgXrhWPICTI1BT2PnuMf17XgJsI2677L+7Wy+11sGJWhjtmbSBV2WT09b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5V0gJi3OVhHChItjq0GUx1QhP3yz1MlnLhjDGmxWrk2Kf8tD
	5vCRb//xaNeUnUG8Qun2d0Alryryczp29Ee8J6rnsBo9sNDKvmPw1wna1huuxPN5HffP/16Ymrm
	VP5UMpqbi3eWGiLF/NN3TMGamebAnJ0s=
X-Gm-Gg: ATEYQzw42IQgGrJlON+mPDF8o+y3JLfnwtn93XehqSapgTnJPqpjYdT8H60ups9eyOy
	verVFLMSnA2bTK4gU9t/MKu2wUNoB5RMZQXhFfB6DhIfB9+oKPDhlpS6yBuctgUpMET+/qAFVlH
	f0Cdl4WLHFSSJ15QtZFR2AABIebU+jr246IEKsE+IkHj/5KupQ9tMgW8rosay4Wqo1WHeZaR5dH
	3ylwaI26XViHESj7KeW20EJdh107mW47/kyf5BboAOh+nAD4zCsJ8j6f928fuNJa2dQQ8SNpg7F
	OO8iDuP+iHl8mBm0lPmNo7Dw8orgORYBLrAGX9INc6sEbhacqOTKbePDr2MG7C0Zb6btsvd0wvi
	mji0g8CgRBmOh2IslpMS4Wsclww==
X-Received: by 2002:a5d:5f55:0:b0:43b:45f5:eec with SMTP id
 ffacd0b85a97d-43b6423fc34mr11863264f8f.4.1774122593057; Sat, 21 Mar 2026
 12:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
 <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
In-Reply-To: <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 21 Mar 2026 12:49:42 -0700
X-Gm-Features: AaiRm527zj-86HKDU9TQg7EH9Yp0FEKxz_hD38hZCMjiPqjfidjcm-ljYcza0LM
Message-ID: <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ian Rogers <irogers@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:37=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.dev> wro=
te:
> >
> >
> >
> > On 3/20/26 7:44 PM, Ian Rogers wrote:
> > > The hashmap implementation contained strict aliasing violations.
> > > Specifically, the hashmap_cast_ptr(p) macro was casting pointers (suc=
h
> > > as void **) to long *, and these were subsequently dereferenced in
> > > functions like hashmap_insert(), hashmap_find(), and hashmap_delete()=
.
> > >
> > > C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> > > through an lvalue of an incompatible type. Dereferencing a long * to
> > > write to a void * object is a violation, even if they share the same
> > > size, as they are not compatible types. This can lead to undefined
> > > behavior, especially with aggressive compiler optimizations.
> >
> > Potentially this could be a concern. Did you actually find an issue
> > with it?
> >
> > The linux kernel build has
> >     KBUILD_CFLAGS +=3D -fno-strict-aliasing
> >
> > The libbpf does not have this flag. Maybe we should add '-fno-strict-al=
iasing'
> > for libbpf as well? This way, we can avoid any future potential
> > 'strict aliasing' issues.
> >
> > Note that bpf program (tools/testing/selftests/bpf/Makefile)
> > also has '-fno-strict-alaising' flag.
> >
>
> The change itself looks correct to me, fwiw, but as Yonghong said, we
> can add -fno-strict-aliasing to CFLAGS and move on. I also doubt the
> compiler can cause issues here, since the usage happens in hashmap.c
> which wouldn't be visible in other CUs where the call is made and
> pointers are passed in (unless compilers also do aliasing-based opts
> during LTO). I guess libbpf maintainers can decide what they prefer.

Agree. I don't think compilers can misoptimize things here.
It's safe to ignore this.

pw-bot: cr
