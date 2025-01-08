Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6E1FF7C9
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350530; cv=none; b=idjGRtDHHpH/TpK6uFtkDqFicywc47bWz2B0Azb2SraoCt3lYFY9wiBfkDerh9X3g8xFt46uP2kaSypwK4qe5y5Ez7LAd/IpbYWNcyoUGCRDqeuYIlk1HZr3kLNcWf5kws4HwOZGPIj7hcahtC39duWuoRgQVc5yKhwBdw6x4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350530; c=relaxed/simple;
	bh=bI5zSZY0FSauTeCs8EE5L0tDnEvBtN9EF7MGTb4o8Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFTjxVmP9LZr1ArI2dqzhH++rAqzSqXcsZsJf0fiBzTJ0HiKa+0XaCKm493yUW+/wxFSxDscrmwfsQPPbtprz269J+Pzzli5r5etyiVTdX4ge/6etkGB3iPqOOaDl3z3doOf6ylbV/uTAhCRIaX1nKOjbdCBrfjTkDOPBkANVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfzyYPfO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfzyYPfO"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso225993811fa.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 07:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736350526; x=1736955326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfSxIcPo4dZIcACB+3hioTOxjqOTnSSjy7Y2hrCwySI=;
        b=lfzyYPfO14xTqdXpV0D9oBjwGDOn6LHMgLXhXgqjSvvNhMWAy6agNcuYffWHixCAw+
         eygInyjqCovfTyKVrvCwwgNSMTF1jKRQPI7DBAvR3P6xzg5s+ntjnWtafuDJoW8A+6Ac
         nAUrqEU4WLLdIRoteAfIG434OTgbAEDx012sApO2Tpzf++iYPKB+m7K6ht3pZC5GZCKr
         YhhWKLIG6zE+Rg/yWnWFMmUMtL8u5GeZ6Y4bUMSbHeC//iXXQduD8f18R+v70//7XaRR
         HSmTmO0bUpdUFy1jg//a+cydWinfc0h9XH+Iv2pJDlt1MKPms6e5XfpivFIM0djXfYQv
         zC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736350526; x=1736955326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfSxIcPo4dZIcACB+3hioTOxjqOTnSSjy7Y2hrCwySI=;
        b=pyNAJM39Z1Tgt62LImR8IlHUv0fGKTmUZB+G5ijEVlESS+kujv28SVnUj2m4g00bTL
         mEk9vmf7Ob7b5ZkQjkchL6cdgH1Qa4dttjajI2QcfCS/7xC+qP+fSewQP/IRm9h5dlZo
         LdCBuk/Gn16V7uhsdB5OouIH0XYZ5AbudvArrpvkkyXYCZlOL6eZ4MkusGh1nCwo/piN
         MNjCPzIpBfVCxqNawWMqTABY2zaWT+xcEQBdcs528Icdub+NLrEI0SrBggUhrhxcwKeJ
         7ipcee3hJgGdXsYJVF7BWQM8hWv2Z4d/+9iDqamYg3tCEjnVmTesUBA0DMQtatLfWMPu
         WhMg==
X-Gm-Message-State: AOJu0Yz8SCdvgSuXOZik1qXsPSkUOluJUNzkmcBsL1R1jouW2E5UMhdM
	1HuxLKsMssJ3WmTUM2IduZbaQ6vH4uKgs7UD84CzoYqQTLBWemmgQzAKjrV6cp9uflds2V4tPWY
	/4f84/loPLKkTCX+nCzr5pNvtj9u7cdPeQPQJfag5aZgbtI5AdfIl
X-Gm-Gg: ASbGnctuUm+NpsZBVaMB0ertSMd8FeUDsnJ3aWENnqhsT3djt75ZXMPH5vEdsmJ+D4f
	6y6g35JsLxYVNtxpCfg/Ap8kAowynt/vwAqH1wUb1ndpSYuCvbYySqUatkNm45gRh9xYbhIQ=
