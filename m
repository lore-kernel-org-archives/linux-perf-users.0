Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A553E2AAD
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178431; cv=pass; b=SHJLB7/s4xTLLQAm4yOWeFM/YyJ2KxmvEznMH1//FfhnHhbp9lXg0tseK1ignoPVyDJnvP6AFItU9twCFVPpDH0QYorDIcnV+Lf3zXBSk0tiIGXNHlJL1L41M1ePtZ9iAfOBtYuA3PEypCxJkffA4ywV3yQQfQVT8PI5VCc0Fr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178431; c=relaxed/simple;
	bh=pMuQGYw4rk5BCWHmOsor/UFYRiWDZaRWKVHA67F2d9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHrWg1D49ZxNZex3iXCgQV0GA1sfdY2gQ7CSnodlzdHwH6JWsU/3+xQPavmvHYHnOjnxLifNi0YU4p5OIraC3bGeAt1u08UAxZPkZ8D22rLhKtsvDKfu2kH5xrD9iUrRm5K1AUF4ZuqF/luBHkGVhW8lsydtzH7gfGUEJyiq22Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIlZ6Wzr; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIlZ6Wzr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b46da8c48eso125ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779178429; cv=none;
        d=google.com; s=arc-20240605;
        b=lJAEm7JqklrWKRhiPbyYHF4Bdoq7Zhw7L7WXSNXWb2vhc3txaTsEZn3AYN4OBtys0j
         S16Oyy2qnt1eSh6VZezGN4i30R5vrJ96i44Yx7L/UPJ2AL5rRfDJZ2OTYRHIVnFE1IiR
         WOUILoHkXipvUljJoZy2gaHqkWMqeBaLMAqTXAED6nEuyh53A7RUvQ0xQYu53fjXok3U
         Rcx88gXhPm0/UPUIW58rfBZnOe49TH1E4Mfbro2ZDoODAF1NL5w9CQUui3E3jZgrtBTz
         1dNJaURstMrTvUbwKlj2ysxFkrZIWBq2asvghZ/1rBdxhP71YdFb1xHHi745V3FmKLXR
         mXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4Vc+lyxyW0QUafQxJDRhUrxVmKRmDsOU2JGDuchYSI=;
        fh=UF5jMlK0zLrWEuq/wCLbClzCxh+ua/Cer7OPzcsTFZc=;
        b=Sh6IwfP+5ujkYQZ9TA4HBo0+HuEdK2wbpiDvfe3XXv9DXH/vnqIb2ZYr0ZHVIMpVPB
         cddngfs2pQ3NZ+coRXHr6xh1ZMzxrpm57rcqDB8giIzn4DOqfZXnQbjft63JneczNSMa
         5HDUspX5qEYW2he1MFBr0/0gyXslDkaGJsuI2gyQ1lXuTrrDtPp6O3viLfZy0nArI10L
         blknHA/qKYGo1hRktylS71B5apyrn6aT2S6U5eRyRQW1l3KEzyra87jPkS58o1PvFw2h
         redFzcNNr7GfoV4EwAKn7Htb1ShG9ioVxPlwDe1KUSJ50GsWgCW8hKLJaxjLwWofcXJO
         2j7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779178429; x=1779783229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4Vc+lyxyW0QUafQxJDRhUrxVmKRmDsOU2JGDuchYSI=;
        b=LIlZ6Wzrx0ajzF7MZbDMPAqf2BLfw2bT0zuIGpw9mH+hZ5G5rEGuIY//XAVE7xmCVM
         YzJ9WCmC+YrAL1gXoWamfks5UJsL37xhrHos+IeI4LffQ03ikt2/fPbclZRQWQXDO78z
         7xG1R8cd/AIQQXhNC9lJMO8yhCyRm6wwMCPBuz3ha0391senTiMHaFvV0m6kiKURFeDi
         NbdS+CVNuVXtZ936wcnyTYNpzxtB8YRG6XMdpnLHaUcozsrkHsNGbAvrXbcR6j0NJRSa
         p6WpAEHfeaj/m6RdQYXh45i2cJcWKofCr11gdUJxTmu9jVaoVyy3CFtXZqZI0EnS3v1J
         TGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178429; x=1779783229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4Vc+lyxyW0QUafQxJDRhUrxVmKRmDsOU2JGDuchYSI=;
        b=lBl05WBvdUVKuC3gXGcGxAbm7az6Tt49fZwAdvRPVjnDTjTDQ73/2w3ZQ7C02/R4Xg
         jiSrsVN/Fqe/3W8pSJ4wf4nhWFsw1+b+7gri2BY/+hi9CK2ilf9V+j9viNyXKGn413tT
         Cc8JXf3an47nAuBLydxPadcCUzFR1MJPzxFdNW/CmtoDQMr47/fkOLXqSMiIrHWuyfmQ
         ueiorGI62cba4CS5LqMkZ8YVXKxMhGvhMKP/hYOilj/sNhpnZbTaSC2BrgdypI8O15ms
         V6t8Xmwk2zETgMcqChacSLRkpRF9CEXkCKNO1jfU1kL5bEMrJ1H7mKoHPDn4lkwxr7tH
         1uyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/kIREhtnUiXqWs/atBv2fRA52IS9nbDUlCOE22DoRWhy0MqhLk1nFFbOlxLViA2O1IMkgHW0j2Mhf/f24jc7B@vger.kernel.org
