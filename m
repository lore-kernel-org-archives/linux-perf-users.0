From: David Ahern <dsahern@gmail.com>
Subject: Re: urgent help needed :perf record and report showing inconsistent
 results
Date: Wed, 23 Oct 2013 17:33:56 +0100
Message-ID: <5267FA74.603@gmail.com>
References: <loom.20131023T175255-294@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:43819 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab3JWQeC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Oct 2013 12:34:02 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so1197639wid.3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 09:34:00 -0700 (PDT)
In-Reply-To: <loom.20131023T175255-294@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Nitisha Jain <nitishajain15@gmail.com>, linux-perf-users@vger.kernel.org

On 10/23/13 5:06 PM, Nitisha Jain wrote:
> hi,
>
> I am trying to find the overhead due to the kvm hypervisor when an IO
> intensive process is running on a virtual machine and the perf record/report
> are run on the host.( host has 12 cores, VM is pinned to a core)

Have you tried 'perf kvm stat live'?

David
