Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B733993
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612927; cv=none; b=m0cNMeTdmNGfL6cMQGbvBHba15D05fQDp26wdXDVirxFr6BtC/RBLd76FtlqLTwBNYOADNKHt/RWwKZ57apNcrQIhcBnupjwEFiJwalbXA12Q0hE6wsIXALMYluE5N6Nt4lw94YIHzAAhuYER03RxdZZ5dH4JBLDrD1h6Ur3i4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612927; c=relaxed/simple;
	bh=ulrdwPEfmjUk8IT8rXc1Llbn11efOcN2yH0jBBhPp3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuwFpjrLY6SGpIG4KSaYTCRoTtdvnr/KvCyAt323f/lPDXjgUJ62vp4VlxZ9RqkboOISo+kYIIhcriVvrKbjtMmNtDqu5t1brmeh9pj2O4vfOnlS/iDV+lsWmGsHp7pBGZ0EtbfQ+vooVAg7825XeK44SkrvQG/zCe1uO9s6Bj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYvGSHae; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYvGSHae"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242ac37caeso178845ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743612925; x=1744217725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1+p+u7oJ2fOG6rupJyrqrL/J3r7aOOvHki3BBz9/Y4=;
        b=SYvGSHaexKJ9udT1dfaiiML5+yF5J/wlcE1Gy1wLZ+Q6Sz6tc88yKJYOTXXI5dXhd6
         x5T+T2IlNiaAsXCsV/ZoTnWIOfSgqDR8dFA1nM2bd0mk24x0B09gSGzrHtYDMoQaNBPp
         ZRKTULvv59Ud2b/ecsLh5yvuHO8FtXIZnuw0AHIXeoB22VNmje7K05qpJcQgZDwl033r
         /63YLyWVyS3GibvbEdI213zS8XYCw+6ztVPxPH1v4iI1QUUf52/XnQ0lSIaqLkmPM/OT
         QKRNx/7iR0+wBfM14ZqovkBknHAN7rSwonKop+tojhGBmPyjgQV+BL3RrQ1qAKX7n+jO
         8h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612925; x=1744217725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1+p+u7oJ2fOG6rupJyrqrL/J3r7aOOvHki3BBz9/Y4=;
        b=tllZaand4rdDOBcdetzJFv/khf8eHJPB4NxTa8DLS/2zZjnkHVd3uDNvvws+tFsWJN
         FgF8Ayzr8d39S26PUY9gjBA4YZh4Zq4O9Eh8TrNd5LmMzMp+l1cHrqRF9XnMBxjlZhr/
         LHoGUoqMCTdWWge7QsDnTpBCVcJIbF0MHnv43wTvv1BOIiaYDTsIPrq/gYM301G3QheH
         nxiM5dfvcItudNdi6Mj3qKcz2VDa3c6yqLeMRRSHkZJ1I4x/wHCFCn6/hnyTmIWc1ngq
         NMIReW2bo1ldaS1X6NLzo3E6o6TNc0GBKA6FA4EWpv+m5CoFBsD93BGPDSQlk5Unq5mR
         dEsA==
X-Forwarded-Encrypted: i=1; AJvYcCUWuP1H0uQElVDcrklAcDcRs7PSErJJOTK7/Ca3vtcmg7ldeBF3B4zk21nfs03Q7gOVWC6nzXT/i3uPFZhF3Cxt@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRFQkKxtWTVk5F+2Ldzv2ZkMl1Dd4AEytg/pyt9BiMaBIlrLp
	GBu2XNUqW0YJeg/7pdmuySm6MMTzcZRi0+3XClE9pF5+4iNS/smwZWuP3XHofwsYvkXvDV55enV
	EudkF5lf8VXhR+682r0j8Moznx4rnmi8tV+vZ
X-Gm-Gg: ASbGncu2mTzgvgExjk0NnJfLYSWdhLMCEP+oXM3/Zqd10Zqmni0Xymleb5Ab2uc+C93
	e549X3tS5233KaAhcHtnxLbEIEe90OEztgvr2Nt6bWXkyqjgyjrz98XQJydTmpwA4uxbpc9N79P
	Yvcs0s7Z17uuFAr9owDg/vwVRnl4/wIYCQYW+MeJ0UmCDwNRx0qIuI2g==
X-Google-Smtp-Source: AGHT+IFxeDB0yIrClam9o1iXY8gJunDBb+Z/vkv/PhtQ8HyON4Llg9ykIV90m3xXDAPGCFc76xoWv1HznNT8aLnAlQ4=
X-Received: by 2002:a17:903:3dc8:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-2296bdaebffmr2098315ad.19.1743612924583; Wed, 02 Apr 2025
 09:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402082106.103318-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20250402082106.103318-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Apr 2025 09:55:13 -0700
X-Gm-Features: AQ5f1Jrf4VkU9NzoUMTfo2fkSLhuzPQGMbEaKh67unWrJZb2x80Qvws2gcP6TGc
Message-ID: <CAP-5=fU3Tam3PXd94ibVQZU=Kk4Q_=z0i9o7kx-Vgm9qwK-mHA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix incorrect --user-regs comments
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 8:58=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.co=
m> wrote:
>
> The comment of "--user-regs" option is not correct, fix it.
>
> "on interrupt," -> "on user space,"

nit: I think "in user space" is more grammatical.

> Fixes: 84c417422798 ("perf record: Support direct --user-regs arguments")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba20bf7c011d..f21b133691d7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3480,7 +3480,7 @@ static struct option __record_options[] =3D {
>                     "sample selected machine registers on interrupt,"
>                     " use '-I?' to list register names", parse_intr_regs)=
,
>         OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs=
, NULL, "any register",
> -                   "sample selected machine registers on interrupt,"
> +                   "sample selected machine registers on user space,"

nit: "sample selected machine registers in user space"

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>                     " use '--user-regs=3D?' to list register names", pars=
e_user_regs),
>         OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
>                     "Record running/enabled time of read (:S) events"),
>
> base-commit: 35d13f841a3d8159ef20d5e32a9ed3faa27875bc
> --
> 2.40.1
>
