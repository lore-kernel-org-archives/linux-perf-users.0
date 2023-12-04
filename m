Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFBhUIu0"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB95D2
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 12:13:07 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bf09be81bso555e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701720786; x=1702325586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9kGZqvqwnAsTmmtCc59WM+PziDt3Qkd7uQA+xA4AAo=;
        b=aFBhUIu0xKirXnUqGlqydjhbVw8N4DoS3WTRzox1BZ+jQ5YLrcd43JkL9mVkXPTkQU
         RbTKCD8AuzKRqpTfa4xx+1HcmYOSw1qRfnFjLdWl8gc5OzmYmIJTd4v6POqi8gJsJ78R
         xC89l+3IlVMJcMan2kZfCwTy/1uqVLFJoEo6Bz/pHpMhdS8pk4VJleORmG3ygxRptpu+
         4YiewIA2TIyETK/AfkyFCiTmBewa5TdbI4EkJyWZ/mjf2jGMBAF6hwhZKSy2zUbF/S8v
         OOsO4Jly5h8PmZhzY5Y3nqG/c5m8rW2Q6d15Qwt0BtWT5FTDvX61DD2KqS6vf1aHWJOF
         Kqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720786; x=1702325586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9kGZqvqwnAsTmmtCc59WM+PziDt3Qkd7uQA+xA4AAo=;
        b=BadJqp3vBaBn9LJhMyNREUlagozgIJ2Uhv6XmwSC+spdq1ZmMUGapAfvxtDCYYV5qA
         dBCgfK+o74B+QgSyZDrjC78joPGQzDfEz1y6+0gQ9RQBe4uNQ68I5ajvmAWuybE43LSI
         GMwl7rWWZCobuBWL6X7ilHbyRnADnnzRstGrxN262HNsUV16fDaowzzOsgEoyJ5TNiuN
         Ead/XDcUKY0+16+SOg5yuW/SbRJOHsgfiAbNZzdxHz+OJ1owvZNFCeCXo2TsEhEze4Ot
         Ngh5H6DvCSmHk5xQx7RlXAEbRT+Xmxs3o2i//8T7Xk4lryE9frrRD+oE2qZFw0KdRADQ
         qa/Q==
X-Gm-Message-State: AOJu0YwO4vH16KNRFri+JtnFEj+Oag2SnmQDWtUqS3QgQQKgbk4clBkH
	Auz+UaMLBcBU0gpH6VfcbRnDgl0brm6jaGe7I0+lAQ==
X-Google-Smtp-Source: AGHT+IHF8bG8tbqf9FFq+JJHa/Dth4bjMhx7Y0kGbSLDJNQXgYURe7388W7P4mZSqcttbSOuxqa4cWvGazhi7p3o3k8=
X-Received: by 2002:a05:6512:b9f:b0:50b:cdd5:b54a with SMTP id
 b31-20020a0565120b9f00b0050bcdd5b54amr300836lfv.3.1701720785882; Mon, 04 Dec
 2023 12:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123160110.94090-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20231123160110.94090-1-atrajeev@linux.vnet.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 12:12:54 -0800
Message-ID: <CAP-5=fWtLHCyZh_6hBkCg16ekOXfwSGAVT9xvgKcUsMcu=Ou9w@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events: Update datasource event name to fix
 duplicate events
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@arm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 8:01=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Running "perf list" on powerpc fails with segfault
> as below:
>
>    ./perf list
>    Segmentation fault (core dumped)
>
> This happens because of duplicate events in the json list.
> The powerpc Json event list contains some event with same
> event name, but different event code. They are:
> - PM_INST_FROM_L3MISS (Present in datasource and frontend)
> - PM_MRK_DATA_FROM_L2MISS (Present in datasource and marked)
> - PM_MRK_INST_FROM_L3MISS (Present in datasource and marked)
> - PM_MRK_DATA_FROM_L3MISS (Present in datasource and marked)
>
> pmu_events_table__num_events uses the value from
> table_pmu->num_entries which includes duplicate events as
> well. This causes issue during "perf list" and results in
> segmentation fault.
>
> Since both event codes are valid, append _DSRC to the Data
> Source events (datasource.json), so that they would have a
> unique name. Also add PM_DATA_FROM_L2MISS_DSRC and
> PM_DATA_FROM_L3MISS_DSRC events. With the fix, perf list
> works as expected.
>
> Fixes: fc1435807533 ("perf vendor events power10: Update JSON/events")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Given duplicate events creates broken pmu-events.c we should capture
that as an exception in jevents.py. That way a JEVENTS_ARCH=3Dall build
will fail if any vendor/architecture would break in this way. We
should also add JEVENTS_ARCH=3Dall to tools/perf/tests/make. Athira, do
you want to look at doing this?

Thanks,
Ian

> ---
>  .../arch/powerpc/power10/datasource.json       | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json b=
/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> index 6b0356f2d301..0eeaaf1a95b8 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
> @@ -99,6 +99,11 @@
>      "EventName": "PM_INST_FROM_L2MISS",
>      "BriefDescription": "The processor's instruction cache was reloaded =
from a source beyond the local core's L2 due to a demand miss."
>    },
> +  {
> +    "EventCode": "0x0003C0000000C040",
> +    "EventName": "PM_DATA_FROM_L2MISS_DSRC",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from=
 a source beyond the local core's L2 due to a demand miss."
> +  },
>    {
>      "EventCode": "0x000380000010C040",
>      "EventName": "PM_INST_FROM_L2MISS_ALL",
> @@ -161,9 +166,14 @@
>    },
>    {
>      "EventCode": "0x000780000000C040",
> -    "EventName": "PM_INST_FROM_L3MISS",
> +    "EventName": "PM_INST_FROM_L3MISS_DSRC",
>      "BriefDescription": "The processor's instruction cache was reloaded =
from beyond the local core's L3 due to a demand miss."
>    },
> +  {
> +    "EventCode": "0x0007C0000000C040",
> +    "EventName": "PM_DATA_FROM_L3MISS_DSRC",
> +    "BriefDescription": "The processor's L1 data cache was reloaded from=
 beyond the local core's L3 due to a demand miss."
> +  },
>    {
>      "EventCode": "0x000780000010C040",
>      "EventName": "PM_INST_FROM_L3MISS_ALL",
> @@ -981,7 +991,7 @@
>    },
>    {
>      "EventCode": "0x0003C0000000C142",
> -    "EventName": "PM_MRK_DATA_FROM_L2MISS",
> +    "EventName": "PM_MRK_DATA_FROM_L2MISS_DSRC",
>      "BriefDescription": "The processor's L1 data cache was reloaded from=
 a source beyond the local core's L2 due to a demand miss for a marked inst=
ruction."
>    },
>    {
> @@ -1046,12 +1056,12 @@
>    },
>    {
>      "EventCode": "0x000780000000C142",
> -    "EventName": "PM_MRK_INST_FROM_L3MISS",
> +    "EventName": "PM_MRK_INST_FROM_L3MISS_DSRC",
>      "BriefDescription": "The processor's instruction cache was reloaded =
from beyond the local core's L3 due to a demand miss for a marked instructi=
on."
>    },
>    {
>      "EventCode": "0x0007C0000000C142",
> -    "EventName": "PM_MRK_DATA_FROM_L3MISS",
> +    "EventName": "PM_MRK_DATA_FROM_L3MISS_DSRC",
>      "BriefDescription": "The processor's L1 data cache was reloaded from=
 beyond the local core's L3 due to a demand miss for a marked instruction."
>    },
>    {
> --
> 2.39.3
>
