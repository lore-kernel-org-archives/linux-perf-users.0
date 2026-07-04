Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CC33F5AC
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Jul 2026 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206213; cv=pass; b=V4hdVf9MdqBHnnI9JbaGAbk1+AqRTFLnlzDaQh2hbDEjCQV+OurCgfVfyQOoRt58T+o3ztx9ZeNzoRkK41O//8jtRVCg1STr/talZpLs0dSz6Mrx+AI2rwGO3WKnjMKDMUg6Rea1CI0BYNRBpAPEB3CSz30FP28aDR12EMVwgws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206213; c=relaxed/simple;
	bh=+0DN3z4e8iX8+bNNHBRVlsEy0UfFOC+jaEHEQd7Ovy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djQSQvf40SiehLnIHsQIrpqzhVk/QhPV/Qa902ej7R0WI3XFghhEGrOmexaFj8RPRFu5VzQWTRvFbxEvX0MuYUhV2eypnYmlJSRZi27R6Uf1pmF98XPdRTsmvdP45Xcx4tFOHJxjmtD9fcr0pHA2+0vt/LlqnQyQvCO6mpI4D9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zzhbqix6; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zzhbqix6"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cab97c86bdso270685ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 04 Jul 2026 16:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783206211; cv=none;
        d=google.com; s=arc-20260327;
        b=eFR5GpAM61vqr0ahgLsUUvsBzalxymX8Pik6FstzT7KN+kSqNiWt+y06QipfsOxsA6
         x9BrfR5oi1AG6U/Oo30IPFqACqP9jTbE6mwosLozHPXU4SKjZZCyd3wexMHsPEtViTup
         XhMy0gdLzW/nZm0XRbcHt49jxW1OuIW5r3C2I5HBrA4DFJUxqDIAqwN+SMrK38kpc+c3
         ybWoPP7hM3WKikI070BG69jEmZ8/msY52rF1KII7xUg/zP9dlqhCeYpIWxNYLdJrDUdC
         RAERCiNOsttNkpmkmWzw9seTg9/+yu7x7UtoBfw25w0RmARYkeGjkm2Ru2kJO9Ya6X4l
         SRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NRoYBkGWb2Ymhsxn4Q9Uph+pMflWWye/JnWbb9YJrXE=;
        fh=WsmiPNzpDfsPNAW7s0j1CmkDYkdJqaJpU1RG2qxKHDU=;
        b=OaO657o4kpXQo/Xl//lcg3YmpmgMX+1vrJnJTkOA7EVrawYC84YzoDuupMUwg+7IQX
         s4f9ERufi5witC+ezYm/s7PX7bsq82bhswaMBLP1WAEZZaMwdpQEkV87fOqYLfRBD+FK
         E0bCLie/qtMQbMP+5EKr/B8iKPwOZUrP/r2PQoHOoDPrPp0PKFqM/+2pAnxz0IdYJEnu
         ppkldkhjurB/0i71PduNrLNyuAq/XgPiynV01YLK3CodsIZgyk3MmnZODgiIqyz9pGCQ
         gKBx5CrMmJQb08NtGy6dDZZnfXozGbzMy8LZmwMjzsf0Z2/PCdySSI5Y6bJCwJgoHoxK
         10cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783206211; x=1783811011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NRoYBkGWb2Ymhsxn4Q9Uph+pMflWWye/JnWbb9YJrXE=;
        b=Zzhbqix66W65p8Uzxj6tQRj//PueK1G5umH2ru+AMDarNKdxcpZSzU13MBKlKV1aQ7
         2cW2R8Rbq7oT2Lz/bxn+vEtQwYbHbjgkz2dXiX2ceUk39RdqQsl/qKJ3wg+UhuQ8IMcL
         iCB/Pu3wEypl03oB8ikM5r5ejm0dy3SLOW92coCRGCSJEVgRjoNfp4Ksjiu7iCk7Xcnv
         2g03rD/8qoE1tzFDe3gZ9l65mBjB2Z6j+S4SONeKbg6kWoX4OF3eM9Oil1IH4c7k1ERB
         +0roFWBv+pjNpBeK+bSQ9vBiYNPffQkel6RE1PtLPxZhiLAMV7GKghfWrivF1Hv59fjT
         1YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783206211; x=1783811011;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRoYBkGWb2Ymhsxn4Q9Uph+pMflWWye/JnWbb9YJrXE=;
        b=G6nm6CVLEKHeurgFkouNmWMhw770A8O7LY0xW75iLYhtVVsPtm9hl9H/xdsJTol2yp
         LnXuLP7VKTzLsl9E24WC8ZaGz+ne6kyVWhg1a0273zw1v4AADwjLOFSlB+GI+ETiVdXM
         rertco3KDZWm0OiIIVPl5mlYiCqpEc5Wx/UzxKoCTJ2Zzy8DS6F9hmB/al2CbhroNttp
         VJstRTAjxTWfw/hHdnwyor9Jyx3O/KJym7LJKtokpdmI5FRofxlfGzXOCBODynqKSlwW
         jpfX8U7+Xwxbfri1AHuXnEyKt2G58qC+tkTxmGPiqc2YHyCTA1vP4pVibqI7WvtXhhma
         50Xw==
X-Forwarded-Encrypted: i=1; AHgh+RpnSH823ra6R58geW1YL1EJ3YDIPQzbD+llR0b+RnmnDLMVkhfxdggTiwLIQ2uQcyZFe/98c39UTpd37iepNHDi@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6bqVtlDfgdJOuoSU7rxT9sR1G6TwNXQ2aYNnykCU0fnOH/1M
	DfuioODsj5od2kO2s2uvoPUctWw+64bD0OZ0hFRwAx7bEuGlJdbXPw48mFWejlb+fmt7WClKiqj
	29vkIQmNnJcff8NgqLRcyGtrSdmOZmtgwnkJjB6j0
