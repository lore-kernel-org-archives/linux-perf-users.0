Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213623741
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247805; cv=pass; b=C6JhMJFeSJRTtYo+kQH1Vps6YSjU/G7S9EvanNC8/D+iSBoBh2oEjuYIwUdGjZhJx4xZUOqu9/BtxsSjmylOtow5McN4RV95Xyop1vxMpUzXfgd65AAXhCUR4XfijIgEfld+gWAjyz94kF40qYsjMRwMEipWNL/mFiLuAL+X5kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247805; c=relaxed/simple;
	bh=IEwSF9bS5nLfNXzD4YZp/jaC5H8bR1SiSRP9mKJwFbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THq+yvTbOyvmq0Bit3fCk01V5cBgAAUnNrPXkAGty2QRVYs+4h4wXaFpMWzdNY7RP7W0VO3pkuo+mxRibxHzjTI1p+cjJWSFxrxLHbMMto/4rB5qUB3PzsqRdUfa354fc3mPwL85UN4kLWi5Mmh23Hg/2webI/xJ3H+KN1FrAfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WN8AXjnN; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WN8AXjnN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso67765ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 17:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784247803; cv=none;
        d=google.com; s=arc-20260327;
        b=EEotKe6wb9J3ufNtpkiDdGJ/K28mS6PBW7a2ibOJ/eaD/uzGL15xQ3xGYtXDw7Mg+v
         ocG2xVz0wN1HK+vn5u5eKscmjfJXuv6/bfAt5O78Zs+r6I8qReE8RlWugHr7zW0GYmLB
         NvEoHudw+L/TsdwXQZ+HHkwpKcZMpm6BclNDssbucjORnZ4keovFJohsxaFe2viGX/ul
         pENPkfgg0ge0on2FLAFlRnrSOe9TGGubpCoY0WFewu5lJu29KD8CVdQQTK1LsnW7FBdR
         +KzoeKplJIvt0C1ke8iuzA+tlFJ14MWlP4Avk7ZMl4As1pemS9nUDbBYrdIm2BBxF6O1
         eLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VsRNxwsGSbofbkwYH5Cobj1ZdAWzohmRcpNBffBTwoc=;
        fh=qqbhR37h177AFfb6ICafj1dIG/Wi+CJ7bZ0kQwgoYIg=;
        b=ae2yyadc+2KzYIZw52oB71ai21C+n5EhUKzjeli41RGKJEnpYY4yeRrDy3cynfgXDV
         SF7HPzhQp0TwQ9YUV/JKmGMOBJ2vYZBBQYMJmPmykYXdy1vKpudw+oGdur/T77fmdcrT
         nI0ENx1e0UT0h378UGP+cfGMVVLzpHAjvYOcMCFSRmsyEKKZ+LYBeBPYWWKgIhZj+gn9
         UMpuydU6ZEMBZnkUwl2qmcgmNlXsgej2Hgu6Ob5mgpSTmYjE5tK7sqqigBOQ0jrefYcq
         JQ6Zveqx2PzdBAxWiD2jGldH1kUt1eZKI8kyBTMFyru3p9SxdH+TQCwgNcLW0ipg4N7I
         DmkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784247803; x=1784852603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VsRNxwsGSbofbkwYH5Cobj1ZdAWzohmRcpNBffBTwoc=;
        b=WN8AXjnN8HzWqOIV7W27V8Nje/fiwZvggbmNrkMwpU1iVLOzFhajH8XSJVix+mnqMc
         d7oT1jGq5jbhkOKUAknCgk8l3pPu0iWOe2z26rd5XoXKV2KOb9MmVnsYtrWBfR7kZiqR
         wwlZ6Okn9AAq4NcCfMCqz9z4GQ+V3xmsosbjaqsv3wEdLN4fihs2GRm1D3fDO8+dDVtk
         ijEn4KwTu0/OX+Zk7muC1sLDAWZn//Qqis4rxjHr1RM/RygHtMCELFK2AhHKgDFRE1Vp
         AMPTgv6wSbeZyeCrUm3ADPyJZyF/znuNArFYkQKxw2JCe6TV+gZ0eytWxnd9W0J73IS4
         0uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784247803; x=1784852603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsRNxwsGSbofbkwYH5Cobj1ZdAWzohmRcpNBffBTwoc=;
        b=r1E9WoSNcHICkwDxbDSWJLyzzY3QSkLvUPyi7mPgFssrtqLfeh/AfBw+HvOCUdKXX5
         EbZs/ISU0bk+M9TiKK0x/MWgp7HrBPo7UmAhA1ddcw4xf4dIZR7+jt1gb0YucKUA1Flj
         VQT7S/O1M/Otnx4Rktxd1vK5B6eJBYAdcGbKa8P5uorVO/atfsaiXfp7A4exTZCftFJp
         b5R1ICuNa6ABWsAOnR6tSiFXBGh3wijkzVzviQ7H3ExAu6ceVUxoJHtvxuzdGr3rr214
         b2t5uBnSi7w+mRNdDolzjdZdaIRBVDhz0oT6Bd3BdqIifR7vBtv3ximgv170yh4p2W6o
         DcgA==
