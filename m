Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C53253F20
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328578; cv=none; b=kVjNrPI/03h5xiahY6/kS5uDsxxwOyvb+gVHs03KDgDJfolbIX3I9qjkVLIbPNFx/3CJMUz6kboelUbfhOpzDi8tbDa2Xv1rok7BNHZKZDBVFKHnqsK9n1NI8+FNI4L6EkLV+5DEwkh5HVx7G2RCgjB9hp+NOaPavvwiS1Rb080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328578; c=relaxed/simple;
	bh=OGYwNu0jk1S3G/lLoWUkF5yx6pm23cVo7q8IIitvTz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDm/AjUWXM6y/gkyFSPbh9sBiUnzWG+XXDdOOuW5t2W7OCDcsVEhS2kf0DMv0kJFOFq+NU+NyPUl7CyYWxIyU3Ftg2SWAKB5E4jMxiHwCKzFCKVLjrKrRtrCP5IOK7rQM1464ZDe3Hsg4K/C5KdwC3zIsKIZKWE3VjvK5XiLABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnSuNQXx; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnSuNQXx"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3da73d35c11so4385ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747328576; x=1747933376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGYwNu0jk1S3G/lLoWUkF5yx6pm23cVo7q8IIitvTz0=;
        b=GnSuNQXxenm/7ClQAXtLqQedGykC32k3AnsWJF7jHVmX9+p2MRlb5fjSST+7eCUus9
         oDKDxXZzuPvbDN7EbvZTxnD9neGm9kUpf+UDAobRQuNeSnql7YRzj5QzkisYZrPy3GcZ
         Ol0z5s/473q+NICw8DRXlBqoP5FzGXvqViedLJm29vOsvU53aFdEiPuOEGKKGDAz7eob
         ShDRIX5ienyurE5EJxcQ5n6yBuPZFilLLSMbeUIbJbYvRWIRglHpBZSRMvlooG4dEUqP
         0ttZrZyV9YRJYdQZxIDZNZdGNTW46Sri1thr6gjPm+/Q1cxThmoCy9VY/e8o7I6bpBm5
         E0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747328576; x=1747933376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGYwNu0jk1S3G/lLoWUkF5yx6pm23cVo7q8IIitvTz0=;
        b=JUqwqwihALUbcgAvT0UkbFRFIR3A04f2HqWePUW6AcPysLZ992/KsKPI8V/rfojdOC
         LZXKv9WA1nCoMaGmu+DiUrBYiCMZKCIyEg8XgdLATNgOPxxVKylhhwxeRLT/5hDmDVF2
         Vwk7fz7pRlaMw5yXDs00MmsrkCOiFT3qVrDwIkgvOkV3XxhiwsNd3lgntcMLBI61rcFH
         Ut6jjkCAhy8WbQAS0OKOCBRtLJ2FXwrCmKJF0jm/K+JLlmC2tO2yuRm9Gq4JjXufyzyX
         t/fKYks6ORtnE2EirEaZdynyyYb0LTcl2NncU34Lnatquh9ukESbzOJxmgsONR5qeV7u
         aQdw==
X-Forwarded-Encrypted: i=1; AJvYcCXolkxO4qX/Zbn/VlPfgW6NTcfemiv+FXnRoLnu0fKxm0J2+SCfU+nVG14AM0qHKaoHWteBGNrfpqGoWJgqccu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rOVjxIQk6rPTwgTdG1iccQQ5oJldFjISV+jar2ON8GzWmaDv
	SVzHEXA5PY37O6phkFqOnAMjCigBCioNm0+yMs0Sxe4Gud1J9tKBIpVRPh4VyXypyFB6bNUzuQI
	pWNgT0wUsS4Vbq7cGK/iR1ZhMS7k6sGFnphKbeJOM
X-Gm-Gg: ASbGncsmQW+uvp5yRWWTeY8V9vKljQPhuXEugyH81Ol+SCzosOmKMmyaTV7poDYgfPQ
	+hXUjPMxO4DNBaNiemgStchyTY6sl6JsuEuMYYogHETgCdt5Ujn/IsIBThn9ztgO7YsCytnM4Mj
	EqwuT9AsYceoCX80f1Z9YWMmYNecdQmn5TNxgvQ7VVKlCXsp1xpj18k2lGMjVurQ==
X-Google-Smtp-Source: AGHT+IHxdfz0mUPuqpeQZwKMnEADRuicx+FbV97LYx8B8R1KseloBXxlGIrVN11rnuFNQv8xvQuSRFZkI6fQAr02/JE=
X-Received: by 2002:a05:6e02:3f05:b0:3a7:cd21:493f with SMTP id
 e9e14a558f8ab-3db780720edmr5332565ab.26.1747328575703; Thu, 15 May 2025
 10:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515043818.236807-1-irogers@google.com> <aCYTG12gSmv0OtXN@x1> <aCYTaveeziFiF3kw@x1>
In-Reply-To: <aCYTaveeziFiF3kw@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 May 2025 10:02:44 -0700
X-Gm-Features: AX0GCFvL-RsYL31pl_fpwdtPF-hl9LiQ91_3-p-5OwxlTjO6Ww7GFCr4hdbUbWM
Message-ID: <CAP-5=fWBdCVSM_QLcLJ66g+LC0ykrJbZA6mQUsH_++xLormFzQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Weilin Wang <weilin.wang@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:16=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, May 15, 2025 at 01:15:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 14, 2025 at 09:38:18PM -0700, Ian Rogers wrote:
> > > On graniterapids the cache home agent (CHA) and memory controller
> > > (IMC) PMUs all have their cpumask set to per-socket information. In
> > > order for per NUMA node aggregation to work correctly the PMUs cpumas=
k
> > > needs to be set to CPUs for the relevant sub-NUMA grouping.
> >
> > I'm blindly applying it as I can't test these changes, and I think this
> > is bad.
>
> In the end the only review/action I could do was to turn:
>
> Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clust=
ers
>
> Into:
>
> Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumasks for sub-NUMA clus=
ters
>
> :-(
>
> Besides the build tests, etc.

It isn't the easiest to test. Let me add Weilin Wang on v3 as I think
she has a graniterapids and could hopefully provide a tested-by tag
:-)

Thanks,
Ian

> - Arnaldo
