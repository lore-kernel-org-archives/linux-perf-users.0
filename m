Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A3391859
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329959; cv=pass; b=uhavwYOEtWza9Ucjf624tihN5rPFoVqyTuzoMICvo39xtT3XzqIV4lmyoI1vsegI1varo3jJczQV642d+2mmHBsnRRP77yXMMwZX7/jsG/pgTsbFNVv7i7qJLxQXYoivYroz8u6IMlQmXwQAG7nb9X7jzI7SbxGFM6kIF9Kjpoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329959; c=relaxed/simple;
	bh=5mBmmllB5S8fgsehiq65Oyp/IPuXw4X4HH7VTt5lbQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxS23avSoMhNc1RsJfvnNS73Ttv9NTcwE2eCuVZcPUHIONKy07yW6wUvNXIAE8Q3kgf5lrv7FTwG6HfU6peYlhVnkuq2NYYDXd9RjLvvOhafc75m7oyXBNbYQIe9/1lov6XDDglv1pCr1KCWDgoYTVWwL6cXxBHVmUTUDTU+W3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOFGGHvV; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOFGGHvV"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501c9903edso8528523d50.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 01:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776329957; cv=none;
        d=google.com; s=arc-20240605;
        b=fYv27A3nY6Cb756lFTCApd8DVKBC9VvFyck7wzTPB4SafVgDE2zkX9CeSfZpqO39GG
         g4WNpvkvYVdSIxSKy+Z0hbnMwp+okF8il7vknWHkhrFT6/5jWX0CLDzH/CgNDnvAICiM
         muj4lyynywwTJWnad8/DrPF31PTNiNwoX2ni4ryFwCqNHGPf3bVayQs4py2JytFwwdIz
         v17RMzsgQAU/6txVUZ+g95SovggRRLmYzmATs9GPt18Ia4+GeQi6Jy2tguIRm/N1Jgh7
         AT9K9xjBYvNji2NKxol7gT+f9KsSVUzSzRtcV0+QtPtLzXIy2XwhAaZwZjKziRbcx2FD
         E5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rHLTvTB9rDNh9jJv6Ebk36+huSVLvHgRUe2zgyE7vag=;
        fh=gopKSN3qdkoBAm2SNqfFrYHA5gt6+5eifgDfAD1tvKs=;
        b=Bor6Znqwg7Hv7Gg0Xo2ifOAhHTNTdk6HG1igB8gz7w365Fcl09DJ0M5g080JsReVqD
         xkWMR48uCQEACV5V7jwZsVShXKW0AAibx++Lojdvc5hg1LlGzRPTidv+gK4jyMqa0wXW
         fnzZSm6MsOnVvxIMkuSGFSAGWHhIiDIBz66D1hygRPbwGzxx9z+bN09iKZXGNgiZl6Ve
         RWM2jEiy3dRcnp0KfMeTc2Jc6Wax6me12cZxBrQLWCouJk6NShlW1TU4ReOD/nUZJ7QB
         EuWSPtRuQJJMHfdZfwDKlAR8pZwAlmnA63d7ejHpiM6w+wZw+QcRJo1jC4Sw21EAPpe4
         lhEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776329957; x=1776934757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHLTvTB9rDNh9jJv6Ebk36+huSVLvHgRUe2zgyE7vag=;
        b=oOFGGHvVKx9vHuDYjmfwePlvGmjRgwVMsqexZz5YV9ZRROlOIxzw5R0canE0s0ICxn
         5P3yv93cWwXI1oMxMRF5INtDNDMLSc4JrIq30Mr7Fu0EclHPw5Ykeyqa6gmWtoGE3+rx
         vEAWMbrD7EAwEPcld77v+xJM5Sk/73H9oHyrwesjVeJuGQsgwz8jd/Nz7SlgwOOsgSns
         stXo/jDaO3uQMBCwof6GM1oOLTGLqUTy2/e4ZHKUrVYuT7+moky0z+m5lu3RtZDUdWAW
         s7qrB1zhHawttew42bwM/RduSrcw8SX8aAir0HD22LYuLSlFWznCeoCOk2/CG0zmoYLX
         Ut/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776329957; x=1776934757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHLTvTB9rDNh9jJv6Ebk36+huSVLvHgRUe2zgyE7vag=;
        b=Ek5JUKS60i0Ba4lTfLwY6ZmONubWrJw/xRdk3IGfjQHSp6yLYNrYuCaB5cHahuEYkP
         Eo/EoMSUYUdDxjkW+ssode8Bti0TbCa5nRdSlhizZ3jpb78TVzZj6hxbsOqC4qTjsl4T
         C9+ONrFtDhRfqyGdgbeUJ3wa5oYndPHsmBcAgDCxyEDpwTBqWcdwoaT9GRQ5+lYrHPV4
         OpAPu/lN4F5cVSRrCjfr124dqRzgkJGzHtf213nrS1LJj1UcM2wiQugvpurYySdNT9Gp
         0eaeNakGohQZuslVHODdvapdPwPXL3ZLnMOJLI6dDkkL1pfKYo/zAA1Xb3CsdDRO0E/N
         QuJw==
