Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4453AE6E2
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709619; cv=none; b=IuaNdRYN8lvaqowWelQpsbgQ6OscNUIigXKoR8YQt4WxUgte+cW05Zvj2/Vo8iMIdRNsD3Q/HZceFvlKNHD2wOT2ONbgdE9LXbVCSBd0pCrdYVNmpEErFMfEQFiSUFiQh4OuZUjP+aTCRvVAi/uAERFbIpV4rIjEajalmAcgfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709619; c=relaxed/simple;
	bh=tdCDk7kQqLLm0xmEYfvTgPbL8wkqXQgP5yooxxBSc5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asW2r1H81WDYRAfjeTfYjSEOkBHsOHpVaC+ta8ZAzVHuVd40QWRRtWyZs1r0G85MU4EALwDNBrv54HxUogKZ66Q/buGQYikLuy+VlIPb2mnuksJLGfTt8B1UQeZUXZbUixfGrYTTn/M791zx8U89hDDHxB3mDMXMV1HO0MT+QEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pydp2RHl; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pydp2RHl"
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8d7e7f48499so381753885a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 11:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776709617; x=1777314417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWPe8++bYX46RiubHBos5NK0oKztWZClINrpZVnlUMc=;
        b=ZNClMzwuBc1TASWxRupv1Q4O2l5rkGLv72XXti37vpq2U8Wf4EqgMZLEeM2te+L3oJ
         eXT/NvbJtUWOcYoQts7l84oBIUpzLzJYI/0htlezaX6DGd3pcO76yk0dbwd25tF8TE0W
         S3I9p49UYA0puX5IeVdgNkccSLdBfoj/pPvA7Ge6ic85m/KTaCu8gEXoAwfcYNKm5tev
         gfiVe7vZRCLEQycob0B8hvCJgZBLiuIylr8cbcCxIjLqUWwYDM1VdHZf1KLtOdxAxoID
         ErZsSU3kf1PnQolfA9BbPb+7LAww6JrEd9v/ch29CJ0V4vkFO6AWuTFl6AwugqbLjvAS
         NokA==
X-Gm-Message-State: AOJu0YwxfmbOTt1QAdWRTJpTRYYJnVW0qndQv4l6WqSdX0bZxstU8p/j
	ZPIcAvgcCXq9q6uu/f4QfvAFNmWLwQdq+A/Jw9rDR2V+9wKLqkhfokdel1Fup39dzg7Hdj6utEp
	gS/ZSZT2d1jhF0nKnl7yrZZpAqhhAvfx4WOVCe4IjLUKbNzQ28e+he84i7J6tSukS2lne+LwNGT
	4SJP9J24T9/eVDkBXohnaXCFw3JfmIgJ+m8WuwWbRmYE6Re43Co/QY0pIJg3mPD1XOEQS6qE+1J
	mEHwYimDooz85MkRfz98XLDToQ=
X-Gm-Gg: AeBDievbVFejW6OzL4JSG2nAj1vuARQYT75oMMF1LdismJVUvoreunwI+zjR/kQiM2t
	WKNNhBecR84pMN+HqY9CRsYG1/pxBdbLbwLuLdO8faTI6eYQgLvt5EwohKD3Q/jSO0eA49NUKIJ
	RMCQZI/DYWfbsFiTU/U6QgWhPpYAAiQGN+obwWI9i0RQswCBlv6c0Tl6sUqhcLp7nvcb9rWbqoN
	tv3o/t//lJ/SKKoYaxsgp4lIsejI3PgRTd4b34nBsaPL8sBSDPLneHqE3TceeKMVzi4B7mdsIJI
	9Ix5khCC7WtlOQSqzLk1qyHJtE8agTbJemm8vUATBDOCQZCUSrPVGMrgU0gX04mUK7FsnANjTfO
	WBkYfX/sKgytTTI9Qet8U/IAyYfbNDkjK/iE/WoHASivQit5UgYFH/87qIY5od1ck28lWaqigvM
	iAbiegRcpEcaPWgWf65C79mB17NqhB0ike2avl3kAii0XEJhc1hA7T2aVRAzOKxTx9RtU=
