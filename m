Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694E1F12EE
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325284; cv=none; b=n66pp92fjT4jd/5p1Nx0h19p05CGPqk50j75c9+1OHAsX/6vsR+LzkrQc1sR/5aVltU1brasyc3cM3eIjwJPqmd80FmfIoSvZ8FMDDtv4lONGjg5VOCxTRQwp9pTn5yIU/EoTWwThB2kxacbdeKw/VPa0I9SRPZH9LYXs0BtOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325284; c=relaxed/simple;
	bh=y6qbiFIIQotwpve+E/nO/mSeP/1pMFOUBNl+ZXv5ZHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCBht/vzdQfcvmbdBuSsoKvY3P6zqoFqLAAUOYWIJ3ch0aVfuajoYt+VV4mrbAvZki3OnWhNLYga0H9wt5tUnFgUEJAhz9uFlDqmaTu0SdQqvNzmHpIu4WDnIZ3pe9UPXSO93658vCDaJqgvyfpyPnnsJpo+js/jMahoM6nMEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phHxdNik; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phHxdNik"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-305f529a987so3066621fa.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 00:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736325281; x=1736930081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vvIhZkhT7EY51SYafwcW7BDUaRhPb9DIiEwlOna2Plg=;
        b=phHxdNikNwX6AZXBt6oTZOk4BdNgBGHLswBavpUDXRJqV4dxzSALyF2jR88n8iCVUQ
         BhNQXq5fAtfkd1YVPYM+kGdm7+wXHyqGIA7TEEdArMU3mVb9mZfKl5CJBdM/FB99XoKm
         U9mxRCAYuSn7PrElOJX3wxMhSbk93kyP4b0vKJlfHVjuzGZsy6GGMeq8nFci8ihqSXqb
         IdgpoZ/7KyHLXgS3ZZXPQ7barckXCQcra8axpP5WSy+IiTN250RlICQ5ozDRjTO8YkCt
         uLCWmmsYjf4WZuA/fGFt8sY6u0vJ1p1ZES8VC+vhXhTKe2HpzOItcWOhvLCVV+QaVnZr
         2JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736325281; x=1736930081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvIhZkhT7EY51SYafwcW7BDUaRhPb9DIiEwlOna2Plg=;
        b=W5cbfsdGjGZ+6hTCsSQqsSNBFRDkpQEOpF3qhm89Qw+OFwSD2tj1EqRUqnpPrwnmDe
         W34x4mKMN3ssP52cXTogufbLLGHkGAfjaKz53K50A08ZhQ2SIvxtnP9a9RCwt7UTOmpH
         79udnZATdyjvEbN0hQvd1WDdQVjFWXtU6c50UWKGowHBwNnMH7tWDIhG8l0cflxIze7d
         /nWFnOVQj/yFasNOivlfQ0vCS3rQ/SdgKune+Z/i8Q/GbXhMwHpj5dicU8QYkgV3lz0z
         BiFwxuht9UpuRZLweqOqMfoU57qmxmVBSDKBD1MFQdh6s4uyMEACMsqglNFk8//ItTGQ
         x4eA==
X-Gm-Message-State: AOJu0YyGIY9NnQmxCi9rle6SUg2Vt5RAR5whH+Bvp+t4e3lYX95ibabI
	q7w6qEUSVI4eUIuwGf0VVmyYx8P+f5QCpnu26qxn5PEaEQZoqeD2A0VZtu4/SBVIfi7+ZqoPn2C
	99JDdkFJne7k/84uPyvu1GZolTLfCn9YZdDCk
X-Gm-Gg: ASbGncs44oHjUvqHKraiaaRkEMyQXLM7wzIK6/6e8KzOF7nnKeVwiK0o6pxCPb/8pUW
	RHRLbcnXvQ3O+B9sBh9162l46w2kzDGkuzMJwjcK4EAA6ZLyxOiKD3vhJ3yL/96b3iYlFiTQ=
