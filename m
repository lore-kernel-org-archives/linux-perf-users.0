Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66721FF3F
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923895; cv=none; b=Yx2pjVqnQ3pGRTEXLXc481ao3Ulgtr8qmY8J3Ggi9+1kwpTDWRfX+0gQ2AQdSv8CSOOLH910q1ABc9w9F8gmYC3PF2yuHJdbenVDFpGMVmHR5iSAA711u3q/G3Pwokdp7mZtrJ/Dx3sfpLyZeUGFbttmej9lQOy7SA4r7csiWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923895; c=relaxed/simple;
	bh=Dwo6JeQuN03rtqKJJ6ttZV+PoZ7zgPamRHnYZdq+qas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMYzXy8pnnLtzUR7Az9nmvkEZ2Ww1hS1k0mW/GHo6hg35ZyjWgOe+p+J/mP4xZsX9l7Js136ti+uymUFizyfvE6kN4ls+x2sw+704iBKQz9xdbHICTpcALZ4YKnK2IyMZQppPmARH5qhYoIT1y8oshUmN7NbKDylIXUmyNjYhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONYQfrs9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONYQfrs9"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65941c07fb4so151561a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 11:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770923892; x=1771528692; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L7fegrrYVrLK7MrY18kiCOAGYiUmZMy3K/iLr1h/Lck=;
        b=ONYQfrs97QEnUk0iNYpINVMY4gqFWQy6/VuZlGkgi3s1SUL1fj8BBKXt/OvjYktDPP
         9LwmL3M7AVXEZQxN1/R9eoLcHt77093FonUmGaJf8oZt1tIMyfS0R3T0kDvfxmugV4/9
         7Z8ymh8uIykc/aZIr87A9xYpiAq/LHMrGnSdEyrLXiMGZiQn3/OhFqANY3DYBdZqq/ar
         6z1eFpG8XalE1dFrM/lYfhTHQo6R7Zdtv7tFM0KAeAFBoehMqFcF2td1KsY3lhWJUZlO
         HGby2HIKk2Id4dGef13cPrUQxLBkpuwBpu4c8Y1MJ6aSeQNAVTbZE6Ajm2hcEwjTOFvQ
         S9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770923892; x=1771528692;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7fegrrYVrLK7MrY18kiCOAGYiUmZMy3K/iLr1h/Lck=;
        b=AC8IHmfceEGIUgJblzp2AcpmiwHZsO/byoq1Z4LrsFVZhb0UNYYgWOsyHgMq2SuhYY
         4CI2kOoZ2QxiK7pXW1j+ps+GZufps2MAFS/UxkaCz8QwAXox+yDNgU713KxcOaDNeLLP
         Ft3lPZ0dV2rkid9Fuif941f51ci3o2Zkp2zFM1FYm3RMEiWwP2wExEZhHjKZV2ry50GO
         2DVjv6zwYD0GaNzC4ikUxiL8iCXu1SK7WXbrVx9lV2o1/HW4Z5RRw8CM1oCj50CdLr0H
         N0PyqDVEb+MSY7FqjhTOTdwC7V7WpO2f6lpWccIUq1g0vks9l7gOZoVEg8EHQPEqFuRh
         ycJw==
X-Gm-Message-State: AOJu0YxDix/ZWUUd5EpzvG/I2QvQfST8Its2/UNH4ku9FysLVLD0Fp8E
	XC46NIVXk2OubGVVdz6JHIm5AAd4AZVaDv1oI8Pkp5waWdiOGEAeylxW
X-Gm-Gg: AZuq6aKTnYq7Ny9HNuOKu5083jkXINZVPQDT00AszBsIDq2XpNXLUSxlfXUhYFj8vyI
	8k+OPoJdDKLY4ZtEIk0cm7JBV2tNS2+i+oa0qu828OrkLG/9Lqz107U1Zt+LKIiWIZiR4d3Medx
	2XinnaTFQyLZWNEwuqXxcuYZm7a7zDeA+0wVoAB1UgpE/ITy+nN3sVGd/zxzDi/Wit+8fjADPtg
	eWgwfdI7Ge1HMzfevMUa3BlqxG43QxMqWGWo4hIg6QKUlBbNBqb8nKlPECoIVYMKIlxBcCWQ51R
	ejU1qC9fV5Tz4WvTKfroMOREfvcffsCnY4bcUWs66CyWnqwQmibjYn9y0CBtPQMZfpqkJ/8nMEA
	X01PxYdC6fKEEw4qsCYqtJNVaGgeHdg8q/UEHcOf/Ezip9m17UXZKx9W7ZFPxWGI4opmFNzx0SK
	NIdXnqkxrKjM3ZjwtuENUkTh/fhGtM2LVmMGjmnSjhpjA0iCYYLyDTzQ5Z5N89tjFEuvJ7cKpEo
	qFsq09/pdfLH83pQwmYTWmxEpBIBy5WZelF
X-Received: by 2002:a17:907:cd05:b0:b73:9280:2e7 with SMTP id a640c23a62f3a-b8facdcd808mr4941966b.34.1770923892195;
        Thu, 12 Feb 2026 11:18:12 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f7a48890esm162938666b.65.2026.02.12.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 11:18:11 -0800 (PST)
Date: Thu, 12 Feb 2026 20:18:09 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v1] tools build: Fix rust cross compilation
Message-ID: <jqbrvllvq4w53qkbvk444gtwldsv5zvxpqaxmjsl2qnk6vnt44@ouojmbn4af3i>
References: <20260212185810.648364-1-9erthalion6@gmail.com>
 <CANiq72nmzYkHpLTwWxn71TKKTPxWprjPHxBau7Yat32P0zE3pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nmzYkHpLTwWxn71TKKTPxWprjPHxBau7Yat32P0zE3pA@mail.gmail.com>

> On Thu, Feb 12, 2026 at 08:13:25PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 12, 2026 at 7:58 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > Note that CROSS_COMPILE might be different from what rust compiler
> > expects, since it may omit the target vendor value, e.g.
> > "aarch64-linux-gnu" instead of "aarch64-unknown-linux-gnu". Thus provide
> > an explicit RUST_TARGET_ARCH, and if not specified, try to match
> > the CROSS_COMPILE value.
> 
> I would suggest explicitly doing the mapping automatically, rather
> than guessing or requesting users to provide one more variable, like
> we do for the non-tools side.
> 
> Perhaps using a "table" like we do for LLVM and `bindgen` -- see for
> instance `scripts/Makefile.clang`.

Thanks, will try this out.
