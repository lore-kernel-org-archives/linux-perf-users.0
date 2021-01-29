Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7BAC433DB
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jan 2021 20:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF96964DDE
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jan 2021 20:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhA2U2D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:28:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59218 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233394AbhA2UZ6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jan 2021 15:25:58 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10TK3gkv150346
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jan 2021 15:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=EVxfYL8P+mjtGJeuKUeGjtQfYXFSA4KcKA10m+TXVhs=;
 b=Wwvr4OCXS3ImjtSZT23dXpfQ/cHKjGAq+hl7vUwBlMjjWj9McbGih59QryzC+m1zzOxG
 /URu+aUKCR5ikonWrzsWq2vvOQ7tY0ozEntX8hHwyxB5FCYbi3HLOu3/rnltWaOzbOX5
 OOF1Jv3u7zA45cCI/6gaXoNsxa19dIgJFcdC4jGCnPDGZQnfFzWWssRDriMojIGci7jm
 h/qQ9RROahWZoawv8IKnoIsWBxll2pyPZLdj4fUb1avNDQrguB3YyGbJf6kb6ryQ7Opl
 jp6UQqW/iObmHzhir3KKSQ3HZXyWw7wXJHAIM3TniSYVqZ9vCfnBz8TTXmpObk7T5t3y bA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36cj6bkm5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jan 2021 15:25:12 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10TKMxk0029170
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jan 2021 20:25:11 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 36ag3ytmj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jan 2021 20:25:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10TKPBA331719866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jan 2021 20:25:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AF1AB2065
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jan 2021 20:25:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D182BB2067
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jan 2021 20:25:10 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.80.217.171])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jan 2021 20:25:10 +0000 (GMT)
Date:   Fri, 29 Jan 2021 14:25:09 -0600
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org
Subject: perf probe hang with DWARF5 object
Message-ID: <20210129202509.GC840387@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-29_07:2021-01-29,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290094
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

GCC 11 will apparently default to creating DWARF5 debug informtion.

I built a program using the latest (still unreleased) version of GCC 11,
and attempted to add a trace point, and "perf probe" hangs:
--
$ perf probe -v -x /path/to/program main
probe-definition(0): main 
symbol:main file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Failed to open cache(-1): /home/user/.debug/home/user/path/to/program/d061c981bc36d9da5026d2fa23dd79de4575c965/probes
Cache open error: -1
Open Debuginfo file: /path/to/program
Try to find probe point from debuginfo.
--

I found that perf is looping forever in
util/probe-finder.c:debuginfo__find_probe_location,
in this loop:
	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
		/* Get the DIE(Debugging Information Entry) of this CU */
		diep = dwarf_offdie(dbg->dbg, off + cuhl, &pf->cu_die);
		if (!diep)
			continue;
...
		off = noff;
	}

dwarf_offdie is returning 0, so the code continues in the while loop
without "incrementing" 'off', resulting in the same call to
dwarf_nextcu, with the same result, and around we go again.

This code is over a decade old, but maybe dwarf_offdie has never
returned 0 before?  Maybe the libdw1 I'm using is too old?
--
$ egrep '^NAME|^VERSION=' /etc/os-release
NAME="SLES"
VERSION="15-SP2"
$ rpm -q libdw1
libdw1-0.168-4.5.3.ppc64le
$ perf --version
perf version 5.3.18
--

If I force the target object to be DWARF4, it works.

If I change the loop above to:
--
	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
		/* Get the DIE(Debugging Information Entry) of this CU */
		diep = dwarf_offdie(dbg->dbg, off + cuhl, &pf->cu_die);
		off = noff;
		if (!diep)
			continue;
...
	}
--
...it at least terminates, but fails:
--
$ ./perf probe -v -x program main
probe-definition(0): main 
symbol:main file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Failed to open cache(-1): /home/user/.debug/path/to/program/d061c981bc36d9da5026d2fa23dd79de4575c965/probes
Cache open error: -1
Open Debuginfo file: /path/to/program
Try to find probe point from debuginfo.
debuginfo__find_probe_location.1109 off=0x0
invalid DWARF
Symbol main address found : 7840
Failed to find debug information for address 7840
Probe point 'main' not found.
  Error: Failed to add events. Reason: No such file or directory (Code: -2)
--

PC
