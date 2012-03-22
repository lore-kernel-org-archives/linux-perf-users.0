From: David Ahern <dsahern@gmail.com>
Subject: Re: perf stat: Doubt about stall cycle support
Date: Wed, 21 Mar 2012 20:30:35 -0600
Message-ID: <4F6A8ECB.5090609@gmail.com>
References: <loom.20120321T054053-857@post.gmane.org> <4F69E9C4.8060108@gmail.com> <CAB_n8zK5b0jWA=retCX12DGmrb19gMd2UxJGWkn6HD9nFrdiAQ@mail.gmail.com> <4F6A00BC.8070705@gmail.com> <loom.20120322T013621-317@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65177 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072Ab2CVCal (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Mar 2012 22:30:41 -0400
Received: by dajr28 with SMTP id r28so2425114daj.19
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Mar 2012 19:30:40 -0700 (PDT)
In-Reply-To: <loom.20120322T013621-317@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yipeng Huang <yipeng@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 3/21/12 6:43 PM, Yipeng Huang wrote:
> Since I am on a much newer kernel, could it be the case that reading stall
> cycles is not supported by my hardware rather than by the kernel?

Sandy Bridge and Westmere support should be in 3.0. Are you sure your 
processor supports it?

David
