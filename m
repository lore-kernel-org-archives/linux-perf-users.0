Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87359C54EE9
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 13:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiIPNGD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiIPNGC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Sep 2022 09:06:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C11E9C8D6
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Sep 2022 06:06:01 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GD2xqA030626;
        Fri, 16 Sep 2022 13:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PZ6UsV+OSRiH95FmszcbE8Wa84RsxMg3+iFCH1oU+gs=;
 b=By6Dmx2svReWo43xrUgyWxEe1foXmUFMVyRmAcqDodg9DYpYYWa/gmB/3FYSHZ8Hk1g+
 Jdc+Em2dYVKNcDgToo3NuEZbpMPWm/aDIvvuulW0ECqOpCcp6o4hO2YW+ivAqJ3+j1PL
 f7eb0Vh2x+/cbILFG4Yw+MRFdZOvID3JzvO6F/1X7XlcJcnqFFqeL1VbNoAgrOtdWrx7
 H67KKhZcYYKYxf3Nnr1UsVEsnFOxNwzoXpRVLqG8PoSX2w88Y9JMWWvb5JLisC14Sdk6
 lOMUANep+nhuro8Nqf0n2qPXPa0NtNe3ksIwwyHKOTUtJIch5cjMFpr7v/x5a4ZOmhtt Dw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmsksrfn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:05:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GCqeBe013773;
        Fri, 16 Sep 2022 13:05:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3jm9168rkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:05:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GD1t0L35258728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 13:01:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BE6BA4051;
        Fri, 16 Sep 2022 13:05:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D08A404D;
        Fri, 16 Sep 2022 13:05:42 +0000 (GMT)
Received: from [9.43.57.125] (unknown [9.43.57.125])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Sep 2022 13:05:42 +0000 (GMT)
Message-ID: <be87927f-f2c9-4475-6298-9ffe0a0195de@linux.ibm.com>
Date:   Fri, 16 Sep 2022 18:35:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] tools/perf/tests: Fix perf probe error log check in
 skip_if_no_debuginfo
Content-Language: en-US
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, mpe@ellerman.id.au
Cc:     maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        linux-perf-users@vger.kernel.org, disgoel@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20220916104904.99798-1-atrajeev@linux.vnet.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20220916104904.99798-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GJP_HsfmYu278vOmNQVgijro3G20JgNK
X-Proofpoint-GUID: GJP_HsfmYu278vOmNQVgijro3G20JgNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160092
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 9/16/22 16:19, Athira Rajeev wrote:
> The perf probe related tests like probe_vfs_getname.sh which
> is in "tools/perf/tests/shell" directory have dependency on
> debuginfo information in the kernel. Currently debuginfo
> check is handled by skip_if_no_debuginfo function in the
> file "lib/probe_vfs_getname.sh". skip_if_no_debuginfo function
> looks for this specific error log from perf probe to skip
> the testcase:
> 
> <<>>
> Failed to find the path for the kernel|Debuginfo-analysis is
> not supported
> <>>
> 
> But in some case, like this one in powerpc, while running this
> test, observed error logs is:
> 
> <<>>
> The /lib/modules/<version>/build/vmlinux file has no debug information.
> Rebuild with CONFIG_DEBUG_INFO=y, or install an appropriate debuginfo
> package.
>   Error: Failed to add events.
> <<>>
> 
> Update the skip_if_no_debuginfo function to include the above
> error, to skip the test in these scenarios too.

Patch looks good to me.

Reviewed-By: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> changelog:
>  v1 -> v2:
>  Corrected formatting of spaces in error log.
>  With spaces in v1 of the patch, the egrep search was
>  considering spaces also.
> 
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 5b17d916c555..b616d42bd19d 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -19,6 +19,6 @@ add_probe_vfs_getname() {
>  }
>  
>  skip_if_no_debuginfo() {
> -	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)" && return 2
> +	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
>  	return 1
>  }
