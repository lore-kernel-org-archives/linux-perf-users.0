Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF9311C1B
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304089; cv=pass; b=pZpJd78REIFTyUzs5/x1LhPX2e6M8RYZTKMxAVJNCFtKlP4CGIJFyFsSInvgGgwnCF6zGP5Isxkb/TiGqx+x2FzYbt1ocGBiSFJIclhw3aeJs5AQxyxFlvnQKKT7INUQPtxvyH2BXTci5L7Hhk/EV5zFncSMVkxNM31fwLhKmLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304089; c=relaxed/simple;
	bh=4j+rengIgiQQBetoYtXz+Zq78fQ2TnWaolneFL1LRvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2bWWHB96icC/rixIPY+q66Iky0t/l+cwOoeX9+C7epl96fNisjWwvhsgifVgFkhQcdbMteP6E5GNV1UXLdeowVD0/AyysfNMjpd9RZtV9n4Vt9LUR0cjuhf3sDBkRlJbc7geiB+czM0G0KkBOnm9ujFeN9LUCKaU3sBy+j+pxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0NkgBce; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0NkgBce"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso935ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779304088; cv=none;
        d=google.com; s=arc-20240605;
        b=HBnwOZAx3vSDf+CHms5EIaMC26W/DOw6khBLPI13/eCJ9QsAZBHAAOio6hju0ZPfeY
         igiBhEo/CwO5Neg1/7T6EgzT6201g2h277cLz/O33EaaB03jxWlP/GdrbU3FbO5OMX7r
         MnqQhwUPUp3FLtVRHJ2GS+38gat0mGqn0sMMi72JAgR83n5u/u4hiyf98xEcb3Z4ki8r
         XFsqn2fpvpmkEK0VMRMmn8iJPQz2xztHYN5LXcrt49UpRRhJ5Voi1+BFqHwB/MGXZeix
         1BhDfr9v+oNxTE65KFpD739OFCq6wAu2lab5mloHk0f52xHX2QwwbQaE9/Dc6MXerE3d
         MkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C8nVw8Ed+p0ldNwV+yAauRWAjAdTvxcQRzlTi/vKR3A=;
        fh=XhaAOgVeG97L/DwDHoEwV0NWeDfQSwhjdfNdW3jZ1AA=;
        b=bl7jtIsa0saYDN5hDrfstm163g6E2o4xeCe4OXtITHK9fDdVXu/um22B7f4oF175C+
         y2lYwcZgFtasOBUrl0H69HaycrHoo2sOUlTKd9a0qjIwhCjPzqxR8TmEn1QzxPAcG9qQ
         L1QvGNh0kBguKZK3J48HLl1aiXSlY12Au54o7THFLTIokHKhANPI9dKUWvKd2GN9cFbA
         GbHJD5Ih1rF6fv0rrTiQXT/U55ZJ7gGF82wBE5tQmLIAjwWr68PW2W63xd03GmGvklWi
         taUvHPef6YiJUu6DxXKhKEeDyFRvw31XysXJgpgmyWdPtC3aB6AMA783Q6UksXxQ4JNf
         WnlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779304088; x=1779908888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8nVw8Ed+p0ldNwV+yAauRWAjAdTvxcQRzlTi/vKR3A=;
        b=h0NkgBcezu7i5aD9+xDpCQ9MhObujXKhJNKew0NJ7AjxKnvvInC9dy7RRlMHtZXFoL
         TIsGOuXkpxatwrORd5zDFZIrfmMG1/8hNWDmK2DOKM1Kpsq7eGFOQNwRx3aBG/DEx1uX
         ECafzkzY8ZMvoF615SjPJKk/ZxRn3mY4nSE5v5g/N6s07EMHLhRGKkdjUlI5SVN5tYYW
         BvYnjzW11zFAUhEaqlPYOx/+ZL/JDoi0HVlTyGyUbzEbmmwj4o+98xxocK8jNEo75UPH
         Zhg57G8N6Dw+3wKAdnnFbdTLQSbFqPjUmENvncAzfXyQPwlatMgATnr82hbixhDSzzfd
         krzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304088; x=1779908888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8nVw8Ed+p0ldNwV+yAauRWAjAdTvxcQRzlTi/vKR3A=;
        b=Wv2sBwfADMG/1vjCRgDN/FUvr7TPL4MwbM9cia+7+mqJr6IWUB/iWAVY1btClZz7jV
         pJwvw46vO+KO8JGrTTXAOomfAilQOI6v/rDpxgc8cicexCYdJesSiHvrebRPbfRDpL0z
         s9oH5FQrjH0K202mn1j5ya9hc1oi3tFjEHO/zwpAJ0TfxJJfy1gtSVV+6F2AKhJZdS0M
         x5hQtvGVMdauRWtWdZFVrbS0PuiUualFOmEnUDsKetttroMg3D+cWH1H7Isel1JqTECY
         sYZYBKebYulqlbsoIVm+BtZAijSFPJxlgMR7rlopqPNE+lfJlLBce7G8ZiHhEjniGBdL
         t4bw==
