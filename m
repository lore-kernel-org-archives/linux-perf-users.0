Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E331E379C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737383526; cv=none; b=Adml8z4eQsDYpaGwG4Osk+zf8HMQw8X8VfLa8oDjA1jjEFRPA5E9+zexo7iqPhTcag6SIE/1nfWSLTH4MClrc8D5HTgnoHK057+gLoJgC34iQ6ZqGv58sBc1+/xGq7iI6xLSvQD9JZAs3Vb8AAvuIKZke3P0+xYkGhEB1xsuO9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737383526; c=relaxed/simple;
	bh=UGyMBMcIVf3YgdAAAO8SDGM93mxs4lAxVLUuWtcg2Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuiQvcGqW/aj5wI90sjo1bTBD9a41eWVUUHzDNnzpv2YrHvHE6Xn0Cpk3eIvd/00cQeGBt3zDMO+42EXitgVxsWccKPwQflMsVdw0Aae9nwvW9lN6VM2y7RTIlwILiXOrO5oNT/8xRotlkluQHi6hVQNCGi2Jy2J/oq1DrRSL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rWy47mSJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rWy47mSJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso32472245e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737383523; x=1737988323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiZ9AEMIpIBal0pgB9YcdYzwMXAZ/sY3umvSjnZjx/4=;
        b=rWy47mSJss8m4YqDU2ht3XSS095XAMJfILnU/TW+AG/jVc1QiXZIPX5BYNWjWsz3B2
         ipJvKtsy56Hlyml7OTZZ06je2FJuMBxUkoQhrmS+ISEpdSIcufWDEt7xxoPPf1igGqIM
         K/7UGUW/Mt+OZe/n7keANn2OvvMUkFT3hvSaLQbn0DVkwtQ23iQzW5JacIZTy4+uWhdd
         4bn/yeANNlPog3k4XfgrExS0Yih7fNQ0JkBjKb+0BKe47nUqOH0ScqkIXyA9YeN3eqhz
         A9h3WFKEhCXiZUEI+usPW4c7Llmeb846K9Hc4c+idlrZ4jeLEkznXTAtgGMoM7eVmf1A
         sVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737383523; x=1737988323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiZ9AEMIpIBal0pgB9YcdYzwMXAZ/sY3umvSjnZjx/4=;
        b=ML6jehULkN6pshV2uqv7+KMB6B3itlNyktvVMvDZM3xzR/UHPTKia1yIOJv6Bwpkzq
         l5doGgLMlVhA8xUtVtRlxcsEgCnSUEIV/5oTLwCVdDYUCeZ/pAFqGiHZt0jxH7d90yh6
         bhEOvA47CSczSKBvNC3ruVGGSAgTGTlyzGGOrqN7fy+CP7Eu3ZE1dTzgZCT24y5n+/d9
         hxobqCqSl7O4TEjn/VAr1Xj4DZB07Vn3xD+veh5TPAsPcgAeoRE7MqWamIBO6vBsETD2
         6sxo2dwJ+f9WoNg7TrWKWzVxEcia4qsFfjb/2vkqSIDvG8LklzE74R5mVZh42ezuZcfL
         gY2A==
X-Forwarded-Encrypted: i=1; AJvYcCVbqiJ5SGd0NKzhjPLDIy/eSI6gJ4yEGzZKon/VOloZ6ctPfPI2kk1diwk9VD1767/zEdYHVESyzHXT/25AC4Lf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4uz+0cbMHXgTmhrSqEJG1k7hp64slpISDXPwcW+5u++37wkRc
	dpsrGtZ3hBxf732VV+13joSH3GuqQxPY9/QYOHtTyA9aUVOOOazgEOLeY+QlBRV7M8HOseeyJ3W
	uJQWJku/zxyRk7DP7seSYcC3MDKi4xVcQe1mAoA==
X-Gm-Gg: ASbGncv5zaljvswcdXcjwkk90l5h/pEmoneglb6yFSF+sdmzfgdeu8IFUIVo/PoBltu
	9GCMdIIGK+KBCEELZrOpvdJkSme76F3wBqfc2P234wO+1XaMxSg==
X-Google-Smtp-Source: AGHT+IGKxzJfAaMej3lPo0df14bMbqPv00NKhWrfw8R61+wj18jHSezj1g2Ch9RDv3IkDJmq5dHO9gQpVTF15GTc4ms=
X-Received: by 2002:a5d:6da4:0:b0:38c:1362:41b5 with SMTP id
 ffacd0b85a97d-38c136244cdmr287147f8f.6.1737383523208; Mon, 20 Jan 2025
 06:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116230955.867152-1-rkanwal@rivosinc.com> <20250116230955.867152-5-rkanwal@rivosinc.com>
 <a6b584bd-d136-4429-90af-6c5cfaf47350@kernel.org>
In-Reply-To: <a6b584bd-d136-4429-90af-6c5cfaf47350@kernel.org>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Mon, 20 Jan 2025 14:31:52 +0000
X-Gm-Features: AbW1kvZInqdQyKkStOI76x1AjV5KU_we8C9l1vTVnN92-zuJ2K0hpojm3xHiJZI
Message-ID: <CAECbVCu0qmCp5fVhkWE48R8xsC7cY4EjS6Rv0tqe8GP8DeZAZw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: riscv: add Sxctr ISA extension description
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ajones@ventanamicro.com, 
	anup@brainfault.org, acme@kernel.org, atishp@rivosinc.com, 
	beeman@rivosinc.com, brauner@kernel.org, conor@kernel.org, heiko@sntech.de, 
	irogers@google.com, mingo@redhat.com, james.clark@arm.com, 
	renyu.zj@linux.alibaba.com, jolsa@kernel.org, jisheng.teoh@starfivetech.com, 
	palmer@dabbelt.com, will@kernel.org, kaiwenxue1@gmail.com, 
	vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Sorry my bad. I will keep this in mind next time.
Thanks for pointing it out.

- Rajnesh

On Fri, Jan 17, 2025 at 7:26=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/01/2025 00:09, Rajnesh Kanwal wrote:
> > Add the S[m|s]ctr ISA extension description.
> >
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> >  .../devicetree/bindings/riscv/extensions.yaml      | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
>
> Best regards,
> Krzysztof
