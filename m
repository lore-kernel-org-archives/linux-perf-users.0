Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E5246783
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873881; cv=none; b=LmOx/d7gierMctUUn5ZnUFB4TQ4nIgJXMXmPhczi90wWkoabThKhkBRK5/anQbm4btGRL5qJVw/qVAor7MNsFetAsEU+1rQchjQmzFCr5CPbqc2I70tfnIgdn9rk+bfqI0IgjYbGul0wcgcc4S2Vrrzh7yeM2c7UQOL69XRGgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873881; c=relaxed/simple;
	bh=mXMo9HWefitty/egIYp/klsc0GBXRnutCiuqQwkHvQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtOrAkKLqQLKxJXHy0Nef5rgIpSoGGJFMtMLjoELVM63rz9PMdHKRFnXS2vVCeWoy9kgqOlRzFtLLksGpsiXqQYxo1YxgdoGow2KUsBSgrqe9X4Mhcu5pGEpn4LIy9uV9AT+fFlXqFhE+TEnbSoYrQUU1F6ShQ+P/ZRfw0Ed2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QFXYY4H6; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QFXYY4H6"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so5630990137.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759873878; x=1760478678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq6BkujLYLi29aUNYGOcmotTjsZeMJXrFlPqy91DqOM=;
        b=QFXYY4H6LWLphSuWTiPtNrTUQahgjGW15wjavyq59a5B991uNiUbIHbHDdLDF8zjC0
         TWXqEuF42GelkRzpoz1niAy89scAseqw75kVrEc6l3p2RrMVRqDYrdLKe1SdtXfiB/iJ
         u0I0lMfltv4XVvH9OGl8Jj7LzqWfBjl7pDWb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873878; x=1760478678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fq6BkujLYLi29aUNYGOcmotTjsZeMJXrFlPqy91DqOM=;
        b=Helk8Cq3+RXFtSv9k/Vj1buZyjnzMPBFQADAqIQYSsUo5m3E7EFu9i1tSXH4Fz5Efs
         +N0MYjC7rh4u1+h/ug1TCYvWnd+IDeFcITstkepOyo6UAydzaM2HxsAhynr8OMURgLr5
         kqeNnnIC2EEZOMLFZP5ndI99ait6vvTWYTELkxmaphhkUUe12PvOUkpjDyd6cz9HGE1F
         vYNMf/WpjMt4G/s7UQZs6nMUdeyGw91M7IP+kkZs18uUNmeP9+ca49hLHlXwnnu8uI5i
         7m/dDh75NWOapYnXBWwvYsIqjs6eQmmfYBQ8TLBvovaI+JLEobSQncSqRnzv+YBH1v/5
         dFIA==
X-Forwarded-Encrypted: i=1; AJvYcCVzXK0/jwjjyLyGm9VFvBdFUrbJLXZ/644utq6ucfd38xBhiwiEWowhpcIsrI9YBd9w4Qj6SlS1MJXtdmi6FEaX@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLbtu5Usky8KLw6buS2jeRoguk+2Fe+b4C6XNtH3qcj0BoquD
	+MP7dp7V/6p8i6IY3CinH79Vgt67C/ANYqU5JC4wJ5K+hOmJxpVI6V3aa68i/kRXthAD0pnC7HQ
	6TNM=
X-Gm-Gg: ASbGncu4klMGQwTqDZxYlY/wQqhcfxC3NvyXCCj/nrcN5zHAO54NI5ijY7kz3+jx5VJ
	DMTd49XVMs6yOhpXKG/DTQ0SeahzHFEutbzY7n+Ib0KTSvCe1tWcIYDYy7/VYKHyg/HJXRzSIGk
	G32WVPWp0jl+hmFTDJmpU+BYHzwTRf4WlDOHb03JoqlIC4YobvDEakVoUgAzUgvMY0GgH7+ReVI
	pGJfBUvD0WK5jhCbEncLVA3vb84dLNK8ePHGxfzD/AorpVtNAPWCR2Vk6bNFcBDXyl5RBwCtxCo
	krgZct/46Py/qKbtvWuVA/smn4m1dhJ2rLzaIp0HEIxuf9YCfW8Zv8OXfSJb8VjmZsfhHVKORkl
	ZLNt/Z2Fpz0nW9DRpG85CYkrtMLQlKuckds/M6b/hDtmGz0Nk8kaXbr171tc0ZOUu8U4YqjdB0i
	ODb7ZxVDkZrQ==
