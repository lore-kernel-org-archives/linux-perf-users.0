Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB71586EE
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173497; cv=none; b=iqeHLOTh/eaFZLR1b4KZN+nLLsFB2UTEeLZWxkjiYV5HvazQUh9N+a5MIvK2013mT5aMVNfpUI3DqCWYJRfeLIiyfz5DwQg+U3+6HbYujeDLHmd7Hg116iYYMt7V0do7GANCxVUnfgOgBls7splwbSa9UQwq/S/LXwbw+PaCOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173497; c=relaxed/simple;
	bh=k6V/f1+BsCmlpZVVeAjfyvro0dNzpctVLuN3eNRB7DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIO/MkDsjB2ivg+pRLbE8IH3JgKF2ljYTg1C89A38sMepy12lXQlHQpc/N20TuZVtQU4VGYym8YpMf+BdMaKuUSEyinTLQRmBEip1FhFFPvB9sI+dwCWCIQbf7Jstmo8xMk3iPWHEFlJXl+xP0YoT+jYhzJTYUcK4TFiiH9LjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BrhqG8en; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BrhqG8en"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43f87dd6866so3721cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717173495; x=1717778295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a/elQ/DVLq9OarBTd3P+ramDxjQmELz1kHVgXiQECk=;
        b=BrhqG8en2PMj59jQ+vrqDCxCP/sdUbmqQdLVcdLxmH9UCiP1K9an0rlm6ApkUBmJc/
         0PwaUOq8Ubr5QVvQmg827kmXAwqNeWPYVK0epBNNMd8DUemE5eSmMi5/W7GkJ23+THDn
         6VCBTgb1XCS3qs1JP9Kc6d3SUoo0hFa5VQw5GgqFdkl0ik/74WdBroQ9ilmKJOIO+Lou
         yJ+CgiHlnfBCjvJHkFNrpnqFqb6QZnGFUcM9vxdU2OiglTprZLJP4yfkgpOePwh89BUH
         YMelG+mDhG3cdVSWb02L5HFwq2buHHkJCL4kmLyXPsSNl28RwcS7p6Cw9BIpsLcTKPwo
         Qw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717173495; x=1717778295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+a/elQ/DVLq9OarBTd3P+ramDxjQmELz1kHVgXiQECk=;
        b=hBib5DFq56TUk+12Ak+JKKWvFkkL5KVlIU/VkbYOe/KG242dQeKdWo8KVwDq7cDjX2
         npVPaMpzDVjgfPwhjkj14bO3U3kymioKCMFs/upVEoShY/Jueae4D8ZIPgUtGtM9Gp7E
         u+4vpIrG30ZKHe/eHVwaf1vNelQ336tDC8Jx/tF/C0S7VkvNLwo40HEA78Wawc8TdSIp
         R7Ul3+psfr9akk2AOA1pFkwTyUM5Jvw9B7dM2OVMoqS4kddp6d1R8t/sVA9HcBN1xbd2
         y9ARq3mBJ/jBV8QyDTl49gULu80LIa0kg5NfPEeQ04PrPSiBwxsuJDV5H2Z4umJNef0/
         bxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6yaTLGoTrhNBV/akrKIFAPy4qZHyqiqnGIsEanIwQUgIuFAoULiijBDPdAZP/4PMslks4LzMxVItk6jcsC6QGIcpnSYhMbODD4/I/LRAhCw==
X-Gm-Message-State: AOJu0Yx1zDtdJ+f9FzZqlmaBk0QRSoqWi2VP7KWTTsQG4qcW5yjVVqc9
	DuoRGqPBfME3t/cFnx3K09ENaCruLplvzGsAc1q2bHcHcaevgTDSMR99pKTTr32mDrZyVMnKnlN
	PEYg8Jm2bXLiS8KTkGYfczOAkimYzNyWMAaaC
X-Google-Smtp-Source: AGHT+IEUvq8IrfxBqobB0qnsPcM/t9xGiOwgW/rm8obnqr7xsT5g6O6XEVnLgbOG+qBuq25Erbdj7agTEdB59tYJqCI=
X-Received: by 2002:a05:622a:4a14:b0:43f:b19e:d3ba with SMTP id
 d75a77b69052e-43ff2c5399bmr3098651cf.8.1717173494634; Fri, 31 May 2024
 09:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525013021.436430-2-irogers@google.com> <202405311548.1e881dea-oliver.sang@intel.com>
In-Reply-To: <202405311548.1e881dea-oliver.sang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 May 2024 09:38:01 -0700
Message-ID: <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Weilin Wang <weilin.wang@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:16=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> hi, Ian Rogers,
>
> we actually want to seek your advice. in our env, there is no problem to =
build
> parent.
>
> * 3249f8b84526d (linux-review/Ian-Rogers/perf-jevents-Autogenerate-empty-=
pmu-events-c/20240525-093240) perf jevents: Autogenerate empty-pmu-events.c
> * 7d88bd0d22746 perf jevents: Use name for special find value   <--- pare=
nt
>
> however, failed to build perf upon 3249f8b84526d. but there is not many u=
seful
> information in below detail log.
>
> is there any dependency or env setting for us to build this commit? Thank=
s!

Hi Oliver,

Thanks for the report and the work testing! Seeing the output:

[..snip..]
> --- pmu-events/empty-pmu-events.c       2024-05-30 08:20:10.000000000 +00=
00
> +++ pmu-events/test-empty-pmu-events.c  2024-05-30 15:55:37.332495538 +00=
00
> @@ -136,7 +136,7 @@
>  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
>  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\00000 */
>  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\00000 */
> -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
edany\000\000\000\000\000\000\000\00000 */
> +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\00000 */
>
>  };
>
> @@ -373,7 +373,7 @@
[..snip..]

It appears the version of empty-pmu-events.c the patch adds and the
version generated in your test configuration are differing because of
whitespace. Perhaps a hex editor will show what the exact difference
is, it must relate to locales or something. Like you mention this
could be resolved by an env change.

> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240531/202405311548.1e881dea-ol=
iver.sang@intel.com

I didn't see the generated test-empty-pmu-events.c there and so
couldn't follow up on the locale/env exploration. I wonder that a
suitable workaround is to change from the patch:

+$(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENT=
S_C)
+       $(call rule_mkdir)
+       $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)

to instead of invoking "diff -u" to invoke "diff -w -u", that is to
ignore whitespace. I can send a v3 with this.

Thanks,
Ian
