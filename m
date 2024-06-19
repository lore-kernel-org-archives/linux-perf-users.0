Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41360155759;
	Wed, 19 Jun 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824261; cv=none; b=QP3r1sy2LBviC/LFUP/3wqfcoePqt2CT9YXf8ETaRDwf1zrd1EVXN+pxM5+bHr1vpp9VWnLPF4vySH9Yyqn9/NUlXZZfCdYxn3Wz6T5OOApZDEyZp6FjiNn9U4vXnuA37ya5bw4q1vh1F4b3GyG662JWu94xbCJzX2GgVf/+EI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824261; c=relaxed/simple;
	bh=JKW2nPoX2X2ixRz7pyFwqsv9YNVEIIHz4xhzfHpO/eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAFfHxG2ck7hcTyXoGgOW2Zo68n9Vg0IeQW78wtlHokGQfLRTW129NjILaZR8T3ufGYzQ1rg1lzxOfcO1CBLTkEXR/ug71HR1YodMBxt0025lWlRowwWrasCa+yJjW7a11AdiPhQJX1Q03N8e4I3X5+XXhPGgC1KgWSkuDTFi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/xikShP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/xikShP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9aeb96b93so655235ad.3;
        Wed, 19 Jun 2024 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718824259; x=1719429059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUGdZMjZzoHYGKKUGNyDbK2J+i2WH4vetBoEX5oj4xo=;
        b=W/xikShPU8KwwMUASYJS4iiOO6+BsIPWGYv5EMh6/pFxLCD1aJJTxHlWfrWpZ5q3kl
         44XXLG9T82ktYjG5sSo18adsU0l1nI0WCybHDSns/Fl4n7IilIZGgrdIp+qqLcoWIpTQ
         VtDkuBGO1V43lYFCAg/7ShE2uzKerVpK4dj4c5/W6L3R61Uca/Pwwb9s/yPiiH9sPn6k
         FphcwqX1nwiVwEMIAd5S3rNkKl8VXI//w3UnhMuGdvikEtcurLys1XZ+b5O7CgMefjQM
         LRCfk/Au7qMpbuiAlKQ5I6gS0h4K5M30ym0cprvP/AArbAUduHCBYZee9l9sGwiYiqAr
         Fk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824259; x=1719429059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUGdZMjZzoHYGKKUGNyDbK2J+i2WH4vetBoEX5oj4xo=;
        b=SpKugucKUdD2yHLzSy6Xuw1QB1G3cJkciG0hGk9t4/Wg/JiEqVj/TvNJHrQApsH5jI
         yPuJhBwKlcw7ZC2jGHINGQfadsu6N/R5ZdHf7jktFrWO8Pr1ZixJZ5iMfwFEfNv/D122
         ThKTVVM5cBhpBekC/MhMwNQIow+3Vlm/rJsWy+BQJdjP1z/RZdqrH7T0yPEkRdgFYzl+
         lfz5ot+4L3Afp3X8mRKu4X7BTeCAaVvS9ULTmha2imMHy50q0Y5s9WUZftynQuVe8I3L
         B35cQEVaWq2sAFyArhK+7Ux05D9OVlsXjV47mbn07XCxpLpvomMSOS8+XqeyGz+fHm62
         eh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKKN8yOimLbdjMMyWnyG+8Q+yt0umM0JxjRHLOk/mC1CvO7P8QdRz/gLFsTdsNFr15/xzVuiEIzE2NRgygQtM4tGBiSJ/5MBPbmzJBcbRqtG3XRs59OQ5AJdV1YWqVTE3+u2riA2r7sLzCVN/8kQ==
X-Gm-Message-State: AOJu0YwTafBC15u6z7PfK/kMhZ3KK7nRsJ7r1KbeYXdJpXZtlU//VPpw
	xwTWgPbvhu9mqiqC7vhiGhbE8xOrckO0AYHL6/oUGJRO9T95it3J
