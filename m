Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A18C07E9B
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 19:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5EED61997
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 19:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhGETgV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhGETgU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 15:36:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58414C06175F
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jul 2021 12:33:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o18so18561037pgu.10
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jul 2021 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zIl8Ci3/1Rb8HyDZ+679iHFrBuyWXwlCKfudoOUUc8o=;
        b=M9X8FRlU1WVX5FylcbdqKOhN2vt1WrSjqkkEoVr3QLDGvQX2h656dRVbkoKgzoxuP5
         Kg4b5gnvHnAUo9wkPnAewymivlgrO9Hz1pjpAp55EbjtY67o+NdbopjoznIz4Z4CLbH4
         LDdnAGbfkqBqV/p3ILLynq6/NEds3A5Aj3rLBaQVcfodoR5ylDuwm5agGneJouiicfkf
         CljamH6c2oLxkCaQUwUm/rxmyfqrv+mtGqQKZDQGvriXVFToJdgaFylKigAGwLouQ+op
         A9Owpk2EdCGtu2HG6EcO60+QYtmrtab7aYiHVdgNrcD/f88X8ntCTP0MV8CRgj8hPx0G
         1jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zIl8Ci3/1Rb8HyDZ+679iHFrBuyWXwlCKfudoOUUc8o=;
        b=Q1eUKO4F5qBziJLnv4a6lpwvSqbQYeOWt1wLKZnsTpN543syRPZIqETNi/OPxFGejP
         56smVtWcZtEotuwHhR0KKnttldzUFJTeaoHTY0bFg57C379xrX+brHs8XXjATSgcGEL5
         2ntlrda1wOHwOSZvhoF7WCpkyzQ+rFe3HD6q2dYPRIgCdGfeburtlbIFUz89ecNfD/W4
         hRqJwrJjsH6N9d65lUcrPVtfvZ8W/TaPEBA3/t8bhAzufDapwHyuRoIBX/B8aMhGIfg9
         NMsx0V+KQ9RzZjqIubARtP+0VNJQtKdQOloGBrEnebq7WBtrVhX0UmgsR26OfPCjCOZW
         sn4A==
X-Gm-Message-State: AOAM5336bwupwO5kmS/cwYF0rnDkyZyvRaMi2s9AQZBd/KAjS/uLfITV
        bRU4Xo9lNqvy6oXWSEeWy1KmFg==
X-Google-Smtp-Source: ABdhPJzZdG1r7whoS+mG6g2z6jtYLYZzcwJzHnt/HgsgIM2doMudRbuO4ur6937Cb/GjWX4o2uET3A==
X-Received: by 2002:a65:62d3:: with SMTP id m19mr17401734pgv.225.1625513621901;
        Mon, 05 Jul 2021 12:33:41 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a65sm9979651pfa.11.2021.07.05.12.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 12:33:41 -0700 (PDT)
Date:   Mon, 5 Jul 2021 13:33:38 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
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
Message-ID: <20210705193338.GB1493103@p14s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624164303.28632-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 24, 2021 at 05:43:03PM +0100, James Clark wrote:
> Currently --dump-raw-trace skips queueing and splitting buffers because
> of an early exit condition in cs_etm__process_auxtrace_info(). Once
> that is removed we can print the split data by using the queues
> and searching for split buffers with the same reference as the
> one that is currently being processed.
> 
> This keeps the same behaviour of dumping in file order when an AUXTRACE
> event appears, rather than moving trace dump to where AUX records are in
> the file.
> 
> There will be a newline and size printout for each fragment. For example
> this buffer is comprised of two AUX records, but was printed as one:
> 
>   0 0 0x8098 [0x30]: PERF_RECORD_AUXTRACE size: 0xa0  offset: 0  ref: 0x491a4dfc52fc0e6e  idx: 0  t
> 
>   . ... CoreSight ETM Trace data: size 160 bytes
>           Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
>           Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>           Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
>           Idx:80; ID:10;  I_ASYNC : Alignment Synchronisation.
>           Idx:92; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>           Idx:97; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0xFFFFDE2AD3FD76D4;
> 
> But is now printed as two fragments:
> 
>   0 0 0x8098 [0x30]: PERF_RECORD_AUXTRACE size: 0xa0  offset: 0  ref: 0x491a4dfc52fc0e6e  idx: 0  t
> 
>   . ... CoreSight ETM Trace data: size 80 bytes
>           Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
>           Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>           Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
> 
>   . ... CoreSight ETM Trace data: size 80 bytes
>           Idx:80; ID:10;  I_ASYNC : Alignment Synchronisation.
>           Idx:92; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>           Idx:97; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0xFFFFDE2AD3FD76D4;
> 
> Decoding errors that appeared in problematic files are now not present,
> for example:
> 
>         Idx:808; ID:1c; I_BAD_SEQUENCE : Invalid Sequence in packet.[I_ASYNC]
>         ...
>         PKTP_ETMV4I_0016 : 0x0014 (OCSD_ERR_INVALID_PCKT_HDR) [Invalid packet header]; TrcIdx=822
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 88e8122f73c9..ad777c2a342f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2430,6 +2430,22 @@ static int cs_etm__process_event(struct perf_session *session,
>  	return 0;
>  }
>  
> +static void dump_queued_data(struct cs_etm_auxtrace *etm,
> +			     struct perf_record_auxtrace *event)
> +{
> +	struct auxtrace_buffer *buf;
> +	unsigned int i;
> +	/*
> +	 * Find all buffers with same reference in the queues and dump them.
> +	 * This is because the queues can contain multiple entries of the same
> +	 * buffer that were split on aux records.
> +	 */
> +	for (i = 0; i < etm->queues.nr_queues; ++i)
> +		list_for_each_entry(buf, &etm->queues.queue_array[i].head, list)
> +			if (buf->reference == event->reference)
> +				cs_etm__dump_event(etm, buf);
> +}
> +
>  static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  					  union perf_event *event,
>  					  struct perf_tool *tool __maybe_unused)
> @@ -2462,7 +2478,8 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  				cs_etm__dump_event(etm, buffer);
>  				auxtrace_buffer__put_data(buffer);
>  			}
> -	}
> +	} else if (dump_trace)
> +		dump_queued_data(etm, &event->auxtrace);
>  
>  	return 0;
>  }
> @@ -3038,7 +3055,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  	if (dump_trace) {
>  		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
> -		return 0;
>  	}
>  
>  	err = cs_etm__synth_events(etm, session);
> -- 
> 2.28.0
> 
