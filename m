Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAB6C43214
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 21:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9D6611BF
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 21:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhHFVOX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:14:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245202AbhHFVOX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 17:14:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176L5NHv056964;
        Fri, 6 Aug 2021 17:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=cRkEW63PV2Y6BSJzudvoYxZko/o4YF/irIOsVhYwkiE=;
 b=KTiKrKWLPOoWxVLu6FcaPTYU8SLOuJZVuoE9YjeAK2od9ozLQ6PxpTFc85sJ0Hfo5GrC
 Bj8LThMBQS0bIt4tmgqUoW9xq8P7qiKVrNEIrlN/uuWowBezH57HIdzVm0OJ17VZb6ZO
 PXYwukHUnCnITjpPTgJsCfNziWrO2xMZPJm7RY4UOiP/fua8vKZa8R48xAkU2siCPhTR
 l/p9UPyWGHXuCqWex0/r+3jhg8Jr5Pj54rSnSrm9lE4ZbEEhzdyLFNwsrCPBc5B4/VG/
 OhV806bAh4+nOmmqE756G5dtIku8npE8n+YM+X1coBEpJfqe3AFZSIOPcs+aCCU/GJZX zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a9bxdhc4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 17:13:56 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 176L65RU061266;
        Fri, 6 Aug 2021 17:13:56 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a9bxdhc46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 17:13:56 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 176LDKTB009026;
        Fri, 6 Aug 2021 21:13:54 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 3a8gwuqnay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 21:13:54 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 176LDsEk33620242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Aug 2021 21:13:54 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13ADDAE06A;
        Fri,  6 Aug 2021 21:13:54 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBE9BAE066;
        Fri,  6 Aug 2021 21:13:51 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.77.144.67])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri,  6 Aug 2021 21:13:51 +0000 (GMT)
Date:   Fri, 6 Aug 2021 16:13:48 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script python: fix unintended underline
Message-ID: <20210806211348.GA66379@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20210806204502.110305-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806204502.110305-1-stephen.s.brennan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qD-FdmqpX4JZSrLVBbhJVFa1WMTZXgL4
X-Proofpoint-ORIG-GUID: OlW__nPxS_ycWnetDraG5IadXgiXoxD4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_06:2021-08-06,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060138
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 06, 2021 at 01:45:01PM -0700, Stephen Brennan wrote:
> The text ranging from "subsystem__event_name" to
> "raw_syscalls__sys_enter()" is interpreted by asciidoc as a pair of
> unconstrained text formatting markers. The result is that the manual
> page displayed this text as underlined, and the HTML pages displayed
> this text as italicized. Escape the first double-underscore to prevent
> this.

I think it would be better to escape the second double-underscore as well,
to prevent the same problem recurring with future changes.

> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
> index 5e43cfa5ea1e..0250dc61cf98 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt
> @@ -167,7 +167,7 @@ below).
> 
>  Following those are the 'event handler' functions generated one for
>  every event in the 'perf record' output.  The handler functions take
> -the form subsystem__event_name, and contain named parameters, one for
> +the form subsystem\__event_name, and contain named parameters, one for
>  each field in the event; in this case, there's only one event,
>  raw_syscalls__sys_enter().  (see the EVENT HANDLERS section below for

escape this    ^ , too.

>  more info on event handlers).
> -- 

PC
