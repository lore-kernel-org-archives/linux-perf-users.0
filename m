Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2616DEB1
	for <linux-perf-users@vger.kernel.org>; Sat, 27 Jun 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525006; cv=pass; b=KX6zj2S8h0jp3pkLV9mGB8g3FlhroWSYlAClVDwnhcWM4QRZB6deJw366XU61FdO1lWuvTokuovE6yNXm00JxvBVd2932K1TzRadaxXRTmB5/Lji2hZFD01xraoWcehF5Vck1dbK4k//jL5DXsdq6/Rulf/rLd9dOPjEMjiYLmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525006; c=relaxed/simple;
	bh=28SzcZB63EPANLQAGb5GhL6Vgwx4XoM3Z6Z+icV3TBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boMou+npEBOFU3axDgFVOCx93mT/TLUcb/Vx7jg0S9p0RQvopbQE681zQBoPVtOIH2soKWj0P7Cnw/L4c8ZmmrFBbgygfkpgsjB1xxg0rw3tyg8ss/90aHAH8S8CCMN9PEf1ZEgEi4K1sNmBAg8oLwyhHeSAadSAG9RF7+5ftrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdjoS/wj; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdjoS/wj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso2025ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 18:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782525005; cv=none;
        d=google.com; s=arc-20260327;
        b=ZvN5TnHWAyvdJRQjXwESb3SgfO3KUGBlFni3PN6JW2IAWhbobccjgWdJufQvhy+AfZ
         SQVWc1Y7OVhV/khSpfBdWdMgC0HvmNGjm77mALd+sUS5Y1cb9vIiEpTtslQKliu+U3gK
         fiDTZohGPFiRihEFiydLa6JuOb2eZBKCsoYZKhgroEd55swu4cbkHUznpVn5ZUXWggwG
         AG25L5inM5GBSV9O/Dl1X6T951uvzZjBfsXq+UFKHYCkrwol5Aa9Und4Xza27qyp6KGT
         2g3lduR8D+dxzlcU+bWTxW8C5eUhoQXSAxHzrFN02+Wod2EB659H/YQEGq7pPhfWtcH7
         bqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ry0pIlmRrwoIT1artIhbtGBHW8BSI1ot0gUlYplyYsM=;
        fh=Nfcfnc6llN6k49u4tpG3NcotVK1JcZQHjaHIqDSRiqE=;
        b=FrZ8H1RTsbpZqnahAuRJq89G9EP0U/ZY5wuhopqjhw6zknXPe85+4gP0udmrBSuK0k
         8GeYrd2YemJqoNcZOvLBeaQ3RMcZhuHqFcXQPt7kzHJr6v15WiQMPJsNjmw15xLN+w7i
         oE+T7qQ4yDkh5osVswh5eFVMSLb2dVc7Pqk1xWOi2qezb3i+KJxCBscZOaGgiRRLb+9N
         /LA8xh7W/a/WqumGeZ60geVWm/00oj3muTGvcHTH15pF97oFiT7nWeNKtSiFBcWFNsbG
         6nzLPav92vQ+BNmfKgUe9mkjnOB/yILw9Ex6+zrxsoAwc1wQvBfVWwySUeoL6lc0dCP5
         ANzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782525005; x=1783129805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ry0pIlmRrwoIT1artIhbtGBHW8BSI1ot0gUlYplyYsM=;
        b=HdjoS/wjU9Au8RvmnA2yqmvMP8UPGmqsD5Pa6oB6nxVrTZ4bo7oRo0Rn1NwJ1gSJcW
         qoKm5pR54XQeQ0EztYl0ZnimhTmpjhDvuvpkgXmpi1slGjjneHuLIxuHoRBF6UL+bBs8
         8o3NbZSEmf64ZQ1Urna1dOChnvQSC2iyokoq8BsG11qwcdx2sqz/0ruEw9i9KVq0ZTpV
         MObhNGoX/UG/nbgiTemibiId6csU1gqfp0jvpMEOPKQmC2ljcyrX/gEXDw9G5peCMsjO
         vs9lyH4mmh2+p/UQQSMotYW7/kucBnyEttYXDoioaTnWI1WUWPlBapya0eGfpqwauDl9
         chZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782525005; x=1783129805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ry0pIlmRrwoIT1artIhbtGBHW8BSI1ot0gUlYplyYsM=;
        b=Jguaj/hzDkwGL9V1M89m2DdOPBoCIGi/FQdaiZLc6GlCshPIpLJS16NvIsz3y0GRTJ
         F4/HXc0X9gZUY+Tu7vcBhkjN2lQsWyOoH+6FiLx03z+lfSsDA4gf23lT7QImyMEvt+rf
         VZTBaTVUTcGpsV1e4kO7PMpwBLq29i7VselFncRBgKQVeP082CpphjnUM6+837HGWPDP
         w5ye5q+H4f3oCNGusYWkOsgmXh1Uh6YsDKaLz8UBSdeJNe3KwCQ2wVTTck2rYQQA7RDQ
         aM5oPQbZ3VNa6yd1F4A2sg4bK8IeC0AtwTXgCRYkldZRxX1d8G61qY0zesedPfAOaysU
         xGzg==
