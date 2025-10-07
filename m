Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4A168BD
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759798825; cv=none; b=ivlzwbqkO2OqK6rhXdb1DaYwhEzFrOJLcDceCo8dnqSU5DHfVYzszphoo0hDyHd946qrEWbg3R7VdymUEJ2xHUr7pYkgUGXXFvhfZW4+Eg0eNcA/d9Ln82HSIMHOtj7alIfqi4E5bazd2xiQpJNwRRt0ePIHM6ZuoRxGqI/bQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759798825; c=relaxed/simple;
	bh=hfCTUH5fhwUXuwcET/5y6JZBqUWUAPXoD5VFTZ/Rd8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbBrq4mVtU7GsWzcTfwZ9QWTM2zreCt2ZVAKxKJgqhnXitTreV7Q0LhViG4naRUxwVPOe/mN+cdq/77SHz+BsquaS2hYt5B3yYpEPe9PAnyZ4ntjYd6NTy2ryZML7Nl2rw64XLx3dHmXhTyPAbeLkdpXdT3hAvxV9lu0y3LiniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlH8FiCQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlH8FiCQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d67abd215so112015ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759798823; x=1760403623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6mQHeLbc51hD/eXve78YPM4+TxG0628utfcdDhF6wI=;
        b=HlH8FiCQ1u3nO4Qkx1jOkzUB98XMmG1c2ITSwdoWuQ25Ci+cU6zuNQnGmjWyRqffIN
         9TuWXYte5QAS6mz6DEqQvSHHlbgiIJ9z2SGll+c8ECHiLqjOqGnV8iYwg+dMoQrQeNUU
         93ECKLI+GlfBt/HpU0gUeUCoqg4MIHoddh69NU6Z9Y/zyrTZxHuTjpcyddvoP0zJzdao
         WfcK3+wCL1K3RUW1CEy0WGhwDYkKKIUE81Au1zmVlKq72WeES7OSFfCBnlyafCr9qAEm
         8tkt3I0Ka9uYH7317oMCGvFUtkqKF6yjYtQx7x6eKw0mupfnlWuEvM6OwKRYafYXomPl
         rqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759798823; x=1760403623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6mQHeLbc51hD/eXve78YPM4+TxG0628utfcdDhF6wI=;
        b=TPDt5gutHa/A16CGks41I0GVqs6OTZo/pvFyLkqwDWuf6DPdLd8BnV6qhCcfpzmI9X
         KCLTBIXApFOA8+Pb+H3jFdTmaAyzniXoMm3N7R076S396smg6EoPD3FnnFMXzro+Pt3O
         syp/UJNa9ULrJnp77tKvIIr6ltSRy1WXLe/pabMKHPt+c7SUvzP+9LVxCQlu870r/Vhu
         FXpuGNGITBE9TQW5FPZwOOSyOKBvRPhmcCZKh4EO0A/Nu1FjLi8Rq+ghA3Z9FZ2w64ak
         QlcqMpwNktdK3LhPr7ODmvbH+xD/u8vbmKP26IsoIF+zhlp3pOoaz95+52GSqvkcC5xH
         ztHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg45QRANUKmK852+X3yWqdKGhfJWIc5mOkyMXthJ94Ecc2Zn5vGFPI/EM9TeAqpVUeeyDVliL528u4yAMPr3Wv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3odFo+sQPtJEGcDFKiQ8nzqayalqse6k3kJbEW8GgbZneqas
	bHTBkZ6MHD8kGDqk901n8+R4Mp+DXZZ8jW/RkV5n6ywuvoGZpbqW0w3MM5W/f4dfYvoiRFAxRqI
	Zd5sBa7pemxlhYn2xBLJnh42Bk2jWgqYTpPs4OgBP
X-Gm-Gg: ASbGnctAuugPI8HwbWjIeMflLxzVr4FS48Tv0IDaqsEpt6dy1K73O/i1eGWMtfTZpLi
	Z70TQ0Uhz6/cc5Q6o3qZdGF/wdssZdV3a3+Y5a514nHHU3GnINQjn5/ArEaxEniWSOEzhuvu+uZ
	W4bNI+q6WXssDL8y7SpKQO2MN8VWkEyTwG6DOESWJMGRKLp+y0S3aAfrPD3+SnJGnUeGQgZ8aYl
	/7Ypyv8hzQ+4nXlalj63t+ToONdZNvIzf+V41sZ4j1275uGtmCV0CmNH8diQ4dd9T3KNbs=
