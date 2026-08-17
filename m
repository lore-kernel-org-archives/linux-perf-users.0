Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB13B47E3
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949968; cv=pass; b=B29nadXSXXvu/swrH4NMCaSAUHHbTMXP/Nx6/AkF+UJlMnwf7Mo62yeh9f+w8dPfLCecTAki4TMrwfaGBaQpd68QFVPljaXpc5Dj1lV8qi8aHY0UWoz65iE2Mj5a+QLZWuCwFQHdsxzpGVZB9PmZYOJ7LEQaxBAcqlWnJsVruug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949968; c=relaxed/simple;
	bh=ypMOncElJcERIG++e5PJp74Wp/2TpX3VUNdFToi5R00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tD94dxD6voMxb3aVsayVfyQkhkVCJJ86NEV8SUdCp/+ppJ7jr1k7KiCnRX+pMQw+SPj3UZqPIMXiGV+kvpILDbWsQcuKoyk6iYANwVG/SxcuuGiT0FqiHW6BCgKXzhBUw3+G7KzDu2GKg6jnrun3VKe4zlbHU/KQ4vBtM8wchqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6I70s5m; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6I70s5m"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c10ed63c0so559671cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 23:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786949964; cv=none;
        d=google.com; s=arc-20260327;
        b=gxN+KD+qhh8lXUnhTchZn0x/vqDK5V4DkVz6grS0S6NLK5qn/WwcXejsKtjEjk5zW9
         Ng4ZXX6S/oOsn1yuOrr+PMBWXlKa3t4izOc+tQmRD5Cd9qAJaAozA3QZnctYbfJhuYdB
         awupLtKmTIpZgBGDYcTCf+PwTHqzkjprp5OpZeI3Y1zo/fNUxcaM6VZsSETWbu1+qBB1
         EJQedgxqdR1RAGSBaUTrSi3Tdn2FFi6JgBhrYDBTmg9zmbYOw/Yrd8JeWpsS0zC27UN5
         pxlxIn8bsx9ZLeLSOCN1PuB/YQoHFpPVxpNgsaoungQk4Mm2N4mfgo4dTmLCfaWKb5Ye
         YNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IY2bHrWP83c5qKEj7JctX4+A/lVgxJqecsGF51bUANw=;
        fh=uEDvrYTJsRaRG8FjcLSpFmmz7179U/m7Alo6RBhBJoA=;
        b=WXnOU6pIITTjNzvMfbh5fOKVcfYrlNDvAzTk+sA6S8YzDDIk4LT0N/cXnIxoApVYFM
         g3RLRfmSCCbMuVwMDcnN2ccv7OiatxAKpHFxqZz/xpG4eYT3fcQqF7bWRJUN3u36f75c
         7Qp+7BiLYsYs8/t7qjzrN1ehLlUeDPL8QGxvOd0rIPx5qUUAohuJ6RWRMvkYGe9qC/yV
         3Rwhzq5Rrnh0ihzio+A+zvD7JNYWWZyFQNXW5GQP/lbgFAGPtrv+qIS3+1u4z1fDgFmQ
         wRIS1MkRiLHEOgq/tYU9h/6DqBm4RUJRDsp0bS9IVHXxe40VNAM33ER/kEuJrXvJGVSA
         hu7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786949964; x=1787554764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IY2bHrWP83c5qKEj7JctX4+A/lVgxJqecsGF51bUANw=;
        b=I6I70s5mD5K2BEGs/95HPiDs2BHSkEP2rnwBZwnBu9QJ0G0R/exvvjJXAW0PvthxY4
         WkReEtqfk77L0S01GHxaw3v7u8sebGbH0LwFHmRsGGqfSkHyxmtGpRZmSXDtSiQBDLdL
         Mt5lINV8aXTSSGiVQEasXYZK6qxvK7i+NH0rwtzuB7Fae/9xrBhlASwcDX+lex1xWiSM
         X3kDdPFiMbf7tPu/attSypETyLwDXT0jtgRGDxEZa3mwXqIsIK1w+/THG7lP4eYVdAq/
         TlBiu0gRUtXscKq5xZGA+MDxNM8MpxG0nznTPT4jH+SUmbMYrrJBJtp1Buvk/mpowm9N
         hxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786949964; x=1787554764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IY2bHrWP83c5qKEj7JctX4+A/lVgxJqecsGF51bUANw=;
        b=eHChk1N4OVP7RZPpQMM9WYRVrag1HEuIh0gb4eGDHgBNH76fLrDN20vpRC62eIVXiU
         ZFiUEa7z1E1JYAAceK4hGF5qaXe/hLQoffxt/XSauePaVIlMaHzWEuazzOYCqa9mY3pP
         dC9GYgWiDOn1ia/ZWTQ59aZI6bByVQi2pSBhccLbO4KD9gWqu2+VIQZKizLMK1ujgWAp
         S7u+77ABlgfWsuGN7lXsYdTrocKZCuB0PCYUuufhLAzcdJcVdBxkRrPwKcZ/uN2351sS
         sSqIyiQzfqV578Mo5V4zf8+Bl8RGxFGQCDNfUWQHSBvArNJ4q9meQsP/OyMqEXbLkQOA
         yrKg==
