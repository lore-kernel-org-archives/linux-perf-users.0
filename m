From: Runzhen Wang <icycoder@gmail.com>
Subject: Re: perf record: per-event sampling period
Date: Tue, 18 Jun 2013 14:39:16 +0800
Message-ID: <20130618063914.GA25372@gmail.com>
References: <CAN1HeCdeoNs4rPcLVcJGbcrJhmzjhd9AkJfx2WSPAwJJ_XugMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:58232 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3FRGjY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Jun 2013 02:39:24 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so4146120obc.27
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jun 2013 23:39:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN1HeCdeoNs4rPcLVcJGbcrJhmzjhd9AkJfx2WSPAwJJ_XugMQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <tabloid.adroit@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi, Yuanfang,

Usually, the package from fedora offical repo is stable but not
includes some new feature, so, maybe you can download the latest 
linux kernel source code from kernel.org, change directory to 
tools/perf .

Then, be a root to 'make', and try ./perf record .......

the perf tool is small, compile it needs no more than 1min, please 
have a try. ;-)

Thanks
Runzhen

On Mon, Jun 17, 2013 at 02:18:52PM -0400, Yuanfang Chen wrote:
> Hi all,
> 
> Is the per-event sampling period supported now? I'm searching around,
> found [1] using "-c 100,1000" method, [2] using
> "cpu/----/period=1000". However, neither of these work in my box
> (fedora 18, 3.8.11-200.fc18.x86_64, with perf package from fedora 18
> repo ).
> 
> thanks,
> yuanfang
> 
> [1]https://lkml.org/lkml/2010/11/23/122
> [2]http://cscads.rice.edu/workshops/summer-2012/slides/performance-tools/CSCADS_2012_perf_events_status_update.pdf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
