Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B793BB119
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511958; cv=pass; b=IZdnsyDSI1/RYHKaeyCz/eSqXcUBn2J5lLXf+ThokbDhYoSgCGaH33cRvXEXsviyeCOOcUjMLvGqwN5tcf6F660vSlC7iz3n4Sb2ZfFLhxSe6RhttrAjwMSIauyabnr/rn0RYZpDBz/dWiOLR4Ya3hXrLhMTx1oPyRWxpqQd5VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511958; c=relaxed/simple;
	bh=vJsCws3FamyI5nwIu6NR9CwJlE0an5auOcy5PUi3Br4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyL+jH4gSdC/PzQRWKL+KCOTv+4mNGvgL+xdtiROtFeuNJZKnKintXTpoNFicjQnJSvaEsIfcJK88xNviU5JsUNtQIymSc8NwClItDy97ykpB3Pl3NO3oMGgbNNH0tSdFePtx1dUNpRz6D8Q8dhtUFKBdrId26W1waCBTsElSZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxyFWca/; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxyFWca/"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5306706e89dso46411cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 15:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789511955; cv=none;
        d=google.com; s=arc-20260327;
        b=lvx/bvxnVKDJi1gBOybu/OEN4z3XaikfJ2Nu2o2bRIIEw4mrQe3HVdBUUrOWfCIpIR
         eI6Mip+KzyilXDaZHuIIDlTO3b2k7aSbRuyBPvbx+Pw8EAMbsuBCS8KY3Hjzd+wigu7g
         VEJmps78OAcb7etGOdXwdX4JI5tkxC6asJaoAXkr4YxuS2IJI+SCpYNE6oYB7n90hYoH
         vZ7yE9bKVjJx4FZRv1nsgvjkhckh1fwaitUI4o7lMUpxyuxq1Di4MVcKFg2AO/kaaXDe
         0hhFphA5gMsP/Ry1Ohb1VDrce+Atycs/zVQS/0KAMAGHR7AnATM1HYW2Q+mYhYm9bb1F
         QqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vJsCws3FamyI5nwIu6NR9CwJlE0an5auOcy5PUi3Br4=;
        fh=WCOiNkKcbPFc5hVmuZyC+CtDgsKddGMW3P87HCroPhA=;
        b=KFJshFaKtoEnvvHigQZzfnvhHYLacs8exwwYoe2auHpmjidb0SgfuEIhSs65aSSSfW
         fPO/05e/NXJTBxQAsJZfu2KNvMTnNuvHW6gXUzkLuoKCNkp8pJZzg7Qo4kypLawTCaI2
         pqX2/9FIjwx4eGBH9rgmQK4DFdN4ZkpJ0Igz2/CwGQDjKytjsR04RPVSPHi12ve44zjl
         3h9JR01tTLVAW/6D4fVLw5MUs+xwfWR/dlEVI0uaip/xsJfvr45i4HFBSC1iKJVTo2Rr
         YObfmrsNDRueO54CY27od8d6SF7xHWVu3XEwY7neHrQunMPIEHtQ0j4fudo/MBgotKs7
         yGZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789511955; x=1790116755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vJsCws3FamyI5nwIu6NR9CwJlE0an5auOcy5PUi3Br4=;
        b=rxyFWca/nEoQjYXMPfAHyf9F1FN3x7rz6dtzEER14eDiw4UDqHIY7juAsfbLvmbPmJ
         TkDG0O2fJ4T/8b/PM7X2oHanauKcsNZFL+/1C+IBusrmvZP5qtYyTRey1vhqFdIyIzGV
         4dwM3FCfXXVPiqyqDkz92vVO5b169ErAe+Gf8uKsj7yOvBDnCxCqYnVbW+MzxwzddyhT
         tH9xI6GNS3A/qwOPzIVt3mWJ/xizDXVAPsbfgAWkEBOjnu90Z0L5ShniO9r/F8wpLbxS
         E2edOgTa27PKYtmnnDYuMkkuSzbwMlqwza1WkEL4Io3+palVNcRZgYe+WUkx9JeikXu/
         wGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511955; x=1790116755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vJsCws3FamyI5nwIu6NR9CwJlE0an5auOcy5PUi3Br4=;
        b=cn2kEH+zdnD6aOx8q6DNs6vQRpFD61H4zhLJ8M1TCbzZbBXFgzjS/O9G81AMSSedQk
         IFBUFzXSoSSknXm5AXGCTKw8dl9yFkb9Is5g0/EUXqDar4FH97Ilr6cvHFTKDKOB26Uk
         HIG2V15+MyTH8vMtjnmUlCsDQtKuczxCj0LKoKrFQ88AcaCyg5Vh6dO9TDj0hyQgBXQR
         K19hegsIzlzUf6nx2DDkZGZn8pU9WDaGVxy28OhAniIEcnLmNBKV/zrRjPlW5f4BmZsG
         IJuC9n7I7BM93/dbR9KXKtea+O+g+Z6C+AcM6NkhSRTqi5wRjMiffNRbdQr1Jz0r5B10
         16vA==
