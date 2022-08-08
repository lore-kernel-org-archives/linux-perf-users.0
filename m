Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8639CC00140
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Aug 2022 09:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiHHJZt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241967AbiHHJZk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Aug 2022 05:25:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB1738AF
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Aug 2022 02:25:38 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2788Od5p031366;
        Mon, 8 Aug 2022 09:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=pcNTAur8n2cmwxDiSsWcCnKS4YOJRxD+cNe2+dDOU84=;
 b=JE85Z0yIb6CqXgtg5MsJ6urwREAGF+bPtavNkQJaGp9UF3Rza02TNjllNfrJ3BeBxhnP
 oU+R35UGR/Wzu56SddExJkwJ/86vK/dug4EpBYA1D97j6gbh22VTeQSeHKWSkPpUwaLv
 MJfjTxsfW51TS97gJa/0/LX47eIBG3SPD0+EtQGw9NwoQMRY/TdfA2zFlkqoSWC2qAbB
 hsmx5v+006OZCoW67wZXvXflkbsgm0tMfZpc5voiOrxZTxDqGlU/+LUWEo2FIfbnKtnW
 0BYwsCdLbPN+VjKuzpYPMDKk/iVCm7WhxUS857KaSDhiGYNwM1QpzmDI8kUHzSu3qFd3 Gw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3htxy19qt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:25:34 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2789KZLB030347;
        Mon, 8 Aug 2022 09:25:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3hsfjhrssd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:25:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2789Pk3c23527922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 09:25:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E704511C04C;
        Mon,  8 Aug 2022 09:25:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B22BC11C04A;
        Mon,  8 Aug 2022 09:25:29 +0000 (GMT)
Received: from [9.152.212.237] (unknown [9.152.212.237])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 09:25:29 +0000 (GMT)
Message-ID: <b8ce5423-f6ee-42bc-75eb-ce182cc325b8@linux.ibm.com>
Date:   Mon, 8 Aug 2022 11:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: perf recording with java runtime broken with commit 2d86612aacb7
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <defae7d2-5f3e-5de1-bcd0-f7ee7871a9f9@linux.ibm.com>
 <20220808083618.GA35313@leoy-ThinkPad-X240s>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220808083618.GA35313@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9G3s6jbq4-LTgXWbjr3fZO9Pxwy4dla9
X-Proofpoint-ORIG-GUID: 9G3s6jbq4-LTgXWbjr3fZO9Pxwy4dla9
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_05,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=941 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080046
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 8/8/22 10:36, Leo Yan wrote:
> Hi Thomas,
> 
> On Mon, Aug 08, 2022 at 10:28:13AM +0200, Thomas Richter wrote:
>> Commit 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
>> brakes perf performance measurement for Java runtimes.
>>
>> I have a java test program which calculates fractions repeatedly
>> for several seconds. It is named j_fac1.java and j_fac2.java
>> and has a class named j_fac2_run() which does the calculation
>> in a long running loop.
>>
>> I do the following steps:
>> 1. Execute Java program j_fac1 which does some calculation:
>>    # perf record -k mono  -- java -XX:+PreserveFramePointer \
>>         -agentpath:/usr/lib64/libperf-jvmti.so j_fac1 1000 123456789
>>
>> 2. Get the JIT'ted data with
>>    # perf inject --jit -i perf.data > /tmp/perf-jit
>>
>> 3. Display the contents of the JIT'ted data with:
>>    # perf report -i /tmp/perf-jit | fgrep 'j_fac2.j_fac2_run()'
>>     94.52%  java             jitted-28128-319.so  [.] j_fac2.j_fac2_run()
>>      0.10%  java             jitted-28128-317.so  [.] j_fac2.j_fac2_run()
>>    #
>>
>> This procedure works fine until above mentioned commit.
>> With above commit applied, the step 3 reproduces this result:
>>  #  perf report -i /tmp/perf-jit | fgrep 'j_fac2.j_fac2_run()'
>>  dso__load_sym_internal: failed to find program header for symbol:
>>         _etext st_value: 0x223d0
>>  dso__load_sym_internal: failed to find program header for symbol:
>>         Interpreter st_value: 0x40
>>  dso__load_sym_internal: failed to find program header for symbol:
>>         Lj_fac2;j_fac2_run()D st_value: 0x40
>>  dso__load_sym_internal: failed to find program header for symbol:
>>         Lj_fac2;j_fac2_run()D st_value: 0x40
>>  #
>>
>> I see this behavior on s390. I have no machine to test it on x86.
>> I have identified this patch using git bisect on the latest linux
>> master branch.
> 
> Ian has committed a patch "perf symbol: Fail to read phdr workaround" to
> address java JIT symbol issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=6d518ac7be6223811ab947897273b1bbef846180
> 
> Could you confirm if have included this patch in your code base?
> 
> Thanks,
> Leo

Thanks Leo, this patch fixes my issue.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
