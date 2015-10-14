From: William Cohen <wcohen@redhat.com>
Subject: Re: unresolved function names in perf output
Date: Wed, 14 Oct 2015 11:50:28 -0400
Message-ID: <561E79C4.1020907@redhat.com>
References: <201510141318.t9EDIkYW025291@d01av02.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43978 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198AbbJNPu3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 14 Oct 2015 11:50:29 -0400
In-Reply-To: <201510141318.t9EDIkYW025291@d01av02.pok.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: George Chochia <chochia@us.ibm.com>, oprofile-list <oprofile-list@lists.sourceforge.net>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 10/14/2015 09:08 AM, George Chochia wrote:
> Hello,
> 
> I am profiling an MPI app using perf tool on Power 8, LE node installed with RHEL 7.2 3.10.0-316.el7.ppc64le.
> Functions from libmlx5-rdmav2.so (Mellanox library from MOFED 3.1-1.0.0.2) show up as function pointers in perf report.
> 
> On the same node installed with Ubuntu 14.04.03 and same MOFED level function names are resolved.

Hi,

It sounds like libmlx5-rdmav2.so might missing debuginfo on the RHEL7.2 version and that is why the addresses are not be mapped back to function names.  You might try the following to see if there are symbols for that library:

eu-readelf -s <path_to_library>

Where did you get libmlx5-rdmav2.so?  You might also check to see if there is an associated debuginfo rpm for that package that needs to be installed. RHEL packages typically have debug information stripped from the rpm and placed in a separate debuginfo rpm.

-Will

> RHEL 7.2
> 19.79%spark64.Linux.L libpami.so [.] _stripe_hal_writepkti
> 11.89%spark64.Linux.L libhal64_ibm.so [.] hal_ibl_rc_scq_flush
> 9.07%spark64.Linux.L libhal64_ibm.so [.] hal_ibl_rc_read_callback
> 8.40%spark64.Linux.L libpami.so [.] _stripe_hal_read_callback
> 7.65%spark64.Linux.L libpami.so [.] _stripe_hal_flush
> 5.83%spark64.Linux.L libhal64_ibm.so [.] hal_ibl_rc_scq_writepkti
> 4.48%spark64.Linux.L libpami.so [.] LapiImpl::Interconnect::SendPacketI
> 3.19%spark64.Linux.L libpami.so [.] Sam::Send
> 2.75%spark64.Linux.L libpami.so [.] _lapi_dispatcher<true>
> 2.33%spark64.Linux.L libmlx5-rdmav2.so [.] 0x0000000000010b20
> 2.02%spark64.Linux.L libpami.so [.] SamSendQueue::Process
> 1.82%spark64.Linux.L libmlx5-rdmav2.so [.] 0x0000000000010b98
> 
> 
> Ubuntu 14.04.3
> 18.09%spark64.Linux.L libpami.so [.] _Z21_stripe_hal_writepktiPvS_S_jS_
> 9.54%spark64.Linux.L libhal64_ibm.so [.] hal_ibl_rc_scq_flush
> 8.67%spark64.Linux.L libmlx5-rdmav2.so [.] mlx5_poll_cq_1
> 8.22%spark64.Linux.L libhal64_ibm.so [.] hal_ibl_rc_read_callback
> 7.70%spark64.Linux.L libpami.so [.] _Z25_stripe_hal_read_callbackPvPFiS_S_jES_P11hal_param_t
> 7.24%spark64.Linux.L libpami.so [.] _Z17_stripe_hal_flushPvS_
> 6.76%spark64.Linux.L libhal64_ibm.so [.] hal_ibl_rc_scq_writepkti
> 4.52%spark64.Linux.L libmlx5-rdmav2.so [.] get_sw_cqe
> 
> 
> Regards
> 
> 
> ------------------------------------------------------------------------------
> 
> 
> 
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
> 
