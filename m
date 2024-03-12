Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B057A72D
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Mar 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253411; cv=none; b=TYp+ZQExT9Bd+lRaobFxFfTvZS0Edal8WNhdIoxqLSUvt+tU/hOG0VeTncBzRxtPVH+issDEHCK9ko9w/D8ebAxdtQgEADZPX83jnGCk6cBzyqcobMHgp0k8uPJn5cQGKEKG68eK4gXRP3IB/xiz+Tkvh8kBhr7I1qJNyOKRFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253411; c=relaxed/simple;
	bh=gf9yMtKzRBlOhLL/fmxIguN/CTFdrmIfHjtFEg9Eo+g=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=CmVtRYGZ1dF/grblBYaoU9VGJibosesooRfaUQqX15EQISvLhfDZe1tcCBeLqtAVmOUB4j2rxVgO6LCzO6PYkBOtamejhUx9nHA+k0aEX1lPjTpnAxTc15u9uGHelzUZxrfFcKY5Z5LGv7dSNIj2HhFsAivEp9Rw/UpN8dtKUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=yPI9Gd9b; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="yPI9Gd9b"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dca3951ad9so45494545ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Mar 2024 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1710253409; x=1710858209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ixjDXdUDhwXI0JLFZkupTe/KFpB3Bws3seOjqAl5dc=;
        b=yPI9Gd9b0/sHZX4nK0ssdhSH1TyxAh6WrCWLTY9SS+lNVJPhJB+BVACb5H53ie+hbX
         hYBweQcZp3gfut0+IYunnyabD75TuihKhTugYI+PbgBwFoJLAbIR7wT8AGXeXE45NtWF
         pOmjMW8c4dCHy5g3DCZ0kv5itqwE8MzLpT3SJ+LQ2MyK41t6qjPMyCIIK3CDTeIrGNrs
         yOD5kBdcGWRVcRflPZDnHFNDWkVVTzIoiNUERgaBjkJpmSUOOkioWDiwT1934PY94t1Y
         PU/BGcuI+lqwUMYyBJj97zSnOFPuYX4dEX6rmy3MpNW/5fFzAOlralB9A0vqFGhL4oGO
         J9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710253409; x=1710858209;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ixjDXdUDhwXI0JLFZkupTe/KFpB3Bws3seOjqAl5dc=;
        b=kYj02O7BSa+4ErgXmLP9wELPWlC8NpXvodHOOiIi79Kwb+sMsJwEQOwOWXMc6hf1C6
         ImUoYtc/TFbJiGOJbPwqUx2QoX/fbrKoL9McCr/xvYA0mC3lKi+RDYZ21ZcroQ6MOQ8C
         W1S+Hhk8Ou0YczrGDnViq9ZOa8B0Qaq7uMVFFaL9EmKZm4NqmJZpC2/5dKPtSPq2u45+
         MaIIVQScYNg2K+9MBccVvP0fXbAsZohrCUP1AlocxqNaFTjr68IU8vIz7WKUFRIzlPk0
         r7WJav6Ae9qg56PRZf5NS1wcTHb49dsEDGIvNb7gVnVNA/JM8/vp5BChdH3N1orjo+pS
         WMFw==
X-Forwarded-Encrypted: i=1; AJvYcCWztUrDew3gUu18eJF93wxsFqSC01Ci0ZrJGZ2GP8YEUNKw2BB0vGOvKn8Qw2oD6HSyJgTq7ywwLI18H+iP5iODymLrCzlKB6EU7CXsAn/f7Q==
X-Gm-Message-State: AOJu0YwXRTwvGQFyY5KhapZ/zJfqLpuzE5HiYEyBu7XtpR4KDmoC2kmH
	MvvgC2DXbVaP27ZD+Fe4yL0FbG4jo80SCs0lLWIfRXHrr7LJlQBahqBrXBfMENM=
X-Google-Smtp-Source: AGHT+IF5Tdh4z8JQsHyW1PPsqQuYiflOdAu+RNp46pn6g+B0xVaFC5Y6Ggu7odCPQpbbShIDcpWR1Q==
X-Received: by 2002:a17:902:e74a:b0:1dd:a134:5680 with SMTP id p10-20020a170902e74a00b001dda1345680mr6869873plf.69.1710253408730;
        Tue, 12 Mar 2024 07:23:28 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id jy8-20020a17090342c800b001dd5806eff3sm6836433plb.306.2024.03.12.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 07:23:28 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:23:28 -0700 (PDT)
X-Google-Original-Date: Tue, 12 Mar 2024 07:23:26 PDT (-0700)
Subject:     Re: [PATCH v9 03/10] irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
In-Reply-To: <871q93eehn.ffs@tglx>
CC: peterlin@andestech.com, acme@kernel.org, adrian.hunter@intel.com,
  ajones@ventanamicro.com, alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
  anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org, conor+dt@kernel.org,
  Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
  Evan Green <evan@rivosinc.com>, geert+renesas@glider.be, guoren@kernel.org, Heiko Stuebner <heiko@sntech.de>,
  irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org,
  krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
  linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
  linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com,
  Mark Rutland <mark.rutland@arm.com>, mingo@redhat.com, n.shubin@yadro.com, namhyung@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, peterlin@andestech.com, peterz@infradead.org,
  prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
  Sunil V L <sunilvl@ventanamicro.com>, tim609@andestech.com, uwu@icenowy.me, wens@csie.org,
  Will Deacon <will@kernel.org>, inochiama@outlook.com, unicorn_wang@outlook.com, wefu@redhat.com,
  randolph@andestech.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tglx@linutronix.de
Message-ID: <mhng-d47edbdb-0a36-4adb-9575-8af094d80e5e@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 01:06:44 PST (-0800), tglx@linutronix.de wrote:
> On Fri, Feb 23 2024 at 09:54, Thomas Gleixner wrote:
>> On Fri, Feb 23 2024 at 09:49, Thomas Gleixner wrote:
>>> On Thu, Feb 22 2024 at 22:36, Thomas Gleixner wrote:
>>>> Palmer, feel free to take this through the riscv tree. I have no other
>>>> changes pending against that driver.
>>>
>>> Aargh. Spoken too early. This conflicts with Anups AIA series.
>>>
>>>   https://lore.kernel.org/all/20240222094006.1030709-1-apatel@ventanamicro.com
>>>
>>> So I rather take the pile through my tree and deal with the conflicts
>>> localy than inflicting it on next.
>>
>>> Palmer?
>>
>> Nah. I just apply the two intc patches localy and give you a tag to pull
>> from so we carry both the same commits. Then I can deal with the
>> conflicts on my side trivially.
>
> Here you go:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-for-riscv-02-23-24
>
> Contains:
>
>   f4cc33e78ba8 ("irqchip/riscv-intc: Introduce Andes hart-level interrupt controller")
>   96303bcb401c ("irqchip/riscv-intc: Allow large non-standard interrupt number")
>
> on top of v6.8-rc1

Sorry I missed this.  I just merged this into my testing tree, it might 
take a bit to show up because I've managed to break my VPN so I can't 
poke the tester box right now...

>
> Thanks,
>
>         tglx