X-Google-Smtp-Source: AGHT+IHslFZnvPnxyPkX/mZaHNYOVntINpkpA4GAI9InrAcnHeQ0US6B53DlhauGtrVRH4NQDUUgpA==
X-Received: by 2002:a05:6102:512b:b0:5d3:ff01:363d with SMTP id ada2fe7eead31-5d5e2323bc3mr462488137.21.1759873877592;
        Tue, 07 Oct 2025 14:51:17 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4eab863sm3748425241.10.2025.10.07.14.51.16
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:51:16 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5a0d17db499so6223399137.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 14:51:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjXuVxK4Qb1mLC395aWv8qWkvOaB8t8snYcJoAurJ7AiGz7mNwOsxlHWHJFLHG3QOLjVMlE6EHHDuhXySmKUO0@vger.kernel.org
X-Received: by 2002:a17:903:1a6b:b0:25c:abb3:9bae with SMTP id
 d9443c01a7336-29027385222mr12638845ad.48.1759873408458; Tue, 07 Oct 2025
 14:43:28 -0700 (PDT)
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
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com> <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
In-Reply-To: <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 Oct 2025 14:43:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
X-Gm-Features: AS18NWBYFe63_-xIFHhSVLEaht3LtLaaYEfLA9Sab9Q5YCvr1mkfoaxOS0mBbFo
Message-ID: <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
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

