Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF9411691
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109263; cv=pass; b=h+3ASrUXLkcs85gCJLHY9cH5OAOcSWb8ub4xsW6pho1f39grQiYV6DVtVt2u4zXddkxZpaG1Em7bAyyXyT9tpojhp/xakE12VHFOQpxOFE/NIAU3nRXf8mREwn1ftRZEz8FBwZZJU4ibt0bu3oTmu19Z8zmEaEYFclfzs2bSpbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109263; c=relaxed/simple;
	bh=XxcnKx8aTyQRysco9yob8teG0Hm7pIWhDCbbc7ogXSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz4bZfmmwqgI2JSNfGoDtqvJWjtZrr5M3aejMPY7YZ3XUHLYULC4fsFGNA7LdRcV1bviFf+KuTyZZH5YGFmOs5MmclXiM+KUVBbebojPsLU1hacm5p7CVzkypdwcjjv68fqbz4gmq+9VWr9aNKtbl7hBByrbPAB3K4dzF45rwFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2B9VLDB; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2B9VLDB"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso224960a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 13:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109247; cv=none;
        d=google.com; s=arc-20260327;
        b=MvXh+0NeER9VdDh2c0r4WrumYCYTOnSdZglEruscc31Dtr04er+NTQz+vvtLmEAVjH
         UmdOQqGqmxMyNDYALuDgXMMUbets+ZKbAF/iOnoyI1kBWJz6VLdubgR3yBtNNqxU8Liw
         JmtucVWQ/pkg+HBgyE7H0mrVii5hVCi4cNHt/p9wwYIETuqGoNFCXMYAkB2hddW1hZSx
         A8Rvj4eJBmSk824zNKuQjim25JCTIc+vlQ58W1Y6LoPbInaDXLPWU7pAdc06Gr4lT4hs
         PvLYtC5hOHoPYhhaNQ3+IsWJWHUjKxOGv7YzLSSsGIuFnnaaeTgiFQOPsSEcow/zD8WA
         UrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XxcnKx8aTyQRysco9yob8teG0Hm7pIWhDCbbc7ogXSM=;
        fh=oimb4ZKzfzwwWPIsk80WAXttSMFEWyebA011L2DEBno=;
        b=e3x4uCF9SWXfH9bCb7XmktJvHE+6ehq66/IyraSWpYwvLkB5XNHc+TKC6A5EPIKykO
         +8luOye5Y5FPhGzcTQZfRLdF4MC4Nj3mFR2SaMNT2jmIs9355lqUeu/4TOB73JWH4vqj
         25HAOMBnNppWJknozv2m8E+86HZ4vd61ym2wOJOwo/DakVDYfRKGanvWHCPJlvNHIe18
         ecMf071SlHlOLfosDPjoILzZagAQW3GrzLi7lRUXN01NsPr+GaYBqi5fxW9DlfncHnHU
         zWdmwq9P7bHH4mkdKe3Vd0hL8nKdtqbvCUnmcGMXqkWHUJjimrXkgerLuyw6uqpBXGow
         eu0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109247; x=1790714047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XxcnKx8aTyQRysco9yob8teG0Hm7pIWhDCbbc7ogXSM=;
        b=b2B9VLDBhB9/kDZFcqYet14QEct3vAWrNBGYUGDVra9qfDJ9RqFq6mtqry9ZHwl/yR
         SWRRsgblCDH+n+EcE9SK80q1tUCx0cfW/BDaYQoANVjqKo6uetl5lDKCkYHsQ/H6Xetg
         CisWWuJkr62mKIQimU1j3lw0VNN42wGD7LW/RqHRjM37UU/czUL6RSgp1y+uuH6NXyG2
         tD/MnnbhlfrBYTCg5K7ea85lJKjH/yKCBHZw7DSHqNDKd3fi52tB4jiBCziSFheiyznR
         tXp1CLnBK6RrdsA4muGgVktTFvSQGjMB9tlpkZ/G9/Z5HGuUtDmM0l/n0if4r8y1f5eO
         /kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109247; x=1790714047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxcnKx8aTyQRysco9yob8teG0Hm7pIWhDCbbc7ogXSM=;
        b=GAVXe9rS1rLOXTRbAFR4R3KueCZClUklOl8eFMNeIjJ6m2qg6tKgv4W+gh2bJUVki9
         IpkHcO/uSQ9307Ep+dXIbzy3KQ380MGABhz2hgFxp0urlt7C6VrEMgq11ryurRj9iJ/b
         WOAk8eEIr86WI6eoXp+q+PxKGrgeRGRUaUAuny6LVRvqNxz5zXNkx1LjjP6Jo6RWY9Vh
         8JLYzahCcZK6dpuODXQlnSBqGVQmmEhbovni7SUMVIk/lEhxkS2Ng0CI97pgX9T0wmSs
         jf1z1a1vYQEjEPL+syeglGGOaj3gODneG5nJiHijziVmu0mQl8D6d6/zSLqv73s2UJ2r
         jcEg==
