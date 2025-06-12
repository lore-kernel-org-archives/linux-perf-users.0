Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02D1E5B7A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757542; cv=none; b=X2k+hwTm+41j9FyFhLepqr5YNveQugb6yUbJDAS30qnRAR5flg/fz75aC1jfDtKFTzjjCUfW9w7BciMUOJCGeQBoKZjqVjNTB2ayC76AKhXY9reMDxKVOWVU67vzUeweP+mJvW1BOWLHjh+hcldm5WOlvXAn7h9hmEV/hbZcbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757542; c=relaxed/simple;
	bh=wAHT/AcGoo7CgSVNGycSSTiAzwBxGuFr8k/W7cFpxZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5tOMiDC/fSmGvvuJh0mql6WC1Qgw2RYUnsqBo1G5Y46zXmY6GErcNxwcbcr+uuRAASDsxEWKW9k/RLGyTM5HMOa0fctvOjcRUpuotUjdqZnBK3ETx5eTQs3Ua/bmg2rkubuV8y+rknpp88JJvM9p41ClJfOhz3KgQlYvPFjy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pf5wsos; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pf5wsos"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e7b397cc2aso361046137.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749757540; x=1750362340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAHT/AcGoo7CgSVNGycSSTiAzwBxGuFr8k/W7cFpxZg=;
        b=0pf5wsosyBPl2BBljKQ8kpYHzFCpD1oRZTYKZm5VYl223v6wcYYolhN4VWv9lM5feT
         nbspVy39p0SZB7/yk+M2QLNK+1YaXXprrxo2bobOY/GVd9utaPv9D4RaEt6k72VwpzJi
         3atJzkf8XnD0pG9A+g/sHT84ZKMIS9qWxDIQ4AAo8kctBmuzmBQqK18GrwsV6EUUSk1J
         hjedVcvHmZtVEI8a9O6cV/aH2rcQYQ82CFL8w0ExEDYUHjgWL1I36ARy50Rs2PDJoKVs
         xiAsOi5IcRDmZTM5vgrNIBCbks+s6bEGJC+26kA6VZihxRR7GI9flQR7jMcsFnw11+4c
         sI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757540; x=1750362340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAHT/AcGoo7CgSVNGycSSTiAzwBxGuFr8k/W7cFpxZg=;
        b=VmtQ6I+y+/S5Oi3UjzwyLXqN79yVtQ2D/QDNhddB6trLBAMpcAD6YnekOYGTsySTCg
         SAmCdXw8LWynMQWslK4yNGEy3spQ5QaiczQK52+ncFtU63q5xGFvS2kw9QkIWt+V39WE
         JRXDj7KQ5wPm60htlRgm9i5u1kSyV5bNaRBfJxKyOZiyc0poq/XOUQU6nwrRtSEayKYG
         v6zGjy5FsFXlRoZb3McRyHdObygdR87MFJBC+3M8Cso5p4ekV6si9fuw4jVyVkyCa2nD
         YtZUHpb+8/sQXbDWUQGVHJq7pNp+vC3nV/rZnaH0bbAf42GYOvW43dOP/i4cIjsjDw6y
         rmqw==
X-Forwarded-Encrypted: i=1; AJvYcCXagtMoE0BXkDfr5DRFgSGTNvf7qv721C2d2Js4gTbuDGCz3TAFaGEbfQBNBlcU7MR0x18XObNaWU+RTO0kvSjZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKMoxv5H+bMt8L0RncBBegd5SWIQxdPe3aZzInmAOggYIncjs
	efVbwndfDnoXT0NpyAAhLrQ40CA+9e7B5PeVMBilb7EDshd8Pi4hoLS+5H5Veg09VqVymhMoik1
	XKOQP7BCrhscAs4aBqRAjHrabrr228J8KmR0S808H
X-Gm-Gg: ASbGncvKNVk2WRv/utoej0WwkQGMpB+tFBThRb5HvtEVKgGcY0ulXkU9kn/qaOL+sVm
	2if6Hvd6xLBPWcPnDX+bSEfOg4M/YAfG8Gs2weJQnAMFNXzOeKTBOcLirHMzKMfwC2jjGbUtR/s
	Mns2mB3f+tsFHm4xorOesH9RKxj08F9Ihmf4QpALUkwe3SuwI8MTYq0j7Uyq/+IqRPN+Tr01QVi
	g==
X-Google-Smtp-Source: AGHT+IEHRxuSJmDekfPevaGg0P88Kg+HTSpjX9dFsg+2vHWBTNzZj+7ncBqz8KjOFQMFJc5ImCgn4Jea+W2cpnvby9I=
X-Received: by 2002:a05:6102:2d03:b0:4e2:bacd:9f02 with SMTP id
 ada2fe7eead31-4e7e39d7d05mr164846137.16.1749757539524; Thu, 12 Jun 2025
 12:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
 <aEnLBgCTuuZjeakP@google.com> <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
 <CAP-5=fW1FhaDcG54OS=_65gxmehjDTR+1XqCPWMX-aw9reJHdA@mail.gmail.com>
In-Reply-To: <CAP-5=fW1FhaDcG54OS=_65gxmehjDTR+1XqCPWMX-aw9reJHdA@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Thu, 12 Jun 2025 12:45:28 -0700
X-Gm-Features: AX0GCFuJaWBm0sxoTLHcXuh_yk_mpToTV13cQIpxmu5iRZXykkCsMy-NMMDTMLg
Message-ID: <CAP_z_Ch+d1FA5Yp65aegn7-vcLhZY8rspSXbDsxCA7yTLufNew@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:19=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> Fwiw, binutils is GPLv3 and license incompatible with perf which is
> largely GPLv2. This patch series deletes the code in perf using it and
> migrates the BPF disassembly to using capstone or libLLVM:
> https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/
> The series isn't merged into upstream Linux but is in:
> https://github.com/googleprodkernel/linux-perf

Good to know. I'd be a bit concerned about the validity of testing my
changes with a 19-patch unmerged changeset, so I don't think I'm going
to try that for now.

Perhaps I'll just send along v4 of my changes, which has the fixes and
testing mentioned upthread.

Blake
