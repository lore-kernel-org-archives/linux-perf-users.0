Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2542F25E6
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720374; cv=none; b=o5BtZyFwiurrwSfMubpN1F/fVIKQFv2xXaG9NUZsEOg3rwNWJjYJTlTNfvbK9mkBGQIPlWgXDPXCjGSDw0t9MkhozmRYfdjhYuX1hWo3Za16o5ibs6ftvhA4o2fpsCjfv5C52gRQSYJjJcqIwpEjx0U1boBFZhcQ17rzaO0h/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720374; c=relaxed/simple;
	bh=8Ci8yuuHIIxvuhpiDNi21ZF21b8HMT0846DfbovB3ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qo00TcQDNCmfWd+S8YfULjnDNeJfu0si3CsTFcvTPW3ImPVwUnVwx5p4qaULiz3HScZHNawGETZQaI6CN8qju5Ror0tALwS70CO6PFhu+ytYOvz+aeyzXvnd4YTP1zk0BQWLAZNaqFB6uJvYX7F3Da8kM+hiIjKI5XgrK91o5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVJH+qMw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVJH+qMw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so7395ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760720372; x=1761325172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ci8yuuHIIxvuhpiDNi21ZF21b8HMT0846DfbovB3ec=;
        b=NVJH+qMwfl03WPOnyYS40+0xTrB1C6/MsUZoHrznJ76KStmRo4Ei2eAFOC6KNwejsH
         X6XWnUeVlvsqHqQixRT2XccFAnjPEcP4MejupMkuK8XqRlH8hV5C02fGhfjUTRTNsoIP
         q/zae9GvFj+i/9i7aUJpOIPZJo67B/JCxj7dNve7Cibt03fKbQUwfbiLL4BppVYiklaz
         igMk3ChGnxFLj4ywgCF+N0apxWKVEE3m2sOpEDMEa93PyTR4waQU4HrAy+On5XXClE1r
         aK4X4f39JStBws2sE39Zb3PH1XLPf4PXaEB+UG/t5DW9Amya8ljcHkMIZKIwcjee+/be
         4ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720372; x=1761325172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ci8yuuHIIxvuhpiDNi21ZF21b8HMT0846DfbovB3ec=;
        b=tKxfdqP7Rxxdg11RGOSEoE0xZ/k9VPXoAqw6gxmyEyQvOxK31Z3NPFpvTgkB83GJ7N
         t+YdV5GacOcehXltiqma70TkXfUWq0+9eOSID+zX8OS4T1WHXAbqIK34YXXNOCl5bTEu
         oAehM5ST3dMaaswPrqJr3z13K8Qtnt2ssB4RNi2HdIpAmuLuMQ//8izjhr2OqyWjdG1c
         GfLKWHdSTaUrTbrmtD+z9udrIxTmBmq1pAJj1NxkjRHpeArbzvSdVlSsfv0KxS1oNSUe
         +ha8G0hHMu0/2QgCurP+bHFsFxdJbTibnEBvljNyIAEFIOIBjx+znb3c6mvmRrqtPKVR
         Biwg==
X-Forwarded-Encrypted: i=1; AJvYcCXNKsq/zg/YKlpGk/ExgwdEccBdaPv5RZ5Vlz7nffYrEV+ez0GddlivqgjNW0a29F0I6Ahty0LHTTWrYze4HQls@vger.kernel.org
X-Gm-Message-State: AOJu0YyhlgCbWIy/QTivyvy7oUEjTjZTBhOxgBPC0qGXClrHk3n+7z/B
	HNFcaiBRZ9Lxj2JsF0sifCVt/57AJArqYDe9YHYZ/IJOvRb2ZDEFDIZlXA+vohPmjHutjVmXiYe
	G867NBax8xc4xK71diZj5Dcy2rp6ADTVnSru6efpV
X-Gm-Gg: ASbGncvp9OcL7FnOp0tg8Igk/zCuKnPPWCr3OEzmOzk3K4KLJ4RGskFvJdXrvoWPXxg
	Y9p0LBY+FTaHN0KiuqOI1Kzr9SXxSC+eKvAbwxp5Zz07eoyezSlv2LvzF6GA5j+Wmx9765B4h2p
	vOSgEw9nrS5ojKUUuqJ2tyaZyIlfEftZYx/ZzNC50IRMDYsGVPI4vgX84s13H7AnigFXAEsETfH
	oVAGRFAWzgl1/D9fKqWOL9oRWg54bUnCOMTC9apbW5sinBkpqqZKjLA6op7
X-Google-Smtp-Source: AGHT+IHT9GHP3NDyXisLOGrRAg0pd0hnfx7c5ihQP7tcFT9uPoT+264mPqqPBBPE6PtZuA5bXZA0JefaZcFAajbv7EA=
X-Received: by 2002:a17:902:e88b:b0:270:bd33:f8d0 with SMTP id
 d9443c01a7336-29087a6f8demr19017785ad.14.1760720371784; Fri, 17 Oct 2025
 09:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825211204.2784695-1-irogers@google.com> <20250825211204.2784695-4-irogers@google.com>
 <18f20d38-070c-4e17-bc90-cf7102e1e53d@linux.intel.com>
In-Reply-To: <18f20d38-070c-4e17-bc90-cf7102e1e53d@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 17 Oct 2025 09:59:20 -0700
X-Gm-Features: AS18NWDqe896mlksjatj2u7oKmSK9x4F3VsHdOBQKUfd686j9G2rPAm8LErB1wM
Message-ID: <CAP-5=fUvppttK3t7GHsWyan08bZJRkv4-M_P2vJpe50bOuiCYA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] perf parse-events: Add 'X' modifier to exclude an
 event from being regrouped
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 12:25=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
> Hi Ian,
>
> It looks the "X" modifier only works for the cases without explicit group=
,
> like this.
>
> sudo ./perf record -e cpu/mem-stores/ppu,cpu/slots/uX -- sleep 1
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.019 MB perf.data (7 samples) ]
>
> Once there is an explicit group, the "X" modifier would not work and the
> regroup still happens, e.g.,
>
> sudo ./perf record -e '{cpu/mem-stores/ppu,cpu/slots/uX}' -- sleep 1
> WARNING: events were regrouped to match PMUs
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.019 MB perf.data (7 samples) ]
>
> I suppose we should enhance the "X" modifier and make it work in 2nd case
> as well. How's your idea?

Hi Dapeng,

hopefully fixed in:
https://lore.kernel.org/lkml/20251017165753.206608-1-irogers@google.com/

PTAL. Thanks,
Ian




> Thanks,
>
> Dapeng Mi
>
> > ference|ops|access|misses|miss)
