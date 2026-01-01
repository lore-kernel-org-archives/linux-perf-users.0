Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5C3A1E67
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767298643; cv=pass; b=Qr4WsOau8u0qUsv2s+7+sLSkv/lrKGv8cV23lktb6OOkJF0B0G8albX+mORA8FoAoj9R95ceJBc/OGvJT1rv8l/qAlbc1iPeTtQ3c+m1fRAPGkq1gkaos/1wekNI69pHSDbOWSrfdjfI2edPDIrZymjMINmz+Ep95YZHLYw2RI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767298643; c=relaxed/simple;
	bh=C0ucjTAswxaTLjTHJ/WMvEWefAwAoUCMadTJWLGtWiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoYX7TLE6F+BkRRanJBe/3YE2aKsQMTv5RD/khFkCbtEi8SU7AXVr+wB7ppZAQU0HGecIRqJ7YdH0JLkdZZYIQ11QJX/0LFY2XCrM0sjkkynKWLw1GPpLm2ppXI+GRoTQqCoTMPOAG71Bt68y6g8UC36VXkeGraeuCnvz1/7UN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGRgC/Rs; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGRgC/Rs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a1462573caso245205ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 12:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767298641; cv=none;
        d=google.com; s=arc-20240605;
        b=KGkwFfSLkXmkkKlLYGLqG0hvxlpAnZvx/2dTFsJaTb9a+z4BI2HDRhxzRtxTqmdLuo
         M3UABDUnW4fs8voWd6suz7pj1uk09w4XkG3NEvRyjXa4MyJt6m8AsH3KajRYIV5Iocdt
         SLqeEnR5624GYdgOH2s1jg2ZZk+fKIVtEi9WmKcXI76u8Yx1bwTgMdzrFXRJZWgKj2p/
         Ut6RJh0/laocwuIluF3fN1V9XSocZcuw+2hxrziSY+p+9FvBBKY9aDCMkNFHk/PcuFPj
         BeSQHEUYFftgnDkRBbvIeiqbD0V+uPmZtJRu4kFuNH5sKb227BbDhaIgzTft8QQXLxn6
         mMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xd3qfCwZr7bQNOtMP97/Y5viSGC9SmDjMaOkf8dtk/k=;
        fh=Ur2G5n8ZQRRv7Kxjdh6zJWEGtF5kH3d3N1a4dhJRcSo=;
        b=bSPXja/nAJBStOjmuNRQxgaK6hZJvSjyd0yqjoAihv6KVGCH9N0kzZYGeLrOlQl/wB
         kIxRfkzR93ZksEpgZxO4nsv72upmk/sIU4Pnol0XqzfRyccoE8bsGT4u0NdAtImmNtUy
         DK4XLsFvo1iW388flyqv/QNbbW1wMmWzTAxV3XBCohFSa9Go2KnxMG9u9WJrz14hCfZy
         GE+vV9DEY0FBjnI05pIQ1755nTnRwAKmYRKyuqRhdd+LS6QTKsLFMrjPGMcTxGOxa/Lg
         YJZOA9P0D1MOJ9gnridpfVgIFagS/pz7kogXUsRD4ryDXARvT7a4cf4ejQKnR2SmSfr9
         J+Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767298641; x=1767903441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd3qfCwZr7bQNOtMP97/Y5viSGC9SmDjMaOkf8dtk/k=;
        b=fGRgC/RsODpck9CLT634PZ4zLw6EAZsFIEHSkKfymTAmfMdPTP948a+4YDKFNBplkU
         3MyTggCPv4CmTcBqdP1BLyGx3ZbRFpS0TDx7V21vnwA5FrFWHDzmx1fq9kSrSRzuYnUo
         bs+pDDFTOTuuRHD2wV2qLLg7GcN2AB/GMCEgGtsUuZQjS8e4smOwa4i142rJ0AuaAZ49
         lRxsybReWgC7a98yITWDEreT/r9svmh/RPM3148xFHRWSIjcPf+1Flnm3BzD0UQ7UwMS
         XUcJFffkSDK/R0++t1lse11YW4F2FEsEHIPlEMgAqSMcC2vy6OWU2CwYZhp/MfzH8jcX
         ibgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767298641; x=1767903441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xd3qfCwZr7bQNOtMP97/Y5viSGC9SmDjMaOkf8dtk/k=;
        b=Y4bZh7jNqfQ5scUXwv9kr11SLz8ZhuXrHuw/vxzgMMAjTclP8AII0GMs/trQ9vBwuy
         S4bleRVsJUOHb1VJbykx5akpTvhkqLOaRQBsH8QudI2BP9NEoPAKAUDlEaT21+L7AIG5
         mneXIAzIRlveZ7LXi1STUUZ35wJueBH6jW/yxqUJ8uqvJj7/0WuXiKR0ZGeUtmNxLQ1v
         DACeQogF0aU+DMjW2jP2p7VozOqs/sst0NviPsbmFmUXHAxZ8I5vetHtr3gfrU7ptokX
         8MXcpydcMmJugUwm2BhhhDuWr1ZLNiViQnFPgTu5IfoodIAy/qKBr3Ib2mpoVHKRQ+gj
         Kv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWC0ZuIA8GfGyfHEjbOzMFiEAlD/+GYS1kW318YbVkSNqXpSzKl92SQHuDa0e+AhcwLf94SsIbJqJM6ySYwUNdL@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCTUq1DrBqXLz8fNY1OEgW/TcWPayuDBlFMlhBCAWujY6zNYb
	QQvGVNjKJkS5/bFRiKC0DyL7hLfod0hcpvPD3ySLyJ4IuihcytBTrXEw1/Q0uE3kiOw9UXrU4Pc
	/kslY4/+ZO79ZOQWuOlohWOFHrtYDfh3kHz4HNTW0
