Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794242353;
	b=dZDljvdS9HDAsX0VyyurFb4ERMvRdr9uLCmxLlAjuK3oKQKeLI1v2o2BLlL6/tLA8ZOh
	 CZ++Hb+eggq8TuUgt/ONHeH5/qaDI6ZBrhuQNiBeVL2ly0NYksHCo2XFn7dTahKUYXLk6
	 itMJ/lB1vV3FRwksycUw1SE6q2uuN6fgr53KkTRs0D0XP5mxt1qzM50arzsJB6X4i9vrG
	 ZKCI59XLg4bMqY9kDIMsmBVyuYUwjKnNiCIaTSFX4D4cq4yQE8JTUFdr11eEfI9yFou7w
	 Je+wPs0HOWh0BhBqebKg2qmoDybAFjt5t196/wixRdqJUEQGOzef3D0ZBQRsnXUQNmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MNALSUguKeNo/Ez0qP/sAmD0UeGu3ljjdxeLtNNj/80=;
	b=sdJHfid0oOalTaRYbF3xaNbls80gEfLLtl288iW6wBelJAygf5qh+dnybYrOkL6HeleU
	 nmkPrNrM6O4QBnhDPhEU3ePeFvDTlu5kD4kao0JZ5O0DiG8y2JLkXwaRygRZ6HBejw4C+
	 lFdJs4+4I6QiB9fLb6Mwunp5WTaLoBxnSscGdJNBmE/h7ZqIvP/YjZJb8IWqsjItSV9PZ
	 YWBicfC1zAUYjNJCuhAGwV+6MLr0j5rCHux+A51Nv2DhJMZV4RipmAabTWVBVDfssPoJP
	 ekojVISzMTQSKwn07sgIEO+IYkF50DwqyuXZe4G3OXPIuDj58CUh/U2wJkfHsUcR2hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V9ccdv3k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815C606A325
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 16:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0815C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V9ccdv3k
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5383c97c8cfso300561cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 08:39:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794242352; cv=none;
        d=google.com; s=arc-20260327;
        b=KS2VHam+77Y6wROwXy3i3zSF/XQOIzgNieMV18FopAFlyaIuGRIc3h2yalzoNcLpV5
         gW0jhyvd+K3jb5FQZB4f3na193Atq06qDlEhFUJgaQwWSbat9w5J9gbgjhPauXJl1qdU
         zEWv9Zh7DxlDJeePB2/I2+c3SMp2DtLrYR+8DRvAI11DO9gZrANgv7rPVO+EstWgTUuH
         95tqoBit/eRdJTwggwneP9Yx2X2i9Lo1+B1ds7fElXjueRtBvms8KEocE1YQN818jMW7
         fd/YudPOCyZocyRpdO1ZuZr8muZtzWEEJnK0EYy/CMVgyFCYq/89Rlmbsz6c/5PnUePx
         q6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNALSUguKeNo/Ez0qP/sAmD0UeGu3ljjdxeLtNNj/80=;
        fh=efcSfHEzVGQcimcHdQPtWa1dAZ3qQXLUu2tr5UrliZY=;
        b=noouX2/UA9kt+q8khe25AMwuUjX1ERCERlIippwRVrpix0EuAZkVR6YFIUJm3reGHe
         o7Oghq6ZVm4YKgf30dFa75ofmOw/WjtDX/241o5161gWOrbjjokS7kgxOpZlFGXDgByR
         ePEkZSXPMVyb60jIFPAS0AJtchFSYQvbKVzxuAj+uwhfDJKz0o2Gy1JaHUa6TcXJZWXo
         qWwXq7OZMIj6/kRIZ+oRXgwv32FhL02gJQki/VZKBvFITLETYg+Uzbk8O+v27UsGFpCG
         XbryjwusAUzPW5R4emeuWnOK/9uPWnYIotMaFwh0PpQz+91s3tqhQpvICRHG+t98PzU6
         fG5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794242352; x=1794847152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNALSUguKeNo/Ez0qP/sAmD0UeGu3ljjdxeLtNNj/80=;
        b=V9ccdv3kK/Lbx1Ki9SfCLupe5m4AB1kXkJnwHDXcTbTB5eivVr+DgayWNH46vmTbE3
         LAgIu6SrTtf0DK7WuYphsLXwxG8xDvpU0IdExkaAamByNth8mgXQjBnM00XZ0Dqh0YwJ
         nZtHi5UCl5R7zeQ8Igx4eFdV2oDs79h5bGJ5jtWwHM/Cn5uHcM348DGk3jx4pThKU2aU
         34NqNj7plitjbus8/7MEN87B4ZriRW6jvASOnR0aHKjYhUU5xT5XvubDw4KSVDMSRoMm
         c0bFTl06PloYMgngbUCB1SkXbW+lMUA+0O1Py2U5aEDtJ91AdWbnINpbE32ryrhk5GOo
         fbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242352; x=1794847152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNALSUguKeNo/Ez0qP/sAmD0UeGu3ljjdxeLtNNj/80=;
        b=PJ5aqO6LaKT/e53AXilrHhxlNowc99WzH1vZ69k1woydsW9n2PyjPZBZh5ABIhivno
         t4R3l9adZLAWRqmxd77Ju4GYzamHKx670BLOUnnZmEIV1AvfZgXNP4SKP7n0tFuCooZ1
         MCsykV6W9n+N880sMvF+bIomeafuHLd0XrCO/E/APYX5Y7T9cXqZeFCmJRLvXfJZMUnk
         1PhFCQkOa0P/eVG9xP333CcriSHyOu0DJBcruEvmcZou/cMdce20A8xHApDhzC7wZQDq
         qd5mMDSYp7Ea/36mOW9VfyF60ZLkqapZF262iHWbbWBAAs4FHP9Mkk8xISc9K5kwMG5y
         HZHA==
