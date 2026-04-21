Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139237DE84
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805955; cv=none; b=iSrOyFuAXCdUre3YaQaooRQobr18RY7CyZ14JrDV7YqPbVXl0mem35xx5NsDVJ04tSEHrcsTNzXkC7I4ktWeKijiGYkyot23T/cFC6lmTZd2U3jK6HSZTVqSKMp/cYfAyyByxDqsx/zBAsRGm2pKy2676yLMnyNFnkIL3ry8CrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805955; c=relaxed/simple;
	bh=W6LIdxI6AdQlV29nRQPvnH/SQhu5be5FEdqJ9I13BwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJEGjcuhN2NDyYLN/jjtaZkjMGyJKAvmFFTy50XJWqWzH0a+OETLEkcJdinTSvWpq7xc9/i8IVuH4DcVksICl42se2hLkLWtWYJN/dN4Tk5Q5XH6ykmz3K52Rnnd1Unht0hAQV9HrnMXEgGANXhGQSs1J49k1j44/iHWKnZlj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gb452p3v; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gb452p3v"
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-4230a00de40so4408010fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 14:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776805953; x=1777410753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT5XDk4ENU9Ts7uBK36HGatXcU+5j9uNYgqp1VJmSAs=;
        b=Ll+RSHH0a4HlxEwSOb4OkZbTT+37NlcsmDdMqIQzvpO5ivF35KW+FH4Y1zUywZmowl
         rcKZveJKII4Dd8mRtp6cidtQHkABSmz/4DmVkN63oocyQCpExxdPPnFnFW9pRRF+Z6vl
         Fb8gdO2j27TMxgkwA08LVJ2fZOhGAIisv5ajAy2bHG1qq185M8qZPmGm7PxrkAz0+CbZ
         4a87D2EFh4/MiADyQS/3IOyRzzr3s+MsjBxcyrpdtJKJF5HdnRr6lcizLNdd8x8uYwCT
         3pXBZeyMsCSGLNhWRQo1verXe/Cbxni8GP4RY9L0EQhTgxse5LHD9NTRtNLRztFxtui6
         3akA==
X-Forwarded-Encrypted: i=1; AFNElJ80uHAu8kYq0I3No+i8aDkkYam17Q+0g9PIm6RjS9w/eTmghV0+lex+jRNfHCo9jHmc1ChaRAKS4DWwaxeliOtg@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbXlRSitNATBOXfOPTZjcsTbPOjMnJhBcx0n2bczxorWR0TGA
	d7snd9wIA9wG7cyIe4ip4YiQsN6LCY4dbqkZbS/QIwgovnCx+Ul/f9S3xAPQfdtA/f8dUIEIaAp
	mkGeEMixAepvKPzF+eOmbOYht9nz+E2raJRFnvWhUkJpRc0ScVRqq610zFWdpfkGLmtikXD9eWS
	c5eCz3zzopWFF8g4tPN+NEo2i5vYJKo0IeBtyoqNaauPRnmi6zoGV7JBgZW7n7ys7HrI5925cQ8
	5gAsS/yLwKVRVgzCG5f9Qjb3gQ=
X-Gm-Gg: AeBDieuVO2y5Zyyh9BnbxghsHgFycBAUQ8hAEp0meE4XRTfagW8cZpoldfHwaXtf52F
	uYlmsNHAVGQBbdoDGGjvK34yU91olAG+yEfTEp9z7DsjO8wXF4DhV4EDPSRdgiW48Q3ZpyGmhb5
	jBAlzrIbjpt7sSdmSnuKri1AnlBwVv/AjzR4hHaNZ24tEXW2aLge+g6DpLHFpDjRellzvpuono6
	52Pk0a3Ht2cy8eXdLejxBnHbrf27ZlHq7NaDQ0iT44vv2QxLGj6pL4Q/MlOT/QtRY5fxOr98Dqb
	K5/TwPpPRioGgpe965vA2qR+3AFRGvftArO2GpIfeAsDLmJXGwBbae2nZDFwjTSUHLTA6p00yFt
	y0aG1cDQVFIqSKtGbfHqOIfpXWCvw2p1cUGOD3AejRs6Ng9MnZV50vi+c+ynhKXnjw8EvBTPpAm
	/b0jSnuxmXfFabeDlskB31Q9X+1ytGRcFnG+tuGglE5N1mjVd9gmlH/6PoNqiPYAve08Y=
X-Received: by 2002:a05:6808:10cc:b0:479:eb0e:670a with SMTP id 5614622812f47-479eb0e70cfmr2900403b6e.29.1776805952899;
        Tue, 21 Apr 2026 14:12:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7dc975ad2b5sm901448a34.8.2026.04.21.14.12.32
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2026 14:12:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8f848ebcbbso354855166b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776805951; x=1777410751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tT5XDk4ENU9Ts7uBK36HGatXcU+5j9uNYgqp1VJmSAs=;
        b=Gb452p3vcOcCnomeZJzFpFsd9kdKt3BNC/Esl9Y2/kRb/J/rBd7nqa1l/HbyHQuq6g
         q71qaCY7WXFHhAgdqekfoRZz/87rUs2vyjEKfRKzMJUBBJQypQh/+n8v+ZESI2NgpqPS
         dm+UZ6cGW1UfzoaUBzIHXZPUsYreb0TPXD68w=
