Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F893AE198
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791025925; cv=pass; b=ggAnvZSMePJ4j/QSNWAFf0pI4+ruf7GotymP7PbUYGqdXukzwHwi39J834WAhfUkRUWuQKpaLLSIYj+Km0YsPqSIylENOu2L3bg1mihX5XFBHtA7TZ9YqLgjh7ieVgWz4oaRLmWUOShaVNYW3ByfTgSpFhcKYXGLOj8EzYN7jBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791025925; c=relaxed/simple;
	bh=rLgxAjUxQiSdL6QzfFYoFCwEhfYuwxFVk8+D/cQg3Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P70RLfwOfnpZRtAVXMxbSq9dtVC0lsuTtaX+dnySY3sFoxYufJihQ2VTb0dDCkZaRWfUbZRJkEE9lQMnw5q2Y/nqB4lWsvMvqMZppvDeIqWmh0uKmGi9eoMDLA4jWHz3gfUaBEE9+4zP55iVAiw0kENoooTR+edtyv35TQjqSqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+4vk1OE; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+4vk1OE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e2e0f3dd40so2319245ad.3
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Oct 2026 04:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791025924; cv=none;
        d=google.com; s=arc-20260327;
        b=IHKOE0KWsupp8Aw+IuGZ3SX1HyO3RBdokhRBgrTtkN7q4DUBd1uE1GKw56kufkAs0t
         PV/ASsaQ0a5jsriQ2G7eZfudMY63PawYxNBve9y928SW91nt0s0iMcNN3Jj6p4BmDEux
         UO/z9vuD3KkwIeZTUGfi6d7V2mZXRLgJktXD31F3VXJSThpXVLPMT92kyofTsigdRm3F
         IMT2nMhZUzEpAUvsiqrR1NAnDWdaGhSLGKgz0S20Drs0HeaRYwL+RjwcicnF4UmVtFAr
         cRyij1evoWB1zZMOkukoEINO6Sw3h+Y57CJD7EXS7NJR27vYRUMUIj25d66BRn1BlVjx
         zq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZOkPI3tXRwTtIn8qocSrw0Y1LMVW42C4jrO7SmDiYa4=;
        fh=19EyY3G995ISpy5vRXp8tSK7TsCO8t5pdFUWeTnJH2M=;
        b=jemawkoSiS8Jd/F8uUovi9Fn+IMxhR97YqG+AEqThLfKf1oTNz6IaqcCrOESGUt7ro
         9ma+AXpNEPtwP9AnLyayiJq2ePEJGw4EhvlxKNE6zI5RNCQcmDfw/nWd4SPzAubtWjBn
         eSieAltlrDV3urfraOhMRLwr5WIehwbrFHxWG01lA2v7G3bjYubn4ARp12RySBS+J3NP
         xOOXp9Gg0grs5SoCSTAhiAIzMK8YYaZTzGZAXFyKU5KX20FbEjgjse6NDBdRUZhQWIcL
         3ZH1GGXKFH7kHvuzlrOk+/NazRyHqP/EQoB598doRS5AhfFc1pcZzqz1PfLDUymKvY1f
         EeTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791025924; x=1791630724; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZOkPI3tXRwTtIn8qocSrw0Y1LMVW42C4jrO7SmDiYa4=;
        b=F+4vk1OEuO9TVU08gykFc9++gSdfE7fGmjpGD+LsXNUdNzr50lJ9naeormHtDMm95E
         Ime8CafGVXmVfsiyACyTtEsV6uig/SaIzSRY0LHeHXk6+lWg/aPICn2iHWekbguQ7Rg0
         Ww0RHS7Fb8OcmDC2vg1EV1NbssItwd0NZKvkb493+aUZIfEqexbdkUQUkKV8+0vqw01l
         euaIxNYx9hhQYt/pcsgMc8UTOBX3XL87MN3WfmTsnc/cfIbnMNRMrSUqlUJvZec+SyhY
         skA2fQjII32ZLII+lSoc9mn7iBcu+Z5C39oXhTdI0/843do8i6xvHipAF0K3EPwBoCJv
         7+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791025924; x=1791630724;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZOkPI3tXRwTtIn8qocSrw0Y1LMVW42C4jrO7SmDiYa4=;
        b=uppTXEmswBHCKSt4hJLivxYHAsywgqyYAro1+/nOQ25lZGRNEaumjgHHC3K+xI4Wta
         day5WDpAygJbz4mwYL4w5eCiINR2Ge6NeST8Qe9TJoEB58INfjbZvylJhsc/FDIUMGWg
         o42UlFEA39cj4CoDZ2UIEHpabQcZqPFRiz6Cl10m7CWK7We/TWeRebtyh7ymX9qlgJqY
         CTt64b0KuXcbn0DLFper1VxHiOqb5w0DBVmNPVUpXAfJN4SqEZvEc2C99OofxI+X2rZd
         FGK8qXIwMD5fDRTWN7GwVZR5Lc+kfR1E/v63NzbcK5XLe/VXl8L84d6TwqBVBgl1Yfm/
         40sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaBPJEQNbExe4RA8KnhwmkJTwH15LG7keahrpmFFzkXML2Z2QJlmLBrZTsewsnkt+1WOI0Cl2oxuNS6u56/3Np@vger.kernel.org