X-Gm-Message-State: AOJu0YzANopA75BJeQ/fi5CF4CdmzNpWU/wGMRCirOrrH+TZbb70G4JK
	P3Cp7hf2W5bFyl2lf3CJ7Wcmg41itr0/1KNBdy7T4c13VHKYoVbH86VlwYjeRvzQpw5DvhjBJdw
	E9udZ2jCbjd73rtARXIX69FN7n5cfd/wASYcFK3KXPTNnrYwxitWP3TRzfeA=
X-Gm-Gg: Acq92OGepaX0oe9G4r/l2vEukL4AiP/Xl9qtNIIfGe5fQUNbx/kAhh2UXiYvZYERL8u
	zb3BhpPUUnhc9zFIyjkEg7vZPj6GVOudJUIIxGLhBhitAPQptqHuPm9cqxrjm42olPzlDIK7ylt
	uZDURKtDSUuuhYwtnn0zoG672lmCWGpBXCG953D7EleJpuWM2NJ4ZU1HTXTDR3ZqOAVj8mD7g/d
	+V8CG0mpntKZfa4GQ0vFylbhrZY6/I4/DWzYDIx8l5DTih55eCpqcmeIp8U25pWZiSuW1lVkpjk
	HZnJ/WGO5IjPhJtlMkLfeGfmN4eN+ZL2cnMDFRSefix1Ryx3
X-Received: by 2002:a17:902:fc44:b0:2bd:bbe:e3a3 with SMTP id
 d9443c01a7336-2be9f0f085bmr626775ad.10.1779304087142; Wed, 20 May 2026
 12:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <314df838-4c38-4f03-9515-ae1dabd09a54@linux.ibm.com> <CAP-5=fUDqHGeM36TrfLxOgC8_ohp8fshtpRJMf7-utkSn3drmQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUDqHGeM36TrfLxOgC8_ohp8fshtpRJMf7-utkSn3drmQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 12:07:54 -0700
