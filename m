Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8ACC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 06:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991A4613CE
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 06:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbhI2GJ6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243377AbhI2GJ5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Sep 2021 02:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632895697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRG+QkBHb7+dJu7hgxSpKrOu8STtKM5W0f2Gvnwat7Q=;
        b=L9abT1y8uDdRCrh+HmVAEYGNY8zUwHSFra7Zswkt3JF5ocV4I+u4xxpHpc6wTDSDt8q/CA
        ifqIFKLgiiIwbX+le/ZdFT8fUXbWZUyIBrf4h1ayyRqdgaJ131OVZYU1W8uGwDkyYqpECx
        5qYDIGfDJjI8MnImhKmm9EfVTra+lcE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-g8HA7v3sOtGkoPlKUpQ20w-1; Wed, 29 Sep 2021 02:08:15 -0400
X-MC-Unique: g8HA7v3sOtGkoPlKUpQ20w-1
Received: by mail-ed1-f70.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso1257520edi.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 23:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XRG+QkBHb7+dJu7hgxSpKrOu8STtKM5W0f2Gvnwat7Q=;
        b=UisbPelYLxBseq+7czP77wAOEsQ5sOkvXIuhIGlZBsM9lhgpmkSRimBDuDzyF1iaah
         lrqCX2bmIonKaxiiWlVvXHE354rUmQiOQvSRdJUDy9r0z1P9TffkxgXWchjFOmQ7RslC
         DqAw4MRgRyJZLaWTezOZ9+P3/3q0+3t4a6WagHrIh7ZECnIju11Vg4gN6PrrM63EmA0p
         M1wOTJ49CmQ4pDPX+7ZaDp5nqBFyrxVB0QkdfiayCugsW1I4uv9bLEV2IqjPDUz4houq
         b4aQ8NewrfUHFcWXLUMFbWoNBOKHwEpCQHr5g6Ppz0+x6xCICVo+VbWygHd94CK4MZ7z
         NBqw==
X-Gm-Message-State: AOAM530lNEVtX2Sh2Qml1p0hezoefYpl5Bw9qUaiwb6q8LWy+QK/GeT2
        COpQESYEm9zY6P9NIb9enrL1FzjYk9+TYoTGI9WuX7+Vhe4XrPfglQxGknqb8SVUryKMJGaWWGT
        4vnN3MxvAVGoLmcdcMtB+hpW8wGadoA==
X-Received: by 2002:a17:906:6558:: with SMTP id u24mr11934218ejn.361.1632895693904;
        Tue, 28 Sep 2021 23:08:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX98eCLuPMiPp7TmfnYb37KWWvnPZgKfuOxIgkhZ2QV4uQYuKD/boIURtrlR08YcB6Uc6NuA==
X-Received: by 2002:a17:906:6558:: with SMTP id u24mr11934205ejn.361.1632895693735;
        Tue, 28 Sep 2021 23:08:13 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id v13sm774085edr.0.2021.09.28.23.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 23:08:13 -0700 (PDT)
Date:   Wed, 29 Sep 2021 08:08:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: problem with 'perf script -F weight'
Message-ID: <YVQCy2yEK00XbWAq@krava>
References: <YVNq9av/3Lwmom4T@krava>
 <732928be-f438-120f-7c9f-685630147495@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <732928be-f438-120f-7c9f-685630147495@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 28, 2021 at 05:35:51PM -0400, Liang, Kan wrote:
> 
> 
> On 9/28/2021 3:20 PM, Jiri Olsa wrote:
> > Joe reported broken -F weight in perf script with (on x86):
> > 
> >    # ./perf mem record
> >    # ./perf script -F weight
> >    Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot print 'weight' field.
> > 
> > the problem seems to be introduced with the WEIGHT_STRUCT change:
> >    ea8d0ed6eae3 perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT
> > 
> > which enables WEIGHT_STRUCT sample_type on x86 instead of WEIGHT,
> > and leaves 'perf script -F weight' in the dark
> 
> Right, I missed the support for the perf script. Because the default perf
> script worked. It didn't ring the bell. :(
> 
> > 
> > I'm not sure what the fix should look like.. should we allow user
> > to use just 'WEIGHT' sample type? or is there a way to get original
> > weight from 'WEIGHT_STRUCT' data, so we could fix just perf script?
> 
> Just fix the perf script is enough.
> Could you please try the below patch?
> 
> (I probably need to split the patch into two patches, since it fixed two
> issues, one is this error, the other is to print the instruction latency.
> Anyway, let's try it first.)
> 
> From 99443f49a6236ef6e3bea3930792967a7863f753 Mon Sep 17 00:00:00 2001
> From: Kan Liang <kan.liang@linux.intel.com>
> Date: Tue, 28 Sep 2021 13:57:18 -0700
> Subject: [PATCH] perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support
> 
> -F weight in perf script is broken.
> 
>   # ./perf mem record
>   # ./perf script -F weight
>   Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot
> print 'weight' field.
> 
> The sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
> PERF_SAMPLE_WEIGHT sample type. They share the same space, weight. The
> lower 32 bits are exactly the same for both sample type. The higher 32
> bits may be different for different architecture. For a new kernel on
> x86, the PERF_SAMPLE_WEIGHT_STRUCT is used. For an old kernel or other
> ARCHs, the PERF_SAMPLE_WEIGHT is used.
> 
> With -F weight, current perf script will check the input string "weight"
> with the corresponding sample type. However, the commit ID ea8d0ed6eae3
> ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT") didn't update the
> sample type for perf script. The check fails with a new kernel on x86.
> 
> Use PERF_SAMPLE_WEIGHT_TYPE, which supports both sample types, to
> replace PERF_SAMPLE_WEIGHT.
> 
> Also, print the instruction latency for PERF_SAMPLE_WEIGHT_STRUCT type.
> 
> Reported-by: Joe Mario <jmario@redhat.com>
> Fixes: ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 6211d0b..fd73bbc 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -459,7 +459,7 @@ static int evsel__check_attr(struct evsel *evsel, struct
> perf_session *session)
>  		return -EINVAL;
> 
>  	if (PRINT_FIELD(WEIGHT) &&
> -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT",
> PERF_OUTPUT_WEIGHT))
> +	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT",
> PERF_OUTPUT_WEIGHT))
>  		return -EINVAL;
> 
>  	if (PRINT_FIELD(SYM) &&
> @@ -2036,8 +2036,11 @@ static void process_event(struct perf_script *script,
>  	if (PRINT_FIELD(DATA_SRC))
>  		data_src__fprintf(sample->data_src, fp);
> 
> -	if (PRINT_FIELD(WEIGHT))
> +	if (PRINT_FIELD(WEIGHT)) {
>  		fprintf(fp, "%16" PRIu64, sample->weight);
> +		if (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
> +			fprintf(fp, ",0x%" PRIx16, sample->ins_lat);

this will add extra number to weight.. should we add separate column
for that -F 'insn-lat' ? users expect just single value for -F weight

thanks,
jirka

> +	}
> 
>  	if (PRINT_FIELD(IP)) {
>  		struct callchain_cursor *cursor = NULL;
> -- 
> 2.7.4
> 
> Thanks,
> Kan
> 

