Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28519EEC2
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867287; cv=none; b=fJmW8xomlBcyf5vu4PV7Y9O4Gy30GbM5zs9CDKOTrCp7WxFKjLKSIuQmR/iUCCdAVw3DeIcXOOgNmWthNsubS1ARhmwsnjnsrCb0u752AkFVohbCXhzJtcTHzRogstySAQzWjl0xJ3gLmbpCgu1VVewOmxxPhVKE7SI3HA0bYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867287; c=relaxed/simple;
	bh=Fuu8nkfLdbjRZzazMa0Phy8EHmY8oDSCvpjrwdDp/Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaZ0rSsTCMu174stF2PvKjOIhkX/cVrNbFH0irsa4bbsCzhvpER8x4ZYcHkQUT423PX7J/ZChUz+4VWPvMzNqQXDNJiRKOHkKAnbmNASLXYVFTIgtrvDse7PzfDoQ5/Wfm6V8/FuQGb9oIHM/RjnhoHfU6uuDiL7vnyAbfyTyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kkxOg8qa; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kkxOg8qa"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-424da17e309so70976565ab.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759867284; x=1760472084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yW/aQ0359kHD92Asr8l75TcASuOtUZ2H6uQ4aCH3qfI=;
        b=kkxOg8qa+KZ8RWhZ8JD2dDcYEBDKDgwBUE+NdSo1qIPBorMxDwIg4zNr9KBakTEMxw
         uEyh5Z8D0V1uz+6bi/sf+Yk2puJvz7j2fmLPzkwNIcknFROjTOUo2zI7QYfbtydOg6vD
         Vv84KiTXc20tUeaZD37HRi1a9ZkbvkTk+Xg20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759867284; x=1760472084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yW/aQ0359kHD92Asr8l75TcASuOtUZ2H6uQ4aCH3qfI=;
        b=cavyYwxgEMjV/9nTAZE7npcBJZESkOfylE2tcJTCFAF17ZFeG8/N6g9niHqk1KczAm
         9+M8d2LRmcWKR8f5w0BZYXQuU1oxVQrLzeipbtTRsIbrLu0Mrb73a2ZqlR7j1kuEaKy8
         2CUPr9WPOUMuYLyegrnG8DfHZsOXrgsTU0UkyghdI8UGti+j5PXHx5BHSoOzcykjIFuR
         s6ZtrLNnL2/xbJ2CsvfzBLz/5Wd7DoivNEGZlPW77vYEb62wVY9FlIcQA3ssOSOYkQK4
         bzZqdTxwY/6dFZ+M0VRspVSS7trV12kBJ7nRpizj6KrM0nw0PYiLedAp1hsGWgk+yr1O
         Qo3A==
X-Forwarded-Encrypted: i=1; AJvYcCV8k6R3c9AhxY1oLS7zeujnG2/ibBGU11l55BMRi64fLy3kabdZAI2BDIx79ZC8rCEfYZIencaKiGeDEDvblyxd@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhV93IHPvvwjFleOJX5lkFdv1MSApeet89MH3bw9sw7hujUtL
	Pz/F66kWCX2hJw37hyMJGPDT0aqlsrOVodevbXQBBnC9aw8FR6+PcNZxy7uPSw4K+renoP2Bq+O
	qVkE=
X-Gm-Gg: ASbGncvcKWE7WJSt/w0TvBw8melzjSe/DclbSMg9sM/7FzH5H6skNb3tAusovMsZkcy
	QEc37/NUKqVIe4M2N6DPqumrDi94NAa7bEaqc5DWu5I0yDAzD2A1u1AgUCsHV+bCfIbw6ynDwnO
	sYsZzE1hdatnwjKncZqbav6J1CfgH35e+3Tq/yaZkSQlyjF/ZmT5iw768pshTj2HScu4YjfYau1
	QbRzdiyjgFSG5XlySmAxxK1oRQ7hmRFywlIPZb+0r3kQvNiMPFE4SQCzTq5eqezbVjQ5eW1zSkN
	N3YIN+yxu1mUcpM4h05HEfPWoHG4iDPCH5B6mzCkpkspLD974PdH9k5WNeblf6Hwgge5xljuPiQ
	cnnbbPWYcvCQJVG0SsHFaw/BA+t2cZpF1kNPwaqjrjYD8DP45HsCaQt3W3aXLxO9oD0tpUHOh2i
	v7ZCcOCUrocgZjWibawlo4Dxti