X-Forwarded-Encrypted: i=1; AHgh+Rpho9ziqIIuPUJrtECEyXNi0f6CRHeJ1pfwgWuM54CYsZAJVKYMax2lfroNZsBjPr3Om1KRZ3zWUwybk7p3wriL@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEcykPb65iENOvNHVL0PW6RauP8l1GTEaoOAQrHM5UMjH4LDc
	Vhd70fKVtTt2KY9x9fQj3FbrckD+auPY5aCmI/6UmL8nN45k89Y27ECdIdBx6HUlpcXTiVpt8c3
	890FssqtWHOX2vYj3aBIotsdOam7S/QHXid9A+Zfx
X-Gm-Gg: AfdE7cm3i/ezvxiQUK/wz9TC7Uatmi8NE4mVhiYhW6DSrlxXAx2mdGCc1riFGTjchDn
	szgS4crq+2/OH5KJaTqHfMg3hE/ywtxVkirm7hyjtrSxq/AAzw1VYGx0CQZmZS5HzBZzqpfigPp
	MQjqgEGZMbwxTLC7rA6RPII0Gs0LCYJ4zyRNLZKVR+ZNHxKXZpQsjzT6oDkLrGmyedxGahYiqnH
	hpW0kc69N6haAq/RhgdCmF2jTt6TAz6uVLcpSVPaaZ4AqEIAuNGufWd3VFMfWjKKLxmdbyeBw==
X-Received: by 2002:a17:903:184f:b0:2c6:cbcb:bc72 with SMTP id
 d9443c01a7336-2c9ae78a3c0mr978305ad.23.1782525004208; Fri, 26 Jun 2026
 18:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612012413.3253516-1-irogers@google.com> <26291bce-9be4-4edc-9dc5-4c685d9811c8@huawei.com>
 <CAP-5=fWY35hNSi8uNjX95TnDMmC3Pek9B7Yaf6Ax0ty_6ZtmCQ@mail.gmail.com> <a9f25a27-5f71-4d64-a42c-ef9c7ed8107b@huawei.com>
