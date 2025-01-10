Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660820ADE7
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736511573; cv=none; b=Ro0M8Low9EHAIySSt7unQYJtJkAcds1+b7RmDFpIu10+7e1aqvbDvP5IuVD9YjSorEhOXyVcZ1HyhAsvRayPkdcTWkHLM2OBlNygNGqge9PyaM4U68FT0Zw6icPh14KxrM3TkJaSzlLp6QBaHtKpr9SQaM8Q9uherS/kwDTj1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736511573; c=relaxed/simple;
	bh=SYWCLk1ZO0o3ESh7WcIEuPB8fLRQpa85s2NlfoY8d+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6sISqUcF2V+9XntHjoCmYzgprfGJVEGZh97EtAej38+Yvs6Cf0M/RfD+KiOPddQZpFzjtVS9KHBiKURyTKnfX6BCW67+sWV1t0gO8v6oPM91vNWDXLslzIIshPMJIezvv7Jx6gpekZ0qxj5ZvryyTeD+BoARYMwR7mxtzoSD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvhGR/+C; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvhGR/+C"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-304d760f0dfso15259121fa.2
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 04:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736511568; x=1737116368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wOmf2yx62KRRvFdcqWYPiy9RC6G2D4PKjAlwdWp73Uk=;
        b=cvhGR/+Con2cUh7LNsDE89vkkxOxhkmzIhkKf406+Z2mkIkq1iQWzaDoeGTvrpFXL0
         PAfHl4rdQZNOGR2Ra8dClgaQdEagQd/3zYQjNwEnX285vTnwJeajMo6n8w0Wd6L/pFm5
         jQ6ZNTTjfd0jcU3pA5olmpfu1UTEP1ewhA+e7+yaRGtEc5z+pfmAIPBDCsWCQXqkXWl8
         2+Z/hNs9fqxOGhOC5vYkbDwPcEC5lDzlKvkVf/yZT2zRdGT3luWSjq9yhgRhyOKlqWmv
         Upe3CIYE+o3Zu8YOfVfLhyePct9QPHMZ492VR4pu1T80/t+tVupOoeIMm5ne33cuN68L
         YkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736511568; x=1737116368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOmf2yx62KRRvFdcqWYPiy9RC6G2D4PKjAlwdWp73Uk=;
        b=eB+7CQxUnHMPwHmhrciQmrbsQK7vaLbcYuTJ5LPVnI1hVYrFDlzpmLVcfvVuviF+pY
         COAF1HLMxKbRR7HxqPAWQJxwPXsGW8PEoN5nmvW6FMFL0KhO1a2Np9hPE928Eezsllnn
         Dia+6qMsXsDOVtlA9z7tgrx8zLfWUSPCiBSTnts36LdiryZxe8Qh+TcmnHuqRVElgY7b
         barVrAvIRScNZdXenXYs6CzrgrYUGXStpEK+fliI+vb6kc3snZkqlH06cawRvrvdPZKr
         hbZCZ53U0rlisH3wbPqlwnCDccdJbLCumlNR753I7m1RFoJpJpp0IzrF4Zf73Mf99MCf
         Hvig==
X-Gm-Message-State: AOJu0YxNx79CJeW3T9k64jYuwmvzZplmjfNkBr1Gan1L777tlkpniAOY
	4Cw+F7P9FtGkUUgXArhsiP262hpFUIfnyrRzeicJe3TWkFMGbehLT7SPop0v+EiLKHueOJUR17t
	TuDFiuX8vzONyQ6ulDakHySWtew0I+xnzoa7K
X-Gm-Gg: ASbGncs7QIhRhScdJ8/6sMks+OWsfnBeOgo2sBc8KWphetCUt3TFrrJ3NRqDYG9xBzF
	2L1jMEdoodZauhscnAUdCJF4I36wwbVh2sFCnKJT0qum6SlhXNDRvlkJ/Fbkf6hnufQKQ52E=
X-Google-Smtp-Source: AGHT+IH+pEv9hCTlgpayVQ7woW3K7IBDmbBjKk7Kb09PblMmoRtiS2gkLZ9rrV5YUu7vd1lGpKHgWouPUB8xpX6kGFg=
X-Received: by 2002:a2e:b887:0:b0:302:1c90:58d9 with SMTP id
 38308e7fff4ca-305f458a829mr34931241fa.16.1736511568009; Fri, 10 Jan 2025
 04:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108063628.215577-1-dvyukov@google.com> <384d6c4b-d2ce-47f8-9030-6225758b5923@linaro.org>
 <CACT4Y+bUrZHD5H+z5-+dKGbtBPO9EQNzBoOwYGhp7zHGrHYrQg@mail.gmail.com> <89e678bc-f0af-4929-a8a6-a2666f1294a4@linaro.org>
