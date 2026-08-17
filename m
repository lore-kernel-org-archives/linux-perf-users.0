Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AA44839E
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001409; cv=pass; b=DcF+12IKP0gJZWwhNMdrroncAJ25KQ/WiknfOePVUAXLAxQtHO4yIkY9nrES4U6Ujmuzp/cJw1gZIqe1JH3Q+xvEU17rpIJiCJ60pS0S8VKo3ZX43AM4g/Bjj06mINL/fmLjYX1GqeeA6+mm8/ByERf9UL6XwXwzCQysIdL/p+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001409; c=relaxed/simple;
	bh=OMUZXSaG8O7luPLGbGO/JcjBr+VAX4xosDd9akuhlH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP4+jyPIz45nhZWmlx8PXL70HF46XEK1DDSvrBHQUt8vweRIXbWqaycrstIJY657GVsRms8x1M8J+x5x58PDVzwGNPwD5OH/oU9B3brDupb6+uLje69ZzFcQNbEFXi/g83O/mRpo40/NiWbwRcegXCxpOlxtHablqw5pVdlbmL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcR9kvuP; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcR9kvuP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c15a5b265so85231cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787001406; cv=none;
        d=google.com; s=arc-20260327;
        b=qIbM6PZiCZUtq7Fbh5Ze3obkyT11Hw24wQiANwfZnWmAZyNZMuMgmkbGfo67/T9GLe
         jWEDemolMWzU6dgxkSTLbdrpQF7pqv+f3TrLXecPnsiIMOA41WuIPVO4rx0uXXzGznYh
         56x5lUr2/Fr5fc0NtLV65ybZJo78gLlDia/Pfrjokr7QnGIsd1Xqj31CLCMf/IdFTwxz
         DuhjXu/eUvHOmwQ0+/ZYAxkyTW0cS9scjRc+dRJvE1VVpSbnIur7gN0MF8ruw5lgol0u
         dvk+3R7Pqy/jxJHi96E+T12WVUvEkYMEjnv9tK3stfpfgut0ryCZf8KOpTWl/4pzFUiE
         bO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AwS+DcBLVWO86z+dijbbJo1WgXcQ+0udYFNcLFCHyac=;
        fh=6dueO/pn4mwP44eGZwFJVXnUMkdpeZYpoFqEB/RX5O4=;
        b=TCBqSfMp6h+6/oKgfRXdoVrF5fpDzHGc72ww8Z2p50VxO3C3pjDnuVUWVhq5dcvvYb
         Vqs8OlroT2ZXna6d9pJ4KdxUHJ8DWe0HNBEtS3hwThQQJdTN6+R6YctdObjNo6SAr4Zq
         vbAYB0ew98z/C1sXrM0c9eiUtdnSboz5nVeDxBD0ohdKAbtol+JCgVEyRYOLyhrA6S+7
         PB4DzS7Os//KqIe/Qhq1K8dtfPdCKJuy/YfVpXRg6oVqbAYcUBjZ+kG1PLF5hEmH5jKH
         byn1OdWF8pXtAxeMtWdtNpk9P6NpImZIX/2a04TxuzliWhFZWaD5gu52Gi59pmkdb0Un
         9blQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787001406; x=1787606206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AwS+DcBLVWO86z+dijbbJo1WgXcQ+0udYFNcLFCHyac=;
        b=jcR9kvuPLh0+1BpwCy5/DVhupFnQYKXytA2WNtRZu+07/aVjVsuAZNsV+QsMEA3+4g
         wcphscOCyx0xpXCk9QRRia19lIsR9RAFnk3ltO3a+1zSHEFVS3fIWfhAG20hdNi1yIfs
         B02GsIH3M5zeEReOX+EO5Jyz4qt5Dsku38oO6ZNBdZGInx7tG7oScC7I0mlLnrsdduXL
         dGIOLEMFzKwPpIukT5xg1GcvhOI+lArEXs8lyZHMgGG9Mj1Is+Rfo0Bh2lVryO3KgDzE
         3jdbofmnNRJvEFrJMy3gvneNUcI0QSOdiRwPgG33zrDlytSqWKrO3w6ruulUBVfNVCSg
         jcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001406; x=1787606206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwS+DcBLVWO86z+dijbbJo1WgXcQ+0udYFNcLFCHyac=;
        b=Txn0FhuAuw8e2b50/IXA0S+lm1RBnVRfQWItcaCwuUuZ5da6N7bhhfBRPb+DnCl0di
         EnZ4XCxPNngzN9FnWhhdHceyo8AFq7/QdrW+Zom4+1X8XWL7TvvHYysbUUQBEaAy2FHu
         lG9lQCLOdqKcQlUras36eQyBumWlVE3yO+tYT1ZQCTPHvTvGUsZyHBCS0CB1yQJwGmTQ
         09g4qOr8aMB1iwlKeZ49nriazrh0xt65U4wD+XBaNGOoU5Py5D7fpqYvuoYnwUDICDFq
         ZJJYBAW89ppl0lFi6QfJBCgkxPMvDBsBNGVqTh1gaMRTpSiJTgdyDuAjj8mdwKio6Nrp
         cQZw==
