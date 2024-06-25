Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788714264F;
	Tue, 25 Jun 2024 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292980; cv=none; b=iGxhJD6DE+c3ApGu1jVpl5KsZXIWAbJF8/5E4L2Axce2s6sjGDUW7/YGbbh/RH5U5mm2/q/F9nC55JLzj3KYImrEJIwlmNeG3B3hAUHUFrAeaOGk2unMM7P4JIVYAzeRF+exKADVMjvFTOaktJaGc6JU6DtGaKR/8pc4+Gypz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292980; c=relaxed/simple;
	bh=k4OQ7xGQtrVC2kJgX9J9ALOCLy/UGD0t7wbhmHHno90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1ADtC4DYLrS8fbEyaHhf5IRjqPRQSYS8Mo4vGNDFNB9dcYr3ahx3MkskE7H4AbY/hLj4KlxIJkEYFBxPWAzdXWCm0Y86pBbwywP2jQ4yyJ5HhulfXzAUh0xkA9w3Ny1wmbitSuakUADcW4LisAij2aOORWc+P30EEqqcXijxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6P1zB1W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6P1zB1W"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f47f07aceaso39941065ad.0;
        Mon, 24 Jun 2024 22:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719292979; x=1719897779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyOQS+2avZap4j8E0kSaNckBLidUkjghHNyRVXogiQU=;
        b=m6P1zB1WSwDilQ5zNig5U/hQRaHqrXZp92HeIbCsRaXC1dIh7xqYJPt4SgrDSRmuN/
         ygwipiEtk5KtoTuHfrPa62KsVTFWBXEMLbXXmYKby1bi5/ahclX8zLplFBN1owsBMkuo
         GDDmnt9sbK9nXd08CoDQltTopsz/DHAhlhi8Taafzj1ZxEvCOPZ+KUpO0SC+772a0cmH
         nwUiVOWIWUHyTnA+b6pUQPNB37asaTggM9kAGVt5LecFLs0yGxoPOcIrWsxs2Q8X/xtv
         3Dx1yyrCHdWtdJWhF+zM/Q4WW9KwyzAU4odrO06VTKFpXlMBm11vlIOhA+EHgUwqU60d
         7LDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719292979; x=1719897779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyOQS+2avZap4j8E0kSaNckBLidUkjghHNyRVXogiQU=;
        b=evOcUN5VnoD3t+OVsqhYK8xJ/RMgSzhJmo5g0eLGvB12QZan5IDnmbNJCEZw2vA9LN
         YO4Wavucf/Gl/QHLNzjZg1q41f7RjFHFIzADqffS4BCKfF7J7p0dwnYFGTFNF4cytMz9
         mJFc3aOf5GLAVcLq9zgNJ7zfQlVNXoWtwlD64XFoBykUimRYW+83wc2EhZa60gYvxHtz
         EvIJV1k/1XCnPkJ0r8vn+jRakA6mmN4/V0mgEkXPb33ewpyzVgVSz7STyvVXaUQ9fwC3
         WtNGeWWvw760Lr/8ybNoFpMeIdyITooKldcE2Bg2+dR35EPNGs1GyD1ALwe6rV5yWS7i
         8BCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpE2Bte+dg0dH11E+/wWPiimYZS0+UinloCk10lD1uvl0augWW2+NiDsQKejI0/vMFNsxNk7BCPzxRnVKsNpwgtrnvOXlCtTaX+Rv9Fh/mF7nFPXs878bLsdd9RwdOLdEj5g2ywMajBLP+Wr2elg==
X-Gm-Message-State: AOJu0YztiMubOEVWq1f9LxFDDk9QSsayElVCBhaRin8CZ3SiAr1+z7H4
	CBYSt4V1pIqPbX/2lzqj/WRwbX1XzVpOo1ayeiVfSdOODbrUlC+A
X-Google-Smtp-Source: AGHT+IG6mRLr4fSYHgaC2+ZBazI2kHMfLIMEgFt4bU7wY3j2ghjQnti7P4sDSZ6eeaW2a6qK0qsT8w==
X-Received: by 2002:a17:902:c406:b0:1fa:487:d930 with SMTP id d9443c01a7336-1fa15943643mr85357025ad.56.1719292978779;
        Mon, 24 Jun 2024 22:22:58 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb321a83sm71889965ad.95.2024.06.24.22.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 22:22:58 -0700 (PDT)