X-Gm-Features: AVHnY4JP_utFY20MB0xl5zCqNBGLzoW1WUjMgq8NYXGQ3-wx4npRMfVGNWi1iqQ
Message-ID: <CAP-5=fXFExWc3sHiZny5ayshPP4dWHFwDjkFeCnhb9QR4e5w4A@mail.gmail.com>
Subject: Re: perf test case 'perf kwork record' fails due to abortion
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:46=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, May 20, 2026 at 5:53=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > The test case
> > # perf kwork record -- sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.280 MB perf.data (568 samples) ]
> > double free or corruption (!prev)
> > Aborted                    perf kwork record -- sleep 1
> > # echo $?
> > 134
> > #
> >
> > The perf kwork record is kill with signal 6 (SIGABRT) and the test fail=
s
> > on x86_64 and s390, probably on other platforms as well.
> >
> > Is this a known issue?
>
> I can reproduce this with an asan run:
> ```
> --- start ---
> test child forked, pid 4058074
> Kwork record
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 4.949 MB
> /tmp/__perf_test_kwork.perf.data.fyllr (17753 samples) ]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D4058078=3D=3DERROR: AddressSanitizer: attempting double-free on
> 0x7b2caa3e6a10 in thread T0:
>    #0 0x7f0cb8318d6b in free
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
>    #1 0x563b32733077 in perf_kwork__record
> /usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwo
> rk.c:2335
>    #2 0x563b327363ad in cmd_kwork
> /usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwork.c:24=
94
>    #3 0x563b327dfffa in run_builtin
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:348
>    #4 0x563b327e0498 in handle_internal_command
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c
> :398
>    #5 0x563b327e0866 in run_argv
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:442
>    #6 0x563b327e0dbd in main
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:549
>    #7 0x7f0cae029f76 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>    #8 0x7f0cae02a026 in __libc_start_main_impl ../csu/libc-start.c:360
>    #9 0x563b3261a3b0 in _start (/tmp/perf4/perf+0x2243b0) (BuildId:
> c542d90b5244b118cf9b3a20501260c659421a94)
>
> 0x7b2caa3e6a10 is located 0 bytes inside of 6-byte region
> [0x7b2caa3e6a10,0x7b2caa3e6a16)
> freed by thread T0 here:
>    #0 0x7f0cb8318d6b in free
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
>    #1 0x563b32733077 in perf_kwork__record
> /usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwo
> rk.c:2335
>    #2 0x563b327363ad in cmd_kwork
> /usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwork.c:24=
94
>    #3 0x563b327dfffa in run_builtin
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:348
>    #4 0x563b327e0498 in handle_internal_command
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c
> :398
>    #5 0x563b327e0866 in run_argv
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:442
>    #6 0x563b327e0dbd in main
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:549
>    #7 0x7f0cae029f76 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>    #8 0x7ffda79dc4ee  ([stack]+0x204ee)
>
> previously allocated by thread T0 here:
>    #0 0x7f0cb8313e20 in strdup
> ../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
>    #1 0x563b32732ddb in perf_kwork__record
> /usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwo
> rk.c:2322
>    #2 0x563b327363ad in cmd_kwork
> /usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwork.c:24=
94
>    #3 0x563b327dfffa in run_builtin
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:348
>    #4 0x563b327e0498 in handle_internal_command
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c
> :398
>    #5 0x563b327e0866 in run_argv
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:442
>    #6 0x563b327e0dbd in main
> /usr/local/google/home/irogers/repos/linux4/tools/perf/perf.c:549
>    #7 0x7f0cae029f76 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>    #8 0x7ffda79dc4ee  ([stack]+0x204ee)
>
> SUMMARY: AddressSanitizer: double-free
> /usr/local/google/home/irogers/repos/linux4/tools/perf/builtin-kwork.c:
> 2335 in perf_kwork__record
> =3D=3D4058078=3D=3DABORTING
> Unexpected signal in test_kwork_record
> ---- end(-1) ----
> 93: perf kwork tests                                                : FAI=
LED!
> ```
> And it looks like I sent the fix a while ago:
> https://lore.kernel.org/linux-perf-users/20260512223001.2952848-32-iroger=
s@google.com/
> I plan to rebase and resend that series today.

I just resent the series and confirmed it fixes the issue for me:
https://lore.kernel.org/linux-perf-users/20260520190538.142018-1-irogers@go=
ogle.com/

Thanks,
Ian

> Thanks,
> Ian
>
>
> > Thanks
> > --
> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germ=
any
> > --
> > IBM Deutschland Research & Development GmbH
> >
> > Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> >
> > Gesch=C3=A4ftsf=C3=BChrung: David Faller
> >
> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht St=
uttgart, HRB 243294
> >
> >