X-Forwarded-Encrypted: i=1; AL+hErGnG0huP2Qds4OK5GuMvE2B3M1B2q6u3ISVLwlvEgYYIJ+uTi77Lz++Gplr0MZ9IhMKyZXHAebBMUbuOvfPd0MV@vger.kernel.org
X-Gm-Message-State: APuU4Z8rPxyFbnxI0BgqhLaXTiMDcoN03oYrz+Hj57XRYi6lFueW006H
	I9peZtQiWROG+rx8E0+wJN0QEqwmICmFsApfEMsinLN54qFTHYBX0AoEVMS1VnSxeU029Ec7q7O
	VH1MFoDnEIBZUfWNV3k5EQ+2QI+NmcjOVmEgqobsk
X-Gm-Gg: AYBFou3ZkjbGdYeKXcwTMZuWl1pqPmKa2PeJfQBTtAXOvkZ0dOgJoYYP0x5d8SsGT33
	J5XbMs2/rLWMFVRpMaVr6qwzc1BOL2reguw9uB5ZocaDKgtTsUi8W5nG1ANAwec5Q/UE5Hf/Dhn
	hF080iosdPuh4FhlrYOskZqLj5LFb/CfHxZnOizLdUMyN1Sw5cEW50/anPz9n/ShyvjRnmUhpEo
	sEEeGm6uXZsnHZAU7k6oL0PDkhSV8suWjvN4trnt+Vo13B8Ini1E7BXCUrY0oiPJudD5HT8WHZP
	5RtDyX1kEHvgVn6Kg5s08lONzf7cByWE4o4aoG/o0HDLCVF6C/KItCchgorM/v2FhLDpBKRZV65
	mUNf/pKjjP0i4hfPyWeLXwSYrSmFS1MIwP6+VsZMMKYWJzmlPTB+YQJIoVwj4qNNiMew=
X-Received: by 2002:a05:622a:2b4b:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-55519d553afmr66891cf.10.1794242351337; Mon, 09 Nov 2026
 08:39:11 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109080126.417161-1-irogers@google.com> <20261109080126.417161-2-irogers@google.com>
 <179423587020.3133545.6594248101575070050.robh@kernel.org>
In-Reply-To: <179423587020.3133545.6594248101575070050.robh@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 08:38:59 -0800
X-Gm-Features: AclHuK8feNx1zDrXSRA0wP-1jAG_C3k6aMQ0LXM4MGvjXYCUb91zzoIWLHYo0TA
Message-ID: <CAP-5=fVDVds_q7NjAcapJw4pUx2psF2c9AsaKZC7nJbcOHOJ-A@mail.gmail.com>
Subject: Re: [PATCH v19 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI
 PMU definition
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, Dom Cobley <popcornmix@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Mark Rutland <mark.rutland@arm.com>, 
	Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 6:51=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Mon, 09 Nov 2026 00:01:24 -0800, Ian Rogers wrote:
> > Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
> > found on BCM2835, BCM2711, and BCM2712 SoCs.
> >
> > The hardware exposes two MMIO register blocks: the primary monitor
> > evaluates the System fabric and the secondary monitor evaluates the
> > VideoCore VPU fabric.
> >
> > Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> > Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../bindings/perf/brcm,bcm2835-axiperf.yaml   | 44 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++
> >  2 files changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835=
-axiperf.yaml
> >
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks Rob, and I appreciate the testing.

Ian