X-Forwarded-Encrypted: i=1; AHgh+RrygLUGmR7jpkNaOKnMfHyXew8tEszsOv5yRHoE9v/RdXA1NrEDDNsHEFD2hvT1Phfgwglm78nNLL8ig+UIM+tr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/LC5Ur+86ZYXRDx3YITwKIfZen+8wlTzjLA2UjPWx8MEeEw3
	1HCW5+gN1wcJ5v0ksoGsPhFy/3bfjKp+qRvYzVrKEA8nh5QA0M6MdC0vS02ZUV2P+LT7jVIZ/zM
	K9WWL5VnFwpRhveXrx9B5+PJlfzlYtyn++hfqQUuT
X-Gm-Gg: AR+sD12P+8PFZrN6pXef9pm9OAVoHoKvbKDQxUBrPJtpoBLFOh0XBH8MZr+n1EQlEuD
	+CiVxx4Gzxtydy8PT/18yqKrCwF2jiqzhgnft2eZ0ZxGJUbn4auH4aJrqgYVLhXaLvyidiPS+PS
	QUH59PykPCpymqo1x5R0cLn+qnq9HIwPfE/stRnktj0wVIXKEiziAEy4aOfv3/kBtNwx+NtNu2U
	7yJH7BBgrsD7UScb12mQEoCHkum7C+EPlmGeKrVF8Y5UPBMmCbGwYFWXBGE4n5zpI8vHCQT2YQk
	xtsae1uMvv40AZUYYfkhjhChGS/okdfJGQ+lEGf8F1FdbA==
X-Received: by 2002:a05:622a:258b:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52db1f07d0cmr7857301cf.11.1786949964069; Sun, 16 Aug 2026
 23:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815082048.4043217-1-irogers@google.com> <20260815172712.50119-1-irogers@google.com>
 <20260815172712.50119-2-irogers@google.com> <bca067e2-bbd7-43cf-9198-32bf4de35a7a@kernel.org>
In-Reply-To: <bca067e2-bbd7-43cf-9198-32bf4de35a7a@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 16 Aug 2026 23:59:11 -0700
X-Gm-Features: AcwNN1Vs4MSe4cISy_57HV-pFnHrgdqaW60la9WkPHYBLONdcObvmkLdsOaO8wE
Message-ID: <CAP-5=fVpy=mK75hXNnFKTcdv-J9ckDV-vqVCbcEKigftom=1Qw@mail.gmail.com>
Subject: Re: [PATCH v13 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI
 PMU definition
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: florian.fainelli@broadcom.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 11:23=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 15/08/2026 19:27, Ian Rogers wrote:
> > Add Device Tree bindings for the Broadcom AXI PMU hardware blocks prese=
nt
> > in the Raspberry Pi SoC line (BCM2835, BCM2711, BCM2712).
> >
> > Depending on the SoC and security configuration, these PMUs support eit=
her
> > direct MMIO access or routing via the Raspberry Pi firmware Mailbox IPC=
.
> > The bindings support defining 1 or 2 backing MMIO regions natively map
> > the system and VPU control surfaces.
> >
> > Assisted-by: Antigravity:gemini-3.6-flash
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835=
-axiperf.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiper=
f.yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> > new file mode 100644
> > index 000000000000..8a4857aa448c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/perf/brcm,bcm2835-axiperf.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom BCM2835/2711/2712 AXI Performance Monitor
> > +
> > +maintainers:
> > +  - Ian Rogers <irogers@google.com>
> > +
> > +description: |
> > +  The Broadcom BCM2835 series (including BCM2711 and BCM2712) features=
 hardware
> > +  performance monitors on the AXI bus for evaluating memory bandwidth =
and
> > +  system traffic. Depending on the SoC architecture, multiple monitors=
 exist.
> > +  The primary
> > +  monitor evaluates the System fabric, while the secondary monitor eva=
luates the
> > +  VideoCore VPU hardware.
> > +
> > +  Older silicon generally restricts direct MMIO access to the VPU endp=
oints,
> > +  requiring them to be accessed over the Raspberry Pi firmware mailbox
> > +  interface. If the VPU endpoints are memory-mapped, they are supplied=
 as
> > +  secondary resources.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,bcm2835-axiperf
> > +      - brcm,bcm2711-axiperf
> > +      - brcm,bcm2712-axiperf
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> > +      Memory-mapped I/O resource regions for the AXI PMU endpoints.
> > +      Typically ordered as System monitor, followed by VPU monitor if =
directly
> > +      mapped.
> > +
> > +  firmware:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>
> This was already rejected.
>
> https://lore.kernel.org/all/?q=3Dbroadcom+firmware

Ok, assume I'm ignorant of device tree things, how should this be
addressed? Your link is to "~70000" messages.

Thanks,
Ian

> > +    description: |
> > +      Phandle to the Raspberry Pi firmware node. Required on older sil=
icon
> > +      (BCM2835-BCM2711) where VideoCore VPU endpoints are exclusively =
accessed
> > +      via firmware mailbox IPC.
>
>
> Best regards,
> Krzysztof
