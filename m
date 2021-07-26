Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E09C4320A
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 09:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B6D60F11
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 09:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhGZIeh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 04:34:37 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51178 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhGZIeg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jul 2021 04:34:36 -0400
Received: by mail-wm1-f46.google.com with SMTP id m19so1008879wms.0;
        Mon, 26 Jul 2021 02:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8v0vqlaubPgIIDAlq605AnjjiTSeodXB7xwaNCFfSbo=;
        b=jyCL1Mhc3TDJdQtcW8kjaVhoWFDb9ffT3rt9XHs8jhuIU9+DNaOeocqQpAJWUel7ll
         p3uoor6wgAUp6qo6LpzQEnpqm7IIOZdki7WnIeyShDiYD+HI6iBxED2DhmEuxVYhjkVU
         j3SUOpJQi3BACHTUKJ1uRX+76NRbDkLkUjKyT1k7xpOHYXo1an7PBQ+cvZVk8OuvD9Ag
         YFkfHBMWfTdRUGQHrh9ZL5A+Pv0f1gky6x8jpRS8/mG+YWmMDN57kmlSH72U01/NBfVp
         naRVYOExGu9K4F2orHzG2NPdf55n1sd54DTGdQvnGDMB2XuvLznSKHY+bm7TMNY1Gf+O
         Q6UQ==
X-Gm-Message-State: AOAM5320jb4LXyMFV+IjO7nYNKjxWwRSi8zWIH5kkXdbqVzxZnJc07R9
        GOPiCxiUom/PJBxwMHmyPZY=
X-Google-Smtp-Source: ABdhPJxT2KRV7nFVsf0ZEFGAudzcRy6gawj1VFxAArTVxI7VTQokttCMHc0vpzw++EYI91RtgJmo4g==
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr3137794wmc.21.1627290904684;
        Mon, 26 Jul 2021 02:15:04 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t15sm41019214wrx.17.2021.07.26.02.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 02:15:04 -0700 (PDT)
Subject: Re: [PATCH] perf: don't install headers with x permissions
To:     acme@redhat.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210726071746.27294-1-jslaby@suse.cz>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <fa9833ed-1458-7437-e004-7c094f714abc@kernel.org>
Date:   Mon, 26 Jul 2021 11:15:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726071746.27294-1-jslaby@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 26. 07. 21, 9:17, Jiri Slaby wrote:
> install(1), by default, installs with rwxr-xr-x permissions. Modify
> perf's Makefile to pass '-m 644' when installing perf_dlfilter.h header.

Scratch this, there are more of them -- sent as v2.


-- 
js
suse labs
