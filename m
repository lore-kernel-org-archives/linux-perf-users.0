Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F3CC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4E861165
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbhHFW2s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 18:28:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22188 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237272AbhHFW2r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 18:28:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176ML27K034486;
        Fri, 6 Aug 2021 18:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vzk8eIJzQpp5+lo/qyJnzpHXqej7XaaGcJFZ/7nY1U0=;
 b=ruuvX7GsdJC/J/GYsVuh+CCEEM4Vc2B70HYSqZfEgViGz9fN7K5+hE4QnoWvQAmGNgts
 JGZBFhuUaga+G8mHLt/UIjcRx3CPyAM17xx9M4hHHUIPAaO1fUl7BtB6TuFJC6dx7yME
 lgSMioHXxp0mCE/f5MHKuvvu1NPiyixjthbDzFtpvft9/qsfLHy/SRgh+MDkPkm3f76N
 vKH6pAgfnlrXM6v9gV4aeB+8FaNnbYyqKfWIHHDwXZZUOpVZeEpLXa+OvoIVaTqBfWH2
 xHGV/Y/YOi+sL1Ig3jnQvC+7M6VIV6ITuzcAAo03hZs9YRlTjVeCynBQUmhRejqMfHUd 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a9dst841b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 18:28:20 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 176MLIkv035535;
        Fri, 6 Aug 2021 18:28:20 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a9dst8413-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 18:28:19 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 176MDPKv026405;
        Fri, 6 Aug 2021 22:28:19 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 3a77h6bm9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 22:28:19 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 176MSIpP43581700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Aug 2021 22:28:18 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DA0CC605A;
        Fri,  6 Aug 2021 22:28:18 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BB07C605B;
        Fri,  6 Aug 2021 22:28:16 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.77.144.67])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri,  6 Aug 2021 22:28:16 +0000 (GMT)
Date:   Fri, 6 Aug 2021 17:28:10 -0500
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
Message-ID: <20210806222810.GB66379@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20210806204502.110305-1-stephen.s.brennan@oracle.com>
 <20210806211348.GA66379@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <87bl6a1cwi.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl6a1cwi.fsf@stepbren-lnx.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nPfVkTvFumYO-KQA8R7h4Yygd4YgDTxc
X-Proofpoint-ORIG-GUID: uKZgyrIMOLY-NNe_7UbEmUmG7i3zz8IL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_07:2021-08-06,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060140
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 06, 2021 at 02:28:13PM -0700, Stephen Brennan wrote:
> "Paul A. Clarke" <pc@us.ibm.com> writes:
> > On Fri, Aug 06, 2021 at 01:45:01PM -0700, Stephen Brennan wrote:
> >> The text ranging from "subsystem__event_name" to
> >> "raw_syscalls__sys_enter()" is interpreted by asciidoc as a pair of
> >> unconstrained text formatting markers. The result is that the manual
> >> page displayed this text as underlined, and the HTML pages displayed
> >> this text as italicized. Escape the first double-underscore to prevent
> >> this.
> >
> > I think it would be better to escape the second double-underscore as well,
> > to prevent the same problem recurring with future changes.
> >
> >> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
> >> index 5e43cfa5ea1e..0250dc61cf98 100644
> >> --- a/tools/perf/Documentation/perf-script-python.txt
> >> +++ b/tools/perf/Documentation/perf-script-python.txt
> >> @@ -167,7 +167,7 @@ below).
> >> 
> >>  Following those are the 'event handler' functions generated one for
> >>  every event in the 'perf record' output.  The handler functions take
> >> -the form subsystem__event_name, and contain named parameters, one for
> >> +the form subsystem\__event_name, and contain named parameters, one for
> >>  each field in the event; in this case, there's only one event,
> >>  raw_syscalls__sys_enter().  (see the EVENT HANDLERS section below for
> >
> > escape this    ^ , too.
> 
> I've tried escaping a few combinations of these four underscores.
> 
>   \__ __    - escaping the first but not the second (as this patch)
>               produces correct output
>   \_\_ \_\_ - escaping all underscores results in no underlines, but the
>               manual page shows "raw_syscalls\_\_sys_enter()" in its
>               output.
>   \_\_ __   - escaping the first two results in no underlines, but the
>               manual page shows "subsystem\_\_event_name"
>   \__ \__   - escaping the first of each double-underscore results in no
>               underlines, but the manual page shows
>               "raw_syscalls\__sys_enter()"
> 
> It seems that asciidoc only allows the first in a potential pair to be
> escaped? I'll be the first to admit, I know nothing about asciidoc, so I
> may have missed something here.

Ugh. Thanks for trying. I thought it would be easy, but that probably shows
I know even less about asciidoc.  :-/

PC
