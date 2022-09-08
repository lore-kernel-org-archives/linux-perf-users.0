Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85ABC38145
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Sep 2022 19:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIHTM4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Sep 2022 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiIHTMy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Sep 2022 15:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E3EB2C8
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Sep 2022 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662664371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8KJR3c/Hw03TXcM9/xQhxaGMAUQA14sxyqZ0rkWO5U=;
        b=iMjt4heSziWx4pEDGOO7CBd534mgJuhaesrpi2LJUkqb6p2DEgCHprRWla78cKXPc/q/nx
        6Jyc4vvc1Gm96WNumjI7U2RmyYySb6CY8QzC8ahQ/4GMAUrm/jr/Rpobq2xNYU2yUrANUZ
        LK+LcdbBAjE53t8poOB631+GNzhsqlM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-7q1Ay1sJMxGALt5Yk-ZREQ-1; Thu, 08 Sep 2022 15:12:50 -0400
X-MC-Unique: 7q1Ay1sJMxGALt5Yk-ZREQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2619E29AA3AE
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Sep 2022 19:12:50 +0000 (UTC)
Received: from [10.22.32.3] (unknown [10.22.32.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3284011A3E;
        Thu,  8 Sep 2022 19:12:50 +0000 (UTC)
Message-ID: <2ff91b93-0daf-afef-682a-437fcffe46f3@redhat.com>
Date:   Thu, 8 Sep 2022 15:12:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Cc:     wcohen@redhat.com
Subject: Re: PROBLEM: The --call-graph=fp data does do not agree with the
 --call-graph=dwarf results
Content-Language: en-US
To:     William Cohen <wcohen@redhat.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <cb3efad5-37eb-29e4-03b0-f0bcc8be9918@redhat.com>
From:   William Cohen <wcohen@redhat.com>
In-Reply-To: <cb3efad5-37eb-29e4-03b0-f0bcc8be9918@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Because of the previous issue of fp unwinding not including
information about inlined functions I wanted to get an idea how often
inline functions occurring in the code.  I have a simple script that
uses dwgrep to extract the number of actual functions and inlined
function then compute the average number of inlined functions for each
actual function
(https://github.com/wcohen/quality_info/blob/master/dwgrep/inlined_funcs).
I ran some quick a quick experiment a few binaries on various
architectures running Fedora to get some actual numbers.


	      average inlined functions per real function

	       architecture
binary		i386	 x86_64	    armv7    aarch64  riscv
vmlinux		-	 6.9	    3.5	     7.4      7.7
libc		1.33	 1.3	    1.3	     1.3      1.1
emacs		-	 17.3	    16.8     18.3     18.6	
stap		-	 75.9	    82.3     77.3     50.3		
libdw-0.187.so  -	 3.3	    3.7	     3.7      3.7
Xwayland	-	 3.9	    -	     3.9      -
libxul.so	-	 19.2	    -	     27.8     -

One thing to note is that for some executables like emacs and
systemtap's stap command there are a significant number of inlined
functions per function.  For stap part of this might be due to it
using C++.  With that ratio of inline functions to real function
omitting the inline functions from the backtrace information is likely
to provide an incomplete picture of what is occurring in the code.

One concern would be sampling skid for inlined functions in the
current function.  Rather than marking the sample to the instruction
that triggered the event it gets attached to another instruction for a
inlined function that doesn't have anything to do with the sample.
The triggering instructions could have been from another inlined
function or the real function everything has been inlined into.  That
might cause people to look in the wrong area of source code.  This
would only be an issue for the current function that is executing.
For the unwinding of the callers that information should be more
precise.


-Will