X-Forwarded-Encrypted: i=1; AHgh+RpbTvVhBLCch6HenUKh/R1dFtRA1DciZC/bZoTdi1+Wpj8rE77+W/VAcWlg4k5Cobd7EK78Nbuu7owMRfxn015l@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOxc9/+3pOvqNQDRJj5+H+uhSTWa/u2PanY7SMOOwstfa4DBC
	3yN1xLXbrX5a9zNypmvz9sqn0dtsjU/+zIaXfFzPNxvqUh8hZbg0Kq6D85eZybd2sadExMY9vuL
	8K6QI2cJu6M3Tq1w324qq71o2dh1+HvIY73BpbScK
X-Gm-Gg: AR+sD12tWWpOtLMyiXaYyoSWKw+b8OYUGcrs5d/W11PT92vz1E95nPxX15ZSydR9l2D
	nuECWlAHGI09Sqpb0fg5CKk0qeqDHQKbd1PFGbekecfX8UgLnBB1Tw8sAXNRB8OBCkAUHuMXJ/V
	BnHwe1OIA/QBHHwLYwvvnY0ZBu3H2oIE8fO8EHso2Oh/VOcyYe+ZNorDnAAN2yCynCj1q16OmfM
	uK/Z2GgolDAK/ACBU+T597ek0cvsd/Eo19EnvcXcv96uXOS6WG6TNzizoZC2IxDcoRotUqqkzLx
	uyxv40aj1SlXdh5J/FRWiKTiYKCn9oc41CKz7yMsuKprEJrMA+cjG4ZzvkKsJRCOSy3rsNfw3wk
	=
X-Received: by 2002:ac8:7dcc:0:b0:519:b655:235 with SMTP id
 d75a77b69052e-52dc0aef867mr5277581cf.3.1787001405125; Mon, 17 Aug 2026
 14:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <20260817094623.3288456-10-jiebin.sun@intel.com>
