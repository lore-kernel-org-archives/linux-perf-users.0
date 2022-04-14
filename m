Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCDBC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Apr 2022 11:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiDNLD4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Apr 2022 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiDNLDz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Apr 2022 07:03:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B553C4B7
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Apr 2022 04:01:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s25so5390748edi.13
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Apr 2022 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qVPWX0NcwYPADIuSMjN5vY8ZOKBiZLiUPYzVutSubY0=;
        b=h32dmWUvdgZ9qgpE9bvZg9GQoBPG9oV8SxUqleymdkXJMcHKUmXFdOzXldZFMPB2pf
         Y9Oj5UqPXfyR7/kXBaVqWOzHVtB3SuAbbOph9QrqCTCSxezSMK3J3I2ucT4V6wke1EDX
         y2NbwAj2o8bG1cpkC4CN/E7teW9lxYQfsAq3pFHOVQZ6lutESB5218RbTCdh7aSEar8B
         FBOMg9AQhpbJTdZaKcSZu+M2dx8XDlr6AZH9IJq+UUY/1Odxds0JGJTmc9DexM2yqDtm
         khh2FUrYQIiWkCngjI9ZNXjW+x/Ma84Sb+OkxNb2QQfYSoQBwvzwPxvhuBVxojTz2SMH
         sIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qVPWX0NcwYPADIuSMjN5vY8ZOKBiZLiUPYzVutSubY0=;
        b=FXZopH2etf+jj/Q9l3YptoeO5CIi6NA05eeyC6Da6rTIgVTaunbcrge7+eDrP6ELkH
         WMQoyBZoI3ynw/kJiv5m4ZsJ/89WSlqEU34zVFHRuNdbDRsVuFw/rDa9Y1z+w8luakIF
         iCsys1iru8BbID5yKbrf57Wz3nOAn39XznD10+0i4oLi0hlukaQc2K9J81ZwhVeIcDpQ
         PVyG+NtJuWYsDVBtRJvSJbPgg09SGWPSzlgbSbPwzV4sA93WKkiNKpUZafY9GyUAbR19
         vS9gkTzwXD15w7Mt5ZmH9hUj5t334ZkFl/8OiI8p4JXNNqSPQHHlW/acq0WBbY1jnY5Z
         zZwQ==
X-Gm-Message-State: AOAM531mqrE//hBNOWaeqQvGrT6Qy1kGl2NOANlY7shOme9nDRiE9n4I
        eeq0Tw2lWX7dxrQofvPzeIa9Rw==
X-Google-Smtp-Source: ABdhPJwb61LRI992HKv1xOAGxblCmB9FMrhAPcn3lxwB++HcuxKWM56ugynaBRppuJhRse1afygEJA==
X-Received: by 2002:aa7:d497:0:b0:41d:6fed:9f90 with SMTP id b23-20020aa7d497000000b0041d6fed9f90mr2309569edr.325.1649934089340;
        Thu, 14 Apr 2022 04:01:29 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm523169ejc.110.2022.04.14.04.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:01:28 -0700 (PDT)
Date:   Thu, 14 Apr 2022 19:01:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE
 event
Message-ID: <20220414110124.GB598831@leoy-ThinkPad-X240s>
References: <20220413092317.756022-1-leo.yan@linaro.org>
 <Yld4fzWWY07ksB+5@kernel.org>
 <9ad30442-41f8-6e17-cb4a-ab102b3ebd69@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad30442-41f8-6e17-cb4a-ab102b3ebd69@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 14, 2022 at 11:29:48AM +0100, James Clark wrote:
> On 14/04/2022 02:27, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Apr 13, 2022 at 05:23:17PM +0800, Leo Yan escreveu:
> >> Since commit bb30acae4c4d ("perf report: Bail out --mem-mode if mem info
> >> is not available") "perf mem report" and "perf report --mem-mode"
> >> don't report result if the PERF_SAMPLE_DATA_SRC bit is missed in sample
> >> type.
> >>
> >> The commit ffab48705205 ("perf: arm-spe: Fix perf report --mem-mode")
> >> partially fixes the issue.  It adds PERF_SAMPLE_DATA_SRC bit for Arm SPE
> >> event, this allows the perf data file generated by kernel v5.18-rc1 or
> >> later version can be reported properly.
> >>
> >> On the other hand, perf tool still fails to be backward compatibility
> >> for a data file recorded by an older version's perf which contains Arm
> >> SPE trace data.  This patch is a workaround in reporting phase, when
> >> detects ARM SPE PMU event and without PERF_SAMPLE_DATA_SRC bit, it will
> >> force to set the bit in the sample type and give a warning info.
> >>
> >> Fixes: bb30acae4c4d ("perf report: Bail out --mem-mode if mem info is not available")
> >> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >> Tested-by: German Gomez <german.gomez@arm.com>
> >> ---
> >> v2: Change event name from "arm_spe_" to "arm_spe";
> >>     Add German's test tag.
> > 
> > Tentatively applied, would be great to have James' and Ravi's
> > Acked-by/Reviewed-by, which I'll add before pushing this out if provided
> > in time.
> > 
> > - Arnaldo
> >  
> >>  tools/perf/builtin-report.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> >> index 1ad75c7ba074..acb07a4a9b67 100644
> >> --- a/tools/perf/builtin-report.c
> >> +++ b/tools/perf/builtin-report.c
> >> @@ -353,6 +353,7 @@ static int report__setup_sample_type(struct report *rep)
> >>  	struct perf_session *session = rep->session;
> >>  	u64 sample_type = evlist__combined_sample_type(session->evlist);
> >>  	bool is_pipe = perf_data__is_pipe(session->data);
> >> +	struct evsel *evsel;
> >>  
> >>  	if (session->itrace_synth_opts->callchain ||
> >>  	    session->itrace_synth_opts->add_callchain ||
> >> @@ -407,6 +408,21 @@ static int report__setup_sample_type(struct report *rep)
> >>  	}
> >>  
> >>  	if (sort__mode == SORT_MODE__MEMORY) {
> >> +		/*
> >> +		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
> >> +		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
> >> +		 * compatibility, set the bit if it's an old perf data file.
> >> +		 */
> >> +		evlist__for_each_entry(session->evlist, evsel) {
> >> +			if (strstr(evsel->name, "arm_spe") &&
> >> +				!(sample_type & PERF_SAMPLE_DATA_SRC)) {
> >> +				ui__warning("PERF_SAMPLE_DATA_SRC bit is not set "
> >> +					    "for Arm SPE event.\n");
> 
> Looks ok to me. Personally I would remove the warning, otherwise people are going to start
> thinking that they need to do something about it or something bad has happened.
> 
> But because we've fixed it up there shouldn't really need to be a warning or any action.

Understand.  The warning is not bad for developers but it might
introduce confusion for users, and if we really want to check the sample
type then we can use 'perf evlist' command, so it's not very useful for
the warning.

I will remove the warning and resend a new patch.

> I don't feel too strongly about this though, so I will leave it up to Leo to make the
> final decision:
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks a lot for reviewing.
Leo
