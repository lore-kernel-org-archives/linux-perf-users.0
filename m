Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EC1B47AF;
	Thu, 20 Jun 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910784; cv=none; b=aurUpm2Tf1CxdNvnKDmOG4bHutfZXtnMraVUf+cpxoiW/obgy4+egCXFOeC6SksHzUTvmoGKXd7B4B1Xr0vNcWBqASYzQJqmaSNHqRT5MLCoi9RuwLsfl8qoyIub6JLhr83wy+8dae7fEgsuQccmO5dK8CuJf45+TOFoNBa08gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910784; c=relaxed/simple;
	bh=PtOuu6kZTUlqJSxFa4kAha8tsp0h6MEzBH1ssp/uCPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuBxpznJx45lnsdAEGo5TeXbggLGAQfJ9GgNYgFg4/kuxGabv575bkRHKaTqbM4oZVI+MBpvm+hTn11EtRwwXMuuDADNKOWws1eKWO3c80bjxoZsDq+Q3AEpExWlt/wzuj8cST/t0o6SIc8baEN0edf+Eb/n4ghd2WGBu5AC6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXdOMYcz; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXdOMYcz"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so1119670276.1;
        Thu, 20 Jun 2024 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718910782; x=1719515582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJihJ2XjNSJujbGLQU/mlrPfH9EVduDFdZBkjvA0LOQ=;
        b=ZXdOMYcz5qPjMefTgRgRom92dVvpeDSUaHn0NQKDZV5bUbytHbDsAknerTMFOgY94R
         gV+0+jhG6x+9g4QU6HgGs7zoHvNQxvZseurP/bTnKUiXEInD7KnFnQM5rsHSgvCyCn3r
         iIHo+0XWnh8ZvOdxII2wa02cHGBIm5d2zf3YPd/4MbQq9accqejfWaqyuuF6PwpcsxyM
         bHqT1m/XLQwzKsNrbXPOB8RAnrj+VOREQcTUt3VeqVuJ+k3N6KnvgSSOqXJteGcPqvR+
         aG2u6wkJWs5sI84gIarw0D2+uWWeEOBmke4WlJp+EFVmPCJXaFPFW/BdMbRMcShPat+g
         T6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718910782; x=1719515582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJihJ2XjNSJujbGLQU/mlrPfH9EVduDFdZBkjvA0LOQ=;
        b=Bat4rBMfWoHnSmiGXaEqi2b9BRaU+gh1YANfLCT/3LfUReXdwnD+uz/EU+PED/Sdt+
         Z3BD+0voZTMuFCk1IWlaOjEHJkltJ0PBTKpwJahUqFmR7oapd8QLFLwkNImfKK5DgwJr
         qpxc8O9LwpQmqB7tGJbaNOc2dQ4WuEwHY6WnD0qkvkWtMABJkR8DXPh+lProR/iBSUIj
         xNyQ8xk0RB7Xo1n/4knCPIxBuyClD8VPqpORLGNdn9h59ofWwjSXTOuRBcqmnR6tC83m
         cBb+lGsK83Lp8kkqTen+VZU/ZWh9+dR+oBtzl3njXJyRr0CCA5UX8OYtcDXWbod10CJX
         nE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkHCvfYAUUvVbfwJ9n3eJ0JeO+4wmTLrAwAMAghdONiqmOAR38WAGIRIoIpG2w9HvlH95OnqQsWyjzLlutNRzagK7dXURgRWS5Oa/1ualdQA1vOKZtAnRX5NCJTSoIyCkY4SpL37BS52p+2cVzUg==
X-Gm-Message-State: AOJu0YwF6Y40y/c/U8qRf9B841799qpn42SwfBIxtKLwO79r1DGCVp5b
	PminrNr5D9JvKPlX5isfwKWDRpOwfZH5dyzIk0gxmcaObS2pV2PMARDyIyd8uadzKUno5F2Snfa
	UnyaMKU60pM2pfVDe3/6LjitPM88CWU0YaPFdxw==
