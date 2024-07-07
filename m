Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2D3CF4F
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jul 2024 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720380493; cv=none; b=g6I87yvHhLuxtqyJu0UXJIiY1LwA/Rx5Um4gfxQJmTZ9vlJl7+R8M0TwYCsrhdc6GJ7+48GiXQ23cLsaw6lA8K2MahSUbB5JriZGBWvGwV/tpO1UudDhsLQcJ7T5+Wz/tDjAAcFsc4nqArYf3trxO0bXj7/qsOJR/AMmuUOAzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720380493; c=relaxed/simple;
	bh=s5M8baUDqyA1frlvctg1yTBQJnCI2vcBFckVGyLzJck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swW50BzFiQCA/U+HpLxO0t8vW2qL4+UmeQvA2tvoDSRPxLheJZhj4acYxOR+b9jnneKgXTjkjzCsBrJQ9yB/q5u+H9ONbka+HeX03JIwttSlAsAoj1Zpdi1RLM2LAmCa8EbwR3Om4nEm12kvv8AJUloMyRMtL69lG57E2qVmMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fE0sRH1r; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fE0sRH1r"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so3138311a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720380489; x=1720985289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=elAeLkUUJDd1jGenTq4xk5+66KT/GBRA/OqXruArGRE=;
        b=fE0sRH1rahjLi/mADStBE3oPJUHqlJvg21s57Pzqr3wi4eCLZe8iKJk1A9C1oAN/Gr
         K5++o6qank1/ZrS8vgG/kcBefmH/QUaqbCD42JL7DDpurFNI/kGbNSyIXovlnEMMfM/9
         zqh7JvgXzpWtkGODmTfsvlwpPDZ++vYoUoaV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720380489; x=1720985289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elAeLkUUJDd1jGenTq4xk5+66KT/GBRA/OqXruArGRE=;
        b=FUAfyNOCQLteBULvqp/RYWa4bou7CR9nTbVSxk+7CPbR7P0gHT+cCNHs0Yw1tjc6Bt
         +YYPHSyBvbLpBlx9+QjhyFnBqvZM3RM5UU/ZD2mLQPdtOMWSfVuLCQsb/ecNIQMo4vpH
         rVdyVjiODKYH4seIoNcvLwQ9BFuDBnKkveM7xbP+slUL3G1kdmNpPEdwkAQgr1nb+V/l
         PKTI5tC8g4ssAyxwkJSfZPMi/yEbvBVJ+nzuAE6YNyanv+0OCmBJGjD4nOczHHwq6Ktf
         gfPP1PngKxSbKZAI7YovgOR7HjwZvq+uAEqW74BqAfbXZCr2+xDU38tkSR7tgg8/AQAk
         2qCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+n270r7Y4N8X4HDDlbfJZpyCvavRueF7GVBYvnBlZRwwCjoHOD2W9BYTo5SO/fFPGcaYh1lyTIcabNVlehifoKkcppZ1gM8Vrabg0efiVpw==
X-Gm-Message-State: AOJu0Yxb+Ex/9C3fa/GzBYTfZZIoin+DnhNGD+x9sZpkesX0W9CPZKfS
	Who8pOdtyBoe36VmxU1ubghW+GI+u3JP75zyAB/EXeux1NilABRaY99qpcWW9EfVvX165Y0pO80
	dQGpnuA==
X-Google-Smtp-Source: AGHT+IEN+UdDJKtJbE7noSfDxjqFCJ6j7FZ8PoMQC9G0e/NxTV7LaV+WMYfeeuEHiGHMU4KbInpkuw==
X-Received: by 2002:a05:6402:1c04:b0:58d:f7ad:f93 with SMTP id 4fb4d7f45d1cf-58e5b89b009mr4672110a12.42.1720380489493;
        Sun, 07 Jul 2024 12:28:09 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5907e4d79ddsm2414224a12.59.2024.07.07.12.28.08
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 12:28:09 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77abe5c709so397302066b.2
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 12:28:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1r5xWHmqiIfH+43pCve1R+DFR6vlS3LhH168FWeEQUgzf4xznj6u9y04AQ7QkiYp4VWJ4BYnwitFV2D+KZU44D0U/lIRFkQaRVvqD1F+7ug==
X-Received: by 2002:a17:907:94d5:b0:a77:d63e:d8fd with SMTP id
 a640c23a62f3a-a77d63eda02mr588658166b.12.1720380488676; Sun, 07 Jul 2024
 12:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
 <CA+JHD90fGLdbxno37FwVQLrtAiiZ=PZ7Wp5+1Du7SWBxTd3UJw@mail.gmail.com> <CAHk-=wgb-vX8g+WV16u53-yTp0dmMkOybndsWt=LMH7A8CMcPA@mail.gmail.com>
In-Reply-To: <CAHk-=wgb-vX8g+WV16u53-yTp0dmMkOybndsWt=LMH7A8CMcPA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 12:27:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy4VxGqeExovNJ0CdznSBOhKD6LHpfBhbo4fY5Pkjzgg@mail.gmail.com>
Message-ID: <CAHk-=wiy4VxGqeExovNJ0CdznSBOhKD6LHpfBhbo4fY5Pkjzgg@mail.gmail.com>
Subject: Re: Performance of 'perf'
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 11:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 7 Jul 2024 at 07:33, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > https://lore.kernel.org/lkml/172012303630.184013.1986960651509995819.b4-ty@kernel.org/T/
>
> Sorry, I found an entirely unrelated issue when I was installing b4 on
> that arm64 machine, so this is taking longer than expected.

I think this series fixes the problem.

Now I started my build at 11:47, it was done at 11:54 and the 2.5GB
perf.data file writeout was done at 11:54.

 So it's not instantaneous, but I wouldn't expect a 2.5GB file to be.
It's no longer "half an hour".

Maybe something else changed too, I only did the before / after cases
once each. So it *could* be random happenstance, but that sounds very
very unlikely.

               Linus
