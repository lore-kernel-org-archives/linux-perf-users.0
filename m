Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA42241686
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766543031; cv=none; b=eeOQSnW+6L3p4cnYZJibZW2L0tPWaOZY0G/QFKC1jOd8FpUMNC6cLLxPU8IRhrouMkWugmoDPvuyNdUqX0G7jNgLm0n3YyMJO7ujn/Nik2w7FdvGKZPxkjSDS6OE0eueLBB6/4Q8YOEqtNcttUtMj3ulx0BRgB7HHwfaEQDuMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766543031; c=relaxed/simple;
	bh=zk2WY1AiP6+Enag8N49LVZry6SGV//pbiK4zYmkTNrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF5pUJCSNRmq0gqOjP86bCfONFM5cxauOE5JGd7MDdffZMWjAlA4RdijBUqbFqdJnQD05inFHLyThGJGlhZ5m3lNxIWT7Ut0Sivr1eLtUdtFYs22QmOcDiWtUgt/oTrDis38kFI2XA2FZpNcUaQVmRwvReikvplIkYUKwOGEIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=2ixzSADd; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="2ixzSADd"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c75b829eb6so3487134a34.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 18:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1766543028; x=1767147828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQixqKOyVSO+r3jnB1Wmiy1Ta+YjO+y7aLMg2T41hO4=;
        b=2ixzSADd6Z4pFf127i8kKhxURsvBmnv2TPZWpmMcmw9Djt1/TFLCuhX5g7PG527s55
         zj3YAyFHv9Fta6xGosAPO6UlNIoEkZjgexavS2tMdCm4wGjsWBOJVo4diYF0jRlRxafj
         Cslj+5FoCXYAMLt9jprVzC+uePlfjc0r4nILRPdLgU/ioVtNLxIIKUy2Ql4EzLEC0ChE
         wr8LFHiMvcypoZlKkBx+lf7T7Jz0KKIFdXlXIbrD2Ocektd6UV5EHd9KbtIqSVdp45Ll
         zHi06r6kmooa7o3E2RfhzXxO2RypTSy5dAQldqEBnwpIzJQ/f/1HjrJBIuqMci/SckvS
         PHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766543028; x=1767147828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQixqKOyVSO+r3jnB1Wmiy1Ta+YjO+y7aLMg2T41hO4=;
        b=fdOZav3HPKPpARvxkJAaT0AUZaMI06KEFfBhRZqUrI1n9dcepp2XqUETTEPkfv3rG/
         2xfsZPMZBzr4rbZ3CRtOpBNs96ipD5hsEh9JKGLKKi6nmEP1uqevBMayy2h4OBsnoKm5
         q7uYJ5yrhzm4PdCQ+VuqzryIimOJqE0GMMxwuc4KW53IscuyY3ivowrX2fvLszxnGoqr
         FstNae4k7RZnK0we5zxswoq7e86KxMAmyxNqWe/o53dMXO1I3oF9wNN3CoqirFqoYc0b
         iO4Vs3+J1E+qkQFAWmCMFB3nTcg/UujiYn9YvYXO571/y5wR5owb9y58VdoBM4viFAS4
         hZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmvdSBJQdNvEUj1vijDyGaBZRFCh5EIVIanQUdbuEIDPutdMc0NOfumZIZ791YjMpvCERW29A/2VCjQhuCqdrN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9MOXCogYQS2tl2ychThmJFxFgJJFAyLAZ7em3Uv9X2gQgKW9
	Fd4eUrII28Pfshfw1LsklsVvzrVsw9ezRGJNVNWssjuVIk3E+yP64Yp2FHusV2t/fpXfrBJ+dkC
	NmrXi9dgg+kM0ykTlAs2jlgJbqi+E2waMBc41+d6ueg==
X-Gm-Gg: AY/fxX4uLDZdDcW9BKrPhMZIUMoDyDtk6T2t51tZlpzVhVD0bDrXHvLcXZD3a2HB0UX
	WL5R001pkY48n7u6T+O8kJ/Tc97LPP7CcG5gu3Qe1U/+tjIbwQPaqBib64/dYtD/i+alF9Lz64T
	L+tpnpaM0pC40M8XeKTzURL1GAnS0nRr8wDkbrUIbWWNKr1IObyXae/X5Y69c+WjvslshGgfbSz
	sjOso801hElUeMTdms5oRNh6UjA1fd2gMWaWFSO0jsYkMQ0DC5HNOmww64exTdaxsvxEAU=