X-Google-Smtp-Source: AGHT+IGtKqlcr/X53YFNFTKkWMvGJGQM0ey7+a031TD49SZJiyKQEgCc9CJhuov2G46Tt8YqmZ9/Z/qPCT8m39Nszs0=
X-Received: by 2002:a17:903:298d:b0:267:912b:2b4d with SMTP id
 d9443c01a7336-28ecb74c0e7mr1431545ad.7.1759798822443; Mon, 06 Oct 2025
 18:00:22 -0700 (PDT)
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
In-Reply-To: <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 18:00:09 -0700
X-Gm-Features: AS18NWDGLlvOhtxIZkpVyFf6Sm7S3dsd_RTNVJ4XYO9x6ozGHkZMxjn7T41Jhr4
Message-ID: <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Doug Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Oct 6, 2025 at 4:32=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Mon, Oct 6, 2025 at 2:30=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Tue, Sep 16, 2025 at 11:14=E2=80=AFPM Jinchao Wang <wangjinchao600@g=
mail.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 10:35:46PM -0700, Namhyung Kim wrote:
> > > > Hello,
> > > >
> > > > On Tue, Sep 16, 2025 at 10:13:12PM -0700, Ian Rogers wrote:
> > > > > On Tue, Sep 16, 2025 at 6:47=E2=80=AFPM Jinchao Wang <wangjinchao=
600@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 16, 2025 at 05:03:48PM -0700, Ian Rogers wrote:
> > > > > > > On Tue, Sep 16, 2025 at 7:51=E2=80=AFAM Jinchao Wang <wangjin=
chao600@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Currently, the hard lockup detector is selected at compile =
time via
> > > > > > > > Kconfig, which requires a kernel rebuild to switch implemen=
tations.
> > > > > > > > This is inflexible, especially on systems where a perf even=
t may not
> > > > > > > > be available or may be needed for other tasks.
> > > > > > > >
> > > > > > > > This commit refactors the hard lockup detector to replace a=
 rigid
> > > > > > > > compile-time choice with a flexible build-time and boot-tim=
e solution.
> > > > > > > > The patch supports building the kernel with either detector
> > > > > > > > independently, or with both. When both are built, a new boo=
t parameter
> > > > > > > > `hardlockup_detector=3D"perf|buddy"` allows the selection a=
t boot time.
> > > > > > > > This is a more robust and user-friendly design.
> > > > > > > >
> > > > > > > > This patch is a follow-up to the discussion on the kernel m=
ailing list
> > > > > > > > regarding the preference and future of the hard lockup dete=
ctors. It
> > > > > > > > implements a flexible solution that addresses the community=
's need to
> > > > > > > > select an appropriate detector at boot time.
> > > > > > > >
> > > > > > > > The core changes are:
> > > > > > > > - The `perf` and `buddy` watchdog implementations are separ=
ated into
> > > > > > > >   distinct functions (e.g., `watchdog_perf_hardlockup_enabl=
e`).
> > > > > > > > - Global function pointers are introduced (`watchdog_hardlo=
ckup_enable_ptr`)
> > > > > > > >   to serve as a single API for the entire feature.
> > > > > > > > - A new `hardlockup_detector=3D` boot parameter is added to=
 allow the