X-Gm-Message-State: AFq9FYIOEVimsCu+LQUe0gB/4d1My+F8/G343YzjoPMFIkjL/0nLCTFS
	d+r27qIqXTGHNC8nAOsxy6E1aFdLG1SDxvUdBdqb4Ac8nQ4TPwpBfuJG7flMZweO+x9x1SY20C5
	pQDI4BUrU2QUQ4PfBce0pJVpnyEyqHC0=
X-Gm-Gg: AYBFou01Otqlsn+xnPQWRPb1zI9UvyWw775XN6MKY/nwT6XTZ2wNRJaNiqI0U0Madxq
	QCgKWKWMtTX5uWrZ1bKK4XeWReUFdd0hotEC6DjJydG0SErUhVEDscWwWHuQZaTMu9CrCgZbXWQ
	8TjLFpE8GF+fTHJGO7k8PRevSwSECIxrsbT/vQ5uk3KERN/JKm8lhCdTTL183ClSlSm8WOlTCAC
	S126I2HQ+q1Iakbs3cKlZebPOkSejCktWOjkhUxj6+aIo96IcCCz3o4ZJoogNPvyIyvwpgplAVb
	47QRwPnNW2tq6DkkBS65fLeEaP2rxAUhv1rY3O2TEJk0g/0oirZHhMOEsMJZt7LGjpFITj6qrEV
	HFCHv9rDuObZ1Z+QywVDB4ale6Bpu1q6eqS6PhswQKi7rpatKmjYZRrSktF1JkAGQoTmdQJvfU2
	RDCSYLW7NzaaYZj58GNoZsmbVZrw==
X-Received: by 2002:a17:903:2406:b0:2d6:ff5f:eeda with SMTP id
 d9443c01a7336-2e4ea0db41amr21785615ad.6.1791025923705; Sat, 03 Oct 2026
 04:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811041934.7609-1-phucduc.bui@gmail.com> <ar_fLAeFU4rmrwiH@willie-the-truck>
 <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com> <asCyI2_CNSoDJy1w@willie-the-truck>
In-Reply-To: <asCyI2_CNSoDJy1w@willie-the-truck>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 3 Oct 2026 18:11:52 +0700
X-Gm-Features: AclHuK9Zi1mA9PZ0oSISuDkDrpCS_y9Tgcj6SbSA32DMxp-Ws9T5eeG0iizhVxU
Message-ID: <CAABR9nH3pkFB-htyrD-Z+iBBcYoVX4Z-hFa_binWCXg9_cHU6A@mail.gmail.com>
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ lookup
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Will,

> > > Not sure about this. If it's optional, why should we bail the probe if
> > > we don't manage to get an irq? Surely it's better to continue without
> > > the interrupt in that case?
> > >
> >
> > platform_get_irq_optional() returns -ENXIO when no IRQ is available.
> > Other negative return values indicate errors, including -EPROBE_DEFER.
> > In the case of -EPROBE_DEFER, we should propagate the error so that
> > the probe can be retried later.
>
> Thanks, The -EPROBE_DEFER case seems more compelling, so perhaps we should
> check for the expliitly (because it won't fail the probe altogether)?
>

The idea of the _optional getters is that only the "not present" case
is turned into a special value (-ENXIO here, NULL for
devm_clk_get_optional()), while real errors are still reported to the
caller.

Besides -EPROBE_DEFER, platform_get_irq_optional() can return other
negative error values depending on how the IRQ is obtained. These
indicate an actual error rather than the IRQ simply being absent.
Ignoring them would leave the device running without its interrupt
and no indication of what went wrong.

So I'd rather keep:

-----------------------------------------------------
irq = platform_get_irq_optional(pdev, 0);
if (irq < 0 && irq != -ENXIO)
        return irq;
-----------------------------------------------------

and continue without the IRQ only for -ENXIO. This is also the usual
pattern for platform_get_irq_optional() users.

Best regards,
Phuc
