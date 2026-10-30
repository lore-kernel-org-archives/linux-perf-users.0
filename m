Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338669;
	b=La74hK1RA1vXQV28OQN14BAYHHvlvHXlY7dG8QFS9FlRhFIQkOqkbDIEgimuTmqPTZ4b
	 7iOh7eik4SYgLAU8Z4I/eKDg9OjaX9McKb6yeZkc91HnlpAOiDzwIrJVCXb9ZL/urjqfx
	 EzPkgDEYElyr1l/wuyq9hp+yAL1LNNxWmPaytpjhsGsIaWU+Y7FeLdQgQfJHMREXsIHi7
	 gfCh3SvA2kaRDa5Y1VJlCUy9K+2WE83qfDzU1NhYtALagHV90ATPi7b5Nw0lCbFLsYG1z
	 h+KfDoqT59N5xr7UJjpzuD5FbDGRBgD3V+PVHr6xPQDuT29sMMGE2NGjjwHTrVOYE7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=Hd4SQw/QsN9XPTgyF2+dmbFrWUM0nmP5RXI1Q+IpKS0=;
	b=Zt2Kj7/xtGOV8IwOs6mA1IVrxOmlFQctswyzfv0ZVY+Kq4RgJo0+cp97RDfyBz5nG+MZ
	 V1mtRQqOe9WPnIXYtcpk2izGnH7VLyXKAgxOk2cF9vbcnI0ghAVD4RzUj8bVYld1M2BAX
	 BTLmO6RPbsSGD/o7nSRFzPKImgqpxc7jNlJHOuGH8OZlyp19qCsZ6ZiYM7agc8B5KOSLy
	 jwEOsnSLFNQTTe4jz6LzfSwtwIFqXEvAqrhyVwBb9WbdqiVq43GaRh3rRI/SKZta7htOn
	 v+YO2dGwP0XyCJtQoPEL0Xx/Jn8BZyp+prVZG3v0EpQmLhd3gkeDfsNhwukBxah+eJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nxDPXlUg;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1A606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 05:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nxDPXlUg
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so247242a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 22:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338668; x=1793943468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hd4SQw/QsN9XPTgyF2+dmbFrWUM0nmP5RXI1Q+IpKS0=;
        b=nxDPXlUgOMehr/q+yNYTph2OS3Xb4G4nZB/BKsVnYIhiJvYLTP1EXWp4mnyhFtpg1O
         nEQ9KK4D1up/5K/bbqUL7KP3koA7DtgExIkLihSJZ1BHmoPTGBCg0xdz+GhB1o4/IfHl
         1851gTY8+T9g/XhdvFhz0TTHsnB8ZcOsO16MeD63J7D+J6/oAPtg76/g67Bh9oJZ9UiD
         56bAaY7Rc2z5jHRNGMZGcIKAk4CvU/ge2rFT5/UeNCuYkpSBxIT4KIYQqZDo/OCSlNha
         XC4S8xahuRaKRH+C1O5m+5proJgCRV2y4cxdPzWbcAHL8SqIVdwrdo1spfmEXzznqDFU
         w/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338668; x=1793943468;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hd4SQw/QsN9XPTgyF2+dmbFrWUM0nmP5RXI1Q+IpKS0=;
        b=JlKtDbtqgLSSUO94oLq6sZASKYMDd1SY6ivAYEhYFx7E+S/QjjNUdRU6ybBDUy7Nkg
         teTeUSSyWQihqFx6CxLe5m/P9CAiGcJSutpXTjLiLq7wzZwkt1Pm7beT16saHkB7ckRK
         aN7TaGyJphTJiIcFxm8zzD90pfqnsiJx1sacQfe66y2d+WNYFOhIbSPc9oj91aBVMByp
         KitmwJUimuxCELCzFilBgTyTkjJNG5MNrvTOUQY6coBSPnRwE6eNZHM3pu7b0YHwV0rx
         NtRUhOY+Zx1iG5GNYP6HAHRsCap2VQarFbfhNWD8h0iUAmrowsIcZWN7ivIEhkZYrO9V
         m31w==
X-Forwarded-Encrypted: i=1; AKwUvBxKBTIVEusjkWfAL3OxdtFPfppHEoD45f0vm0Y+iD3ejZdTGBd9B4c47/LXs5JJrQ6wvOHtk9UiJ01Oc173+HJE@vger.kernel.org
X-Gm-Message-State: AFq9FYJfi92fgp16UnAeOKsjXCEwziroPM7sdqoIBPdQhBOwdzrAJlbk
	1WdVKBsiKbq7ov1d2pGi4JA9viRhrdSE7x6TawuxcY8aqyFfEhrMg+un
X-Gm-Gg: AYBFou2k1BZIcSfh/2p2al4Mc25+GDlGWm0Y4aUyjScuae5+74YF2AkB+2YGSaghWCL
	vNVkhjxo+ohQr9IPfQmojZjaJaVWreJELUKtROSWg2MV+KndYLC09W0/1FTaJtnVAImnDte5Xxw
	zsbMbXlF2vatWRUK2YiXZv3Cw2kVWjUM5NT+MyhXbLjRM+2HFUdFHZr50kvY/bPY7ImlU8ZwLQg
	RBvhGivm4l7/OQr09neZkJZt7ffp8mUrWTwn5FsL0AtGXJqyb9qaRMVlTAeRy+IjF0okFk7I1eu
	U66tm/EyGDXE5yCug8Sy+wAXTyPZWas3G7x/Pb9JPttT5c/5ZtmdiaMhCGKbm0ScEOPBPYW9uOP
	lou6e/X/UHKezNkuZTGeuf/lUFqcvbBbZj7pWceYtsBXCWnD5xg8mobH4FnvM59JC8Mf2Gzp6kw
	sWpP9mrlTPSxpl45Cn7HhUT1/7x8eNhsO63BzgkUiE6UdBjuHNmyVUkfwjcmHdvW0CUmyFq5fgG
	ot6klaYKuBzMcJAktn62wxBy7OivZAPyxB4NuSFe/0g50NzPp24GEGrYeAJKiDib1iJIo/xm4NL
	oB5mQJaq7P7xm2lcjBrqYNyr6P4=
X-Received: by 2002:a17:90b:3b48:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3ae898681e2mr1040732a91.61.1793338668326;
        Thu, 29 Oct 2026 22:37:48 -0700 (PDT)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f662basm862596a91.1.2026.10.29.22.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:37:46 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Drop stale BPU_FLUSH_MEM_FAULT entry
Date: Fri, 30 Oct 2026 05:37:44 +0000
Message-ID: <179333866449.669133.15101451727175644059@gmail.com>
In-Reply-To: <CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com>
References: <20261021224527.167637-1-takano32@gmail.com> <auEK6E-jX12Bi8u_@phoenix2> <CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Hi Ian,

Agreed, and v2 is in this thread: the entry stays and is marked
deprecated, with the description worded the way the x86 tables word it,
so perf list shows the counter once and a script that names
BPU_FLUSH_MEM_FAULT keeps working.

Ilkka, your Acked-by is on v2 as well, since you said either option was
fine -- say so and I will drop it rather than have it look like you
acked a diff you did not read.

On Arnaldo's jevents.py question: a general duplicate-EventCode check is
not possible for the reasons you gave.  Across the 1463 raw EventCode
entries under arch/arm64 this is the only duplicated code, so a check
limited to those tables would flag this and nothing else in the tree
today.  I can send that separately if it is thought worth having.

Thanks,
Mitsuhiro

