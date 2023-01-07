Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCF3C46467
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 Jan 2023 18:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAGSla (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 7 Jan 2023 13:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAGSl3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 7 Jan 2023 13:41:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D581BC91
        for <linux-perf-users@vger.kernel.org>; Sat,  7 Jan 2023 10:41:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47365352C2;
        Sat,  7 Jan 2023 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673116886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4hiDNpa3rBvHTs0MQ07bIhEgr4LQ6lpDQCuD/c1IEI=;
        b=SSveoXmsO79854DpErtHCBirWGIUQ9g+P+v3NfPBFh7gxrxlP2PUXF9HsHmaNI4nOpsaSP
        nGOeme+tgap+jFAbFBvf1gA+X047VHRhCCXjsIW7s4Z1pgtE8qhr7rNEZDg4dLOVhN7MHZ
        C2EunxrmycYXQqVOAeAylzEjPD0y7IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673116886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4hiDNpa3rBvHTs0MQ07bIhEgr4LQ6lpDQCuD/c1IEI=;
        b=F0TH+cJnTLwLOxduF4rsN7kT6gH7Id5LFZjLJPYdxF/RjvXArU20JcdKhe0l7xWrraX53h
        nwszPOmuRzTDXGAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4A51357F;
        Sat,  7 Jan 2023 18:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eaWqBda8uWPiDAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 07 Jan 2023 18:41:26 +0000
Message-ID: <b8adcc62-a403-bbb0-8540-4feea189ddc2@suse.cz>
Date:   Sat, 7 Jan 2023 19:41:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [BUG] perf kmem: Broken because of missing tracepoints
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
 <Y7b6cmRE/+5HJLCa@kernel.org> <Y7ewMG+0YKp9pgud@leoy-yangtze.lan>
 <c4c5c3cb-f1a8-84ee-0dc8-8be0d63c820d@amd.com> <Y7haGk30muVMjRhF@kernel.org>
 <Y7heE/e+g9IbefmO@kernel.org> <Y7jxZZ+jVrldfcPx@leoy-yangtze.lan>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y7jxZZ+jVrldfcPx@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 1/7/23 05:13, Leo Yan wrote:
> On Fri, Jan 06, 2023 at 02:44:51PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
>>>>> Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>>> Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
>>
>> But I'm removing this Fixes: tag (leaving the reference in the 1st
>> commit log message paragraph tho), and removing the term "ABI", as AFAIK
>> tracepoints can change and tools have to adapt, right?
>>
>> Lemme see...
>>
>> Documentation/bpf/bpf_design_QA.rst
>>
>> Q: Are tracepoints part of the stable ABI?
>> ------------------------------------------
>> A: NO. Tracepoints are tied to internal implementation details hence they are
>> subject to change and can break with newer kernels. BPF programs need to change
>> accordingly when this happens.
> 
> Okay, it's fine for me to remove the term "ABI" in commit log.
> 
> But I am confused for removing Fixes tag, this leads us to have no
> chance to backport this patch to any stable kernel branches, right?

Agree that leaving Fixes: would be appropriate to help anyone
backporting the original patch to notice they should consider this fix
too (although there's some disconnect between kernel and perf), it can't
hurt.

>> ---
>>
>>
>>
>>>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>>>
>>>> Thanks Leo. A quick test shows it fixes the issue.
>>>>
>>>> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>
>>> Thanks, applied.
>>
>> And I retract that, we need to query for the existence of these
>> tracepoints and use it if available, as we expect a new perf tool to
>> work on an older kernel, one where the removed tracepoints may be
>> available.
>>
>> Leo, can you try to rework this?
> 
> Sure, will respin the patch.
> 
> Thanks a lot for the suggestion and Ravi's testing.

Thanks everyone for fixing the fallout. I did expect some 3rd party
tools would need update to work with the slab tracepoints change, but
didn't realize it would be perf itself as well.
