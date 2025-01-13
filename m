Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731C1C5D74
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782814; cv=none; b=eR7UT7bUYRf+5HsyIM/vmktE9C65HruIZ+3Zk/ODnv02L7P015NAARzQLQl2Hp09AmGl4gvkftzxRY42wvRefT3Zckp1ykdS5RF5QEd8RduhzO6N6DQqSbkSbio8X7TBm6CcLk1zDc3cEtSPmhTwz2+mD5IKZMb7cQs/Oh91GhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782814; c=relaxed/simple;
	bh=6lNC1JIim1bJZyL7tlQ0WNQPZSSqI3emE4QGfoap9xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihlJXtpulw0hvFkDGT8a1diyktLTWCDh7PYTHr3tbyWJ/pmp5fCR3mIBBT8zHpEEGsCXEYF/A07jzeycC+1RDL1JgVB70e/Py3C2eSUXKNqSVI1XElY1uwkbnzRMuBGv8SHymvnDPPJRSBfYG7bdBc6N7HRhG20kfNqWIeSXXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/BLQMsc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/BLQMsc"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3002c324e7eso43636121fa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736782810; x=1737387610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HrS4UJvX8GQSDWYXmRVMRPX+ISu2HR4FDscTkasjkI=;
        b=G/BLQMsco03Obu2QUtBjsUQg6biD5mp/ZoTqU/+Ch7LZcO3dFCVmApL+u9y8kbzhOb
         rBiZrqKgtrstCKmyUDFR2pNuVn3Y+EHyw704YVRRC+j+mFfPFiIBhWhAhZrWfc84kbkw
         ss1Qka86naybfEzj8t5LkcGMLFg96W5czaq4SBY+AT5ys8i+lAjoeFVo118IJV7qIEbU
         T1NmisyZw0rCWLubKTzqvw74pGAT7Z0CTnjqXqwfb7YNdEyHmBwjSahpo3PhrcCiob5o
         FBS/QsSZ0lE/4WUBGUTLv3v9+CsWqOhu6jhKmrpGlBxDWNd48gKgU+BLmb1WsXOefqma
         iKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782810; x=1737387610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HrS4UJvX8GQSDWYXmRVMRPX+ISu2HR4FDscTkasjkI=;
        b=urkMw4fgd+WFDPXa8AKHrYYbVHdRjFudc4oxn5wrwn2VJPxpTMoBRaDiA7VPH+jHPT
         QazdTzVTwiq5djqzeIWi453xR9HNlA3ShIYb59uvSSaQvQ0ujhgf3uNt9EHb+NNxTmA5
         Qq7qP5Dn7WN2tbU5WldSuVtW4x92nM8eGStu2WUdF3CbSDnVdvchDCLL+VU7OzZ1OBRw
         UZicgmPkmWul33NGpvQ5Bkh5ushMMXV6EH9XvMfbl9DNq10nIC/6Q6bEbMbCgcQBH7FU
         CqpIpcRDjWhQi0cm6A7o5yJ8J5GwQrk2puajVLUhX5Lzl3qKudtpiRQL1xMEi8+u5iK9
         zyww==
X-Gm-Message-State: AOJu0Yyjb8MWlt0+owC/INteqhoI3LOTmtDKcevCrFUOQRm2L2eQgSfM
	MEQBEp3wTHRWqklL0WyKo2AUhlno1mEGP1xl9bo4l6xvxUxWnkSm0rGNW1HFmsxm5bNLX4cKDIz
	mh18CoEAASJ+oxzBgKMx8xQn9BQr7ohbXHJNt
X-Gm-Gg: ASbGnct78456tbc/pLm0GnHZbbDw9GwAM60vc0g+8ofJmiLTRQkhCU8LzDuJBSfT1Ov
	KVySs66bBN3GPEXpnAgY275pDNa9rBPBfSb9JUv6Mh0IUejt1yQAd0v9xiPi0QtQl/mkh
X-Google-Smtp-Source: AGHT+IEFebVk6fMQyWyw5PFB2l0Gn8W8cHx8TfxPGkHm3kKGlwBvlEj+hkkJqt6Mb0xRzrtZMMyhZxNYW5BGlmN5Js8=
X-Received: by 2002:a2e:a99f:0:b0:304:68e5:eabf with SMTP id
 38308e7fff4ca-305f458651dmr71057961fa.23.1736782809601; Mon, 13 Jan 2025
 07:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108063628.215577-1-dvyukov@google.com> <384d6c4b-d2ce-47f8-9030-6225758b5923@linaro.org>
 <CACT4Y+bUrZHD5H+z5-+dKGbtBPO9EQNzBoOwYGhp7zHGrHYrQg@mail.gmail.com>
 <89e678bc-f0af-4929-a8a6-a2666f1294a4@linaro.org> <CACT4Y+ayg0oo0sX54DuJ9n+L4MJJU5LsEJtEDS13Zu7ifOyq3g@mail.gmail.com>
 <20d97acb-bcf8-481e-a898-a13580c566b0@linaro.org>
