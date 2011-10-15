From: Sujamol James <sujamoljames@yahoo.com>
Subject: Performance Events/Hw Cache Miss counting
Date: Sat, 15 Oct 2011 02:12:03 +0000 (UTC)
Message-ID: <loom.20111015T035102-72@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44681 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab1JQSKN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Oct 2011 14:10:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1RFrdZ-00085b-Lr
	for linux-perf-users@vger.kernel.org; Mon, 17 Oct 2011 20:10:10 +0200
Received: from 216.52.20.2 ([216.52.20.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2011 20:10:09 +0200
Received: from sujamoljames by 216.52.20.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2011 20:10:09 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi All,

I am trying to query the performance management counters on my box, whi=
ch is=20
based on Kernel 2.6.38 and running Intel processor.  I am trying to do =
the=20
same from my kernel module itself as I need to profile my kernel module=
s. I=20
use the perf_event_create_kernel_counter() api with the following attr/=
config

The below  attrs/configuration is working and I am getting the counter=20
values/overflow_handler is getting called.
static struct perf_event_attr counter_attrs[] =3D {
{
  	{
	 .type		 =3D PERF_TYPE_HARDWARE,
	 .config	 	=3D PERF_COUNT_HW_CACHE_MISSES,
	 .size		 =3D sizeof(struct perf_event_attr),
	 .pinned	 =3D 1,
	 .disabled	 =3D 0,
	 },
 };

But, when I use the following attrs/config, the=20
perf_event_create_kernel_counter() API is failing.  Ie,  (IS_ERR
(returned_pevent) is TRUE and the event is not triggered on the CPU.  I=
 even=20
used =E2=80=9CPERF_TYPE_HARDWARE=E2=80=9D type also with the below conf=
ig.
static struct perf_event_attr counter_attrs[] =3D {
{
	.type		  =3D  PERF_TYPE_HW_CACHE,
 .config	  =3D	 PERF_COUNT_HW_CACHE_L1D 			   << =20
0  |
		   	(PERF_COUNT_HW_CACHE_OP_READ 		   <<  8) |
			(PERF_COUNT_HW_CACHE_RESULT_MISS 	   << 16),
	.size	  =3D sizeof(struct perf_event_attr),
	.pinned   =3D 1,
	.disabled =3D 0,
	},
 };

Does anybody know why?. What =E2=80=9Cconfig=E2=80=9D value  I should u=
se to query the L1D/=20
L1I cache misses. I think the =E2=80=9CPERF_COUNT_HW_CACHE_MISSES=E2=80=
=9D counts only 2nd and=20
3rd level caches.

Thanks,
Suja
