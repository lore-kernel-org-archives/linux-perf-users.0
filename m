Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC37EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 09:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjFVJ3D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 05:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjFVJ23 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 05:28:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696B53A96
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687425621; x=1718961621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mWna7oMxuqOohljFW9zcnexigbwEdDOnvtfN9EGkVfI=;
  b=JWulOMmBzLQxCyVMVpZBVWhWv/QZIVfMkhaajdo3nQEPAZwaKWyMU/lT
   ao0wohzYPHZ62OSsgwVuZWFNxQo8CcrkiDZdYZ79wSBzC4iWHRH3Jv4ou
   Rj97PXOqpiP4bSZUZxa3I1in0ev8JvDoMb+6p6x9YbQfq1HHwzqHNGe1q
   sGcU22WCnor9jO5hLE2ijnapqQqy9BgYJrQDVm2Uz5nvDz5pJnqjKvoY4
   RUDjb1mia/F0EhKNy9ff/xN81DnMXrQIRjlPf6i08osDjXlHHW4cswLhm
   GHDp9FbDWegWzTDXMfjTXl1si1+xo9za6BHGZU3erKe272qc96pCB57PQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363859044"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="363859044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 02:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744526610"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="744526610"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 02:20:21 -0700
Date:   Thu, 22 Jun 2023 02:20:16 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: Perf stat regression from d15480a3d67
Message-ID: <ZJQSUHLe9Cqpw21n@tassilo>
References: <ZJOmXU/41HMzanM9@tassilo>
 <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> Can you provide an example that is breaking?

I only have a very long auto generated example[1], because it's not
easy to make a non scheduling event and it's also dependent on the system. =
The example=20
works on a SKX.

>=20
> Wrt event order, cases like:
> ```
> $ sudo perf stat -e '{data_read,data_write}' -a --no-merge sleep 1
>=20
> Performance counter stats for 'system wide':
>=20
>          1,960.81 MiB  data_read [uncore_imc_free_running_1]
>            438.48 MiB  data_write [uncore_imc_free_running_1]
>          1,961.85 MiB  data_read [uncore_imc_free_running_0]
>            438.79 MiB  data_write [uncore_imc_free_running_0]
>=20
>       1.001127356 seconds time elapsed
> ```
> Reorder events so that the PMUs match (ie the -e order would 2x
> data_read followed by 2x data_write). This covers more cases now so
> that perf metric (aka topdown) events aren't broken when coming out of
> metrics:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools=
/perf/util/parse-events.c?h=3Dperf-tools-next#n2139

How is any tool supposed to handle arbitary output reordering like
that? Perf is not just for humans, but also for tools.

It cannot just look up the events by name because there might be multiple
instances of the same event in different groups.

The only reliable way to match is to match on the original order,
but that totally breaks down with these changes.

The same actually applies to humans reading the output too,
if it's ambigious for the tool it will be ambigious to the human too.
perf stat shouldn't reorder events ever.

>=20
> Given the original commit message there seems little point to give the
> 0 counts, but perhaps it is something that could be done on the more
> tool oriented CSV and JSON output formats.

It's not 0 counts, it's <not supported>. But even 0 counts can=20
be important.

We should always output when something doesn't count so that
the user knows something is wrong. Hiding problems is always a bad idea
and not an improvement.


-Andi

[1] Long example for SKX:

