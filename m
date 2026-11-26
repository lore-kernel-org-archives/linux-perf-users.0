Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795710983;
	b=0zPu/Vq7bUVyJ+Pr+rr+rN1NTQe25iCOHRmnMUdI6y4P8dzVdIQTgNuRY42SE6hanfg6
	 rO3YMRGYlcYmjMMvKWUYTMeTmamAgBewCkQG7ENBgAZx0UihnkHBP4hvtmcyOascoxvL/
	 n49PQpFbmm15NRn4hpuMhJUJL2nCgtK5SKtH/gBu5XOe6OW68Hn5D081mS52D3PLsS7Kj
	 phC9AePRVtiIv6jUYrkpn/CYZJXop6g8gWHne2PEY0rEMSx/oLE6MoXNnYWf2LBaGTn/P
	 B7Kt7WvI/eSFgeYZWqVb2T34pWC9vzutpsIzipMjEcfrkCfkG378AO079hMNYnqtNfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LFEx+gS0KwbEQ/6V1mz+8OMjx0/yll4VS+XXjBpHC7k=;
	b=Ixbwn56ihDfuhtedYi90ZQfetqLWrx13720XyISEpk1iGFeZBrVNbIdGAAQ2jCHg3LyH
	 Bh0poWMJK0W2j5bvVNT4P+4Ipf94xQtWFr97flIQPpYcNn+JkgKb1Y4Qg7BTdkmBwhu08
	 MG+Xq/c4DPqygS22L9NV/ngGHhzbSLcAFWpUzDP+hzI+3iT9B6Mmx8x21OfWUwvAEa83g
	 PFedkpP+nMzABgqGv3GOc6owZ/8JzOIgkbX31Ak6A0Cpc5g9Ymyf2oj3Qu8IZNkURe1Hd
	 CZu6PkAPR3ypOAER12JWLc1OnJBqNm11QgMEAA9SEq7542vO2U05vED3LCTrl4U62/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ptLiNKFO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC4606A323
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 16:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46AC4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ptLiNKFO
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1aefd1bf74aso3824801c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 08:36:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795710982; cv=none;
        d=google.com; s=arc-20260327;
        b=hehneXUUGAqlckz7fTh7QXp6FpiDHDeSH1X4KbbX1fYRuIoZ1j7uiwKnkuGc3T658I
         RayXNAPUpnIMVLvMqmrnkbhcq7YPzMIe5CPCzAc2RUm2kgc29bLbVGuoXB3TzakiAz8V
         kw96Id3WtlmwhqsOwmZylJEibc5UEoOePeb+LIoNwRSjaDlCrHBwTrGQvJ9ry8Ya48M5
         qKF2XwsEwMMG4ijeMJxl3KxbC63B4g2VjU5Pal6z2jYwenF3y4DxdnYSx3TEc/ANhWx+
         NiTCZa+ef00tJRwB217NBv/eKzFWSqPGYB2/NmBDWs4KIT5j3zg57uesP366cvXXoK28
         JhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LFEx+gS0KwbEQ/6V1mz+8OMjx0/yll4VS+XXjBpHC7k=;
        fh=Nb0L2RuhAu0WwCFB3RiAtROaaaX51PzNl9nmC4rEAYU=;
        b=PrNSHUSSzEkiwEQOFOS2Xjs8iAJedzMGZvrJfc370d7Gj90vPDwO3AQmLwOhatrfx+
         V7/LCDuS/u+2/3Fi1hnlT6+TJ81FzZpZZRNwSltemxb3hz0mELdKghUr7YRWxPPpsoUC
         bwU3+ao5TCA24+bK3OfhOacqsg/IOcmhIyGn+7q6yLGGGJiR1yM+M3FQfn37lro58KAT
         pL+Z+SrVGrMU1o/czlif08knVEAylCwG/uI6TpQWTSQ09sYkKbaq243sM+/z8HnlRlKQ
         vFUNn1MvpUpEWE7oJAebA1FBzEIN3l/3TwZgaurt88FMSplCh/i7KqYotOjZSXOE87L6
         gvmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795710982; x=1796315782; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LFEx+gS0KwbEQ/6V1mz+8OMjx0/yll4VS+XXjBpHC7k=;
        b=ptLiNKFOylNx7Ejt4KNS6RHIhckRNQp3MTgRjFlxE8ftMWIgqDPVI+KiSHrjdjkTxV
         exY2Bjms2hxcedy7I/LTtPh70Ea2ybaE3FB7MQqblceklreQyJ49FuIlS2/wYjo80qBE
         v4Th4AsiakMsMokYhqRypHSKft8NNBJxgw8r4lhklKkgYRh64S/I7CMC62W0c8Xkbiwf
         jzn8gWvetdmLhVJMrHeOVqsu3FyQBoSep6S7KzJN3L+xoaTKFBjatPNwc8zfuciCBnwf
         QyrACjIN37F2XQeiuKSPS5aAE0YnPojlBx975VREskcYxXzYRsgzwmTz+SmVd4phuefY
         odnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710982; x=1796315782;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LFEx+gS0KwbEQ/6V1mz+8OMjx0/yll4VS+XXjBpHC7k=;
        b=JYGWPWMG/XSla26vtjQwQF/wKNZvUkJKwxYbCi5LtTWD6Id8w3bAN4u+MlyWF/p6KJ
         zBHQ6oxU9qytAub4WE2pliAsbaOQhjQuow6rtSFFYqljjp94KlSGLgyuXUYeKrG3IoQX
         FLDhz5lCOHns87Yj7sVKp+GK9GynJFsQsq0eGYg2O6O+08YzGShzlvwfgT1WIRuIdQMm
         mVJOqkcy/I7Y19ADMsXrkH1aqKmweZV82Ttt9NjW23uaM8STk6l+MEftLX5HR0BQbxgR
         he0yI4CEX6FuJMMMHuPEP3ik/95Nn3jbRfIgtdg8TBm7Fp20TXal8i+bTAdTYc720Dyu
         +tCg==
