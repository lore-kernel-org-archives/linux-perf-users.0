Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F465350D7D
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781045897; cv=pass; b=af9tm0VL+yo9CK9QhZKwqo74stqhPgMy0u4qrmCRpuc/nUaSQjNNMCmbr/ofxaOMti6aMH4azTqoOsybv/FufKGzn4it1hE467H8A0E1qMM5Q+09j3gvUrDrB2fJAMPgNB2NvyC4iU91qwcRktXYpxwHxsKAiG0ce8PRyTFr1ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781045897; c=relaxed/simple;
	bh=qZFaPRGz5RjpiD+1kd6OH/4xOnShPD/AsfPVF08zHMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vj2+VNIr8e/738mYBSSNqqurtbvVyhyqhkWVmaci0p2/+jhZqKtC7u86Gf2nBfmWdwA4HM344YX4/GUDLPcUgp0hifcaHW8G/dI6WoGirpA15UjtOYT5rpGHDwbFUF+LOqTEPvO0FtaaXT6D0/wGGd41mxAX0R1Oj4ZAEgxnGY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/RkIU4C; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/RkIU4C"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137dd523634so9711188c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 15:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781045896; cv=none;
        d=google.com; s=arc-20240605;
        b=AE8Dxc9KPjs90NMj/C01Rfa6uqUvtWBavEIHvFOuXtX/QN8c9vSnPgXkKACpw9e0vw
         bJ5u0JH+/YUEpBznMYKw34QlsAzXTNvc2nwLvKggdZmBq1iMvGOjsslK7JvDOnA40iGV
         xTkuWS71od2OXG55EodFgjAhmC8SoAZU7kWwj/+PitxSDfUslbdX4agQvWpuQCsdy5R0
         d94qNLu/aQXkNsbYhHJ8Sp16TYfWeExBfoSWFhlbcltwbd+ae9+GdKFxN8blOMwH8HRE
         bQkqlCiexN/2dJYrN+ngs0bxt50ZR+BT3YLVSz6cvimlXy1fhezYhPtlEifyP1iEAMCr
         CfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRQiEMNzjeIyYVIHBgB7FoLDi1djI4KbRH5yTfubvaU=;
        fh=SZZh6j1QBXadKtJjjGcXUZUtUB2//Zb6+rETVS/7fVI=;
        b=QCdhqo32u6hS2y9DNpwjKbV2lomRo9+JNa/GZKNlPs+kByBf8a09RiA3w5Ldd2B8Pi
         jkoNNBP2fyfd7sCnD+SjfrEbzNouv83tdRlL07VxFj4PgulXx/hq5SQh01lweLaZ+nSs
         tjNTwSnOIpaixpIVKz7iEMM2/NZiQJDmRxBEEgVJEIA6u9lUURUUAXc2bc/NqDJr6eKN
         D7nvNyZwXylQzlDiaIcrSLUxkJxMvscHUI9qXWMkOEXB4CaneOBFAdEB+WWZYa/tBndU
         Vnlp9QyZj/jVaRjjRm8Mscl6e37iX9YhkFqvDg9u2qdUVpRxRLLJZysGbIexsJyOvTJy
         5rNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781045896; x=1781650696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRQiEMNzjeIyYVIHBgB7FoLDi1djI4KbRH5yTfubvaU=;
        b=F/RkIU4CmVpb/5KaxjvjNIyS+2Vqx1UPBAOtnQGMDj8LT5ivxeoRMfJz9Tn+G77QBa
         6YuhyykEqGdEZ2Plag85k/a8ZQs5BO5Zi5VW92MvnSd6KI61ns2nKqW1La2ZXUc1sqxa
         oAOgtO2IsH9TS642nG/jJxauCk67+xDu3iNJ/eQ8JKtvXFR+DKTCa/jkyDGL8C2jma0p
         bIn1mTbSv3FQUHEgpczrFYucN81Xy+4wihFbPAYkbbIS0gHdnMGtZHMC5fNZVAmodrLA
         WtF/riytw7G0F7FvgdLcRQ3pz0dfqb/EF0fkpFd88fHuLGHxC/tFkzdxUqRe/MXq1Hhm
         1mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781045896; x=1781650696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRQiEMNzjeIyYVIHBgB7FoLDi1djI4KbRH5yTfubvaU=;
        b=FRZRCFz/cHXZibSv6z0yI8/VZph96x40Uo15qRgaHL+j6ZTBsUZ2m03mJUaMADDz6k
         7j2qd/AWbXDoaPTBSMquOpKaQQ65zS06ob+D5my2UQtts1fm3Xdpt7k9/G0+R3042z/4
         JSciNo9jaSrK9uGgZw6q0szS4uT7em0ZZ8pAwce7tjQOp4D83PECj7rdFzxVqMIWaKAY
         yZUNZODy5dzNJ0/IVk3aBHpt1DcogKgnCy4IQ5oQzk7cIbuJX6/pEU/z/j4ZWe4TbZAe
         +IkOeHcurC38NSpmbtbEGzCQ9h41sNGVZ+xDx/h27Orv1lB/6LWyhyWto7Gx9aDKtZqA
         a2Kg==
