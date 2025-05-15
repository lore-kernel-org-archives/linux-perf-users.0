Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0351171C9
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747348556; cv=none; b=OjLIP5NWmQMcb06tTzmrFSwdQpKhfKhgz4OVuEYbigVG93+sxKvITsdm8ZI7zv2TPR4yeM58EmVm1onjd6bN5wCFfmpRWD3JvWACudRuZiY7v1AYJFKkTqqSk0kG+37MDqvNlunMtI3SmL/SUtmeyJA0Mz0MB76t9oxH8MHahyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747348556; c=relaxed/simple;
	bh=yhSVuxDAeN6/JexVyGTwdgu/3rvrClhhHDwV7NvryjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PofoeZQrV9GJw8/pCXVlHblTI4LOGMyk+hdtzZt+QVfTPtqrm+cQSXnOrg+w09b9c/lufbHYtorTR6TF0KMpK+4o/B0U0CBPWhwHkdemb31KgAJ6i87fW8VLVf8yDb6zMy6mhOjF8xRHFqvSkatOxQUpuq6qyS6HUTdg2dpsgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBOULKvs; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBOULKvs"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d96836c1c2so69275ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 15:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747348554; x=1747953354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBwbRvTZaf1mj20nujKN59HMwobtiT5fyAFRk1Y3Iu0=;
        b=QBOULKvsWPtj48iU8xpO3fDLRIV/PVCMAS54WlTZguVPPxZlHgSCO5eE3yFyfwR7uV
         FVz5S+nxksL1nmeGWb4FbTPu8Mk8s3Ylb+DI8iUuFKZeffvDlq2KAuoqjZZ/J9AZJh7Y
         3/0/qJSysU1sboDjKQL2FV7U7dt2+lehKO1trl4JVRiXcVorMjlJkZ9TMtpLyeeZmi5K
         004lxQCCnt05xzmi751Wkdj0vt4FLDOeTMuP7oGnH9ZRQXc0yfswEnz4Ny4e8rzcvxcP
         IsgLVvlyvUS62wR4P3eszTPKPd8PeRcsewbcoF4VwpEDTFBLEbXrzgElSfgQyB1kv3KJ
         egTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747348554; x=1747953354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBwbRvTZaf1mj20nujKN59HMwobtiT5fyAFRk1Y3Iu0=;
        b=j8vaXNrGV5Vyy965wMeFhm1rsvBUng6/FLTNEY2QRG5lco0T9/uNrEC+HhjfI2b4b/
         dHRO6Jo1XRAPVDky4edGfJVE2Piv1YSSjnO0tyuMN3z3GhN5ChHI71hTkpsepdr3P1jz
         nFm2UzfR3oaapFCRq3Fp3RPQ16fmdyf99+8vB85DHoYbZ9OFPlNqEh/d5Ijtld4TOHIa
         OM8CqAJ7KqQem6JpByX211/nRHClXLvEIl7/thhGbIHvo9lkJhDBV8WZrrCMjVvjEURF
         sHT7FGcmnATBGOoCFdaPtVVSBenPkDyXyd79t0bHGaOlKKu6UNZTNcfgOBVSf0KFdLGb
         lwXg==
X-Forwarded-Encrypted: i=1; AJvYcCWIrZ0A3kfB6izThlCNjaJoIUxS8v8u+3Y+lwE41/16TtSURpcBRey5+Egy9SrrSU+CqXD+xKRDbolJNX9XQb0D@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyln7Dw1dxDfi+HuptqXajZ91xVEFLYe/rOjScvyaMlsKBCH8E
	/yGHk/zPJpDSvlhe27QBTdbFxBXteV+fPAKP9acPIDh16uxoNhfsxJl5z4lccoITR2u86zIxtpl
	KfY4dcNo9FtPAmh/UNn5alWctYqiahlBqN4xfKJLJ
X-Gm-Gg: ASbGncsmDGFUu+ipIKkChcdyMpK5URVpd0okIy/p3yIB+T/9sz6I+UblKWhy/7xBUzY
	QmMr3eDSERWj2pT7rVVbxWkkM3A/8GCdCj5qAS15peLs8+HLYomZ0RRjKSN9CCn9WQFUkIDsUhi
	Mpb22ahDQQyjmfeVKIdPPpeWTiMO2UskiB5NZRjyPeKcnPK5DdZvwNAVH/P/o4hQ==