X-Google-Smtp-Source: AGHT+IFFcRg5E9lPpDE/QyTmMqROGDF79Myq+weMUw467L15y8GhI3zvDAuv5u5efRFS6hYNVNq0kw==
X-Received: by 2002:a05:6e02:3c05:b0:42d:8a3f:ec9a with SMTP id e9e14a558f8ab-42f87346dfemr6822705ab.4.1759867283881;
        Tue, 07 Oct 2025 13:01:23 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea4b312sm6227330173.30.2025.10.07.13.01.23
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 13:01:23 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4242bb22132so65320265ab.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 13:01:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHuD1DC5c+hFsdq4wlfAF1Cg9QJ0gKMQOWg7vD3ALnVwYoVRq7L8hl2moJpOvkIOEczN18Ivj2D37kBziCj4VR@vger.kernel.org
X-Received: by 2002:a17:90b:48:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-33b51399953mr804760a91.36.1759866860576; Tue, 07 Oct 2025
 12:54:20 -0700 (PDT)
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
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com> <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 Oct 2025 12:54:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
X-Gm-Features: AS18NWApr4Rg-zXM3q8fbS_fiJ3b6uIVakfVzTHv9MBXxByROdeDBGbo6mNFQ44
Message-ID: <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
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

Hi,

On Mon, Oct 6, 2025 at 6:00=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Oct 6, 2025 at 4:32=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Mon, Oct 6, 2025 at 2:30=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Tue, Sep 16, 2025 at 11:14=E2=80=AFPM Jinchao Wang <wangjinchao600=
@gmail.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 10:35:46PM -0700, Namhyung Kim wrote:
> > > > > Hello,
> > > > >
> > > > > On Tue, Sep 16, 2025 at 10:13:12PM -0700, Ian Rogers wrote:
> > > > > > On Tue, Sep 16, 2025 at 6:47=E2=80=AFPM Jinchao Wang <wangjinch=
ao600@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 16, 2025 at 05:03:48PM -0700, Ian Rogers wrote:
> > > > > > > > On Tue, Sep 16, 2025 at 7:51=E2=80=AFAM Jinchao Wang <wangj=
inchao600@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Currently, the hard lockup detector is selected at compil=
e time via
> > > > > > > > > Kconfig, which requires a kernel rebuild to switch implem=
entations.
> > > > > > > > > This is inflexible, especially on systems where a perf ev=
ent may not
> > > > > > > > > be available or may be needed for other tasks.
> > > > > > > > >
> > > > > > > > > This commit refactors the hard lockup detector to replace=
 a rigid
> > > > > > > > > compile-time choice with a flexible build-time and boot-t=
ime solution.
> > > > > > > > > The patch supports building the kernel with either detect=
or
> > > > > > > > > independently, or with both. When both are built, a new b=
oot parameter
> > > > > > > > > `hardlockup_detector=3D"perf|buddy"` allows the selection=
 at boot time.
> > > > > > > > > This is a more robust and user-friendly design.
> > > > > > > > >
> > > > > > > > > This patch is a follow-up to the discussion on the kernel=
 mailing list
