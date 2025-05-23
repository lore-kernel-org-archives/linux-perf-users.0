Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EC27472;
	Fri, 23 May 2025 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747961336; cv=none; b=L+xISuCrT/rcrCpwSSyOH2k4YsjtAwBYET7AqIQMljhGsIzVUZOLWFOfSr3UUWaMf4uz6bihpdrEODivIVf0q7Sse2gkE3R2lnL0wOmy4EtSlj4e4+ujvpC+G0kn/cvGbf4Jvq/cKJ59TUA7zjgAIV7LuCIH+DwnnKPzwF4XfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747961336; c=relaxed/simple;
	bh=d63wCnHr0EWqOU1BocWeJHYROt/+eG8tWicDhvgarj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppHOYG9zR990qHjl6kVXynjt7oPXOSucrDRj41j3jNjxGeptaPKLSftYAQ66Bj7i5SqVtP0tnYLIoXO318pJ3myVGeRFSbSduA9jp3As8y5ClXP129XqsxO7h88wfSnRc7D8D/eYZUejNaIlGRWiW3cyVLJF6WCwhGUJwlJ1MaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ7Ms7tF; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ7Ms7tF"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70825de932bso4636667b3.0;
        Thu, 22 May 2025 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747961334; x=1748566134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdEzR6oYqaiK1/sHd3LxPGkdfI/HB1NaUFC/a4rXl0U=;
        b=iQ7Ms7tFGNG75HvGhcfyfMtXi7F/5abD4kCY6A7LIArEFMBo0RQhgWaSABM5iKV093
         dIQtyBaJvHpgBJYJAFrC1/5arcv2rv81LyCgDpt2Oe7UmTBjsrTlElDhhIvoHnenjUDe
         uu46SllBjmLguj6jfetjHEsumaqB5c3VibbOSZO79IBPEhgJb8dCOu4yyMSfuocGfwN1
         5p3bTThIvw7k6fhF38bDEp7XKxdU8UbtDdKsfsqiCp1jCOnpqKwcGwV+hqBbX81WouQz
         hvTvq9cCpwDi8l/S+HcM1leXd+vMmxW4Gz3NkvW7nvzrkZpI5HCQ2OA1lhPiCuua3Taa
         4KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747961334; x=1748566134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdEzR6oYqaiK1/sHd3LxPGkdfI/HB1NaUFC/a4rXl0U=;
        b=obN4mnV6U4BQlzQHO92gSXgkvI/12JYfK5bKBQtUsH0khj6YaCpSpX66f5PRNp+rwK
         y8bTa0/SEt1U5hRGfAZ2+cG8R9rnICLREPPa89Mz35TxFTlmOZvKRNXxDSJbUDq2ePgQ
         aSlqVBboCWtng84SfYCw0nANYvxuFZLRQaZXNZgAp+zg8PxcKohotd4D86Dr6XfSmUi2
         RHJl+MhPTbZ/e7j+gHb4guX4Zm1KdLI3E3P4+ejXo7Tb2FfCOpEQn207m3vyS6g7zqrk
         AI1R0X9IOEQeGNtsM30fyKWleCTMbR9MHcCR45GkkPfoKVSUqvfs9dGm2JP+mJbu7YgQ
         s4qA==
X-Forwarded-Encrypted: i=1; AJvYcCVpY5dhdf2vNLwO/9tHStqb55DSBoxT3Ssy1rwcPZDpHWH7xzH6gX2vqqVVfwr6x4VKjwZattWkooAMP1cLrXoKcQ==@vger.kernel.org, AJvYcCWlYF0Ug9e/11wpD6oW+rxfaugaTTou3b4OjsePynMCed+mtIC3n38dCG8ftb/7BAvNox+nH+bH3S1owQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+Ux9kk8ovNLRz+RAeo9sz9w0cyXuNGpAIiQd1S0DRDjK7IsH
	FOpkOIdqsLOYD6E1DER1efj8G3wj+n06jqR76/dfuDgXFydJydacCvJJKgGrvKWmipFy9IgHb+I
	9mA8zqGEbFd2s4FqW4zVAdKspc8FgNnw=
X-Gm-Gg: ASbGncuJtdFm6/CSf1SOK3D+RyKfSAeyz5IQcbBIEZ/kOl7bxA+c6Tc+gZtHaweGHTN
	XdbnXgEcxloIKdPibeJPjc10zlZupBG1MiY7mx4OiqSckX7S/wz5Dh8Pf9q3azaM4FUWb5gXod0
	sfTef9fRMNeEnx2Vc0KO5qkj3FcEHveWUZp47l2m4KFfIQTZ3wgdWrWDCoR9VF3AYmgA==
X-Google-Smtp-Source: AGHT+IHTbXMo645TLAKiKzwcTCZtggCP0/WdBe/3QdIQOHg4uWL1iUz5UxVrl0DzgXTvI5jULzxnxFedN2gjjVFrJ74=
X-Received: by 2002:a05:690c:9a01:b0:70d:f88a:2390 with SMTP id
 00721157ae682-70e18500cb4mr25074317b3.4.1747961334251; Thu, 22 May 2025
 17:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522142551.1062417-1-namhyung@kernel.org> <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>
 <aC9VoTL_Cv4R7J-j@x1> <aC-hHTgArwlF_zu9@x1>
In-Reply-To: <aC-hHTgArwlF_zu9@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 22 May 2025 17:48:42 -0700
X-Gm-Features: AX0GCFsmVF6B2aUgAA8kNv0vdOkNuuYx--WCPyyqEwwwhmxudr2xO-2tLWZCReU
Message-ID: <CAH0uvogYaqjutK3WuH0+Xw0q0fGwnXQqQP7=qCd302N8S2NiLw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add cgroup summary test case for perf trace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Thu, May 22, 2025 at 3:11=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, May 22, 2025 at 01:49:37PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, May 22, 2025 at 08:33:16AM -0700, Howard Chu wrote:
> > > $ sudo /tmp/perf/perf test -vv 112
> > > 112: perf trace summary:
> > > 112: perf trace summary
> > > --- start ---
> > > test child forked, pid 1574993
> > > testing: perf trace -s -- true
> > > testing: perf trace -S -- true
> > > testing: perf trace -s --summary-mode=3Dthread -- true
> > > testing: perf trace -S --summary-mode=3Dtotal -- true
> > > testing: perf trace -as --summary-mode=3Dthread --no-bpf-summary -- t=
rue
> > > testing: perf trace -as --summary-mode=3Dtotal --no-bpf-summary -- tr=
ue
> > > testing: perf trace -as --summary-mode=3Dthread --bpf-summary -- true
> > > testing: perf trace -as --summary-mode=3Dtotal --bpf-summary -- true
> > > testing: perf trace -aS --summary-mode=3Dtotal --bpf-summary -- true
> > > testing: perf trace -as --summary-mode=3Dcgroup --bpf-summary -- true
> > > testing: perf trace -aS --summary-mode=3Dcgroup --bpf-summary -- true
> > > ---- end(0) ----
> > > 112: perf trace summary                                              =
: Ok
>
> > Thanks, tested and applied to perf-tools-next,
>
> But then when running all the tests, since this does system wide
> tracing, it fails:
>
> 112: perf trace summary                                              : FA=
ILED!

Yeah I've been trying to diagnose the parallel problem for days... I
just can't find documentation about why 'returning 1' (in
syscall_unaugmented) can emit a sample in
tp/raw_syscalls/sys_(exit|enter)...

Thanks,
Howard
