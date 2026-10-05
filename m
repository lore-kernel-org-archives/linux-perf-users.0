Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA130C632
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187362; cv=pass; b=Cgej491iuq1RJ1B6aRpa7vGkvytt1lRCKOkhhDTaiewZcviQ/13/mft/GycLhrQa922oaB99D5bC6F1ivkayYo2KQyzfDP4itaY27JnBJ/tQ3ObWBbXH8n3lyH8LCtYUU4sQcoP98OM1MI+9oBdiZAmb+M3StlmwKQm+3uHTG7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187362; c=relaxed/simple;
	bh=7zF4xdS44Xdj/0gtRmmbBKIp6z7kFhT/J/MOFXG2lYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSK+EtoweRd8r7JzJOAF6LZwu6Bex2mwxUcXiFbpolsOLRdwxwqnvTKz0+NKbQHBs87QV2Zm9bazjFvxrL1xKIqYetIp2modsOrMeCSQkdcuFcnfvBaUII3tyQ1nr/6ggTz/FJpQbqRmncygnGhha9vJR0wxtDSnavYJJ1eoGFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QskGlNfa; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QskGlNfa"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a7d7287703so800026a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Oct 2026 01:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791187360; cv=none;
        d=google.com; s=arc-20260327;
        b=oBLghZM3/IdvYiO8cCU+mv+KDr1rmcIxYQJfG34724Lmj/YSsezpKxC28TSBx0H7L9
         XT8YmAAXNbEKnU3XG59P33+9k4ntkyFB6UfxGeKpEl/S9U6dulZIlwcv+Goc6Cz7LGu+
         dhvWWC0meG8oN7l0gy6a6kVtZ1rxVL0SSPDEckq4P7lU8VoRHGCcXdIp3fl7DQAZu/m2
         hPbCycKafC2lOIReUelYBUb50Zh6ipjiJe3yW5NiJJAiDzgtCBNBjBn67EKTL1Uf9Rcp
         s3Q341I9gkK6l77hsaPzZbeAy9TfPa7CFRUXTEeCoMS4yksDofvyTWXjyHZeF/6EhW6v
         S4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sxQo0TrlOMq0lWMXbruwrg0I1eTUMnNipPm9JCY8MIk=;
        fh=TbFrc0wgwWyP6GEfjPBfjt2l6LRbt1QMN5hRfIZJcps=;
        b=qabAGjOJ3hGsTmLXiHcV2apTJNWAxUnuXb7fNEjTADTtb6W1HzkUyKKSGkG4ccgKc9
         uj5BQNbmkzyL8kHT/D2kM7MGDMLpNlxpFvXqlrEiIO0t5BiB+0REbJWxLELoImyqA4b9
         0DNNL3y2+P9Qqyi198jwyW1ZvjL7sOuFgdz3gm2C/E53b/a3Matv73zo39WL/nvX81nL
         psxndGrDfqxSiiQ+CX7fbJ+SjJshA3xVkNLCRVXzRR/qZOw9fbi35IClxi0F/5LtTqKo
         As38UOCwnq6KHUN9qL8naWPWf7zz8Gb8NGoA/chzsMbDpXzi+1jw2i2gNdb9jGknBv69
         CkLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187360; x=1791792160; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxQo0TrlOMq0lWMXbruwrg0I1eTUMnNipPm9JCY8MIk=;
        b=QskGlNfaKR1NGm3Rf/TBxnIjcbUDyWTdI6pkV358Sbl+UOM7z87R5FWZJJIebp4jYC
         Xn+21AqV1bXNJiHEbjpNHdwPtqXxT7qWoVgVjSn8ffUYDhXDESqgRTCO5DDtRjIopRAp
         cBLqLuVSQh20sZTgsqB3Ml7Qe1py7M043jwH5D9OidK3FaQ/v/G8JjaCjUVsHER+O7o5
         a2bxYwWcrIeLxtzZqs1NNOJTz4iPa5VDdOL7La/amAQ+lYuSYXkUI5cpDYr/TpgMAU8r
         k7xDelXzBv21hyjgOdDF0HTYfGxZ8B+8HCcqYcvjAEcOjCD/NSpTC07RPguVcCETCTmJ
         eshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187360; x=1791792160;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sxQo0TrlOMq0lWMXbruwrg0I1eTUMnNipPm9JCY8MIk=;
        b=YenRkDM4vnjmI6kyNZWjyGAO0DQAN7TbPMkp6P//YIlQMCV+XmId3oe4zqBFUNmKW5
         Qon2D4pykMw4SF2Iz00oyCa0455qBGqpXXE2dMiM1cGVUxaf6ezGkfz+iMPatrKP3zG8
         Pdnrpb9O0eOeg5k+TjyWa2ZrgQY7w1dTJ8YyFnnvUOXBV1ijIzBmUyEgojK+VXRY8FUq
         y4tSHV/n4Xet+Hyg5cBeuKaPjjr4VrPxYD468GAVkS9tm2zZPOGjKzX1LenYgAeKCYp3
         QVfX+gugwUtt/8c/gTK0nT1aXrQyIhMwmy0m7UMPhlp2MAZC49ic5hjwlKTam/IsgXiI
         MRnw==
