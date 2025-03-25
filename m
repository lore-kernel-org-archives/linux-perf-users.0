Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4D42A82
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935762; cv=none; b=Ccf7I5k00BxYOYD9knsjheitWCQurKDC9bYx5x4v5FPaeQLX3/YVyGeWh4U1caz6RDAsyw19FGsIpoVY/1QJQ2lzxl20zzbhu081YbMhkMOC2JqTxwnkxeHsYbj+94T0zEctj1LU/LIGr9ZDo2zpnsM2QRklygHe58jC76VS86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935762; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qj/68HgUxORY5RPoS5K+9TfdCYeCkPDv+kKSIOhHZn6Snl6721AFwr7tCWpAszRjEq+7If9KqDugmepAtL/9Z83gd/sOkYA7J+/bTGu9Cd00u7VLNj+4Gsj06OzyNaFb3JYnC9jSmFMnIgCxFd8QtDwQqO0IOd8MExe5SvZdamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ffg9DM7X; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ffg9DM7X"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54af20849bbso2161531e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 13:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935759; x=1743540559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=ffg9DM7XyO1TjKbhsBpYGnBOLY1HFkTSg9XlgOfVXr5nTmJqGt8oc6LT2RiKGtVO+f
         fpjrxTa1pCNWUKZ+dTOFrI8YTyFr4CeB7+n6yQWGR5+/U6FoZN1E7P5HY3icoqDbU955
         asf/U3FoSfV5niFlAfRPWT3RWHqhYTJc2KHxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935759; x=1743540559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=obVxDQ7AZxgE5JrxgpEj7DIWSidGhB3uPyiupHKji0wLe0WUfEkEodB7kfZ4vrJA+B
         qTFuChkpYGDodCoyelS5i0KcFHCcT80mNgftL3mBtXsxn9Ss0zBko8G+OJ98J/kRiVes
         Kihz4Nd2e4K3rs6jhRyYJ7nTBObDhZ7o0RXF8To1KF7n10kMPcgkxN0qcjJfAS78XLkZ
         oZfQywozyA7BXs4A8jy9sHbinW4eu3cYYwtWPVl0cOcycVwK6iEnfcA/qA7YEi0DEvRx
         TpGy9auDILxbsi4DGdrNeQDInQnK04hOS4cJbX/DYuox8zQZykK+mgM9FZeauBII0qBA
         GelA==
X-Forwarded-Encrypted: i=1; AJvYcCUtd8bQnNcR+dv28iCehAnTiK6DWVpxZVoiWKR2OxJzfoIvpLfeO5Iv7aV0ZAe5qLYaxhvyCatgF0lQG151q5gR@vger.kernel.org
X-Gm-Message-State: AOJu0YygU11zBlxGceMyrejNX5f6gAe9FjWSyzMLEAs4cyDWxIfmu4S/
	iZ3uYR3IAD20M0HPCW6XoCQa42UXi61ASUtqJSXaU8qftewmUGQm3wpS2lng73M9Noz9fXyv5+u
	OXfhkPg==
X-Gm-Gg: ASbGncvWddV61liJBVo5rWSOKA9aI0a0UBOj5qSsBt1etijR4MCsGMf5EjpMqRrZ1j2
	HwUDkaPCaTbpsrHoUy+i9pL8GP7p/2q34sFAjsdIXYB5RUo2B0+wtC9blqqWk3MhAvWSPdjfpMV
	Z5iTusWXbtt6hFWJRWfhqXoKhtz4BQiQ2lSihd/Fn9lss/g3NheT+AmhI7JFFAR0fbFFWmsAlL+
	N6lfTydjKUKXK3zyzg57YQ2Ge3ZTNDQDC4PJR+Yp9PWxariSXOAYKknUTFzYQcr+onfMxFprxaC
	nePPjcXHFl7lTu3Tv/iFIfkI/7PRggG4zblrg598ycgjS9XprbSjhHfk6ZsdEMjvH4knCVX8hdY
	xY2a/Qk7frlMNJY9/6tw=
X-Google-Smtp-Source: AGHT+IFf1zxacEYeu+yFVIAeNOEpi6zEe06rX5lt5NGePkLj8NvbmrmI98f8K/nHi/Ge6MlKlBK+aQ==
X-Received: by 2002:a05:6512:3b9d:b0:549:8537:79d5 with SMTP id 2adb3069b0e04-54ad64868acmr7140344e87.20.1742935758624;
        Tue, 25 Mar 2025 13:49:18 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54af62dbe50sm310157e87.197.2025.03.25.13.49.17
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:49:18 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-549b159c84cso6816069e87.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 13:49:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfIHtAwBdVSTZKdbe6i310Wf8ALiRvN1xFBKU6ES7b331ugXw14sNf9BKrZrLwXI75hSSXVrLpoKZczYNFplSc@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus
