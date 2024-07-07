Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6CF3A8CE
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jul 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720377761; cv=none; b=aOSnFanykr2UEqu/dyO0hTrBE8de5NGWuQjd/3E7O4nfBIj8yWYZnhQD3GSIatnMzcNgRtTLbuTqDMWiZInl7toDpYLDZ77D2li4aVpd5DI1Dq5Zh/siijWCKMUW6YPg+FcICSXKoktcTepxkQxkfE9jDD5agG6tLqBUC2KJ4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720377761; c=relaxed/simple;
	bh=HclCobLDoAb38Pqq9t8DhnnLYZr+cSLuxdOk92M1vPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmeU/rHoAWYkyOxbejfbjvpYuuWiKOyYL9aSx9mRWC7JzUSxvtjzFd6/G2g+UMxlcCn6s0nL0nbAU9jYpU6ctAu0r4DWK0QiJpUdPPI+oFeUmNrIekpzIkjK/DFlAQ4Cu5INGXa5gBK3gNEhw6jh92VzxGGFLU9rOjlGEzEoyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bt0Chw7r; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bt0Chw7r"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so2907709a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720377757; x=1720982557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ8k2BMSYrnl1JAgFfH6+xIOa0jpqIsnJz5HnLiWIrw=;
        b=bt0Chw7r4JA4ialxp+Me9h1kqp2bkUaCBChvQ2VddfQzOta/GwCUMLuS5NQDXn2O3W
         AKONZ0keOuHYdHWl6UP8PkJ34NSBCg08Oum89a+chicACw3unpTUNW6tjTzQ3mj38/pY
         93ddr9mZ2+izwgxP78NQwFwnwP3+MPUmF/jOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720377757; x=1720982557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQ8k2BMSYrnl1JAgFfH6+xIOa0jpqIsnJz5HnLiWIrw=;
        b=PSVBimAxVBZtwgxc4KujhKstuLAt4326cPvu2vO9py7F8stqHrvISIB8jDugQEmKgT
         eZ/FqLlzIerTuOS5TuVcCFV4w1RdGcig0g2tEOkgMuJ3gh0zIU5bzvtb/0aobR8HHIxi
         IIOzvFZjIZRV+C/T1JtdsUDsJZ7DexPzayVUXKRMzE17mlfarfFAXocp/Y3vDD1V4zxi
         ejyAqyua67dpviHQ+0tvR84/VKsIeGoTpqMHpfZXY+AalflbpnNiqcEpQqnSe6OeYuzT
         WgFFXMR0eDZlHXgsrmdWdcUvpbGFGzFVilkdLouzriHqvWu7eB3XU+4mq3fouAmUFT+G
         JlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVNYbFxVCHaI+beLeUXsF3swAIIKnDgTrDMXAu8IyRQeh6OLqkWt8fAbwdYoWqQeriVmqJlZqFJikn5qZYD14XrsCXxEjDYrU7M4jMmk6dBg==
X-Gm-Message-State: AOJu0YyIs+wrBVqSGyC0RxB5CAy1/0kWOB3JNrRmyUnqyHkKmb+OMYej
	TQQdyALqH2E3XumuEfF3t+2oWzZfQ5vV5XQX5GOD/jHEMsbrD4fGJHmoImNsW1oBpovO+zKo70y
	NvHFBzw==
X-Google-Smtp-Source: AGHT+IGlvgceXb9UZ/to9LLwzBW6NRt9onM6bm3aKTbVDW3r7YMZtRYSUXB8pSiz6QPd1QEEIR9o3Q==
X-Received: by 2002:a05:6402:2353:b0:57c:c166:ba6 with SMTP id 4fb4d7f45d1cf-58e59b42805mr7701920a12.19.1720377757376;
        Sun, 07 Jul 2024 11:42:37 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f08esm11894574a12.27.2024.07.07.11.42.36
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 11:42:36 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a75131ce948so388500966b.2
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 11:42:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEmTvbtwsGKhgSWAcvRlQOVR2xlv6Vc4AKkN5cE/dEmRPfCosnN5yZghI4lysO5JWc+0M0rrYjlT0QiGUDUNSBuJlu0u9YmGR9Sz5hStePCQ==
X-Received: by 2002:a17:906:40d0:b0:a72:5bb9:b140 with SMTP id
 a640c23a62f3a-a77ba7123abmr621285966b.54.1720377756480; Sun, 07 Jul 2024
 11:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
 <CA+JHD90fGLdbxno37FwVQLrtAiiZ=PZ7Wp5+1Du7SWBxTd3UJw@mail.gmail.com>
In-Reply-To: <CA+JHD90fGLdbxno37FwVQLrtAiiZ=PZ7Wp5+1Du7SWBxTd3UJw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 11:42:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgb-vX8g+WV16u53-yTp0dmMkOybndsWt=LMH7A8CMcPA@mail.gmail.com>
Message-ID: <CAHk-=wgb-vX8g+WV16u53-yTp0dmMkOybndsWt=LMH7A8CMcPA@mail.gmail.com>
Subject: Re: Performance of 'perf'
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 07:33, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> https://lore.kernel.org/lkml/172012303630.184013.1986960651509995819.b4-ty@kernel.org/T/

Sorry, I found an entirely unrelated issue when I was installing b4 on
that arm64 machine, so this is taking longer than expected.

But I'll try this one asap, I think I have the b4 thing sorted out.

Considering that it did seem to spend a lot of time in what appeared
to be sorting, it certainly sounds promising.

                   Linus