X-Forwarded-Encrypted: i=1; AFNElJ/LsLpVnd1sSmQkMhqQQNiOTUhumxvRRSZW6+DVYYqmkQoNefP2OIoJC+gxi6cMY+ibNlprIbJOiNUQ4VXrLfNj@vger.kernel.org
X-Received: by 2002:a17:907:60c9:b0:ba9:6faf:3ce4 with SMTP id a640c23a62f3a-ba96fbeacbbmr258353566b.38.1776805951088;
        Tue, 21 Apr 2026 14:12:31 -0700 (PDT)
X-Received: by 2002:a17:907:60c9:b0:ba9:6faf:3ce4 with SMTP id
 a640c23a62f3a-ba96fbeacbbmr258352266b.38.1776805950524; Tue, 21 Apr 2026
 14:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409221418.185343-1-mmayer@broadcom.com> <20260409221418.185343-2-mmayer@broadcom.com>
 <d9c9eddf-8f66-4757-98b4-16b4ba505f5e@linaro.org> <CAGt4E5tinak=M+301yDCE_R0qREcQvWY6uGQ9vPZjhfrCTxk7g@mail.gmail.com>
 <ee8e6379-6bb4-4a83-87d3-5ae30fc0e95c@linaro.org> <CAGt4E5t4v3ztJPFRX-x0ygTk3cgnM_SwB_t+vvbNJ+_ifa=KHA@mail.gmail.com>
 <aee4R3i-xnb0F0qb@google.com>
In-Reply-To: <aee4R3i-xnb0F0qb@google.com>
From: Markus Mayer <mmayer@broadcom.com>
Date: Tue, 21 Apr 2026 14:12:18 -0700
X-Gm-Features: AQROBzDlXJaplPXlk9BF6qlQEd-jVWT5j3i6bCqRsMLFfV0irFF8oUgiOJO-st8
Message-ID: <CAGt4E5snokobnozpiVcAUKuj3nmOMifNWn2ZT+KKPcRqZh2-dQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: fix "argument list too long" in second location
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, 
	Perf Mailing List <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, 21 Apr 2026 at 10:47, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Mon, Apr 20, 2026 at 11:26:42AM -0700, Markus Mayer wrote:
> > On Tue, 14 Apr 2026 at 03:43, James Clark <james.clark@linaro.org> wrote:
> > >
> > > On 11/04/2026 02:07, Markus Mayer wrote:
> > > > On Fri, 10 Apr 2026 at 02:25, James Clark <james.clark@linaro.org> wrote:
> > > >>
> > > >> On 09/04/2026 11:14 pm, Markus Mayer wrote:
> > > >>> Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
> > > >>> shell and cause it to display "argument list too long".
> > > >>>
> > > >>> Trying to quote $^ doesn't help.
> > > >>>
> > > >>> In the end, *not* displaying the (potentially long) list of files is
> > > >>> probably the right thing to do for a "quiet" message, anyway. Instead,
> > > >>> let's display a count of how many files were removed. There is always
> > > >>> V=1 if more detail is required.
> > > >>>
> > > >>>     TEST    linux/tools/perf/pmu-events/metric_test.log
> > > >>>     RM      ...634 orphan file(s)...
> > > >>>     LD      linux/tools/perf/util/perf-util-in.o
> > > >>>
> > > >>> Also move the comment regarding xargs before the rule, so it doesn't
> > > >>> show up in the build output.
> > > >>>
> > > >>
> > > >> I'm assuming this is just a cosmetic issue so it doesn't need a fixes
> > > >> tag? And "upsetting the shell" doesn't cause a build failure?
> > > >
> > > > No. It's not just cosmetic. It absolutely DOES cause a build failure.
> > > >
> > > >  From the cover letter in this thread:
> > > >
> > > >    GEN     linux/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
> > > >    TEST    linux/tools/perf/pmu-events/metric_test.log
> > > > make[5]: /bin/sh: Argument list too long
> > > > make[5]: *** [pmu-events/Build:220: prune_orphans] Error 127
> > > >
> > >
> > > Ah in that case it should have a fixes: tag then. And it's worth putting
> > > the actual build failure in the commit message IMO.
> >
> > Unfortunately, it looks like the patch was already applied.[1] Is
> > there anything I (or someone else) can do to fix up that commit
> > message in the way you are suggesting?
>
> It's already merged to the Linus tree.  I don't think we can change that
> anymore.

Agreed. If Linus already merged it, it is too late. Sorry guys.

Regards,
-Markus
