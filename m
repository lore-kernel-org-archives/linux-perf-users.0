Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43E8C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 05:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD0660F38
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 05:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhHDFtv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:49:51 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53130 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhHDFtv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 01:49:51 -0400
Received: by mail-wm1-f54.google.com with SMTP id n11so476594wmd.2;
        Tue, 03 Aug 2021 22:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GgdNz1NgdkEFekSLCkbFNoAD3gpMYm5SQwudLZkpI3s=;
        b=jKO2Kke4trqSkgaxC7tOVaA20x2UKiU5MC/uyspehE2OlCBg4Stit3nbx9hdd11r23
         X0FLZh6HCLt9Yoob3yjk/OnveChPP459yIbaobMMNk80tOE4o1S7z/GWtKA/aiLB7zMV
         gvUwQCuFl+mAx4yk7wzcZkjxgJUYIZjFzw+R8lytQUGsG4wQLozwfNfGffcdTbAgn6yr
         hbxrJlgyLrWeDSUO5anXPsyhfZKliIMUT80wJ+FwkHh3fg5nT5aHjxz4BjbVrmbHB5sh
         0YJjg+h6zOgg48UaoMszd2CZIyGyKAuK11S/AIRUS+JKJ3J/Rklni5PEF6QCCzL0G2WL
         Q8Lw==
X-Gm-Message-State: AOAM533k9uIJm/pFEIv0Kj6lpVq0Bl1I7k/ElGlygf/AS6+JHBmRL/t/
        d1tC1h4MvkVJOv0/2xf6dfo=
X-Google-Smtp-Source: ABdhPJxofAvpnCFZX4nJ0UPWt2mV75icXOQNyrc4tU5T+2WesSFrsXlPCkkbDyw6LlSm0GWW7alUyA==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr7735903wmb.178.1628056178447;
        Tue, 03 Aug 2021 22:49:38 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c10sm1051400wmb.40.2021.08.03.22.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 22:49:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf: remove shebang from
 scripts/{perl,python}/*.{pl,py}
To:     Adrian Hunter <adrian.hunter@intel.com>, acme@redhat.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210726091434.5000-1-jslaby@suse.cz>
 <20210726091434.5000-2-jslaby@suse.cz>
 <d916a46f-91fb-4e11-b72e-b96a73971117@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8c62e5f1-be91-0104-898b-250d9f533f8f@kernel.org>
Date:   Wed, 4 Aug 2021 07:49:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d916a46f-91fb-4e11-b72e-b96a73971117@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 03. 08. 21, 13:44, Adrian Hunter wrote:
> On 26/07/21 12:14 pm, Jiri Slaby wrote:
>> The scripts cannot be executed on their own. The python ones were always
>> installed without x permissions, the perl ones fail anyway:
>>    BEGIN failed--compilation aborted at /usr/lib/perf-core/scripts/perl/rw-by-pid.pl line 18.
>> so there is no point to have a shebang in them. This causes rpmlint to
>> complain too:
>>    W: non-executable-script /usr/lib/perf-core/scripts/perl/rw-by-file.pl 644 /usr/bin/perl -w
>>
>> Hence drop shebangs in them all and remove x permissions in the
>> repository. If anyone wants some of them executable, they need to fix
>> the install scripts first.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> ---
>>   tools/perf/scripts/perl/rw-by-file.pl            | 1 -
>>   tools/perf/scripts/perl/rw-by-pid.pl             | 1 -
>>   tools/perf/scripts/perl/rwtop.pl                 | 1 -
>>   tools/perf/scripts/perl/wakeup-latency.pl        | 1 -
>>   tools/perf/scripts/python/exported-sql-viewer.py | 1 -
> 
> exported-sql-viewer.py is a standalone executable

That's great, but in fact noone can run it when make-installed as I 
stated above:

 >> If anyone wants some of them executable, they need to fix
 >> the install scripts first.

See:
$(INSTALL) scripts/python/*.py -m 644 -t 
'$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python';

thanks,
-- 
js
suse labs