X-Google-Smtp-Source: AGHT+IHN2civLTCc8OOGxCDTZrlICoPRHL6fnJTMV7DoL+8l67a47RNYQ2VMW9dpQtDiRbLHeDPM6PD/ovwFcD3u9Dc=
X-Received: by 2002:a05:6830:3154:b0:7c1:12c5:334e with SMTP id
 46e09a7af769-7cc66a023c7mr10318927a34.17.1766543028236; Tue, 23 Dec 2025
 18:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3u-5gjxsFbnimP0mMFM6GRki7TAfNe6YmY6KtJhApV45nSNw@mail.gmail.com>
 <CAP-5=fVndu7gOVSzH=jKtsNLQk=Asv_OZNaEQ8nPXoUKWE8izg@mail.gmail.com>
 <CAK3u-5gfzAR5RDicyqaUi9ddZSbD=JkYN-K--iD4wCMCqFKF=w@mail.gmail.com> <aSdPUOz6gqInzJdR@google.com>
In-Reply-To: <aSdPUOz6gqInzJdR@google.com>
From: Shimin Guo <shimin.guo@skydio.com>
Date: Tue, 23 Dec 2025 18:23:37 -0800
X-Gm-Features: AQt7F2qbE54_X7h-aFmrw0wHu1JDH4k3xzgbV2i-k9Qii9rCfrmAu_TJ2lOKB1Y
Message-ID: <CAK3u-5gBQ3GGTNx4Pj8UPgFguKfOnOHLvKPXnTu42Z-XDCJJ6A@mail.gmail.com>
Subject: Re: [BUG] perf: libdw not working for data collected on a different
 arch than host
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:04=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Tue, Nov 25, 2025 at 06:55:54PM -0800, Shimin Guo wrote:
> > On Tue, Nov 25, 2025 at 5:43=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Mon, Nov 24, 2025 at 10:39=E2=80=AFAM Shimin Guo <shimin.guo@skydi=
o.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I see there have been patches aimed at enabling perf to unwind stac=
ks
> > > > collected on a different arch than the host perf itself is running =
on,
> > > > for example, https://lore.kernel.org/all/20230606014559.21783-4-leo=
.yan@linaro.org/.
> > > >
> > > > I believe there is still one issue that prevents me from doing
> > > > unwinding on arm64 stacks on a x86 host. As of v6.18-rc6, I still s=
ee
> > > > the following in tools/perf/util/unwind-libdw.c:
> > > >
> > > > static const Dwfl_Thread_Callbacks callbacks =3D {
> > > >     .next_thread =3D next_thread,
> > > >     .memory_read =3D memory_read,
> > > >     .set_initial_registers =3D libdw__arch_set_initial_registers,
> > > > };
> > > >
> > > > libdw__arch_set_initial_registers is defined for each architecture,
> > > > and the version is chosen at compile time, not for the arch the dat=
a
> > > > is collected on. After fixing this issue, I was able to get the cal=
l
> > > > chains. Is my analysis correct?
> > >
> > > Hi Shimin,
> > >
> > > I think your analysis is correct. I've been trying to clean up other
> > > cases of this, such as with dwarf_regs:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/log/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next
> > > Or with syscalltbl:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/commit/tools/perf/util/syscalltbl.c?h=3Dperf-tools-next&id=3D1470ea=
a574870da3f78942927b15e0b75da3ffbe
> > >
> > > My belief is the arch directory is a code smell where we've most
> > > likely broken cross-architecture support. Were you in the process of
> > > putting together a patch series to fix this? My hope is to move away
> > > from the CPUID feature strings for things like this and just use ELF
> > > values like EM_X86_64.
> >
> > I don't have immediate plans to put together a patch series. I'm not
> > familiar with the Linux development process, coding standards, and
> > common practices. Conceptually it's not that complicated, but whatever
> > I come up with is likely not the best way to do it.
>
> That's fine, we can find the best way during the review process if
> you're willing to. :)

OK, I gave it a shot at
https://lore.kernel.org/linux-perf-users/20251223-cross-arch-unwind-v1-1-4d=
71ee7db512@skydio.com/T/#u

-shimin

>
> Thanks,
> Namhyung
>
