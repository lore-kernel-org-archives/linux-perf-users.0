Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F928E0F
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124058; cv=none; b=Se6laUKv4MscK+keHA5VT3B6q/EZgvNEXoDjRLrDOhbDUAOhO2FM0p+CGLGY55X/X+65vkNShrSFzUBtNjUSsHvyG1SKg1q5PJPjsbPN6uPY6mMcojkso9VUF/KvHCprS5yrZzVy7vgcbalcL99lwK7YCPsGLgPoHuIbUc3bUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124058; c=relaxed/simple;
	bh=l+Bbr5zgMrvRyMwXeAJsfgNlRx6rA3ODHm82hDoI7PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KY/0mze3Fm4BbgehFIwQ+//QhvJDXaOlyPGbkICUY8f5uwbprlk7GazGUcMGla6xqXl/vur8oRoPwYY7ItFfDO1/ktWcd299patFrJMm/JaRUQMxUM+Oyw5cb7HsogxfH4r8lcCDgDarHLgEKiwWBXebGO9vJjYW4JNmNDMGAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuE/Iowj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuE/Iowj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297e13bf404so104055ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 18:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764124056; x=1764728856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AfyTSLxsENf/ESlVNQYE59WjUSDrJkKq+u96c91FR4=;
        b=BuE/IowjM8pmHkVS/dlerUg10l0iqDH4ssC6KmnaHVqbUeH8TgDKBdh6Th+WT1EPBu
         +8fCqVU07vTveDsp8RfVa4bJtn7SMDsHDfS6QWQ4WDv7xeruyOSlt1vQULiYFn/NIAzF
         pjFVptAQCjBsOYSP7MHOV2bHqYiM26uhX9jtI9w8fsgCNs2ZiYOCRV84NPlyNe7CuPte
         1ng6H5EnUQBbhBhqunR7IwB1ZFsKm58L6fwPykhWAQejiGzjeqTuczfUjf2Oci/q9fRe
         9gPaiweUGqH2ZUrlYq+D56/8vrqFxPhTgnsSBJwuKXovtt+yHgJ6aOA+dpscIgFYJ3Kb
         OSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764124056; x=1764728856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3AfyTSLxsENf/ESlVNQYE59WjUSDrJkKq+u96c91FR4=;
        b=fu65vezAn+3dxOhJCaRAWaxXqdf/K/g3CNXIldNR5BAlpK9vfLJtt/YN0mH5CLXHSJ
         b07majWuIisrSNs92YBMG34UlW/kqm1MXhmc6ZtNvmVuMioFPfBIOdCMw+VWDtkw5+BK
         3XdOxlNm6BOpyp43XLmWJEpt9oVrKoGyNNEZy6JS+k7auaFMyK23rvAc0sete1Qv9RPF
         xhH/1uFusGzlH+V8BjJRL466YWH+EpCAEjlIPAi+tkmYMbcymF6oxk9VyyxjUSjX3OcQ
         zgImDVmFnYytlWV7eg+a9i0MWjIqQN0I7UQoDAJBpAQNhTp7KGEwSmCRErhSJznIpSNJ
         ljsg==
X-Forwarded-Encrypted: i=1; AJvYcCVrnYD5IJm9NPgcWsWGUW6goBlBbKtL3F90TsFQ1FH5KAd/2uqfLF7bRN3xTNcs3qlUFxkw4mUbE8p3sfpxa5DW@vger.kernel.org
X-Gm-Message-State: AOJu0YyowpvvkyPGftkwbEZYdCJVVIP0Rj1te3cTwY7T4G4fpnA7aAju
	7bacFGAqKZVsZ28d7mgkuV+kg5SYhSyLbIrIss9eK74ysrPDwfIZn/tKytoF+Nz/5aK+xjS4vDP
	nz71LIHFuv9J7J3OkjD7zbtl4APEkF2HHtzIz9GvInR8d896e54E8Yov8+Tk=
X-Gm-Gg: ASbGncsyuprd5Ffc8LaG9Qz0yOIE4uygooAqTESe4D6bYp8GrbLC2YMjrcSRffB724M
	aFPqgjMndzga/KDYSjW3Gr4XmOW2F7Bzn/5pq2rytYQpgAjM9rAUeA1Dq9AtG4hywfvGM+5wta7
	wFYkWOkCwNWwmJJVnXIU5AtkHvKbr0klXY3r4GT8kxWgbptANNWNVGJFq4iAL/wWo5dIygn+GjX
	oqwec2zExKlJrVW2yRWsP3jn8XuJsAvnajGQW2ByvmJyiksy48S9DTyuTPEf6wGrrFtBSperZ/R
	NFzfi1A=
X-Google-Smtp-Source: AGHT+IGhtZfRQkAQfRD+HQDWYpS0KOqBkcd+E1vcSInN3twS9evj3f+CnU/9UcNMyVsw/sZspK9k88TXojmZnxXBY4A=
X-Received: by 2002:a17:903:22ce:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-29bb8f51558mr1678465ad.2.1764124055842; Tue, 25 Nov 2025
 18:27:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114220547.496562-2-irogers@google.com> <20251125114118.196089-1-ashelat@redhat.com>
 <9efbbdad-c7d6-46ac-89f3-6ed28533b85c@linux.intel.com>
In-Reply-To: <9efbbdad-c7d6-46ac-89f3-6ed28533b85c@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Nov 2025 18:27:23 -0800
X-Gm-Features: AWmQ_blYbDA6mFfPRsrO9Pv4aigd6KQwY0d_RrilFwT8m6O6ja7OFVqQtLrlbj8
Message-ID: <CAP-5=fXP66bNcm26MGD=7stHW56Eq3=3iYejgYKG_jZsyKOS6g@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: fix duplicate conditional statement
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Anubhav Shelat <ashelat@redhat.com>, mpetlan@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, linux-perf-users@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 5:33=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 11/25/2025 7:41 PM, Anubhav Shelat wrote:
> > Remove duplicate check for PERF_PMU_TYPE_DRM_END in perf_pmu__kind.
> >
> > Fixes cedf1f4852ae.
>
> The code change looks good to me. But the offensive commit hash ID seems
> incorrect.
>
> The change comes from this commit.
>
> f0feb21e0a10 ("perf pmu: Add PMU kind to simplify differentiating")
>
> Better add a "Fixes" tag for this change.

Thanks! I think the fixes tag should be:

Fixes:  f0feb21e0a10 ("perf pmu: Add PMU kind to simplify differentiating")

and there could also be:

Closes: https://lore.kernel.org/linux-perf-users/CA+G8Dh+wLx+FvjjoEkypqvXhb=
zWEQVpykovzrsHi2_eQjHkzQA@mail.gmail.com/

as well as:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> >
> > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > ---
> >  tools/perf/util/pmu.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index cfcaba3e2e75..723a67cb41f4 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -331,8 +331,6 @@ static inline enum pmu_kind perf_pmu__kind(const st=
ruct perf_pmu *pmu)
> >               return PERF_PMU_KIND_PE;
> >       if (type <=3D PERF_PMU_TYPE_DRM_END)
> >               return PERF_PMU_KIND_DRM;
> > -     if (type <=3D PERF_PMU_TYPE_DRM_END)
> > -             return PERF_PMU_KIND_DRM;
> >       if (type <=3D PERF_PMU_TYPE_HWMON_END)
> >               return PERF_PMU_KIND_HWMON;
> >       if (type =3D=3D PERF_PMU_TYPE_TOOL)
