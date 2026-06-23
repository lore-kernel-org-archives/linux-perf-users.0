Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B50350A18
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221395; cv=pass; b=XTI78UMkBEkCSywOLjpw6/FdnONxqSUUyhCON4RSI/OAdzx27cMiOAEDRXM1b5neNL7FsjXlWnk1NL8Y/Dc8oXR/nU+MCCL5ZDqFDVanbAChvPIVV1s1LILN3av+19etj+2P4VQa0+G44niQDqmm1lrYlf2WCL0z/kO5HtkAX8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221395; c=relaxed/simple;
	bh=pvopdsMv5vMxVcxFnrVZ7Q3OIZo7brgzX0LyyVbmd/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJifC9m7qm8XlALc5Oq4bwH/QbcfODeyVsPyHWKM9THAvS4VqZPCmt3ghR3ZmgdqCFMbmXgRiHy1MHFW1ctx67JmZIwWsK6mD0CVxSeLx5ItRw0yYuUWgWYHHRdxlQAlxnQ4kkLeyU0k39qdHCTxTDuROU4EqpaNfdgg/CaNPgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRSHfj3Q; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRSHfj3Q"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-804e46366d7so22271997b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 06:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782221394; cv=none;
        d=google.com; s=arc-20240605;
        b=c2G0DJQG/asAOWfKxuyri8PRJIXNvWFZH2H2rLXnhZ3Vygg3/uhln2kMssUFQVH++E
         EyqQIKCJ+XPExJBqSoT26sFzZgd5/vvVBnlU50Rl4YkDXtVOxhRPLWHX7hWboLm8Q3nB
         ceD1B0/CIn8bYaoRMpN4IzeeelkKiDIIsniJhLi9kN6yIppQpAyCGDCUZNi86TdHAWaO
         X39ZwAnBzoGeMPvuQXQee7QKnCb/vIH9Dzv5AbRp/seEBuEDQPTeN0Mua0+0wCstWSC5
         qBgXM4CSLaFoTTTy6Xt2FfuHMRsQX3bkrbF35zSrtAxqdNveoUHad8eHTHYDZA3+71Np
         f4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmHmIXXw9DS5fEEeykM6L+uF9W8BEvYOXYiQBx9JZS4=;
        fh=FHAtYlEnyx2pJ/+0YgIoSTH+Nu0lUVWr7V0aFPNsnvo=;
        b=h0pofh331zfdyWKmUhaxrv3z/FozUT835eBfXMYBOz6Te+gNZV4kT9WUWxI/xeujdq
         E0iOE8rSGJBu7CskyrXe32UWcKuule2NU7ZgPdpq1xgI5eUXlvpHPEeIy8Eiy06ZeCKL
         EsMrINvWoDkhaP87vwDvA0hIawnrFDwklmGnR4Fo91nRzrwwLK9jsohJ9nbAr5hq2VGu
         Wk9mS4hQt8LIUnfezStCdTjFD7Nb9DeFa6aaf2g8FNxP1Ea8OueNvNgGDVFu1risDldf
         sF4W6IyqzxyeCpbfW8BsnM2aG1yQ7GQA7a2+y6Fgq2PJ1LMSZG7TbsNzDKJvss5ILOYl
         TgpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782221394; x=1782826194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmHmIXXw9DS5fEEeykM6L+uF9W8BEvYOXYiQBx9JZS4=;
        b=JRSHfj3QHxjn/kBk8mhftQt/ON0IKA+h4qd67yvUAAkaJkO/BeWXMZdjX4caQf/Bim
         bKCpGogZGXIb3F9ka1ESphnvZ9zRon+2yoSD9FRJvbFJLKSRPtu4VBVltE9AtS7r8tKb
         OfNijWMJkC9vI3lqW1Q43VlZg7u7c0KwSjFIZ5ZSz6J0KuKEbr66FFYnGkp5v2OuXxMl
         efEiUbeOtTc5yAekgjToQQgkIw5/Gpkjf1LXG4o6Fjn9D9VYZlnYtRpcA5zWBBJbUmcI
         MZ0XInKKd8g8sU8bY6cKNkeyqc7iuJ2ywAz4ZEpgvsjBJnbRb8Cayy27d/VueyL6ZQXg
         JMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782221394; x=1782826194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmHmIXXw9DS5fEEeykM6L+uF9W8BEvYOXYiQBx9JZS4=;
        b=PbnvNuhgEDAEwAPtghB/ltdVB+TBtNhM/5d6tK3GvHZenVr3Ny7A961CsVgmToatGz
         2l8mJkRyk7tvgnMeZm1ywcpuJlC+FbuY6Nhi8vJ76Cp8qUSGDtHOP+dgpOo/7h0jfYZA
         kN0dsKGxWVqcrB/d9vKeQ3OSPbMek7m9WMur911+vvwcKD8wqVKb8QwqUyDoYqZzS8i5
         sJAYu3elLPLj2cuwgR7Zw+oU8UgC/8DQ+F4o6jHgLKAaYUX1OFjFJN7IZogTSYX8BvgE
         LBm6tNNtvZICOCxC04JzC8Gx8MXZtvhjZMxpmGEVx4SWuR1iLOMcn3ZIPKVnUW7/hcpk
         ycfg==
