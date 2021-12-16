Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F6C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Dec 2021 13:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhLPNq3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:46:29 -0500
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:36237 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhLPNq2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Dec 2021 08:46:28 -0500
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 08:46:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1639661832;
        bh=bTWQzA0vmOXRmuWnMLqo48xYcvihkk6mMLwkFnLxcn8=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=dSMZciKt7hoj2kY4rvC3VMhwDrJiOL6GDyQGyzrq8gw/nCjrtohFNGPJpPKw7AFtX
         TAEXinCG47b5c66C2zV3kQmUjmkTfNNEQN/E1R4jmUi437IAF7SsEZuX5QNr+xxF0K
         Xos8PkfKhlnKcGbgRGxYUup1YCqF/1skaurzJ+AdxMLfdb8UuNDUbjB24vVpC5Jony
         KdgpLIHwV/tKJXIZoYB2tqk196JKXeroDZRHPxGz+YJFnnTohu0PodiIIEFC2vcy8R
         3mdIvXOC+0FUmCjf7LhuY6GpoZooSrQY6oMThiOwmeVmds9WqifMXo7i7TfHIaZ4zG
         ZDi2fVFuFFMyw==
Received: from smtpclient.apple (cpe-66-24-82-52.stny.res.rr.com [66.24.82.52])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id 09552540577
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Dec 2021 13:37:10 +0000 (UTC)
From:   Timothy Miller <theosib@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: perf not showing me call graph for memcpy no matter what
Message-Id: <55BDE53A-EF97-4EF6-80C4-11821372A842@icloud.com>
Date:   Thu, 16 Dec 2021 08:37:03 -0500
To:     linux-perf-users@vger.kernel.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-16=5F05:2021-12-16=5F01,2021-12-16=5F05,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=637 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112160076
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I am doing some software profiling on an aarch64 system, and I=E2=80=99m =
using the Linux perf tool. The problem I=E2=80=99m running into is that =
=E2=80=9C__GI___memcpy_simd=E2=80=9D keeps showing up as the function =
with the most CPU usage.

Unfortunately, no matter what I do, this function keeps showing up as =
orphaned. That is, I cannot get a stack trace for it so I can find out =
who is calling it.

I have tried using dwarf mode, but it always gets overloaded.

I have tried using lbr mode, but I get the following error:
   Error:
   PMU Hardware doesn't support sampling/overflow-interrupts.

I=E2=80=99ve rebuilt my application and all relevant libraries with =
-no-omit-frame-pointer so that I could use the default frame pointer =
mode. Unfortunately, I still can=E2=80=99t get a call graph for this =
function.

I emailed the glibc mailing list about this, trying to find out how to =
work around this problem, perhaps adding frame pointer to the assembly =
implementation of memcpy. They suggested I try attaching a debugger, and =
I=E2=80=99ve found that I can get stack traces just fine. They suggest =
that I seem to be running into some kind of bug in perf.=20

Any help/advice would be appreciated.

Thanks.