In-Reply-To: <89e678bc-f0af-4929-a8a6-a2666f1294a4@linaro.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 10 Jan 2025 13:19:16 +0100
X-Gm-Features: AbW1kvbZdM4CvU6BABQX_6RNaKWxpjEXNAXdnNcF00HlH1phcaBnwN6Z_zTDQM0
Message-ID: <CACT4Y+ayg0oo0sX54DuJ9n+L4MJJU5LsEJtEDS13Zu7ifOyq3g@mail.gmail.com>
Subject: Re: [PATCH] perf report: Fix input reload/switch functionality
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 15:50, James Clark <james.clark@linaro.org> wrote:
> On 08/01/2025 3:35 pm, Dmitry Vyukov wrote:
> > On Wed, 8 Jan 2025 at 16:23, James Clark <james.clark@linaro.org> wrote:
> >>
> >> On 08/01/2025 6:36 am, Dmitry Vyukov wrote:
> >>> Currently the code checks that there is no "ipc" in the sort order
> >>> and add an ipc string. This will always error out on the second pass
> >>> after input reload/switch, since the sort order already contains "ipc".
> >>> Do the ipc check/fixup only on the first pass.
> >>>
> >>
> >> Hi Dmitry,
> >>
> >> A reproducer with before and after behavior might be helpful for the review.
> >>
> >> It might be unrelated to your change here, but the input switch thing
> >> didn't seem to do anything for me. If I record two files, open the first
> >> one, press S and select the second file nothing seems to change. I
> >> assumed it would show the other file but nothing changes?
> >>
> >>    $ perf record -- true
> >>    $ perf record -o 2.data -- ls
> >>    $ perf report
> >>    S key
> >>    load 2.data
> >
> > Yes, sure. This needs "--sort symbol":
> >
> > perf report --sort symbol
> >
> > then press 's', select file, and it terminates.
> >
> > Affects fewer cases then I initially assumed, since I happened to run
> > with "--sort symbol" when I discovered it.
> >
> >
>
> Ah yeah I can reproduce the bug with --sort, which is fixed by the
> patch. But 's' doesn't actually reload a new histogram for me, I just
> get the original file again. Maybe I'm misunderstanding what 's' is
> supposed to do?

As far as I understand, 's' allows you to select and load a new
profile w/o existing (fwiw, if you select a different file). If the
file has changed, I guess you can also reload it and see the changes.


> >>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> >>> Fixes: ec6ae74fe8f0 ("perf report: Display average IPC and IPC coverage per symbol")
> >>   > Cc: Namhyung Kim <namhyung@kernel.org>> Cc: Ian Rogers
> >> <irogers@google.com>
> >>> Cc: linux-perf-users@vger.kernel.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> ---
> >>>    tools/perf/builtin-report.c | 30 ++++++++++++++++--------------
> >>>    1 file changed, 16 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> >>> index 048c91960ba91..42d7dfdf07d9b 100644
> >>> --- a/tools/perf/builtin-report.c
> >>> +++ b/tools/perf/builtin-report.c
> >>> @@ -1721,22 +1721,24 @@ int cmd_report(int argc, const char **argv)
> >>>                symbol_conf.annotate_data_sample = true;
> >>>        }
> >>>
> >>> -     if (sort_order && strstr(sort_order, "ipc")) {
> >>> -             parse_options_usage(report_usage, options, "s", 1);
> >>> -             goto error;
> >>> -     }
> >>> -
> >>> -     if (sort_order && strstr(sort_order, "symbol")) {
> >>> -             if (sort__mode == SORT_MODE__BRANCH) {
> >>> -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> >>> -                              sort_order, "ipc_lbr");
> >>> -                     report.symbol_ipc = true;
> >>> -             } else {
> >>> -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> >>> -                              sort_order, "ipc_null");
> >>> +     if (last_key != K_SWITCH_INPUT_DATA) {
> >>> +             if (sort_order && strstr(sort_order, "ipc")) {
> >>> +                     parse_options_usage(report_usage, options, "s", 1);
> >>> +                     goto error;
> >>>                }
> >>>
> >>> -             sort_order = sort_tmp;
> >>> +             if (sort_order && strstr(sort_order, "symbol")) {
> >>> +                     if (sort__mode == SORT_MODE__BRANCH) {
> >>> +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> >>> +                                      sort_order, "ipc_lbr");
> >>> +                             report.symbol_ipc = true;
> >>> +                     } else {
> >>> +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> >>> +                                      sort_order, "ipc_null");
> >>> +                     }
> >>> +
> >>> +                     sort_order = sort_tmp;
> >>> +             }
> >>>        }
> >>>
> >>>        if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
> >>>
> >>> base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
> >>
>