Message-ID: <8a6a5de3-cc0a-4522-a885-c1ef454158a8@gmail.com>
Date: Tue, 25 Jun 2024 14:22:52 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: constant -1 with expression of type char and
 allocation failure handling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Yang Jihong <yangjihong1@huawei.com>, Ze Gao <zegao2021@gmail.com>,
 Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240619183857.4819-2-yskelg@gmail.com>
 <CAP-5=fWm-Tij+vjqOa-18RsiO+1_ytWnKkDvp3vz5hv1O9aMCw@mail.gmail.com>
 <5c1f3b54-da71-47b7-a30c-0011a23195c8@gmail.com>
 <ZnpO8TKWSiterMwC@google.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <ZnpO8TKWSiterMwC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Namhyung,

On 6/25/24 2:00 오후, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Jun 20, 2024 at 04:10:53AM +0900, Yunseong Kim wrote:
>> Hi Ian,
>>
>> On 6/20/24 4:03 오전, Ian Rogers wrote:
>>>
>>>
>>> On Wed, Jun 19, 2024, 11:39 AM <yskelg@gmail.com
>>> <mailto:yskelg@gmail.com>> wrote:
>>>
>>>     From: Yunseong Kim <yskelg@gmail.com <mailto:yskelg@gmail.com>>
>>>
>>>     This patch resolve this warning.
>>>
>>>     tools/perf/util/evsel.c:1620:9: error: result of comparison of constant
>>>     -1 with expression of type 'char' is always false
>>>      -Werror,-Wtautological-constant-out-of-range-compare
>>>      1620 |                 if (c == -1)
>>>           |                     ~ ^  ~~
>>>
>>>     Add handling on unread_unwind_spec_debug_frame().
>>>     This make caller find_proc_info() works well when the allocation
>>>     failure.
>>>
>>>     Signed-off-by: Yunseong Kim <yskelg@gmail.com <mailto:yskelg@gmail.com>>
>>>
>>>
>>>
>>> Both changes look good. Could you make them 2 commits? If so add my: 
>>
>> No problem! I'll send it right away.
>>
>> Thank you for the code review.
>>
>>> Reviewed-by: Ian Rogers <irogers@google.com <mailto:irogers@google.com>>
> 
> You forgot to add Ian's Reviewed-by in the next patches.
> I can add it to them this time, but please do so next time.
> 
> Thanks,
> Namhyung

Thank you Namhyung for the code review. Oops, I completely forgot about
that, I'm so sorry.

>>> Thanks, 
>>> Ian
>>>
>>>     ---
>>>      tools/perf/util/evsel.c                  | 2 +-
>>>      tools/perf/util/unwind-libunwind-local.c | 5 +++++
>>>      2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>>     diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>     index 25857894c047..bc603193c477 100644
>>>     --- a/tools/perf/util/evsel.c
>>>     +++ b/tools/perf/util/evsel.c
>>>     @@ -1620,7 +1620,7 @@ static int evsel__read_group(struct evsel
>>>     *leader, int cpu_map_idx, int thread)
>>>
>>>      static bool read_until_char(struct io *io, char e)
>>>      {
>>>     -       char c;
>>>     +       int c;
>>>
>>>             do {
>>>                     c = io__get_char(io);
>>>     diff --git a/tools/perf/util/unwind-libunwind-local.c
>>>     b/tools/perf/util/unwind-libunwind-local.c
>>>     index cde267ea3e99..a424eae6d308 100644
>>>     --- a/tools/perf/util/unwind-libunwind-local.c
>>>     +++ b/tools/perf/util/unwind-libunwind-local.c
>>>     @@ -390,6 +390,11 @@ static int read_unwind_spec_debug_frame(struct
>>>     dso *dso,
>>>                             char *debuglink = malloc(PATH_MAX);
>>>                             int ret = 0;
>>>
>>>     +                       if (debuglink == NULL) {
>>>     +                               pr_err("unwind: Can't read unwind
>>>     spec debug frame.\n");
>>>     +                               return -ENOMEM;
>>>     +                       }
>>>     +
>>>                             ret = dso__read_binary_type_filename(
>>>                                     dso, DSO_BINARY_TYPE__DEBUGLINK,
>>>                                     machine->root_dir, debuglink, PATH_MAX);
>>>     -- 
>>>     2.44.0
>>>
>>
>> Warm Regards,
>> Yunseong Kim

Thank you for your hard working and for always being.

Best regards,

Yunseong Kim