On Tue, Oct 7, 2025 at 1:43=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Oct 7, 2025 at 1:00=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
> > On Mon, Oct 6, 2025 at 6:00=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> ..
> > > I don't mind a file that also says what kind of lockup detector is in
> > > use. I'd like the meaning of nmi_watchdog to keep meaning the kernel
> > > stole a perf counter as this is the behavior long assumed by perf
> > > which I think is the majority or only user of the file. I think the
> > > buddy watchdog being controlled by this file is less than intention
> > > revealing.
> >
> > I'm more than happy to be outvoted, but IMO nothing about the name
> > "nmi_watchdog" says to me that a perf counter was stolen. It just says
> > that there's a watchdog that NMIs are part of its work.
> >
> > ...and, indeed, "nmi_watchdog" doesn't use perf on PPC, right? As far
> > as I can tell, from reading `arch/powerpc/kernel/watchdog.c` checks
> > `watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED`. ...and before I did
> > commit df95d3085caa ("watchdog/hardlockup: rename some "NMI watchdog"
> > constants/function") it was checking `watchdog_enabled &
> > NMI_WATCHDOG_ENABLED`. That was at least since 2019, I think...
> >
> > ...and you can see "PPC_WATCHDOG" depends on
> > "HARDLOCKUP_DETECTOR_ARCH", not "HARDLOCKUP_DETECTOR_PERF" so it's not
> > perf-backed.
> >
> > I think this is just the critical question: does/should "nmi_watchdog"
> > mean perf-backed detector or is "nmi_watchdog" just a synonym for
> > "hard lockup detector". In your mind it's the former and in my mind
> > it's the latter. The correct way forward depends on which way we want
> > to jump, right? In either case some external code is going to need to
> > change...
>
> So we could say it is one-idea against another, I'm hoping to be
> objective and come from the viewpoint of the perf code as part of its
> function is to be a demonstration of APIs and the buddy watchdog has
> altered this. The perf tool has referred to the nmi_watchdog's
> behavior in man pages and code since 2016:
> http://lkml.kernel.org/r/1459810686-15913-1-git-send-email-andi@firstfloo=
r.org
> ```
> +Globally pinned events can limit the number of counters available for
> +other groups. On x86 systems, the NMI watchdog pins a counter by default=
.
> +The nmi watchdog can be disabled as root with
> +
> +       echo 0 > /proc/sys/kernel/nmi_watchdog
> ```
> http://lkml.kernel.org/r/1464119559-17203-1-git-send-email-andi@firstfloo=
r.org
> ```
> +void arch_topdown_group_warn(void)
> +{
> +       fprintf(stderr,
> +               "nmi_watchdog enabled with topdown. May give wrong result=
s.\n"
> +               "Disable with echo 0 > /proc/sys/kernel/nmi_watchdog\n");
> +}
> ```
>
> Probably the most common error message dates back to 2017:
> http://lkml.kernel.org/r/20170211183218.ijnvb5f7ciyuunx4@pd.tnic
> ```
>       Some events weren't counted. Try disabling the NMI watchdog:
>            echo 0 > /proc/sys/kernel/nmi_watchdog
>            perf stat ...
>            echo 1 > /proc/sys/kernel/nmi_watchdog
> ```
> and that is saying "NMI watchdog" not "buddy watchdog". Users are
> familiar with the idea that the /proc/sys/kernel/nmi_watchdog is
> unremarkably controlling the NMI watchdog.
>
> I've not found another use of /proc/sys/kernel/nmi_watchdog outside of
> the perf tool.

Although it's possible I missed it, from my quick look in ChromeOS, I
don't see any use of `/proc/sys/kernel/nmi_watchdog` either. NOTE that
you also need to look for `sysctl` references to
`kernel.nmi_watchdog`, right? That's essentially a way to access the
exact same file...

The other thing you need to think about is the kernel command-line
parameter. Right now we have the kernel command line parameter
`nmi_watchdog=3D<0,1>` that can be used to turn the hardlockup detector
on or off. On PowerPC I believe it turns on/off the ARCH hardlockup
detector. On systems with the buddy hardlockup detector it turns
on/off the buddy hardlockup detector. How are you proposing to handle
that? Are you going to make the kernel command line parameter still
affect everyone, or require people using the kernel command line
parameter for buddy/powerpc to change?

All of these ways to turn off/on the hardlockup detector can, in
theory, also be things that end users are messing with. People may
have settings in their `/etc/sysctl.d` to tweak things. They may have
messed with the kernel command line in their bootloader to tweak this
setting. I'm not saying it's impossible to change, but anyone who
changes this has to be prepared for people to yell.


> > The kernel docs are certainly pretty ambiguous here. "kernel.rst"
> > certainly mentions perf, but it also says that "nmi_watchdog" is only
> > for x86 which is certainly not true. "lockup-watchdogs.rst" doesn't
> > say anything about perf and just seems to indicate that "nmi_watchdog"
> > is another name for the hardlockup detector.  "kernel-parameters.txt"
> > makes some mention of tweaking which perf event would be used, but
> > otherwise makes it sound like the nmi_watchdog is just another name
> > for the hardlockup detector.
> >
> > My vote would be two files:
> >
> > * "nmi_watchdog" - simply a synonym for "hardlockup detector". 1
> > enabled, 0 if not (like today)
> >
> > * "hardlock_detector" - could be "buddy", "perf", or "arch"
> >
> > ...if the "hardlockup_detector" file doesn't exist and "nmi_watchdog"
> > is enabled, you could probably guess that a perf event was in use. If
> > the "hardlockup_detector" file exists then a perf event is only in use
> > if the value of that file is "perf". It doesn't feel terribly hard to
> > do this and it doesn't break anyone who was assuming they could turn
> > on the hardlockup detector with "/proc/nmi_watchdog".
>
> It is not hard but:
> 1) it means whenever perf wants to determine the NMI watchdog is
> present it needs to read two files rather than the existing 1, which
> has some runtime cost;
> 2) the name nmi_watchdog for controlling the behavior of the buddy
> watchdog isn't intention revealing as the buddy mechanisms whole point
> is to avoid the NMI;

The buddy mechanism is to avoid the use of a perf counter, not an NMI
(non maskable interrupt). "NMI" !=3D "perf counter". Many types of
interrupts can be non-maskable (or pseudo-non-maskable). The buddy
lockup detector still uses an NMI (indirectly). Specifically, a
non-maskable IPI (NMI-backed IPI) is used to interrupt the other CPU.

You keep saying that perf wants to determine if the "NMI watchdog" is
present. That's not what it wants to know. It wants to know if the
hard lockup detector (which likely uses NMIs in some way) happens to
use up a perf event. If an NMI-backed hardlockup detector (presumably
like the one on PowerPC) wasn't using a perf counter then perf
wouldn't care.


> 3) old perf tools with the buddy watchdog have the wrong behavior
> (they've regressed).
>
> It is also not hard to have the watchdog files named
> <mechanism>_watchdog, such as buddy_watchdog, nmi_watchdog,
> arch_watchdog and have the contents be 0 or 1 as appropriate. Such a
> scheme would have less overhead for perf, make the name more intention
> revealing and not alter old perf tools. I'm really not sure what
> problem we're trying to fix by not adopting this approach. I was
> surprised the buddy watchdog merged but using the nmi_watchdog file.

The buddy watchdog was pretty much following the conventions that were
already in the code: that the hardlockup detector (whether backed by
perf or not) was essentially called the "nmi watchdog". There were a
number of people that were involved in reviews and I don't believe
suggesting creating a whole different mechanism for enabling /
disabling the buddy watchdog was never suggested.
-Doug