X-Forwarded-Encrypted: i=1; AHgh+RoEZgy//vjHct6gqc+Niyu3zYqVQ44a3/MzpZalInqxvDKYMo7kmCY0Tc5hP/Ial5ql2dTV4Asq2Wy+008TSM7d@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWUD/mbob/jhHCJBRBR3hwIKDnFV+d2KjQWZHkFJ0SVmDTFHQ
	4t9QyCZU679DBpGE7Qn/1G3PDFK0NkT5BRd8foGJaUOaLgSncOSG62sSh3q+ukM5NWPVa+1vSjT
	IMnhNh4XfMh/5OQZO7Op/gclhjS0zHFdU44HNZnmi
X-Gm-Gg: AfdE7cm3RhPDilhr8MB5Bkyuzh0MAukRSLPXLGtGLHOB1oiG4Dk04HVQ9e7wAzSeUER
	I+MZ1j8SHPmOWb73G0zEU4nnnOvdmxws6CBnT6iDfoZsBv5ewRfTgAKb+2+95ELwTIsVZONeXcB
	+i/pReMxIKILYQBVGQYj1X++0Ek7pvFZa/KZ5oms/yt5nsIkFlVvfP6ICp/IQjTqlOo64HXZYDY
	ERKkagXgltoZyNWyIO9v7SxSwslUx4PpClqd+yHxRutBT//CszXUbQrGS7LkHs=
X-Received: by 2002:a17:902:c611:b0:2c9:bd54:cf with SMTP id
 d9443c01a7336-2cf2f67eb0amr1240805ad.4.1784247802899; Thu, 16 Jul 2026
 17:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
 <allf2kCJcc72HTRo@google.com>
In-Reply-To: <allf2kCJcc72HTRo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 Jul 2026 17:23:10 -0700
X-Gm-Features: AUfX_mxlD4bKEj8ucKp2faW6QamZH6W81x7vOpn3cO-DmPDxftN_rHXToRvfOQQ
Message-ID: <CAP-5=fXwNMcowMfoikd_m=njNkn2H9rmY-kVK5K5dnpORC0F5w@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] perf stat: Decouple and modularize display formatting
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, ctshao@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Jul 16, 2026 at 12:02:49AM -0700, Ian Rogers wrote:
> > This patch set decouples and modularizes `perf stat` metric and event
> > counter display processing into a unified traversal engine supporting
> > pluggable, format-specific callbacks for standard (STD), CSV, and JSON
> > outputs via the new `--new` flag.
>
> Thanks for working on this!
>
> I'm not sure the goal is to produce the exactly same output or not.
> If so, we need to verify that by comparing outputs before and after.
> Probably you can use perf stat record and report.
>
> If not, please show the output here.
>
> Actually I cannot say I like the name of the flag, but it's ok if we
> want to keep it for a short period time and eventually get rid of it.

