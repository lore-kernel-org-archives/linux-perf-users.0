Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749282556E
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793528; cv=none; b=bzBhHfT2mDRcF1MoQeCmsbW2qSucsXhooqB7l6GowoFUodQronUMBOJW0z9owVYR6j4KmtgIXOYmKp/2bOM1A7gqGclkgUb2tRuEVX8NAUadydnxYQL1Hdf4ijhM4jaD5qtn5aWr/up8QvDcAc+iPW/0HPv6zcHDKz3PT3+fVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793528; c=relaxed/simple;
	bh=7tqlVWP4acxgpE5EcMSiKS87wF6KuJWZHL6Q47dsTBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw17q8M+SjtFb2mgi938MHYdjjPAATvbEFJPbdumI/Y+04wkeQAQSLBPv7RNkAwfVfWdmnISQCks1mh5bMV6KKhs0t1UE8WtKifBZrHmaeJRk/qTy1Q2XcoIT4EHQ+Kv7shFT73x1AcOCzrrh77BSK2LtLuxyBe7Y8qJnVjuPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YBhAZbJ9; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBhAZbJ9"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5c7fda918feso6012473137.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759793524; x=1760398324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnju/FemhqeCtzM3OCxOQRA++/MMOptuug53TgoDLoo=;
        b=YBhAZbJ9Hx3Ui1F1IXZKySd5M4kIrN+IfyleUeV2LQ+p3x6gs4L8UOpoFzlo09xQPB
         LwXphr6HyY943yxOzP5EOGQOlbKQE38tBmBTRys/OMFvYumYZRltbSZr5pqkZ+Lhiaf8
         D0d8K2c/T1Iwxq8v0FR4nxkhkFCP6SycC4XEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793524; x=1760398324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gnju/FemhqeCtzM3OCxOQRA++/MMOptuug53TgoDLoo=;
        b=L7EYMrhxUXP8VGij52TRWxKLNjMx3S8ABGoCFsEpA2jmrGh3G4dIsuttYygrjEjDn/
         IwGY6vJ5rmnH4Do5fchpkfKV+/Uja4aqQyd8XcE2oEXoTuzYBReuqBXKNIB06+REU0J8
         oY4g4P8kKTtGh4DUS0eL3wbrSyuiH5fVm2nVLI8tihN1n3wCDe7eU8ZR7x+MOT9MHvrw
         BPXyW06WKsLl4hHvv4SG5+UQg9bbl//jxvsDgBmYHOBZT+SgdUGgAjQrFs5zY9cKO9us
         vnzYkMx5FZGugOqMpN5TFJDisUB0rhHS2iDKY8c68c16+CeJlBX9Muf9W8b16XgUpZDU
         wXoA==
X-Forwarded-Encrypted: i=1; AJvYcCXF041adefk1RCZye4+Y+24A3B+/xa9JN3+b2YrRbnSifc2BDp/b1x+/UImdlVi/XuDaPpXiNd7hYe4Tgv/ZfMl@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpziC8y40C2t9B0kUirAW1VgJdLkdYRDCgDJAukPMx9sA8Ini
	vba4OmYGp8lYmsBK3JDSYtZ0g14POhkEVOAnU37RqI3QRMZ45HLTlOLUZoBj1hAk53qEqPLa2i4
	HdXg=
X-Gm-Gg: ASbGnctW3g88tRA4VUr5OGjeFQaL/jsfx5zusUjwJHnvnxvPH8TvBUUpKaaCf27n4B5
	dE3cIJbmL5DVntTKJXBd84zbFFfoh1FBCLzjT4CRlx+qgEZyw/sDDWE0NoR6w0KOLXBsF5GOm7U
	e3Vj7lLkLq+/NQnrB8vwhXbnhPoMUEwfX32r9Do+vq3IRUh3PQbU0wk6wKElyPcJRs1tcRyB2ms
	67okBxP5SdzJBWmpAF7anDC2lVfwwBikS/y85PAjbmzW6gYx5Zk0j8QpkyDC/d63VBDcCjI2pyp
	J7HZGSgTALoTMCHthrXnTzoR5nv56/ze/qzSm6BZksM4YPuNs8oZBcwnfAY575oQBMRRA7IsRwI
	HvE7SQ0k9uvOnPsT7BRSk0a36k9nNyUQioWxpz44bvN2wPiA3vUjV+20Vt3WG/X1d9XnITTpSWE
	Fl/TYwxt4hYg==
