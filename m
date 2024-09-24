Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0B1ABEB8
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196109; cv=none; b=uOnu+BWv5h4QHKpiMDPsEAI57xp9rWgmrQL9dk8qSYV7lDfnDARRxHvTe6ryJsdxeXY4EM+E5WBacrTvVPcb5iHLauYG6FJCp7w+jF6rriSSeJ1FDo1/TUorTyvYRmkZSiKED9lwpjnvB6DrZ7mpoPWTObC+a1oIZokHinyppus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196109; c=relaxed/simple;
	bh=Ddebs7NiJQxxst74sSF3DERS4MlxE/1zlrBSLxUAn5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mSbvDan72b75U7XZVeuO6tQMkGtvauFtQKAtzos78zLUaAkxx5VxWAKl+rJwdGjk2//5jJY8oP7onM0AnJBBtH3dquKCK275IBaqXtSSttJYLpdUZwNQFK/JCRK8dsGJj2USD0eI/b3ovT8cQdtUWL0u5gfqRu6XMNWLQyYtpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtpFXmD+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtpFXmD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727196107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly6sJLgbwXipZpoZxAj2N1Oadc6oFWef+44LVvkEXgM=;
	b=dtpFXmD+cW+1GcxQDOlZGfKFjmIMS3BdmVsmfleJHlhdedAj+AnJdujh6Q4ISS4z3yX/qe
	dIN42Hg3HuZcohrDip/+ykWwrX6YsfsvBW0Nfn80MmGAe7v5EEnHXS2outYiHpd8BzPZQm
	OZ+wFo57Xns1m5fmADVUsyaYI3PEaII=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-xmrbNZq9OWeoo6rIRV3FZA-1; Tue, 24 Sep 2024 12:41:45 -0400
X-MC-Unique: xmrbNZq9OWeoo6rIRV3FZA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5356d0f6cdcso4391499e87.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196104; x=1727800904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6sJLgbwXipZpoZxAj2N1Oadc6oFWef+44LVvkEXgM=;
        b=jaoR4eW7LFZmW0E/9qHvD0mq6Yke0z1HsQFssoG5tvagSxK6WO4jquXM/9I9dyd0gn
         aPTViXLnAENfv29yBUxscuMeEy9HESq9AVdZJQ3KipoAgLzYRHWn/IYWFDjjEmkp1Ijo
         2klmOdReOyY1g5O/hdmOPym1KDmvbM/P6+eERZutZUGHeDwy8gpSAPlKnZ3b/ESxKCDC
         kVXC6+KIlMCWYTSa2SrvA+n4C31d/Nh6qjEK+AjDkPQvyfaE6XGkT0hZVd6EyS1nhstV
         YzIhvNgtP0/HkUblM+Bu7a0xXPMW+SKMOt00qqH9TpFRV8qnN0N6SIWOyVNh0jSYMMgI
         H8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWbu2TFSVmcGVF7Zsb/JA9ipqj/jJhSaz9y4sGloWuSUIIIYBGDBp1AYlFGadpZBIh7LiJBAQ6r+WqomkD3GSxQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxULWhdUH1PDL6y2k8EVXFz0uyVy641qQnCpqttR3wnQki1icBs
	Kjr4TmtGCwh3an5JrUkv85NVKvPDlXsWV6lX6rEWnEzZkfpTSWEJ31W8XZmtlQrstbiywy20V2X
	t9MAVNaH9h5C/hbxOP95m7yEW7U0ekwkee8t9LljNNM11mq+YSJZSFc07aK3jEc//fO8=
X-Received: by 2002:a05:6512:3b14:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-536ac32e437mr10881530e87.41.1727196104060;
        Tue, 24 Sep 2024 09:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp83+kSWaKLfEgQ7J8wYrL7FxZHdLIv4s6kY4OvSQk+f18+aZtTWcoz4Bg4yNpb81w2ZyG6g==
X-Received: by 2002:a05:6512:3b14:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-536ac32e437mr10881497e87.41.1727196103612;
        Tue, 24 Sep 2024 09:41:43 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8648dd7sm273486e87.200.2024.09.24.09.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 09:41:43 -0700 (PDT)
Message-ID: <ab460ce5-c635-4fe5-99e6-04d889021b2c@redhat.com>
Date: Tue, 24 Sep 2024 18:41:40 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test: Be more tolerant of metricgroup failures
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240502223115.2357499-1-irogers@google.com>
 <CAP-5=fXGaLsnqd2DdEx-+9V8tO6Wi_HNFgzrGdhdFo5nFSCb9w@mail.gmail.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <CAP-5=fXGaLsnqd2DdEx-+9V8tO6Wi_HNFgzrGdhdFo5nFSCb9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/23/24 20:51, Ian Rogers wrote:
> On Thu, May 2, 2024 at 3:31 PM Ian Rogers <irogers@google.com> wrote:
>>
>> Previously "set -e" meant any non-zero exit code from perf stat would
>> cause a test failure. As a non-zero exit happens when there aren't
>> sufficient permissions, check for this case and make the exit code
>> 2/skip for it.
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>> v2. Add skip if event mode isn't valid in per-thread mode. Suggested
>>     by Veronika Molnarova <vmolnaro@redhat.com>.
> 
> Ping.
> 
> Thanks,
> Ian
> 
>> ---
>>  .../perf/tests/shell/stat_all_metricgroups.sh | 36 +++++++++++++++----
>>  1 file changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
>> index 55ef9c9ded2d..c6d61a4ac3e7 100755
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
>>    [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
>> @@ -14,11 +12,37 @@ if ParanoidAndNotRoot 0
>>  then
>>    system_wide_flag=""
>>  fi
>> -
>> +err=0
>>  for m in $(perf list --raw-dump metricgroups)
>>  do
>>    echo "Testing $m"
>> -  perf stat -M "$m" $system_wide_flag sleep 0.01
>> +  result=$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
>> +  result_err=$?
>> +  if [[ $result_err -gt 0 ]]
>> +  then
>> +    if [[ "$result" =~ \
>> +          "Access to performance monitoring and observability operations is limited" ]]
>> +    then
>> +      echo "Permission failure"
>> +      echo $result
>> +      if [[ $err -eq 0 ]]
>> +      then
>> +        err=2 # Skip
>> +      fi
>> +    elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
>> +    then
>> +      echo "Permissions - need system wide mode"
>> +      echo $result
>> +      if [[ $err -eq 0 ]]
>> +      then
>> +        err=2 # Skip
>> +      fi
>> +    else
>> +      echo "Metric group $m failed"
>> +      echo $result
>> +      err=1 # Fail
>> +    fi
>> +  fi
>>  done
>>
>> -exit 0
>> +exit $err
>> --
>> 2.45.0.rc1.225.g2a3ae87e7f-goog
>>
> 

Acked-by: Veronika Molnarova <vmolnaro@redhat.com>

Thanks,
Veronika

