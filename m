Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B43C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Dec 2022 16:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiLLQ1E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiLLQ1D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Dec 2022 11:27:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9EB49F
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 08:27:02 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGMcI9028895;
        Mon, 12 Dec 2022 16:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=4mX3lP23XX2Lm8iEps3xhgamzv4FiB8MAFbKl6gj5RM=;
 b=fj+N9xhKjBl2HKtfTatJu+SjDLnb75XiEEAzYnIlHJDuGtVCcMJ0gzesil48MumETz1Q
 NSnPieShS+LulLHT1FlA8bEhTcgFiRtLL4Pq5AcC2Z+Egg2ux+1a2p17iHyPiJn/Kzbe
 mNiP/kKqqS0uSdx4UeoHV5YH6x7XGynUTC7xzZV4oaEj+1EdcZQ28INSa5aT5atEFFI7
 ba3HXiGIeb8m9wi+u9NxH4cvkxy/DOHgns0KvjoTBbDwCtxIMAMPoTTgcmd3QV+JasYk
 TSdph6HfHjjgPMS9wz/2BNoCkC16J7mMx5C7BhkQKJq9oN2YWNpFc6ZUoWs40XzGIIjD aA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3me7rv824x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 16:26:59 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCEYPnQ025630;
        Mon, 12 Dec 2022 16:26:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mchcet53f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 16:26:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BCGQrh318285244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 16:26:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1091320049;
        Mon, 12 Dec 2022 16:26:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BED8C2004B;
        Mon, 12 Dec 2022 16:26:52 +0000 (GMT)
Received: from [9.171.69.141] (unknown [9.171.69.141])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Dec 2022 16:26:52 +0000 (GMT)
Message-ID: <a284b362-4891-5384-9b88-cb1304b415a4@linux.ibm.com>
Date:   Mon, 12 Dec 2022 17:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: Perf dumps core when running test case 86 on x86 and s390
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W3bGlgGzeKCHqB8yEEHzMwXUjLLLgpuq
X-Proofpoint-ORIG-GUID: W3bGlgGzeKCHqB8yEEHzMwXUjLLLgpuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120141
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I just downloaded and installed Fedora 37 and the latest Linux kernel 6.1
on my x86 virtual machine (running on my Lenovo P15 TP)

When I run the perf tool test suite test case 86 'kernel lock contention analysis'
I hit a core dump.
Here is the stack trace:

....
--Type <RET> for more, q to quit, c to continue without paging--
Core was generated by `perf lock contention -i /tmp/__perf_test.perf.data.YR9Bn -E 1 -q'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x0000000000462b52 in is_lock_function (machine=0x1df2ed8, addr=18446744071579970007)
    at builtin-lock.c:882
882			lock_text_start = kmap->unmap_ip(kmap, sym->start);
(gdb) where
#0  0x0000000000462b52 in is_lock_function (machine=0x1df2ed8, addr=18446744071579970007)
    at builtin-lock.c:882
#1  0x0000000000462fdf in callchain_id (evsel=0x1dfa470, sample=0x7ffd1af0a770) at builtin-lock.c:1009
#2  0x0000000000462140 in get_key_by_aggr_mode (key=0x7ffd1af0a4f0, addr=18446612682148243264, 
    evsel=0x1dfa470, sample=0x7ffd1af0a770) at builtin-lock.c:589
#3  0x0000000000463194 in report_lock_contention_begin_event (evsel=0x1dfa470, sample=0x7ffd1af0a770)
    at builtin-lock.c:1051
#4  0x0000000000463811 in evsel__process_contention_begin (evsel=0x1dfa470, sample=0x7ffd1af0a770)
    at builtin-lock.c:1231
#5  0x00000000004640f9 in process_sample_event (tool=0x7ffd1af0b080, event=0x7fd21c950bd8, 
    sample=0x7ffd1af0a770, evsel=0x1dfa470, machine=0x1df2ed8) at builtin-lock.c:1413
#6  0x000000000056ce18 in evlist__deliver_sample (evlist=0x1df99b0, tool=0x7ffd1af0b080, 
    event=0x7fd21c950bd8, sample=0x7ffd1af0a770, evsel=0x1dfa470, machine=0x1df2ed8)
    at util/session.c:1520
#7  0x000000000056cff6 in machines__deliver_event (machines=0x1df2ed8, evlist=0x1df99b0, 
    event=0x7fd21c950bd8, sample=0x7ffd1af0a770, tool=0x7ffd1af0b080, file_offset=7128, 
    file_path=0x1df29d0 "/tmp/__perf_test.perf.data.YR9Bn") at util/session.c:1559
#8  0x000000000056d541 in perf_session__deliver_event (session=0x1df2cd0, event=0x7fd21c950bd8, 
    tool=0x7ffd1af0b080, file_offset=7128, file_path=0x1df29d0 "/tmp/__perf_test.perf.data.YR9Bn")
    at util/session.c:1640
#9  0x000000000056945c in ordered_events__deliver_event (oe=0x1df9850, event=0x1e20960)
    at util/session.c:187
#10 0x0000000000573a7e in do_flush (oe=0x1df9850, show_progress=true) at util/ordered-events.c:245
#11 0x0000000000573db8 in __ordered_events__flush (oe=0x1df9850, how=OE_FLUSH__FINAL, timestamp=0)
    at util/ordered-events.c:324
#12 0x0000000000573e8d in ordered_events__flush (oe=0x1df9850, how=OE_FLUSH__FINAL)
    at util/ordered-events.c:342
#13 0x000000000056f893 in __perf_session__process_events (session=0x1df2cd0) at util/session.c:2461
#14 0x0000000000570216 in perf_session__process_events (session=0x1df2cd0) at util/session.c:2623
#15 0x0000000000464efb in __cmd_contention (argc=0, argv=0x7ffd1af0c380) at builtin-lock.c:1742
#16 0x0000000000465e70 in cmd_lock (argc=0, argv=0x7ffd1af0c380) at builtin-lock.c:1992
--Type <RET> for more, q to quit, c to continue without paging-- 
#17 0x00000000004f030b in run_builtin (p=0xe4aa08 <commands+552>, argc=7, argv=0x7ffd1af0c380) at perf.c:322
#18 0x00000000004f057f in handle_internal_command (argc=7, argv=0x7ffd1af0c380) at perf.c:376
#19 0x00000000004f06ce in run_argv (argcp=0x7ffd1af0c1ac, argv=0x7ffd1af0c1a0) at perf.c:420
#20 0x00000000004f0a95 in main (argc=7, argv=0x7ffd1af0c380) at perf.c:550
(gdb) 

It also shows up on s390 too. Is this a known problem?
Maybe already fixed?

Thanks for your help
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