X-Google-Smtp-Source: AGHT+IG9IxxcGqXPxN0WIStMRgSoeydwG5S4iSwCWw0r3GJUCAjE98dwQra2tCzymn+Ow/PiJUsEWr6PrHrajTidu/U=
X-Received: by 2002:a5b:1ca:0:b0:dfe:3de:87a0 with SMTP id 3f1490d57ef6-e02be142101mr6000616276.24.1718910782151;
 Thu, 20 Jun 2024 12:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <ZnLjT_m90EDtRFE0@x1> <CAM9d7ci+TEXG49=-7oLfFpTakUMHikxGFc-=NhEPPG0sf-UC9g@mail.gmail.com>
 <CAH0uvoiFvHu-iKJFNHeO1TcQHLMgo60N+1zXFQx3QrLibgEU6w@mail.gmail.com>
In-Reply-To: <CAH0uvoiFvHu-iKJFNHeO1TcQHLMgo60N+1zXFQx3QrLibgEU6w@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 21 Jun 2024 03:12:54 +0800
Message-ID: <CAH0uvojwF0j4=9qP83Re3YMVg0tT3RtURRNkxnXWXqC6CKPxeA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf trace: Augment enum arguments with BTF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Now $ make NO_LIBELF=3D1 can build successfully, and if
__NR_landlock_add_rule is not defined, we'll skip the test. The fixes
that Arnaldo suggested are also included.

I added too many things, changed some behaviors, figured it's probably
easier for you to merge from my source tree.

The fixes are on the perf-tools-next branch at:
https://github.com/Sberm/linux.git

please use
```
git pull https://github.com/Sberm/linux.git perf-tools-next
```

I'm no git expert so please tell me if something is wrong.

P.S. not my proudest patch, changed too many things, might be buggy.
If there're bugs please let me know.

On Thu, Jun 20, 2024 at 2:25=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> On Thu, Jun 20, 2024 at 2:19=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Wed, Jun 19, 2024 at 9:55=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Jun 19, 2024 at 04:20:37PM +0800, Howard Chu wrote:
> > > > changes in v2:
> > > > - Move inline landlock_add_rule c code to tests/workloads
> > > > - Rename 'enum_aug_prereq' to 'check_vmlinux'
> > >
> > > Usually the versions descriptions comes at the end, after your signat=
ure
> > > line, just before the list of csets in the series.
> > >
> > > > Augment enum arguments in perf trace, including syscall arguments a=
nd
> > > > non-syscall tracepoint arguments. The augmentation is implemented u=
sing
> > > > BTF.
> > > >
> > > > This patch series also includes a bug fix by Arnaldo Carvalho de Me=
lo
> > > > <acme@redhat.com>, which makes more syscalls to be traceable by per=
f trace.
> > > >
> > > > Test is included.
> > >
> > > Thanks, the patch submission is now very good, at some point you'll b=
e
> > > able to point to a git tree from where to do a pull, then have it wit=
h a
> > > signed tag, etc, all this is not necessary at this point in our
> > > collaboration, but as you evolve as a kernel developer, it eventually
> > > will be asked from you.
> > >
> > > And it comes with a test that introduces a 'perf test -w' workload,
> > > super great!
> > >
> > > - Arnaldo
> > >
> > > > Howard Chu (5):
> > > >   perf trace: Fix iteration of syscall ids in syscalltbl->entries
> > > >   perf trace: Augment enum syscall arguments with BTF
> > > >   perf trace: Augment enum tracepoint arguments with BTF
> > > >   perf trace: Filter enum arguments with enum names
> > > >   perf trace: Add test for enum augmentation
> >
> > Please make sure that your change doesn't break the build
> > in case libbpf is not available.  For example, a build without
> > libelf seems to be broken.
> >
> >   $ make NO_LIBELF=3D1
> >
> > Thanks,
> > Namhyung
>
> Thank you, I'll fix this.
>
> Thanks,
> Howard
