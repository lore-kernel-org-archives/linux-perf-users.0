Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E43C0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 20:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGMUhI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjGMUhH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 16:37:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84581FD6
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689280625; x=1720816625;
  h=date:from:to:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1j+X89xHrI/HHt6VHIT5oc1K5FJUb0a+UpWm/iDYm7A=;
  b=Itr2CfE4vaCGPYm1QlCaInqYy9ob+J3GtKnQUGTBh15iaUnjExRVjt0Y
   +X/XiCLi4DXgsEmzVrBB4HmOmXWmD2+iSj39/douQeIrLDBeUt0aHNCKV
   WA4IpM9cvg1yuMI7bhevL+VKyWPToLnZ5wQr0VyRdLdX/LQ/fF5ZhkeF9
   2/pYxPMZx5HZC31yka28PVgj8gLOp8Pff4LSyVhsyq38A8/74Y/YRRmGQ
   yvojbpalwWSnHw/EMwPXuKGJ6Jmw/38uBAKzhB+MDd+UOeqMYUyK3LHUm
   Baw+Atj5V3HjgmxjbqMscjyB1CpdjBRK78SZuCaROvv5WBuSBZBVLpjmA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="396116486"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="396116486"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 13:37:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="699398210"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="699398210"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 13:37:04 -0700
Date:   Thu, 13 Jul 2023 13:37:00 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     irogers@google.com, namhyung@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Event reordering regression for software events
Message-ID: <ZLBgbHkbrfGygM/u@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

The current post 6.3 linux-perf-next causes some fairly drastic
reordering in output for some event combinations. I bisected it down to
your patch:

commit 347c2f0a0988c59c402148054ef54648853fa669
Author: Ian Rogers <irogers@google.com>
Date:   Sat Mar 11 18:15:40 2023 -0800

    perf parse-events: Sort and group parsed events

    This change is intended to be a no-op for most current cases, the
    default sort order is the order the events were parsed. Where it
    varies is in how groups are handled. Previously an uncore and core
    event that are grouped would most often cause the group to be removed:

I currently only have a large test case, but for the test case [1] below=20
most of the "dummy"s and some other software events end up in a row and als=
o in the
wrong place, instead of the expected order.

good:

=2E..
986476553;ns;duration_time;986476553;100.00;;
0;;dummy;983952237;100.00;;
0;;cs:u;983952237;100.00;;
16532;;minor-faults:u;983952237;100.00;;
0;;major-faults:u;983952237;100.00;;
0;;migrations:u;983952237;100.00;;
3532509496;;cycles:u;23999092;2.00;;
=2E...

bad:

1010119571;ns;duration_time;1010119571;100.00;;
0;;dummy [software];1007748753;100.00;;
0;;cs:u [software];1007748753;100.00;;
16496;;minor-faults:u [software];1007748753;100.00;;
0;;major-faults:u [software];1007748753;100.00;;
0;;migrations:u [software];1007748753;100.00;;
0;;dummy [software];1007748753;100.00;;
0;;dummy [software];1007748753;100.00;;
0;;dummy [software];1007748753;100.00;;
0;;dummy [software];1007748753;100.00;;
0;;emulation-faults [software];1007748753;100.00;;
0;;dummy [software];1007748753;100.00;;
0;;dummy [software];1007748753;100.00;;
0;;emulation-faults [software];1007748753;100.00;;
0;;emulation-faults [software];1007748753;100.00;;
3603193382;;cycles:u;23996241;2.00;;
2277091922;;cpu/event=3D0x0,umask=3D0x3/u;23996241;2.00;;
4182126406;;cpu/event=3D0xc2,umask=3D0x2/u;23996241;2.00;;
4364677170;;cpu/event=3D0xc0,umask=3D0x0/u;23996241;2.00;;


