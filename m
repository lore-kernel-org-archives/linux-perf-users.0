Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE21534E2
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800553; cv=none; b=DIOmiV3Tlgsoee/TKo0D2hFg8qsPW8Kx/NVy4MRKQ6rkO8v/zaVaV/Ci0bBezne/BgZqkx7qMdgNrIJ8mAeikqubCYB9k6VaHR67PEUod5lCxwrNESOmpmt+Bmep2VQWpCI3P0YFy5AuZt0+IZB0mVOCoBOwhxlZRev6OPwPl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800553; c=relaxed/simple;
	bh=tXjSwVBeGb/Eb0FtFwqpwFwRnMr6GKOhM4c8ow2qQ9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRyBg2VgscKLavQaWsWixHN67ETipLRr64qnUiq3abEjOaJcuaKHSDslxvirPPnFsGDzAMp+M74q979cTjWBiyU+3gMIeLLqfy1DTR+z96uZ0fGNzRyuCw/9Qoi7r8lfqjstH5BRjkSpLI2raHzAdzyWC0paYObtgRsUGZ5CHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPYY8eI1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPYY8eI1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43989e6ca42so430521cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Apr 2024 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713800550; x=1714405350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LWWbUhCinHZ4pRRDKlPFXeIrr7YidOY2PqyCtNwxyA=;
        b=PPYY8eI1S3O8scbt6x/Zx50IcR/bxB1i8qTziTZ2FJwijamJTwQNKWJSkXCi2HglH0
         Lsk5sAAXOxKDVhZ/cGjPpGv3iIMbDYjQXsKziJX5ZySsBwe/wpIddI1L8qovi63gJpLQ
         EmC9eJXp+yVA8SVwth+RhQNDuFZqWMHU5MiYpiv391y8mGeEgmJSAibPA6CRHd+DQxJY
         zA0Thf1llvmHvZB2gXZRKGnwTG6Tq37zby+kd71UYqG4C2f56PujYbsln1b4tzR1ojBt
         VhKREBjN/LeepQpNl8RFpoobhiW7i6K7JH8q+sramtnacV1xK/1X6V3pVq1C2dsePtAn
         oXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800550; x=1714405350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LWWbUhCinHZ4pRRDKlPFXeIrr7YidOY2PqyCtNwxyA=;
        b=qr0wajQjS7eKbRclk4t32l5Rl5eao705Enlk/SY8y7St8fmvhBOrTDxL5v17sD6rVy
         etHHhHnl6pA5INjglNPjuu12IFrg8GcZc91MoVGqOQc0lgeHlMHGABAK0isLe9iTqKcY
         kyt811kHnCRJuHHa2ony0BC2vnAakV4jjzhTm+VwnI9SOLxWj6XVmZsMW3yCGj0H9pXT
         VaLBNSpT7p416uUxTox9w6fPUgGhz2/Rk6C6Z3HrTG3fhucwsL13X+G6TeyhOmATDt3K
         VgTYd9VZdPa/ao4b4tQXhaqPkmsQ2n9Gy8sNGWksaxMFNt68LXIYym8WMaleCLO19l/6
         kMiw==
X-Forwarded-Encrypted: i=1; AJvYcCXsRKBs9uwN3mu21gzYngAj+uT91CKb4k5jXSVWNf9z6zzVEQ+EgPPyDsXvlm2DiZksgxpSEEAFgnBAB/i/j24qQdWzDZAxefobg+VGNzkqpg==
X-Gm-Message-State: AOJu0YyGHLMB/K4qZSz7PvrXCgx5YDwf5+R6cpEWSc8dStHcw+L3711D
	E28kCDu5jDVOrZwsA3mG77uz9rfERrE5Kfp8a2+wsrL2YezMMlHoW0ZzYhgdpdgsAfLFS+ea/TO
	M0QaiEausWtl7eWCy6GG1xB54XIeIvH/pLTB+
