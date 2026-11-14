Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794628873;
	b=DwAiOPEUElLXn8Eqt8NjYSd1dBFkN9kgn/RYo4vGdA0GWt4+PLCzFiO9dxwkdaAUcVnm
	 x+USN0yy8bv3XQTA5CiMCAEkPv1TPQxAXI11uJpne3oC5uklcK7Hbmj+lUHbwFpNARsFG
	 TOOzM15nQf0x14UD5Bl1KhGRomHD1YQ1KvJNR+meKE37yzHMloNBrZNZ8bH25GPS8MqzL
	 klvv/OoXSpEZhVsYakUeeAnIFTGzGsinVMAa5oAY7Ow2rw1j498t0mFa1bG5BR1x/+SAr
	 guczGK67DWOZUZosfj/SKleqY2H9954OcQEDsAmIGT0n6NmASKXG54DnaL7E572++rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1B2T0Qlp7SxuW+qGAUFg3vBl1toeAk+9yB0Qb2CaAgQ=;
	b=KcKv0ufSsJIiFbdTc6xgnOQFBAS4lAg8/ImBBOdzrrg5m/x5F/FpZhvXAWIO7iXXqzGg
	 QPmIFN/Y7VlcqcIgYE29V5FRRX0x6sj7kYXxY9sNQqGFZvZkdmmFpEgVp08GrDcyACdjk
	 PnZHCMHyLxmOIV7U7BrXjzd9HkPinShvi3wWKRo9tnJSUkoArN9xH2dVpQ/UfpVUjYDix
	 JLo47Obws3VpyOaxUhryLMZOHv5JdQqIjl1AQeQrgqv4bESLrGbSKo2sZmUXPIZYZfRXg
	 NHo+FzFfgsUSlwRO1raP2ysGNXO9gAD4LQMX5XVcfFzCvYEFlV1m7IA/gdDsNB1G4dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=giZQU52T;
	arc=fail smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B2606A8BE
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 04:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 075B2606A8BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=giZQU52T
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67c246c0c60so2634496d50.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:01:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794628872; cv=none;
        d=google.com; s=arc-20260327;
        b=SuLRpYb/QEr6NmIZX1EKN3E4xBVR7TCRslNnMHFZPTeGe/xZg6FSf/elGYWu4a5JZZ
         PL6eEJwog1Ql4pdaNACg6UIwaExpssubxgbVcNgMp46/04kgeTUZpwXn2Ljw9AXVdzH7
         Hr2H1CJZuYAIv8etsKmX0BzPeNQ0w+X28ogkdUH6nyy10Oq0wkVCOvQa95aYNRxW32D5
         3zSjngG41PS3HMj5RRS6uG4UAueZEZgGi16XtSIdazI6g4EjyCTcyKd7OTLlN9i5mnMw
         CFN03b11An/flioaFohdYujpIaCdedQsVcp/wPV/h3SEvx46/hTpfonfX2spFR3PF27j
         65Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1B2T0Qlp7SxuW+qGAUFg3vBl1toeAk+9yB0Qb2CaAgQ=;
        fh=XUtlG1zfjhTP7GNapGDdtokFSKDwzyCol+Ic2AMTL+g=;
        b=otrc4O6mnGobpgz1cCgaBAYIbjrTqHbKyHiLUB1Vj6bnm2eMXtxhS/yOB6CMXIf6pY
         1NWwiEWmeohauSreCz5iAU/9c32AZ8Awg8GTAt19MPyiYsa5L1sgBNK6/FCovx88JM5R
         Bn70hYYVBL0eal/9sKjoy1DTdZBEilCqlONuUywFqbs5kUp9+uTTZZJevgUVpiacGhHT
         xkrlZcq/lVc15ZrAM2mE1O7/NxtAofs8W4sR1JLDFzQWM0vdTsgLO6QNWtEm7xysHHMR
         o6b6AMF+BC5oXqC+7GYZYe84L37faZCN6kyUwvimPTbPrfIltPEIFmdPDl+UK4jfMEWt
         hKZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1794628872; x=1795233672; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1B2T0Qlp7SxuW+qGAUFg3vBl1toeAk+9yB0Qb2CaAgQ=;
        b=giZQU52T402qCV+fpfDf0qxgdq+5QVENrYtKz3T0DfbRaYxgc4YEGd16+rNEGO0zTP
         KoTtdZEGHGzOgtZcz2rwxvWpntH0Z8nuAOJLyyHWdO0oZxkDvRHYDLcY32cxqR8q4zOV
         035DLlW8COEgogerrQwaNoTfp/+Iof/dqfcsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628872; x=1795233672;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1B2T0Qlp7SxuW+qGAUFg3vBl1toeAk+9yB0Qb2CaAgQ=;
        b=pHB3Zaev+Vit4NszTKx6uOyhm2sh/khA5OPBkKESvjqY1DMcdxoCkCqX7T85DPHnag
         QRJgvGR1Pkx9dQ/4xpEW9so6CNU/xI54zxk9gRbtGt1zVt0T/h1mi1l7Owj6z79zd1LW
         CGAGBNYJZCEsVSb3I0q9wrqpfNV6mRW/FU2uLloNN8dN8nmR5F/gQJ7T1Ung6tq8g82p
         7KYSm0/5GD0x7gPhwpPqr0lQFhsYOBgAaIoKCoc9qwZHdE6Dq8Yv6b1zcqpwQDueDoqU
         U2LUgClDoo1kNVxy4Z4Nf21I8/BD+nXkuITKlpOktQw18dPlz5go9haZRGKFlYOGv5Pn
         HOXw==
