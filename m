Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995937B011
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321298; cv=pass; b=V/oguv5X+Mm+1tBb7U8VnoRDLUECPRB5jPEIRbER1V5TLR+3fQ8GdgyL7O7fDt0lgVlFRlLqktJeLlAsJIDRPM59HmxNAxat4qMC/F/WPxkzA2rQzopA26Zrs4ee1i6dw1f+wGWvk41uCPV5tC8Fm1kaoGJIec7JysP66ccX4mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321298; c=relaxed/simple;
	bh=zkE8BBtcWTfxhbp67Vqhj2WQ70db3sr/Z6W8Xr2/kkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T61EVUVXAGTAvAuvMfVJxmTatxvA3Vng+x0ucldJtzbNFD/3Mjrii/bbhKxfEIP7mOjvegdoKeV60WVcKtnbP+/QV1R/kO0xG4IGfjiH5fhKSqbkJ3fE4Iy+yBr4ISytn1zsW4RRbWKhJgXXpsyeu7L/HkGH1aTk4D6xVvXwt34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skxriIEd; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skxriIEd"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651d692e833so3650391d50.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 23:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776321296; cv=none;
        d=google.com; s=arc-20240605;
        b=bgkc7wsAit5zZrklZWrdVwnb/1rVpJWs+PxbfuZOMg33sM1a0DGewi0zFbjnqSfHFA
         vZ7CL0vuci6Czsn70GpjTaRb9D0WQlpSW3GqdPIXRfbOf2vFY2IGAwL3U4UPZ9ku5c0r
         MU8So0+0oDqUjWcplYlMtY5XlpFRHgsFawsZoBGRObaFeZhbCRL2T1Z42LZUMm20xPIk
         yo7E4nNG/Wx6akeKWR9tF0Gq/hJca2kAmJ72w05tTkZGltr6c7bTupjQ4cf2S/M5HAaZ
         SJooJ/N/bxKY5iuYrM5BO717ZWM/tZ4NzuvDsWzpRMlSkorHVhoTzl9ga0QBaVzygRJ2
         x2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6WBIGgQfqXhM97YbaJTI7B6LyiqfGzNm6rs6snpZKzw=;
        fh=eO5XS7XuBxIN0/nNdG7gHhxsy2OYLrarjv73Vs3cQ2M=;
        b=JCt1ArGT6FzCZnBMck/TeDghs6N8Hyk8JwBIJRWydMVPf3qFQQqjJ1IQ9W3WST0LG4
         briZ7blOQsb/P8xcyMo1jjNPvxNxoY/FT/eBS5g/HBS2s/Ymv1iB6ADiEVysYmIVIy5f
         LpFMR5cvXk4kjSOZN40zG9a8N2kVDQC3QfKV9JmKj39Ix0TlcIWJrJkTBEG8BH/+zDel
         /DbNRS7mfHPsjA2Y+gjTfDrSESRcyz/UnWi96pmGnAU0uofou6aL4C10uWmQDsFjS+Y+
         iv2sls7/o4UNJkQC82ysnNp9J3EVwN2oqKQo+LYlv8yBpMNjIfikMvvJYgEhQHxwBK26
         zcAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776321296; x=1776926096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6WBIGgQfqXhM97YbaJTI7B6LyiqfGzNm6rs6snpZKzw=;
        b=skxriIEdwSjqBRMsG8xs3mf9nTwcXFgl5P1Heebx4izhtUdhBD+/UcL2Y/5Vs0JZyE
         cx55vP/KEGzceTxdi/XFL5PGAU8sbQoj1KIuGWrlIl9Booy/PUXoqKszxtEVAcyTpXwL
         cTU9NEu4vTSDYQtJ0EMmM6nqfHaaxhWokVd2uSAKsK6o6hwmkxyFLEJvRzODQcnIgZy0
         zBnCEXrmeUHTun602imJhotTY4OSWIe3XURcwq4trzBge7DBQ62uhaNl0CTTWSfNUHXx
         u4lzMCZaVA4fTe/XKFfiJ3AoU5ojovOVZTp6HaBvf4tQn0FQpO79YO+NSnQyjy8XJKch
         JyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776321296; x=1776926096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WBIGgQfqXhM97YbaJTI7B6LyiqfGzNm6rs6snpZKzw=;
        b=tXTpszJX37zUE37wGpBSf9sdJ+XM48TsghUPZ/gfdzgezauuD5UTVF/4PqmAR7aHIv
         WecDqL4kuIeQ2n7/5dwUS/7nreYKhyMmlW01Y9CPaO0fUPM6TKUwkmLL7h2lXzELVy8f
         2seJtB0JdsXpB6Aaa0/oAukVcnhvLUVyshUtqZgLAjukqhcLwFL9uz5elCxYidTMywq/
         6I2CPjywDRuNKE6V8vePHEOx0jcs/Fz7IfraqFr2X9UcYNf0yCElhWojfmS0o3rfvERr
         UTIcnwPE8B3YReMRZicJEUH2Nh8nYA1LMJqXGKwsyYe6iNah3xyXLRLbntLAPCC6Cjqh
         I3fA==
