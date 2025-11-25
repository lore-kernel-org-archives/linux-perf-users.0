Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE82DEA67
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075155; cv=none; b=HiYjwT3N1so1BWyHdpu5dhZB6nQ7nM/WJ0DJKz7dBjvsiDXFtwStQKKYIS8JlNTZjX9uYu+4eOjWd6XiVZY55pQhi3orBosbKTgCM40tPqvobQHIcQ1G89yF9w2yDyVXIolKm9+g4yaXL5qxSamSPuRBwkjGZtipdUMQpAqzNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075155; c=relaxed/simple;
	bh=h89X8hoQsnUNXRrFA9WTK0IloltLc43BlD6vdW+VttQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYhxhpc+gSGJrNjtRtV5Jf3NqtjL8CTmzp4TPQUl4khCT1CxvTiIC5nAQZAJSnnfhz3iwIH5YfZhQy3ftWZgWqoNFn/3CFICX2tWpXBtmoOBpNtWDv4kgm0OnTjzjC7DrOgrH+JUpMycILDHr5JOMUTOC1+1CrpLM292jj5Y0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QADwU+yF; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QADwU+yF"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-595819064cdso7650910e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 04:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764075152; x=1764679952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JqXhjWZpLKi5nhr+dAB/mps07ErXFu1ilXKvYiesmY=;
        b=QADwU+yFtov+uB7e6qa+RzO57TjaXokCM4rLZizWIzWpipM4/6Fo9KaVVX5gOcGujf
         jwSyOZU3EUDcFiTuq+w6XAaRLpq4/w5BQSsfzYUj2CGit0D82VOKUFb7GvmU6YA/MzMF
         5QL8J87/8eOoPgMKTu1Zo5zylj4IVEGIfeu8gz0RvwvimMPxa/QMbIR4Nbl97uL8DEkT
         kd/7YNwOZ9Sud8eEp8L3vnynR/+5CyZKyNgipauLLEU7oTCKkgxGRsBgSpnuRXFEgl84
         B9wvkO58W9AmFqJGqlotj8WJOjX0l2rtBJIaWHYaCR4WRvkDKb8OeN2ncfdPEX/cc1h0
         V18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075152; x=1764679952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JqXhjWZpLKi5nhr+dAB/mps07ErXFu1ilXKvYiesmY=;
        b=BTnB2BGjMplFTEL+fIgegEiNsICFJ1/qgXLtuVgLXNjSwo1NwqM2fqop0hWQFEm8Xp
         olBHrpS8uuPxTTBLal64gI6wTF90h/YBpMPsBQZcEUVs4uXZeL8j2N4P7iF1zUIgROCi
         q38heUliUGdQMF3bURLzjUV4tlTkuB3+YWnNP+yzIusoUkszsC85AK4WQtJw5EkRQOZD
         XwHgjkU5maFrUl4I/Zsr+EJIlKyJZga2S17kOKborU1tWTHPO+E6WFb3xvRJ+W0SdlRn
         nNQtU2QqILLnT8E/oXUF2fhLVD+iiy0JvIXxSr+Lli10XK0UVzZqRGiqj5c8FtXxQPdX
         2ZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtbItPByIo+6OtanyMfUKecnzgvBKoAsmHt2+mnl5MgZSMIGWexMa9PmkwUHqdCnTGJtUuCXnRtPdxW+LH4fD9@vger.kernel.org
X-Gm-Message-State: AOJu0YztQB0QWaBp/HszLHYtPnmPh4/Z7n3vYlooCBkAilwfQSacEwbk
	mOMsdhNo/zVptA/vGoq0GmiHTVoq2OIaYb5GOdwrqDsZ6hz6Mr3rJJVvryTCOntN83ZiKO8AmIo
	XvhnQft415abnWk0Kaeai10a8MxHPFAw=
X-Gm-Gg: ASbGncsDLRqCVWz7uY5o10KMS24vXGKi8+4v9H9d9pYV1fNSC8ZI0XC/t20mSWyjQsM
	lVkCTGirFz4Oub4Bv0O4o0IbSF06rMLTtrSDjUMkNvbLhW7IWjzq23oo10ZW7p11jOuJPJ65bh+
	6QhA0RxWPlT37hRbY5SsqDCy2pZkyF/hnoISHNCXnLtIzxBW5Fi8XKbTZ+ub7OfOD/PAziRHk9Q
	LSPiiR9TLofVfYTFhhP0zsfKYYkCT/L+3x6YUGCxloLhcD2n610y23HaIq2sGuybdVMxiUF12wc
	3M5cwQ==
X-Google-Smtp-Source: AGHT+IGRSwAdZSmKmUS/oJCjg/mDAvmVX2NxoH/aaca2O/xBg+tb9isPElTkgzPoyZc0O0JnfyLWFYwBT9PbjZtt48Y=
X-Received: by 2002:a05:6512:3e1a:b0:592:f2ba:b6a with SMTP id
 2adb3069b0e04-596a377e677mr4849990e87.13.1764075151853; Tue, 25 Nov 2025
 04:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com> <aSVlQHJ9xcGcZULp@google.com>
In-Reply-To: <aSVlQHJ9xcGcZULp@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 25 Nov 2025 20:52:19 +0800
X-Gm-Features: AWmQ_bm3EvaNMABXlMLoZPQ7Dfpfr1bLYOm7peTyHfXC1QSNoNB4Ezpjncbm8uE
Message-ID: <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: leo.yan@arm.com, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,
Thank you very much for your valuable suggestion.

On Tue, Nov 25, 2025 at 4:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> >
> > +CLANG_OPTIONS +=3D $(EXTRA_BPF_FLAGS)
>
> While it seems CLANG_OPTIONS is used only for BPF skeletons, I think
> it's better to add it directly to the below lines instead of adding it
> to CLANG_OPTIONS like following.
>
> > +
> >  $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf=
_version.h | $(SKEL_TMP_OUT)
> >  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/v=
mlinux.h
> >       $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3Dbpf=
 \
>
>           $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI=
_INCLUDE) \
>

I agree that this approach makes the logic clearer, and I will update
the v4 patch to follow your recommendation.

Thanks again for your review and guidance.

Thanks=EF=BC=8C
hupu