X-Forwarded-Encrypted: i=1; AKwUvBza5zV3V2Tt7anCtlD0FXlEHlCdpp3H2Ap/syUrXDnuws/Z8ZWi1dj0vD9Yv73MIFpB9IYYmiQbhqlUa3oO1KIa@vger.kernel.org
X-Gm-Message-State: AFuF++kZ49K6HDMI6bsw26Y14KhHvxW0yhahpsRZR+md947qbllgGEdW
	PEONN19GDhbd0G7ujSdXzd0POh/mA4B6ltQuFBqbkKTZO9DowNfhLFd5sAuZLVf6t2FlG12YMdW
	d0e/eXIkT7ZeYbo20M3zrti+kbqb2qTE/OejXBR5N
X-Gm-Gg: AYBFou1DjVOnUh0ozhF3nkVal8YnEo8FUEYPdsymzzKQX397pNfgUXEmy77DJDWIouv
	XXEasWoyWRDHGspKSfenMtzb4Y5ZcpYrTEHuUEAYCjQlsegqVGxH7Sjhrbt1UbUmRUxF6WArE7q
	6fVkyWymXzr7x3iWkWtBC6iDbXyftTfrKtSZRjOntsJfWkWZspjaI0bTx4dffKzzYvpXud2wVq3
	BCqz+YpTRrwKWTrgcsfmcl0G7PYzL+ywwZGRvKG/oFcT8M2SXVRvVAXCbQI0zRot+OxsWf3wpjx
	yViECTP/GaDg4VjJ19u9fTxczMEYP46LjqebJomhMkdmds0sR6wLvoUgbCVtsgcFV0Ny6cvY/TC
	5kMRgtWDH8JfNurXkzZDL
X-Received: by 2002:a05:622a:4d8c:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-5327ed8004emr2058291cf.4.1789511954807; Tue, 15 Sep 2026
 15:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810133540.1947118-1-puranjay@kernel.org> <4f755a7f-0a55-4292-892a-28346ed235a4@huawei.com>
In-Reply-To: <4f755a7f-0a55-4292-892a-28346ed235a4@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:39:03 -0700
X-Gm-Features: AcwNN1VJtEici--U7gAI-B9LpTV32UhMFNQSbZNGUEhTbibENqFgMN18MX5xm4g
Message-ID: <CAP-5=fUepMzyctDcUqYNJMG+xBOK0bdUF_cXPtQ43AxfFVL+Zw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf/core: sched_task() dispatch and branch entry fixes
To: wuyifan <wuyifan50@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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

On Thu, Sep 3, 2026 at 7:45=E2=80=AFPM wuyifan <wuyifan50@huawei.com> wrote=
:
>
> Hi Puranjay,
>
> On 8/10/2026 9:35 PM, Puranjay Mohan wrote:
> > These three fixes were found while adding BRBE support for
> > bpf_get_branch_snapshot() on arm64 and were carried in that series unti=
l
> > v6 [1]. They do not depend on it, so they go on their own; the version
> > number continues from that series to avoid two numbering schemes for th=
e
> > same patches.
> perf record -C <cpu> -b [<command>] triggers a NULL pointer dereference
> in armv8pmu_sched_task().
>
> Commit fa9d27773873 ("perf: arm_pmu: Kill last use of per-CPU cpu_armpmu
> pointer") changed armv8pmu_sched_task() from reading the per-CPU
> cpu_armpmu variable to dereferencing pmu_ctx->pmu via
> to_arm_pmu(pmu_ctx->pmu). Meanwhile, commit bd2756811766 ("perf:
> Rewrite core context handling") made __perf_pmu_sched_task() pass
> cpc->task_epc to pmu->sched_task(). cpc->task_epc is only non-NULL
> while a task context is scheduled in; CPU-bound events do not schedule a
> task context, so cpc->task_epc stays NULL. The NULL argument is dereferen=
ced
> and crashes.
>
> With the patches applied, perf record -C <cpu> -b no longer crashes,
> and system-wide perf record -b -e <event> -a alongside a task-bound event
> on a different CPU runs without any WARN_ON.
>
> Tested-by: Yifan Wu <wuyifan50@huawei.com>

Hi,

Is there anything that needs doing to land this series? Avoiding a
perf crash seems worthwhile. I believe Peter and Ingo are best placed
to review the changes to kernel/events/core.c.

Thanks,
Ian
