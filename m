Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5923CF48
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821043; cv=none; b=mFznSXmSVUMD2MaFnB8CNf1ZAfTjy3+RXM6Hh8HmkSlPrDJgYQyEPFgIZ4l3dZoE+Hl7qHObfakcDFOGxpDn2FNnQ44cXAdJWNVZpS8NvloaN+64hJCOkZhXKxk70nMHiSqLmMYPjYdVial+neaKd8GhhWxJ6MzUV/WQkuVDsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821043; c=relaxed/simple;
	bh=urrJyHrBIsQS9KKLtMLnx2kfVk9RVyLYlhfhNo7Fw9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cL0vPBvouqxVrcdr2I09EN5S4Woz2GmJ00E9q5Bh9vxFVr8n9+o/xv3ywWBYsBSvTzky0OazCMlSfZJjsZtB+T4Ne6wQrWv6DV13vJrbWiog5aHUtMPt5FVF9D/FZXARiQoZxn2ZM7G/RPHDMOtDtVeV/96tWeHI/c7/lPsZXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WXSzkJrL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WXSzkJrL"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so196961166b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706821039; x=1707425839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U47R3tnrX6FGfSIGHpWmTF5rVj64ObwGeUEFtVpqF+4=;
        b=WXSzkJrLLBo8YfVKcsrBuqSwO+C00sqHv4+52wN8SkmmO6vg/ve0XyX4syEEryiFeb
         60PthlqmwyHj1UVt2fkW2gjabVjMXmha55/zvvIEUa4GmdmDrawFV2Ur5RykRoP4ZiZF
         wyo/bVSvoIN/vw3uPa2yEwl7NCvxpdNZ/SuqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706821039; x=1707425839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U47R3tnrX6FGfSIGHpWmTF5rVj64ObwGeUEFtVpqF+4=;
        b=ecUn0c3Kv14TUnwk+8n2hKiWjknr2UnRUk4MwwwVYm/zhJutn096qlq6sVuxcYy0oi
         Yq49orG2z2F0XHkUGXGRYPkRxmx22QJy4wjrXwqIVSWTSBBcy2KgS9HNFLjClrmoUZih
         nBeoAswUrR9oHYM48Z4880uqzR7J3LTxjE+FfZp0BeJ3TSY7llZLIyKUJU1KiuXp/MfM
         Jo88fNnrqAysDPbShXIOF5KjqPPou05jsiwbU1avTgJKr+8r8XwfgXBdMaZc8OdpvGPS
         MEMqRRHNxwJLtaoyLeC9Itkopv6glH725NPk5EP/kpWCOi3brTg7DYq3hhzbR0b2ZVcr
         zV9g==
X-Gm-Message-State: AOJu0Yz6yOAvoMFWhiHMY6Ktes6C9AVJsBU16hrQsxCVpl5xX2V6S58t
	Wem9vVTzoQaVnFC5Kb8chyXGW2pdjdfy2sWqv0ULNy8TmHwUXW/YeXj713AF1tn70iEFCpuMcSL
	ud6KcPw==
X-Google-Smtp-Source: AGHT+IFz3ioh7vosY1mF7Dqqzpl6jX7WhNIp0zFHAuPly185SUX+j6UMUGpvsruEUlXIEDzkAiYOyg==
X-Received: by 2002:a17:907:7711:b0:a36:f672:6e8d with SMTP id kw17-20020a170907771100b00a36f6726e8dmr224107ejc.5.1706821039289;
        Thu, 01 Feb 2024 12:57:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKfWKRMNhhLkunUncMSwsFqqdYFFKM508dwhzrxakPnriLlatlVZyaZF542woXml3dpYzs4HYdG8gU9yr4DRgIRqACuOulwSXweSQ6YWTamg==
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id tk12-20020a170907c28c00b00a30e1f233b4sm152285ejc.128.2024.02.01.12.57.17
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 12:57:18 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so1878740a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 12:57:17 -0800 (PST)
X-Received: by 2002:a05:6402:3181:b0:55c:d503:764c with SMTP id
 di1-20020a056402318100b0055cd503764cmr4327080edb.22.1706821037656; Thu, 01
 Feb 2024 12:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201202254.15588-1-acme@kernel.org>
In-Reply-To: <20240201202254.15588-1-acme@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 12:57:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
Message-ID: <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.8
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 12:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
>         Please consider pulling, mostly 'perf test' issues, which in its
> turn are mostly related to myself having Intel hybrid systems at home.

I started pulling, but there's some truly odd noise in the tag, so you
clearly have done something wrong.

You need to fix your odd tagging process, they are normally noisy, but
this is just so far off the norm that I can't overlook the craziness.

                  Linus
