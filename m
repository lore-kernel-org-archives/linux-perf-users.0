Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920773EBF3A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447838; cv=pass; b=ToOMaNZKWm0BzWA7oXI+wPosGFvkbF0hnqijDEARajlBFbi2xdhAzAOIBOGuCFJY2yJFEwx2OpFPQMVHmDxcgrAIX/KopsLhKsjCEJUOLRCZPiXxwbhY4Is3GzdtyOxUrGCL+W7dxMrxYjQd525hxyLSpn/y4u3ZWmyYbbJOrqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447838; c=relaxed/simple;
	bh=mfN5BNHQ7JCEJ3EHb4HRgb8WKkrZMBFBkUU7E/K3FA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1J65BM8TDHKkeqM9w6BhpthJdeR18bNsNwJVMFP37DytdYQ6ywv3/yKf8Cs+UHixiOdz9BlRRWQdOgo9ci13G2JfYE8Ai+2J+QCEEbv10ZVTcltMXDAKNTtxfWOtvI/H+UMOJiRmohS5+PhSQ2MAewo9UbMA5dI+3h7Z3hxHbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtQliCmf; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtQliCmf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d06cfa93so154865ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 09:17:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769447837; cv=none;
        d=google.com; s=arc-20240605;
        b=XI/cHoeZ4tXeTcCL78/FA83v+EWp3ixlF9z7w0+TJD52NBsHvBZzEIq3f3iLHVrp6M
         BjQpOsvikV1VM78nQ3PormxBdd0+7UzQfau27gkV3grTfbPd9lTaUB93AV3Jz4wQNE0X
         n1fg8xH5TCRdFXXP/P45bhILOXBcp5v8GqwDvZ+CQps9gRkD+IKmV6WQjV28JM+lyBV8
         7uRYtlXLbRIZPLzTh86Ez/W798meuxzqoRf4lM3JTLz9NasJ6bOfSqLscu6kqryH1rkw
         pSfd3fsquguFuxKGdjMBoY2XX8udac6kLCqMCV4D3T9LqbwFtsuGtZB95rbeYPu1gsYf
         SD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HxMNixTp3LZ2WeNGX4gUsv70oF31gHkKukJbaqYDTHU=;
        fh=dE/TvXiZzHCYd7uslqyhlOEn9l4zXeVQjJSbPov6yDA=;
        b=NF2ozvWL/uhD2FtLn38DsXerH6WSXH55KDXa/jbDh8DjGM3tGC/gCN8HafsK2tb/OG
         J2MUZPLL5Yh69RnzDsVUpyWgkxupldvGWuDzmCGFBvLBX0yxu1dKgebFYpje/hdAZJYh
         XsjCqBpUI7ZnkE8jGel7eJNpnHyFiJJ2Vp5nd7vmrT5H9W7B/EwUZA1DGGxztZ6yzdku
         XUJTn1kMMDEjefF/sE+7bIfAS3dSwA7NB3GCOXpMZcZ48S2oEhOayTPjeiUioeXdu8m1
         vZOU2J9kewQsIAyNVouxK6wr+yPWDC9vMjTGDqqGEwg7VrdOHWR4N5nBALoBvLac+JwF
         3nbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769447837; x=1770052637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxMNixTp3LZ2WeNGX4gUsv70oF31gHkKukJbaqYDTHU=;
        b=XtQliCmfZvUG0m2l+32s8R09qTgNUGElRr/dMApi8xgRir+0KCIA+801H2HXh2R3D7
         7eTBPMe21h4s4qwApxC1rhzhkb679lV5SzCoQTghAcaF0VbYYsVptfBfZbyNKDdPWiDd
         6O+qhNVwAyXP76RvtsCRvqOlmU2BhVqwhS1Mw2ncfE2UdAH0iKqR7a0h0IZ1ynva8jIm
         cux59n+HjhblpuFl1zBRgenmGJo6z/uRVkrNSaVyip8+seNQ+5cAJEGjFd7L1xQ/lDpL
         hFHzm5tEwVySh4p/Xl3HNQBjm9PdmVLp5X/+uU+kA8d67CQ2iBhLdvqLxDPSCMB3yjQ7
         pv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769447837; x=1770052637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HxMNixTp3LZ2WeNGX4gUsv70oF31gHkKukJbaqYDTHU=;
        b=BpwdbyuS5vjKDcCS0i90mwOvACcq1CEC7ZXSyMzgRpP32dd1CFtaT34UmqG2z99YTF
         f4RjizpzQPV9JnXvcarLzAKbFSqwc3YM7jCvhDmwt/B11WAB7O1qOzQ+lzVZ/mR0sJSr
         2zNrb1oR0GN9IMdFM3Yn/+YLAwARl2UvZjqowMweP5i10bMVn7eOrdTHUFPiJAb4kVHw
         bdyUCXQShWFTX/if1Jc+wtYkiOS53mB7y8vEKDxg+wW2PlY0F78SI8Ha9JJn1TBC4/1v
         NpPZqzT3Z0w+U1JNngEcs/G7F9Inv7NhcubshnZsfJCzDH1q4qpBX6JhQcz0ahtu+4Ad
         GKAw==