X-Forwarded-Encrypted: i=1; AKwUvBy462jLoVS7nSxTwWYLvKaalkQyzjX+uw12eCljIpwO5Erct6GBHp4qai/A5+C8l5IXp9U0fzfCtRfPLZnLOGQV@vger.kernel.org
X-Gm-Message-State: AFq9FYJBdYoZV9j9ZuR7/v9y871EjyCUDSiJXrIgPbsPm2qCplIfNcXG
	cGoJXUo8vywNFTMSdTDgU3s++9aEjXJ0BkiyOk1oUUDZ8e2znk/J5U39bPEydPW3XSotrAVHWOv
	xej44oe9yI42FV15YmS/UGV7x09hTTkI=
X-Gm-Gg: AYBFou0GK6OIiZvx+h7Yj1hfKIOBjgW3z1ZP/EPxj0kPzuX/A61931MLyahm4PWY6kY
	JJDPt7xXUy8fbbqiqa3YHJwWbtCrPEVQ1lkqaz13jLdbX5X55WKIXSqVDnCDfLx33aa1ASFL6m+
	Lomd1mWNdJkyfGlDZ9IuQGbhd+G7VV1o1VeQB5knxMrJ2djVg3+KRnL7HInjLYn4gz3pTyQ3/VI
	eeDIf3CQJuJqP3DRSz5ZXYE2K51jORWLrhL0hqReg/i7ewByZGGnBy4uZzfayIP/oNS/VeT776/
	GwhUL5LktOv36AhudNDagNvj1snuRRlReW7RLeyyqu5JY/swpscRI5k0zBQeWduAEOKOyRmmEOA
	Rbq4FcvwcGMQz5fbfNcO8HbezpWvYrkUKZU7ABXtQsscX7G8tzQ22ZRHY1URN0pOnoZs=
X-Received: by 2002:a17:90b:4d82:b0:3a7:f5a0:caec with SMTP id
 98e67ed59e1d1-3a7f5a0d163mr2413572a91.60.1791187360538; Mon, 05 Oct 2026
 01:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811041934.7609-1-phucduc.bui@gmail.com> <ar_fLAeFU4rmrwiH@willie-the-truck>
 <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com>
 <asCyI2_CNSoDJy1w@willie-the-truck> <CAABR9nH3pkFB-htyrD-Z+iBBcYoVX4Z-hFa_binWCXg9_cHU6A@mail.gmail.com>
 <asISGdljsG86gUwb@willie-the-truck> <CAABR9nFMR+D0j5kYR+HwLBOHG4WF7PUDrqjE4Bt0-VTUacxmBg@mail.gmail.com>
 <asJlxV06xzDIgqW4@willie-the-truck>
In-Reply-To: <asJlxV06xzDIgqW4@willie-the-truck>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 5 Oct 2026 15:02:29 +0700
X-Gm-Features: AclHuK_-IzVQxn_9iJFhUH3HgnqyIHn7q3tI6SFZm8WjyMttspFJ0qnFCtIhvys
Message-ID: <CAABR9nFz65Yt-SeHAx-Gxe18c4i3Sb3b_H-zsr7d+wwK5gB=CQ@mail.gmail.com>
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ lookup
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Will,

> > > Sorry, but how is failing the probe possibly better than continuing without
> > > the optional interrupt? Add a diagnostic if you like, but aborting the probe
> > > feels completely unnecessary to me.
> > >
> >
> > My understanding is that the driver is designed to be generic and
> > support various hardware configurations, some with this resource (IRQ,
> > GPIO, clock, ...) and some without.
> >
> > If a configuration describes the resource, it means the board is
> > designed to use it. For that hardware the "optional" nature of the
> > driver no longer applies, so if we fail to get the resource the error
> > should be returned.
> >
> > A log alone is easy to miss, and the root cause still has to be found
> > and fixed later anyway. Failing the probe makes the problem visible
> > right away, when the board is being brought up.
>
> If you're doing bring-up, you should probably pay attention to the logs.

OK. Then we should probably write it as:
-------------------------------------------------------------------------
irq = platform_get_irq_optional(pdev, 0);
if (irq < 0 && irq != -ENXIO)
        return dev_err_probe(pdev, irq, "failed to get irq\n");
-------------------------------------------------------------------------

> If you're trying to use the device, you probably don't care about the
> interrupt.

If we're worried about returning an error here because it might cause
the device probe to fail, then shouldn't we hide errors from all
the other functions in probe() as well? :-)

Best regards,
Phuc
