Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05951B87EB
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918042; cv=none; b=fJM5/pXPm5Kjc1CKSI7+i14OwHYklZkFBHAyA1/HKV4fdoztu0+lZlO3WIcnadF3QR4OVHxCIklASao1TaG81OKMLHF0b2IuEEeb88NbViK9k7xXSB2pb2ORMWW7hYokZhad42KUOJSFMgq0AAxWo//nm/tWDVNijtLVEWOg6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918042; c=relaxed/simple;
	bh=LMr3mAVEp9T0899OdsHcYNuOQbKwWhoX8JpQNIYLZ+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eegnbYZtCXjnpJXFcMn1e3mSrYjC3/yIyj2LdFAld3XaVDSZ7dDLHuGTW5E2kPGF3Vx5F4/w/0slBRejfhDULjnOFd6oFA9bbF7SetPtUwl/MYwu4fO3ZdkebSQOioG9FTzAXdh/ZBlesAyRKPBMdqNSzWTP0pRA3yf3JypOk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDh0iWYQ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDh0iWYQ"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d2ad29f630so175855ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 14:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739918040; x=1740522840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/cgij1lFdZqKfhJzvdkh7LmAc2T325VXWYvJrhG6fY=;
        b=oDh0iWYQRl2y+GBgwCET+eh4ecnW7iVY77Dsnn76nyKeV8bCkR2JJk3ll47VX4r+wb
         bza3Wy8vKeeWSu0wuyeEu2RDuRdMym6Za6kRwB5WgsCu3GMBb2NVyoDEHNDZZdJihhOP
         3YGJsaNy/Rrk6XdXZ5VPLTmfUNYP59jsEt2QlirZwOPBNrTDPZr+t/sk9sq0PU2PV2Od
         jqLlzSXQ71PasDFriIHi0Mtz8xDDgqUMJXdobwUv1mSMdK9tA7TIC5Q7Q8xFAouApiqt
         wihFAAyEST2b423lZr3n250/+gZ5iYsnPVNBWS59cIYmOfQo7qGEnRLWgxSnfTXDRcEi
         1jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918040; x=1740522840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/cgij1lFdZqKfhJzvdkh7LmAc2T325VXWYvJrhG6fY=;
        b=P061PHxKQezMMWNrRtzo6rGrTtEk0aYhebdpGgGhmnkCDfnVurKqGBeQQ2xIHzSNMb
         rc510Cq9Q3t7QbAhls4+VQxgdTLlFhEnniYeB6G0WBjF2V356FL8KGVlwi3gXlCf6lSs
         Ir6sqVWiCwGkfg+1HhrDT4Pyja1hWfZjmfircjcHsueiAFFoj4VQAq8X5cKdCwBsx3a0
         bM9e/V6sjrH5HqTdnNis34BKioRpMdLRbGoQw5J6uMum9it0Ln13O+YfKZo3+0Bq+2JF
         UoEhjVpn5Tzk8oDqSN6mfh9tlFjz1wLkwZQSv1pUse7iJPmbprjsT6L0UHNst9rbSkw4
         qzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx6gKB4cmPVO/RaR8JZojnU3XA98GSEWB5gUhzZBaQCd5Rtv21MHPxU2riKoNtllaRR8INO/5MxSqYp1oqlm5k@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8jaCl1ROpJFCQB2ub6Sfd/Hb970hoy01x9kapyQWO77gle2E
	Wf2+HD2Zin7mCidqr0EF5IrtR5ODKd2t8nfu4EYFSpXZhpDFYFuwTwQ0p628jUZEovHWzktFKRd
	zdL5jjsFYiXojN8+ZheFfNZ8O/Umc59JQPVJd
X-Gm-Gg: ASbGncthaNy7KTCa/KFOuW6SFemsPr08TjU8weYa8TUSv8zadZ/lI7TBya55UVRwgcY
	B3jQVEBMBE4tEUPfBjmOYixev0kmXLylyvQblnt5shvEL2P2p7rDIGRJxx/aj8R9oj+7FrRZ1y/
	cFKFhKdXFxPs88/lUjh7CFgxri
