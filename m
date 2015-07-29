From: David Ahern <dsahern@gmail.com>
Subject: Re: perf CPU profiling in Xen guest fail & workaround
Date: Wed, 29 Jul 2015 14:02:23 -0600
Message-ID: <55B9314F.70800@gmail.com>
References: <CAE40pdd6Ab9w1da7ztwed+h9NUbtLyqiC1-tarrGQsFo2MrmzQ@mail.gmail.com> <55B92661.7010309@gmail.com> <CAE40pdfEv5aFDUf_ixp_mtq9T1NQ4sCkhS211EwaaeCg7a=8NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34885 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbbG2UC0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jul 2015 16:02:26 -0400
Received: by pdrg1 with SMTP id g1so11165424pdr.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2015 13:02:25 -0700 (PDT)
In-Reply-To: <CAE40pdfEv5aFDUf_ixp_mtq9T1NQ4sCkhS211EwaaeCg7a=8NQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 7/29/15 1:27 PM, Brendan Gregg wrote:
> Thanks, yes. This took me by surprise: I've been profiling different
> Xen guests for over a year, but this is the first time I've hit this.
>
> All my other Xen guests:
>
> # dmesg | grep Performance
> [    0.058664] Performance Events: unsupported p6 CPU model 62 no PMU
> driver, software events only.
>
> This linux 4.1 Xen guest:
>
> # dmesg | grep Performance
> [    0.258140] Performance Events: 16-deep LBR, IvyBridge events,
> Intel PMU driver.


yep and since the hypervisor lies perf has no means of knowing to 
fallback to cpu-clock.
