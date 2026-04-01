Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9838B7AC
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076780; cv=pass; b=AjuEUMwLRNZlkvBpZ6Env6EyPROoWK6FZ4ApNiA5g+ojljA9wtTlh/pLYvTxCxbhUrLGilkLUHzhPhDf7bOMvDSLBByJoWYj/GAjy7v+VuKDO0I33y9LCH3MZqy0N17XjU4iUnoc4+Fl+rfz5EJFWxvTEwM50VWITjga3NieYPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076780; c=relaxed/simple;
	bh=IEiHob1b/bmJBnMIVappS5TAw8RiUmR+bg/NxKzTYMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHq4k9Z/q3Q80gfGwG5FxFdV46GsuqA9dJEAfkFJ0+KeKiK5nCwYEU03yMhDvSJICKh1DdgKx5cFIT1ezaep3Ah6KmQwiMU7AxYbJbWZFlZ7YV0ojMAUqLM2iyZJHINQGpOgTaPRiwx0CuAOxmd39j/CesJDmCWCq36h6a0frSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+aliVXN; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+aliVXN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0c12be0ecso12315ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 13:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775076777; cv=none;
        d=google.com; s=arc-20240605;
        b=UgkovDlHY0C2kgf64MJMIeLHN3lciKeVfJLPt3oTtrrVYOcwL4RgjXQwdzq7O02oq2
         Teq+NbRcT1PDS+Yn3IXEELK82ep4d5TtI3B8zlAy/5kA71GyTo/P7Bfo/xSFw2w3AL1x
         s66eHsAEtie8zAJRP5YKHaQGrlHm/di8B1ewJB+LCHmrHfo+4GPRLKOIvUnnAvaLzzYE
         6uCDL7Qzps0HmVWRRmV1gqdAPJq4ZkCCvXWUjlpdO/zVuhDqux1t1NctCjRJ7gDjRIzl
         CzflFqag8QM7nJes8Vh8NYGUVHbtneMmPzGieqr88sKBbc2XCKNarQinwtnvwS94sk+L
         jU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qItXOIPrlOJqWrbJliKI/xUeFEFgaVo0zObBoX/Mh/8=;
        fh=uxjEmwFH0GljYV5fh8o/9wswO4REzwxCtpvDfE+AbOw=;
        b=Pnexq58/o5gXVqNSTIiefy91r80Y3KEwHQN7gCaJSF0iVQMNndawV2FpdvkrWxUrq9
         IpTNsog1ZnFBdQYRYVzeh7s8j4xlQOzv+fOaJBp7mpQ4eq5APPf6+OB0BddcViPJWpT4
         1VEImz/wqZGccKMDG6RQKAK7qxw0/S8Xb0X3toweNqWpTpzG3ePzN7vr3Mp8HgHjVZKD
         nwCEpmnYyVkcpYgm/y3tqIr1X100q6nKKMoJ3qOUK/xZ+OGvs9kOUXYqgrNU7zNm9sEw
         dogvwq/asrGYn/7+eTfXRJfJZrNrS1Vle3bphJMLFhIW9LsLUBquFrX61XzoLChQjhWT
         PwOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775076777; x=1775681577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qItXOIPrlOJqWrbJliKI/xUeFEFgaVo0zObBoX/Mh/8=;
        b=S+aliVXNNSJAYuDcxIgxWtY8aB/z74uy0K4qDlxfA4obtcva++LALorITjyftEiBtj
         RYaAsP9F4lRSQCghXzaVopJE9+JYNF4AaCTQjo/BdDP+UZXV7ASkw9MyyUGmAjf2+eXQ
         meUAaub585roro5XEHY0I2XCjpIzxmbGwennW/bXKewm9I60WMrrLIMTaAevPc2exR8M
         8EUxgPtVwubkp5xFZJYza1SDOoAlvEe/Y2ECwVw4WsFQGsgUDfIrAb2NEKGqw/eTasLv
         4CynIBD78019/q20O0T9x9WF0RiStE/ivVACow4Epa9bl0a96x7oYDIFItGNkJqqOJiM
         PgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076777; x=1775681577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qItXOIPrlOJqWrbJliKI/xUeFEFgaVo0zObBoX/Mh/8=;
        b=E9HYUULKYcvxdHQ77zBUpfo8djBURG/10YW12a+N7V2ZJpz26C6c4KIjKva5Ay9Ob6
         8veIJjsGPK2tCtTpjeacyMoW0CYNg9BGSwYOdQW/a6N8zVNwljGPSzkbAL+dLgU+yyr9
         qyPM6X97qwAxkkPd/9fJCQuyOQJJUemkX60dWjbnO0FPJuT/C0CkCC8oLE5uLQ0QCC4Z
         HMo8odD/E1kUneKweqnoI37ikrO/onMAeewLI3OV6HMUgXrTg93baiSugTvGdMWDwx9V
         oOXJXf+dVJQTLGA+N0LTN7Bqwm2VU9H8qIAbzurw3ltveB79rcrKTlglz/f8KeLmfX4C
         KYyw==
