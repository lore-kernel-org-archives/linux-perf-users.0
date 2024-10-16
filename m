Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333B1885BB
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105505; cv=none; b=etj0ejaLfd6eEFMjLMhirQ1qX8SWw/lxzcmFau2H/UlvDNkTtQX9P49hajQ7F2MQqPSCnZEcxS1wAQ4lwFPZtmP4STcG9xNQQfRLP0K6TU7DU+XxDqPN7itavIrJB3EWVr7QDfFGpAdUzIWliFcdK1q3SLWqLE+KieSHxvgQA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105505; c=relaxed/simple;
	bh=zRQ3X1yKrhjM9MjxEnBO8bVsZAz/MNAO5jq9d1cT2ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/4Ph5I7r4KvsaKP/C7JYlEyT2Hj/aM35Zx5IJmD/aURzdL9yKn9VKE0NowDdq3R6RXddW2pe94sURDU0KYJ8Au0XtqF+hLEo7ijfMeIF2kFY3PaepDp5laZow/juSjl6YgaHNMeRBwAtyVvJxNS7J3xGmQuGcbYxYfD29TnGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mP4Chxyp; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mP4Chxyp"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460969c49f2so48011cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729105503; x=1729710303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7zRfX4mGGXxSTxvTu2G9/F4Ncm83GwEzwpAfcljlS0=;
        b=mP4ChxypLrtuQQoBzoJhzMi69CwBfWDuLeSedFjBSBnKNFX3Nh9QBOhwXnglHN1DRF
         mC0qZWOK3BmvTq8b1/gAuFbx/NuiAjp3xG5V7mScBaov96I50UlFF++HbpH5rzx5q6Ne
         JLM+NRhEam3Qzb3hSWokYZ8c8wDu8ihGWhe882kvoWl/aNNKl+5hoeQjJS2oLkgMc/W2
         uK2eo2wjVoLrqQOCUTYQo+MDfhF2SjZuILngw1/lbSXlDUZ8OnYo43c/fnXsNT/x5DhZ
         cY/7x8dny4I6qwkRZUOAdR5FPM5tKm8OtHKfb6AfxjWLCF290mq+VQnm72XDOYCcs4oA
         FFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105503; x=1729710303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7zRfX4mGGXxSTxvTu2G9/F4Ncm83GwEzwpAfcljlS0=;
        b=bw4sOBsy2wOaYJNX4Wvcy52bOZ9FMMYMGaXTrmRh7v4GfUg0iPyB8YHHhwVnP/ki9u
         h//DibviJt/SQyGAKpP5E5iTCqBOTzNnQCI7IydknDIaogZsj8rmSsemEyy8nWnkffw6
         xa/k6ruEhTgM/LbKfLb7Fw1JpQFOjQ+wEMgkcKin/GqFKIH9fO+VakQln5Q1/c8WILoV
         AbG2AlSoCnmLXM26WBBfQ1oJO9MGKL7CsBGtDgghFRP77AknUf72vKTe31m54YISrAFM
         dnvwzfL6QQVyJa5VigwvKxznRbzcQmagb5g1OSUwyPvPcJyqGQpjARrpmIU2AXw4d+81
         NI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+EpwnrwTf6GVFGWE34PykWXMwcDGfaN+jDFp9xMq5aeJLBTsWHm/VVo+pE2PjD7CDYrVkxzsVCs5RRjpqDTMe@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUC57cfXliTGpAuFwm5S/Lt840bVtU2E9qZy3hmIpoIcbgUx/
	CHMswRkZAnGh5P4KPbd0KFDgBoncLmFTpgOzoddv3McBR2Bh/phhqvn9S79xSxwf9yECKbUMDY8
	jxq+K1VPeeGO+u5CPAlX4MZLW4W5mmqqbwitY
X-Google-Smtp-Source: AGHT+IF6yT/3DZPUJjVREQ085mlGzCKYggvS44niMjh+ismHxC3q3Agj0jop5VQ9GGNmLz4ZIwzzoI848WEnMWOHipc=
X-Received: by 2002:a05:622a:a709:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-4609c8e1bf2mr479661cf.26.1729105502801; Wed, 16 Oct 2024
 12:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>
 <Zw1UXbWTS9Gk3lmw@google.com> <8B5B2251-E41E-4584-881E-61A468AFB222@linux.vnet.ibm.com>
 <CAP-5=fWQsQp3WgJcLvZWsBsiJ2VzxP6j2kOfd5Hrzi0oBUNy2g@mail.gmail.com> <E64BA2C9-3046-4C96-ACB8-A4F0D99BDA40@linux.vnet.ibm.com>