X-Google-Smtp-Source: AGHT+IEcexetf6hadylHwrbQObZoy+JCEiQ1uOfbi2F+xopKplHeVr/OBJsC/CdDC2h+xNB0MFcDmg==
X-Received: by 2002:a17:902:a507:b0:1f8:46c9:c96f with SMTP id d9443c01a7336-1f9aa4729b7mr32007575ad.61.1718824259539;
        Wed, 19 Jun 2024 12:10:59 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855efea73sm120492015ad.182.2024.06.19.12.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 12:10:59 -0700 (PDT)
Message-ID: <5c1f3b54-da71-47b7-a30c-0011a23195c8@gmail.com>
Date: Thu, 20 Jun 2024 04:10:53 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: constant -1 with expression of type char and
 allocation failure handling
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <CAP-5=fWm-Tij+vjqOa-18RsiO+1_ytWnKkDvp3vz5hv1O9aMCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ian,

On 6/20/24 4:03 오전, Ian Rogers wrote:
> 
> 
> On Wed, Jun 19, 2024, 11:39 AM <yskelg@gmail.com
> <mailto:yskelg@gmail.com>> wrote:
> 
>     From: Yunseong Kim <yskelg@gmail.com <mailto:yskelg@gmail.com>>
> 
>     This patch resolve this warning.
> 
>     tools/perf/util/evsel.c:1620:9: error: result of comparison of constant
>     -1 with expression of type 'char' is always false
>      -Werror,-Wtautological-constant-out-of-range-compare
>      1620 |                 if (c == -1)
>           |                     ~ ^  ~~
> 
>     Add handling on unread_unwind_spec_debug_frame().
>     This make caller find_proc_info() works well when the allocation
>     failure.
> 
>     Signed-off-by: Yunseong Kim <yskelg@gmail.com <mailto:yskelg@gmail.com>>
> 
> 
> 
> Both changes look good. Could you make them 2 commits? If so add my: 

No problem! I'll send it right away.

Thank you for the code review.

> Reviewed-by: Ian Rogers <irogers@google.com <mailto:irogers@google.com>>
> 
> Thanks, 
> Ian
> 
>     ---
>      tools/perf/util/evsel.c                  | 2 +-
>      tools/perf/util/unwind-libunwind-local.c | 5 +++++
>      2 files changed, 6 insertions(+), 1 deletion(-)
> 
>     diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>     index 25857894c047..bc603193c477 100644
>     --- a/tools/perf/util/evsel.c
>     +++ b/tools/perf/util/evsel.c
>     @@ -1620,7 +1620,7 @@ static int evsel__read_group(struct evsel
>     *leader, int cpu_map_idx, int thread)
> 
>      static bool read_until_char(struct io *io, char e)
>      {
>     -       char c;
>     +       int c;
> 
>             do {
>                     c = io__get_char(io);
>     diff --git a/tools/perf/util/unwind-libunwind-local.c
>     b/tools/perf/util/unwind-libunwind-local.c
>     index cde267ea3e99..a424eae6d308 100644
>     --- a/tools/perf/util/unwind-libunwind-local.c
>     +++ b/tools/perf/util/unwind-libunwind-local.c
>     @@ -390,6 +390,11 @@ static int read_unwind_spec_debug_frame(struct
>     dso *dso,
>                             char *debuglink = malloc(PATH_MAX);
>                             int ret = 0;
> 
>     +                       if (debuglink == NULL) {
>     +                               pr_err("unwind: Can't read unwind
>     spec debug frame.\n");
>     +                               return -ENOMEM;
>     +                       }
>     +
>                             ret = dso__read_binary_type_filename(
>                                     dso, DSO_BINARY_TYPE__DEBUGLINK,
>                                     machine->root_dir, debuglink, PATH_MAX);
>     -- 
>     2.44.0
> 

Warm Regards,
Yunseong Kim
