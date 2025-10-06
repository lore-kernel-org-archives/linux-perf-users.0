Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6173FC7
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759786213; cv=none; b=GwS9cz8CaKpYhD+PLa9xDrkluftOq9mtmG1kIphmyEruhnZ97dNIamoD+OSbjuThthCCRTlYi+pYDN3Z3/Da3ShwUOy7ZSfT3x1vxf0G3LI9ZxumbjkInExzif4QwmKeWS0y2y0QR9mJorVuvTOZpnTrcHGTfD9rnguZlJ//TBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759786213; c=relaxed/simple;
	bh=G++TVFpTn9qgmMRG5/zGKEsQpQPZr6Les6XJe4XifHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU7H4jlhDkUlbRmx7ee1LPJGZCbcKn64TUh/aO+O+Gzu2L3FF8eobbzwlJP7aGWkMgZwpKvK3FoY9yBagzj3D5tWgH2if11hQ8EWHPDI0tHX/IDsGSrIwTuvO5pYfv/2d5vqIXA4fEPLpadaJROq+yEMeyV+iZ8J2DlFVlMqs48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzhgLIsV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzhgLIsV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2731ff54949so23265ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759786211; x=1760391011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw1MyvGILMOokBtUrAMjae6GJN1JO+CrPDkYUwFO7Vw=;
        b=tzhgLIsV+qY7BIrNGdYN5k3Tc8LKIAY5mABd+BPaKpafklmqVjyeuC3hcUqC4k0VEB
         4q7uNGvntveDIOCvbvDPiI5mmUFMjEaC+DGs1LjzBpRtYQC1u0BJcMhDVnMw/r2FA7ki
         jy+dD2e0Lhrpqlhc+6cY9gnvzZxnA67Fh4+BCZHBl92TK8qCEAgPq4btNU1gzNQhlp/i
         WOOVH8jFnJiGOdeRzACae5D+p2ZPsn2N7FHDKve9yxW9sdbM7TjELJKhaq3pNuqd7ARD
         1Iyb7hVQDEYwTY5k0Y/l/Pq0jayphstDoK11yCxFo7Efb6zUCR2ugvquV2t6nYBA8W1B
         ityA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759786211; x=1760391011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw1MyvGILMOokBtUrAMjae6GJN1JO+CrPDkYUwFO7Vw=;
        b=HTmE2nHcOyiJqa1H8/maAtb9kaa/QdZ1xd5OTFjfaDiRp7ran6Bh6OQZkpNLPMyDp6
         UhE5+aOgXHW7onciXDDymDldbCoGTdzljNiBBVSXwbhe0kG+dp4vpkc8bSU8yvPls9Ee
         F2wG69hXVgGVZRqZF8bfNC2M7HqEpsScVh/wAYjNLiaxMjoE3HsT5LlUfXXjrnGAf+Nn
         YeYeEWLAMCJ/e/Ywt7L1l5OVsBK2xr9ExFIJ0VkiJYDkPrMqws4aWB8WS89uviMORZsL
         enepSxfoW1D3GmVkX4sJQ/FxCdDJLo+KvI3OWoFdvMu3jHgQcE4PS56EMhX/maKQqHQa
         brbw==
X-Forwarded-Encrypted: i=1; AJvYcCX58zpNGGwAZhtXi34yP7off1hvZqGOtp1M9Oq4/GUGNzpf23NXhw1hIanzm6GAqAO/EHNagirU7JuymoOEsloZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHHJR88LNk0DpFexSKMqMeL0wx6yyyCZpXYF30CqPYYUsrJZj
	z1S3PFhY6OVp94Plx7WcFQAHtV46zmyginWQ4jgeHi9SJZMM4D1vt1xo6kbGXeu3uBEZX+0kFbz
	6Fx8Pg/Rl4t2As4KcJTUypx6G/+a+ESLRXGIOdgUr
X-Gm-Gg: ASbGncs7KSPGxADLaAKcja0YDLGV7phNKEcYBzA2ry1DjNpaTH5tqEuFmKryLdQhQOo
	LTsYVu/0JGnUpFLuZ4ioU2GqEr8eUVuFGemkTGd6jD8jsdhUkaPVn/JQIb7H++RH6zYqZ6PiUG+
	9LeCf332t2DVUHQCC3kPMWP5KWtJHYfosqvpthZaPuVkkq4lupZlJFRAfC5dIfA4sDGCjVxSJRO
	4x9LOCcnwUeulvpdoB5iPHowYefSJ4IHyyHqmDBK2njObg7Um8WnIsdd1D0e60Tio45qUEYP8PT
	HlY=
X-Google-Smtp-Source: AGHT+IFkI1d774NUM89ERAmmoBpl8K2DOaRCy8aLicUU5wa9/d/itWTaNCjDnD5mazd4twphVqteWH4/6mJbbTT8ad8=
X-Received: by 2002:a17:903:13c6:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-28ecb74e7c6mr413065ad.9.1759786210402; Mon, 06 Oct 2025
 14:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev> <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
 <aMpIsqcgpOH1AObN@z2> <aMpRqlDXXOR5qYFd@mdev>
In-Reply-To: <aMpRqlDXXOR5qYFd@mdev>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 14:29:59 -0700
X-Gm-Features: AS18NWAsc-mMgvqvwymBO2fCmWj4Pi21wg3nny62z2YmWnca4ioS04TPfarW-YI
Message-ID: <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Doug Anderson <dianders@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
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