X-Forwarded-Encrypted: i=1; AKwUvBzJPsKQwVRKlhzLOoHMxRj1XXC9gkT4mF83+R7YPOf3USYsTw6WOn6qpp4JHyRbhFkB5UpGLd5gwc7lEb+FZNMp@vger.kernel.org
X-Gm-Message-State: AFuF++lN7C4a6rgpKBV3uIFKoN+5jNA6Vv2yCpzk7KN6NRRAU25N/qqf
	Bbk6vDpd/dSW05k2DvKNHBXeE/5NNid+c9kS9SGf+yFb+KqPsi6Ki9MRqfWjw6FQS0WRo93Tm8j
	iKgtrJ1AUnNQ1NPZUo7iFq4oUIMn0ZDw=
X-Gm-Gg: AYBFou30Uo9OqQr4i5VYz2yMrxhSfjbyfbVp6GeqaxqDNaI9F6k5YA/lbaRaMxxguYQ
	u0qH2RMCdjEJ2f31KEVqj1WGXGnd75B/uOccfeVrKnPd15QC8OhJrLAwaiaD7fXM+lexwvA3LxH
	3UIeDJBmxMbNK5kYHmIanNfDE3wYcZgzfr3rMBuaewBt7fAuOVJru0a595lFV6lTX91v0G2YhZ4
	0t/t9ie7CjBYqb4N6m86//mPqrU3L2NgNeb8rfXPae/sNA3riqnts+XL/c1Lk+l8yiRjjvMrLlj
	mnTsVf/js/JXySaHmWqpxuMi1z6EQXGL5VIk9+9XlZfpdblcPvIS2/x3REsx7nSxEtm8NA2XZYs
	UnueRwc4T9tams2SJgDc2opEbeKYNDFza1GKr6q+xVkMr21tNIj23x2MS9DF21+E=
X-Received: by 2002:a17:90b:4a45:b0:39e:2530:2102 with SMTP id
 98e67ed59e1d1-3a07e56552cmr499070a91.11.1790109247222; Tue, 22 Sep 2026
 13:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810133540.1947118-1-puranjay@kernel.org> <4f755a7f-0a55-4292-892a-28346ed235a4@huawei.com>
 <CAP-5=fUepMzyctDcUqYNJMG+xBOK0bdUF_cXPtQ43AxfFVL+Zw@mail.gmail.com>
In-Reply-To: <CAP-5=fUepMzyctDcUqYNJMG+xBOK0bdUF_cXPtQ43AxfFVL+Zw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Sep 2026 13:33:52 -0700
X-Gm-Features: AcwNN1WthkF5BlZ1QMNrqoVSwR9HYVD5IHCsPcWIws_60KwDdxRC38bx-LOITwg
Message-ID: <CAEf4BzZZOqFvSfjp7YMAvEabQSrziv7j26P_SRwMczKf56WZ4A@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf/core: sched_task() dispatch and branch entry fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: wuyifan <wuyifan50@huawei.com>, Ian Rogers <irogers@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Usama Arif <usama.arif@linux.dev>, Will Deacon <will@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:47=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Sep 3, 2026 at 7:45=E2=80=AFPM wuyifan <wuyifan50@huawei.com> wro=
te:
> >
> > Hi Puranjay,
> >
> > On 8/10/2026 9:35 PM, Puranjay Mohan wrote:
> > > These three fixes were found while adding BRBE support for
> > > bpf_get_branch_snapshot() on arm64 and were carried in that series un=
til
> > > v6 [1]. They do not depend on it, so they go on their own; the versio=
n
> > > number continues from that series to avoid two numbering schemes for =
the
> > > same patches.
> > perf record -C <cpu> -b [<command>] triggers a NULL pointer dereference
> > in armv8pmu_sched_task().
> >
> > Commit fa9d27773873 ("perf: arm_pmu: Kill last use of per-CPU cpu_armpm=
u
> > pointer") changed armv8pmu_sched_task() from reading the per-CPU
> > cpu_armpmu variable to dereferencing pmu_ctx->pmu via
> > to_arm_pmu(pmu_ctx->pmu). Meanwhile, commit bd2756811766 ("perf:
> > Rewrite core context handling") made __perf_pmu_sched_task() pass
> > cpc->task_epc to pmu->sched_task(). cpc->task_epc is only non-NULL
> > while a task context is scheduled in; CPU-bound events do not schedule =
a
> > task context, so cpc->task_epc stays NULL. The NULL argument is derefer=
enced
> > and crashes.
> >
> > With the patches applied, perf record -C <cpu> -b no longer crashes,
> > and system-wide perf record -b -e <event> -a alongside a task-bound eve=
nt
> > on a different CPU runs without any WARN_ON.
> >
> > Tested-by: Yifan Wu <wuyifan50@huawei.com>
>
> Hi,
>
> Is there anything that needs doing to land this series? Avoiding a
> perf crash seems worthwhile. I believe Peter and Ingo are best placed
> to review the changes to kernel/events/core.c.
>

another ping... seems like worthwhile problems to fix

> Thanks,
> Ian
>
