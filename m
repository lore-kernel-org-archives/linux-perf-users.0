Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2341E3775
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016188; cv=none; b=aDb9eHbQNwzk6beHOLwVuYOzCwElSzhYU9NT0+7mZcgEOTsZPhP8SeFY26DfnOofq4cqcr1pAS/62kN4Y0ZSz3tA+ew2G3JllNyoLygwe1mxf7NATT/5sG05Zo9Hum97SOjKsqd9vI7C6aE43ovRqxcUe3gz2mSkd/g0Sx0n+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016188; c=relaxed/simple;
	bh=iUsN6+xOKFFmhbmQ9CG96hFFXoboyzRrO/ukkjIyYHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLVvypCCmc5zPE1lWahW0AZMni38JAO/gIHpFlB+gwztrfr7eAnMhjaYQB9zYLJr+pKqZK3z1muvc4VKKgnp4fZYkt6ld2QHvnSJqXpy8MyMQ9gdaOKMRHcXav2VHNIvsPsVCXPZRU+t8IffcUNGo21IlwRntReG0o0zTmvbAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcE6OzCe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcE6OzCe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27d67abd215so250805ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760016186; x=1760620986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MmBd+7zzowhrSWoBWSLCsui3fgz/9aHsIIOvCWsuYU=;
        b=QcE6OzCe4FrsAGoYCDlZ2DjYXhN9L0NfGDNWvsNVa9lZbAEzeyDJcH3oavLzpCrbyS
         VB97Z/jbfPTUgt9yFv6fXPCYlENIptyKf+oPKhfitTLyNta3+/lnvI9Ap9RgMzy8SDYI
         PU0Vsg1Hd+ylFNoTH32X6/Y64+yp7zQC4gm1n3M+ysbYlZXATh9g8+iTtwaRs1NbCyCb
         7m30nR1JCuu0XGbqBTZbzhvfAnEbz7GQsfU4Fd+gaEN7LF8RTH6/aeKhmc7UPqwQG13e
         Kvzqnk5tmYuFRY/HC4uhPO+XU4m5fk4vq4eVdfacMuWPrXjPBdfREadLhM6T5VTW3Cpl
         EAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016186; x=1760620986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MmBd+7zzowhrSWoBWSLCsui3fgz/9aHsIIOvCWsuYU=;
        b=lKTvY/Gvnfe9Aks3cONGdrgrsUoBdl8QdOE+U50tFvOGgIvUcLPXE8f5nyBApZOC5c
         OK+BDBNP9Pw5tbcMoGt0J/grhJaS45mGD2oMheg/rfTZygq9BW7+p2DhCKUH8RIV/mNQ
         5oUDDx57tWN+Q3wxRyNqiS4l2j+MCN1decHkbQ/CN7BSM0gNRxvghGEHvqSeSc5h/VcK
         3j7g36Un/3kKHDFKdFc0HRPjBDhdC8AyEw/vL3rS0+GX5BkVuzYuczU7Juaxg/ABIjrq
         OODIJjctuvAmb3WZYFbPTykkwJ9kyFKV+06X/zuGRJPV284Y4GiyZqvAiL9rbcCO2Idu
         Kudg==
X-Forwarded-Encrypted: i=1; AJvYcCUnh+2qJT2yUBgi/5SPs3EghrUkkxjqwBPVCHa3sU4VH9etAYeJ96XB3gj6lGTNA7ekexFxHNY5zLjMT/oRu1VS@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuovYkPxYRBw7e65mQslpYCeIv+WDDvjW4icEyrPzX4z+e4En
	3MDaqrko4MfAdxuWbT2+QzN3znrHnxngzY3Xq5JMhlpaRjG3ascAULroOrqPJOXL8mJTVftzocg
	6g8QCN3GLfddXCzs9T31IPhRAvvRkl/1S63k+Ywfi
X-Gm-Gg: ASbGnctpAnJeXnPhP3lrb9U6vJ3Rndyypw1DsmfYluvY8VNXJ1MYjPJrIXOGNGr43+F
	7Aa8KPNZ5EU8tDaAJYTJw/E5f1i7XOg3XPvH3ulQR7x063Nc3gx1iVZRc5T19Rrag8CtNNPrqVd
	MVYB6rZko/5O5vBqJ893uOrYxFTKaQiUM1ypAC+ohrgvCBSOQqekoSJvVomDe9bLz1WujP418D5
	hvhPI1d4Mzz8LUTWvCBFLvf0cVYZGEB7PYX6MZB0UHUzaVRrg==