X-Google-Smtp-Source: AGHT+IF3ZZmxdES8MLySBu8qzJCo1vmFFEMqOrOnwcnqfwgbgTQabDbMU50iIbfQCqAGbgp5UCkPTw==
X-Received: by 2002:a05:6102:512c:b0:59d:2396:18fb with SMTP id ada2fe7eead31-5d41d0fd79bmr5552761137.25.1759793524472;
        Mon, 06 Oct 2025 16:32:04 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4ea7941sm3306441241.12.2025.10.06.16.32.02
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 16:32:03 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8e936be1359so3467017241.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 16:32:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2xU6KiMEy2ozQfmL8BBmoLZdmjDYFuYZnFYVRpqTUFi4kCn/Cd5UQfkghyI1FSLrUH0A0Y1CGJU+ygx0fnGVZ@vger.kernel.org
X-Received: by 2002:a17:903:1a86:b0:28e:7567:3c45 with SMTP id
 d9443c01a7336-28e9a54ef63mr131748815ad.9.1759793096320; Mon, 06 Oct 2025
 16:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev> <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
 <aMpIsqcgpOH1AObN@z2> <aMpRqlDXXOR5qYFd@mdev> <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
In-Reply-To: <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Oct 2025 16:24:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
X-Gm-Features: AS18NWBbZ6LGmNfNjtMxbnkF3b7BSgxpW00PIA8Lwf4SUgxrT3SU1KuL0dbjEqc
Message-ID: <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Ian Rogers <irogers@google.com>
Cc: Jinchao Wang <wangjinchao600@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
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

Hi,

On Mon, Oct 6, 2025 at 2:30=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Sep 16, 2025 at 11:14=E2=80=AFPM Jinchao Wang <wangjinchao600@gma=
il.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 10:35:46PM -0700, Namhyung Kim wrote:
> > > Hello,
> > >
> > > On Tue, Sep 16, 2025 at 10:13:12PM -0700, Ian Rogers wrote:
> > > > On Tue, Sep 16, 2025 at 6:47=E2=80=AFPM Jinchao Wang <wangjinchao60=
0@gmail.com> wrote:
> > > > >
> > > > > On Tue, Sep 16, 2025 at 05:03:48PM -0700, Ian Rogers wrote:
> > > > > > On Tue, Sep 16, 2025 at 7:51=E2=80=AFAM Jinchao Wang <wangjinch=
ao600@gmail.com> wrote:
> > > > > > >
> > > > > > > Currently, the hard lockup detector is selected at compile ti=
me via
> > > > > > > Kconfig, which requires a kernel rebuild to switch implementa=
tions.
> > > > > > > This is inflexible, especially on systems where a perf event =
may not
> > > > > > > be available or may be needed for other tasks.
> > > > > > >
> > > > > > > This commit refactors the hard lockup detector to replace a r=
igid
> > > > > > > compile-time choice with a flexible build-time and boot-time =
solution.
> > > > > > > The patch supports building the kernel with either detector
> > > > > > > independently, or with both. When both are built, a new boot =
parameter
> > > > > > > `hardlockup_detector=3D"perf|buddy"` allows the selection at =
boot time.
> > > > > > > This is a more robust and user-friendly design.
> > > > > > >
> > > > > > > This patch is a follow-up to the discussion on the kernel mai=
ling list
> > > > > > > regarding the preference and future of the hard lockup detect=
ors. It
> > > > > > > implements a flexible solution that addresses the community's=
 need to
