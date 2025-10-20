Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AF29ACC3
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927912; cv=none; b=JknthEStdCvSTlOJs/pLkm4gSuA8bo3ZRnYRzCR+wS/+iyrbONadcwyZleJPICv37KCiruc2+X/W9/K/4dl2NFB4Z0cFSQPhdgZukDbsfa8YWvYbzbKwTJ4pNJktF9d3osMbw1w5f938ZGaxyW7Wb18qGq4bMUyLuu3GRZauc2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927912; c=relaxed/simple;
	bh=y0K7k6I+BV6ZAk6JhUxr7YToM6mEtXYVHMVmZVG/J34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uux+mISlDuFlRoI8vN5d1guqIXjSX3Ueo5EkvKFaExgUqCaPIlQz51czfkOo8sJFdC+8c2GQxrok/Tz+sox2sNlFuU/dmKAf6vEf4NpWRn/G2k1ljIEiTz07jMq4+fnAjCLmn7xBY7DvVQV2IoDxZ5W0LPeCUU/Rse6cQTK0YfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrvGGasA; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrvGGasA"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so47492911fa.2
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760927909; x=1761532709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOhVPJvkzoAq6MTL1X4HF7I90hEeoZHpROyKquD6p5Q=;
        b=hrvGGasADJrlp4+YGHKspiFdqyAzD7Do4fV758a5XIGMWrIj3cccpvWfiGstoUkyRN
         QqWZaz0aHPthHpr2EdtuCRGe4xW24hXCoh/vUdfGv1fsVsIDg4r5OnVLmDyOukMe+vKX
         bLSow+hrdG830ky5QCSceDBc/rrGvAV1auh0UVn4bx41HmT2lrOO6dRlGsD6LjlC0Fk8
         blezrBcpO32Ivf2BjGjVMbEFgrcB2WTWIUEy1Hy7xLqOoU8dkJ85LEsIjv+kiK1ViOpL
         PShRa24cWoEK6tM3TBKPQtOFUV0DUlIXRKd/157vMA+RV8NVyEJwWpevrRtyRcIswBvA
         t14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760927909; x=1761532709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOhVPJvkzoAq6MTL1X4HF7I90hEeoZHpROyKquD6p5Q=;
        b=V37cBxFymTZr3bIKQBJH82sx61vVsXIRMBQdUzknlAK26WnDPhj8PjrZ7og1Vyp1Kf
         xi7vP90sIGsjB8lkkduT5UDsYNMVmdWxNTIMwGegktM9Vy/AcImi3VSnBaNv/2kQFKsy
         EiWmSPReKRZen2PAxQOyjpeD2MW3ERRpZHCyBsKEFgxkhoyRjLDhYqkDNrS8PXrBCXD4
         yB2+ZO3Up9wFhMDRQHsgoJ8ORC0/qo9fFoh7ryUE7CQ5QUydihnTtVon2jSTWQbi+v5p
         ugTEPUJdGhAEjuRsPhYzSn/N7Hel80Zreb1nlPi9upqK5x+ZWJb+JLoKYG4UluZGp667
         24UA==
X-Forwarded-Encrypted: i=1; AJvYcCVR54DRw4v8EBMCGNnRcWxYQAK3HMOaBYbSOWENaml4AqdJhyKvDdEjoGAyKoXKmT1qEeZXr5qSOIRTv1s0YzJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YxYuH3GGU83Q4fOcfqlDgZyfZO8SludA8gyZJ/FtYvU7uTVcljw
	+JzmPf1eJktjmWDULJJPS1HxSHffd81kkTUugI3ptyUJzyMLP5skxuG7SC+CmLYUcDObizvccTf
	XsankO5la3cOu3RoAv0vIGw8Q/8BBU7Q=
X-Gm-Gg: ASbGncubXm8aqM5mRI0B3/5DDFHcfLKH6rgBuSzWgOcq4KME8t7jK69duZuBFNlsCQI
	odLgZIXJSaafYPu7BxkhKqQ/syV9cYgidD8ETe3RJDdt0d/uis3SxpB9h3Z5G3G7qVL0do1HTAr
	xs6yhj5XsCvJ7R6Ik0L/YqZl/h959wu86eg4omSP0HiDo+k2KyOA7cPTUvz4rt61ybYNt5n4LGW
	tHDvhyTZrWMFepuggA1yEqdv1veDHNOf+w7OOMKWyJYA6RA3ehBUsDIuntiymY0mW6FwFE=
X-Google-Smtp-Source: AGHT+IGNI2EEgtUcROBhmN6VjA+9ofmSu2epcoOxwdcOXI9gMiMvjfzwo0uOJIuo0RZFKxApFhagZo234h2spz5MADc=
X-Received: by 2002:a2e:9a14:0:b0:372:8d1d:6952 with SMTP id
 38308e7fff4ca-37797986b26mr40588931fa.41.1760927908956; Sun, 19 Oct 2025
 19:38:28 -0700 (PDT)
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
 <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com>
 <aPRNSgunb8K9boWx@google.com> <CADHxFxQ5ph5P+ihVw2Qm-f1T-OFUQziyc8fi-k+q3-YgL-XCMw@mail.gmail.com>
 <aPWNaOqocEPgAJcq@google.com>
In-Reply-To: <aPWNaOqocEPgAJcq@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 20 Oct 2025 10:38:17 +0800
X-Gm-Features: AS18NWDRgumED3s7YkkRYw0nhMLNa1cnrut_hBejIDtsUIB12B6K-JM7JMhZH8I
Message-ID: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,
Thanks for your valuable feedback.

On Mon, Oct 20, 2025 at 9:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
> >
> > I=E2=80=99ve tried using EXTRA_CFLAGS and confirm that it doesn=E2=80=
=99t work. When I
> > build perf with the following command, it still reports errors:
> >   make perf ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE
> > EXTRA_CFLAGS=3D"--sysroot=3D$SYSROOT"
>
> Thanks for checking this.
>
> >
> > In fact, by checking the code in tools/perf/Makefile.perf, we can see
> > that the EXTRA_CFLAGS variable is not passed to Clang at all:
> >
> > $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vm=
linux.h
> > $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3Dbpf \
> >   $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> >   -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_versi=
on.h \
> >   -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> >
> >
> > As shown above, EXTRA_CFLAGS only affects the GCC cross-compilation
> > process and has no impact on the Clang build process.
> > That=E2=80=99s why I proposed introducing an EXTRA_CLANG_FLAGS variable=
 to
> > provide a way to control Clang=E2=80=99s compilation behavior more flex=
ibly.
>
> One thing I care is that we can set clang as a default compiler using CC
> variable then meaning of EXTRA_CFLAGS and EXTRA_CLANG_FLAGS may be
> confusing.  I guess EXTRA_BPF_FLAGS is clearer that we want to pass
> something when it builds BPF programs.
>

Indeed, I agree with your suggestion to rename the macro from
EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS, as it better reflects that the
options are only intended for building BPF programs.

I will soon send the updated v2 patch with this change.

Thanks,
hupu
