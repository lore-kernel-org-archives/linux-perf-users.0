Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3738D412
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259313; cv=pass; b=uyEAAFcOkmTS06cav0OAi57C/Y4T6S6tB0Tp0TPFn02KQeCCjmRRLoUMs3WUhqeTZExb2Cx5jsV1wGeDY893m0SBPQZWg18Rkw1cijnu2APvFfP6Qz+fQgsdvSBwGKw603r6VfDaPFwoIIJqsCQWTIrxlk0GLQIpzi9gU93nU5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259313; c=relaxed/simple;
	bh=cjkcJje3D43GI36ThNxlKNXb2AapwbD/qOFz41XnyWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp2JLW6KpVBTtqkNsiwwrSUyeqLh4bBatKvHUVBzlIrUhIuVI6mBAW00jb77leuvOSVVrWy6EOBDlyNLyEo/6qg9Ssd6qnC62GDZO6G3t0B6XGcGPrQskpsFNPw8NQ6XeBVqNaP3+Rp7JpiKk2dQohDgMjLjn4cSJ2sPeldiOsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmHsghSZ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmHsghSZ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-530e8c6fb80so254741cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 07:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790259307; cv=none;
        d=google.com; s=arc-20260327;
        b=LqHDH0elH8mSpF5ykfGZfSCvNJBTN3pUec4rwHRpxAH0oxClquV60McQucsaBUIjxu
         dGO7B4c/YsULTPE4cyjq6SggleZtTLslVYzR/zIByOyFM3eDOt2RISDVXxY3nWZXBoZE
         K4Sbd9XDxxlW6sgshyjWFzzImQo9VNk0wCAYWVtcV1HGNdR6/4pi3R7CqxaVYyu4dTU4
         bOCY9S4GwwulfPQ2IFhT5VwpMPH0l4ra0DcmBr9MjVGD3N4i37lEk69S7pf0sKOfHWTA
         Q27FFUi+KdIPbHtbfCqLc3mpi5l2sFpVR6gsPDdfs/slpfe5NPkXG52B1FEoAGAxMC9b
         5W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C7QwgFIDJPeVD+m+9h/VZ8uU/5iMIuRsG3J/mrcbQTA=;
        fh=WwZD1EB6Tjgd87mh/04sazSNljN3VCeXXd+1MHPWLKM=;
        b=XvISI0iXwDRpQPQyAjEQzDRbUTz+9fRSIqfb5VEPffRrW1dNoLYnkShSByXj4YAU24
         JsTaZtszGdAmaAnuW5FI+wAsHebA2raKgRDrOnx6uAHVfDCvafo+5NxYJMJ3Ukn/Md95
         ZxklYGWgCG9jel8wVTxcKGxcjSFY1uLFzkXKG6hMqErEq3xtdkQyaF18nxtVX0wWByQ1
         5ZB3mADBv69XNHWwLf06e0OTVrTUPodaTNmxgI8Ic7maLTuzauqi01RtOTRWbremc9Kv
         Z4sxXLkcirkck/rI1vhz0rvSdrxn1wk2mHFO68j4mAJklj/sn3LPgDKVxohghqPl6CX1
         Tfcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790259307; x=1790864107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C7QwgFIDJPeVD+m+9h/VZ8uU/5iMIuRsG3J/mrcbQTA=;
        b=EmHsghSZv35PN7tyhjm77nMJDB7kyZhZBeIw0wGoA0GFe2NSsCaT8aD2OjFQITwkhq
         GxD3UcsqKz22g/YSDIGUNIxbP4zA6FN9zAD9EiFivIJ0B9eWW89uW/eY8HpWXXwFZq6m
         8b0DkuxWX6yoaoRTjbD/Vg2CHsnX18gjGB6JdNQzzcjCcgdQNP6RpmgJc+FtIBXbHeKy
         4ruVe0puQ8Ly4svM6ZzXRh9wIs8ZE8Q4brQ0EPCLyohXNmGU1EY6B/qQEf646KUdtPTU
         MmDEjDORk29rLHoIhXye9PJxrIMczCeKZUhcDdYFrLbEO8WL1dBjdqa9SrSY0ulKajbU
         K72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259307; x=1790864107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C7QwgFIDJPeVD+m+9h/VZ8uU/5iMIuRsG3J/mrcbQTA=;
        b=cP4VYiBrkE747ALRcRoLCsYtJptz+dOeDdH6FvrYH0Hwuq1FAmzOLNE46VadsRZFY2
         2s+I7CIn9P4RP7cD3vzhEtndbXBX/Fzb6XmZwUeHKyNrauCHqd0sTe5sbhrgMUZSGnod
         VSiPP+hHvERopWGOo2d5C3YyHJAyHGkxisgBwCOfTFm5VXX6yb9S20dgPLJ9xyx6mmsf
         pAKRl6cEIl4nLUjPuCyqOb+18est6Ksk9BeXuMwjlQ217uZOGflHFE12Ar/X74VbA4Fb
         DmbSo1c2UTrwhHRxqnXiv+yYuXWmKpvVENNrPdSF0c3YWIM9YVUkNtStZVotAoKh8L2M
         d4nQ==