X-Forwarded-Encrypted: i=1; AHgh+RqBnNErO93DmLfIXanXif5p22xgFNkSzdYAeGES8Gyp7cRYYWy+p6DIdDtB0y2e3fxOBZtTp3r+vZQwF3ZodOZB@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEK6s5WqOQndM97SIPo81U+5a0nCrcbwhn+Fm5A+rTm2Velxo
	2NfRNkkrnlXfuWgPPN/oFWf9N/R0psdaUgPtWnKyzeQqfW8usbkTrnYANZ5vb8CKzBG02Sqaj0J
	mzkkABGaWFZD52KDjdCKfoSp+yVs5JpM=
X-Gm-Gg: AfdE7cnQnXVXxr+grXEKvkq2kSvmb6kiHHWPLPiKXnLZ7kJ0Y7udIm8clyMzqYjLeP4
	nukarSF9px4bq6cVGmNbhfodhvCpQZjnjZ3wfb33X+S+O4ttJOtuilfwCYkiYEb4aCQfhfgKXq3
	EdLk1D35swhFOWEfP7oPE3mwfmVDQyI37w+PZqFMI8IANJ1C3zRjhtVAeuLdEWNqTqURN1CVpke
	Fx795KJo69MM4UlViDGJLrLY0Csk6rGmejjyxpaJrTlqpS8zcnl96KZCCFsQmuK0/J6QHkwWWcc
	Mk/hIQva/5QLhn1OmVGfJcRmmpblNJuh/SQ=
X-Received: by 2002:a05:690c:9b0a:b0:7fd:2b49:181a with SMTP id
 00721157ae682-806c226341dmr27480367b3.19.1782221393456; Tue, 23 Jun 2026
 06:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622134933.35773-1-akinobu.mita@gmail.com> <20260622152432.32788-1-sj@kernel.org>
In-Reply-To: <20260622152432.32788-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 23 Jun 2026 22:29:42 +0900
X-Gm-Features: AVVi8CfnlzfNTmMwHdN7shEapsXJbXkpYk4ewUy7jToRUMM10YJXpvwK5mFO01E
Message-ID: <CAC5umyi0v8Z3Frtr4yL_LRZu9O7wWF1HZfVbutagORde_i-7XQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] damo: support perf event configuration
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	ravis.opensrc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B46=E6=9C=8823=E6=97=A5(=E7=81=AB) 0:24 SeongJae Park <sj@kernel=
.org>:
>
> Hello Akinobu,
>
> On Mon, 22 Jun 2026 22:49:31 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > This patch set aims to make it easier to specify the perf event setting=
s
> > proposed for DAMON by Ravi's hardware-sampled access reports patch set =
[1]
> > from the damo tool.
>
> Seems this patch is built on top of the per-CPU/thread/read/write monitor=
ing
> patch series [1].  We made a plan [2] to use another user interface, thou=
gh.
> The plan is, making the interface ready for page table accessed bits base=
d
> monitoring by LPC'26 (milestone 1), and implementing the perf event based
> monitoring on top of it, by LSFMMBPF'27 (milestone 2).
>
> So the eventual damo part change for supporting perf event based monitori=
ng
> will be quite different from this series.  I guess you are sharing this s=
eries
> not because you aiming to merge it as is right now, but just for sharing =
the
> code with other stakeholders like Ravis, not me?  If I'm not wrong, I wil=
l skip
> this series for now, to focus on the milestone 1.

Since I will align with the final user interface later, please focus on
the optimal interface for Milestone 1 without worrying about that.

> Please let me know if you want more of my feedback.

However, even if the interface ends up being completely different from the
current one, I believe that enabling configuration via `damo` using
symbolic event names like this would still require calling the perf
python interface (`import perf`) from damo and modifying the `perf` tool
itself; could you please check if that approach is acceptable?

Thank you for your continued excellent work on improving DAMON.

> [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org
> [2] https://lore.kernel.org/20260525225208.1179-1-sj@kernel.org/
>
>
> Thanks,
> SJ
>
> [...]
