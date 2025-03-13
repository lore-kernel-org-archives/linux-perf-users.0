Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A2268FFC
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881684; cv=none; b=FsCJNOkOvzIIc4iVoD1GS3XZ+Ba5rVfrDMCTTg29U5RrvHCo9/92wgDA3NRIvSY1C9q1px6BN0ZIGUT9f9we8dxEL/SGj+AgJj5wAl+qdi0KFWn7jtck3jhADI/qTzDgOOvgEZZ6ckiEcJfgiY9XsYgJC9edqwOAF/Ko9Zwr7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881684; c=relaxed/simple;
	bh=He1qoD1LyuJLmPXOu6Sug+RnIL2fCie3WCh5VYdyMDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPYiNtzGe1jeJ+U5v9kruc9XJnqLFfBXkXM0ljy/+MXCufSjzB+PSCdqewb4cux6Cu1e2Y7y/BlGpELoTUJbHVtZswiZ6fZJCLGH+Fc1l9Xu5WfByetQD5fvA/0qfuxzPHFfRxb5EYa4A7wr9B0qbQfHVyOjRG7Znqo13xEreG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pC+buNF7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pC+buNF7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2242ac37caeso147025ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741881681; x=1742486481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/yH+WMcOt8tNQM0srrtHpsC9U4iKncCQNGb3KLC61c=;
        b=pC+buNF7gxlYWFm65eBLZnvX1MzvsibmZJ3C4MAGCKzJprEhcH7Oc6FwPHU7beCLR6
         D6vuZBjPcFaO5+anoy+QAO/yxapJ0NCiAAKjWbGsiYGb1XCq7XAMW8uZmSwxZ0SNZ8Pr
         pV4SuoHdLJfKxAqmlwkVE5CzX8AOPyMRpqIz6HhjHQCWGgPKcnD6HOzsz/BI+++eADee
         j++lhFW1fOUqLuxWi5fRVyPXT+loDSBxixS4Yoismxu1oL/fQPsqnD6UV7VJAnfyqo6e
         0GQeJEsFzMXG/LaXa0Hsa7ObfNUOp6tJJjUByzTF+4utanHsjHrGdJ7Gu9ZiInVR7+tE
         w4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881681; x=1742486481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/yH+WMcOt8tNQM0srrtHpsC9U4iKncCQNGb3KLC61c=;
        b=e9sZ5Sz1NGQNLbiyDnu0WSSU8c+GaEK7ATdbg7HRMKnoYwksO2nZ+7boJl3Ov0+x3j
         aVmTQbycuD+RcPq7akRPh+qMYxpxyL18VxBlV+g1jlYtKGCf2cjFwx70QjQnccNlQ6ct
         EplHTmwn94uglD02kQgHdmab786EsYJ6KqZZ/Y8fN+ZjdfVbE3SvCzI45a3zp1rsDjBx
         +dFPXxIs3LnkI3sgQ85nbTXyTnEIp4e6gklkSZH7MBInJhF01NLm51BBzCtTrZNpJlhq
         aRCWlZ2hsUHkwi/rGzZ1O7/4OpmPNAPovCuQh3n9jbeHLANuFLwqw8immPuYvSLYGbkS
         MGFA==
X-Forwarded-Encrypted: i=1; AJvYcCXXGmgirhp+05YPsi2qGNePmc2VzWpFXgTJvSp7BqN4h6XYfW6hI1ZV0B3beGs2nJ6mR78aBkrrS7O50ubAA2K+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30Pt/GAPKC1Aj7cG6rmuwQt4STD/2VrO6sHB1FOWXrsnbX3W2
	iD2LOMgeZlKfhSWEN/2K9rqjPQdm0Uy75zcJwzfVzBpG/hxrcjlWJhUELkOrIQj8pe0/rbr+49+
	dx37bmE/teQwsnQM3cgePXV3rO32EBCYnNmna
X-Gm-Gg: ASbGnctIhjyDCcte7h+tdhJq/uDYwWsLuGBQdvQbtrPGGd5uaUlgbDXF/I3uqqlTD10
	PfaPuKHs2xMdxdGlJd9YO0gld99Sy9q2T/+TEt542lBdegQpYxrG4F7FQotlr0QvbSx902wIFd4
	ZxbZKW8QfwKMv5Hs3frf5oBPLcCe7wVumiXbXvChGb++QOBkv/mnsAVAA=
X-Google-Smtp-Source: AGHT+IEfR+iXZ7BebnhxB5okisX5ERNMertQsNLMEMPpFQikCdkWp3eUopoaUifcDnJZ/HTnk/fkfvYLDMyu7hcQBE8=
X-Received: by 2002:a17:903:19e8:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-225c5322e12mr2999115ad.10.1741881681251; Thu, 13 Mar 2025
 09:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313075126.547881-1-gautam@linux.ibm.com> <Z9LnuXCvK5P5KCiU@thinkpad2024>