X-Gm-Gg: AfdE7clZwCTPkEdmkbRZPPpfd3gMqL9+cD1pNYLplOkVBESwmpaT9maMjf4ZNFGIIhi
	fIa1hs+isHA5NnTSnr2syTYTrGTqYG/qjUIYw5H2GAnvKnTIl3Eudhj6BlZtn+AXNKW7oOIG+Kv
	r4CPIUiVFnPgJ8ZkkGSumDOxndOdGl3mHH1O2+iCdnGL/vHsAMjJhckAxWCz33dZREgFqmhEGpO
	oLBb/hPQsDvRztwP8bvGFcjUX/XLs2MD0Z0GvKdYXBu32QN1pCw0vSinv6xJXZcQzEoHomtUA==
X-Received: by 2002:a17:903:41d1:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2cc61416ee6mr1186695ad.5.1783206210897; Sat, 04 Jul 2026
 16:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
 <akk6yvqJuXWOrGUr@google.com>
In-Reply-To: <akk6yvqJuXWOrGUr@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 4 Jul 2026 16:03:18 -0700
X-Gm-Features: AVVi8CfHyGWdFSxXMeodjMVq2BmXF_Jj2D6ZyBy86GaX3ves9m5urN-Z64rOglc
Message-ID: <CAP-5=fU4Q2zUQF1xKTdW_f6Z5eSpwQvRQCDtcVh6Z5BHXks4hQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] perf python: Fix python extension bugs from v19 review
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Tue, Jun 23, 2026 at 10:15:17PM -0700, Ian Rogers wrote:
> > Phase 1 of splitting the v19 review patches into smaller fixes.
> > These patches address issues identified in the python extension during
> > the review of the v19 script porting series, as well as fixing several
> > pre-existing bugs and leaks.
> >
> > v2:
> > - Addressed sashiko review feedback:
> >   - Fixed 64-bit casting for counts_values by using T_ULONGLONG and PyL=
ong_FromUnsignedLongLong.
> >   - Replaced strict Py_TYPE checks with PyObject_TypeCheck for thread/c=
pu maps.
> >   - Fixed a missing CHECK_INITIALIZED for pyrf_thread__get_cpu, pyrf_pm=
u__name, pyrf_pmu__events.
> >   - Included <string.h> where memset was used.
> > - Fixed line splitting formatting on PyObject_New in pyrf_evsel__read.
> > - Added fixes for memory leaks and issues discovered during review:
> >   - Fix memory leak of key and value in pyrf__metrics_cb
> >   - Fix count_values memory leak in pyrf_evsel__read
> >   - Fix sb_evlist leaks in both top and record paths.
> >   - Fix potential divide by zero in perf_event__synthesize_threads
> >
> > v1:
> > - Decomposed the single large "Fix python extension bugs" patch into 13=
 individual fixes.
> > - Added Fixes: tags for issues that date back to earlier commits.
> > - Addressed checkpatch warnings (line lengths, Signed-off-by, etc).
> >
> >
> > Ian Rogers (16):
> >   perf script: Fix metric_evlist leak in script_find_metrics
> >   perf stat: Fix evsel_list leak in cmd_stat
> >   perf tools: Fix sb_evlist leaks in top and record
> >   perf python: Fix memory leak in pyrf_evlist__get_pollfd
> >   perf synthetic-events: Fix uninitialized pthread_join
> >   perf data: Fix directory file descriptor leak in perf_data__switch
> >   perf test: Fix skiplist leak in cmd_test
> >   perf python: Check counts_values size in set_values
> >   perf python: Validate CPU and thread maps in pyrf_evsel__open
> >   perf python: Validate attribute setters in pyrf_evsel
> >   perf python: Zero initialize perf_data in pyrf_data__init
> >   perf python: Add thread and PMU uninitialized checks
> >   perf python: Fix MetricGroup return type in perf.pyi
> >   perf python: Fix count_values memory leak in pyrf_evsel__read
> >   perf python: Fix memory leak in pyrf__metrics_cb
> >   perf synthetic-events: Fix divide by zero in
> >     perf_event__synthesize_threads
>
> Will you send v3?  You don't need to fix all pre-existing issues but we
> should not introduce new bugs or regressions.  I think some of Sashiko
> comments found them like data switch and pmu init checks.

Thanks Namhyung, I have a v3 coming. I'm working with Sashiko locally
and trying to address as many issues as possible, including minor
pre-existing ones=E2=80=94it's easier than remembering to clean them up lat=
er.

Ian

> Thanks,
> Namhyung
>
> >
> >  tools/perf/builtin-record.c        |   2 +
> >  tools/perf/builtin-script.c        |   2 +-
> >  tools/perf/builtin-stat.c          |   9 +-
> >  tools/perf/builtin-top.c           |   2 +
> >  tools/perf/python/perf.pyi         |   4 +-
> >  tools/perf/tests/builtin-test.c    |   5 +-
> >  tools/perf/util/data.c             |   3 +-
> >  tools/perf/util/python.c           | 160 ++++++++++++++++++++++++-----
> >  tools/perf/util/synthetic-events.c |   6 +-
> >  9 files changed, 153 insertions(+), 40 deletions(-)
> >
> > --
> > 2.55.0.rc0.799.gd6f94ed593-goog
> >
