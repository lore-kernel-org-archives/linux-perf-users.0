Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CE28A2DC;
	Thu, 13 Feb 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470635; cv=none; b=D3Cj6XLuxD4kb5WHFEmFtJUYc2FE24bzFKUkEECcjAe4OGG5NMiJFfYZVNYDDGTIlbRTJsFnQfxeAU6uoqhpw5F7iuF13yQHx1Jn3E9tkCtFIAuzjI3bwfbp90XBqnw/fe5AovieyPdzck0nJ0pfKVoLEOT9mX/tupNmsmQ1exU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470635; c=relaxed/simple;
	bh=rO4GIpGT6liY8W3nr+0xOkaybz3T+Ojxjd2+DuonTb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgGKt/13lvrNKu2Pl+Q4KP19neM4l39qwdiyQPLSXm86ZlGVex2vOBDtdShI0oAMRT3NY1qsJP4Nvlq388Il+NfM0X0P2AedCJfaMn1oju2bNDZRajttlNL8hPwcm67Csumw+EU5DaJI+phNp19LJHE1YmcuCELqk+nceGTDJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI6qoxeP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI6qoxeP"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de74599749so1806855a12.1;
        Thu, 13 Feb 2025 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739470632; x=1740075432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m9oFcZ0wUohit+9FMqKFVcVAGvuipnTtAY3MFUUaXek=;
        b=GI6qoxePG14Xa7fG5+aRTHdRLXgEQyukttvCpfQV8RnCjfrNeuvuO4s6TiTA/AM291
         dl6TDEOVzHE50GrycygrhV08Cmh96Bw5BgVjkDF6z0UdjgFtmkf0kvDQSCZPyNFJQWuk
         Qe29JCkYXRYOEPWEefEhWFibY+gU5kwKGGwT6oa/Vm27IY/z+BUvm7euqYBea7Cj6Shn
         nO6ccVgquNyRxRe+6CrKNjw5jFBHWZ/zR3VfYWsizUGo9eZlpap7MD7eN0Eg1Uiwyp6F
         FzBDY7nIPSDcddk4eoYOY+ZDxgta1nfagoQlG/+WDSn0YRrmhaM8ommqWN9ppCUoVgnu
         8Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470632; x=1740075432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9oFcZ0wUohit+9FMqKFVcVAGvuipnTtAY3MFUUaXek=;
        b=lzRNzNZouwUv4l7ePmL1X6N79EVcmU2g5Yrs4IulkcAjt4Bhxw8iS3b5zKu2oyJi/t
         3IXhHLQh+behvkgJ7puxIRI67d6N5b9XT0FIaL3rD3jJccIjE6KH1q6WXhWfbJvsAnXM
         I1BoYbYUkwR6VnVZdR+l00finMRGT23/wSrA9E54xnI6tQyAwuwpqYsIyRNFSGf42t6O
         oIi193ZaXa9EfyyZOTyzZR43YqHyAcAK3kCvcDsncWbIsWpepNYIyc2iKqyyC7V/EjR4
         ZVTOSGzsRjAO4ZmT327WePL7xkViWNAstoM7IazzF15ofthI7PpmV0AYdSc9aAyXdVvQ
         XBBg==
X-Forwarded-Encrypted: i=1; AJvYcCX5j9KB/cXQHa5ZcipVlWW7+BlzvGwYX2OANUHu7TrnCIatUSQkQXY7DL7eY1WucLbtkTNpoX8KhsTBG/0C2jEEBw==@vger.kernel.org, AJvYcCXXebf0f0Vw2ehJKkchgGEIbU2WdQjS0BVDD8qoysAguzSD01R6dMi7WuQEsvfQ+YZmYpWxDVTDXYAPyhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoerT6UGiVhQH3wH7cl0rdBN4hXdKJeU6RMZr8i3ZMQBd3R+Zo
	CgN9WYO0bkL/zaL+wklfBvcOta83fZp5MUBfFcpaGs1y26j9d5J9xSlSMczwmRMGsk6PjVySePZ
	sibpj2lN9WvYBxwx1YHh0WnrRb/c=
X-Gm-Gg: ASbGncuZy7IzLWCFyWTXSsqaTUx8TuKhR6bQjosDIq8G9Hg2tv12NIwotuGbDMTi13P
	sd0d2dPySTlOFJtGJDXAeB8V66ShpwoZfC4h3oWdFaXass4ah3t4nzH3XrOE1nC7QufR85lqZyQ
	==
X-Google-Smtp-Source: AGHT+IEc4dO0lMF0x7NEcpRg1b6rnOyQiV1JT5VAtF4BRvAzpI3AeIG7o43UGsV6/vI/laJkci8pTqCSmMwlPJHEVQE=
X-Received: by 2002:a05:6402:40ce:b0:5dc:88fe:dcd1 with SMTP id
 4fb4d7f45d1cf-5dec9d3f9bbmr3983618a12.12.1739470632105; Thu, 13 Feb 2025
 10:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com>
 <CAP-5=fW94Q2i4EHGoM7kczTZUsfmD4nK4sAjVtcLzqZy29Quxg@mail.gmail.com>
In-Reply-To: <CAP-5=fW94Q2i4EHGoM7kczTZUsfmD4nK4sAjVtcLzqZy29Quxg@mail.gmail.com>
From: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Date: Thu, 13 Feb 2025 19:17:00 +0100
X-Gm-Features: AWEUYZmpGlD_AtmgVmFr2H-kOgvLg0KfoUauYCMv3eOueMuD4LQEWBKCcVajz9U
Message-ID: <CAOQCU67xtf4ndP2fo6fFxgsb7q_6uUooHQK4mb+Xi4fZR_ir0g@mail.gmail.com>
Subject: Re: perf: Question about machine__create_extra_kernel_maps and
 trampoline symbols
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ian,

> We do have a kallsyms parsing benchmark:

Yes, I've looked at `perf bench internals kallsyms-parse`. It returns for me
    Average kallsyms__parse took: 99,994 ms (+- 0,199 ms)
However, this benchmark only measures the raw parsing speed of the kallsyms
file, without any of the symbol processing that happens in real usage.

> I was curious to know if the regression is also visible there?

You can call it a regression if you mean from 2018 ;-)
I gave measurements at the top to give a sense of scale and show it's not
an already solved problem.

The core issue is that we're calling 'kallsyms__parse' multiple times, when
we could likely consolidate these calls since most of the overhead comes
from reading and parsing, not from processing the symbols.

Notably, the third call I mentioned (in machine__create_extra_kernel_maps)
accounts for about half of the total kallsyms parsing time, yet appears to
have no effect on my test system. This is why I'm questioning whether we
need to keep this functionality.

Ultimately, I believe we should explore ways to avoid reading /proc/kallsyms
altogether, given how expensive this operation is.

Best regards,
Krzysztof
