Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793D19B3EC
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748480326; cv=none; b=VQTCpdhU8ovGWulLw79NUOVp4oXgR4+gh8nxf4raIx/iwWakXZlf2aLDLgApRlZlo0gcZk7S1I7W+nz8OUm8wtVL+OOL5kK4rsgcAmPvfXyPDXKrFtuIVnkQsIAbDYBxWxrRGeWDQPtKphEq95IaIzr5cUd3Q7tW+zPEv+daLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748480326; c=relaxed/simple;
	bh=3LJcOgM16Q1j+9Th1SFZvDmY147GM4KkX2rAr1YfKhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKHu9H0ocet4LExlSML5qv1kgYFkXK2RAMVRzRiDo1ExSnX6n+aNv2XEFUv89Uelk6HMR7LuPmOpdFtiFYb1ruV0ZJWYVUm3A3MyVCJZtWtCBW8a+mOKDKo8+AyzS02kE6hApFc/fm9T+JIc+hIjuFm3LWNctV0BN58BW6xyr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8SAI7VF; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8SAI7VF"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e47c2a9cdcso244413137.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 17:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748480324; x=1749085124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LJcOgM16Q1j+9Th1SFZvDmY147GM4KkX2rAr1YfKhQ=;
        b=V8SAI7VFlPtkPbyc1dL1gjfXp12iNxY/O7nkWcdeSjTl/YcfVPiLQpk9HH1R1gB/lS
         Wkbf6qRz1mKeF9Ddi8zlrJYonyniXGkF72XVGahic1jKgOtMGVN+pOD6OpfxEJ3sssDE
         1x48JlAdlty5tUZm0WeBJvGiZAkxYVmxuY9ZrnUQRtbVfSU7rZbnqJQUcEYQ3toZA4Fl
         S711KAzkr+GfJTlcbDTzhAETuRin8N1BV53/sSrAHqR0WlmB9bpfcb2pQgByJ2MXQyik
         Xp1/07GlEGJ18BMp6lzx+Yn8RWSmmc2HUI8Eko/50s7M74snfEUrFegh+STKT869tRqh
         3DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748480324; x=1749085124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LJcOgM16Q1j+9Th1SFZvDmY147GM4KkX2rAr1YfKhQ=;
        b=MY9RBSfjhe4QH5ubKAn6223tjOP1URnUBmtG3VLd7ku0r5gM7K9YGEOq5aJHUmG+ZH
         voFTXOD2SdOwN5Ao5RtKGetovuDtKT21C4U3KeEyfDFkYs9L2YQkaKA9Xh6exFkpOaSb
         y7W/I/2pPewfPN4uZeHxFxr1UoDtNAbnSnq8K+W5K+qa9mR/x+Vhi+Gn/Z7lMRFPzJ0Y
         lgUisgNwbTT29XD4goBt47/r1NeNc55jnEsEyWdyBIkIbp6oAL910C+lpmRSo5190SL9
         DjryTnl5/1drO3FZlqm52P1hOFierVfQ/1VOj7DK2NpyCUATyiGKZIC4i4DTWWHVUkaV
         JFRw==
X-Forwarded-Encrypted: i=1; AJvYcCUfeMdjFXvYM1k+rjsZzICtf4zDqSS5MFNyznbIFu9ucShMeet+s5aHdgY+q+/U8Ws3LT+ZTfaPz1NTBGMh4ebw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33KU6pTjzjOu2H6oJQYsF51bCCjPZKMNoMr6KoW4AlRNJ232+
	YPfWq0bMVwudcU6MFA2zIFjnCqwWlbm2rdURNmuC5mFYpnwPWtR+ADVwW40WjsG8kNkF3AqK2yB
	wLIU0X8P/6iUSRslJM5ZLs2XGOyzbG5fA5bucyG4n
X-Gm-Gg: ASbGnctAxhlrrs+SGkNPkzIXbh2RG63oWqVUZq/p4mcmmZRr47O0ZhGx4tWbFIOn/I+
	ZZ5HcikU5PZdamJXHGk9SVZC4CwrlyzZnYv2VCMFZrxWdMJdaNyl/on3HXWO43t118z+h0Ptd2T
	7fYpRJZ0Fe7tInF25lcg0kse8SvyOlKnb5yZ5ml8nUpJs=
X-Google-Smtp-Source: AGHT+IGwx4Uty5er2IzIySgycdil2fOJygTTHKMBF3mM9M6iD5H+JXzX07+IWyvy/kC9EeuCYaOM6quQ4vt7XbW+weA=
X-Received: by 2002:a05:6102:2927:b0:4e5:a309:85da with SMTP id
 ada2fe7eead31-4e5a3098731mr3876448137.7.1748480323519; Wed, 28 May 2025
 17:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com> <aC9iF4_eASPkPxXd@x1> <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
In-Reply-To: <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 28 May 2025 17:58:32 -0700
X-Gm-Features: AX0GCFusfVzOe8iNeRt_7LeEPUEcrg67_QANaTma6IA3CsaAZ6gVZ8V4ecXjgtQ
Message-ID: <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, May 22, 2025 at 11:19=E2=80=AFAM Blake Jones <blakejones@google.com=
> wrote:
> On Thu, May 22, 2025 at 1:42=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > I'll test this but unsure if this part should go thru the perf tool
> > tree, perhaps should go, together with some test case, via the libbpf
> > tree?
>
> Thanks for taking a look at this. I'd appreciate your guidance here - I
> sent it here because the other two patches in my patch set depend on this
> one.

Do you think this can be merged through the perf tree, or should I separate
this patch and send it though the BPF tree first?