> > > > > > > >   user to select the desired detector at boot time.
> > > > > > > > - The Kconfig options are simplified by removing the comple=
x
> > > > > > > >   `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both dete=
ctors to be
> > > > > > > >   built without mutual exclusion.
> > > > > > > > - The weak stubs are updated to call the new function point=
ers,
> > > > > > > >   centralizing the watchdog logic.
> > > > > > >
> > > > > > > What is the impact on  /proc/sys/kernel/nmi_watchdog ? Is tha=
t
> > > > > > > enabling and disabling whatever the boot time choice was? I'm=
 not sure
> > > > > > > why this has to be a boot time option given the ability to co=
nfigure
> > > > > > > via /proc/sys/kernel/nmi_watchdog.
> > > > > > The new hardlockup_detector boot parameter and the existing
> > > > > > /proc/sys/kernel/nmi_watchdog file serve different purposes.
> > > > > >
> > > > > > The boot parameter selects the type of hard lockup detector (pe=
rf or buddy).
> > > > > > This choice is made once at boot.
> > > > > >
> > > > > >  /proc/sys/kernel/nmi_watchdog, on the other hand, is only a si=
mple on/off
> > > > > > switch for the currently selected detector. It does not change =
the detector's
> > > > > > type.
> > > > >
> > > > > So the name "nmi_watchdog" for the buddy watchdog is wrong for fa=
irly
> > > > > obvious naming reasons but also because we can't differentiate wh=
en a
> > > > > perf event has been taken or not - this impacts perf that is choo=
sing
> > > > > not to group events in metrics because of it, reducing the metric=
's
> > > > > accuracy. We need an equivalent "buddy_watchdog" file to the
> > > > > "nmi_watchdog" file. If we have such a file then if I did "echo 1=
 >
> > > > > /proc/sys/kernel/nmi_watchdog" I'd expect the buddy watchdog to b=
e
> > > > > disabled and the perf event one to be enabled. Similarly, if I di=
d
> > > > > "echo 1 > /proc/sys/kernel/buddy_watchdog" then I would expect th=
e
> > > > > perf event watchdog to be disabled and the buddy one enabled. If =
I did
> > > > >  "echo 0 > /proc/sys/kernel/nmi_watchdog; echo 0 >
> > > > > /proc/sys/kernel/buddy_watchdog" then I'd expect neither to be
> > > > > enabled. I don't see why choosing the type of watchdog implementa=
tion
> > > > > at boot time is particularly desirable. It seems sensible to defa=
ult
> > > > > normal people to using the buddy watchdog (more perf events, powe=
r...)
> > > > > and  CONFIG_DEBUG_KERNEL type people to using the perf event one.=
 As
> > > > > the "nmi_watchdog" file may be assumed to control the buddy watch=
dog,
> > > > > perhaps a compatibility option (where the "nmi_watchdog" file con=
trols
> > > > > the buddy watchdog) is needed so that user code has time to migra=
te.
> > > >
> > > > Sounds good to me.  For perf tools, it'd be great if we can have a =
run-
> > > > time check which watchdog is selected.
> > > Considering backward compatibility, I prefer to keep
> > > /proc/sys/kernel/nmi_watchdog and introduce a new file called
> > > /proc/sys/kernel/hardlockup_detector_type, which only shows the defau=
lt string
> > > or the boot parameter.
> >
> > Is there code using the buddy watchdog that cares about the
> > /proc/sys/kernel/nmi_watchdog file? My assumption is that everything
> > except Android is using the NMI watchdog, so a new
> > /proc/sys/kernel/buddy_watchdog file doesn't impact them.
>
> Buddy watchdog has been out there for a few years. At Google, I know
> it's used by everything except Android. AKA I believe it is used in
> Google's servers and also in ChromeOS. Both of those (presumably)
> enable the buddy watchdog via calling it "nmi_watchdog". It's possible
> that some Android phones are using the buddy watchdog too but I'm not
> aware of it. I don't believe Pixel is using it, though that could
> change in the future.

I thought what motivated the buddy watchdog was patches implementing
this approach on Android for ARM that lacked an NMI based hard lockup
detector?
Anyway, while the buddy watchdog is in use by Google servers the
nmi_watchdog file has an actively detrimental effect on that.
Specifically the nmi_watchdog file having the value of "1" disables
certain event groups for certain metrics in the perf tool as it is
assumed there are too few performance counters due to the NMI watchdog
stealing one. We want groups of events so that events are scheduled
together and metrics are more accurate, we don't want groups that fail
to schedule because of a lack of counters.

> IMO at this point "nmi watchdog" is simply a synonym for the
> hardlockup detector. That was what it looked like in the code before I
> started messing around and adding the buddy lockup detector and it's
> how it is now. While it's unfortunate that there are two names for the
> same thing, I don't personally think that should change at this point.
> FWIW, even the "buddy" watchdog relies on NMIs to actually get stack
> crawls on stuck cores, so NMI still means something even there.

I think this is misguided. Currently the only use of nmi_watchdog I'm
aware of is by perf where the buddy watchdog's use of it causes issues
(as mentioned above).

> If we want to tell between the perf detector or the buddy detector we
> should add a separate file for it.

We could with perf then having to read from two files rather than one.
Presumably the lack of presence of one file will be sufficient to also
avoid a kernel version check.

> > On Android
> > writing to /proc/sys/kernel/nmi_watchdog would switch from updating
> > the buddy watchdog enable/disable to the NMI watchdog enable/disable,
> > but it is a straightforward patch to make anything doing this update
> > the buddy_watchdog file instead.
>
> Straightforward, but you've got to go find everyone that you break by
> doing this. That's not something I want responsibility for. If you
> want to convince others this is something worthwhile and you've got
> someone signed up to deal with the fallout (if any) then I won't
> object, but it's not something I'd be in support of.

Stuff like this happens, check out this thread:
https://lore.kernel.org/lkml/2025020304-chip-trench-4e56@gregkh/
Imo we shouldn't design in using an actively misleading file name and
incurring extra overhead in perf. Having two files nmi_watchdog and
buddy_watchdog is fine as the latter case currently isn't in
mainstream distro use and people shouldn't care. It also maintains and
correct's perf's behavior when the buddy and not nmi watchdog is in
use.

> > If we have to keep "nmi_watchdog" then we should deprecate it and
> > create an equivalent file with a better name (ie without NMI in it).
> > It'll be moderately annoying in perf to determine whether the NMI
> > watchdog is enabled by having to read two files.
>
> Again, up to you if you want to try to do this, but I'm not really in
> support of it. It doesn't seem terribly hard to make a new file that
> says which hardlockup detector is in use. If that file exists then
> read it. If not then you fallback to what you have today.

I don't mind a file that also says what kind of lockup detector is in
use. I'd like the meaning of nmi_watchdog to keep meaning the kernel
stole a perf counter as this is the behavior long assumed by perf
which I think is the majority or only user of the file. I think the
buddy watchdog being controlled by this file is less than intention
revealing.

Thanks,
Ian

> -Doug