X-Forwarded-Encrypted: i=1; AL+hErFbtzgGLimuFNG6b9e1L5QESMWfwupG9mD3/SjWhmMHRuA3QDb/mXvALBBWVAVRu96L0/V4C4IKIpiTTawdfQB8@vger.kernel.org
X-Gm-Message-State: APuU4Z/+7eUeO6Sdoq4PdCx9Hz9VhKQ3zCjGVE/s5GjQvyi1XiT8SAbz
	do94o89R3kxA0+8qCWA0jTQ6zEZDdJzUAD7mczZR2HKhU5D1zqfx9a+P3Ua/5FG1bvp7d6+9kNa
	KDsxSXukOSRfypGQc+zXU5CaLQBFMTS0oD4vbcuQl+A==
X-Gm-Gg: AYBFou02FUzuVEZDglVlFyB8/MKB0LzSmOjE3pQGgNAtkWYqfJi107kNc0gmiZhA00b
	v9v0LgzSs3/KHUBgAAAAaxOVwVH9pzSqas/6Pjgd/wjqusFBeA0fgntxTpBZq/vL1trFt2/9IXo
	UO/PG1Rl+LIrlIvPtczfA8WSOKOorqC+H4hxVeJeYB3+HXv2vSGDmi/h9t0w3Jhk9VCpTROGHLF
	D8Grw1AXP7b2JmbJI3vyU2Tgwrp5T/siw0qVrRzKzUoy+qRIrfNB6x7wdsiZ0/KZEe0XQqJB0GT
	ZFB1lIUx8hQhSda+jDrSabdZL0Z//Lo/zEnJguoZi3tyXWA5T4gXeP1RR4RWA33UftxLhxZ1DAP
	8q1/Xupgozs3s1N0K8bOy5Uwi/rU7zuqXD8OGa9IHoUVcV3s0VM0HXgFs1tGqFoLw7nIK4A==
X-Received: by 2002:a05:690c:f15:b0:8b0:a01e:2ce2 with SMTP id
 00721157ae682-8b3bb1a2e7bmr50130047b3.15.1794628871618; Fri, 13 Nov 2026
 20:01:11 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-4-7e90415f0101@uber.com>
 <CAP-5=fU9Du9cCge2aTm10ejtwBKX1THQpm=h7EMR=WVQLww6DA@mail.gmail.com> <auacxQZKtlFa9Pc3@z2>
In-Reply-To: <auacxQZKtlFa9Pc3@z2>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 13 Nov 2026 20:00:55 -0800
X-Gm-Features: AclHuK-PAd8WaFSlUgwMAK01VlUdCFUGPmX-smvUPTx6hiYe7HFC--zgfoa4cgE
Message-ID: <CA+w=M=S-H4d_-KCZJqdPoUCyfYtNDsKLd8t37kT134bwpKD7qw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] perf script: Add --lazy-load-symbols to load
 symbol names lazily
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 31, 2026 at 6:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Oct 30, 2026 at 08:55:55AM -0700, Ian Rogers wrote:
> > I'm thinking this option should really be the default, requiring
> > people to opt out.
>
> Agreed on making it default.  I'm not sure what's the case that needs
> eager loading.  We can change the code to load all symbols just before
> it (oh, it seems the patch already handles the cases) then no option
> would be needed. :)

Sorry for the slow reply. I wanted to have v7 ready before answering.
I agree that lazy loading should become the default, but I would like
to keep it opt-in in v7 and flip it in a separate patch later.

While checking what default-on would change, I found that a binary
replaced during the run gave wrong names. Lazy loading reads a name
later, at the offset the symbol table had at load time. If a deploy
replaces the binary in between, or the path resolves to another file
because the process of a mount namespace exited, perf read the names
from the new file. I reproduced it by swapping the binary under gdb;
perf printed names of the other build. Eager loading reads every name
at load time, so it is not affected. I fixed that in v7 and kept the
device, inode,
size and modification time of the file and checks them whenever it opens
the file again. If they changed, perf warns once and shows the
remaining symbols of that DSO as [unknown].

Also, each batch of names opens the file again, resolves its name and
enters the mount namespace. On my test profile this is cheap (1.3 s
lazy vs 2.9 s eager, identical output), but I have not measured it for
containers or debuglink layouts. The type-aware data cache that we
discussed on v5 would remove most of that cost.

So my plan is to run lazy loading in our continuous profiling at scale
first, and then send a patch that makes it the default. By that time,
hopefully we will have already added the type-aware data cache.
Does that work for you?

> > I'm curious if this is global just to avoid the expense of a mutex per
> > symbol or it needs to be global? [...] but perhaps the dso__lock works?
>
> Probably.  dso__load() already takes the dso lock.

It was global because dso__named_symbols() and dso__sort_by_name()
already hold the DSO lock when they load names, and the mutex is not
recursive. Nothing that holds the DSO lock looks up symbols, so v7
uses it: a lookup takes it only when the symbol it returns still needs
its name, and the batch loader requires it held.

> Nit: I'm hesitate to argue about naming, but it seems a bit confusing.
> Why does it skip to load when it doesn't have a (lazy) name?  Probably
> symbol__needs_lazy_name() would be a little better...?

Agreed, renamed in v7.

Thanks,
Alireza
