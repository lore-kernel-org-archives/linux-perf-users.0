Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209F1A9B3D;
	Fri,  6 Jun 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749235257; cv=none; b=D+3ycytpaSwoWKYR5g9RwSXJr+fl/ijwAMUEdJbdYP5n10+rNx5KRNJ1UDpWhCVk6Zv/OVn2Jx/+yuvCoGKVSqUYy3ODYarOQJL7DuMOvFKKo3fAYPFEJgY6Lz5UIn2fEfT4wksUZg1CgpXtW3qNnnp/AMADM7/edi3glxdYRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749235257; c=relaxed/simple;
	bh=nd7Qy1kKKrpW7iUlYYWs5D47amWIruf/C+4oEJHy2tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=il86nYMhaaM9hUK/JAPCPqPYgfKHtefUi58liXsIyEdP9AzFKOkMwiI9Pjjj5UvrEEbz8CS+phSFXVnNGCkpFPWvybhplw8dlY8E4dtYoK7O07Z6lC6JlYNNWBO/pUs5B6zHxOBZIdc6Tkk9Mi94XP6efZCAPv7f5E3E9NlM9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFk9e5WV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFk9e5WV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a510432236so1889310f8f.0;
        Fri, 06 Jun 2025 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749235254; x=1749840054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd7Qy1kKKrpW7iUlYYWs5D47amWIruf/C+4oEJHy2tg=;
        b=EFk9e5WVVO84xElPcApefsTpOxjQm/LXGJl6nJsA4L+uW8c87eXqAhKG2/0m2AV+ZU
         M3NR1ZgJcD1zfBoqnXuKWgOHrOXr6VeTWvSeKAnzC7+RwjxkuEMoDs0PdaYIfy7afkgs
         EyoJMlOmFtqNxDIzy8ReCLSkYLsMw5vxCS3Bjoc5WCp8G7vWzyQHwJyyy9Me27VU72ew
         /Z0tcYXIUUpTMQcoOvCxjup8fA9Le6AeHzjZStWACK8qSqc3ZqoEP3mpF79BylSQmEM5
         /6xZN91e0wOgUZE9dSjDnyyFSK8xIiTbnQg/mACRxw1GQsr4KPH54WM+XDvqW9OFlG7V
         ge7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749235254; x=1749840054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nd7Qy1kKKrpW7iUlYYWs5D47amWIruf/C+4oEJHy2tg=;
        b=sw+AOS2fcwPPZStERa/uYa9+BDJzM0yosDflWNv0HRH+T5H2Vc2CwCOTtoI7YT1m70
         LTX5mNav7E3rYQ4Xd9Zqc8aKIOh3X2UOEZF+57zAvWdem5ye55QLsoCuX2Eq2nT82qz6
         0wevxTQZLU9PDIK726dLVMPg5nqlLV9tMXu2xjjvPmoRQ6z1uUbsP5zcvRYMRNV3nOsJ
         rX0/2zC9RuZ/+wBvJhhmRd+YHF6i2tu1ERDGzqLOUprXUXhTxSTlWaOu8HPvmg0NgQyA
         +OEa8wDhgThRoWwwzghLQf/WH3XGuSsnzJkFU9CHu9zxSb/U8TaBZ1g/nVnVfaT8KU/X
         Uvdw==
X-Forwarded-Encrypted: i=1; AJvYcCV9RGZOGv4K5dNtKQL97F9F79LhQu3gCIwWylHZWiHCKT/ls6L86JiT97CzpJw9zKe3SATBY4l+A+ALnSbfWahbTA==@vger.kernel.org, AJvYcCXiSyA8G/j4IrHugAd0xlAtduoA3JAKKd7PR4cUcwVdn+XaUO2ZJ6LrIaCtBVSa37gSEeRrWlW+9ZUcmd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLfsxGQf3mwIbdaeIKoXsSgHZyiwX7mlSfgygnbtabtQJKHpUi
	mwc8heeMOzYLpuipIPNWh7sLUAU1ggKhjfTWqrr7pfN2y1egK2W8AxW2y79ca+Uc++TcRYZSd5e
	v6KmFxygR3yW6aKohW++8TywnLbzsLas=
X-Gm-Gg: ASbGncsM1wi77EPtQuysVxlgVUCS/ykV5VPq0eHExOCGTcXlhuwnmxyCV6A8MGNF8i1
	6DRdiN0WuoxPTohWEEcl721jVicm604A8XqAwleM5OC9ag5UJ8rKnIWVuwnS1J/bIRG5LUeoo1J
	EcYBjlXNYs4mkzH4AiahnLzFSHiqO+OA2eTQTeaQsTlbqUHWVtcjzYoO892ULcPhLi4lezNpYp
X-Google-Smtp-Source: AGHT+IEQC9fQv4kactTxAWCEV5FEKsh8+pWuznPByHUXwGxhx2zG6vfYXUSSolmJqWbq7PYgzAf1pMhycgsUql7zMoY=
X-Received: by 2002:a05:6000:2c0f:b0:3a1:fcd6:1e6b with SMTP id
 ffacd0b85a97d-3a531cea596mr3919566f8f.57.1749235253903; Fri, 06 Jun 2025
 11:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
 <CAADnVQKjyzdNVR_+WCMzORPJAX00tD3HK0vaCz13ZprWaG72Tg@mail.gmail.com>
 <d5fcf34f-63fe-451b-89ad-621c38981709@linux.intel.com> <CAADnVQ+N5UaBwLjtLGHAe1PCjpRzxxcFL45gbb0eHMDZD5+X6A@mail.gmail.com>
 <3f8b0b58-3b48-470e-b8ff-a71a26370bc3@linux.intel.com> <CAADnVQKRJKsG08KkEriuBQop0LgDr+c9rkNE6MUh_n3rzZoXVQ@mail.gmail.com>
 <7638853b-bbc6-464d-8890-29ed92aa5cef@linux.intel.com> <CAADnVQLBv08fjWWVL+7w7TqoYN-EbGT-E=YsAcms+NEQ9zGUeQ@mail.gmail.com>
 <e671d9e9-7da5-4f04-8584-fd743fce1202@linux.intel.com> <CAADnVQ+BF5FjZgqgh08+uoZgkVqE-QG33kYKoMjErZDX5Lh-nw@mail.gmail.com>
 <62855572-5961-4548-a961-d05d14a3659f@linux.intel.com>
In-Reply-To: <62855572-5961-4548-a961-d05d14a3659f@linux.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Jun 2025 11:40:42 -0700
X-Gm-Features: AX0GCFtYIWSj9Zm31iledCXOdsdilNNRG7OvYgbHaQCOc03GFL-2U6jFc8NK87g
Message-ID: <CAADnVQ+Lx0HWEM8xdLC80wco3BTUPAD_2dQ-3oZFiECZMcw2aQ@mail.gmail.com>
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 11:38=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
> Right, but the soft lockup is a different issue. Even without the recent
> generic throttle logic change, it still can be triggered, right?
>
> How does the below sound?
> I will send a V4 with the small change I made yesterday. Please help to
> verify it and see if it fixes your original report (test_progs cases).
> If yes, let's merge it first, so it can unblock other people (ARM CI,
> IBM CI, Vince...).

sounds good. definitely address the regression asap,
since BPF CI is also blocked.

> Then I will go back and see what I can do for this long-standing issue
> in VM.
>
> Thanks,
> Kan
>
>
>