X-Gm-Message-State: AOJu0YwWrKBUjT39Zt0HB9mPCs00iPnJAMkTsWHDluCuoqRNE4ao2D/S
	1AiMX6XtZlJ/XALF8FPB4p4VYw/U3uO2tkTsU7fXJE12hFMCYkGJugZj+wbgXd3kMNrZ0OAhA5Y
	67eQASIedm+ufncz8Z9pRgV4SDflanYXK8eGzCQAC
X-Gm-Gg: Acq92OGUA0C+UW2yin2rMUScrEEro4OBhvg60CfQ3TbK/l1sZykmcESNmVZYD+7raCA
	6gKRJFanHOAjPMPLOIyX9T4dH19x09xejzvfXHjVX7q8lrttskTnKNnKX2gsjeaEl27NoTisY7k
	6TnSTDDJYkfvLe/oHOPFcAXiBqtNf7KXUWLdofjZ7TBgfprmVS1XNDeKtbW/GIsqKgpLsfxITWv
	ORdcY0RtvrR3iOIK6IHHARuaSOh4vzMbA9QtojVKx5++/9lcDcEIw5C/idobpxocnfC9IOcDvXK
	ICsOjTCQBwMngX7iW5ctNxT7nh1iJA==
X-Received: by 2002:a17:903:2a87:b0:2bd:6dad:3dfd with SMTP id
 d9443c01a7336-2bdb37cf83amr6195985ad.27.1779178427929; Tue, 19 May 2026
 01:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518223733.3034897-1-irogers@google.com> <20260519014106.3089452-1-irogers@google.com>
 <20260519014106.3089452-2-irogers@google.com> <agwGdqBaeEEXnAtp@z2>
In-Reply-To: <agwGdqBaeEEXnAtp@z2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 01:13:35 -0700
X-Gm-Features: AVHnY4LNtAxpG9ZF863vxBZZZrr4GebBXCv68LWp_Cr1gQ-fkAO8Myl0-6yDMgo
Message-ID: <CAP-5=fVsCXqC2-0-huGq5qdkdqY1KuKO=mdv7ZorTjdgyWF+Ag@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf tool_pmu: Make tool PMU events respect enable/disable
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, nigro.fra@gmail.com, 
	peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:43=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, May 18, 2026 at 06:41:05PM -0700, Ian Rogers wrote:
> > Tool PMU events (duration_time, user_time, system_time) currently
> > count from when the event is opened to when it is read. This causes
> > issues with features like the delay option (-D) or control fd, where
> > events are opened but should not start counting immediately.
> >
> > Make these events behave more like regular counters by implementing
> > proper enable and disable support. Add accumulated_time to struct
> > evsel to track time while enabled, and implement enable/disable CPU
> > callbacks to start/stop counting.
> >
> > Also generalize userspace PMU mixed group handling. Userspace synthetic
> > PMUs (type > PERF_PMU_TYPE_PE_END) do not have kernel implementations a=
nd
> > cannot be grouped in the kernel (opened with group_fd =3D -1), and are
> > skipped by kernel enable/disable calls. Iterate over group members in
> > userspace and manually enable/disable any members if the leader or the
> > member is a non-perf-event open PMU, and synchronize their disabled fla=
gs.
>
> Can we divide the commit into smaller pieces?  I think we can have
>
>  * preparation for accumulated_time
>  * implement enable/disable for tool PMU
>  * wire them to evsel__{enable,disable}[_cpu]
>  * support group members properly
>
> What do you think?

That sounds needlessly painful, involving many irrelevant intermediate
states with dead functions and variables. Most of the patch is
confined to tool_pmu, we could make the evsel patch smaller by
removing comments. The changes in evsel are pretty minimal and the
patch is largely confined to tool_pmu.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
> > Reported-by: Francesco Nigro <nigro.fra@gmail.com>
> > Closes: https://lore.kernel.org/linux-perf-users/20260517093650.2540920=
-1-nigro.fra@gmail.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Assisted-by: Antigravity:gemini-3-flash
> > ---
> >  tools/perf/util/evlist.c   |  10 +-
> >  tools/perf/util/evsel.c    | 197 ++++++++++++++++++++++-------
> >  tools/perf/util/evsel.h    |  15 ++-
> >  tools/perf/util/tool_pmu.c | 250 +++++++++++++++++++++++++++++--------
> >  tools/perf/util/tool_pmu.h |   4 +
> >  5 files changed, 377 insertions(+), 99 deletions(-)
