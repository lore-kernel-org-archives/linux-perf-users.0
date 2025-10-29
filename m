Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A05278E5D
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750805; cv=none; b=eF1+E8czm8fttnDVohK3G2CGcIW69OH2M5q21SeUC5s9OpwhZ+bYFeCGNEeYQENa2z0JyAJIBFuY0jw6wg5IpePUz6Cf/MThPuVuF7tdmZHGQ5qhjGLLVtAn9PJSZsC8NmTtwmS4eIpTzexOixAbsyBR+8R1dYLpr5JSHKaL11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750805; c=relaxed/simple;
	bh=9PJ9EARvOsp5wxpB2XNAHlJswvMLpeemrLKV6P+lLME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7WSS/8ngzCqMIp+xl/0yQGVG5zWtUN8secWurhcYIZsU/kFSv3Oq1FsACt5B6qJmUTNGjwMlhuAdNsepuF31uMdlBvxWa/gI7lgh6LTdaEBkQm/CPbD2cQiMIXQKCeKKsBJnEJggioVwn8g+0vgZKU8GhTCW4V4Fn8WFuT1Rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJjEJMb2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJjEJMb2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d67abd215so226455ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761750803; x=1762355603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0dYPU3Bn2piGd/ljPrwHid5cgPmP+amO0tRotO4NIY=;
        b=xJjEJMb2fQYziHEQO56Nk9t0zzMUDiCuOOr9COb3jBMPr7bD+Lx8cPrJEoTGQfKxgM
         /vHg+bqWDPQbPZ9d2sIkByiy3TwgT5Ofm/xLjLYY22plCUMn9T9Rir1TftMXGkHGqwPz
         bLf5YwScifvD/uaGcpGCtsXbCwStUxJBiyMVEFC42ztJuQEeu8kWiF9ELaFE2S5z3eCw
         esJtZpNVJ8EA7dPRLVUzFItGBXg7fi4oCG+OcOAX/ot/uTESugmZ3e6VcbBFqzdcZOow
         DQy1H4b1w5TdfjjEMFMSw7Pf50Xpvv0ZX6Cb7LIG1dOPWrBnrgT6Bmt6mMs9J/NxbRRk
         3PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750803; x=1762355603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0dYPU3Bn2piGd/ljPrwHid5cgPmP+amO0tRotO4NIY=;
        b=BpGRj0OdskrjgTDijsEsbn53uUjFjrmeiJfPV07vEZbT0qcRzc6URdp4FxhYJRFd5C
         aEbFvx4qlpLj/iPs4YDlhTRsIr+xDqQhJaOERvbp+qdP889xiW2xV7p5QT69WN4Ldm8U
         UiiZHOYQauJXr/Bsk8zlIexgc3qrDQPK2cIGh11qnGdgqlaevHkD5eD8C315XDoJg4a2
         v60+Zdb4h49GCGceMFPI5TpfpIUhHxyFnqFTXik4Za1YbT0cnUG2Gi+L4GQUxZ+uaSZl
         T6pXYsm0mUN8WnvtpDmLeIPn9VvbQRceHZLPe5pExjV5kn3RajHKJKEI+N6B2L0MgW+A
         iZ4A==
X-Gm-Message-State: AOJu0YyqRqt8rpCUyOMMKBu896d+5t0z/PiO0iddOz1fAhn2AdKhXS7L
	BQUlpSgPs77tVib94njGkr2eYJUhoT54/YKLhGofbQa4u/VA8IO0lW5XBY0AVWy5r4YITVymomd
	ZlYFn6E/WKHBWvau3Z81TPdbIZuFIuc6nsIcYRgwj
X-Gm-Gg: ASbGncvFEuEePMQEokfUmuMmz94qD/DB96iN3ju/cGyjldsKLH6b1ByQRZFY/2fM9T5
	godPbpWbNB5Xhj+rGdN9HsgKJxBqJKc1mmjs5Tmy/Bd8kyzjVnOrI5c/77CoCRDu2NLJ0+psudV
	uoVe2PTupWvuAAsqJwd3Mr7QFqitqNyyiaxgS7QSBeYw3oJjSIXz2hIA3u8Vudt2HfcaFI5Zcqt
	OWktHrKPKQxAQP5A4bgI+ihZ+xrNIXt1jhmmldIlIgwm3kpvthfil5wqT9IBkoi1ozI5feu2LrB
	V5sAa3240xwIjtKf12YGGO/P
X-Google-Smtp-Source: AGHT+IGqO6PIJQ6x6mvspPUugJ6k9sPrGPr9n7imDSf1cIoNsMDUtbvcr0nLVJ5V4XVEDzZYj2dlFYtKcvBrJboCrvc=
X-Received: by 2002:a17:902:d508:b0:290:be4a:40d2 with SMTP id
 d9443c01a7336-294e0190e79mr4805085ad.13.1761750802764; Wed, 29 Oct 2025
 08:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
In-Reply-To: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Oct 2025 08:13:11 -0700
X-Gm-Features: AWmQ_bll24LPz5eEyAO1BmgyHONOERtlPy7igC0cK4BIdmzwHQaWEObLij16MHw
Message-ID: <CAP-5=fU7zGF90yPyPhNUKqZp6zvynjZ_fQd_+x4hB6+KFumrhg@mail.gmail.com>
Subject: Re: [linux-next] perf report runtime extremely long
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:04=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Hi all,
>
> has something changed recently in perf report in linux-next repo?
>
> I run perf report -i <file> -D | grep something
> on s390 with 2 different kernels:
>
> master 6.18.0rc3:
> # uname -a
> Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 CET=
 2025 s390x GNU/Linux
> # ll /tmp/perf2-eSso2q-2
> -rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/nul=
l
>
> real    0m22.262s
> user    0m22.068s
> sys     0m0.200s
> #
>
> This runtime is ok for the perf.data file size.
>
> linux-next:
> # uname -a
> Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc42.s=
390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
> #ll /tmp/perf2-eSso2q-2
> -rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/nul=
l
>
> real    2m53.601s
> user    2m52.938s
> sys     0m0.575s
> #
>
> Same perf.data file and run time increased from 22 seconds to nearly 300 =
seconds, roughly 14 times longer
> for the same input!
>
> Has anybody similar observations?

So there were changes relating to addr2line that could impact this:
https://lore.kernel.org/lkml/20251005212212.2892175-1-irogers@google.com/

There was also the switch to always using build IDs:
https://lore.kernel.org/lkml/20250724163302.596743-1-irogers@google.com/

Any chance you could do a `perf record`/`perf report` to see where the
time is going?

Thanks!
Ian