X-Gm-Message-State: AFuF++lH2+GGY7pGE4xUeaWwGrJrNWdwigoNuXX3lkVa2oRdv98gtuwE
	dUatrtqwZZAVSWR1wTbFGWg+gwJXoJ+n/7tyBAIDJD2x6FSXow7TWI+gl8i+wdJgwoSm82Js7jk
	EVpc4yLPlUAMA438SRAeSKZP++pAqQ15yc7zKN2ca
X-Gm-Gg: AYBFou0YDTQqc7RVyxZFsh23SDbF3r1WbrYRLHQmgFUokMdb7T3lgjakhm4S8//GpHc
	4elhzfDNRf2O+EZfQty3e6YjYmvlXuzPTFREjhQxC8BPmfgxOzbEcV/tDvSk/G2QtaRm++MEIY2
	wW5vuiUMocDA67uMPiDNGpQP2xm/2pOhT5obURKWyk540uBL6IjDjgrxwxH+soMUaEePN39atIz
	3Q0Rs+5th2bkOcNkvowA14GhJW6WbVbw9epYG98uor26u/Sy1Eu0w44Z+sTa82ufkDZht/IZrEc
	XJnZshhiDuUdCmPs47VHqi0HDI0rBV8xeeeHdO6fCbbhMpKzlXCCAIk=
X-Received: by 2002:a05:622a:107:b0:532:84d3:abb with SMTP id
 d75a77b69052e-532fea4a126mr10270761cf.7.1790259305798; Thu, 24 Sep 2026
 07:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924053645.3555041-16-irogers@google.com>
 <20260924054906.404961F000FF@smtp.kernel.org>
In-Reply-To: <20260924054906.404961F000FF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Sep 2026 07:14:53 -0700
X-Gm-Features: AclHuK8ZVOo9UPJOqQO5EI7ej6eUSk_Nl-O97AH2fqwChdW9BPzVRoYbGo57ahU
Message-ID: <CAP-5=fXwk8TT-aQYUz+q7RYAcEiEez4MZwGEe5j7rfsTtvq2bA@mail.gmail.com>
Subject: Re: [PATCH v1 15/21] perf vendor events intel: Update novalake events
 from 1.00 to 1.04
To: sashiko-reviews@lists.linux.dev, Edward <edward.baker@intel.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:49=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf: UMask omission in novalake events causes EventCode alias=
ing
> --
>
> commit 1470a977cdc98c6d093466522a50ce1b48974108
> Author: Ian Rogers <irogers@google.com>
>
> perf vendor events intel: Update novalake events from 1.00 to 1.04
>
> This commit updates the novalake PMU events from version 1.00 to 1.04.
> It synchronizes the event lists with the latest intel perfmon updates
> and updates the format encoding for the off module response MSRs.
>
> Link: https://github.com/intel/perfmon/commit/50afd00f84fb8c7bfa26a993a96=
8982c1573e6d1
> Link: https://github.com/intel/perfmon/commit/b576c542b68d377fa00ef467471=
5ea87a37c309c
> Link: https://lore.kernel.org/linux-perf-users/20260923015517.2665398-1-d=
apeng1.mi@linux.intel.com/
>
> > diff --git a/tools/perf/pmu-events/arch/x86/novalake/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
> > index 471a90f3670c4..2dda2225d0043 100644
> > --- a/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
> > +++ b/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
>
> [ ... ]
>
> > @@ -181,6 +181,22 @@
> >          "UMask": "0x1",
> >          "Unit": "cpu_core"
> >      },
> > +    {
> > +        "BriefDescription": "FP_ARITH_INST_RETIRED.SCALAR_HALF",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc8",
> > +        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_HALF",
> > +        "SampleAfterValue": "100003",
> > +        "Unit": "cpu_core"
> > +    },
> > +    {
> > +        "BriefDescription": "Number of all Scalar Half-Precision FP ar=
ithmetic instructions(1) retired - regular and complex.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc8",
> > +        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_HALF_WCOMPLEX",
> > +        "SampleAfterValue": "100003",
> > +        "Unit": "cpu_core"
> > +    },
>
> [Severity: Medium]
> Is the UMask intentionally omitted for FP_ARITH_INST_RETIRED.SCALAR_HALF_=
WCOMPLEX?
>
> When the UMask is omitted, the perf tool JSON converter defaults to UMask=
 0x00.