In-Reply-To: <a9f25a27-5f71-4d64-a42c-ef9c7ed8107b@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jun 2026 18:49:52 -0700
X-Gm-Features: AVVi8CfuH3pKbrkcfAdpZxtxEb-BDBm6Fri-r3mT8dvEBOzDdvUe-2s7L9-LpdA
Message-ID: <CAP-5=fUrRvBuJ93e=QzDrE9OiVEoOQng_WLRU6wr_iF_r40Hzg@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Recognize default_core as a core PMU in more places
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 11:22=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> =
wrote:
>
>
>
> On 2026/6/23 01:53:52, Ian Rogers <irogers@google.com> wrote:
> > On Mon, Jun 22, 2026 at 2:11=E2=80=AFAM Qinxin Xia<xiaqinxin@huawei.com=
> wrote:
> >>
> >>
> >> On 2026/6/12 09:24:13, Ian Rogers<irogers@google.com> wrote:
> >>> The python metrics code used in places like ilist.py passes a
> >>> pmu-filter of "default_core" on non-hybrid x86/ARM/.. systems. As a
> >>> PMU like "cpu" isn't a literal name match then no PMU matches
> >>> "default_core" and the events fail to parse for the metric. Fix the
> >>> name matching and PMU lookup for "default_core" and check that it
> >>> fixes ilist.py.
> >>>
> >>> Fixes: 74e2dbe7be50 ("perf tools: Add --pmu-filter option for filteri=
ng PMUs")
> >>> Signed-off-by: Ian Rogers<irogers@google.com>
> >>> ---
> >>> Note: this bug is in 7.1 but it is a little too late to send for the
> >>>         release. It should get picked up via the fixes tag.
> >>> ---
> >>>    tools/perf/util/pmu.c  | 6 +++++-
> >>>    tools/perf/util/pmus.c | 2 ++
> >>>    2 files changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >>> index a550f030b85d..836e3b5615cd 100644
> >>> --- a/tools/perf/util/pmu.c
> >>> +++ b/tools/perf/util/pmu.c
> >>> @@ -2660,8 +2660,12 @@ bool perf_pmu__wildcard_match(const struct per=
f_pmu *pmu, const char *wildcard_t
> >>>                pmu->name,
> >>>                pmu->alias_name,
> >>>        };
> >>> -     bool need_fnmatch =3D strisglob(wildcard_to_match);
> >>> +     bool need_fnmatch;
> >>>
> >>> +     if (pmu->is_core && !strcmp(wildcard_to_match, "default_core"))
> >>> +             return true;
> >>> +
> >>> +     need_fnmatch =3D strisglob(wildcard_to_match);
> >>>        if (!strncmp(wildcard_to_match, "uncore_", 7))
> >>>                wildcard_to_match +=3D 7;
> >>>
> >>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> >>> index 5e3f571450fe..e0a4cb2428ca 100644
> >>> --- a/tools/perf/util/pmus.c
> >>> +++ b/tools/perf/util/pmus.c
> >>> @@ -150,6 +150,8 @@ struct perf_pmu *perf_pmus__find(const char *name=
)
> >>>        bool core_pmu;
> >>>        unsigned int to_read_pmus =3D 0;
> >>>
> >>> +     if (!strcmp(name, "default_core"))
> >>> +             return perf_pmus__find_core_pmu();
> >>>        /*
> >>>         * Once PMU is loaded it stays in the list,
> >>>         * so we keep us from multiple reading/parsing
> >> Thank you for the fix, Ian.
> >> In the previous patch, I overlooked the handling of the "default_core"
> >> alias. Also, perhaps we can leave need_fnmatch as-is, since it doesn't
> >> seem to affect anything here.
> > Thanks. I moved need_fnmatch's initialization just to save some work
> > in the "default_core" case where the value is unused. While leaving it
> > in place would reduce the diff, I think the optimization is worth it
> > as we would otherwise call strisglob when say iterating all metrics.
> >
> Perhaps we can do it this way=EF=BC=9A
>         if (pmu->is_core && !strcmp(wildcard_to_match, "default_core"))
>                 return true;
>
>         bool need_fnmatch =3D strisglob(wildcard_to_match);

Unfortunately we require variables to be declared at the top of
blocks/functions.

> > Would it be okay to supply a Reviewed-by tag? I notice this fix is
> > missing from perf-tools-next.
> >
> Sure, add my Reviewed=E2=80=91by.:-)

Thanks,
Ian

>
> > Thanks!
> > Ian
> >
> >> --
> >> Thanks,
> >> Qinxin
>
> --
> Thanks,
> Qinxin
>
