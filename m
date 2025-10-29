Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C52D6E69
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751728; cv=none; b=Pd/x8TCiMouRTI9IVYG+L/udLuPWKyWNgzJug8irnQM1sZ1ejfbszlep6Z8DFXNbx2rqyVccETFo9ZWGLwiK45N3WUCp+lkXHjJa+wjPpS9Zpux4u2xWp0//apHAUiA3wkK02DzdaHhLiN4/y9C7vPDObeRRmmUkSo5cl7XiIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751728; c=relaxed/simple;
	bh=TJHFnnFKIqy6xvnPpB0BOQQvgK6dk7JKH68jj6ONkWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyWemxTsPy0i9J0Y0vwS6UAFEZol9GUuL21TTbvdwhUM7ryGfbodDHrormMnCdfXvTwEdANuU3jxr7cR4QD0/0jp3X6dw91edo5Xnt3lkL/aSdsTPBQWOm3EcT27MPf06D9yXxqjsGwrgXOvKpWlYdNElNIXkytAJuB6Z2P5E1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wmy0ybJt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wmy0ybJt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d67abd215so230495ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761751726; x=1762356526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4LDGDuuvy1GZmmeIYc2HRo9Q3u3XPw/hRPINr8ofC8=;
        b=Wmy0ybJtG/chSY4gZRAsG5qm7CriFZMPrtWJ2gnTk3PLBfc7P/W+BhZaADu5yOwQOw
         GTn8onLLcaV3AKVfX2uTLWjWxFJQRR2u+lNudfdIYkMisMo8JMq2rmVHrvX45Sqp+sAk
         2Hm4i3QZaSNsuVL8hckiSeyGSJlA7W6p1R9XFAzLYGiaYeQTYS6fKcMWcr08qB4c5mUZ
         4U2YopKCdsoOI6AwxBy7L4rS7SErKluohlpGTzkoc39yjiBVE3y4s/6LBn3qDD4ZRH9G
         MOORkLdoY+ZOJS+3YXEgSIVU9xw/wZ3PvKk7P6i+cBkcKOAq3vb/+oglrzwsJBbLJPOJ
         ms+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751726; x=1762356526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4LDGDuuvy1GZmmeIYc2HRo9Q3u3XPw/hRPINr8ofC8=;
        b=Oop+hhCxkN2rxAdw1FCitsc4rIVNgWuBrAfUiGFs3EnesazZOrWcyN1SwM29FmeObO
         In+7Qg6ceuBw+jCDeYRAu2xAwdMEMvqlYrb+jhy3zJR2waqpYEhv7QKB61spwV80U4vj
         1d8rjWhlmzowe1lfUnJ4oaz2MHWcWZx3uM+2Cu5WtDdNYCEzOd4/GLshtO3zUtd/LkK0
         7zAuYx8Cak4cJN1GCXppT2f1X07nj+/YOkuelhOg3FTLnaGqAKhOT0aiG2d/QpR70pWO
         yPd2ggan7VBvQ4/H33+WOa/VYM49DBL1j7o6NbfTaiEWpaBvnWKcyBUR5d60FWEHtysb
         UXdA==
X-Gm-Message-State: AOJu0YwYsebDezQkEYNh9sWVtuZgvnQ56U9tEAobwdxLKoMeMjHJpXLs
	mOgitutlZ4yMRecI5ZXGzKwMcjLXlHQNAa3GOE9VgEbG0scrRBBb40tSGx3Go04kQK/39GMBv8X
	Yy+NaJCcxvjT8FGBPEs2fyTH78g6i7eG4/+9G+9Az4UN/NBzNf1YgAZNJktc=
X-Gm-Gg: ASbGncv7E5kp3RAl7ZHM5+/Ynl+RO1oGgFmaLVmCjSCaTG+rQZDCDoto4eeMMHaDyZo
	/E7rOjehKu/O+Gm1eWnGEXWbvDqh0wWFlSJeqfeOD8VcywyZO9sythmareiWQG6IQp4LprLftye
	NQTQAy49GfyZLatTwfD3anri6ZUrqhk2sbUGPNkNKyob1u0z/u5P04S6omU9T5uDpcMsOI0nySW
	Dta91FYaXZ6ZffUo0Cdb3YPJWwMpyh9EuaFqdquMUfIWmOzDdswTMtLJXfGIQ9HzJhubDAlibVH
	rl2ZpxNfbRkZivPRgoSQXD8v
X-Google-Smtp-Source: AGHT+IGbAZc0pTGcyKUm8UV42riCk2JGr2M35EYk/AjWbjgSxCBTcDpVkkadUgGMPm4WDB7W2gcwK1N4m1I6xmRQiBg=
X-Received: by 2002:a17:903:1205:b0:292:6145:c2a with SMTP id
 d9443c01a7336-294de569863mr5105485ad.8.1761751725844; Wed, 29 Oct 2025
 08:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aP_AyZAzBBGXaTgR@google.com>
In-Reply-To: <aP_AyZAzBBGXaTgR@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Oct 2025 08:28:34 -0700
X-Gm-Features: AWmQ_blFb_K-LJIjiLaao8mgxsSM4O0niKSdLT-yr3T_PbYJZjZrlItzJGbxxtc
Message-ID: <CAP-5=fW==xQ=fgyCTZmrPDTc3aikdoLdRUYk5NxEbDq+0HP6mQ@mail.gmail.com>
Subject: Re: [RFC] perf tools: Update JSON event description
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 11:58=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> I'm trying to make this change in the JSON description for hardware and
> software events.  But I got a build failure in the empty-pmu-events.c
> even after I re-generated it like below.
>
>   cd pmu-events
>   ./jevents.py none none $PWD empty-pmu-events.c
>
> Did I miss something?

So the build failure/diff has the path to the generated
empty-pmu-events.c. I'd copy that file rather than try to recreate the
command line - although there should be no reason generating the
command line fails it looks to me that you need to pass "$PWD/arch"
rather than "$PWD":
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/Build?h=3Dtmp.perf-tools-next#n51
Fwiw, the formatting in legacy-hardware.json was based on Intel doing
the same thing and not wanting to start new conventions:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json?h=3Dtmp.perf-t=
ools-next#n32
```
    {
        "BriefDescription": "Conditional branch instructions retired.
[This event is alias to BR_INST_RETIRED.CONDITIONAL]",
        "Counter": "0,1,2,3",
        "Errata": "SKL091",
        "EventCode": "0xC4",
        "EventName": "BR_INST_RETIRED.COND",
        "PublicDescription": "This event counts conditional branch
instructions retired. [This event is alias to
BR_INST_RETIRED.CONDITIONAL]",
        "SampleAfterValue": "400009",
        "UMask": "0x1"
    },
    {
        "BriefDescription": "Conditional branch instructions retired.
[This event is alias to BR_INST_RETIRED.COND]",
        "Counter": "0,1,2,3",
        "Errata": "SKL091",
        "EventCode": "0xC4",
        "EventName": "BR_INST_RETIRED.CONDITIONAL",
        "PEBS": "1",
        "PublicDescription": "This event counts conditional branch
instructions retired. [This event is alias to BR_INST_RETIRED.COND]",
        "SampleAfterValue": "400009",
        "UMask": "0x1"
    },
```
As the order of seeing events isn't well defined, I'm not sure what we
gain by shorter descriptions and it could be frustrating for a user to
see that 'cycles' definition is in effect a redirection.

Thanks,
Ian