X-Google-Smtp-Source: AGHT+IF+7zfWQt83fE+c72MOWUcZi8w9LWOw2ihOTr7uDSulNkawVPiF09qlWGgHviWH81bJW7RybsZ9bfVS0SHZuFo=
X-Received: by 2002:a05:651c:a0a:b0:302:25ef:813e with SMTP id
 38308e7fff4ca-305f45e851cmr8521341fa.32.1736350526429; Wed, 08 Jan 2025
 07:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108063628.215577-1-dvyukov@google.com> <384d6c4b-d2ce-47f8-9030-6225758b5923@linaro.org>
In-Reply-To: <384d6c4b-d2ce-47f8-9030-6225758b5923@linaro.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 8 Jan 2025 16:35:15 +0100
X-Gm-Features: AbW1kvYHed0mm2BZpqiEjQqyV2q1K82zG9JwjnQuiwMLAWWYnvAd3_PVI7yaaLA
Message-ID: <CACT4Y+bUrZHD5H+z5-+dKGbtBPO9EQNzBoOwYGhp7zHGrHYrQg@mail.gmail.com>
Subject: Re: [PATCH] perf report: Fix input reload/switch functionality
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 16:23, James Clark <james.clark@linaro.org> wrote:
>
> On 08/01/2025 6:36 am, Dmitry Vyukov wrote:
> > Currently the code checks that there is no "ipc" in the sort order
> > and add an ipc string. This will always error out on the second pass
> > after input reload/switch, since the sort order already contains "ipc".
> > Do the ipc check/fixup only on the first pass.
> >
>
> Hi Dmitry,
>
> A reproducer with before and after behavior might be helpful for the review.
>
> It might be unrelated to your change here, but the input switch thing
> didn't seem to do anything for me. If I record two files, open the first
> one, press S and select the second file nothing seems to change. I
> assumed it would show the other file but nothing changes?
>
>   $ perf record -- true
>   $ perf record -o 2.data -- ls
>   $ perf report
>   S key
>   load 2.data

Yes, sure. This needs "--sort symbol":

perf report --sort symbol

then press 's', select file, and it terminates.

Affects fewer cases then I initially assumed, since I happened to run
with "--sort symbol" when I discovered it.


> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Fixes: ec6ae74fe8f0 ("perf report: Display average IPC and IPC coverage per symbol")
>  > Cc: Namhyung Kim <namhyung@kernel.org>> Cc: Ian Rogers
> <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   tools/perf/builtin-report.c | 30 ++++++++++++++++--------------
> >   1 file changed, 16 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 048c91960ba91..42d7dfdf07d9b 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1721,22 +1721,24 @@ int cmd_report(int argc, const char **argv)
> >               symbol_conf.annotate_data_sample = true;
> >       }
> >
> > -     if (sort_order && strstr(sort_order, "ipc")) {
> > -             parse_options_usage(report_usage, options, "s", 1);
> > -             goto error;
> > -     }
> > -
> > -     if (sort_order && strstr(sort_order, "symbol")) {
> > -             if (sort__mode == SORT_MODE__BRANCH) {
> > -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> > -                              sort_order, "ipc_lbr");
> > -                     report.symbol_ipc = true;
> > -             } else {
> > -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> > -                              sort_order, "ipc_null");
> > +     if (last_key != K_SWITCH_INPUT_DATA) {
> > +             if (sort_order && strstr(sort_order, "ipc")) {
> > +                     parse_options_usage(report_usage, options, "s", 1);
> > +                     goto error;
> >               }
> >
> > -             sort_order = sort_tmp;
> > +             if (sort_order && strstr(sort_order, "symbol")) {
> > +                     if (sort__mode == SORT_MODE__BRANCH) {
> > +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> > +                                      sort_order, "ipc_lbr");
> > +                             report.symbol_ipc = true;
> > +                     } else {
> > +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> > +                                      sort_order, "ipc_null");
> > +                     }
> > +
> > +                     sort_order = sort_tmp;
> > +             }
> >       }
> >
> >       if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
> >
> > base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
>