X-Google-Smtp-Source: AGHT+IGqGSjYwcJiVDgalrNn9TAUZdU5fgYKsr64wzHajwJV8/cKH1NAZTOsWkwmjf3FzaLTTq7w5Jmo5xwj/l8huMk=
X-Received: by 2002:ac8:5885:0:b0:437:c4ae:f3b4 with SMTP id
 t5-20020ac85885000000b00437c4aef3b4mr542257qta.26.1713800549734; Mon, 22 Apr
 2024 08:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403164818.3431325-1-irogers@google.com> <CAGa8GX5MhP3FUhafN5QivHaE3Fg+p5MgvTq3SW6MQy4NeZ1sYQ@mail.gmail.com>
In-Reply-To: <CAGa8GX5MhP3FUhafN5QivHaE3Fg+p5MgvTq3SW6MQy4NeZ1sYQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Apr 2024 08:42:17 -0700
Message-ID: <CAP-5=fU_EvN-bSjwbWMP8R+WyG-jeAQ1p4ziyejy2FCH0kgYig@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Be more tolerant of metricgroup failures
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:51=E2=80=AFAM Veronika Molnarova <vmolnaro@redhat=
.com> wrote:
>
> Hi Ian,
>
> On Wed, Apr 3, 2024 at 6:48=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>>
>> Previously "set -e" meant any non-zero exit code from perf stat would
>> cause a test failure. As a non-zero exit happens when there aren't
>> sufficient permissions, check for this case and make the exit code
>> 2/skip for it.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  .../perf/tests/shell/stat_all_metricgroups.sh | 28 +++++++++++++++----
>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/per=
f/tests/shell/stat_all_metricgroups.sh
>> index 55ef9c9ded2d..d6db192b9f18 100755
>> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
>> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
>> @@ -1,9 +1,7 @@
>> -#!/bin/sh
>> +#!/bin/bash
>>  # perf all metricgroups test
>>  # SPDX-License-Identifier: GPL-2.0
>>
>> -set -e
>> -
>>  ParanoidAndNotRoot()
>>  {
>>    [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoi=
d)" -gt $1 ]
>> @@ -14,11 +12,29 @@ if ParanoidAndNotRoot 0
>>  then
>>    system_wide_flag=3D""
>>  fi
>> -
>> +err=3D0
>>  for m in $(perf list --raw-dump metricgroups)
>>  do
>>    echo "Testing $m"
>> -  perf stat -M "$m" $system_wide_flag sleep 0.01
>> +  result=3D$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
>> +  result_err=3D$?
>> +  if [[ $result_err -gt 0 ]]
>> +  then
>> +    if [[ "$result" =3D~ \
>> +          "Access to performance monitoring and observability operation=
s is limited" ]]
>> +    then
>> +      echo "Permission failure"
>> +      echo $result
>> +      if [[ $err -eq 0 ]]
>> +      then
>> +        err=3D2 # Skip
>> +      fi
>> +    else
>> +      echo "Metric group $m failed"
>> +      echo $result
>> +      err=3D1 # Fail
>> +    fi
>> +  fi
>>  done
>>
>> -exit 0
>> +exit $err
>> --
>> 2.44.0.478.gd926399ef9-goog
>>
>>
>
> The patch looks good and thanks for taking care of it.
>
> Just wanted to check what is the desired outcome for metric groups
> with events that are invalid in per-thread mode causing the test to fail.
>
> ```
> $ ./stat_all_metricgroups.sh
> Testing smi
> Metric group smi failed
> Error: Invalid event (msr/smi/u) in per-thread mode, enable system wide w=
ith '-a'.
> ```
>
> Wouldn't it be better if in these cases the test would result in skip ins=
tead of fail?

Hi Veronika,

I agree that fail isn't best here. I'm wondering:

 - why doesn't msr/smi/ support per-thread mode? Can't we save/restore
the count on a context switch? The implementation is here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/arch/x86/events/msr.c?h=3Dperf-tools-next#n234
There's clearly something going on as pperf appears to have other restricti=
ons:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/arch/x86/events/msr.c?h=3Dperf-tools-next#n115
I'm wondering if aggregation is working right if these counters are
more than per hyperthread (I'm guessing why the restrictions exist).

 - the tool error message is doing pretty good. In the test I guess we
can spot the per-thread error and turn the fail to a skip. It's a
shame to bucket things as skip, but it seems easier than listing
metrics in the test or spotting particular events.

I can do a v2 to add this.

Thanks,
Ian

> Thanks,
> Veronika
>