X-Forwarded-Encrypted: i=1; AJvYcCVMv0CY75Zz53r8bIvpPDSrrOlaX/WJaJEaYwjUpo14k5BUr3jH+el7N3LBwBcbjQg4u+4jecaVmG/Aayiwgx6W@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtr00vGIy8r9CwJsNNB6/vKJuKtDfYCrgU5EJLI8NeAHWutfy
	M4Qcmvw2YR5Hxlo228NZmAaOv7KgFUBULvXer70MAjUIc2ZKl0IokniWAdbSkY0n7/H2j/f9n3O
	BHDQ1o/ST68fyr/S+pKd51g0IiRhioN2JCxLPHPa+
X-Gm-Gg: ATEYQzyloyhztDeUGNh1FQK48K0k/q2RgHXg0yrQsLkl6yETpV8zWFQQb6x8ahwLaXc
	2zlGZo1zP7rJgZSYsV0V24QTDEgjus4vSqDxkXc6iPo2mRgmj3KuOWmxpctA8UhQ0Udx4VsYUIF
	JP15wGE8xBnulm2kxXKPDUx0JxzD7r4vNSoRj4fgkcLOL+udsWCqHPQ7SEKuvpWiAcqKiJpUz2O
	xy9bScxBVu4pBi2mwRvaeLhvSr0Xb5J3UhotSvdQyIJb/YU09CQw0e+8gfs9PrBVq1Qq6y4Frvx
	LGbiPqPrwOXV9jrv91EkjriDOZNvcJdQwbyP
X-Received: by 2002:a17:902:e788:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2b276af630fmr347195ad.9.1775076776423; Wed, 01 Apr 2026
 13:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
 <CAP-5=fWkBjJy2i=e+zn1Ou5g3J8rapGKi8O7ryQ-ic2vXFEOoQ@mail.gmail.com> <d8639ed9-63d9-4a61-8cce-72f4b7fcb872@huawei.com>
In-Reply-To: <d8639ed9-63d9-4a61-8cce-72f4b7fcb872@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:52:44 -0700
X-Gm-Features: AQROBzB-RkizY5trQwsbMUj3yzVWTc2iQyH6pdEcyLX7bSLsHyFCYxZPcVGRMIQ
Message-ID: <CAP-5=fUmozPRDgms0QxHS5G3O8csrhyak9TWGGXeYE+QwiSHQA@mail.gmail.com>
Subject: Re: [RFT PATCH 0/7] perf tool: Support iostat for multiple platforms
To: wangyushan <wangyushan12@huawei.com>
Cc: mike.leach@linaro.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, peterz@infradead.org, 
	john.g.garry@oracle.com, Jonathan.Cameron@huawei.com, shiju.jose@huawei.com, 
	will@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	liuyonglong@huawei.com, prime.zeng@hisilicon.com, fanghao11@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 7:15=E2=80=AFAM wangyushan <wangyushan12@huawei.com=
