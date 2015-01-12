From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf support for interpreted and Just-In-Time translated olanguages
Date: Mon, 12 Jan 2015 10:58:41 -0700
Message-ID: <54B40B51.5080107@gmail.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>	 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>	 <20141209203419.GI4189@kernel.org> <87ppbs4h5k.fsf@tassilo.jf.intel.com>	 <20141209222203.GD8788@kernel.org>	 <20141210173228.GA6759@two.firstfloor.org> <54888569.30409@gmail.com>	 <20141210180529.GB6759@two.firstfloor.org> <54889086.4070606@gmail.com>	 <20141210194302.GH8788@kernel.org>	 <1420834758.4897.10.camel@oc0276584878.ibm.com>	 <54B0A757.2010407@redhat.com>  <54B141F2.60104@gmail.com> <1421083368.6211.2.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32785 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbALR6n (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 Jan 2015 12:58:43 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so33293959pab.6
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2015 09:58:43 -0800 (PST)
In-Reply-To: <1421083368.6211.2.camel@oc0276584878.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Carl Love <cel@us.ibm.com>
Cc: William Cohen <wcohen@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 1/12/15 10:22 AM, Carl Love wrote:
> Ah, this is the ioctl patch you had mentioned you mentioned previously.
> I hadn't found the patch before.  Yes, this looks like it would work.  I
> will see if I can get a prototype working with this patch.  Thanks.
>

If you need to shove samples into perf (versus mmap updates) I suspect 
the prctl system call will have way to much overhead. In that case 
perhaps processes could export a shared memory buffer that a perf 
session could attach -- another aux buffer similar to what itrace needs. 
But then that brings in the perf_clock issue; samples would need to have 
the same time basis as kernel generated samples.

David