> Because FP_ARITH_INST_RETIRED.SCALAR_HALF also shares EventCode 0xc8 and
> lacks a UMask, these become indistinguishable aliases for mutually exclus=
ive
> events.
>
> Could this cause incorrect PMU programming and inaccurate measurements?

This finding is correct and I need to do a fix. When there is a umask
of 0 and and a umask_ext the umask_ext wasn't getting combined with
the umask:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L350
It is the scalar_ext that differentiates these events:
https://github.com/intel/perfmon/blob/main/NVL/events/novalake_coyotecove_c=
ore.json#L8626
I'll fix this in v2. This impacts more than just Novalake, here is a diffst=
at:

 arrowlake/cache.json                      |    1
 arrowlake/pipeline.json                   |    2 +
 cascadelakex/uncore-interconnect.json     |    6 +++
 clearwaterforest/pipeline.json            |    3 +
 clearwaterforest/uncore-cache.json        |    5 +++
 clearwaterforest/uncore-interconnect.json |    2 +
 emeraldrapids/uncore-cache.json           |   42 +++++++++++++++++++++++++=
+
 emeraldrapids/uncore-interconnect.json    |   12 +++++++
 emeraldrapids/uncore-io.json              |    1
 emeraldrapids/uncore-memory.json          |   10 ++++++
 graniterapids/uncore-cache.json           |    5 +++
 graniterapids/uncore-interconnect.json    |    2 +
 icelakex/uncore-cache.json                |   79
++++++++++++++++++++++++++++++++++++++++++++++++++
 icelakex/uncore-interconnect.json         |   22 +++++++++++++
 lunarlake/cache.json                      |    3 +
 lunarlake/pipeline.json                   |    2 +
 novalake/cache.json                       |    2 +
 novalake/floating-point.json              |   18 +++++++++++
 novalake/pipeline.json                    |    4 ++
 pantherlake/cache.json                    |    3 +
 pantherlake/pipeline.json                 |    4 ++
 sapphirerapids/uncore-cache.json          |   42 +++++++++++++++++++++++++=
+
 sapphirerapids/uncore-interconnect.json   |   12 +++++++
 sapphirerapids/uncore-io.json             |    1
 sapphirerapids/uncore-memory.json         |   10 ++++++
 sierraforest/uncore-cache.json            |    5 +++
 sierraforest/uncore-interconnect.json     |    2 +
 skylakex/uncore-interconnect.json         |    6 +++
 snowridgex/uncore-cache.json              |   68
+++++++++++++++++++++++++++++++++++++++++++
 snowridgex/uncore-interconnect.json       |   10 ++++++
 30 files changed, 383 insertions(+), 1 deletion(-)

Thanks,
Ian

> [ ... ]
>
> > +    {
> > +        "BriefDescription": "Counts the number of retired packed 128 b=
it or 256 bit double precision floating point arithmetic operations.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc8",
> > +        "EventName": "FP_ARITH_RETIRED.PACKED_DP",
> > +        "SampleAfterValue": "1000003",
> > +        "Unit": "cpu_atom"
> > +    },
>
> [Severity: Medium]
> Similarly, FP_ARITH_RETIRED.PACKED_DP shares EventCode 0xc8 without a UMa=
sk.
>
> This defaults to UMask 0x00, which will alias with PACKED_SP and other ev=
ents
> that share this EventCode.
>
> Does this need a distinct UMask to prevent profiling collisions?
>
> > diff --git a/tools/perf/pmu-events/arch/x86/novalake/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/novalake/pipeline.json
> > index 998dd4cbc66a7..65a8a3058f81d 100644
> > --- a/tools/perf/pmu-events/arch/x86/novalake/pipeline.json
> > +++ b/tools/perf/pmu-events/arch/x86/novalake/pipeline.json
>
> [ ... ]
>
> > @@ -146,6 +196,15 @@
> >          "UMask": "0x2",
> >          "Unit": "cpu_core"
> >      },
> > +    {
> > +        "BriefDescription": "Counts the number of far branch instructi=
ons retired, includes far jump, far call and return, and interrupt call and=
 return.",
> > +        "Counter": "0,1,2,3,4,5,6,7",
> > +        "EventCode": "0xc4",
> > +        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
> > +        "PublicDescription": "Counts the number of far branch instruct=
ions retired, includes far jump, far call and return, and interrupt call an=
d return. Available PDIST counters: 0,1",
> > +        "SampleAfterValue": "1000003",
> > +        "Unit": "cpu_atom"
> > +    },
>
> [Severity: Medium]
> Does BR_INST_RETIRED.FAR_BRANCH require a specific UMask?
>
> It currently lacks one, defaulting to UMask 0x00 for cpu_atom. This will
> collide with the preexisting ALL_BRANCHES event that also defaults to
> UMask 0x00, leading to inaccurate performance measurements.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.35=
55041-1-irogers@google.com?part=3D15
