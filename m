Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73714EA3
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jan 2024 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705732289; cv=none; b=g6k2sblLSnuIgaOzOt82PcUfyb/P48l6W12AsEGx9ssGqzinxvyjIxvZx0eVi669TEw3tJ05IwSWakhMGH36i7DCoB/4kCnEL88HP/XdwmESU3z2PiuxS7l9IfTpdN6+33EC6NPiFMJDBklRs+xKn6JVB8SepxqRl3BK2gSGl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705732289; c=relaxed/simple;
	bh=HQPG5CYuhZnVq2tw7DjnmORSE6UQJxygdXMEgyIzhPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q79abc47imGol+v1MuhSOQJu9woe3dhfYTOYF/sojIuzyBhrG7yV0l5Nh34gMjLSizs3+3TOBC7jwe+SthAns6KgckVLjeA6px9IRVVEBjXwp5eMTzZjYWBtTB/grjDYrRnfnA1zVgtgTS821MMxutm7dU8MnxRAhsD/YBSWt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKK7tV8e; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKK7tV8e"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-361b23b9328so56765ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 22:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705732287; x=1706337087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHKfgCsJrRpTNZ4Z1JCGgdfo83odYf4yZ8h8YSNbSyk=;
        b=uKK7tV8eVCvj5wQRNnPAgiowh9EvzfWY4riOqC38tE9rVBk1+hQYpRNM75n3YWkxn/
         qBjOsWE/egZTL/zqhSrf1m0IFVxgcwSh6HrKSp8hWlEEiqKlDCYxk5UE36dKO74PbVOI
         aAn9SOALm5oxYuOMJ4ATklQ6iQVGz7eE//ZPIdZZwOiinE6vjUVa4utTnJ0s++XQ9ACg
         PGEdN3xBkHLLN/o+Z3GB24CavqQhgbtE9UA+GgKY/fDLxsVqGByU47Fvsw+1LxbuvS6K
         emdJWiPDktHnn/79QP+3TlBjiIgb+AYt1156Sofcfy5gbla7bqlkYswbHXWnp1nhHr9p
         qowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705732287; x=1706337087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHKfgCsJrRpTNZ4Z1JCGgdfo83odYf4yZ8h8YSNbSyk=;
        b=oR4HHNplZcGHGwWYqWh+MpZMOpcVICHPsS93nVqopzvin2bdvfsTJmilWyc2+6naj+
         DvaXt4NwSbOhJFGz7fpy/QoLu8sDGY1kYetkUlF8ISfSp/LT/4goVNZGBZ1RX54Yyhuq
         +LcofwrPuQuL9Whe1MbbXnCWIoaPJG/8ZYmr81rWLvRTD/7yr7zhW0obpb556yQfm0G/
         qY+QOJWdaf6p30QLktzUFq/Og/R8/hdgh8gCqBWeT/qscwBl8nvL6q+PthDh7gNnPMPn
         W4xzw/Bbn1gPunAq736vTHMVqvTaCtcKF8DDeWWFTCACBbUtoG8fj+wzTznJklFZMjTA
         MCHQ==
X-Gm-Message-State: AOJu0Yys1CqUBiKqcEVb6D7CoYq7bQNzvYQFNwMcS3eUARHmk3NUnrxy
	ioYBSGWLmMI4aPSe5v2kAGaXciD/bQn4ToV+ROZFIyXF2LcX
X-Google-Smtp-Source: AGHT+IFLrR2I2qWq6jPWU/VUfmvu4fmiopvbw6UFrCxsVVwfkijPvAqxFiFMWs3DBunI2Z0RHVcsXJyeQPmemGmOyDI=
X-Received: by 2002:a92:d3ca:0:b0:360:a34a:e589 with SMTP id
 c10-20020a92d3ca000000b00360a34ae589mr53379ilh.6.1705732287378; Fri, 19 Jan
 2024 22:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
 <CAM9d7cjgu=Ec0Hd83sn=LkHrHBGciCev=tE1vRKFMhzNo4xipg@mail.gmail.com> <CAP-5=fUA39pwG+RaL5ZN3gFzemvTEAnw8EgQAeHGGGBAOqNu6w@mail.gmail.com>
In-Reply-To: <CAP-5=fUA39pwG+RaL5ZN3gFzemvTEAnw8EgQAeHGGGBAOqNu6w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Jan 2024 22:31:14 -0800
Message-ID: <CAP-5=fWM5MWbqYUSEwzmY2MjKc2_3qvaAVUcz7s-M3v19YSFow@mail.gmail.com>
Subject: Re: Issues with Linux perf tool on Raspberry Pi 5
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 8:27=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jan 19, 2024 at 4:55=E2=80=AFPM Namhyung Kim <namhyung@gmail.com>=
 wrote:
> >
> > Hi Ian,
> >
> > On Fri, Jan 19, 2024 at 3:40=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > I thought I'd report the state of Linux perf tests on Raspberry Pi 5
> > > and so I opened a bug because of the number of failures. I'm happy fo=
r
> > > help resolving the issues. The bug is:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D218401
> >
> > Thanks for doing this.  I've looked at the error log and found
> > it had a failure in loading BTF.  Maybe the system setup is
> > more or less broken..?
>
> I think so. Looks like the kernel was built with CONFIG_DEBUG_INFO_BTF di=
sabled:
> https://forums.raspberrypi.com/viewtopic.php?t=3D349411
> They also package libbpf-tools and those tools fail in the same way.
>
> I think the fix is to update the bcm2712_defconfig:
> https://www.raspberrypi.com/documentation/computers/linux_kernel.html
> https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm64/configs/bc=
m2712_defconfig
>
> It is kind of a shame this option is opt-in rather than opt-out. I
> wonder if there is something we should do to diagnose and help users
> who may have a BTF disabled kernel.

Rebuilding the kernel with CONFIG_DEBUG_INFO_BTF fixes kernel lock
contention analysis and perf record offcpu profiling tests.

Thanks,
Ian
