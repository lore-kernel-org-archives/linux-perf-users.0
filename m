Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332521E091
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817660; cv=none; b=YMkhG3oT1Rtp4f9LktZ/BjORgSjMSdNMVCCEcQi910hr10RPsEavU51SzXBCaYophtUzGVJPawq9O3HnAiZ+JqIUN7y7Sa4+yipvkJnDwVTZQafx3SRytuOv1DwcG8h4Ll3CZmYLkepLAnZfQXBqLargdDKNAWMpf+O3RwdCycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817660; c=relaxed/simple;
	bh=tKo0aXmpGJcdBrGhcXY2lCyeZIUJ1PkodFtfhRjU2cM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ktRp7yd8Q7WtZ8X/66EwxSVC4UGIFRLRx7onwE68EuvIiiUuOUV9gSBFitUaDGgYfsiJtc7zSfb/moQc5HI1wp3rhiB7N47xUCWOkULKJMQdDvMk9uKithA7Dro79LUPFO61/4kK4qeU3JQgQmWkPRkvtQ4B0y/LcD8PPBMETkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFQfPLXQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFQfPLXQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46b7580f09eso8060785e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817657; x=1759422457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DOt8SCNPqNoEq/gynRl5Nvsh98Fum4P4iOo41lrBivY=;
        b=KFQfPLXQOkHcSHCqty60p6TJXD/pF9+w30Bcfzphwk8lnbEW4r37bXnr3Hh1KtyHCO
         SYYSF7iNMI4bjUTZW/c+94TkG5Mdy4ZW/dk/k2VzE8E3LFdhWjO7w4/QQadIvta5A3ld
         /fbRRS/HgocS6RWs4OQcdEv4XkjpafysV3FI9uzELkAx9KBV4P0LL6okpqF73MmfFLp/
         LHtKcm+sp1fmCXJVRTBzr24M2KLuwBHQyprbiqzVlhkC4WhvnbLrVxKjMA3SS+PavQH/
         Dz+ngpuJ+jpwSVzxuo1/om7qjbQZ3wX7smvKR0no7hssjiTSUrxMaFKR80Nw9OlsHS37
         kRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817657; x=1759422457;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOt8SCNPqNoEq/gynRl5Nvsh98Fum4P4iOo41lrBivY=;
        b=GQwSlKPCWW6xfRGLNqDEsH3C7LNxJ9I7piJYoQ+P8+OHb9hQxsH08JILcEgrGrL2EN
         JXBqgUxdUeTuI5ArdK7hriDXwTVIv77N0m7kl25s/Mnb+FyFli6OCbBvodTfAhgtKYGk
         dG8qbtG7TdzfoukxMwHS7VZTYa3YcBaVcLs5OAGxmFqUARaJ5zroF1kgXH0I8S4oTDAW
         dkxYFWM4QfBCZP27VBCGCeSWFsoNRfGkWzaZBqHdlMdDyrP2pYO5LtL2I6CtAykyJPSz
         PvaUh0qUIXlckXHTciKcdM/82Gmsdp6EKC/nPdqtvhUNCMCokTL6Hg3oNFCm5l8nC3nr
         hrYw==
X-Forwarded-Encrypted: i=1; AJvYcCVNCx8oRjcemnyh5PoE2IaJLYJut2XcnioYoIaP5sYFZ7gmC/GErMXdm3YiGsWoOhgWfv3gIClN0f4ecJmYtRDm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/RLm/izu02DwGuOqbpnwb33gFfw48jH6vykFNW0DDs9tuQtIK
	ptxdGhum5RXQ80CY8zMW7KJAHxE68SMG+CuFfkoF1Q1G8MSoOxUT1r2o
X-Gm-Gg: ASbGncvyFz8KPEJC9FIJahtskLpprDpM0wcp/Lb0PmJsjh4FXXN4rgt91YHgzfXpjjG
	7G7uCzKKgNpfnzaF0KfzOjZgrl65aIpm6htRzFRiaSYBZPdF48otti8tui2w1Oa1SQMb0G5lmGM
	4nxsA2IMxvnFJwbWeOWmmL6jnSzYnwKB47Kj5Fp8/nXrOGVHYUnW+C4lH47nd+RQkKR5KNEAC9O
	Q0z3mLOXQI5u9q6HremkDpnhHMjarUVscCxGi6xZFh++bU6ugtqClVf0udeifwbE80UlIfkVg5y
	rxl00JLzkqQs4sJQuh28D/XJaqqeJ2iNLQL93H71Au0znq4nmro9iJUw/ViTHLudxKoac45RwVw
	q0KJ+8ZFI703Ws+mfaJC1qs8X6sLiFPwi6ABnxqmToveNt+M=
X-Google-Smtp-Source: AGHT+IEFKHBHubn1cTGjy+ZH0sSlW55oT61o1prZ3rjWvLnj0iZRejAZ/4vk8KwWhanKzHuomILbiw==
X-Received: by 2002:a05:600c:8b58:b0:45d:e326:96fb with SMTP id 5b1f17b1804b1-46e32a17d2bmr48722145e9.30.1758817656742;
        Thu, 25 Sep 2025 09:27:36 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.255.128.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb2fcsm3932799f8f.22.2025.09.25.09.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 09:27:35 -0700 (PDT)
Date: Thu, 25 Sep 2025 18:27:27 +0200
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Athira Rajeev <atrajeev@linux.ibm.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, hbathini@linux.vnet.ibm.com,
 Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Tejas Manhas <Tejas.Manhas1@ibm.com>
Subject: Re: [PATCH V3 0/6] perf/tools: Add interface to expose vpa dtl
User-Agent: Thunderbird for Android
In-Reply-To: <6BB167B7-6479-44E7-9175-E67E500DB9E2@linux.ibm.com>
References: <20250916052536.93911-1-atrajeev@linux.ibm.com> <ac85151f-21e0-4a98-96e6-8153d0159915@intel.com> <6BB167B7-6479-44E7-9175-E67E500DB9E2@linux.ibm.com>
Message-ID: <7EE7DD5B-6550-436B-A799-2B1DF293121E@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 25, 2025 6:21:19 PM GMT+02:00, Athira Rajeev <atrajeev@linux=
=2Eibm=2Ecom> wrote:
>
>
>> On 17 Sep 2025, at 11:28=E2=80=AFAM, Adrian Hunter <adrian=2Ehunter@int=
el=2Ecom> wrote:
>>=20
>> On 16/09/2025 08:25, Athira Rajeev wrote:
>>> The pseries Shared Processor Logical Partition(SPLPAR) machines can
>>> retrieve a log of dispatch and preempt events from the hypervisor
>>> using data from Disptach Trace Log(DTL) buffer=2E With this informatio=
n,
>>> user can retrieve when and why each dispatch & preempt has occurred=2E
>>> The vpa-dtl PMU exposes the Virtual Processor Area(VPA) DTL counters
>>> via perf=2E
>>>=20
>>> - Patch 1 to 6 is perf tools side code changes to enable perf
>>>  report/script on perf=2Edata file
>>=20
>> For all patches 1 to 6:
>>=20
>> Reviewed-by: Adrian Hunter <adrian=2Ehunter@intel=2Ecom>
>
>Hi All,
>
>Looking for further comments if any on this patchset=2E
>The kernel side patches for this feature which was sent as separate serie=
s is pulled to powerpc tree by Maddy
>
>If the tools side changes looks good, can we have this merged to perf too=
ls tree ?


Sure, I'll look at it soon now that the kernel part is merged=2E

- Arnaldo
>
>Thanks
>Athira
>
>>=20
>

- Arnaldo 