perf stat -o p3 -x\; -e '{cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0x3c,u=
mask=3D0x0/u,cpu/event=3D0x0,umask=3D0x3/u,cpu/event=3D0x3c,umask=3D0x2/u,c=
pu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0xb1,umask=3D0x1/u,cpu/event=3D0x=
b1,umask=3D0x2,cmask=3D1/u},msr/tsc/,duration_time,dummy,uncore_imc/event=
=3D0x4,umask=3D0x3/,uncore_imc/event=3D0x4,umask=3D0xc/,cs:u,minor-faults:u=
,major-faults:u,migrations:u,{cycles:u,cpu/event=3D0x0,umask=3D0x3/u,cpu/ev=
ent=3D0xc2,umask=3D0x2/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0xc4,um=
ask=3D0x40/u,cpu/event=3D0xb1,umask=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},=
{cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xc2,umask=3D0x2,cmask=3D1/u,cp=
u/event=3D0x3c,umask=3D0x0/ku,cpu/event=3D0xc0,umask=3D0x0/ku},{cpu/event=
=3D0x79,umask=3D0x8/u,cpu/event=3D0xa8,umask=3D0x1/u,cpu/event=3D0x79,umask=
=3D0x4/u,cpu/event=3D0x79,umask=3D0x30/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu=
/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x10,umask=3D0x20/u,cpu/event=3D0=
x10,umask=3D0x80/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=
=3D0x40/u},{cpu/event=3D0x11,umask=3D0x2/u,cpu/event=3D0x11,umask=3D0x1/u,c=
pu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x=
3c,umask=3D0x1/u},{cpu/event=3D0x10,umask=3D0x20/u,cpu/event=3D0x10,umask=
=3D0x80/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x40/u,c=
pu/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x3c,umask=3D0x0/ku,cpu/event=
=3D0x3c,umask=3D0x1/u,cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xd,umask=
=3D0x3,cmask=3D1/u},{cpu/event=3D0x9c,umask=3D0x1/u,cpu/event=3D0x3c,umask=
=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/u,cpu/=
event=3D0xc2,umask=3D0x2/u},{cpu/event=3D0xe,umask=3D0x1/u,cpu/event=3D0xc2=
,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,cpu/event=3D0x3c,uma=
sk=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0x9c,umask=3D0x1/u,=
cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0=
x3c,umask=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},{cpu/event=3D0x3c,umask=3D=
0x0/u,cpu/event=3D0x9c,umask=3D0x1,cmask=3D4/u,cpu/event=3D0x3c,umask=3D0x2=
/u,cpu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0x9c,umask=3D0x1/u,cpu/event=
=3D0xc0,umask=3D0x0/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0x3c,uma=
sk=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/u,cp=
u/event=3D0xd,umask=3D0x3,cmask=3D1/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu/=
event=3D0xe,umask=3D0x1/u,cpu/event=3D0x79,umask=3D0x30/u,cpu/event=3D0x3c,=
umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0xe,umask=3D0x1/=
u,cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,cp=
u/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0=
xc5,umask=3D0x0/u,cpu/event=3D0xc3,umask=3D0x1,edge=3D1,cmask=3D1/u,cpu/eve=
nt=3D0x3c,umask=3D0x1/u},dummy,{cpu/event=3D0xe,umask=3D0x1/u,cpu/event=3D0=
xc2,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,cpu/event=3D0x3c,=
umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0x9c,umask=3D0x1=
/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=
=3D0x3c,umask=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},dummy,{cpu/event=3D0xa=
3,umask=3D0x6,cmask=3D6/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/event=3D0xa3,u=
mask=3D0x4,cmask=3D4/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D1/u},{cpu/event=
=3D0xb1,umask=3D0x1,cmask=3D3/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D2/u,cp=
u/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0x5e,umask=3D0x1/u,cpu/event=3D0x9=
c,umask=3D0x1,cmask=3D4/u},{cpu/event=3D0x9c,umask=3D0x1/u,cpu/event=3D0x3c=
,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/=
u,cpu/event=3D0xe,umask=3D0x1/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=
=3D0xd,umask=3D0x3,cmask=3D1/u},dummy,dummy,emulation-faults,dummy,{cpu/eve=
nt=3D0xa3,umask=3D0x6,cmask=3D6/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/event=
=3D0xa3,umask=3D0x4,cmask=3D4/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D1/u},{=
cpu/event=3D0xb1,umask=3D0x1,cmask=3D3/u,cpu/event=3D0xb1,umask=3D0x1,cmask=
=3D2/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0x5e,umask=3D0x1/u,cpu/ev=
ent=3D0x9c,umask=3D0x1,cmask=3D4/u},{cpu/event=3D0x79,umask=3D0x30,edge=3D1=
,cmask=3D1/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x87,umask=3D0x1/u,=
cpu/event=3D0xab,umask=3D0x2/u,cpu/event=3D0xa2,umask=3D0x8/u},{cpu/event=
=3D0x85,umask=3D0x10/u,cpu/event=3D0x85,umask=3D0x4/u,cpu/event=3D0x3c,umas=
k=3D0x0/u,cpu/event=3D0x8,umask=3D0x10/u,cpu/event=3D0x8,umask=3D0x4/u},{cp=
u/event=3D0xc5,umask=3D0x0/u,cpu/event=3D0xc3,umask=3D0x1,edge=3D1,cmask=3D=
1/u,cpu/event=3D0xe6,umask=3D0x1f/u,cpu/event=3D0x3c,umask=3D0x0/u},{cpu/ev=
ent=3D0xd1,umask=3D0x4/u,cpu/event=3D0xd1,umask=3D0x20/u,cpu/event=3D0xa3,u=
mask=3D0x5,cmask=3D5/u,cpu/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x14,um=
ask=3D0x1/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,c=
pu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0x11,umask=3D0x2/u},{cpu/event=3D=
0xc2,umask=3D0x2/u,cpu/event=3D0xe,umask=3D0x1/u,cpu/event=3D0x79,umask=3D0=
x30/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/e=
vent=3D0xc2,umask=3D0x2/u,cpu/event=3D0x10,umask=3D0x1/u,cpu/event=3D0xb1,u=
mask=3D0x1/u,cpu/event=3D0x10,umask=3D0x20/u},{cpu/event=3D0x10,umask=3D0x8=
0/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x40/u,cpu/eve=
nt=3D0x11,umask=3D0x1/u},{cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x9c,u=
mask=3D0x1,cmask=3D4/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umas=
k=3D0x1/u},dummy,{cpu/event=3D0xa3,umask=3D0x4,cmask=3D4/u,cpu/event=3D0xb1=
,umask=3D0x1,cmask=3D1/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D3/u,cpu/event=
=3D0xb1,umask=3D0x1,cmask=3D2/u},{cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=
=3D0x5e,umask=3D0x1/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/event=3D0xa3,umask=
=3D0x6,cmask=3D6/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x60,umask=3D=
0x8,cmask=3D6/u},{cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x60,umask=3D0=
x8,cmask=3D1/u,cpu/event=3D0x60,umask=3D0x8,cmask=3D6/u},{cpu/event=3D0xc2,=
umask=3D0x2/u,cpu/event=3D0x10,umask=3D0x1/u,cpu/event=3D0xb1,umask=3D0x1/u=
},{cpu/event=3D0x10,umask=3D0x20/u,cpu/event=3D0x10,umask=3D0x80/u,cpu/even=
t=3D0xb1,umask=3D0x1/u,cpu/event=3D0x10,umask=3D0x10/u},emulation-faults,{c=
pu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x40/u,cpu/event=3D=
0x11,umask=3D0x1/u,cpu/event=3D0x11,umask=3D0x2/u},emulation-faults,{cpu/ev=
ent=3D0x11,umask=3D0x2/u,cpu/event=3D0x11,umask=3D0x1/u,cpu/event=3D0xb1,um=
ask=3D0x1/u}' ~/pmu/pmu-tools/workloads/BC1s
grep uncore p3
