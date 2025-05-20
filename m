Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3CEEC8;
	Tue, 20 May 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747701934; cv=none; b=fl5a5OGPiSSNChpGxmAdZlh/+QBon2ncmPey/OlCGqJxwAAGGkQaBGQUMn9WndxWOvP619As2nBaTN6jLd63rTq3wJN6Ji7XDQea+OnE2bX18phc2IxvHuN77M1MG00h3zrBrSHoJmpPfcAMnJfJB/NY+hDowW/aNfu3PAMS27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747701934; c=relaxed/simple;
	bh=Kf0SJSppNaWVJ4XBHTT8WVTAbD7aZcMNvh7j0UnKs2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GriQYq1K2GGCF+qor7gVdvrl4y0XVf+KQvqMcdPJxmlAJfaRH1itmkk/XiNGrsyB6S10O6Qxn+/C2wSYX3xitvkIR1QPRHtTYm35FJAA0cjNe+ZnmxBCFyCxwB5iUOdCx9x4c5mBB5WJl2X0C2v0EB4D56+vbuuAPc6fXwJHzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=l1jQItyj; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="l1jQItyj"
Received: from mail-ua1-f53.google.com ([209.85.222.53])
	by smtp.orange.fr with ESMTPA
	id HB5fuTD4PijBQHB5gucJsw; Tue, 20 May 2025 02:44:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747701860;
	bh=5pYlYSUs/XJrVFwv5HkG2CglNELQVl6CvhtMXbLtExo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=l1jQItyjp+iSeIzSqFjxnCDIU3WqxjYJTrag5olGPzSBlrVA4UIpgTJuCcRB6JkAR
	 VWkJskHHGzlGTGEEX481dtJSKy8ejJIDWMLbndiYzgsZBIRr5fvX1YCTBMp3ruXi9A
	 W01wh32tjLz0chyZF5A2V6luANl3kwFbWxqbA8WJHKCmNMYIXu97u0mTzmeB96NARt
	 cRqNS0tTVvjTcnUxQlX0aOmmS2NjjO/rHnqJFNJzxeWhntEkCmoE7v1nPk8wY+UYnF
	 Svsn0KmdoTxSaifSYMD+kSUSwyWsRoxtqrwYa1Yuot3ePsEZ1DTf6Zeew5Q4h8XziQ
	 XBEEnuxIrhbmg==
X-ME-Helo: mail-ua1-f53.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 May 2025 02:44:20 +0200
X-ME-IP: 209.85.222.53
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-87c03d93848so560981241.2;
        Mon, 19 May 2025 17:44:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBegtge3jguvozjNZuhqU3pmkGv9AnGOG8kPbhL2DNYgeso+125NwBba6YGNdH4Bdtwq170SMMIKBVNuMjNpvE5A==@vger.kernel.org, AJvYcCWPo3Vmv55HV4sGiGle6tg1HHhzGKo5sTQ9gRQFV01c6LEuYHwFRP4XGva1srFie7gOXJqO7xKZQzX0qK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCCL54D1U3lCxAt0L1cRh2xGl5NXc8bIJQvdjtxPnFD0Yh5f6
	nRhiwinPwFUM3n2qSqP+KBaeBBTzDAiJwtuVb1nraejGZbipI8gW9btIzxtynqOag/xukQ2tlTl
	dKsa8GGexJRskJa2hahZlOjodvm/QVas=
X-Google-Smtp-Source: AGHT+IG8uEJ/tu4eNKdpef3D2/1c0HX4ojDfoAMFvMKxm8EX5Jr+3NyOza8CowUeKmUuhwQ8ofXeJK7Wl8GMr92ikQ4=
X-Received: by 2002:a05:6122:d18:b0:529:995:5aec with SMTP id
 71dfb90a1353d-52dbcc85543mr12794316e0c.4.1747701859557; Mon, 19 May 2025
 17:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519214126.1652491-1-acme@kernel.org>
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 20 May 2025 09:44:05 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJUf=LpczMNu9WwLik9i-4tJHYENvM3d15nxjNM+_vc5w@mail.gmail.com>
X-Gm-Features: AX0GCFvSS9K1OuZGoIL3eeBsQEHRTpp1TyjaGzlfFZ-BMPDeXAr3qSiOzzxx66o
Message-ID: <CAMZ6RqJUf=LpczMNu9WwLik9i-4tJHYENvM3d15nxjNM+_vc5w@mail.gmail.com>
Subject: Re: [PATCH FYI 0/7] Updating some kernel headers with the kernel sources
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	I Hsin Cheng <richard120310@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Peng Jiang <jiang.peng9@zte.com.cn>, 
	Stefano Garzarella <sgarzare@redhat.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue. 20 May 2025 at 06:41, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Just FYI,
>
>         Updating some kernel headers with the kernel sources.
>
> - Arnaldo
>
> Arnaldo Carvalho de Melo (7):
>   tools include UAPI: Sync linux/vhost.h with the kernel sources
>   tools arch x86: Sync the msr-index.h copy with the kernel sources
>   tools headers x86 cpufeatures: Sync with the kernel sources to pick
>     ZEN6 and Indirect Target Selection (ITS) bits
>   tools headers: Sync the linux/unaligned.h copy with the kernel sources
>   tools headers: Synchronize uapi/linux/bits.h with the kernel sources
>   tools headers compiler: Pick the const_true() define from the kernel
>     sources
>   tools headers: Synchronize linux/bits.h with the kernel sources

Note that there are new upcoming changes in bits.h and build_bug.h
which are queue in the bitmap tree:

  https://github.com/norov/linux/commits/bitmap-for-next/

So, if you prefer, you can wait for the beginning of the merge windows
when the above changes will be merged and do the sync with all those
changes (this is just a suggestion, I am not objecting to this series
in any way).

>  tools/arch/x86/include/asm/cpufeatures.h      |  5 ++++-
>  tools/arch/x86/include/asm/msr-index.h        |  8 +++++++
>  tools/include/linux/bits.h                    |  5 ++---
>  tools/include/linux/compiler.h                | 22 +++++++++++++++++++
>  tools/include/uapi/linux/bits.h               |  8 ++-----
>  tools/include/vdso/unaligned.h                | 12 +++++-----
>  .../trace/beauty/include/uapi/linux/vhost.h   |  4 ++--
>  7 files changed, 46 insertions(+), 18 deletions(-)

Yours sincerely,
Vincent Mailhol
