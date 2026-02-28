Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530C329361
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772260813; cv=pass; b=mLBVsB3YRV7nUBp3pVPQTKWNnOrMAhmUGMAjDCStCx3idMZCdQ0DseT8lN3o+pYc3YS1mOlAixIpLmtX7lzggaK61qbbb46I48RYD7Pc532SgTjkblul631JrBnEB6W43F0o6Hdc66F5vaHZqiEYqSPMnnBEeXpnPaoil2H5Kpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772260813; c=relaxed/simple;
	bh=GCgtjPDV1FRTC+iBUt4U+e1Kjkved8C7aB/V+1Smtxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuZODejzuNflTvii/UVK9M9sgZRiWkrye94YoMCwAiGRMqWL/5xzvr9+GigCyRCTDkUoFV3uZmfu/E3JS0n9R75IOSl0SxalCsEjxfuWCpkltdG1hBtHeW0YHqAEbfH3qvY163bxKhWBNys/pDScxltJDffOrRuwT1swG3NkTIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZhVZ8tt; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZhVZ8tt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae3f822163so7675ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 22:40:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772260812; cv=none;
        d=google.com; s=arc-20240605;
        b=HPQvnnee+kKI2/dKHKzoMfKBFE9urfx2mJjdy8xx9YuZzvrr3Rg2AzsjLwn8CiBbL5
         KW/29ypjrw5KDtcPWvQND88lRjdtHcsftJSrdSr7Vc7VhB4KyDMWPmW/e7a0ijSto0/w
         S6VFlf2qUVd5DV7ODSl7pG0Z47788dovMfjtNWQLCni76jy8E5jgVbTibRFSL8AD+ZHp
         BUDZjiM/nuQYo/Xwf8EHTtRTOmGcNO/mY63H91N6KBOsvY8irrd4PtUNBcCPGC5cJ1rB
         GkdLi+d3pKVpsNjYH9Pn8AjhRd9kbcR9P1MSbsIINCDbXrbYd79njjh7uwtNl9PmpROA
         HSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y1SGkCngI5GvsQqU0a9kGo4JXYTF/HfVjBSLW9M8+Nk=;
        fh=O4M0oSYkl9CbCrvGq24CEuU8qB/2RmG3r2tIxnLZJQw=;
        b=VQXszXPJ8VS48WoyMw2g0RVGFd4YoTxC/hkQjJjUJCwAymEMxoR8zfVpN5ynvk4tcN
         WBXxUkJNoLNf6gPy7G9AADTmkiPd/3csH2r7J/bM0AhA1+DU+4nXp6nFOK6S85J20LV9
         Uqi7aaQtHCocDlOTjBop8+2HmVytma9OpvC3bRIZ3CckmfNX7NVhZNt5TXGDWj8xUssF
         MK1X1umoEPQHK++1yrcovVl5Cblofu7uq1k+dOSyIUdEM2f3o7d7At5FvuurR6VSCwU3
         regVVWMFL6zyUWi6eLC4wbYhkUMhuycseBwM4TjizrZ2LnIMqLkr6PXCnkxuIBcOSTb7
         hPCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772260812; x=1772865612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1SGkCngI5GvsQqU0a9kGo4JXYTF/HfVjBSLW9M8+Nk=;
        b=aZhVZ8ttzJ/vhZSo1d2KjILZ7hYvZ1rljFoJMyyRm4XjgOdXB9Ys+eOtqS5rkZnOhE
         QjOaCbYFDxWtm9sAoDWOxwXJnia52UOzohioes+lwwgJrAQZK7Su7zCJmKOU6f/rh3l1
         7ZdPzYQvlLDZnGUt251smLiGj1dT898hdIIz75y7rl1iA5yGmg19ZCNjbV45xV6LE6lS
         34TffnhbqNrmII9tenar3LgVGLyRBk2UTea5eE4ei98Y79Gy5lWkzgV94n0K+HMiINKK
         D5YdsAhVTaEiTSYX3jOnfjJ9oiTOvjLTXZY2cCmbn67++mMNNNbHi7xJ+4vhZWAtTbQy
         FKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772260812; x=1772865612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1SGkCngI5GvsQqU0a9kGo4JXYTF/HfVjBSLW9M8+Nk=;
        b=qQci5tyvyE4cjOAbAgno0lWA8Ei64cl8qe/Km6gvmdxX0cXDpf+k5J5gYLI7l2hxTw
         mkjIrs7Vzo1qA3qEqM2Scby3MtXSuhmMyJD1FCmM9jYEjOJGuZLZg4yJuCsV2RjONS2f
         mkDADGcEHuAqQ6YB0v/Bfr8lfvW6S8ITbjDCaMI8EfVJNEbru8AgTbFvzP343i4BM7/S
         TqV6WcnQO18ELtizMXEG5BhZNgoECYQ3tnSTIHPx5PTnb+WF8x3+8gjOdZzcbCYBGt++
         p5P1JYPVFrcF/XxTkkqLOgOS3pPBbHWGxUOA3Tv8IE/OO2I5DeGD19tMlBkDXAeW49JU
         3Bxw==
