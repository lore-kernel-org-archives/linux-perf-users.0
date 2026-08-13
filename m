Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C547ACC1
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628913; cv=pass; b=Tc7zEUTqZ1ccfSNnNEho7wvYqSBh3dxaZzc6hUvArw8ib5TKj36ClS0vNSyMVS89bjL/QoKA4ryRl9zeMPuiBD1ZeN/sUTtwayCcR4yYMu4W/ig6pNAHXQzmgDhfS17rCFaW128r55mG/kP/bquuOZouP3cKW60K8O3+J0hRlD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628913; c=relaxed/simple;
	bh=95X0xGDH/htI+O0+SsmKnC7glJi3n4umuMsOUsqLvKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBIqFtwruj4DBjBFE2x7ya4wqcx4+rEY9vdp1YjAjBzhvmCcqoUX7TVV5ZuZwsnlWIsrOGPwEaqCPmU8VkV9nslYstG4Hgtg9vXCUMZNLzC1LkEqUKqil1RmGQWMNsycUe2wAVZKgVoqPXGuKHWDrbOtUsiMZxm9UHnhdmPxL5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icG0qOtz; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icG0qOtz"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c10e86e52so203511cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786628910; cv=none;
        d=google.com; s=arc-20260327;
        b=gN72IQVgryVedPTe3VOES1GXGYGtnaK65V9sSYvTRuYV7xqueDie+mqnpE3omQPNME
         97+HDSDp+XNVIGVBvEkrv00APx94WX4tJMPyot8Vzyd11bMaTcMHPfrzAxaM/aBNxhy3
         xk2Nk+zprh/MseTNFwb5UAckz7YdsiTRsD1VusqyAfY0UshIkOKVNr0V4W+KjbW2DQ6p
         v4PnS8xG4QACv2S/Hi03uHlLeot9modRvr0UobNsJLdVUer944mWIYrdlevzqKRL8BNN
         pxD6dJXSTMlrjgekmA7K1W1ZxQfwmtYIlJ44miWayrHRziQ5L2T9GNn0Z0U61OC3F1Yu
         XiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=95X0xGDH/htI+O0+SsmKnC7glJi3n4umuMsOUsqLvKg=;
        fh=OS9EddGY001FZLqUWx87S+gY990A7iAReD49UMiv5n0=;
        b=P3SyjqFVaGau4bBnaBw9NxmioaUFx5z/yIG1N+2fi3JRnL9HHHM7jUVJx0EoYtZ0go
         tWziGQixw5lEiUdjr8kOwqtUPbM+azDST/UfVVO5uLjlvCroZilb3pEJcctd3jK7K8cm
         uAoBT6STm248IXxJ8seBypoqYeM9HEFezAd9J0bzoSzH3OpdappTQV00Gvsab2J9BnJR
         mNXeG46rwnLbtahotetgW55SG+l54N/dCnjkUc9NWOqHg3Z4rtIRnxYEndri3BkUrpw4
         liJ3EqiVhFgfQ6Cheq7edsLVGhLWM+dADzD0C0Le0BEN0d5IKImAEhZffUP34PwVkvRj
         OYsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786628910; x=1787233710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=95X0xGDH/htI+O0+SsmKnC7glJi3n4umuMsOUsqLvKg=;
        b=icG0qOtzhHSTjb8EHsSrDmSulhsldZwQ3fNfCaujGjAC3pSDKhz7FaRobhg4x6ms2J
         3whDj+G/qEKoDYq3XcIidhUGYBdAEvl8gjp4DTQJu+MuXpwhuQ8SNsRU/0z3CINfBhL/
         kvVZVaVT+ftveZAyBUaqYlnZIwS+IadMEaKGE/tN2fnKkKlZNDqz58QrphKpMcOvCxbS
         r67FaC4w/VM64xTb7WQFePGltqiCQtgskSejT+WFQ7m2ZHisvbhPXWhkAsQd/5xUeRKd
         c7jnOW8XEXBiTSauF27iST4mHDsBuxGBSFQqd50BBhjf+lVjI5OPw5S0tYNWXawAuT+S
         TDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628910; x=1787233710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=95X0xGDH/htI+O0+SsmKnC7glJi3n4umuMsOUsqLvKg=;
        b=Twjhpm9odSCBTJQ6AcqF+Qy19by13GD5YuH3CjCvvDtKStAcgpR99nzC2dDsJQK1vE
         B+eJiRmy4JRG4Pf8VZOite9+Tlr98YYF66PNe3XfJ25b+lH96hr8Ju5nq92tN831bnEb
         qF9ReYXKkvGxYstHjWyG39lkkilUIXuG+G1+SVCJXKdj/c6gRezli4dZVG/sj8Po5eqj
         S69XvcycNbtaXZw6vYO+JtzU4OwsK3GUglQdTec8O3hOku1bMSiJJMjPy8kg7zDxTeXl
         7zXrY7LKzVMSy/BOFfG4Jfkrp/O/BEmdlJQ8BIueI22H+++MLP+1BcflOvk2i2xwetPp
         xFBA==
