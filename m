Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB02BFC7B
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845220; cv=pass; b=sBeRihHnB1TNXrxtxROFc8zeZvHz1PUZ7DpEbc3BqWk4uCq9v9cRZkXPl/c/E2b9j874fSocWDatSog7TlfTBPFkYzcfpx05VdJ08MKK5ajGI2eW+SEZrLsZjs7k4JUzjwQR2Gkgo8DhT1NBe072ouExLnQpRHVRF6ahvIoBDAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845220; c=relaxed/simple;
	bh=RhPTPbxOil0nNbcCTe++QZ3I591tZ3jVFSRYtTAyr8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS/E8PFsvbC48B6VtBFTPM62vmiL/tdMfTFbGw0clQCatyPP/TUotPK4emRvVlICt4ww5zoznTfTHAQgmHJm/JH3Cfk9DIO/kQ3hfwXZCwWsFV8wY6yAnYW0jNxr4RGEXCTBvqVv+4DmsUrvTETRSjaDqHcSHf0hGZ/V31klvWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lhJ0/cwF; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhJ0/cwF"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5337c7b9937so555141cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 15:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791845217; cv=none;
        d=google.com; s=arc-20260327;
        b=k/Mym9dtzsiLMlmKkFfzeQkAtMPmTEn9ul26GF8jVgHWEKAMI+nJw+r9uezg3u/CG0
         MByZc5NBQmUY0khgl91ijaasXrJlNdZ7YQbT1e5ai50dWZUknijvUWW0PQ9UtI7yTq8e
         nwGN7MJlHahBfz9neXnyEUFMVlbPqcSmiANar2SC6ryOL82vm0e3ZsY5bQ87nBSGLd8S
         lFS2t2Nk606l8z2cXSRFT7Tj45U6Fxy5vT6kCKsYyHGmbk76X7or05hiCIFUNCpL7tFW
         +ncwl8XHlblJxUnBYNF3+6UEeF+jNqeZmUVdcFweRIE1Uyqv6WQ6zYzKKQpgtgSYSQgw
         /Uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RhPTPbxOil0nNbcCTe++QZ3I591tZ3jVFSRYtTAyr8w=;
        fh=zSK7VzGSh8IM0xV7DqWR+dDuSjZlti9BxCNPZ2GeVTk=;
        b=dUPvTHBfcxipQZvSfQjj6UK7UyHFEWrfPmAH6PenVX9Vinhfp3lwRRiSht/IvRuZ/1
         h0YUBCJrMGFDAxwWv9W1ExrFDNhTbB5Dpz/dpQmWHCz66BJno0qP+VOrq5+CSM0Xiww+
         8+R0D3kb8gcnTAF0afwOLTyjK4VBUg2dyRLHW6E8PwJCWIlbxf9YjBvYrO520H1UvsYk
         IJ/lya1kJBZn7/RuyS1S/Rh9p8xBxCl18SHRiOlImAkXzlQu6kTe/ez87m7KPYBdSWFH
         ituyPyIEcPMrV7f+h8eLtbHPdplE7MDtGyT6BnBeYgv1jUOxDW5sKzDkcEOIVGpBWBEQ
         XPQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791845217; x=1792450017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RhPTPbxOil0nNbcCTe++QZ3I591tZ3jVFSRYtTAyr8w=;
        b=lhJ0/cwFdQWf/2bVpInNeLDhUOQEPN6t6y74mzPuTbwYM+UgFz6JtDLvGRy1rR6Jgl
         cu73rNvLL1FPRpVN16q0h7KmP9notVAbJJ2hiLzeXPiK4s9QiC1dw64NVWaDPIukNXad
         Mp7CrTjkpZnNcJ/Oefmkl43J6LpJx30Cv1w4je9ezMFE6uyBIeRNJsxlkqDmKYwk3rux
         kF9QeG5EdEjrls+fK1jM0ULhiNlIoPgJ1niF2AfPPct8HtbyXTeqZNOuemWLGKJ6Bkik
         e2VMVBBYYVmAhGBy2miI2ATfmR8VvoPoq0vWIhCPfGLQIm6pTK8+RHog+JYY82YeP0IE
         4q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791845217; x=1792450017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RhPTPbxOil0nNbcCTe++QZ3I591tZ3jVFSRYtTAyr8w=;
        b=jgV5or0PtFgjMzg1Ne7Iv48oXNt1D5rL44XavoVRmGtC2gzZNYG1cbVAg6UFOIpRw7
         1kleE1u0KYadhpXntT8Xd0SDZLwDYvdjR0hjgdohVOUYgWFNrDLP4lwcT228ePX9Fpg2
         dMzPeZyfcsX5cyUfrEmczEcx1ioxZkG6x30RMo/BeYWqnAKldbJQqHn+yM/ObzSIKqg3
         G9U8X7oJPWUV5uA99gs6D/mevwN9d/XAAJngmjqE4sypNhiHxTweMr7xX5m3PvcXZHwR
         vbQkLNF2336/g7vn2VXdhrUstpkKXqO4Ux9T7z03ZioaXZmtvGXSTv1iwKYOplkuj3mJ
         8jEA==
X-Forwarded-Encrypted: i=1; AKwUvBx3oM1HW5TguM0N9UNBnCrsNTAz6Iyb0QnTVXAkkGVpOG+a0HRNI22kbBGYgJtAWrq+4NbWhh6q9T4X967PxQl3@vger.kernel.org
X-Gm-Message-State: AFq9FYI2ZiV+xkmZpGmeYly+v2m00o75LR2X4zzbXnoZRRTaJPrVdM26
	XDMtBGMnzGpJg6A8EXz9lfyxsNnrJoQP6y1lX8sQt9YtT65jRd7FNb77kc5zNCB3Z8VcaD0dqPG
	gn2zrsHt0Qcrlw8xgVbrRhauPa8g9ag3G9keN8qIN
