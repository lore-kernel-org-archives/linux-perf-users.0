Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FFC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 00:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CF860EDF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 00:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhJMAlc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJMAlc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Oct 2021 20:41:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06680C061570
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Oct 2021 17:39:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so926276pjb.4
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Oct 2021 17:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IvTxsHSrT5WqhfqZ1UE7wrX/qNYGR7vcH+V9R3apHUE=;
        b=hk3y0m7DD6ChpAKvbr8HTLJy54K/oijnpOuZ8Uf/H7NfVw8EqURfUAvIuuU7pcNhSx
         BcSRKALnrbWuf0XJjsxEuB37ZqfdNSPFEgGBNEnphpx4QxMXPcG8HvduhqMhG88M6ylo
         GAYiN6iIAX0cHm34LJ1QFpmwT4Dtb9thCKXvRW0sk1+SXLGWdaK2NLP1OjM/32gq7gnl
         kHXzJeYFdSiTJiF2F5Z8ClprsMxEUoXFmQorqoSNWs37Mg4kO2uoGpM2h1ts1Vz1RiHr
         31v1GtrhwR8H5ygUsU7xzO5XtEcUPANSvfH2zPwF3PbX4p3BFQpE+24eOOWNADDgS0dR
         UiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IvTxsHSrT5WqhfqZ1UE7wrX/qNYGR7vcH+V9R3apHUE=;
        b=E5wufle3J0S/DblJvaI1amxYcsdZohRoH2EQhrzKeY421+GkfIvrtp2JT/qJIEbIwQ
         oON3e5akUzmdn+PrHdKQ2kbpt5V8PLcRE6NtUjVPKBH4FoOGDGYtvcq+WqB5LaLScR3z
         tx+HeZ7CGO3wzRRVGXEEc2Q+GOkSBc8nZfv7wsf+c/Uf9jmEilIh9r13aw1YyISJF7S8
         cmanbYqsvCz/3zVxmjAAgK6FkA9YKXobvebFC5vUtch7HfXE7B7aWBaIwNzDU8DGALh7
         KX+sP1S8cNL5Rl/RFdjkBEZkISSLZ4DV2D2CjQ8Q9Fg3Nm5SG4qtxhBIfcnzxGQzy4HB
         Cb3Q==
X-Gm-Message-State: AOAM531s5lFgpXMsu6o4Dho7mSDxqtkqN0ojnAz2UhAIudSPIygSrHPP
        3DuSZYqgD9dsSYt7SxkiqFYKbg==
X-Google-Smtp-Source: ABdhPJyg4Exz9Z6Gx6smVH1W8R9vd34HiFs5NJcTiRcVrY1KypmEb7e+ZI1F3OXhgxvm+XgL/I78Cw==
X-Received: by 2002:a17:90a:384a:: with SMTP id l10mr9553625pjf.168.1634085569395;
        Tue, 12 Oct 2021 17:39:29 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id 22sm12417786pgn.88.2021.10.12.17.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:39:28 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:39:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211013003916.GA130842@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi German,

On Mon, Oct 11, 2021 at 04:55:37PM +0100, German Gomez wrote:
> Hi Leo,
> 
> On 06/10/2021 10:51, Leo Yan wrote:
> > On Wed, Oct 06, 2021 at 10:35:20AM +0100, German Gomez wrote:
> >
> > [...]
> >
> >>> So simply say, I think the head pointer monotonically increasing is
> >>> the right thing to do in Arm SPE driver.
> >> I will talk to James about how we can proceed on this.
> > Thanks!
> 
> I took this offline with James and, though it looks possible to patch
> the SPE driver to have a monotonically increasing head pointer in order
> to simplify the handling in the perf tool, it could be a breaking change
> for users of the perf_event_open syscall that currently rely on the way
> it works now.

Here I cannot create the connection between AUX head pointer and the
breakage of calling perf_event_open().

Could you elaborate what's the reason the monotonical increasing head
pointer will lead to the breakage for perf_event_open()?

> An alternative way we considered to simplify the patch is to change the
> logic inside the find_snapshot callback so that it records the entire
> contents of the aux buffer every time.
> 
> What do you think?

We cannot do this way.  If we send USR2 signal with very small interval,
then it's possible the hardware trace data cannot fill the full of AUX
buffer.  You could use below commands for the testing and should can
observe it produces small chunk trace data:
  
  perf record -e arm_spe_0// -S -a -- dd if=/dev/zero of=/dev/null &
  PERFPID=$!
  sleep 1
  kill -USR2 $PERFPID
  sleep .1
  kill -USR2 $PERFPID

Thanks,
Leo
