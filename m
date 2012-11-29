From: Animesh K Trivedi1 <ZRLATR@ch.ibm.com>
Subject: Re: cboxes on NehalemEX
Date: Thu, 29 Nov 2012 10:15:04 +0100
Message-ID: <OF06F65378.873F0645-ONC1257AC5.00324D5B-C1257AC5.0032D88B@ch.ibm.com>
References: <OF1ABEA8BA.B758F3D3-ONC1257AB8.00507893-C1257AB8.00512F18@ch.ibm.com> <m2fw3th3hp.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:58356 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab2K2JPn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Nov 2012 04:15:43 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <zrlatr@ch.ibm.com>;
	Thu, 29 Nov 2012 09:15:40 -0000
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id qAT9F6C850069568
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Nov 2012 09:15:06 GMT
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id qAT9FDQT009557
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Nov 2012 02:15:13 -0700
In-Reply-To: <m2fw3th3hp.fsf@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Bernard Metzler <BMT@zurich.ibm.com>, linux-perf-users@vger.kernel.org

Hi Andi,

Thanks for the reply. E7520 have 4 cores (and 8 threads, though I assume
that is irrelevant) but in a dual-socket configuration shouldn't I see
total of 8 CBoxes? 4 CBoxes for each E7520 processor ?

Cheers,
--
Animesh

Andi Kleen <andi@firstfloor.org> wrote on 11/28/2012 09:33:22 PM:

> From: Andi Kleen <andi@firstfloor.org>
> To: Animesh K Trivedi1/Zurich/IBM@IBMCH,
> Cc: linux-perf-users@vger.kernel.org, Bernard Metzler
<BMT@zurich.ibm.com>
> Date: 11/28/2012 09:33 PM
> Subject: Re: cboxes on NehalemEX
>
> Animesh K Trivedi1 <ZRLATR@ch.ibm.com> writes:
>
> > Hi all,
> >
> > I'm testing/using uncore support on a dual socket NehalemEX (Xeon
E7520)
> > box on 3.7-rc1.
> > It shows me only 4 CBOXes under devices. Although the document (Uncore
> > programming
> > for 7500) says that there should be 8 CBOXes. Am I missing something?
>
> The number of CBOXes depends on the number of CPU cores in the socket.
> Each core has a CBOX.  You would only see 8 on a 8 core CPU.
>
>
> > get a global view of LLC behaviour shouldn't I have to sum up the count
of
> > events from all
> > physical processor's CBOXes.
>
> Yes. Each BOX has its own counters.
>
> -Andi
>
> --
> ak@linux.intel.com -- Speaking for myself only
>
