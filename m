Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8314A60E
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Sep 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726958409; cv=none; b=sZQWrGzUzTQnrF6KND+Q3mLI9p02zpwJNikXFTZICE5HLHEHRpH09MTepWkxX09smlohu519YMuOoxO1MiUT88A4s9zsuHxba1lcsjmN7p1t0U+SbSzOwR2IJK3DLnJvUv5sLauDCjeg5SxGOBdM+56uVT0X1DKfgHqhqA7DVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726958409; c=relaxed/simple;
	bh=i6UGHvn0NlCb7NMXzSQc6lSGYWO6d8Nh1O3SQketvSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL6RjYeKQwH48rTKzp7Y2TWxznikEc1XccAfAH7PjPBcLMdCqMgMKy3bnZqigYscdOA1JSZIe5v9pI+srf0q4Aw7V9knzKpU7/9p34APQegsOp6ctbiA6+2gPspiyzG5qSxROkgGNlUi9A+6UPYwnkPLMqpR5aVp5H0yRDDUXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a9jNn4gA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a9jNn4gA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso3902711a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Sep 2024 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726958406; x=1727563206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=plt1UiMUWuPsIzwz+72FDwV5eGBDH42f9ag0oCj0M/k=;
        b=a9jNn4gAFAEhQzsyx9UIdaOig6yZS276LrJUvl6em/jJVAmZrYLsIY9Q9w78YnI/C+
         F1YFJ4QHXTITyUw9+uvr5OLA53NBsUKqT6x3legPHqcAGsHFkWyFvu4IKx+ZVR+jSnWU
         bb2MC2F/z00HuIRQ8Njk35RL63Vu698ZgbVGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726958406; x=1727563206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plt1UiMUWuPsIzwz+72FDwV5eGBDH42f9ag0oCj0M/k=;
        b=qsPy7KnXccIXcSjoiwqg6Li5fiHWx0PfPsSmrBHFXw9xphsKOdhlFx4bP8lcRQeqKL
         tRaQ7xUx25WaNa+tLpJ9MnQWZsmesWYYrO+JkqepPdcxKlYf4zUh91SL4nI4d69bmn1e
         bwHB/auyGlBkDsUe4Tla1ajiI8qOwEkx1y0ucyvc+PY8pJ/DQJM+KhaJVO11VTL0mrdJ
         TWkR5IU7hXkJy3Jq3YrWsip8igwBCCi61E6rc+Tt19W2uF2HLKiAnBPdraEHqT4uB/hi
         c5I76HhAef5xbqV7SeJUpGdjxCZYo7Kv8lJZ++z4TR4Fmm2/jdYyxI7xWAGDyamuUxZU
         dgxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Dlwx8VYPVeWYtD7/BP+L2oSk4GyEtSDQmAcf73TtA7MnFBsNoPg0mDFQN1etSrs/K/BVUpCpjw6Xz9IqinBj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6P6Ojzzvd9zzrv9hAATcnsSPZH0eP5OtRWDM0cxeBI67bKwM1
	l6/ustyKfPXhrgJq9gYEmVCbISy8dZhbdsJiav4+vfzG8r7VfX9200tcnS6WflrRQwKBnEMD9LD
	jjhw=
X-Google-Smtp-Source: AGHT+IEhEQtwcVqJjsPy1DkeLilcA8ITFbBUuEe4TxJ2YakAn3cB5GJ7KYf+kmiWhZJEkc298F1XuQ==
X-Received: by 2002:a50:c8cd:0:b0:5c0:9fca:9352 with SMTP id 4fb4d7f45d1cf-5c464b79923mr3597429a12.36.1726958405700;
        Sat, 21 Sep 2024 15:40:05 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb497adsm8664163a12.14.2024.09.21.15.40.04
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 15:40:04 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d56155f51so368504966b.2
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Sep 2024 15:40:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+Tw8RZnWbqH/z/h84w0DGsuMId106FCAxca93GQic4wQWQFnlAi8OSoR9hp0nEMdmFuo7LyZ0EJSyn7F17cOu@vger.kernel.org
X-Received: by 2002:a17:907:d3e1:b0:a8a:71d5:1094 with SMTP id
 a640c23a62f3a-a90d50eec25mr626803266b.46.1726958403863; Sat, 21 Sep 2024
 15:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com> <20240919082624.05ca5fd6@canb.auug.org.au>
 <Zuv0kA-um9ZT-Tjd@gmail.com>
In-Reply-To: <Zuv0kA-um9ZT-Tjd@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Sep 2024 15:39:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
Message-ID: <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 02:53, Ingo Molnar <mingo@kernel.org> wrote:
>
> Thanks: I've queued up the fix for this ARM warning in perf/urgent and will
> get it to Linus later today.

So this apparently never happened.

I'm back home now, and so I now do my arm64 builds too, and it is
indeed failing.

                Linus