In-Reply-To: <E64BA2C9-3046-4C96-ACB8-A4F0D99BDA40@linux.vnet.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 12:04:49 -0700
Message-ID: <CAP-5=fWEkpxsUkX_o_wMjkn6rvwr81oGPJ=6_85Q45RZhqXUng@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Fix compilation error with strncpy in tests/tool_pmu
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:23=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 16 Oct 2024, at 8:36=E2=80=AFPM, Ian Rogers <irogers@google.com> wro=
te:
> >
> > On Wed, Oct 16, 2024 at 5:30=E2=80=AFAM Athira Rajeev
> > <atrajeev@linux.vnet.ibm.com> wrote:
> >>
> >>
> >>
> >>> On 14 Oct 2024, at 10:56=E2=80=AFPM, Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >>>
> >>> Hello Athira,
> >>>
> >>> On Sun, Oct 13, 2024 at 11:07:42PM +0530, Athira Rajeev wrote:
> >>>> perf fails to compile on systems with GCC version11
> >>>> as below:
> >>>>
> >>>> In file included from /usr/include/string.h:519,
> >>>>                from /home/athir/perf-tools-next/tools/include/linux/=
bitmap.h:5,
> >>>>                from /home/athir/perf-tools-next/tools/perf/util/pmu.=
h:5,
> >>>>                from /home/athir/perf-tools-next/tools/perf/util/evse=
l.h:14,
> >>>>                from /home/athir/perf-tools-next/tools/perf/util/evli=
st.h:14,
> >>>>                from tests/tool_pmu.c:3:
> >>>> In function =E2=80=98strncpy=E2=80=99,
> >>>>   inlined from =E2=80=98do_test=E2=80=99 at tests/tool_pmu.c:25:3:
> >>>> /usr/include/bits/string_fortified.h:95:10: error: =E2=80=98__builti=
n_strncpy=E2=80=99 specified bound 128 equals destination size [-Werror=3Ds=
tringop-truncation]
> >>>>  95 |   return __builtin___strncpy_chk (__dest, __src, __len,
> >>>>     |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>  96 |                                   __glibc_objsize (__dest));
> >>>>     |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>
> >>>> The compile error is from strncpy refernce in do_test:
> >>>> strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> >>>>
> >>>> This behaviour is not observed with GCC version 8, but observed
> >>>> with GCC version 11 . This is message from gcc for detecting
> >>>> truncation while using strncpu. Use snprintf instead of strncpy
> >>>> here to be safe.
> >>>>
> >>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >>>
> >>> I found this issue now and thanks for the quick fix.  I will push to
> >>> perf-tools-next soon.
> >>>
> >>> Thanks,
> >>> Namhyung
> >>>
> >>
> >> Sure
> >>
> >> Thanks Namhyung for pulling in the change
> >>
> >> Athira
> >
> > Thanks for the fixes. As this is test code I don't think performance,
> > style, etc. matter much. The GCC strncpy warnings are annoying imo,
> > I'm not sure it makes sense for them to be enabled. I see in the
> > kernel lots of "sizeof(foo)-1" as a workaround. strlcpy looks like a
> > better alternative but it gets a checkpatch warning as in the kernel
> > strscpy is preferred. Perhaps we should create a strscpy shim.
> >
>
> IIUC, strscpy is defined in kernel source and is currently not used in to=
ols side.
>
> Ian,
> Your point here is that we can create an interface in tools side so that =
we can later safely use strscpy in cases like this ?

Yeah. Tbh the string code is a bit chaotic in the code base. There's
some stuff using char*s, some asprintf, there's strbuf then there all
the kernel ways of doing things. I lose track of why strscpy is
superior to strlcpy, but strlcpy will get you a checkpath warning.

The standard kernel solution to the GCC strncpy warning I've seen,
changing "strncpy(a, b, sizeof(a))" to "strncpy(a, b, sizeof(a) - 1)",
looks dodgy and possibly worse to me. The point of the warning I think
relates to strncpy not necessarily \0 terminating the string and you
need to reserve at least 1 character for this, while strlcpy
guarantees the \0 termination. Doing "sizeof(..) - 1" likely confuses
the checker making it give up, but now you have less space to copy a
potential \0 as well as not getting a \0.

Thanks,
Ian


> Thanks
> Athira
>
> > Thanks,
> > Ian
> >
> >>>> ---
> >>>> tools/perf/tests/tool_pmu.c | 2 +-
> >>>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu=
.c
> >>>> index 94d0dd8fd3cb..297cc8c55579 100644
> >>>> --- a/tools/perf/tests/tool_pmu.c
> >>>> +++ b/tools/perf/tests/tool_pmu.c
> >>>> @@ -22,7 +22,7 @@ static int do_test(enum tool_pmu_event ev, bool wi=
th_pmu)
> >>>> if (with_pmu)
> >>>> snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
> >>>> else
> >>>> - strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> >>>> + snprintf(str, sizeof(str), "%s", tool_pmu__event_to_str(ev));
> >>>>
> >>>> parse_events_error__init(&err);
> >>>> ret =3D parse_events(evlist, str, &err);
> >>>> --
> >>>> 2.43.5
>
>