X-Google-Smtp-Source: AGHT+IGhhfwquftG3OPfc1yFJyu3sUcU/9fv6zR9qUd7YxlB2CmNyfs1IConJMMMZ9k3soJjoLGrVTJ7xdC7KzEwe+I=
X-Received: by 2002:a05:651c:2223:b0:2ff:a7c1:8c2e with SMTP id
 38308e7fff4ca-305f45f56a7mr5124281fa.28.1736325280476; Wed, 08 Jan 2025
 00:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108082435.268431-1-dvyukov@google.com>
In-Reply-To: <20250108082435.268431-1-dvyukov@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 8 Jan 2025 09:34:28 +0100
X-Gm-Features: AbW1kvb34C2o5cRSYkqE80I-vZ540x6PFi7s6O21htMdoMDhm6H-uA4ZqnZJcNs
Message-ID: <CACT4Y+an1LSY15f9MS_vnbaaeeqMf+k4-Dqqfu-zwcUAHFNk=w@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Add wall-clock and parallelism profiling
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 09:24, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> There are two notions of time: wall-clock time and CPU time.
> For a single-threaded program, or a program running on a single-core
> machine, these notions are the same. However, for a multi-threaded/
> multi-process program running on a multi-core machine, these notions are
> significantly different. Each second of wall-clock time we have
> number-of-cores seconds of CPU time.
>
> Currently perf only allows to profile CPU time. Perf (and all other
> existing profilers to the best of my knowledge) does not allow profile
> wall-clock time.
>
> Optimizing CPU overhead is useful to improve 'throughput', while
> optimizing wall-clock overhead is useful to improve 'latency'.
> These profiles are complementary and are not interchangeable.
> Examples of where wall-clock profile is needed:
>  - optimzing build latency
>  - optimizing server request latency
>  - optimizing ML training/inference latency
>  - optimizing running time of any command line program
>
> CPU profile is useless for these use cases at best (if a user understands
> the difference), or misleading at worst (if a user tries to use a wrong
> profile for a job).
>
> This patch adds wall-clock and parallelization profiling.
> See the added documentation and flags descriptions for details.
>
> Brief outline of the implementation:
>  - add context switch collection during record
>  - calculate number of threads running on CPUs (parallelism level)
>    during report
>  - divide each sample weight by the parallelism level
> This effectively models that we were taking 1 sample per unit of
> wall-clock time.
>
> The feature is added on an equal footing with the existing CPU profiling
> rather than a separate mode enabled with special flags. The reasoning is
> that users may not understand the problem and the meaning of numbers they
> are seeing in the first place, so won't even realize that they may need
> to be looking for some different profiling mode. When they are presented
> with 2 sets of different numbers, they should start asking questions.

Hi folks,

Am I missing something and this is possible/known already?

I understand this is a large change, and I am open to comments.
I've also uploaded it to gerrit if you prefer to review there:
https://linux-review.git.corp.google.com/c/linux/kernel/git/torvalds/linux/+/25608

You may also checkout that branch and try it locally. It works on older kernels.

What of this is testable within the current testing framework?
Also how do I run tests? I failed to figure it out.

Btw, the profile example in the docs is from a real kernel build on my machine.
You can see how misleading the current profile is wrt latency.

Or you can see what takes time in the perf make itself.
(despite -j128, 73% of time was spent with 1 running thread,
only a few percent of time was spent with high parallelism).

  Wallclock  Overhead           Parallelism / Command
-    73.64%     6.96%           1
   +    28.53%     2.70%           cc1
   +    17.93%     1.69%           python3
   +    10.79%     1.02%           ld
-     7.49%     1.42%           2
   +     4.26%     0.81%           cc1
   +     0.72%     0.14%           ld
   +     0.68%     0.13%           cc1plus
...
-     1.33%    15.74%           125
   +     1.23%    14.50%           cc1
   +     0.03%     0.33%           gcc
   +     0.03%     0.32%           sh
