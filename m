Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FCC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Dec 2021 13:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhLPNyP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:54:15 -0500
Received: from st43p00im-zteg10063401.me.com ([17.58.63.175]:38328 "EHLO
        st43p00im-zteg10063401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237058AbhLPNyP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Dec 2021 08:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1639662854;
        bh=hIwCA46n4X8DBGy4YUjX7M53fn8LLYnEOCVe4AB7nec=;
        h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id;
        b=v/ZWwVzxmItPqXHjulmDVIZ4/BnJKwdA1wbPqYAnfrjk6UGfPRI2Ilqf8kOS1yd8g
         VEs8qGl3HH85li7bRV0A4W15Qno56v2C+sI5TBvYRoqc2eZV5QXMfU6iIsMv0yWsIw
         XhttKVwfxwPXB9CqhhWaEdDaMbpGcknSB0HVea08Qv/94bKLfqbRAp1u8lmYEo0LKq
         5yajEhyv6f+cafXuP7ACIXSHcgmjg1BiWtMmoOTtntkvImNMynZJHvr2XTDl8Ibd93
         w06YaCypQj0U2X/0HK+E72+iGBzLza2rhWjArt2oOhyt3A7qmzAsGlZcwAwqSpkD8G
         M5exCZwdDYhgA==
Received: from smtpclient.apple (cpe-66-24-82-52.stny.res.rr.com [66.24.82.52])
        by st43p00im-zteg10063401.me.com (Postfix) with ESMTPSA id 495A74A05A6
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Dec 2021 13:54:14 +0000 (UTC)
From:   Timothy Miller <theosib@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: perf not showing me call graph for memcpy no matter what
Date:   Thu, 16 Dec 2021 08:54:12 -0500
References: <55BDE53A-EF97-4EF6-80C4-11821372A842@icloud.com>
To:     linux-perf-users@vger.kernel.org
In-Reply-To: <55BDE53A-EF97-4EF6-80C4-11821372A842@icloud.com>
Message-Id: <BA01400F-BB83-4873-8087-D4B777FDEBA0@icloud.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-16=5F04:2021-12-14=5F01,2021-12-16=5F04,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=829 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112160078
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Sorry about the duplicate. Majordomo kept throwing errors when I would =
try to join or verify. It really didn=E2=80=99t like the email address I =
tried to use before, so I assumed that it wasn=E2=80=99t going to accept =
the post either.

> On Dec 16, 2021, at 8:37 AM, Timothy Miller <theosib@icloud.com> =
wrote:
>=20
> Hi,
>=20
> I am doing some software profiling on an aarch64 system, and I=E2=80=99m=
 using the Linux perf tool. The problem I=E2=80=99m running into is that =
=E2=80=9C__GI___memcpy_simd=E2=80=9D keeps showing up as the function =
with the most CPU usage.
>=20
> Unfortunately, no matter what I do, this function keeps showing up as =
orphaned. That is, I cannot get a stack trace for it so I can find out =
who is calling it.
>=20
> I have tried using dwarf mode, but it always gets overloaded.
>=20
> I have tried using lbr mode, but I get the following error:
>   Error:
>   PMU Hardware doesn't support sampling/overflow-interrupts.
>=20
> I=E2=80=99ve rebuilt my application and all relevant libraries with =
-no-omit-frame-pointer so that I could use the default frame pointer =
mode. Unfortunately, I still can=E2=80=99t get a call graph for this =
function.
>=20
> I emailed the glibc mailing list about this, trying to find out how to =
work around this problem, perhaps adding frame pointer to the assembly =
implementation of memcpy. They suggested I try attaching a debugger, and =
I=E2=80=99ve found that I can get stack traces just fine. They suggest =
that I seem to be running into some kind of bug in perf.=20
>=20
> Any help/advice would be appreciated.
>=20
> Thanks.
>=20

