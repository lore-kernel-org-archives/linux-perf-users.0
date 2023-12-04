Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dc+9PuTL"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF311FA
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 11:03:20 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso1462a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701716599; x=1702321399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3patIUasVYl44OnkTW8tZ5hoP9CKgx51bwg6aa1ps2o=;
        b=dc+9PuTLb2jHcvB4hEzVyQCGkX/aD0XumWkuUrb7oSh7b4Fkoy3NpvV4WhKv9/kSYV
         HXWSWrFEyPqZj1lat7+pj/nNzTpWD3fMaluk+6Azw6qtz/LZ29+tmAHEmRqb2ELtBXw5
         rpUIhpdShPBgXUPpd1KkfOixNsq+1f7IxSPoWucyOt1jcoyRi0I290+zdvR4WZsoeAXi
         fkblXM1/tvl/XFCmXG7/UK8kzyqcEkYXUpnE4xXSy6T5sq81XYT641+ca2lUGIUQOKk3
         Wm0d5K6mN/LM8l24Dcd+UDrIQIRt+Iyb23QpnQWq/XDS4JzKvcaAWbZkoBhmqa3/tgGV
         XC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716599; x=1702321399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3patIUasVYl44OnkTW8tZ5hoP9CKgx51bwg6aa1ps2o=;
        b=cI9+/clMPy/fG1Kk0dZfX4c8gtORfslZoWbo7IJE455UEZbsZ4/rCceETOe8jJv8aK
         0nsME5LRS5vGm6qQq3LThNic9vASLCc6GWXCulh9FdidFdR4TGv7IRxWOF+askMcVzhP
         eXiVQBbFYyGtSia4J2pSVvVo+9DA0cnZ+uwv1trpfRZe3h16ZW/N6++91H8WeVmFG85D
         Dx33vsifghXTbHp6d3t8HmgGqnNKVJDKStuxcMLXr8XCdp15/9p3v6h8PHpZBqa+IWwu
         FLpt2rtnBm7Mp0SoxQz1M6LSMil9srok891EpwH/rmP0CuteSooNEVEIXnugtRQP6JIy
         RC0g==
X-Gm-Message-State: AOJu0YxU9pDZlkzYPqC0mBP8YkGhGGHlmWEgE/wD2qaueMZY3oTADWEM
	Q0hqV67xwiCeZJXTscu9RCmJ4xhD4eqn5K7uAhcVPA==
X-Google-Smtp-Source: AGHT+IHpFP4IwRHSnWAcYG/jbBNlaN2sY1FYbD0QjhIdOW7/Z248wZPfkm9Gu2K33fIFIHTef2G1343PdDfnyw7fTR0=
X-Received: by 2002:a50:99de:0:b0:54a:ee8b:7a99 with SMTP id
 n30-20020a5099de000000b0054aee8b7a99mr320455edb.0.1701716599146; Mon, 04 Dec
 2023 11:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com> <20231201021550.1109196-3-ilkka@os.amperecomputing.com>
In-Reply-To: <20231201021550.1109196-3-ilkka@os.amperecomputing.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 11:03:07 -0800
Message-ID: <CAP-5=fWKjRORSVh65cm+RMknS_-K=XQC2ew1VVaakvoX1X6CKw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf vendor events arm64: AmpereOne: Rename
 BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 6:16=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> The documentation wrongly called the event as BPU_FLUSH_MEM_FAULT and now
> has been fixed. Correct the name in the perf tool as well.
>
> Fixes: a9650b7f6fc0 ("perf vendor events arm64: Add AmpereOne core PMU ev=
ents")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-d=
ef.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.js=
on
> index 88b23b85e33c..879ff21e0b17 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
> @@ -110,7 +110,7 @@
>      {
>          "PublicDescription": "Flushes due to memory hazards",
>          "EventCode": "0x121",
> -        "EventName": "BPU_FLUSH_MEM_FAULT",
> +        "EventName": "GPC_FLUSH_MEM_FAULT",
>          "BriefDescription": "Flushes due to memory hazards"
>      },
>      {
> --
> 2.41.0
>
