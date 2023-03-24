Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43403C6FD1C
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Mar 2023 07:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCXHQR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Mar 2023 03:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCXHP5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2023 03:15:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E318E27D6F
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 00:15:39 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3e390e23f83so299171cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NStJZFS2Gb6txcjvYhiRXbaz73gXtLsJkraNktzIj+M=;
        b=slsc2orTdb1VUCunzmPASK4nSeDix1sYu5TaJq5kwU65mFCR8X0rNb9YuE2ny+8y2R
         /eo+4SdSntYlFbTiXaEwPShG8LowC41fc5upmDEcINNNipH7WuQfPRkL56nYvu38xnie
         MVuv64uYC/6sEeicN8dKz9HlkGd+aJr5hr60+UzJrMvvOSm2nQkZndND32XCTrYKP0ZI
         rR70PbmebEWnE0Ma87VI0D4C0jtnVI6EIq6bFqL5t+qsqcisWI4mfyB6ncqn7Z6sWEzl
         EwyPX9Nhyp4VidMgyK9YJ8gTFPZJjggC3BdTFjtAqUFAB4frFJJghT1eExM8nhSRkcJF
         CFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NStJZFS2Gb6txcjvYhiRXbaz73gXtLsJkraNktzIj+M=;
        b=2Y4XZUexNYG7sq/5eZiI0V/4NVP9Ljy+adV9YlRs1ocYwYzG9Zwy8fioYmQClFeqHI
         WrsYbK7qN9I+daPiP0ofRieoQVRU3/STQPv+X7977z3aioHkcsiVbK+hrV4mBErcoR3y
         yy3zQ9183Zik6IyQZ+CUUg4hPoBj3Q7W+Y6fE1WKY9mGaEecAlMOgWo6M0SlVYMQsgOE
         5iiRusl0Kr4l20TA8Z7sPozIp/dSbKmaikJUro1CUWR5Bon5WU6rQZpaqrwrf7ka2hD+
         G6yGiQEp2NN2EtlSl7gLTdfK7WE1AeJFL91OUH1aGTQPVqx0vVTO3LnRrW+nXAePd/2O
         VmOw==
X-Gm-Message-State: AO0yUKXqTPplqSlj3Uw/KfHedcLF+nDFzrAN524W/jn4ZQi1Oqct5Nsd
        lSSjzoMWol+aljapunMJoYlopfHTwgq5nDZX87lXYpH/8zecEH6+Sr0=
X-Google-Smtp-Source: AK7set+/2UJan9SLGGi7Ef+sZwTZ+aksfDb9pKaZEb6kZWUrij58g9ICurzl9OlsjNwWH5D22OYmJzASauXiFnC7f4w=
X-Received: by 2002:ac8:7f41:0:b0:3d3:3cc:6f70 with SMTP id
 g1-20020ac87f41000000b003d303cc6f70mr157028qtk.17.1679642138794; Fri, 24 Mar
 2023 00:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230323192028.135759-1-irogers@google.com> <20230323192028.135759-9-irogers@google.com>
 <44476adc-3797-504b-2b82-8ec670c691b6@linux.intel.com> <641cba052d0f8_1b98bb294ab@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <641cba052d0f8_1b98bb294ab@dwillia2-xfh.jf.intel.com.notmuch>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 24 Mar 2023 00:15:27 -0700
Message-ID: <CAP-5=fX5KaQE+P5X+jBt9uFymkjWbUi_0dgq2w=18jX8vVQ1XQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] perf metrics: Add has_optane literal
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, samantha.alt@intel.com,
        weilin.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 23, 2023 at 1:44=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Liang, Kan wrote:
> >
> >
> > On 2023-03-23 3:20 p.m., Ian Rogers wrote:
> > > Add literal so that if optane memory isn't installed we can record
> > > fewer events.
> >
> > I think we call it pmem (Persistent Memory) everywhere in the Linux
> > code. Maybe we should use #has_pmem instead?
>
> That makes sense especially because has_optane implies more precision
> than the the check is performing. In general Optane is probably the
> widest deployed NVDIMM type, but this check will succeed with battery
> backed NVDIMMs and emulated PMEM in VMs which I think is perfectly ok
> for making a default event record decision.

Thanks, I'll change this in v3.

Ian