X-Forwarded-Encrypted: i=1; AFNElJ/0V6R36n72/ch05E6a5SHq2fBOV3p/2YzClS5pJN2/GUng4g1+pWuGRja6+kEjdvZG2rG6em4oOXLDLztbdoVJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRwffyJlFVMXZWR2wiUbwNflAZVPNyOJrTKTdvmiWqskGGUIm
	mCIo8L7ahwFTjjV2vh9JOAU6ZyzF3vm3FQXbq2iFOybTpCRU5vCu3r6SNUZcg5P5teA9BTGp+IQ
	c6lxHlbTm4FfXNosrwG+ZnfqNgIqbLNY=
X-Gm-Gg: AeBDiess+/8msx0vUTnilZatmOoKMaG/mE8OyYf2JLjPcg9IcD/M0eUi+q1YRaZaXg5
	87FJIAeE08Udp35rTaN0bfEF4FvaJ5K9KFScwbJOsLiuJrME741SKZEgjcHW8NvhqGHvq1T/6E8
	TvZ/MHQjGdvmkGAAQCxjBT4aaDREZcbJqaegl2/Qk2sgfFSuCpOIRZBJccRRwYP9PmPm45KE9Fm
	A+aGE4PaiNwcRb2a+1vJtsbNrPEAH9op8Ao+4ak19hCSy0Q3lx1IWLUyMVV6HRZpVTsqgH1DXuC
	IJy1zEX1cERpOwmiUvH6
X-Received: by 2002:a53:c903:0:b0:64e:a335:95cd with SMTP id
 956f58d0204a3-65198b427f8mr17307099d50.41.1776329956736; Thu, 16 Apr 2026
 01:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3> <2026041603-guts-crested-ef76@gregkh> <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
In-Reply-To: <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 16:59:01 +0800
X-Gm-Features: AQROBzBJInu6_sedDTufJcGH_sz0MWfYgc8C0FVsACksumcnkFd7jCyotGqllqk
Message-ID: <CANUHTR9+Z9s3thfKMC5qiLMdYJAo-1sX1g9QiU65OVCbb+mAMQ@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device registration
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Mark, Johan,

Thanks for the further comments.