> wrote:
>
>
>
> On 1/27/2026 1:01 AM, Ian Rogers wrote:
> > On Mon, Jan 26, 2026 at 4:35=E2=80=AFAM Yushan Wang <wangyushan12@huawe=
i.com> wrote:
> >> Currently, platform-specific iostat code for PMUs is implemented as a
> >> common iostat callback interface and invoked based on what is being
> >> built. This approach limits support for iostat across different types =
of
> >> PMUs.
> >>
> >> Support of HiSilicon PCIe PMU iostat was raised at [1], which uses the
> >> similar approach.
> >>
> >> To extend support of iostat across platforms, change common iostat
> >> interface to framework to allow perf to probe PMU capabilities during
> >> runtime and route iostat request to the correct PMU-specific functions=
.
> >> Then HiSilicon PCIe PMU iostat is supported with the new framework.
> >>
> >> Request For Test:
> >> Refactors has been made to x86 iostat to adapt the iostat framework, t=
he
> >> probe function that checks if there's any PMU's name contains 'x86-iio=
'
> >> may not work properly, tests of that would be appreciated.
> >>
> >> [1] https://lore.kernel.org/all/4688a613-c94a-49b0-9d0f-09173c64082d@a=
rm.com/
> >>
> >> Shiju Jose (2):
> >>   perf-iostat: Extend iostat interface to support different iostat PMU=
s
> >>   perf-iostat: Make x86 iostat compatible with new iostat framework
> >>
> >> Yicong Yang (1):
> >>   perf-iostat: Enable iostat mode for HiSilicon PCIe PMU
> >>
> >> Yushan Wang (4):
> >>   perf stat: Check color's length instead of the pointer
> >>   perf stat: Save unnecessary print_metric() call
> >>   perf-x86: iostat: Change iostat_prefix() to static
> >>   perf-iostat: Support wilder wildcard-match for pmus
> > Hi,
> >
> > Thanks for the changes! Given the iostat code is display code, it'd be
> > great if we could avoid the arch directory usage. For example, I may
> > record data on a machine with a HiSilicon PCIe PMU but then want to
> > look at the data on an x86 laptop, as the code is under arch/arm64 it
> > won't get built.Given the PMU name is unique, is it possible to put
> > this code into tools/perf/util and determine whether to use it or not
> > by seeing if the PMU is present by its name? I know that means
> > refactoring the x86 code that hasn't done this.
>
> Yes, iostat itself didn't do much more than rearrange the display
> format. I can try to refactor that to the util directory, though x86
> iostat may need even more testing :)
>
> > A thought that is away from the iostat code and may simplify the code
> > base is that we could introduce system PMU, rather than CPU, dependent
> > metrics. Perhaps the iostat code could be replaced by a particular
> > metric group like Default or TopdownL1, so `perf iostat` becomes
> > something of a synonym for `perf stat -M iostat`. An example of what
> > this may look like is (unmerged):
> > https://lore.kernel.org/lkml/20260108191105.695131-34-irogers@google.co=
m/
> > where I introduce a memory bandwidth saturation metric dependent on
> > uncore PMUs (either cbox or cha) on Intel. There is a metric
> > "have_event" function that can be used to make a metric conditional.
> > If you `perf stat record` a metric today and then look at the
> > perf.data with `perf script --fields metric` (IIRC) then every metric
> > that has the recorded events within it will be computed, although the
> > code needs better testing, etc. I suspect the biggest downside to this
> > approach is in how the output looks, but perhaps that can be tweaked.
> > For example, the `ilist.py` command:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/python/ilist.py?h=3Dperf-tools-next
> > supports regular metrics.
> Since iostat is a small sub-command with not many events involved,
> it is great to have some events extracted as system metrics, like PCIe
> bandwidth etc.
>
> But the variety of bdf filtering and display may be difficult to adapt
> to the way metric does it. What do you think if we leave the iostat as
> is for now and maybe merge it to system metric infrastructure later?
>
> > That said, I'm not against the changes, the arch directory usage, not
> > using json metrics, etc. and this change is doing clean up, following
> > existing patterns, etc. Sometimes the codebase has evolved but certain
> > commands haven't kept up. I think `perf iostat` is a command like
> > that.
>
> And we are trying to make it follow up!

Hi Yushan, thanks for your effort on iostat! Did you have chance to
work on follow up?

Thanks,
Ian

> > Thanks,
> > Ian
>
> Thanks for the feedback!
> Yushan
> >>  tools/perf/arch/arm64/util/Build         |   1 +
> >>  tools/perf/arch/arm64/util/hisi-iostat.c | 479 ++++++++++++++++++++++=
+
> >>  tools/perf/arch/x86/util/iostat.c        | 105 +++--
> >>  tools/perf/builtin-script.c              |   2 +-
> >>  tools/perf/util/iostat.c                 |  79 ++--
> >>  tools/perf/util/iostat.h                 |  21 +-
> >>  tools/perf/util/pmus.c                   |  12 +-
> >>  tools/perf/util/pmus.h                   |   3 +
> >>  tools/perf/util/stat-display.c           |   4 +-
> >>  tools/perf/util/stat-shadow.c            |   4 +-
> >>  10 files changed, 638 insertions(+), 72 deletions(-)
> >>  create mode 100644 tools/perf/arch/arm64/util/hisi-iostat.c
> >>
> >> --
> >> 2.33.0
> >>
>
