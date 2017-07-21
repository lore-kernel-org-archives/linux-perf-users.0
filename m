From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf report: fix kernel symbol adjustment for s390x
Date: Fri, 21 Jul 2017 13:27:06 -0300
Message-ID: <20170721162706.GI4134@kernel.org>
References: <20170713130252.6167-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbdGUQ1P (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Jul 2017 12:27:15 -0400
Content-Disposition: inline
In-Reply-To: <20170713130252.6167-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

Em Thu, Jul 13, 2017 at 03:02:52PM +0200, Thomas Richter escreveu:
> I would like to fix this by introducing an archticture
> specific function named elf__needs_adjust_symbols(). This is the same
> approach as done by PowerPC.

Seems ok, arch specific one, same method used by another arch, applied.

- Arnaldo
