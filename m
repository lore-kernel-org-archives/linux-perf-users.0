Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F8C7EE25
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 10:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjFHKcU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjFHKcT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 06:32:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227082113
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 03:32:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2564dc37c3eso1210025a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686220337; x=1688812337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+5ci3F9H5iPKnXYZzOcI9CsPolbMf1gP+o5j9926rE=;
        b=dB9UrO6+ganb89zL52J2NM7LMln/CXJYT3Ib25+RSZwbv4F/6ChFJg/VDk9RbFjzik
         VhDMxj8/R/htZAVwp2b4d85Hr25nKbuOMpw4P4k9mrOrK6Z/NqWcb6artb55cx7WWV81
         gzIQq/8uxxilLBVYBrcmwIlA5nJDFzGj4I2ZB2J3wK8H5EkAUlCcrndOo2Km63eC6Vbi
         Lq2WeyQ1pcjT+YQ6+Bgv2nA45x6HTHe2GzZ2HrwXdFVC27hw7+9MvGDp3FWT1tO1knE8
         qrGnj7CbGi+N3Z/H4qT+/7+Ig0nxSc4t0DcQ7qKLTeDQRyCggj6P4TSu/IuQLWavUjNB
         SsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220337; x=1688812337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+5ci3F9H5iPKnXYZzOcI9CsPolbMf1gP+o5j9926rE=;
        b=M5ySdLwvXzQeIUdTrBWD9qcwARMpOBCAuxdbVribbroZmBHtftOeLsARLx1Rkg35LI
         s88oGx3oUDIFxJO2tBPdOe0dpF5tEIhXgtosFJIDN2jPdjZo9m8ZmUewGGxywYEa4tP1
         VgUKrUoIJBavi4/cNgmieJvKYaqFHIlcaltTEzKxL0fRfZX+Wd0vR6w/Nvy0cDoXgL5e
         uR8e786ai/yjNzI+OVha6TarqjvJ7dXajThdS04zU2UovbIWLc5TqaNUH8CO3TngEG0o
         7Nc7A9D4SUqtDGcM4HRd58llPmKYwOR26Q0DUo+JuEpoHblZADJXYrgQq+kvY8t2jd96
         2pQQ==
X-Gm-Message-State: AC+VfDwm085ytp0alj9v8vti+BEQhbxGuovrH995beX2de5+9evVg+ci
        CRoi85X3iVzFIYcsfNpDg5eocA==
X-Google-Smtp-Source: ACHHUZ5Np9xRp10Pl2SNolMvnYQDv8n3Gci/B5QYG/MyQLvSXo5r+3o35BlAoAlijQ6sgMTWKzXn+A==
X-Received: by 2002:a17:90a:fa0d:b0:256:7d07:c8a1 with SMTP id cm13-20020a17090afa0d00b002567d07c8a1mr2058796pjb.12.1686220337457;
        Thu, 08 Jun 2023 03:32:17 -0700 (PDT)
Received: from leoy-huanghe ([156.59.39.101])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a01cf00b00252d960a8dfsm2962730pjd.16.2023.06.08.03.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:32:17 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:32:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf cs-etm: Use previous thread for branch sample
 source IP
Message-ID: <20230608103210.GC123723@leoy-huanghe>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-3-james.clark@arm.com>
 <20230527090635.GB886420@leoy-yangtze.lan>
 <630ab636-107d-4b12-5454-2ee91ad43543@arm.com>
 <1e7aa657-6d1e-9e7c-95cb-b32d307abe93@arm.com>
 <20230608102555.GB123723@leoy-huanghe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608102555.GB123723@leoy-huanghe>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 08, 2023 at 06:25:55PM +0800, Leo Yan wrote:

[...]


> Seems to me, this is a synchronization issue between the field
> 'tidq->prev_thread' and 'tidq->prev_packet'.
> 
> It's still hard for me to understand "two adjacent packets on the same
> thread will say they branched from the previous thread that ran", IIUC,
> even we move thread swapping into cs_etm__set_thread(), if the two
> adjacent packets are in the same thread context, we can skip to update
> fields 'tidq->prev_thread' and 'tidq->prev_packet'.

Sorry for typo, here should be:

... skip to update fields 'tidq->prev_thread' and 'tidq->thread'.

> So I am curious if below cs_etm__set_thread() works or not?
> 
> static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
> 			       struct cs_etm_traceid_queue *tidq, pid_t tid)
> {
> 	struct machine *machine = &etm->session->machines.host;
> 
> 	/* No context switching, bail out */
> 	if ((tidq->thread->tid != tid)
> 		return;
> 
> 	/* If tid is -1, we simply use idle thread context */
> 	if (tid == -1)
> 		goto find_idle_thread;
> 
> 	/*
> 	 * The new incoming tid is different from current thread,
> 	 * so it's to switch to the next thread context.
> 	 */
> 
> 	/* Swap thread contexts */
> 	thread__put(tidq->prev_thread);
> 	tidq->prev_thread = thread__get(tidq->thread);
> 
> 	/* Find thread context for new tid */
> 	thread__zput(tidq->thread);
> 	tidq->thread = machine__find_thread(machine, -1, tid);
> 
> find_idle_thread:
> 	/* Couldn't find a known thread */
> 	if (!tidq->thread)
> 		tidq->thread = machine__idle_thread(machine);
> }
> 
> Thanks,
> Leo