X-Received: by 2002:a05:620a:4052:b0:8ee:17ba:9eb1 with SMTP id af79cd13be357-8ee17babdbcmr108489285a.51.1776709617198;
        Mon, 20 Apr 2026 11:26:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b02ae87b06sm8286036d6.27.2026.04.20.11.26.56
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2026 11:26:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b9399d68111so370186266b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776709616; x=1777314416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWPe8++bYX46RiubHBos5NK0oKztWZClINrpZVnlUMc=;
        b=Pydp2RHlLgK/IX3geo2ZFS7Mu7b5F0e5LB5KYX6757FFW4D5CMruwTeP/V6WUs5mOJ
         o7S6q6I5Vm+J6EwqysHnwcI3wAu/bdzziXS/7/APPJKMUfh0APU3i1f+aLU0lCnSqr9w
         YNgcSADBDK8uc0rw67Opgb91qPf1+tCrQYywY=
X-Received: by 2002:a17:907:7286:b0:ba5:bef2:2ab0 with SMTP id a640c23a62f3a-ba5bef232d4mr489878866b.20.1776709615490;
        Mon, 20 Apr 2026 11:26:55 -0700 (PDT)
X-Received: by 2002:a17:907:7286:b0:ba5:bef2:2ab0 with SMTP id
 a640c23a62f3a-ba5bef232d4mr489875666b.20.1776709614781; Mon, 20 Apr 2026
 11:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409221418.185343-1-mmayer@broadcom.com> <20260409221418.185343-2-mmayer@broadcom.com>
 <d9c9eddf-8f66-4757-98b4-16b4ba505f5e@linaro.org> <CAGt4E5tinak=M+301yDCE_R0qREcQvWY6uGQ9vPZjhfrCTxk7g@mail.gmail.com>
 <ee8e6379-6bb4-4a83-87d3-5ae30fc0e95c@linaro.org>
In-Reply-To: <ee8e6379-6bb4-4a83-87d3-5ae30fc0e95c@linaro.org>
From: Markus Mayer <mmayer@broadcom.com>
Date: Mon, 20 Apr 2026 11:26:42 -0700
X-Gm-Features: AQROBzDzrB56doXH0tRh7A1w1QmSJaKB2dN5yhxrMpNQeCQoaIzy1ijfgrMPZeA
Message-ID: <CAGt4E5t4v3ztJPFRX-x0ygTk3cgnM_SwB_t+vvbNJ+_ifa=KHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: fix "argument list too long" in second location
To: James Clark <james.clark@linaro.org>
Cc: Perf Mailing List <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, 14 Apr 2026 at 03:43, James Clark <james.clark@linaro.org> wrote:
>
> On 11/04/2026 02:07, Markus Mayer wrote:
> > On Fri, 10 Apr 2026 at 02:25, James Clark <james.clark@linaro.org> wrote:
> >>
> >> On 09/04/2026 11:14 pm, Markus Mayer wrote:
> >>> Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
> >>> shell and cause it to display "argument list too long".
> >>>
> >>> Trying to quote $^ doesn't help.
> >>>
> >>> In the end, *not* displaying the (potentially long) list of files is
> >>> probably the right thing to do for a "quiet" message, anyway. Instead,
> >>> let's display a count of how many files were removed. There is always
> >>> V=1 if more detail is required.
> >>>
> >>>     TEST    linux/tools/perf/pmu-events/metric_test.log
> >>>     RM      ...634 orphan file(s)...
> >>>     LD      linux/tools/perf/util/perf-util-in.o
> >>>
> >>> Also move the comment regarding xargs before the rule, so it doesn't
> >>> show up in the build output.
> >>>
> >>
> >> I'm assuming this is just a cosmetic issue so it doesn't need a fixes
> >> tag? And "upsetting the shell" doesn't cause a build failure?
> >
> > No. It's not just cosmetic. It absolutely DOES cause a build failure.
> >
> >  From the cover letter in this thread:
> >
> >    GEN     linux/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
> >    TEST    linux/tools/perf/pmu-events/metric_test.log
> > make[5]: /bin/sh: Argument list too long
> > make[5]: *** [pmu-events/Build:220: prune_orphans] Error 127
> >
>
> Ah in that case it should have a fixes: tag then. And it's worth putting
> the actual build failure in the commit message IMO.

Unfortunately, it looks like the patch was already applied.[1] Is
there anything I (or someone else) can do to fix up that commit
message in the way you are suggesting?

Thanks,
-Markus

[1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=97ab89686a9e
