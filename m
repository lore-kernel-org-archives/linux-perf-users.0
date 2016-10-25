From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: perf bpf-output example program
Date: Tue, 25 Oct 2016 01:37:56 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1610250136010.32482@macbook-air>
References: <alpine.DEB.2.20.1610231302040.27722@macbook-air> <580ECF62.8020900@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35825 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755322AbcJYFi1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Oct 2016 01:38:27 -0400
Received: by mail-oi0-f50.google.com with SMTP id i127so24408969oia.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2016 22:38:03 -0700 (PDT)
In-Reply-To: <580ECF62.8020900@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, 25 Oct 2016, Wangnan (F) wrote:

> But in your case it reports can't locate kbuild dir. Please fix it, or the
>  #include <uapi/linux/bpf.h>
> at the head of test-bpf-output.c causes failure.

It looks like the problem was trying to run on 4.7 kernel, which just 
didn't work.  I tried running on 4.9-rc1 and it seems to work.

Thanks for the help

Vince