X-Forwarded-Encrypted: i=1; AJvYcCWmYLFEfXTzkHs+5bQqAMWAuaAKXGGWIhJkbaMtdXU9/kTtt3dV69xEgOQQaen9DPFjOhRgsqukteMb2KHvAtAv@vger.kernel.org
X-Gm-Message-State: AOJu0YylMGc4lTBhazYKswu2iBTjS+MZ9h84Pb0P103CHoljh6wUInz5
	olDSB5Dm+Rdcpi7J8mNLYoDpNTjEalfAruTXYOeLA95931KlWWYBS8fl5UD119LZ2kIBmnV+bNc
	wzhDDhCT1dKvVRhh9DiRZG1iVguo0vzpGijQyrRIM
X-Gm-Gg: ATEYQzwC6rvidfs1Z7S9k5NMiPGLYbXLbMz+EYzzt9/1SaC/K/uaLmGCJbWOHLmTz72
	w4hC5N86aoVmGIHcwjOHtlMSoQ9AAso+uHeX6y6lA+jFE1SrPzNxFsFHpl+Zm1HxOfNVftyq/aW
	tgrytu6b7n6pULuxhz7Jz3nb1anQEpHiCFe6mVBG4TwdbKu9EQPCflmvl2pTjG6LOvQ6eD6jsnS
	MF4bSK5/ilCloAaHQnJoFWxhdy3TGw+D+/79lKB5QpqJQVF9HyDgJV7lT2MMq8U7/9GJl0qQPZk
	+sgRX6Qn
X-Received: by 2002:a17:902:d50e:b0:2a7:640c:834b with SMTP id
 d9443c01a7336-2ae39492c95mr1453345ad.0.1772260811132; Fri, 27 Feb 2026
 22:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226122208.162765-1-wangguangju@hygon.cn> <177222796929.277001.11130004024791436706.b4-ty@kernel.org>
In-Reply-To: <177222796929.277001.11130004024791436706.b4-ty@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Feb 2026 22:40:00 -0800
X-Gm-Features: AaiRm51vV-A7vG76vsDhWMPaaAGxVulpGIL2fYozxanfuAdQwhVtGvBS02w1ZWc
Message-ID: <CAP-5=fXep0Frpoxq=G5KJOMzmEXyrj134XsaO=p9N-61Hp99dw@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, wangguangju@hygon.cn, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, 26 Feb 2026 20:22:08 +0800, wangguangju@hygon.cn wrote:
> > The alloc_syscall_stats() function always returns an error pointer
> > (ERR_PTR) on failure.
> >
> > So replace NULL check with IS_ERR() check after calling
> > delete_syscall_stats() function.
> >
> >
> > [...]
> Applied to perf-tools-next, thanks!

This broke the "perf trace summary" test for me (run `perf test -v`).
The failing command under gdb shows:
```
$ gdb --args perf trace -s -- true
...
(gdb) r
...
Program received signal SIGSEGV, Segmentation fault.
0x0000555555672210 in delete_syscall_stats (syscall_stats=3D0x0) at
builtin-trace.c:1579
1579            hashmap__for_each_entry(syscall_stats, pos, bkt)
(gdb) l
1574            size_t bkt;
1575
1576            if (IS_ERR(syscall_stats))
1577                    return;
1578
1579            hashmap__for_each_entry(syscall_stats, pos, bkt)
1580                    zfree(&pos->pvalue);
1581            hashmap__free(syscall_stats);
1582    }
```

As NULL is false for IS_ERR I think the correct change is:
```
if (syscall_stats =3D=3D NULL || IS_ERR(syscall_stats))
```

We seem to be routinely breaking tests, which may indicate a lot of
noise in the test output. I see many failures in the type profiling
test due to the typedef vs struct issue.

Thanks,
Ian

> Best regards,
> Namhyung
>
>
