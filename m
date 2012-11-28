From: Andi Kleen <andi@firstfloor.org>
Subject: Re: cboxes on NehalemEX
Date: Wed, 28 Nov 2012 12:33:22 -0800
Message-ID: <m2fw3th3hp.fsf@firstfloor.org>
References: <OF1ABEA8BA.B758F3D3-ONC1257AB8.00507893-C1257AB8.00512F18@ch.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14794 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab2K1UdZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 28 Nov 2012 15:33:25 -0500
In-Reply-To: <OF1ABEA8BA.B758F3D3-ONC1257AB8.00507893-C1257AB8.00512F18@ch.ibm.com>
	(Animesh K. Trivedi1's message of "Fri, 16 Nov 2012 15:46:36 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Animesh K Trivedi1 <ZRLATR@ch.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Bernard Metzler <BMT@zurich.ibm.com>

Animesh K Trivedi1 <ZRLATR@ch.ibm.com> writes:

> Hi all,
>
> I'm testing/using uncore support on a dual socket NehalemEX (Xeon E7520)
> box on 3.7-rc1.
> It shows me only 4 CBOXes under devices. Although the document (Uncore
> programming
> for 7500) says that there should be 8 CBOXes. Am I missing something?

The number of CBOXes depends on the number of CPU cores in the socket.
Each core has a CBOX.  You would only see 8 on a 8 core CPU.


> get a global view of LLC behaviour shouldn't I have to sum up the count of
> events from all
> physical processor's CBOXes.

Yes. Each BOX has its own counters.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