X-Gm-Gg: AYBFou1JSYLfdWVBeJkUCjXmUGuPD2VE+dyMohrR5gHX3YmdxiDwP3vk4Li/HrXxnMn
	vEklXxiqp3X3kbCMhUZjQabTLokPLcTUW+ANpJt3gLf1G543JMyU+pc4VLWmFy1U7ksiIpqkRXf
	ZFw0rah02yAu+rATH/q/3v2IZo8M1fHRpYwYC7vmDA9pccNP7he6jK7CxPWyzCmcrY5BoZtV+XG
	xpxJ7ACqR/qJAq+ZXVhlTZiMbBv40dkz1o8gZdvuR9JjjhnzQ76paZQYLfg+kQRcb3q5Ui+XbSv
	8Fi9iQ5XUj9XytFwgjfaMm0aajhN961YZQof5WTrFeMawRL8Jok5Yppv7nWC+4X15QPhEiSzBpo
	/nE6iIR+zFLIwWsGaBHai
X-Received: by 2002:a05:622a:1ba0:b0:534:313:9b4e with SMTP id
 d75a77b69052e-535b321298dmr38673911cf.5.1791845216797; Mon, 12 Oct 2026
 15:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com>
 <CA+=Fv5SDnzQQDzyhaQ37kWJMjTOHP0NHuAS6kJHwT8_Zqyjd-w@mail.gmail.com>
 <CA+=Fv5RGr2NQs=gnErAWXfSZgMcWB1q-_-BNQ5X5DyzqkV-bmQ@mail.gmail.com>
 <CAP-5=fXFYbuV9MtJsVX5hUPKDOxcjtNTHM4-qR7Q+ncsPq59UQ@mail.gmail.com> <CA+=Fv5QHzus2HUPJNFeWMCFSrOjvr8xhkPie2CLSbdjgK=+j8g@mail.gmail.com>
In-Reply-To: <CA+=Fv5QHzus2HUPJNFeWMCFSrOjvr8xhkPie2CLSbdjgK=+j8g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 15:46:45 -0700
X-Gm-Features: AclHuK-ozzc1SZ1dDdK3H95QIDfp6Kr1nmKiVr9Y7a1gGwdz5GDz1Mrtu83sdx8
Message-ID: <CAP-5=fUk=me0TYTyyHojzrGzW2ZF2Jyu14QezdjdN=Z=siwmrQ@mail.gmail.com>
Subject: Re: [PATCH] perf regs: Add alpha support
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Matt Turner <mattst88@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 3:38=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com>=
 wrote:
>
> Hi Ian,
>
> On Mon, Oct 12, 2026 at 11:45=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Mon, Oct 12, 2026 at 2:41=E2=80=AFPM Magnus Lindholm <linmag7@gmail.=
com> wrote:
> > >
> > > Hi again,
> > >
> > > On Mon, Oct 12, 2026 at 7:37=E2=80=AFPM Magnus Lindholm <linmag7@gmai=
l.com> wrote:
> > > > > base-commit: bc01105ed65d15787b2eb93ac26e8624a2139e35
> > > > > change-id: 20261001-alpha-perf-tools-regs-c206a84dec7f
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > Matt Turner <mattst88@gmail.com>
> > > > >
> > > >
> > > > Thanks for doing this!
> > > >
> > > > Register selection, recording, decoding and user stack dumps tested
> > > > on my ES40. End-to-end DWARF unwinding remains unverified because t=
he
> > > > installed elfutils 0.195 lacks Alpha unwinding support.
> > > >
> > > > Tested-by: Magnus Lindholm <linmag7@gmail.com>
> > >
> > > I just pulled your elfutils patches and ran some more tests.
> > > With your elfutils patches, DWARF unwinding now works on my ES40.
> > > Both existing and fresh perf recordings recovered the expected
> > > leaf -> middle -> outer -> main call chain.
> > >
> > > As documented, samples whose CFA depends on r15 stopped at the
> > > sampled frame, since r15 is unavailable. Tested-by tag already given
> > > to this series.
> >
> > I'm finding this fantastic and exciting to follow! Being greedy, does
> > the cross-platform DWARF unwinding work? perf record on an alpha and
> > perf report on, say, an x86. It would in no way block this work, but
> > I'm keen to check Matt/I wired this up properly :-)
> >
>
> Tested recording on the ES40 and reporting on x86-64 with patched
> perf and elfutils. I hit an existing offline architecture-detection
> issue in my for-next-based perf tree: it selected x86 registers for
> the Alpha samples.
>
> After two local corrections, both perf report and perf script
> recovered identical seven-frame chains for all 391 optimized samples.
> The r15-dependent workload stopped at the leaf, just as on Alpha.
>
> Both issues predate Matt's patch in this tree. The places to look
> are machines__init() in tools/perf/util/machine.c, where the host's
> machines pointer is left unset, and thread__e_machine_endian() in
> tools/perf/util/thread.c, where the session->data check for is_live
> appears, to me, inverted?
>
> Locally, setting machines->host.machines =3D machines and changing
> is_live =3D !!session->data to is_live =3D !session->data resolved this.
> These changes still need broader review, but the Alpha cross-platform
> unwinding itself looks good.

That's great news! I think the is_live issue was addressed here:
https://lore.kernel.org/linux-perf-users/20260905-perf-alpha-annotate-v1-1-=
97380433ccb6@gmail.com/
and the machines issue maybe in:
https://lore.kernel.org/linux-perf-users/20260918062620.2145220-1-irogers@g=
oogle.com/
Both these fixes are already queued up in perf-tools-next:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/

Thanks!
Ian

> Thanks,
> Magnus