X-Forwarded-Encrypted: i=1; AFNElJ+1bLpLU0c3zrbj+0qhfPqWo4bW9H8z87vWmMgKU6f+FowCrYUuENKZ3kx1IKoMtFbJqIY6kg3IaiNtviNblfXI@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxlkVYM2wKOZ5CfmW25xxqydsZdxoBmvl8gunBV/0xGyAGWaN
	DSe960SULUyG3HZ3m4RIaBP6K/uIwNIlvUIXkdSBKQFVPngws2TQyWo004yUcn2RD0dBRi5Eafy
	+6CXi8Oq3Rr/DNxnHG1w1z0qhYxPHnjrlS0LBNFZRFvMY
X-Gm-Gg: AeBDietR7qCLgDP/LM7oHxcPCyskW6kgG3W6oH2HS4/bX1yPP/YzaaJsyp72xdJ5Z9n
	9gfzjIMtjZ4ZsKeVIRMoWQzbn5/sMHGoJET77kKT8NB2odq1XJIaYqSyiutFYVQsldcjxKOVkBX
	Hc4tAlMbS//L+ETGOj5OQuAQ3Bn/0T2JLWH43O/buF6IWhaZbCmYkfTEJSvOU7anx2ob9N9fVGQ
	rffogZq/Fw7xZtLy9UpFT1poWFMt0CMR8uVwG6GS56A7SveN+ouu/kutp1J2clSh6/XNNBxUl6+
	06X5pWxoAdMVAJ+jQw==
X-Received: by 2002:a05:690e:1209:b0:651:d23c:3d70 with SMTP id
 956f58d0204a3-651d23c47afmr12655185d50.16.1776321295868; Wed, 15 Apr 2026
 23:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3> <2026041603-guts-crested-ef76@gregkh>
In-Reply-To: <2026041603-guts-crested-ef76@gregkh>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 14:34:41 +0800
X-Gm-Features: AQROBzCOpZzRmD41Y6QW8paZXFQAYd1mYTjiI8Mq73St9Vcp-8vYTmlQsIfc7_Q
Message-ID: <CANUHTR89FUUFxL-TKxOOAugNFp9oR3dc9Zf87-kEEXSrRWxk5g@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark, Greg,

Thanks for the feedback.

On Thu, 16 Apr 2026 at 12:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 15, 2026 at 07:19:06PM +0100, Mark Rutland wrote:
> > Hi,
> >
> > Thanks for the patch, but from a quick skim, I don't think this is the right
> > fix.
> >
> > Greg, I think we might want to rework the core API here; question for
> > you at the end.
> >
> > On Thu, Apr 16, 2026 at 01:41:59AM +0800, Guangshuo Li wrote:
> > > When platform_device_register() fails in arm_acpi_register_pmu_device(),
> > > the embedded struct device in pdev has already been initialized by
> > > device_initialize(), but the failure path only unregisters the GSI and
> > > does not drop the device reference for the current platform device:
> > >
> > >   arm_acpi_register_pmu_device()
> > >     -> platform_device_register(pdev)
> > >        -> device_initialize(&pdev->dev)
> > >        -> setup_pdev_dma_masks(pdev)
> > >        -> platform_device_add(pdev)
> > >
> > > This leads to a reference leak when platform_device_register() fails.
> >
> > AFAICT you're saying that the reference was taken *within*
> > platform_device_register(), and then platform_device_register() itself
> > has failed. I think it's surprising that platform_device_register()
> > doesn't clean that up itself in the case of an error.
> >
> > There are *tonnes* of calls to platform_device_register() throughout the
> > kernel that don't even bother to check the return value, and many that
> > just pass the return onto a caller that can't possibly know to call
> > platform_device_put().
> >
> > Code in the same file as platform_device_register() expects it to clean up
> > after itself, e.g.
> >
> > | int platform_add_devices(struct platform_device **devs, int num)
> > | {
> > |         int i, ret = 0;
> > |
> > |         for (i = 0; i < num; i++) {
> > |                 ret = platform_device_register(devs[i]);
> > |                 if (ret) {
> > |                         while (--i >= 0)
> > |                                 platform_device_unregister(devs[i]);
> > |                         break;
> > |                 }
> > |         }
> > |
> > |         return ret;
> > | }
> >
> > That's been there since the initial git commit, and back then,
> > platform_device_register() didn't mention that callers needed to perform
> > any cleanup.
> >
> > I see a comment was added to platform_device_register() in commit:
> >
> >   67e532a42cf4 ("driver core: platform: document registration-failure requirement")
> >
> > ... and that copied the commend added for device_register() in commit:
> >
> >   5739411acbaa ("Driver core: Clarify device cleanup.")
> >
> > ... but the potential brokenness is so widespread, and the behaviour is
> > so surprising, that I'd argue the real but is that device_register()
> > doesn't clean up in case of error. I don't think it's worth changing
> > this single instance given the prevalance and churn fixing all of that
> > would involve.
> >
> > I think it would be far better to fix the core driver API such that when
> > those functions return an error, they've already cleaned up for
> > themselves.
> >
> > Greg, am I missing some functional reason why we can't rework
> > device_register() and friends to handle cleanup themselves? I appreciate
> > that'll involve churn for some callers, but AFAICT the majority of
> > callers don't have the required cleanup.
>
> Yes, we should fix the platform core code here, this should not be
> required to do everywhere as obviously we all got it wrong.
>
> Guangshuo, can you submit a patch to do that instead and ask for all of
> your other patches to not be applied as well?
>
> thanks,
>
> greg k-h

I agree that fixing this in the platform core makes more sense than
handling it in individual callers.

I'll look into the core code and send a patch for that instead. I'll
also ask for my other related patches not to be applied.

Thanks,
Guangshuo