In-Reply-To: <20d97acb-bcf8-481e-a898-a13580c566b0@linaro.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 13 Jan 2025 16:39:57 +0100
X-Gm-Features: AbW1kvYGC3kPEjvPzrlUi0bpo8ypL88w9EfZ03z1bXjn4LWo9rjr8g709TgbYE0
Message-ID: <CACT4Y+b8X7PnUwQtuU2QXSqumNDbN8pWDm8EX+wnvgNAKbW0xw@mail.gmail.com>
Subject: Re: [PATCH] perf report: Fix input reload/switch functionality
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jan 2025 at 16:19, James Clark <james.clark@linaro.org> wrote:
>
> On 10/01/2025 12:19 pm, Dmitry Vyukov wrote:
> > On Thu, 9 Jan 2025 at 15:50, James Clark <james.clark@linaro.org> wrote:
> >> On 08/01/2025 3:35 pm, Dmitry Vyukov wrote:
> >>> On Wed, 8 Jan 2025 at 16:23, James Clark <james.clark@linaro.org> wrote:
> >>>>
> >>>> On 08/01/2025 6:36 am, Dmitry Vyukov wrote:
> >>>>> Currently the code checks that there is no "ipc" in the sort order
> >>>>> and add an ipc string. This will always error out on the second pass
> >>>>> after input reload/switch, since the sort order already contains "ipc".
> >>>>> Do the ipc check/fixup only on the first pass.
> >>>>>
> >>>>
> >>>> Hi Dmitry,
> >>>>
> >>>> A reproducer with before and after behavior might be helpful for the review.
> >>>>
> >>>> It might be unrelated to your change here, but the input switch thing
> >>>> didn't seem to do anything for me. If I record two files, open the first
> >>>> one, press S and select the second file nothing seems to change. I
> >>>> assumed it would show the other file but nothing changes?
> >>>>
> >>>>     $ perf record -- true
> >>>>     $ perf record -o 2.data -- ls
> >>>>     $ perf report
> >>>>     S key
> >>>>     load 2.data
> >>>
> >>> Yes, sure. This needs "--sort symbol":
> >>>
> >>> perf report --sort symbol
> >>>
> >>> then press 's', select file, and it terminates.
> >>>
> >>> Affects fewer cases then I initially assumed, since I happened to run
> >>> with "--sort symbol" when I discovered it.
> >>>
> >>>
> >>
> >> Ah yeah I can reproduce the bug with --sort, which is fixed by the
> >> patch. But 's' doesn't actually reload a new histogram for me, I just
> >> get the original file again. Maybe I'm misunderstanding what 's' is
> >> supposed to do?
> >
> > As far as I understand, 's' allows you to select and load a new
> > profile w/o existing (fwiw, if you select a different file). If the
>
> By 'without existing' do you mean running perf report with no perf.data
> file? It won't run like that it just says "failed to open perf.data"
>
> > file has changed, I guess you can also reload it and see the changes.
> >
>
> I wasn't able to make that work. How do you reload? If I change screen
> between different events I still get the old file and I didn't see
> 'reload' mentioned in the keybinding popup.
>
> I suppose my point is maybe it's not worth fixing the sort order bug if
> we can just remove input file switching. The behavior doesn't seem any
> different to v5.8 in case its a regression. Maybe I'm just doing
> something wrong though.


Humm... indeed, it does not seem to actually reload anything (even
though the "Processing events..." progress bar progresses again).

I tried to use the reloading feature while implementing:

perf report: Add wall-clock and parallelism profiling
https://lore.kernel.org/linux-perf-users/20250113134022.2545894-1-dvyukov@google.com/

to change some of the flags that can't be changed otherwise, but then
dropped this idea since it was too messy, but decided to fix the
failure I discovered.

So, yes, I guess we can drop this patch (I don't need it anymore).






> >>>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> >>>>> Fixes: ec6ae74fe8f0 ("perf report: Display average IPC and IPC coverage per symbol")
> >>>>    > Cc: Namhyung Kim <namhyung@kernel.org>> Cc: Ian Rogers
> >>>> <irogers@google.com>
> >>>>> Cc: linux-perf-users@vger.kernel.org
> >>>>> Cc: linux-kernel@vger.kernel.org
> >>>>> ---
> >>>>>     tools/perf/builtin-report.c | 30 ++++++++++++++++--------------
> >>>>>     1 file changed, 16 insertions(+), 14 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> >>>>> index 048c91960ba91..42d7dfdf07d9b 100644
> >>>>> --- a/tools/perf/builtin-report.c
> >>>>> +++ b/tools/perf/builtin-report.c
> >>>>> @@ -1721,22 +1721,24 @@ int cmd_report(int argc, const char **argv)
> >>>>>                 symbol_conf.annotate_data_sample = true;
> >>>>>         }
> >>>>>
> >>>>> -     if (sort_order && strstr(sort_order, "ipc")) {
> >>>>> -             parse_options_usage(report_usage, options, "s", 1);
> >>>>> -             goto error;
> >>>>> -     }
> >>>>> -
> >>>>> -     if (sort_order && strstr(sort_order, "symbol")) {
> >>>>> -             if (sort__mode == SORT_MODE__BRANCH) {
> >>>>> -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> >>>>> -                              sort_order, "ipc_lbr");
> >>>>> -                     report.symbol_ipc = true;
> >>>>> -             } else {
> >>>>> -                     snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> >>>>> -                              sort_order, "ipc_null");
> >>>>> +     if (last_key != K_SWITCH_INPUT_DATA) {
> >>>>> +             if (sort_order && strstr(sort_order, "ipc")) {
> >>>>> +                     parse_options_usage(report_usage, options, "s", 1);
> >>>>> +                     goto error;
> >>>>>                 }
> >>>>>
> >>>>> -             sort_order = sort_tmp;
> >>>>> +             if (sort_order && strstr(sort_order, "symbol")) {
> >>>>> +                     if (sort__mode == SORT_MODE__BRANCH) {
> >>>>> +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> >>>>> +                                      sort_order, "ipc_lbr");
> >>>>> +                             report.symbol_ipc = true;
> >>>>> +                     } else {
> >>>>> +                             snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> >>>>> +                                      sort_order, "ipc_null");
> >>>>> +                     }
> >>>>> +
> >>>>> +                     sort_order = sort_tmp;
> >>>>> +             }
> >>>>>         }
> >>>>>
> >>>>>         if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
> >>>>>
> >>>>> base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
> >>>>
> >>
>