In-Reply-To: <20260817094623.3288456-10-jiebin.sun@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:16:33 -0700
X-Gm-Features: AcwNN1XdvAaRrtDmFu9eB30K5Oz9KR_6aE1DNoMBQhB96akPRVmT_UZwWhw7SAA
Message-ID: <CAP-5=fVgRoudLw-AY_k9g71_ttq52pXtfM+OAxXppVoV8Z3xbw@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] perf c2c: document function view in perf-c2c man page
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: namhyung@kernel.org, acme@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, wangyang.guo@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 2:40=E2=80=AFAM Jiebin Sun <jiebin.sun@intel.com> w=
rote:
>
> Describe the function view hierarchy (read-side function -> contending
> writer function -> shared cachelines), the per-level indentation, and the
> keys, with a worked example.
>
> Document that reliable function attribution requires `iaddr` in
> `--coalesce`, that the reader and writer may be the same function, and wh=
y
> the coalesced function view cannot distinguish same-thread from
> different-thread accesses in that case. Also document that verbose mode
> includes code addresses in function rows.
>
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-c2c.txt | 71 +++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documenta=
tion/perf-c2c.txt
> index e57a122b8719..8775889bc0a3 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -365,6 +365,77 @@ TUI OUTPUT
>  The TUI output provides interactive interface to navigate
>  through cachelines list and to display offset details.
>
> +Pressing the 'TAB' key in the cacheline view switches to the function
> +view.  The function view shows a three-level hierarchy of the symbolized
> +entries retained in the cacheline view, organized around functions rathe=
r
> +than cachelines.  Levels 1 and 2 normally show function names, while lev=
el 3
> +shows cacheline addresses.  Lower levels are indented beneath their pare=
nts.
> +Verbose mode also includes code addresses in function rows, and code add=
resses
> +remain available in the per-cacheline detail view ('d').
> +
> +The function view requires `iaddr` in the cacheline coalescing fields.  =
If
> +`--coalesce` omits it, TAB reports that the view is unavailable rather t=
han
> +attributing already-coalesced samples to an arbitrary function.
> +
> +  Level 1: the read-side function, sorted by Cycles % (estimated load
> +           cycles: HITM, peer-snoop and other-load cycles)
> +  Level 2: the functions sampled writing the shared lines read by the
> +           level-1 function, sorted by store count.  This can be the sam=
e
> +           function when it has both read and write samples
> +  Level 3: the specific cachelines shared by the reader/writer pair
> +
> +The Cycles % value is the function's share of event-provided load
> +latency/weight estimates from cacheline-detail entries retained in the
> +current view.  It can include non-HITM and non-peer loads coalesced into
> +entries that pass the C2C filter, so it is not a pure contention-cycle
> +percentage.  The share is relative to the functions and entries retained
> +for the current report and is not comparable across recordings or differ=
ent
> +`--coalesce` settings.
> +
> +The store count on a level-1 row is the number of sampled stores by writ=
ers
> +shown in the function view into the cachelines that function reads, incl=
uding
> +stores from the same function.  It decomposes into the level-2 writer ro=
ws;
> +each level-2 count in turn decomposes into that writer's stores on its l=
evel-3
> +cachelines.  A level-3 count is therefore not the cacheline's total stor=
e
> +count.  The level-1 value is not the number of stores made by the reader=
 and
> +is not additive across level-1 rows: two functions reading the same line=
 each
> +carry the stores into that line.
> +
> +Each function aggregates all of its code addresses into a single entry,
> +and a level-2 writer aggregates all of its shared cachelines, so a
> +reader/writer pair is a single row with its total shown -- there is no
> +need to sum a writer's traffic across cachelines by hand.
> +
> +In the function view the 'd' key opens the detail view of the selected
> +level-3 cacheline, 'e'/'+' expands or collapses the current entry, and '=
TAB',
> +'ESC', 'q' or Ctrl-C returns to the cacheline view.
> +
> +For example, with the first two read-side functions collapsed and
> +dequeue_pushable_task expanded to show the functions writing the lines i=
t
> +reads -- two of which are further expanded to their individual cacheline=
s:
> +
> +  Shared Data Functions Table     (19 entries, sorted on Cycles %)
> +     Cycles    Store
> +          %    count  Function / Contending function / Cacheline
> +  ----------------------------------------------------------------------
> +  +  35.67%      876  + [k] cpupri_set
> +  +  24.31%      424  + [k] pull_rt_task
> +  -  16.53%      555  - [k] dequeue_pushable_task
> +                 145    - [k] pull_rt_task
> +                 145        0xff2d0082809da080
> +                 139    - [k] enqueue_pushable_task
> +                  70        0xff2d00a2071f9640
> +                  69        0xff2d0082809da000
> +
> +Here dequeue_pushable_task pays 16.53% of the estimated read-side load-c=
ycle
> +cost.  Its store count decomposes into its level-2 writers, and each wri=
ter's
> +count decomposes into its level-3 cachelines: pull_rt_task's 145 stores =
fall
> +on a single line, while enqueue_pushable_task's 139 stores split across =
two
> +lines (70 and 69).  A writer can be the same function as the reader when=
 it
> +has both read and write samples; after cacheline coalescing and
> +function-level grouping, the view cannot distinguish same-thread accesse=
s
> +from different threads running the same function.
> +
>  For details please refer to the help window by pressing '?' key.
>
>  CREDITS
> --
> 2.52.0
>