> > > > > > > select an appropriate detector at boot time.
> > > > > > >
> > > > > > > The core changes are:
> > > > > > > - The `perf` and `buddy` watchdog implementations are separat=
ed into
> > > > > > >   distinct functions (e.g., `watchdog_perf_hardlockup_enable`=
).
> > > > > > > - Global function pointers are introduced (`watchdog_hardlock=
up_enable_ptr`)
> > > > > > >   to serve as a single API for the entire feature.
> > > > > > > - A new `hardlockup_detector=3D` boot parameter is added to a=
llow the
> > > > > > >   user to select the desired detector at boot time.
> > > > > > > - The Kconfig options are simplified by removing the complex
> > > > > > >   `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detect=
ors to be
> > > > > > >   built without mutual exclusion.
> > > > > > > - The weak stubs are updated to call the new function pointer=
s,
> > > > > > >   centralizing the watchdog logic.
> > > > > >
> > > > > > What is the impact on  /proc/sys/kernel/nmi_watchdog ? Is that
> > > > > > enabling and disabling whatever the boot time choice was? I'm n=
ot sure
> > > > > > why this has to be a boot time option given the ability to conf=
igure
> > > > > > via /proc/sys/kernel/nmi_watchdog.
> > > > > The new hardlockup_detector boot parameter and the existing
> > > > > /proc/sys/kernel/nmi_watchdog file serve different purposes.
> > > > >
> > > > > The boot parameter selects the type of hard lockup detector (perf=
 or buddy).
> > > > > This choice is made once at boot.
> > > > >
> > > > >  /proc/sys/kernel/nmi_watchdog, on the other hand, is only a simp=
le on/off
> > > > > switch for the currently selected detector. It does not change th=
e detector's
> > > > > type.
> > > >
> > > > So the name "nmi_watchdog" for the buddy watchdog is wrong for fair=
ly
> > > > obvious naming reasons but also because we can't differentiate when=
 a
> > > > perf event has been taken or not - this impacts perf that is choosi=
ng
> > > > not to group events in metrics because of it, reducing the metric's
> > > > accuracy. We need an equivalent "buddy_watchdog" file to the
> > > > "nmi_watchdog" file. If we have such a file then if I did "echo 1 >
> > > > /proc/sys/kernel/nmi_watchdog" I'd expect the buddy watchdog to be
> > > > disabled and the perf event one to be enabled. Similarly, if I did
> > > > "echo 1 > /proc/sys/kernel/buddy_watchdog" then I would expect the
> > > > perf event watchdog to be disabled and the buddy one enabled. If I =
did
> > > >  "echo 0 > /proc/sys/kernel/nmi_watchdog; echo 0 >
> > > > /proc/sys/kernel/buddy_watchdog" then I'd expect neither to be
> > > > enabled. I don't see why choosing the type of watchdog implementati=
on
> > > > at boot time is particularly desirable. It seems sensible to defaul=
t
> > > > normal people to using the buddy watchdog (more perf events, power.=
..)
> > > > and  CONFIG_DEBUG_KERNEL type people to using the perf event one. A=
s
> > > > the "nmi_watchdog" file may be assumed to control the buddy watchdo=
g,
> > > > perhaps a compatibility option (where the "nmi_watchdog" file contr=
ols
> > > > the buddy watchdog) is needed so that user code has time to migrate=
.
> > >
> > > Sounds good to me.  For perf tools, it'd be great if we can have a ru=
n-
> > > time check which watchdog is selected.
> > Considering backward compatibility, I prefer to keep
> > /proc/sys/kernel/nmi_watchdog and introduce a new file called
> > /proc/sys/kernel/hardlockup_detector_type, which only shows the default=
 string
> > or the boot parameter.
>
> Is there code using the buddy watchdog that cares about the
> /proc/sys/kernel/nmi_watchdog file? My assumption is that everything
> except Android is using the NMI watchdog, so a new
> /proc/sys/kernel/buddy_watchdog file doesn't impact them.

Buddy watchdog has been out there for a few years. At Google, I know
it's used by everything except Android. AKA I believe it is used in
Google's servers and also in ChromeOS. Both of those (presumably)
enable the buddy watchdog via calling it "nmi_watchdog". It's possible
that some Android phones are using the buddy watchdog too but I'm not
aware of it. I don't believe Pixel is using it, though that could
change in the future.

IMO at this point "nmi watchdog" is simply a synonym for the
hardlockup detector. That was what it looked like in the code before I
started messing around and adding the buddy lockup detector and it's
how it is now. While it's unfortunate that there are two names for the
same thing, I don't personally think that should change at this point.
FWIW, even the "buddy" watchdog relies on NMIs to actually get stack
crawls on stuck cores, so NMI still means something even there.

If we want to tell between the perf detector or the buddy detector we
should add a separate file for it.

> On Android
> writing to /proc/sys/kernel/nmi_watchdog would switch from updating
> the buddy watchdog enable/disable to the NMI watchdog enable/disable,
> but it is a straightforward patch to make anything doing this update
> the buddy_watchdog file instead.

Straightforward, but you've got to go find everyone that you break by
doing this. That's not something I want responsibility for. If you
want to convince others this is something worthwhile and you've got
someone signed up to deal with the fallout (if any) then I won't
object, but it's not something I'd be in support of.


> If we have to keep "nmi_watchdog" then we should deprecate it and
> create an equivalent file with a better name (ie without NMI in it).
> It'll be moderately annoying in perf to determine whether the NMI
> watchdog is enabled by having to read two files.

Again, up to you if you want to try to do this, but I'm not really in
support of it. It doesn't seem terribly hard to make a new file that
says which hardlockup detector is in use. If that file exists then
read it. If not then you fallback to what you have today.

-Doug
