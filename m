From: Jerome CORRENOZ <jerome.correnoz@st.com>
Subject: RE: Is it possible to get source code annotation for kernel modules
 ?
Date: Thu, 18 Dec 2014 16:23:11 +0100
Message-ID: <A896A0DA7D7489439B5404E97E8CA1400158AB95165A@SAFEX1MAIL2.st.com>
References: <loom.20141126T215923-206@post.gmane.org>
 <loom.20141215T094546-812@post.gmane.org> <20141216114432.GQ9845@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37335 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750899AbaLRPXV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Dec 2014 10:23:21 -0500
In-Reply-To: <20141216114432.GQ9845@kernel.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi Arnaldo,

It would be a nice feature. In particular when people are interested to display C source annotation for a specific kernel module.

Best Regards,
  Jerome

-----Original Message-----
From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org] 
Sent: Tuesday, December 16, 2014 12:45 PM
To: Jerome CORRENOZ
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Is it possible to get source code annotation for kernel modules ?

Em Mon, Dec 15, 2014 at 08:51:36AM +0000, Jerome Correnoz escreveu:
> Hi,
> 
> Could someone please provide support on it ? 
> 
> We would like to know if 'perf annotate' can allow to display the C 
> source code interleaved with disassembly for the kernel modules (we 
> can get it only for user space application. For kerne modules, we only 
> have the disassembly). Is it feasible for kernel modules ?

Yes it is possible, as is possible for userspace, someone has to work on it.

- Arnaldo