X-Gm-Message-State: AOJu0Ywu2i5WFtPIGvhu14z6Bn5BsNXxAQq+IfiBsTjtqtQTs0QxiagN
	lMmpV1OqhAM2mdnsRbV86U9eXOrWQdoUG4Gn7ZL+0LfganyxXRY+A+zSP5aX1BgBL+RcDT1Lb6q
	3EEsswyGaaGIUwr1pwwCuUE8mSuGEs/yIQ3uE8WLj
X-Gm-Gg: Acq92OGya/JVTfaz/3FLb6TpVyMLM0JebV7Zh93XkVoZx8eenY0544MAld8ugyfeJMd
	6uIADgrZhKgI0Ru5SJc8uNyfGunGrpjCZwZpqqBDOQVQ5P+FaXaf/nmvlD0Zqjb3ZG9DaDEC2ir
	etvISleCrEGMlEBOkA8Ry9vWIjV6z1vdqrkzjwLXRPvSzWGZQhjOGQoET3CxPDMrE6NBhPHCUcX
	T2Nr2rsg3zIDemGS20w0NL+7aan8p45zTuGlf3nW9hcYUYzrtr6VtDkxTwlD5lSWihA71d1NguI
	9IJN3y4mFunLl5Cp9ccNVU/abq3/xFEXQkM3JCE5Y0BRVs0=
X-Received: by 2002:a05:7022:62a3:b0:127:3f2a:af21 with SMTP id
 a92af1059eb24-138066d4123mr10554961c88.15.1781045894916; Tue, 09 Jun 2026
 15:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609215046.2391903-5-ctshao@google.com> <20260609220242.A7B301F00893@smtp.kernel.org>
In-Reply-To: <20260609220242.A7B301F00893@smtp.kernel.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 9 Jun 2026 15:58:03 -0700
X-Gm-Features: AVVi8CdkKC5fy87JuRZuB0MXYdsxj7xLxr5vqMmF4loXQUwoDWEGiPBZWTVHhUM
Message-ID: <CAJpZYjXoC=Z10_X_=TQw2Q+O-jrQfV+S-bHThAUoXEoenHpT0w@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf vendor events intel: Update lunarlake events
 from 1.22 to 1.25
To: "Baker, Edward" <edward.baker@intel.com>, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Dapeng and Edward

On Tue, Jun 9, 2026 at 3:02=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Accidental deletion of the UMask field for the BR_INST_RETIRED=
.COND_TAKEN_FWD PMU event, making it an alias of ALL_BRANCHES.
> --
>
> commit 5c9c0d0a9a04ac6fce773f8ccf00f8df75a3f68d
> Author: Chun-Tse Shao <ctshao@google.com>
>
> perf vendor events intel: Update lunarlake events from 1.22 to 1.25
>
> This commit updates the Lunar Lake PMU events from version 1.22 to 1.25
> based on the upstream intel/perfmon repository.
>
> > diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> > index d66eafccebbb6..a7467b2f291de 100644
> > --- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> > +++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> > @@ -190,7 +190,6 @@
> >          "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
> >          "PublicDescription": "Counts taken forward conditional branch =
instructions retired. Available PDIST counters: 0,1",
> >          "SampleAfterValue": "400009",
> > -        "UMask": "0x102",
>
> [Severity: Medium]
> Was the UMask field intentionally removed here?
>
> When UMask is missing, it is omitted from the generated event string.
> The kernel PMU driver interprets omitted mask bits as zero, which makes
> EventCode 0xc4 with UMask 0x00 an exact match for the ALL_BRANCHES event.
>
> Does this cause BR_INST_RETIRED.COND_TAKEN_FWD to incorrectly count all
> branches instead of only forward-taken conditional branches, potentially
> corrupting Topdown metrics that rely on this branching ratio?
>
> (This same UMask removal also appears to happen in the parallel Arrow Lak=
e
> update patch within this series).

From perfmon: https://github.com/intel/perfmon/commit/5535a3e8cc14ae8ef5801=
3cf3d8e9480018b911a
It seems like the umask of `BR_INST_RETIRED.COND_TAKEN_FWD` is changed
from 0x02 to 0x00.
Can you confirm if that is correct?

Thanks,
CT

>
> >          "Unit": "cpu_core"
> >      },
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609215046.23=
91903-1-ctshao@google.com?part=3D4