On Tue, Sep 16, 2025 at 11:14=E2=80=AFPM Jinchao Wang <wangjinchao600@gmail=
.com> wrote:
>
> On Tue, Sep 16, 2025 at 10:35:46PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > On Tue, Sep 16, 2025 at 10:13:12PM -0700, Ian Rogers wrote:
> > > On Tue, Sep 16, 2025 at 6:47=E2=80=AFPM Jinchao Wang <wangjinchao600@=
gmail.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 05:03:48PM -0700, Ian Rogers wrote:
> > > > > On Tue, Sep 16, 2025 at 7:51=E2=80=AFAM Jinchao Wang <wangjinchao=
600@gmail.com> wrote:
> > > > > >
> > > > > > Currently, the hard lockup detector is selected at compile time=
 via
> > > > > > Kconfig, which requires a kernel rebuild to switch implementati=
ons.
> > > > > > This is inflexible, especially on systems where a perf event ma=
y not
> > > > > > be available or may be needed for other tasks.
> > > > > >
> > > > > > This commit refactors the hard lockup detector to replace a rig=
id
> > > > > > compile-time choice with a flexible build-time and boot-time so=
lution.
> > > > > > The patch supports building the kernel with either detector
> > > > > > independently, or with both. When both are built, a new boot pa=
rameter
> > > > > > `hardlockup_detector=3D"perf|buddy"` allows the selection at bo=
ot time.
> > > > > > This is a more robust and user-friendly design.
> > > > > >
> > > > > > This patch is a follow-up to the discussion on the kernel maili=
ng list
> > > > > > regarding the preference and future of the hard lockup detector=
s. It
> > > > > > implements a flexible solution that addresses the community's n=
eed to
> > > > > > select an appropriate detector at boot time.
> > > > > >
> > > > > > The core changes are:
> > > > > > - The `perf` and `buddy` watchdog implementations are separated=
 into
> > > > > >   distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
> > > > > > - Global function pointers are introduced (`watchdog_hardlockup=
_enable_ptr`)
> > > > > >   to serve as a single API for the entire feature.
> > > > > > - A new `hardlockup_detector=3D` boot parameter is added to all=
ow the
> > > > > >   user to select the desired detector at boot time.
> > > > > > - The Kconfig options are simplified by removing the complex
> > > > > >   `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detector=
s to be
> > > > > >   built without mutual exclusion.
> > > > > > - The weak stubs are updated to call the new function pointers,
> > > > > >   centralizing the watchdog logic.
> > > > >
> > > > > What is the impact on  /proc/sys/kernel/nmi_watchdog ? Is that
> > > > > enabling and disabling whatever the boot time choice was? I'm not=
 sure
> > > > > why this has to be a boot time option given the ability to config=
ure
> > > > > via /proc/sys/kernel/nmi_watchdog.
> > > > The new hardlockup_detector boot parameter and the existing
> > > > /proc/sys/kernel/nmi_watchdog file serve different purposes.
> > > >
> > > > The boot parameter selects the type of hard lockup detector (perf o=
r buddy).
> > > > This choice is made once at boot.
> > > >
> > > >  /proc/sys/kernel/nmi_watchdog, on the other hand, is only a simple=
 on/off
> > > > switch for the currently selected detector. It does not change the =
detector's
> > > > type.
> > >
> > > So the name "nmi_watchdog" for the buddy watchdog is wrong for fairly
> > > obvious naming reasons but also because we can't differentiate when a
> > > perf event has been taken or not - this impacts perf that is choosing
> > > not to group events in metrics because of it, reducing the metric's
> > > accuracy. We need an equivalent "buddy_watchdog" file to the
> > > "nmi_watchdog" file. If we have such a file then if I did "echo 1 >
> > > /proc/sys/kernel/nmi_watchdog" I'd expect the buddy watchdog to be
> > > disabled and the perf event one to be enabled. Similarly, if I did
> > > "echo 1 > /proc/sys/kernel/buddy_watchdog" then I would expect the
> > > perf event watchdog to be disabled and the buddy one enabled. If I di=
d
> > >  "echo 0 > /proc/sys/kernel/nmi_watchdog; echo 0 >
> > > /proc/sys/kernel/buddy_watchdog" then I'd expect neither to be
> > > enabled. I don't see why choosing the type of watchdog implementation
> > > at boot time is particularly desirable. It seems sensible to default
> > > normal people to using the buddy watchdog (more perf events, power...=
)
> > > and  CONFIG_DEBUG_KERNEL type people to using the perf event one. As
> > > the "nmi_watchdog" file may be assumed to control the buddy watchdog,
> > > perhaps a compatibility option (where the "nmi_watchdog" file control=
s
> > > the buddy watchdog) is needed so that user code has time to migrate.
> >
> > Sounds good to me.  For perf tools, it'd be great if we can have a run-
> > time check which watchdog is selected.
> Considering backward compatibility, I prefer to keep
> /proc/sys/kernel/nmi_watchdog and introduce a new file called
> /proc/sys/kernel/hardlockup_detector_type, which only shows the default s=
tring
> or the boot parameter.

Is there code using the buddy watchdog that cares about the
/proc/sys/kernel/nmi_watchdog file? My assumption is that everything
except Android is using the NMI watchdog, so a new
/proc/sys/kernel/buddy_watchdog file doesn't impact them. On Android
writing to /proc/sys/kernel/nmi_watchdog would switch from updating
the buddy watchdog enable/disable to the NMI watchdog enable/disable,
but it is a straightforward patch to make anything doing this update
the buddy_watchdog file instead.

If we have to keep "nmi_watchdog" then we should deprecate it and
create an equivalent file with a better name (ie without NMI in it).
It'll be moderately annoying in perf to determine whether the NMI
watchdog is enabled by having to read two files.

Thanks,
Ian

> The global str pointer hardlockup_detector_type was already introduced in=
 the
> patch, so exposing it in a file is straightforward.
> >
> > Thanks,
> > Namhyung
> >
>
> --
> Jinchao