X-Google-Smtp-Source: AGHT+IEdrbQJWbBux9pavyDpSQy9ZinCAuiOJMYN+NXoFglR2vnRt6D5+OiKnG1DQ8GqgnIDFnpngIY4dqYtYVE57TE=
X-Received: by 2002:a17:902:f605:b0:25b:fba3:afb5 with SMTP id
 d9443c01a7336-2902768ec14mr10451505ad.11.1760016185180; Thu, 09 Oct 2025
 06:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMpRqlDXXOR5qYFd@mdev> <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
 <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
 <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
 <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
 <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
 <CAP-5=fX4=fV70N3GCdXgV6o-YoJynnSppxJp0MwdRrtsyDrs0w@mail.gmail.com> <aOdbRI3BaMCbyvtv@mdev>
In-Reply-To: <aOdbRI3BaMCbyvtv@mdev>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Oct 2025 06:22:53 -0700
X-Gm-Features: AS18NWASwkyvua1-o-5GApfZryqQldGLDGiPEERJurLRPNNxfov3J3ycLz5Cqx0
Message-ID: <CAP-5=fUAato=+jyNNESCX3SjWMEEJQ697VvWiBFCi5wKs_JQCA@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	kees@kernel.org, masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:50=E2=80=AFPM Jinchao Wang <wangjinchao600@gmail.=
com> wrote:
>
> On Tue, Oct 07, 2025 at 05:11:52PM -0700, Ian Rogers wrote:
> > On Tue, Oct 7, 2025 at 3:58=E2=80=AFPM Doug Anderson <dianders@chromium=
.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Oct 7, 2025 at 3:45=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > On Tue, Oct 7, 2025 at 2:43=E2=80=AFPM Doug Anderson <dianders@chro=
mium.org> wrote:
> > > > ...
> > > > > The buddy watchdog was pretty much following the conventions that=
 were
> > > > > already in the code: that the hardlockup detector (whether backed=
 by
> > > > > perf or not) was essentially called the "nmi watchdog". There wer=
e a
> > > > > number of people that were involved in reviews and I don't believ=
e
> > > > > suggesting creating a whole different mechanism for enabling /
> > > > > disabling the buddy watchdog was never suggested.
> > > >
> > > > I suspect they lacked the context that 1 in the nmi_watchdog is tak=
en
> > > > to mean there's a perf event in use by the kernel with implications=
 on
> > > > how group events behave. This behavior has been user
> > > > visible/advertised for 9 years. I don't doubt that there were good
> > > > intentions by PowerPC's watchdog and in the buddy watchdog patches =
in
> > > > using the file, that use will lead to spurious warnings and behavio=
rs
> > > > by perf.
> > > >
> > > > My points remain:
> > > > 1) using multiple files regresses perf's performance;
> > > > 2) the file name by its meaning is wrong;
> > > > 3) old perf tools on new kernels won't behave as expected wrt warni=
ngs
> > > > and metrics because the meaning of the file has changed.
> > > > Using a separate file for each watchdog resolves this. It seems tha=
t
> > > > there wasn't enough critical mass for getting this right to have
> > > > mattered before, but that doesn't mean we shouldn't get it right no=
w.
> > >
> > > Presumably your next steps then are to find someone to submit a patch
> > > and try to convince others on the list that this is a good idea. The
> > > issue with perf has been known for a while now and I haven't seen any
> > > patches. As I've said, I won't stand in the way if everyone else
> > > agrees, but given that I'm still not convinced I'm not going to autho=
r
> > > any patches for this myself.
> >
> > Writing >1 of:
> > ```
> > static struct ctl_table watchdog_hardlockup_sysctl[] =3D {
> > {
> > .procname       =3D "nmi_watchdog",
> > .data =3D &watchdog_hardlockup_user_enabled,
> > .maxlen =3D sizeof(int),
> > .mode =3D 0444,
> > .proc_handler   =3D proc_nmi_watchdog,
> > .extra1 =3D SYSCTL_ZERO,
> > .extra2 =3D SYSCTL_ONE,
> > },
> > };
> > ```
> > is an exercise of copy-and-paste, if you need me to do the copy and
> > pasting then it is okay.
> Can we get whether a perf event is already in use directly from the
> perf subsystem? There may be (or will be) other kernel users of
> perf_event besides the NMI watchdog. Exposing that state from the perf
> side would avoid coupling unrelated users through nmi_watchdog and
> similar features.

For regular processes there is this unmerged proposal:
https://lore.kernel.org/lkml/20250603181634.1362626-1-ctshao@google.com/
it doesn't say whether the counter is pinned - the NMI watchdog's
counter is pinned to be a higher priority that flexible regular
counters that may be multiplexed. I don't believe there is anything to
say whether the kernel has taken a performance counter. In general
something else taking a performance counter is okay as  the kernel
will multiplex the counter or groups of counters.

The particular issue for the NMI watchdog counter is that groups of
events are tested to see if they fit on a PMU, the perf event open
will fail when a group isn't possible and then the events will be
reprogrammed by the perf tool without a group. When the group is
tested the PMU has always assumed that all counters are available,
which of course with the NMI watchdog they are not. This results with
the NMI watchdog causing a group of events to be created that can
never be scheduled.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >
> > > -Doug
> > >
>
> --
> Jinchao
