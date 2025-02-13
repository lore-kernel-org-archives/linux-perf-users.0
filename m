Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72D24293A
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470837; cv=none; b=JCHzId/t+4ObUwdCP0/F0WoYIADqiRSFhAjAbgu0l1uDXxersBg/si2yYdECog3ITnE1WqjKke5mWBaVAfG596SI98Fj0y461lDX3uAkdJHotNL41Zab+nuBr9NwAMdfO5EI3XIQ+GSOti+e828gg6C8Y3tUGpLmRU9lo172f5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470837; c=relaxed/simple;
	bh=/LyGFbPE1BAmB++z38OZpHSq6dQ7FxIc5VWLCNL1wxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5x8revCP92YfiDqZNvdGisga2Ndv1jEIHZxSH02CSS+S3W4oLXNueerfd/1O3I0M1ybENyHOwfq/54IJn2ndQVpVv6mAiiI+8QgfBqIs7CR6LE6koEaHV3mc1Lobp48kzhnL8yJQ/4Csbkv3zsD+igm5MXpQimqZM28HfjMMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BF3dlGVd; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF3dlGVd"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d19702f977so5335ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739470834; x=1740075634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5Yi8A4+6Jiha2cMKDJFdE3ONJ7D37Fd1pQ+hUL3DkA=;
        b=BF3dlGVdcRl9DT7czH2XHbCT00Wo5+vx2GcQrf0auN2HyHFmLi+VPGCFQRIdaC51pC
         joCYbwSTGm+AXpKwRXlofMG3gd4iwbytrS+vKPAYIdAcH71dqPMPCsQMDyTo/uIO/Ink
         8cTsFmI9DSfRJys6gf0isMbNrhapMbWc95YwRfHHPoMfMk8DpbwAM4fy8EQc3pdoCj+a
         8XDKN7OfBFZs0JSAMdQY+bac7tNz9UvY7N6l2Vag5XKA/IeWtfn1mTm7lpxzvVjWg5OE
         3FWoY42IcivGalcb7Sq0s4rLic2ZJjMS0crdoF5GJKFn/Wxslg2z+mfBY6wESAkkyX9D
         o7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470834; x=1740075634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5Yi8A4+6Jiha2cMKDJFdE3ONJ7D37Fd1pQ+hUL3DkA=;
        b=BJ+UeCxRpH77dLt4CJKMZnn0Z6WngZNUuK2gV1nyvS0Pht7Ip6piA1tpx2M6Z3Eg2l
         mBZOqg0CGGFUnjjRrh2++QaLsYNRqZ/4J6Y2Ywvplux9WUz3URJRXBegF2hJAp4TBPRe
         FknnQtQeK3v0LRgpF37LLZLSnmlezfcX4fN3bjuxXSjiD8i/OKvmOZowjU/PRiDJP793
         /CCPhOiuCFVTqSFoIMAayDbFQCfoPUFyBku4cW8o3OQLri01EnzVfQ+7+J3weCQou/vC
         DHqdp1naZJn45kPSrGMy/akntxBNxIUwUP9UmLG9qJTjf8Aj8m2TALfzQyXiRmU68l1O
         FxQg==
X-Forwarded-Encrypted: i=1; AJvYcCXRtpdApgpiS2bLWY9HpJrzd1/UmHKCLx1Ac4Yvk11Jxh6HrFPnn/a03rcjcABpQCA3FcszQSHW3ETTnXlrEhDz@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMcgEIkSK+jZNeYVT1hgZSstz7ivmV6WbA88sq4TuxSZb/+O1
	mq+Hs2k2wh1LyxWqsXUXD5iz6i32sY092q3AsCwWoI6q/oNJMReEwBT7O6fsCH1D4HRuAFsOTVg
	SHLjRKbD/5S8BjcpexA5Q7AyG1716IRQZUtG+
X-Gm-Gg: ASbGncu36nkvyY5xBqFnyXLrUUkj+JqCE52CDf9M9Wu65PJ6OioUKA0tJdW2RuWkLR6
	vXTyEXr2Ua2uvIZq/kejj05nx9fzYoeK8lP1MMSSTl4jec0zZE63PStQBCrvAu8Ratti1SmoXt0
	jPTjdrTShuPtQadzkzt1qxhzmP
X-Google-Smtp-Source: AGHT+IE/SiI13+b7bF+C4AfY+GjkVCmV2TCoGjBbfEPBrkZXoZpHcK6Pj2DJbKttS1cXo3XAtbnSEyYT2uGv8O9+aIY=
X-Received: by 2002:a05:6e02:308d:b0:3ce:46e2:42c7 with SMTP id
 e9e14a558f8ab-3d18e265567mr4170575ab.13.1739470834440; Thu, 13 Feb 2025
 10:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com>
 <CAP-5=fW94Q2i4EHGoM7kczTZUsfmD4nK4sAjVtcLzqZy29Quxg@mail.gmail.com> <CAOQCU67xtf4ndP2fo6fFxgsb7q_6uUooHQK4mb+Xi4fZR_ir0g@mail.gmail.com>
In-Reply-To: <CAOQCU67xtf4ndP2fo6fFxgsb7q_6uUooHQK4mb+Xi4fZR_ir0g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Feb 2025 10:20:23 -0800
X-Gm-Features: AWEUYZl_wnASXQm9eB-3X2u_vxgEDQP_7aR4Fco6U72vV9FWxU9cBPy7bFLQors
Message-ID: <CAP-5=fVqCUYrMDac520c1AvwGXmBRstGTZEeY8VeC=0hoCBrEg@mail.gmail.com>
Subject: Re: perf: Question about machine__create_extra_kernel_maps and
 trampoline symbols
To: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:17=E2=80=AFAM Krzysztof =C5=81opatowski
<krzysztof.m.lopatowski@gmail.com> wrote:
>
> Hi Ian,
>
> > We do have a kallsyms parsing benchmark:
>
> Yes, I've looked at `perf bench internals kallsyms-parse`. It returns for=
 me
>     Average kallsyms__parse took: 99,994 ms (+- 0,199 ms)
> However, this benchmark only measures the raw parsing speed of the kallsy=
ms
> file, without any of the symbol processing that happens in real usage.
>
> > I was curious to know if the regression is also visible there?
>
> You can call it a regression if you mean from 2018 ;-)
> I gave measurements at the top to give a sense of scale and show it's not
> an already solved problem.
>
> The core issue is that we're calling 'kallsyms__parse' multiple times, wh=
en
> we could likely consolidate these calls since most of the overhead comes
> from reading and parsing, not from processing the symbols.
>
> Notably, the third call I mentioned (in machine__create_extra_kernel_maps=
)
> accounts for about half of the total kallsyms parsing time, yet appears t=
o
> have no effect on my test system. This is why I'm questioning whether we
> need to keep this functionality.
>
> Ultimately, I believe we should explore ways to avoid reading /proc/kalls=
yms
> altogether, given how expensive this operation is.

Agreed. We had similar expensive operations in event parsing and that
has now largely been made lazy - so you can craft your command line to
not require all the costs. I can't answer your question but it seems
adding the symbol processing to the benchmark would have value.

Thanks,
Ian