I don't like the flag name either :-) I wanted the output generated
with `--new` to pass all the existing perf stat tests, which requires
the output to be as close as possible. Only the json output changes
things as the order of results matters less with json. The csv and std
printing buffer events and metrics to make sure the output matches
without relying on a particular printing an event, then printing a
metric, etc. order from the caller. My hope in doing things this way
was that we could land `--new`, another patch can make it the default,
another patch series can delete the old code and another patch can
remove the flag. Once we are happy with the --new version of the code
we can change what CSV and std output looks like without worrying
about the existing stat output code, etc.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Changes in v4:
> > - Squash all multi-metric column padding, zero-skip logic, and formatti=
ng
> >   fixes directly into their introducing commits for a perfectly bisecta=
ble,
> >   pristine Git history.
> > - Avoid newlines before signed-off-by, assisted-by, and acked-by tags,
> >   organizing all contributor tags into a single, contiguous block for s=
trict
> >   checkpatch and LKML compliance.
> > - Introduce strict, grid-based column padding to perfectly align multi-=
metric
> >   events (e.g. TopdownL1) across both standard and metric-only CSV rows=
, guaranteeing
> >   perfect 6-comma and 7-comma parsing compliance by external DataFrame =
engines.
> > - Refactor the PMU and hybrid metric event printer to propagate identic=
al zero-counter
> >   skipping semantics in alignment with the legacy abs_printout path.
> > - Re-run all STD, JSON, and CSV linter test suites to achieve 100% pass=
ing status.
> >
> > Ian Rogers (14):
> >   perf stat: Introduce core generic print traversal engine and header
> >     stubs
> >   perf stat: Implement standard console (STD) formatting callbacks
> >   perf stat: Extend STD output linter to test basic New API checks
> >   perf stat: Extend STD output linter to test core aggregation checks
> >   perf stat: Extend STD output linter to test advanced PMU checks
> >   perf stat: Extend STD output linter to test metric-only checks
> >   perf stat: Implement CSV formatting callbacks
> >   perf stat: Extend CSV output linter to test core aggregation checks
> >   perf stat: Extend CSV output linter to test advanced PMU and
> >     metric-only checks
> >   perf stat: Implement streaming JSON formatting callbacks
> >   perf stat: Extend JSON output linter to test core aggregation checks
> >   perf stat: Extend JSON output linter to test advanced PMU and
> >     metric-only checks
> >   perf stat: Add --new support to PMU metrics Python validator
> >   perf stat: Extend PMU metrics value linter to validate --new outputs
> >
> >  tools/perf/builtin-stat.c                     |  96 +-
> >  .../tests/shell/lib/perf_metric_validation.py |  12 +-
> >  tools/perf/tests/shell/stat+csv_output.sh     |  19 +
> >  tools/perf/tests/shell/stat+json_output.sh    |  74 +-
> >  tools/perf/tests/shell/stat+std_output.sh     |  18 +
> >  tools/perf/tests/shell/stat_metrics_values.sh |  22 +-
> >  tools/perf/util/Build                         |   4 +
> >  tools/perf/util/stat-display.c                |  12 +-
> >  tools/perf/util/stat-print-csv.c              | 677 ++++++++++++++
> >  tools/perf/util/stat-print-json.c             | 339 +++++++
> >  tools/perf/util/stat-print-std.c              | 854 ++++++++++++++++++
> >  tools/perf/util/stat-print.c                  | 500 ++++++++++
> >  tools/perf/util/stat-print.h                  | 137 +++
> >  tools/perf/util/stat.h                        |   6 +
> >  14 files changed, 2688 insertions(+), 82 deletions(-)
> >  create mode 100644 tools/perf/util/stat-print-csv.c
> >  create mode 100644 tools/perf/util/stat-print-json.c
> >  create mode 100644 tools/perf/util/stat-print-std.c
> >  create mode 100644 tools/perf/util/stat-print.c
> >  create mode 100644 tools/perf/util/stat-print.h
> >
> > --
> > 2.55.0.141.g00534a21ce-goog
> >