X-Google-Smtp-Source: AGHT+IFXVN6djINl8YP62wn5MPMzvUo+Dxjr7AAyx4YxZcB/3yjDq0GkJHqwF1gWj6Y5la0VPjyrI6xlejgjgoTds5c=
X-Received: by 2002:a05:6e02:2582:b0:3da:7cc0:77de with SMTP id
 e9e14a558f8ab-3db7800af7cmr6704905ab.8.1747348552908; Thu, 15 May 2025
 15:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515181417.491401-1-irogers@google.com> <96c8fae8-b8f9-4094-b03a-9dba3ca234c2@linux.intel.com>
In-Reply-To: <96c8fae8-b8f9-4094-b03a-9dba3ca234c2@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 May 2025 15:35:41 -0700
X-Gm-Features: AX0GCFuiE3r5RQOp0iXTL7uOycTf1581WMksuSxRhpH_o7_xLst5DQolbvw-bA0
Message-ID: <CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com>
Subject: Re: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
To: "Liang, Kan" <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 2:01=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> On 2025-05-15 2:14 p.m., Ian Rogers wrote:
> > On graniterapids the cache home agent (CHA) and memory controller
> > (IMC) PMUs all have their cpumask set to per-socket information. In
> > order for per NUMA node aggregation to work correctly the PMUs cpumask
> > needs to be set to CPUs for the relevant sub-NUMA grouping.
> >
> > For example, on a 2 socket graniterapids machine with sub NUMA
> > clustering of 3, for uncore_cha and uncore_imc PMUs the cpumask is
> > "0,120" leading to aggregation only on NUMA nodes 0 and 3:
> > ```
> > $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a slee=
p 1
> >
> >  Performance counter stats for 'system wide':
> >
> > N0        1    277,835,681,344      UNC_CHA_CLOCKTICKS
> > N0        1     19,242,894,228      UNC_M_CLOCKTICKS
> > N3        1    277,803,448,124      UNC_CHA_CLOCKTICKS
> > N3        1     19,240,741,498      UNC_M_CLOCKTICKS
> >
> >        1.002113847 seconds time elapsed
> > ```
> >
> > By updating the PMUs cpumasks to "0,120", "40,160" and "80,200" then
> > the correctly 6 NUMA node aggregations are achieved:
> > ```
> > $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a slee=
p 1
> >
> >  Performance counter stats for 'system wide':
> >
> > N0        1     92,748,667,796      UNC_CHA_CLOCKTICKS
> > N0        0      6,424,021,142      UNC_M_CLOCKTICKS
> > N1        0     92,753,504,424      UNC_CHA_CLOCKTICKS
> > N1        1      6,424,308,338      UNC_M_CLOCKTICKS
> > N2        0     92,751,170,084      UNC_CHA_CLOCKTICKS
> > N2        0      6,424,227,402      UNC_M_CLOCKTICKS
> > N3        1     92,745,944,144      UNC_CHA_CLOCKTICKS
> > N3        0      6,423,752,086      UNC_M_CLOCKTICKS
> > N4        0     92,725,793,788      UNC_CHA_CLOCKTICKS
> > N4        1      6,422,393,266      UNC_M_CLOCKTICKS
> > N5        0     92,717,504,388      UNC_CHA_CLOCKTICKS
> > N5        0      6,421,842,618      UNC_M_CLOCKTICKS
>
> Is the second coloum  the number of units?
> If so, it's wrong.
>
> On my GNR with SNC-2, I observed the similar issue.
>
> $ sudo ./perf stat -e 'UNC_M_CLOCKTICKS' --per-node -a sleep 1
>  Performance counter stats for 'system wide':
>
> N0        0      6,405,811,284      UNC_M_CLOCKTICKS
> N1        1      6,405,895,988      UNC_M_CLOCKTICKS
> N2        0      6,152,906,692      UNC_M_CLOCKTICKS
> N3        1      6,063,415,630      UNC_M_CLOCKTICKS
>
> It's supposed to be 4?

Agreed it is weird, but it is what has historically been displayed.
The number is the aggregation number:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/stat-display.c?h=3Dperf-tools-next#n307
which comes from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/stat-display.c?h=3Dperf-tools-next#n135
which comes from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/stat.c?h=3Dperf-tools-next#n435
However, I think it is missing updates from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/stat.c?h=3Dperf-tools-next#n526
but there is a comment there saying "don't increase aggr.nr for
aliases" and all the uncore events are aliases. I don't understand
what the aggregation number is supposed to be, it is commented as
"number of entries (CPUs) aggregated":
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/stat.h?h=3Dperf-tools-next#n26
it would seem to make sense in the CHA case with SNC3 and 42 evsels
per NUMA node that the value should be 42. Maybe Namhyung (who did the
evsel__merge_aggr_counters clean up) knows why it is this way but in
my eyes it just seems like something that has been broken for a long
time.

Thanks,
Ian