X-Gm-Gg: AY/fxX5PAxcq6mhp53xfV9aaUMFoMTCdxG3Bt6nckOhRzcJ6DwzfyN2TJH2bdVuKCWV
	2+K4TCO20CLDcbDxCLhLXDnRan9cUsyjdU0YjVU6uY7QQaRHuiJ7gzE+w/b0FfNRF6oDqRH4F6l
	/61XZaxUT6s7QmYLjc47smvIZLK4n407iXhD5djzNrsSeNZOZMN8MixlbsoJmmMTgsRc0eiNBIe
	dOmZs4d9bDgRoBR8/viFeZ59vlReCnkqNPAYpp3E/7XRhEIk0uPW+FYu/K0ulFL02YRC1fR
X-Google-Smtp-Source: AGHT+IHH5duhvysbptcj6J5sTs/VtPbaM0aggdri498TObWuj7o1HVc1P+zBCFmxkDB1hJ5f0Xkc9Tjb87Kltre+01U=
X-Received: by 2002:a05:7022:380d:b0:120:5719:624d with SMTP id
 a92af1059eb24-121c689b121mr104646c88.20.1767298639973; Thu, 01 Jan 2026
 12:17:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122093934.94971-1-irogers@google.com> <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
 <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org> <aTtVO7Iykc8oTl8c@suse.de>
 <CAP-5=fUbZ1pjvcbF0do8BrC0NAzkOJeQUAozQhXKpGuosrW3ew@mail.gmail.com> <aTxECtpK3wdxd9uI@suse.de>
In-Reply-To: <aTxECtpK3wdxd9uI@suse.de>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Jan 2026 12:17:08 -0800
X-Gm-Features: AQt7F2p9oDtMOtINK_Pv0YXjC_CYeeOcZsmE3mZKOv6ZF74ktVgOCSSXU6WXtx8
Message-ID: <CAP-5=fUd95Hw8opxtCA+5aO5-6V6_Y0FMPOCCSmfwsDP6YnzeQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
To: Tony Jones <tonyj@suse.de>
Cc: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 8:34=E2=80=AFAM Tony Jones <tonyj@suse.de> wrote:
>
> On Thu, Dec 11, 2025 at 09:20:35PM -0800, Ian Rogers wrote:
> >    Thanks Tony, those are great performance numbers! I'm wondering now:
> >     - do we want to land addr2line with libdw given the wrong file/line=
#
> >    problems or wait for a fix?
> >     - do we want to make the addr2line configurable like with objdump [=
1] to
> >    mitigate the problem above?
>
> I think we should spend a bit more time understanding the former before
> doing the later.  If only to provide some documentation on why there
> is a deviance to explain the configurability.

Thanks Tony, did you get a chance to look at this?

Ian

> Tony
>
> --
> Tony Jones
> SUSE Kernel Performance Team
