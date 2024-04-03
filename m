Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C2155A29
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Apr 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175847; cv=none; b=WmJOE1A5vxPA7ohU1IefZ9FmKLGoCGXbvwJgPmsJCEPrXDJisUVbJpbCwj6zRrcqK0+imr9tVPpLoChH1MaosfcWDnWlsV11ftsj8R5xCKonGSttcfwb6cgKH7h65MegOSWXEmOT+Kr6nejcnMCsgrqai13zqUiHS11KPwKXJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175847; c=relaxed/simple;
	bh=EKlQoR2IwAcNBhIZaP0pvhBaPu27ciSZd+tBUsZpkgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loKPdFisIRJczQ+xt48pSn671VpyZDz1UtVSJIaDS41B5gyORzGipxyl1qD2z7Ni/CVbP8a9v3L1TOl2q9ZjGN5+szMc50S33387zsT9y6p+SU5yuaD7KA90+Dxaw58LpI9mH1HANICrgwS2wTcMbv6PX6kWp6infYJjKNSqE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9n3T+Jw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9n3T+Jw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e277154d4cso10675ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Apr 2024 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712175845; x=1712780645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKlQoR2IwAcNBhIZaP0pvhBaPu27ciSZd+tBUsZpkgU=;
        b=W9n3T+JwHYw8by+O13xUUQf3XoAo9/+pu3NuIpyQyS6Ar+0iSr047lRELjtnm3cOCM
         /eU/F6qdRAc8Q3OiIaL06C5pvGg+XnfKXycCT4WHg88W+SQM3uRB29CQNdk5qP6Vy2OL
         4QOY0phQEkKKzCdUKh2WtZVmoySDOyixzdOcRwthxPSGcQWOIHknT7QuGwgYwIgrs0kb
         djJ+O3SDwH38lJTMs16zEdGHUwthf5Y2CJbEkQYHJ/bBpZH7bh15phcrPultLz7I7wwk
         GV2oxjqy6A11t+CCE2QCkCRN6F4/Zo+FsuR+bgfmj13pjGbzpgC/UfxoEqRzqd22hLJn
         kFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712175845; x=1712780645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKlQoR2IwAcNBhIZaP0pvhBaPu27ciSZd+tBUsZpkgU=;
        b=mw8wl9qOYl6cFZXqjUqRVexnRVWc+JJ2JmvS5OJHlzqcze00hp/+Nc/yWaYzAcpRqH
         JcX7uY82QRIiI/zmi5MmYZwTS4unDhQj/3CiYKG/DFvHkfMJXJFpctv5dWeNnLCUO6i7
         Z+q4CXMXt41OtkIc/6fJYGxcwkZa0lesSExGhwdOwjNlYFdvqCNG4zKez0yAYWXNQrRB
         73j+wqRoAM1R69Kblu9Wf6lTvVBjMe3wXJQtIvdWXJ6dgTMQVA3l5LQsNN4ZKDYdBe1E
         lMagMkG4T4QrvEVe1zOqBRRy4WFJEh82WwU+HtZykGIAGJgpY9akRSDYIBRtg1GNDEA9
         CP8A==
X-Forwarded-Encrypted: i=1; AJvYcCUJmLZdiVQrXeNqZ2PIcqOawwGv2iqDV1Z9zY/Xe2YYahZRl698l9/MpDsJudX9PT2iBavPIGR62y55q5VEtZGuh2onQsupPuXup+6VgQkXdA==
X-Gm-Message-State: AOJu0YxiNCuUht3+zQqMSTKMciz7KEan0b7K9I0g1o349nScxIXiqyOm
	H3apxaLI8OLzM6n3PvF+HNaRTQxMI0zKS2VwkRTnTxpc8W4PHppui/xHlEtVHUZFCKQcZsa2HPA
	asWXZ2Fb+YbyJ3db0kXIdlbr1g0WDFK1k4gWu
X-Google-Smtp-Source: AGHT+IGaQ1rrzpJ2yRKs3uqUHY1o4iZdBddjpY4n6NwPtk4ppMDyXIl26yh4emb/jApyta9gcqzTCpVEMrBseUTr15c=
X-Received: by 2002:a17:902:f551:b0:1e0:a977:d88 with SMTP id
 h17-20020a170902f55100b001e0a9770d88mr306363plf.13.1712175845279; Wed, 03 Apr
 2024 13:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403164636.3429091-1-irogers@google.com> <Zg2jdJ3-LNRkL95T@tassilo>
In-Reply-To: <Zg2jdJ3-LNRkL95T@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Apr 2024 13:23:51 -0700
Message-ID: <CAP-5=fU1ZC2dAr-U9kecXxxVAyyx3BtnQVOAax2PtvzEfAKjyg@mail.gmail.com>
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:44=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Wed, Apr 03, 2024 at 09:46:36AM -0700, Ian Rogers wrote:
> > Rather than place metrics without a metric group in "No_group" place
> > them in a a metric group that is their name. Still allow such metrics
> > to be selected if "No_group" is passed, this change just impacts perf
> > list.
>
> But what's the point of it? It will just make perf list more verbose,
> but I don't see any advantage.

So it is possible to list all metrics, that's not changed here. The
thing I'm looking to change is that when a metric is standalone it
appears in "perf list metricgroups". The reason is that a metric group
can gather a bunch of related metrics, say some form of read, write
and total bandwidth, whereas something like an idle metric
("d_ratio(max(msr@tsc@ - msr@mperf@, 0), msr@tsc@)") that could get
placed in No_group is more useful if it appears in a metric group of
"idle". I'd put forward that nobody ever wants to run "idle" as part
of "No_group" whereas being able to see it as a thing in metricgroups
is useful. I want to be able to run "perf list metricgroups" and get
groups of 1 or more metrics that someone might want to pass to "perf
stat -M", currently this just shows when there is a group of more than
1 metric as there is no practice of putting a metric like "idle" into
a metric group called "idle". We could update all metrics to make it
so that when they don't have a metric group we add them to one with
their name. We could do this in jevents.py. Those changes would make
the No_group logic redundant, so we should remove it. Just updating
the No_group logic in the perf command seemed like the minimal
approach.

Thanks,
Ian

> -Andi