X-Forwarded-Encrypted: i=1; AJvYcCUtKbzU5NaNlCbmK34t7ca7VHGzHomYAx1bVyrcSXSsnbgRqiZpOsEoNxTmP9ss5dm7vgBRaiSOW1Pea6BYhO4t@vger.kernel.org
X-Gm-Message-State: AOJu0YyQDmtCb3a3L9xAG3PAPU8E9YawS35xNmLukqD63hh3khL2iTpL
	Vj9Fc0kpe2ySUbu2rFkDwOZPIZ+3+73Wo2CQa2MW/TA9PAU+5J2N1C7DWHmzvLAdHxQTcqEVgyL
	fnibhrCnBPkiPdGAoRI4jFHP76XKvjb6yMxGNp0xu
X-Gm-Gg: AZuq6aJXPwgp3CuiHgB3IvnAwu9mNhtyTqnzNDcHLFjO8pwUoDNJB12L2jK+Qp3HIoN
	M0jIXlk35ejeiaAW57xxev0cgLflLaUlrkbnz1342n/ZSlvZ3JDKw5YoR9iKQFI/v8/F+c7UxMN
	vK95HzLuhpAxLEowzk9W8t+ZXJzF5E9pM7ex9g2lWGbkG0l0wkjyJTOhiUJy+Ipty9JNJNMqxci
	YWtci1Ik3nMcO32p6ve+viUsnKSPGEdYHU+6Z0KujZ8q/BCvFkAGMiypdIOrRSgc4fTqAqo9DM8
	6nvHreurLglaSvDh4N3faayxuA==
X-Received: by 2002:a17:902:dac9:b0:29d:7b9e:6df8 with SMTP id
 d9443c01a7336-2a8447ffcf1mr2869235ad.2.1769447836514; Mon, 26 Jan 2026
 09:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123090938.2222960-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fWMvuMXU405nu8hsysnq3id_3A1Uj4H5mTCDY3Chsfe-w@mail.gmail.com> <4fa47f77-fa1c-43d2-992e-de166613dda8@linux.intel.com>
In-Reply-To: <4fa47f77-fa1c-43d2-992e-de166613dda8@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 09:17:04 -0800
X-Gm-Features: AZwV_Qjs7KKjcXf582-rj7bkeRq2GnArPvRBZFp0fQMpASprKB4gL9PwNFc2Too
Message-ID: <CAP-5=fVmVnFQOp82rdrnq=cLiQq+jq0fLJXUWGwV+Q+U+yHwTQ@mail.gmail.com>
Subject: Re: [RFC Patch] perf regs: Remove __weak attribute from perf-regs functions
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 9:20=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/24/2026 8:39 AM, Ian Rogers wrote:
> > On Fri, Jan 23, 2026 at 1:13=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
[snip]
> >> diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arc=
h/arm64/include/uapi/asm/perf_regs.h
> >> index 86e556429e0e..43e8e08f52ed 100644
> >> --- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
> >> +++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> >> @@ -43,6 +43,6 @@ enum perf_event_arm_regs {
> >>         PERF_REG_ARM64_EXTENDED_MAX
> >>  };
> >>
> >> -#define PERF_REG_EXTENDED_MASK (1ULL << PERF_REG_ARM64_VG)
> >> +#define PERF_ARM64_REG_EXTENDED_MASK   (1ULL << PERF_REG_ARM64_VG)
> > I think avoiding the conflicts by adding the architecture name is corre=
ct.
>
> Yes, but the side effect is that there would be mismatch with the
> corresponding kernel header file. Not sure if someone dislike it ...

It should be possible to update the kernel headers too rather than
have them out-of-sync with the perf ones. Someone might object but it
doesn't seem unreasonable to make the changes to me :-)

> >
> >> Additionally, there could be architecture-specific instructions called=
,
> >> such as the "mfspr" instruction on PowerPC, which causes build errors =
on
> >> other platforms like x86.
> > Right, the mfspr is used to add additional registers into the mask and
> > if we're not on a powerpc and can't run it we should assume something
> > conservative which your change will achieve. Fwiw, I tried to see if
> > similar information was available from say the ELF header, but I
> > couldn't see it.
> >
> > With your SIMD changes and common functions you can refactor the
> > function signature to take the e_machine and also the perf ABI enum
> > value, then the mapping of either an XMM register string or SSP should
> > be possible by varying the ABI enum value. You'll also know to fix up
> > all the callers on the reading perf.data side to pass the enum value
> > as the code won't compile with the missing parameter.
>
> Yes, if we decide to use this way, the SIMD/eGPRs support would follow sa=
me
> way.

Great, thanks.

[snip]

> > I think it would be nice for the SDT clean up to be a distinct patch
> > from the arch__user_reg_mask/arch__intr_reg_mask clean up. If there
> > are regressions it will be easier to bisect.
>
> Sure. Would split them in V2.

Thanks!
Ian