X-Google-Smtp-Source: AGHT+IHw3DoO4qf0xpi1Amzv3pmc+X9SJTYSaoh3aiUz35JKe6rXdAzYIXkiqfdS7Bg/GHnOCWs6r2oDH8RnN6nJDDg=
X-Received: by 2002:a05:6e02:3287:b0:3d1:7971:e6d5 with SMTP id
 e9e14a558f8ab-3d2b6236f8amr1406365ab.0.1739918039639; Tue, 18 Feb 2025
 14:33:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com> <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
 <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org> <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
 <fe46069e-c52e-45ee-b4b3-8b929fb83b31@linaro.org> <Z7UHieRRnvRb5_oU@google.com>
In-Reply-To: <Z7UHieRRnvRb5_oU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Feb 2025 14:33:47 -0800
X-Gm-Features: AWEUYZnCIRZ8gA78AOy7d6LlsQyiSAxYf8f5kf90YgWTOUXfQDLRg9JD7T1vwFY
Message-ID: <CAP-5=fWXmNoFLyWv+vo7hhLSqTDy7hf+-huKRD9OUWnO-GESRw@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520 events/metrics
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Yangyu Chen <cyy@cyyself.name>, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Feb 18, 2025 at 09:30:23AM +0000, James Clark wrote:
> >
> >
> > On 18/02/2025 12:41 am, Ian Rogers wrote:
> > > On Fri, Feb 14, 2025 at 2:02=E2=80=AFAM James Clark <james.clark@lina=
ro.org> wrote:
> > > >
> > > >
> > > >
> > > > On 14/02/2025 5:49 am, Yangyu Chen wrote:
> > > > >
> > > > >
> > > > > > On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wr=
ote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
> > > > > > > This patchset adds the perf JSON files for the Cortex-A720 an=
d Cortex-A520
> > > > > > > processors. Some events have been tested on Raxda Orion 6 wit=
h Cix P1 SoC
> > > > > > > (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
> > > > > >
> > > > > > I'm curious how the name of PMUs look like.  It is cortex_a720 =
(or a520)?
> > > > >
> > > > > The name of PMUs comes from Arm's documentation. I have included =
these
> > > > > links in each patch.
> > > > >
> > > > > > I remember there's a logic to check the length of hex digits at=
 the end.
> > > > > >
> > > > >
> > > > > Could you provide more details about this?
> > > > >
> > > > > > Ian, are you ok with this?
> > > > > >
> > > >
> > > > I think they wouldn't be merged because they're core PMUs, so shoul=
d be
> > > > fine? Even though they would otherwise be merged because they're mo=
re
> > > > than 3 hex digits.
> > >
> > > Do we know the PMU names? If they are cortex_a520 and cortex_a720 the=
n
> >
> > It will be "armv9_cortex_a720" from this line:
> >
> >   PMUV3_INIT_SIMPLE(armv9_cortex_a720)
>
> I see, thanks!
>
> >
> > > this comment at least reads a little stale:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmus.c?h=3Dperf-tools-next#n76
> > > ```
> > > /*
> > > * There is a '_{num}' suffix. For decimal suffixes any length
> > > * will do, for hexadecimal ensure more than 2 hex digits so
> > > * that S390's cpum_cf PMU doesn't match.
> > > */
> > > ```
> > > James is right that core PMUs aren't put on the same list as uncore/o=
ther PMUs.
>
> Ok, then I guess we're good.

I think you may be able to do things that look odd, like today the
"i915" PMU can be called just "i", I think the a520/a720 naming will
allow "armv9_cortex/cycles/" as an event name, then open it on two
PMUs if they are present. We may only show one PMU in perf list as
that code I think assumes they're the same PMU as they only differ by
suffix:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n384
I can imagine aggregation possibly being broken, but I think that
works off the number of PMUs not the names of the PMUs, so it should
be okay. Probably the only thing broken that matter is perf list when
you have a BIG.little system with a520 and a720, this may be broken
with say a a53 and a72 today as both of those suffix lengths are >2,
but maybe they use the "armv8._pmuv3_0", "armv8._pmuv3_1", etc. naming
convention. I suspect the >2 here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n80
would still work and be correct if it were >4. If that changes then
this will also need to change:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/Documentation/ABI/testing/sysfs-bus-event_source-devices?h=3Dperf-tools-=
next#n12

Thanks,
Ian

>
> Thanks,
> Namhyung
>