In-Reply-To: <Z9LnuXCvK5P5KCiU@thinkpad2024>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Mar 2025 09:01:10 -0700
X-Gm-Features: AQ5f1JrxRsSvm9uzSroxX2RwhQ6wbjbDcA0dzrSUad0a-XkWOT__3vkZ8beC4io
Message-ID: <CAP-5=fWjca+SMBdsyPe8Ggsqrqz=ZzWqxDYhaF+pcYk0MJ12zA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce a C extension module to allow libperf
 usage from python
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:12=E2=80=AFAM John B. Wyatt IV <jwyatt@redhat.com=
> wrote:
>
> Hello Gautam
>
> On Thu, Mar 13, 2025 at 01:21:21PM +0530, Gautam Menghani wrote:
> > In this RFC series, we are introducing a C extension module to allow
> > python programs to call the libperf API functions. Currently libperf ca=
n
> > be used by C programs, but expanding the support to python is beneficia=
l
> > for python users.
> >
> > The structure of the patch series is as follows:
> > 1. Patch 1 : Create wrappers for the perf structs which are used by
> > examples/counting.c
> >
> > 2. Patch 2: Create the C extension module that maps and exposes the
> > libperf functions to python programs
>
> May I ask why you are not using SWIG? With libcpupower the kernel has
> already been using SWIG to generate Python bindings for a C user-space AP=
I.
>
> This has several advantages including a much smaller footprint (you only
> need to copy the header definitions into a .swg file), can generate for
> several languages (Perl, Ruby, Java and C#), and SWIG is an active,
> tested, and mature piece of software code that has been around for
> almost as long as the Linux kernel.
>
> Python bindings including the makefile as an example:
> https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bind=
ings/python
>
> How to use the bindings in a script:
> https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bind=
ings/python/test_raw_pylibcpupower.py
>
> Original discussion:
> https://lore.kernel.org/linux-pm/20240724221122.54601-1-jwyatt@redhat.com=
/
>
> SWIG has been pretty useful as it helped me find two issues in the
> libcpupower API that have been around for over 10 years:
> https://lore.kernel.org/linux-pm/20240905021916.15938-1-jwyatt@redhat.com=
/T/#mf04b4ba93f79fe68c20c1d88d8ed966164a1c7d7
> https://lore.kernel.org/linux-pm/20250305210901.24177-1-jwyatt@redhat.com=
/

So I think we should probably get rid of libperf and re-integrate it
back into the perf code. There are issues in the code, like removing a
list element:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/perf/evlist.c?h=3Dtmp.perf-tools-next#n58
just leaks the removed element. Deleting the element means that the
container evsel, rather than the libperf perf_evsel, leaks things like
the name variable. We can add yet more call backs and complexity but
I'm not sure what we're winning. Perhaps we can move things the other
way, perf code into libperf, like machine, session, pmus, .. I'd
prefer if we were to do that we refactored the code and adopted the
same license as libbpf as both libraries have similar packaging
issues. The viral GPLv2 on libperf is something of an issue. Perhaps
we can also migrate this code to Rust.

SWIG is fine, there is also CLIF, I'm way of dependencies as even a
python dependency in the perf build is optional.

We already have perf python bindings, and I've been working to extend
those for example in:
https://lore.kernel.org/lkml/20250228222308.626803-1-irogers@google.com/
and I've been working to expand those for things like hybrid CPUs. It
seems a shame to reinvent all of that logic again on top of libperf.

Thanks,
Ian

> >
> > 2. Patch 3: A python variant of counting.c - counting.py to demonstrate
> > the usage of libperf from python
> >
> > We have not added support for entire libperf, as we want to get
> > community feedback on the approach taken in this series.
> >
> > Gautam Menghani (3):
> >   libperf: Introduce wrappers for perf structs to be exposed to python
> >   libperf: Introduce a C extension module for python
> >   libperf: Add counting.py example to demonstrate libperf usage from
> >     python
> >
> >  tools/lib/perf/Build                          |   1 +
> >  .../perf/Documentation/examples/counting.py   |  74 +++
> >  tools/lib/perf/Makefile                       |  12 +-
> >  tools/lib/perf/include/perf/py_perf.h         | 431 ++++++++++++++++++
> >  tools/lib/perf/libperf.map                    |   1 +
> >  tools/lib/perf/py_perf.c                      | 262 +++++++++++
> >  6 files changed, 779 insertions(+), 2 deletions(-)
> >  create mode 100755 tools/lib/perf/Documentation/examples/counting.py
> >  create mode 100644 tools/lib/perf/include/perf/py_perf.h
> >  create mode 100644 tools/lib/perf/py_perf.c
> >
> > --
> > 2.47.0
> >
>
> --
> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat
>
