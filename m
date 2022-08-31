Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEB6ECAAD1
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 13:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiHaNrx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiHaNrw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 09:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97056260
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661953670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lv5oG1fF86KJH3EQZEFcgS8CWz7z7mhNttduXy5ZoR4=;
        b=Ms9RtPye/bViqLJud+F6ooOc6kAZtOKKr+POmH1YLbuOT7k2GFEF8wh76ekXr/gNbauJfS
        Vqy1EspUWyPldhhF7nZ3CHhgX+UwnIXE5myRhy5LPwsYvTMi7z6xuHUvYvG7W+uERpASHw
        7TVL0LTbDH+P/W8T108RblRZDu1Jywc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-e7nRLdPwNVe1SKTkFENmBA-1; Wed, 31 Aug 2022 09:47:49 -0400
X-MC-Unique: e7nRLdPwNVe1SKTkFENmBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EA2918A6525;
        Wed, 31 Aug 2022 13:47:49 +0000 (UTC)
Received: from [10.13.121.77] (dhcp-121-77.rdu.redhat.com [10.13.121.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46410909FF;
        Wed, 31 Aug 2022 13:47:49 +0000 (UTC)
Message-ID: <a339a987-dbfd-ce56-8169-f781bd3f5522@redhat.com>
Date:   Wed, 31 Aug 2022 09:47:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Cc:     wcohen@redhat.com, linux-perf-users@vger.kernel.org
Subject: Re: PROBLEM: The --call-graph=fp data does do not agree with the
 --call-graph=dwarf results
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
References: <cb3efad5-37eb-29e4-03b0-f0bcc8be9918@redhat.com>
 <Yw9RVlb3YxpTxROw@krava>
From:   William Cohen <wcohen@redhat.com>
In-Reply-To: <Yw9RVlb3YxpTxROw@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 8/31/22 08:17, Jiri Olsa wrote:
> On Tue, Aug 30, 2022 at 10:21:28AM -0400, William Cohen wrote:
>> With a perf Fedora 36 perf-tools-5.18.13-200.fc36 I was examining
>> where perf-report was spending its time when generating its report and
>> found there was an efficiency issue in Fedora 36's binutils-2.37.  The
>> efficient issue been addressed in Fedora rawhide and will be
>> backported to Fedora 36
>> (https://bugzilla.redhat.com/show_bug.cgi?id=2120752).  This was
> 
> nice :)
> 
>> initially discovered when processing perf.data files created with
>> --call-graph=dwarf.  The output of the perf-report call-graph for
>> dwarf information notes inlined functions in the report. The excessive
>> time spent in binutils bfd's lookup_func_by_offset was caused by perf-report
>> building up a red-black tree mapping IP addresses to functions
>> including inlined functions.
>>
>> I ran a similar experiment with --call-graph=fp to see if it triggered
>> the same execessive overhead in building the red-black tree for
>> inlined functions.  It did not.  The resulting output of the perf-report
>> for --call-graph=fp does not include information about inlined functions.
>>
>> I have a small reproducer in the attached perf_inlined.tar.gz that
>> demonstrates the difference between the two methods of storing
>> call-chain information. Compile and collect data with:
>>
>> tar xvfz perf_inlined.tar.gz
>> cd perf_inlined
>> make all
>> perf report --input=perf_fp.data > fp.log
>> perf report --input=perf_dwarf.data > dwarf.log
>>
>> The dwarf.log has the expected call structure for main:
>>
>>
>>                main
>>                |          
>>                 --85.72%--fill_array (inlined)
>>                           |          
>>                           |--78.09%--rand
>>                           |          |          
>>                           |           --75.10%--__random
>>                           |                     |          
>>                           |                      --9.14%--__random_r
>>                           |          
>>                           |--1.58%--compute_sqrt (inlined)
>>                           |          
>>                            --1.32%--_init
>>
>> The fp.log looks odd given program:
> 
> what's odd about that? perhaps the confusion is that you are
> in children mode? you could try --no-children
> 
>>
>>    99.99%     0.00%  time_waste  libc.so.6             [.] __libc_start_call_main
>>             |
>>             ---__libc_start_call_main
>>                |          
>>                |--66.07%--__random
>>                |          
>>                |--21.28%--main
>>                |          
>>                |--8.42%--__random_r
>>                |          
>>                |--2.91%--rand
>>                |          
>>                 --1.31%--_init
>>
>> Given how common that functions are inlined in optimized code it seems
>> like perf-report of --call-graph=fp should include information about
>> time spent in inlined functions.
> 
> hum, so 'fp' call graph is tracersing frame pointers which I would
> not expect for inlined functions

Hi,

The --call-graph=dwarf version gives a more accurate picture of what is going on in the code.  The output of --call-graph=fp makes it appear that the call to rand is coming from main when it is actually the result of the inlined fill_array function.  The results fp would be even more confusing if both main and fill_array had a call to rand.  The perf user might overlook the contribution by fill_function's rand  The dwarf handling makes it clearer where to look in the source code.  One could resort to using perf's annotation of  the binary to figure out where in the code, but it seems like a better approach would be to add the additional expansion that --call-graph=dwarf does to the backtrace to --call-graph=fp.

-Will
> 
> jirka
> 

