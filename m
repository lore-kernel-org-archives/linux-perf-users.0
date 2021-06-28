Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B80C11F64
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 20:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AA761C4D
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 20:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhF1UED (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhF1UEC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Jun 2021 16:04:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA13C061760
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jun 2021 13:01:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l11so10888076pji.5
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jun 2021 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JUCHMqimV26M+N4zD2aR1uV6fMENRzPa10+B4/WZOb4=;
        b=zAvdAyhu0J8Ne7myACLAgGKe4adrqcNWMRAndZo+oEEhBBEc4Uw+ptB9ktsWEoXmXV
         6HHAdtIuMz+cOl5H7G2rZ7QOb0WrXtx4R0OD5oLT3ex6vzdTZ5ggHzYbg1qBbvVHgF7A
         DB8BKopLFYska8Jsy8s+AoxfZUpqXDOoH68rHxPlL4PMfBxEjbUnvAnIzmOgK1xVuIJM
         tHdjuXNmAMTxhdAk6AgiZCCGs+5rFjrmkkRdgCZzsRdQ7m6HULbk8DA9wMSyYcCn3jd1
         66xMkA+4QcZQu0Fd5gkWWBO3m3fwkDSnelearFAVLZy+b9U+ANKhFWlbBXxFf5Dd2mo2
         zuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JUCHMqimV26M+N4zD2aR1uV6fMENRzPa10+B4/WZOb4=;
        b=E4KSfOj8lvNG1FyZ3GLPBjkzR+qoZ3mYbaQLzYl0HUQh2uRBNuwmw/KnHnisftED9F
         /XqDuC37cmBzpZv/U6uhTeURKi/D1esnuh8a1jdBsRXku1v5sUuAs4LQ6YGuH7u42M3e
         28a5JjPqcIYnTubJK9ZZovj0XabANb7nN1R0HWB/tvMNy4dmn+5asi90bEWBNxBPe5+P
         TNNS1qPvOCdxUP8ySkNzdabwT9V+GfVlmeMchRBtPrBo4K3er87+PyoqTZ9FGEgvA3c7
         j0kRYwyPaU2gGB4cox8GAL1dvHpCMhICR4M0H5CEYYqI7XJ45Y6JmoTENGe9JMudc0wb
         CDcg==
X-Gm-Message-State: AOAM531olXVWWWckbQmvPnQWkEThLMwvs9RIYjxgy0pJ0MH1hk/WUb50
        ZKMfzMp9wps71IiEzXVZohuNpg==
X-Google-Smtp-Source: ABdhPJyCIzhw4fmNkoS6QhjFHkMXV7pgGimaStifjJ/ZNc2iiWyX48Qh+GEnIqmouApNjPRIzxDZ2A==
X-Received: by 2002:a17:902:bd42:b029:123:1986:d0c3 with SMTP id b2-20020a170902bd42b02901231986d0c3mr24447882plx.74.1624910495372;
        Mon, 28 Jun 2021 13:01:35 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c5sm15500289pfn.144.2021.06.28.13.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:01:34 -0700 (PDT)
Date:   Mon, 28 Jun 2021 14:01:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, acme@kernel.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
Message-ID: <20210628200132.GB1200359@p14s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
 <20210628012744.GA158794@leoy-ThinkPad-X240s>
 <c7906b72-e547-da37-c387-23de65831ac4@arm.com>
 <20210628120802.GC200044@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628120802.GC200044@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 28, 2021 at 08:08:02PM +0800, Leo Yan wrote:
> On Mon, Jun 28, 2021 at 11:38:34AM +0100, James Clark wrote:
> 
> [...]
> 
> > >>  static int cs_etm__process_auxtrace_event(struct perf_session *session,
> > >>  					  union perf_event *event,
> > >>  					  struct perf_tool *tool __maybe_unused)
> > >> @@ -2462,7 +2478,8 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
> > >>  				cs_etm__dump_event(etm, buffer);
> > >>  				auxtrace_buffer__put_data(buffer);
> > >>  			}
> > >> -	}
> > >> +	} else if (dump_trace)
> > >> +		dump_queued_data(etm, &event->auxtrace);
> > > 
> > > IIUC, in the function cs_etm__process_auxtrace_event(), since
> > > "etm->data_queued" is always true, below flow will never run:
> > > 
> > >     if (!etm->data_queued) {
> > >         ......
> > > 
> > >         if (dump_trace)
> > >             if (auxtrace_buffer__get_data(buffer, fd)) {
> > >                     cs_etm__dump_event(etm, buffer);
> > >                     auxtrace_buffer__put_data(buffer);
> > >             }
> > >     }
> > > 
> > > If so, it's better to use a new patch to polish the code.
> > > 
> > 
> > Hi Leo,
> > 
> > I think this is not true in piped mode because there is no auxtrace index.
> > In that mode, events are processed only in file order and cs_etm__process_auxtrace_event()
> > is called for each buffer.
> > 
> > You can reproduce this with something like this:
> > 
> >      ./perf record -o - ls > stdio.data
> >      cat stdio.data | ./perf report -i -
> 
> You are right!  I tried these two commands with cs_etm event, just as
> you said, in this case, the AUX trace data is not queued; so the flow
> for "if (!etm->data_queued)" should be kept.  If so, I am very fine
> for current change.  Thanks for sharing the knowledge.
> 
> > There are some other Coresight features that don't work as expected in this mode, like
> > sorting timestamps between CPUs. The aux split patchset won't work either because random
> > access isn't possible. And the TRBE patch that I'm working on now won't work, because it
> > also requires the random access to lookup the flags on the AUX record to configure the 
> > decoder for unformatted trace.
>

There is a lot of things happening in this area.  Based on the above should I
still plan to review this set or should I wait for another revision?

Thanks,
Mathieu

> Cool, looking forward for the patches :)
> 
> Leo