X-Forwarded-Encrypted: i=1; AL+hErG9VtprG1zs852elQxVTIEyjMNcxlgJwvGeRkKiTnKjxRdqrNoC0uLq2DFHwT4gGFiM1G+4AUICNUmM9QPOYGbQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+6OjtYx9R1k87Xs599pu6ZFRnFcCM59sxi+y82KqJZrt0BeXz9
	0ziBH/pUPcusbonpEUX0YiLgkQ+ct6G/Y/rfoB7QDGEfODlIeRqh8S74RkWEdRXUfsAP8nfAhwL
	u+jEwE2IleNlG2Pn5Gfxf50NVGOzbWVPI3UFRelYR
X-Gm-Gg: AZFdTZcPjVLlbKg11wJiNbaCokfT6hhOZjy3yb7K7U4ITBul410bUfWyNXXmhtxXPEk
	VwqcAJ178qnpseTChqVbb4chg6sK3L7410AT1JiKVUrR4lJYmnDd4OIOqy/fInIEh0cQJWm45PM
	KeamLaWQIsqBQC54AlwS00XsZui6CvCXMfLU+iNDG/IWGfKAaPe0RRsX4OuDewofoo3/J5EdPK9
	4Qgmhj6VH97ongELzb9xkUZBS9kPANkjgeOas7Bnu7GqnXkSN6Njj5OW4ZlnnpMMGqXXepzHOcn
	WPgRZV+hS/e7fQ0xiekBPJGepzsv2SqOjguOZesgx+tm+fLA+AyoumJiJHlSHU4t3Ht1aZoFYYH
	R6UPvfyB3FUISZAblGLLKD7xXoVEHvG2IU6JpsVtbBN94lvpxW0sJLRFPIQR5vPkA+o36
X-Received: by 2002:a05:701b:2706:b0:192:a481:361 with SMTP id
 a92af1059eb24-1b5568c12e0mr20476197c88.7.1795710981271; Thu, 26 Nov 2026
 08:36:21 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119192228.2661266-1-dmnk@google.com> <20261120115601.GQ2668564@noisy.programming.kicks-ass.net>
 <20261124181148.144716-1-dmnk@google.com> <20261126153041.GI49833@noisy.programming.kicks-ass.net>
In-Reply-To: <20261126153041.GI49833@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 26 Nov 2026 17:35:43 +0100
X-Gm-Features: Aa3M54qRfAjovGbLGq19LIs6hzzgOCioSYJmfsTA9DZQWXOGc3FWUSD2SR7jkWs
Message-ID: <CANpmjNMZQ4i4f5kpc0XXp8eT9sgg2+bCYb7Ke_RSSbUkZ7iDqw@mail.gmail.com>
Subject: Re: [PATCH] perf/hw_breakpoint: fix ctx->mutex vs perf_event_mutex
 inversion on attr modify
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dominik Maier <dmnk@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Nov 2026 at 16:30, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 24, 2026 at 06:11:48PM +0000, Dominik Maier wrote:
> > Hi Peter,
> >
> > Thanks for checking. I'll switch the second Fixes tag to 82aad7ff7ac2.
> >
> > For the lock: since perf_event_modify_attr() walks child_list inside
> > ctx->mutex, hoisting each target task's perf_event_mutex out doesn't
> > look workable. Would you prefer a dedicated mutex on task_struct under
> > CONFIG_HAVE_HW_BREAKPOINT, or a larger cacheline-aligned hash table?
>
> I'm not sure; you're at google and should have access to both very
> large machines and the workload Marco and co have created this stuff
> for.
>
> Did you run your patch on that workload?

Back when I worked on all this I added perf bench support that
exercises this close to worst-case expected behaviour. Just need a
big-enough machine (VM is not good enough). The git log of
hw_breakpoint.c also has the commands I used:

> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512

Dominik, can you please compare before/after?

If you need a large machine that does not suffer from interference,
please reach out.

Thanks,
-- Marco
