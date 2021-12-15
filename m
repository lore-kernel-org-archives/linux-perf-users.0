Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E4C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Dec 2021 23:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhLOX4t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Dec 2021 18:56:49 -0500
Received: from st43p00im-ztfb10071701.me.com ([17.58.63.173]:51168 "EHLO
        st43p00im-ztfb10071701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232079AbhLOX4s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Dec 2021 18:56:48 -0500
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 18:56:48 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639612033; bh=nabJC3GdjoIrUeYiQY+wdpND8yaRU8eF0J3qCFIkJHI=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=heza7IPpQGOtXfhQ/+mEElhzjeuPLs+qWmg/LzyiJirGa9uV+OCgVsFzofG2JgUY2
         lW5AtZn5pB+nCbe6Vg/CXsQmN5c4w7aQFW2uo8l6zhwo/YB3JT3p9NMLwQqAi8+3Nv
         lV+6+NjJ3P7VlO9CKQ98C58Z0i9y95xiInNrN8d6skw9Va7vRgPZeQEmEhmOPgSlJz
         oD+7H/1l6MUOOvrQ1Xi7xkEVFI+nle3vlObYYwxDOGkNQVmUWc4z4h3cFzUMpVeOBy
         KH0yyhRhALLnaWt43O18QxyVgb/NeP92T6ebS+KSNd4PqCY5EDdkD9c3TEFCTNi13j
         8+I9cwjlWRVFw==
Received: from smtpclient.apple (cpe-66-24-82-52.stny.res.rr.com [66.24.82.52])
        by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 3606E8A069C
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 23:47:13 +0000 (UTC)
From:   Timothy Miller <theosib@me.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: perf not showing me call graph for memcpy no matter what.
Message-Id: <4296BD20-DEBC-4A20-ACF0-EE46A1AD20CC@me.com>
Date:   Wed, 15 Dec 2021 18:47:12 -0500
To:     linux-perf-users@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-15_09:2021-12-13,2021-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=600 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112150129
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

Thanks.=