Unfortunately this totally breaks toplev. It needs to have the dummies
in the right location.`

Another problem is that it also now adds [software] to lots of software
events, which of course also breaks any parsing tools. I haven't bisected
that too, but it needs fixing too.

I must say using perf recently is frustrating with all the regressions!
Please be a bit more careful with compatibility.

-Andi



[1]=20

$PERF stat -x\; --no-merge -o xxx -e '{cpu/event=3D0xc0,umask=3D0x0/u,cpu/e=
vent=3D0x3c,umask=3D0x0/u,cpu/event=3D0x0,umask=3D0x3/u,cpu/event=3D0x3c,um=
ask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0xb1,umask=3D0x1/u,c=
pu/event=3D0xb1,umask=3D0x2,cmask=3D1/u},msr/tsc/,duration_time,dummy,uncor=
e_imc/event=3D0x4,umask=3D0x3/,uncore_imc/event=3D0x4,umask=3D0xc/,cs:u,min=
or-faults:u,major-faults:u,migrations:u,{cycles:u,cpu/event=3D0x0,umask=3D0=
x3/u,cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu/even=
t=3D0xc4,umask=3D0x40/u,cpu/event=3D0xb1,umask=3D0x1/u,cpu/event=3D0xe,umas=
k=3D0x1/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xc2,umask=3D0x2,cma=
sk=3D1/u,cpu/event=3D0x3c,umask=3D0x0/ku,cpu/event=3D0xc0,umask=3D0x0/ku},{=
cpu/event=3D0x79,umask=3D0x8/u,cpu/event=3D0xa8,umask=3D0x1/u,cpu/event=3D0=
x79,umask=3D0x4/u,cpu/event=3D0x79,umask=3D0x30/u,cpu/event=3D0xc0,umask=3D=
0x0/u,cpu/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x10,umask=3D0x20/u,cpu/=
event=3D0x10,umask=3D0x80/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x1=
0,umask=3D0x40/u},{cpu/event=3D0x11,umask=3D0x2/u,cpu/event=3D0x11,umask=3D=
0x1/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/eve=
nt=3D0x3c,umask=3D0x1/u},{cpu/event=3D0x10,umask=3D0x20/u,cpu/event=3D0x10,=
umask=3D0x80/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x4=
0/u,cpu/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x3c,umask=3D0x0/ku,cpu/ev=
ent=3D0x3c,umask=3D0x1/u,cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xd,uma=
sk=3D0x3,cmask=3D1/u},{cpu/event=3D0x9c,umask=3D0x1/u,cpu/event=3D0x3c,umas=
k=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/u,cpu=
/event=3D0xc2,umask=3D0x2/u},{cpu/event=3D0xe,umask=3D0x1/u,cpu/event=3D0xc=
2,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,cpu/event=3D0x3c,um=
ask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0x9c,umask=3D0x1/u=
,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D=
0x3c,umask=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},{cpu/event=3D0x3c,umask=
=3D0x0/u,cpu/event=3D0x9c,umask=3D0x1,cmask=3D4/u,cpu/event=3D0x3c,umask=3D=
0x2/u,cpu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0x9c,umask=3D0x1/u,cpu/eve=
nt=3D0xc0,umask=3D0x0/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0x3c,u=
mask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/u,=
cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u},{cpu/event=3D0xc2,umask=3D0x2/u,cp=
u/event=3D0xe,umask=3D0x1/u,cpu/event=3D0x79,umask=3D0x30/u,cpu/event=3D0x3=
c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0xe,umask=3D0x=
1/u,cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,=
cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=
=3D0xc5,umask=3D0x0/u,cpu/event=3D0xc3,umask=3D0x1,edge=3D1,cmask=3D1/u,cpu=
/event=3D0x3c,umask=3D0x1/u},dummy,{cpu/event=3D0xe,umask=3D0x1/u,cpu/event=
=3D0xc2,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,cpu/event=3D0=
x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0x9c,umask=
=3D0x1/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/=
event=3D0x3c,umask=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},dummy,{cpu/event=
=3D0xa3,umask=3D0x6,cmask=3D6/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/event=3D=
0xa3,umask=3D0x4,cmask=3D4/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D1/u},{cpu=
/event=3D0xb1,umask=3D0x1,cmask=3D3/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D=
2/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0x5e,umask=3D0x1/u,cpu/event=
=3D0x9c,umask=3D0x1,cmask=3D4/u},{cpu/event=3D0x9c,umask=3D0x1/u,cpu/event=
=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=
=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu=
/event=3D0xd,umask=3D0x3,cmask=3D1/u},dummy,dummy,emulation-faults,dummy,{c=
pu/event=3D0xa3,umask=3D0x6,cmask=3D6/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/=
event=3D0xa3,umask=3D0x4,cmask=3D4/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D1=
/u},{cpu/event=3D0xb1,umask=3D0x1,cmask=3D3/u,cpu/event=3D0xb1,umask=3D0x1,=
cmask=3D2/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0x5e,umask=3D0x1/u,c=
pu/event=3D0x9c,umask=3D0x1,cmask=3D4/u},{cpu/event=3D0x79,umask=3D0x30,edg=
e=3D1,cmask=3D1/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x87,umask=3D0=
x1/u,cpu/event=3D0xab,umask=3D0x2/u,cpu/event=3D0xa2,umask=3D0x8/u},{cpu/ev=
ent=3D0x85,umask=3D0x10/u,cpu/event=3D0x85,umask=3D0x4/u,cpu/event=3D0x3c,u=
mask=3D0x0/u,cpu/event=3D0x8,umask=3D0x10/u,cpu/event=3D0x8,umask=3D0x4/u},=
{cpu/event=3D0xc5,umask=3D0x0/u,cpu/event=3D0xc3,umask=3D0x1,edge=3D1,cmask=
=3D1/u,cpu/event=3D0xe6,umask=3D0x1f/u,cpu/event=3D0x3c,umask=3D0x0/u},{cpu=
/event=3D0xd1,umask=3D0x4/u,cpu/event=3D0xd1,umask=3D0x20/u,cpu/event=3D0xa=
3,umask=3D0x5,cmask=3D5/u,cpu/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x14=
,umask=3D0x1/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/=
u,cpu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0x11,umask=3D0x2/u},{cpu/event=
=3D0xc2,umask=3D0x2/u,cpu/event=3D0xe,umask=3D0x1/u,cpu/event=3D0x79,umask=
=3D0x30/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{c=
pu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0x10,umask=3D0x1/u,cpu/event=3D0x=
b1,umask=3D0x1/u,cpu/event=3D0x10,umask=3D0x20/u},{cpu/event=3D0x10,umask=
=3D0x80/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x40/u,c=
pu/event=3D0x11,umask=3D0x1/u},{cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D=
0x9c,umask=3D0x1,cmask=3D4/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3=
c,umask=3D0x1/u},dummy,{cpu/event=3D0xa3,umask=3D0x4,cmask=3D4/u,cpu/event=
=3D0xb1,umask=3D0x1,cmask=3D1/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D3/u,cp=
u/event=3D0xb1,umask=3D0x1,cmask=3D2/u},{cpu/event=3D0xc0,umask=3D0x0/u,cpu=
/event=3D0x5e,umask=3D0x1/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/event=3D0xa3=
,umask=3D0x6,cmask=3D6/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x60,um=
ask=3D0x8,cmask=3D6/u},{cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x60,uma=
sk=3D0x8,cmask=3D1/u,cpu/event=3D0x60,umask=3D0x8,cmask=3D6/u},{cpu/event=
=3D0xc2,umask=3D0x2/u,cpu/event=3D0x10,umask=3D0x1/u,cpu/event=3D0xb1,umask=
=3D0x1/u},{cpu/event=3D0x10,umask=3D0x20/u,cpu/event=3D0x10,umask=3D0x80/u,=
cpu/event=3D0xb1,umask=3D0x1/u,cpu/event=3D0x10,umask=3D0x10/u},emulation-f=
aults,{cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x40/u,cpu/=
event=3D0x11,umask=3D0x1/u,cpu/event=3D0x11,umask=3D0x2/u},emulation-faults=
,{cpu/event=3D0x11,umask=3D0x2/u,cpu/event=3D0x11,umask=3D0x1/u,cpu/event=
=3D0xb1,umask=3D0x1/u}'



