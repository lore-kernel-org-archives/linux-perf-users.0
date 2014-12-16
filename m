From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Is it possible to get source code annotation for kernel modules ?
Date: Tue, 16 Dec 2014 08:44:32 -0300
Message-ID: <20141216114432.GQ9845@kernel.org>
References: <loom.20141126T215923-206@post.gmane.org>
 <loom.20141215T094546-812@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34121 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaLPLog (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Dec 2014 06:44:36 -0500
Content-Disposition: inline
In-Reply-To: <loom.20141215T094546-812@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jerome Correnoz <jerome.correnoz@st.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, Dec 15, 2014 at 08:51:36AM +0000, Jerome Correnoz escreveu:
> Hi,
> 
> Could someone please provide support on it ? 
> 
> We would like to know if 'perf annotate' can allow to display the C source
> code interleaved with disassembly for the kernel modules (we can get it only
> for user space application. For kerne modules, we only have the
> disassembly). Is it feasible for kernel modules ?

Yes it is possible, as is possible for userspace, someone has to work on it.

- Arnaldo
