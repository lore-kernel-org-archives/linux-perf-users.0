Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8717ECAAD1
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Aug 2022 14:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiH3OVw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiH3OVu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Aug 2022 10:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C5AF494
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Aug 2022 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661869303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jyN/gbd0XxSyznl/5jYtc0nwOpm14/J2h4soXed+O0k=;
        b=eBNQtKImo4CNt8/Bla+Z/HXhI6ceVV6Dd5R0tkKh7TQXPhzP2gWivjOBflETS+cXrAM0m4
        JKlBoQIfyjj1VPan37MwwMr03JK7Z1lfZAGRWiUNnTzo5for4MC3Aq8khWSiC8g8Tr3iHn
        uk1X/e8cpi2eedMQjhjgAW4FYyCaw5s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-wktcH5IMN8KHSnZcUuulCg-1; Tue, 30 Aug 2022 10:21:30 -0400
X-MC-Unique: wktcH5IMN8KHSnZcUuulCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6464A1C05EC3
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Aug 2022 14:21:30 +0000 (UTC)
Received: from [10.22.32.101] (unknown [10.22.32.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D74EA1121314;
        Tue, 30 Aug 2022 14:21:29 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------oFAoaECnVykd63M9jOHcygq3"
Message-ID: <cb3efad5-37eb-29e4-03b0-f0bcc8be9918@redhat.com>
Date:   Tue, 30 Aug 2022 10:21:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To:     linux-perf-users@vger.kernel.org
Cc:     wcohen@redhat.com
Content-Language: en-US
From:   William Cohen <wcohen@redhat.com>
Subject: PROBLEM: The --call-graph=fp data does do not agree with the
 --call-graph=dwarf results
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------oFAoaECnVykd63M9jOHcygq3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

With a perf Fedora 36 perf-tools-5.18.13-200.fc36 I was examining
where perf-report was spending its time when generating its report and
found there was an efficiency issue in Fedora 36's binutils-2.37.  The
efficient issue been addressed in Fedora rawhide and will be
backported to Fedora 36
(https://bugzilla.redhat.com/show_bug.cgi?id=2120752).  This was
initially discovered when processing perf.data files created with
--call-graph=dwarf.  The output of the perf-report call-graph for
dwarf information notes inlined functions in the report. The excessive
time spent in binutils bfd's lookup_func_by_offset was caused by perf-report
building up a red-black tree mapping IP addresses to functions
including inlined functions.

I ran a similar experiment with --call-graph=fp to see if it triggered
the same execessive overhead in building the red-black tree for
inlined functions.  It did not.  The resulting output of the perf-report
for --call-graph=fp does not include information about inlined functions.

I have a small reproducer in the attached perf_inlined.tar.gz that
demonstrates the difference between the two methods of storing
call-chain information. Compile and collect data with:

tar xvfz perf_inlined.tar.gz
cd perf_inlined
make all
perf report --input=perf_fp.data > fp.log
perf report --input=perf_dwarf.data > dwarf.log

The dwarf.log has the expected call structure for main:


               main
               |          
                --85.72%--fill_array (inlined)
                          |          
                          |--78.09%--rand
                          |          |          
                          |           --75.10%--__random
                          |                     |          
                          |                      --9.14%--__random_r
                          |          
                          |--1.58%--compute_sqrt (inlined)
                          |          
                           --1.32%--_init

The fp.log looks odd given program:

   99.99%     0.00%  time_waste  libc.so.6             [.] __libc_start_call_main
            |
            ---__libc_start_call_main
               |          
               |--66.07%--__random
               |          
               |--21.28%--main
               |          
               |--8.42%--__random_r
               |          
               |--2.91%--rand
               |          
                --1.31%--_init

Given how common that functions are inlined in optimized code it seems
like perf-report of --call-graph=fp should include information about
time spent in inlined functions.

-Will Cohen
--------------oFAoaECnVykd63M9jOHcygq3
Content-Type: application/gzip; name="perf_inlined.tar.gz"
Content-Disposition: attachment; filename="perf_inlined.tar.gz"
Content-Transfer-Encoding: base64

H4sIAAAAAAAAA+2VUU/bMBDH+4o/xQk0KR24TZYEJEr3xsOksUnT9gSoMo7dujhx5iYghPju
s5NC0zKENJVJ0+730Nh39v3Pvl5SCisnqtCqENmw9zaEjqM09c/oKA27z0d6URKHcRJFSXLY
C6M4TJIepG+Uzxr1omIWoHfLzUwUL697zf+PUnbrf8auhVRabFnDF/jQFfSl+h8eRW394zBN
P/j6J2kU9SDcch6/5T+vP9P6GJo/gSwHGatYO8lumZXNnJBK5WJyyxaVOIbVeMDJzpRzoFOg
Ogf6NQYqC0NNrioqLcsFLY0qKmHXNgE1nTkhXelueLLjPWAFNzYDKoCXNeXa8GuglLus6dSy
cjaWpZubuirrarx2jMHwmczqUH+i1OzeEFtF3NDjWrDimOxYdzNu18oFF63eS9e96R8YnW2u
8Taypfqv9X+3UFuK73ml/6MwjZ7e/3HT/2mcxNj/f4M9VXBdZwJOFlWm1dVg9pGs2ZR5Znq2
LGfVzFvIXua+H4WAT99Pv0Hkavtk+fLjbHL6+fSssTo7kdqwCtj5o+NyREhm6ivtGtDkrsPE
ZPHTVsHSJvvknoDr0qq2BTQe2R+RB0JujMrAfbX0hFnL7oJ2oXvzgBq5gTQ2UONwBOrkUWoE
+/uq73wedq4uYbyuuRTtW1ZkQb+V8QFzporAD5id8gPgM2bf+/HN+WVH9WDudZd5s5upix4O
Qne8JhkI5j6b+UlzST6VeR/um2S6hxi1lteSd9H3x80Z2g2tnP8dPl259zyQjm/YKDtLaV3C
MthtPe/kRbF74Bc06surDv3pAbb1vkEQBEEQBEEQBEEQBEEQBEEQBEEQBEHehl9qgLc/ACgA
AA==

--------------oFAoaECnVykd63M9jOHcygq3--

