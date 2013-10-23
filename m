From: David Ahern <dsahern@gmail.com>
Subject: Re: urgent help needed :perf record and report showing inconsistent
 results
Date: Thu, 24 Oct 2013 00:23:40 +0100
Message-ID: <52685A7C.6040107@gmail.com>
References: <loom.20131023T175255-294@post.gmane.org> <5267FA74.603@gmail.com> <CAJUy+oSrdAwiGVBZq-PPFB-U7gPzRwPCrFSucEyySCYqT+9v9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:39944 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab3JWXXs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Oct 2013 19:23:48 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so1518106wgh.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 16:23:47 -0700 (PDT)
In-Reply-To: <CAJUy+oSrdAwiGVBZq-PPFB-U7gPzRwPCrFSucEyySCYqT+9v9g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Nitisha Jain <nitishajain15@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 10/23/13 7:30 PM, Nitisha Jain wrote:
>
>
> I am not able to find 'perf kvm stat live' command , when I try, I get :
>
> usage: perf kvm [<options>] {top|record|report|diff|buildid-list}
>
> Is this subcommand still supported in the current version of perf ? if
> yes, can u please tell the exact syntax ?

You need perf code from 3.12.

David