On Thu, 16 Apr 2026 at 15:23, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Apr 16, 2026 at 06:40:55AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 15, 2026 at 07:19:06PM +0100, Mark Rutland wrote:
>
> > > AFAICT you're saying that the reference was taken *within*
> > > platform_device_register(), and then platform_device_register() itself
> > > has failed. I think it's surprising that platform_device_register()
> > > doesn't clean that up itself in the case of an error.
> > >
> > > There are *tonnes* of calls to platform_device_register() throughout the
> > > kernel that don't even bother to check the return value, and many that
> > > just pass the return onto a caller that can't possibly know to call
> > > platform_device_put().
> > >
> > > Code in the same file as platform_device_register() expects it to clean up
> > > after itself, e.g.
> > >
> > > | int platform_add_devices(struct platform_device **devs, int num)
> > > | {
> > > |         int i, ret = 0;
> > > |
> > > |         for (i = 0; i < num; i++) {
> > > |                 ret = platform_device_register(devs[i]);
> > > |                 if (ret) {
> > > |                         while (--i >= 0)
> > > |                                 platform_device_unregister(devs[i]);
> > > |                         break;
> > > |                 }
> > > |         }
> > > |
> > > |         return ret;
> > > | }
> > >
> > > That's been there since the initial git commit, and back then,
> > > platform_device_register() didn't mention that callers needed to perform
> > > any cleanup.
> > >
> > > I see a comment was added to platform_device_register() in commit:
> > >
> > >   67e532a42cf4 ("driver core: platform: document registration-failure requirement")
> > >
> > > ... and that copied the commend added for device_register() in commit:
> > >
> > >   5739411acbaa ("Driver core: Clarify device cleanup.")
> > >
> > > ... but the potential brokenness is so widespread, and the behaviour is
> > > so surprising, that I'd argue the real but is that device_register()
> > > doesn't clean up in case of error. I don't think it's worth changing
> > > this single instance given the prevalance and churn fixing all of that
> > > would involve.
> > >
> > > I think it would be far better to fix the core driver API such that when
> > > those functions return an error, they've already cleaned up for
> > > themselves.
> > >
> > > Greg, am I missing some functional reason why we can't rework
> > > device_register() and friends to handle cleanup themselves? I appreciate
> > > that'll involve churn for some callers, but AFAICT the majority of
> > > callers don't have the required cleanup.
> >
> > Yes, we should fix the platform core code here, this should not be
> > required to do everywhere as obviously we all got it wrong.
>
> It's not just the platform code as this directly reflects the behaviour
> of device_register() as Mark pointed out.
>
> It is indeed an unfortunate quirk of the driver model, but one can argue
> that having a registration function that frees its argument on errors
> would be even worse. And even more so when many (or most) users get this
> right.
>
> So if we want to change this, I think we would need to deprecate
> device_register() in favour of explicit device_initialize() and
> device_add().
>
> That said, most users of platform_device_register() appear to operate
> on static platform devices which don't even have a release function and
> would trigger a WARN() if we ever drop the reference (which is arguably
> worse than leaking a tiny bit of memory).
>
> So leaving things as-is is also an option.
>
> Johan

I did some more investigation, and it looks like directly changing the
semantics of the existing API would break code that is already correct
today.

In particular, there seem to be at least two different kinds of callers:

Callers that already handle the failure path explicitly after
platform_device_register() fails. For these users, changing
platform_device_register() itself to drop the reference internally
would lead to double put / use-after-free issues.

Callers that operate on static struct platform_device objects. Many of
these do not have a release callback, so blindly dropping the
reference on failure would trigger a WARN.

Because of this, changing platform_device_register() itself to always
clean up on failure does not look safe.

One possible direction may be to leave platform_device_register()
unchanged, and instead add new helper APIs for the different cases.

For case (1), I was thinking of a helper like:

platform_device_register_and_put()

The implementation would simply call platform_device_register(), and if
that fails, call platform_device_put(). Callers converted to this helper
would then no longer perform their own put on the failure path.

For case (2), I was thinking of a helper like:

platform_device_register_static()

The implementation would first install a no-op release callback when
pdev->dev.release is not set, and then call
platform_device_register_and_put(). This would make the failure path
well-defined for static platform_device users, avoiding the reference
leak without triggering a WARN.

If this direction sounds reasonable, I would be happy to work on it and
send a patch, and I would also be very willing to help with the related
API conversion work for existing callers.

Thanks,
Guangshuo
