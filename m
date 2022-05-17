Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC4C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 08:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiEQI7W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 04:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbiEQI7U (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 04:59:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3C2ED73
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 01:59:19 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H8va7v027087;
        Tue, 17 May 2022 08:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=URcsjrjOBlUkdjGoyePQAASt2Q4JVsxnTRwYlRLZGQ0=;
 b=NVhkmseY5SEBnM3yahkphfAI8hmynkXRYR2L6RSxj9E7DWJ2U2r/KuxJdKwSUQFVWVjM
 7CGQK5tY9VT4Vf2uRWBmRN6lucxFKSlvjfrNObOLlLs0kOzKYQKSg8qg3KK2btTpYFt6
 8EgCNfyrWLY/XBPU1IaMpjq84PSq9lXVl+TrUvbxW7ujdMtiLzx4yWjigAh8Yo4lcHEe
 6cwkr7HhAjMgH0xbl0mrhnXrwJ+T1EDf7uZQOWuWMtuB83cpgqprlhLiKd86lK7wY4gO
 iCiil93MxMiMFrFHk1RvDmthAzA+m4jjzPbooZ4XMuZZ+/q6btIOA9ciRYpdvuhoy7m/ 8A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g48nfr0yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 08:59:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24H8w2Sp015070;
        Tue, 17 May 2022 08:59:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjbws1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 08:59:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24H8xBn226935618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 08:59:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB3E75204F;
        Tue, 17 May 2022 08:59:11 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 93B3E5204E;
        Tue, 17 May 2022 08:59:11 +0000 (GMT)
Message-ID: <626c38d8-ce7c-51f0-5f2e-094192809d5c@linux.ibm.com>
Date:   Tue, 17 May 2022 10:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: File bench/numa.c compiler error on s390
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
References: <00a443b1-92e0-8992-18ae-10e0e8489658@linux.ibm.com>
 <YoJItiE0xWDutZKR@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <YoJItiE0xWDutZKR@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: if7NdP-Gn4wvX_L9LlkKL0tL4EvOBfRY
X-Proofpoint-ORIG-GUID: if7NdP-Gn4wvX_L9LlkKL0tL4EvOBfRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170051
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 5/16/22 14:51, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 16, 2022 at 09:24:52AM +0200, Thomas Richter escreveu:
>> Hi all,
>>
>> I just upgraded to Fedora 36 and gcc version 12.0.1 20220308 (Red Hat 12.0.1-0) (GCC) 
>> and run into this compiler error:
> 
> Humm, I regularly build on fedora 36 and didn't catch this :-\
> 

Thanks for your feedback, Arnaldo.

I talk to our compiler guys about this.
Looks like this is a s390 thing.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
