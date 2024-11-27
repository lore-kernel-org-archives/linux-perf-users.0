Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C69200130
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Nov 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723384; cv=none; b=SUzdHUKrPgSMqGzVJ8CJXXGV2QI3Fbq8TAfhd1FxH7Mb3Mc7ROayxmChpdOvlA8T6JmYklTyvFUrCdg2AZ4XDubjYwLt4RnwLyS6ErMV7mKqssl56TSo7i4EpEiwPDj/3MaVeF5Lp/K1/x+On/1c+rF8LUcbUGGJEszctcLWT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723384; c=relaxed/simple;
	bh=kvkQBgKgqvbTXYYmqM6UI6L/FLm2zpO7UdH3CTjBjK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZbZiXcAeKQ4kLdlXMdizqlj8/iqgTdWIBzgqNVtUeCGz/5oSumvKnmlaD0TPkNMV1j4WN7qPS7P+0aPOz+v8mevYMlWHVbfgRtjnV6NHOOT8HX2kZ2CKNsjRQ+BIJUaBjBoICXJjocYSerJGjQS16upck7Nmycknm1RKHTrWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eo2OZrA7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eo2OZrA7"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa51d32fa69so743497866b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Nov 2024 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732723381; x=1733328181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdWnBnwaeKDvwcEaAV+LyuOscfq71IzH2DRHDLZ0UH8=;
        b=eo2OZrA7o1sWFDiNMaLqnOwRjxg40qeDP2IkUY2oswBLW1DNdxyqbEu6kN9DtfLaAo
         bSfwTZmouWbka5ulniPi6uwyk17bTAdvgO9XbPzzdGky+qrRMJn+32strLjLbhupj10O
         tqXwsmltM3ZixTsXJoo0VrDLn003onjbY3WZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732723381; x=1733328181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdWnBnwaeKDvwcEaAV+LyuOscfq71IzH2DRHDLZ0UH8=;
        b=aK/h59jtL8C1VNdp2rP2fBVvcaMdWC44GGmdjjd8ieokgOmAuXOxB+3x+M8Fzaf7M4
         Syv4rNo/6AMsmr9EHmgVj6VX4GkNqb0wp1Ac25RDOI1WpcRo0yEAblfh3gmdvsk2vw6O
         XVCG98a6CW9W6J4w713CLuW6TzrNewAuDt9PcvU2oOf98E2KscLoWr8of16gHWZN6OK2
         P/w3EVbiJMtoPph/mIbH0SIPDGQ2/pYrucN2OFZuOEybFeDfpYhvCa7OOAN3HzO0nplr
         zMIwNp7STwJrUHAW53hSE2/jQz1F0ZjfjEm+1l0VVZjy8LlLK4V7lUx8AIhERbUlg8PT
         NtAw==
X-Forwarded-Encrypted: i=1; AJvYcCXz8CoWrAAz4AL0df+gPjBEzvkgiuh4jK9NX/75vbzAlKuYvI47g8dvkoV2neeUQaMeT/Ljia8tdHO26lX33I0o@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2+YnpK+H3soHtsRgVKv6qP3RC/vckNNdIEwh03ax3YBTedA7
	2XFwjl4Zvr9t+SmDkLZypWYaCGnyCZDdgQpHuw03y8dYaBrNeYeNV/1aJKSx7wiEVP9StOHhEyf
	fTaucGw==
X-Gm-Gg: ASbGnctFZLp5aCxf5UKHsYoFmLNcS4p8soXotxUcb5N89vSc6mHVeQUBf3MfBMuOvLr
	79DvGLWEgKsdq7x5jZDiMXb8vYZ2oe3ZrL9snGBhzgMp4/ilhIKZPbkCkKEgC6I3x6tHJ8wvPWH
	YH0d4eKCbrS0sPvIWCP9xO6chEBK+DX16If0g1qaChteq4G31cKCMgvp+/2PfW4C5Ns0rc9VIAq
	ii3DBSS3GLTNNhXUlNgdqIQhWAoT/4YG4Q+52cXawtQw0IZ0HMR4LSi3mwSZy3DyTmUwufo03/h
	ASm0PB/f9mgvwiD2stbprXud
X-Google-Smtp-Source: AGHT+IGESO0SyNCk3eKp4lbOnF2CmhTOZlC0g8V+8wLwR7bgFVpnCqwI20Mx6BaBSjQSaoFXuM0DLQ==
X-Received: by 2002:a17:907:775a:b0:a99:ff43:ca8f with SMTP id a640c23a62f3a-aa580ed01dcmr289283166b.10.1732723380477;
        Wed, 27 Nov 2024 08:03:00 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b7333sm717149266b.177.2024.11.27.08.02.59
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:02:59 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa55da18f89so440322866b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Nov 2024 08:02:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGOBsZxrqmrHK2VTt06YCHBik+6icNZPeUPwbZsBLdYuoKKh2LKAA7aZnYlgPN390G2HDJGuqLWado36btFh2v@vger.kernel.org
X-Received: by 2002:a17:906:3d22:b0:aa5:50b6:a600 with SMTP id
 a640c23a62f3a-aa581028af3mr237466666b.44.1732723379380; Wed, 27 Nov 2024
 08:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125071653.1350621-1-namhyung@kernel.org> <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
 <Z0ZhDHXxHKoE2Nrl@google.com> <Z0ZvAB0vcL-D-a6f@x1> <Z0aRFFW9xMh3mqKB@google.com>
In-Reply-To: <Z0aRFFW9xMh3mqKB@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 08:02:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=widREwanfzcQ3YUvqQ42xLmQHjK_asCFN2jTBM2OHY-Ow@mail.gmail.com>
Message-ID: <CAHk-=widREwanfzcQ3YUvqQ42xLmQHjK_asCFN2jTBM2OHY-Ow@mail.gmail.com>
Subject: Re: [GIT PULL] perf-tools changes for v6.13
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 19:25, Namhyung Kim <namhyung@kernel.org> wrote:
>
> I think it's a bug in perf record since v6.12.  I found the build-id
> event in the header area is broken.  Can you verify if this works?

Ahh. And the reason I thought it was new to this release was simply
because I was traveling during the 6.12 merge window and didn't do the
tools build that I usually do, so I hadn't realized it was actually
pre-existing.

Your patch indeed seems to fix it for me. Not hugely urgent (I just
installed the fixed perf binaries and clearly nobody else has even hit
the issue), so I'll leave this alone until the next perf tools fixes
pull and we'll get it fixed then.

             Linus
