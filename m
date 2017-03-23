From: David Ahern <dsahern@gmail.com>
Subject: Re: Need help in tracking down OS jitters using Intel PT
Date: Thu, 23 Mar 2017 09:30:01 -0600
Message-ID: <6ccea408-bf0e-e730-5375-e6cba55f6540@gmail.com>
References: <CAPJB79SqGQY-jb455rJXsyzF7cEkrLE653rwG+rPy6F4+-VQEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34729 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935061AbdCWPaF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Mar 2017 11:30:05 -0400
Received: by mail-pg0-f46.google.com with SMTP id 21so92216712pgg.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2017 08:30:04 -0700 (PDT)
In-Reply-To: <CAPJB79SqGQY-jb455rJXsyzF7cEkrLE653rwG+rPy6F4+-VQEA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yilong Li <yilongl@cs.stanford.edu>, linux-perf-users@vger.kernel.org

On 3/23/17 3:28 AM, Yilong Li wrote:
> What am I missing? Where does the 15us go? The program and the scripts
> I used in the experiment can be found here:
> https://github.com/yilongli/OSJitterTest.

have you tried the hw latency detector? kernel/trace/trace_hwlat.c and
config HWLAT_TRACER