> > > > > > > > > regarding the preference and future of the hard lockup de=
tectors. It
> > > > > > > > > implements a flexible solution that addresses the communi=
ty's need to
> > > > > > > > > select an appropriate detector at boot time.
> > > > > > > > >
> > > > > > > > > The core changes are:
> > > > > > > > > - The `perf` and `buddy` watchdog implementations are sep=
arated into
> > > > > > > > >   distinct functions (e.g., `watchdog_perf_hardlockup_ena=
ble`).
> > > > > > > > > - Global function pointers are introduced (`watchdog_hard=
lockup_enable_ptr`)
> > > > > > > > >   to serve as a single API for the entire feature.
> > > > > > > > > - A new `hardlockup_detector=3D` boot parameter is added =
to allow the
> > > > > > > > >   user to select the desired detector at boot time.
> > > > > > > > > - The Kconfig options are simplified by removing the comp=
lex
> > > > > > > > >   `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both de=
tectors to be
> > > > > > > > >   built without mutual exclusion.
> > > > > > > > > - The weak stubs are updated to call the new function poi=
nters,
> > > > > > > > >   centralizing the watchdog logic.
> > > > > > > >
> > > > > > > > What is the impact on  /proc/sys/kernel/nmi_watchdog ? Is t=
hat
> > > > > > > > enabling and disabling whatever the boot time choice was? I=
'm not sure
> > > > > > > > why this has to be a boot time option given the ability to =
configure
> > > > > > > > via /proc/sys/kernel/nmi_watchdog.
> > > > > > > The new hardlockup_detector boot parameter and the existing
> > > > > > > /proc/sys/kernel/nmi_watchdog file serve different purposes.
> > > > > > >
> > > > > > > The boot parameter selects the type of hard lockup detector (=
perf or buddy).
> > > > > > > This choice is made once at boot.
> > > > > > >
> > > > > > >  /proc/sys/kernel/nmi_watchdog, on the other hand, is only a =
simple on/off
> > > > > > > switch for the currently selected detector. It does not chang=
e the detector's
> > > > > > > type.
> > > > > >
> > > > > > So the name "nmi_watchdog" for the buddy watchdog is wrong for =
fairly
> > > > > > obvious naming reasons but also because we can't differentiate =
when a
> > > > > > perf event has been taken or not - this impacts perf that is ch=
oosing
> > > > > > not to group events in metrics because of it, reducing the metr=
ic's
> > > > > > accuracy. We need an equivalent "buddy_watchdog" file to the
> > > > > > "nmi_watchdog" file. If we have such a file then if I did "echo=
 1 >
> > > > > > /proc/sys/kernel/nmi_watchdog" I'd expect the buddy watchdog to=
 be
> > > > > > disabled and the perf event one to be enabled. Similarly, if I =
did
> > > > > > "echo 1 > /proc/sys/kernel/buddy_watchdog" then I would expect =
the
> > > > > > perf event watchdog to be disabled and the buddy one enabled. I=
f I did
> > > > > >  "echo 0 > /proc/sys/kernel/nmi_watchdog; echo 0 >
> > > > > > /proc/sys/kernel/buddy_watchdog" then I'd expect neither to be
> > > > > > enabled. I don't see why choosing the type of watchdog implemen=
tation
> > > > > > at boot time is particularly desirable. It seems sensible to de=
fault
> > > > > > normal people to using the buddy watchdog (more perf events, po=
wer...)
> > > > > > and  CONFIG_DEBUG_KERNEL type people to using the perf event on=
e. As
> > > > > > the "nmi_watchdog" file may be assumed to control the buddy wat=
chdog,
> > > > > > perhaps a compatibility option (where the "nmi_watchdog" file c=
ontrols
> > > > > > the buddy watchdog) is needed so that user code has time to mig=
rate.
> > > > >
> > > > > Sounds good to me.  For perf tools, it'd be great if we can have =
a run-
> > > > > time check which watchdog is selected.
> > > > Considering backward compatibility, I prefer to keep
> > > > /proc/sys/kernel/nmi_watchdog and introduce a new file called
> > > > /proc/sys/kernel/hardlockup_detector_type, which only shows the def=
ault string
> > > > or the boot parameter.
> > >
> > > Is there code using the buddy watchdog that cares about the
> > > /proc/sys/kernel/nmi_watchdog file? My assumption is that everything
> > > except Android is using the NMI watchdog, so a new
> > > /proc/sys/kernel/buddy_watchdog file doesn't impact them.
> >
> > Buddy watchdog has been out there for a few years. At Google, I know
> > it's used by everything except Android. AKA I believe it is used in
> > Google's servers and also in ChromeOS. Both of those (presumably)
> > enable the buddy watchdog via calling it "nmi_watchdog". It's possible
> > that some Android phones are using the buddy watchdog too but I'm not
> > aware of it. I don't believe Pixel is using it, though that could
> > change in the future.
>
> I thought what motivated the buddy watchdog was patches implementing
> this approach on Android for ARM that lacked an NMI based hard lockup
> detector?

It's probably not worth a full rehash of the history, but suffice to
say that the buddy lockup detector did originally come out of Android
but isn't currently used there as far as I can tell.


> Anyway, while the buddy watchdog is in use by Google servers the
> nmi_watchdog file has an actively detrimental effect on that.
> Specifically the nmi_watchdog file having the value of "1" disables
> certain event groups for certain metrics in the perf tool as it is
> assumed there are too few performance counters due to the NMI watchdog
> stealing one. We want groups of events so that events are scheduled
> together and metrics are more accurate, we don't want groups that fail
> to schedule because of a lack of counters.

Fair enough, but that code could also change.


> > IMO at this point "nmi watchdog" is simply a synonym for the
> > hardlockup detector. That was what it looked like in the code before I
> > started messing around and adding the buddy lockup detector and it's
> > how it is now. While it's unfortunate that there are two names for the
> > same thing, I don't personally think that should change at this point.
> > FWIW, even the "buddy" watchdog relies on NMIs to actually get stack
> > crawls on stuck cores, so NMI still means something even there.
>
> I think this is misguided. Currently the only use of nmi_watchdog I'm
> aware of is by perf where the buddy watchdog's use of it causes issues
> (as mentioned above).
>
> > If we want to tell between the perf detector or the buddy detector we
> > should add a separate file for it.
>
> We could with perf then having to read from two files rather than one.
> Presumably the lack of presence of one file will be sufficient to also
> avoid a kernel version check.

This was what I was assuming


> > > On Android
> > > writing to /proc/sys/kernel/nmi_watchdog would switch from updating
> > > the buddy watchdog enable/disable to the NMI watchdog enable/disable,
> > > but it is a straightforward patch to make anything doing this update
> > > the buddy_watchdog file instead.
> >
> > Straightforward, but you've got to go find everyone that you break by
> > doing this. That's not something I want responsibility for. If you
> > want to convince others this is something worthwhile and you've got
> > someone signed up to deal with the fallout (if any) then I won't
> > object, but it's not something I'd be in support of.
>
> Stuff like this happens, check out this thread:
> https://lore.kernel.org/lkml/2025020304-chip-trench-4e56@gregkh/
> Imo we shouldn't design in using an actively misleading file name and
> incurring extra overhead in perf. Having two files nmi_watchdog and
> buddy_watchdog is fine as the latter case currently isn't in
> mainstream distro use and people shouldn't care. It also maintains and
> correct's perf's behavior when the buddy and not nmi watchdog is in
> use.
>
> > > If we have to keep "nmi_watchdog" then we should deprecate it and
> > > create an equivalent file with a better name (ie without NMI in it).
> > > It'll be moderately annoying in perf to determine whether the NMI
> > > watchdog is enabled by having to read two files.
> >
> > Again, up to you if you want to try to do this, but I'm not really in
> > support of it. It doesn't seem terribly hard to make a new file that
> > says which hardlockup detector is in use. If that file exists then
> > read it. If not then you fallback to what you have today.
>
> I don't mind a file that also says what kind of lockup detector is in
> use. I'd like the meaning of nmi_watchdog to keep meaning the kernel
> stole a perf counter as this is the behavior long assumed by perf
> which I think is the majority or only user of the file. I think the
> buddy watchdog being controlled by this file is less than intention
> revealing.

I'm more than happy to be outvoted, but IMO nothing about the name
"nmi_watchdog" says to me that a perf counter was stolen. It just says
that there's a watchdog that NMIs are part of its work.

...and, indeed, "nmi_watchdog" doesn't use perf on PPC, right? As far
as I can tell, from reading `arch/powerpc/kernel/watchdog.c` checks
`watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED`. ...and before I did
commit df95d3085caa ("watchdog/hardlockup: rename some "NMI watchdog"
constants/function") it was checking `watchdog_enabled &
NMI_WATCHDOG_ENABLED`. That was at least since 2019, I think...

...and you can see "PPC_WATCHDOG" depends on
"HARDLOCKUP_DETECTOR_ARCH", not "HARDLOCKUP_DETECTOR_PERF" so it's not
perf-backed.

I think this is just the critical question: does/should "nmi_watchdog"
mean perf-backed detector or is "nmi_watchdog" just a synonym for
"hard lockup detector". In your mind it's the former and in my mind
it's the latter. The correct way forward depends on which way we want
to jump, right? In either case some external code is going to need to
change...

The kernel docs are certainly pretty ambiguous here. "kernel.rst"
certainly mentions perf, but it also says that "nmi_watchdog" is only
for x86 which is certainly not true. "lockup-watchdogs.rst" doesn't
say anything about perf and just seems to indicate that "nmi_watchdog"
is another name for the hardlockup detector.  "kernel-parameters.txt"
makes some mention of tweaking which perf event would be used, but
otherwise makes it sound like the nmi_watchdog is just another name
for the hardlockup detector.

My vote would be two files:

* "nmi_watchdog" - simply a synonym for "hardlockup detector". 1
enabled, 0 if not (like today)

* "hardlock_detector" - could be "buddy", "perf", or "arch"

...if the "hardlockup_detector" file doesn't exist and "nmi_watchdog"
is enabled, you could probably guess that a perf event was in use. If
the "hardlockup_detector" file exists then a perf event is only in use
if the value of that file is "perf". It doesn't feel terribly hard to
do this and it doesn't break anyone who was assuming they could turn
on the hardlockup detector with "/proc/nmi_watchdog".

-Doug