X-Gm-Message-State: AOJu0YwcuWExnjh2BNNIk2FN3/lzgtxn+zeF+EN168QTA4h5NUpbOgqm
	FcwQYWOBpGrEcG4zF3xnHEWTj8u/m0cg5BNMD03/Jiq2B3ZwBopitL0eBon8wrzjC+CSNB7Jifc
	gCcyrqCD3DS7gUbzldNUSywTbzH3ODfEiruGw/7O5
X-Gm-Gg: AR+sD12CARy0tLqx6LHJ+OaXHed3TOwIRkiMiVUWf8iyYnajuVdUJgQokBBLHxHY0uk
	1XmVB7VTTvlB7MYu0aW02rx1n7PKn9EdQB/nwAjWXwhI5mEG49unxFPFy+NEHny05oIe+Ga4P/K
	/CEK8Kvn/qfUhrR2lVdZDX9fXB75ARf7QtC8d23ZyGsucr22tIy7LjL6fwfko6CmpR7u7fgFhLO
	H/X8XRQxtLemh4QnXw/Qz9B8sxM/B/BqkHGOA/Z5cNHQM9zvxZbvfaKeVyDKXlljwWVehDY1vKg
	R+1no4v0wPkTqoJtDifzjYjuEOSlNlykXYmEjCmiBwVUxg==
X-Received: by 2002:a05:622a:1910:b0:528:3186:5799 with SMTP id
 d75a77b69052e-52d768d5d2cmr2627311cf.10.1786628909923; Thu, 13 Aug 2026
 06:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812002728.2283079-1-irogers@google.com> <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck> <CALeDE9P1xZonVnZDExR_hMafd4mxahkjBVTDLJenQ6DKW5MSHA@mail.gmail.com>
In-Reply-To: <CALeDE9P1xZonVnZDExR_hMafd4mxahkjBVTDLJenQ6DKW5MSHA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Aug 2026 06:48:16 -0700
X-Gm-Features: AUfX_mxpNk_3iJtiE0EeIVhw8BTBZeCO2omT6q3DILEf19QXO8fjDxzqZ9-wBrQ
Message-ID: <CAP-5=fXd2HETe-484Pe5wMTGPiXbLheMaW6ZDpdD+YCtKoBHVg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
To: Peter Robinson <pbrobinson@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:08=E2=80=AFAM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Wed, 12 Aug 2026 at 09:28, Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
> > > This patch series adds an uncore Performance Monitoring Unit (PMU) dr=
iver
> > > for Broadcom AXI system and VideoCore VPU performance monitors found =
on
> > > Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5=
).
> >
> > Why are you sending four versions of this patch series, at -rc7, each i=
n
> > reply to the previous one? Nobody is going to review that.
>
> I'm also wondering why this is called rpi_axi_pmu where it very much
> looks like Broadcom IP, and is possibly used in other Broadcom SoCs,
> Florian can you confirm what this driver should be called?

I'm somewhat agnostic regarding the naming, and having a more general
driver strikes me as a good thing. Fwiw, I based the name on a
somewhat similarly named non-perf-compliant driver:
https://github.com/raspberrypi/linux/blob/rpi-6.18.y/drivers/perf/raspberry=
pi_axi_monitor.c

Thanks,
Ian

> Peter
