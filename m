From: David Ahern <dsahern@gmail.com>
Subject: Re: Some event modifiers missing from output and desire option to
 compute value based on measurements
Date: Fri, 21 Mar 2014 08:16:40 -0600
Message-ID: <532C49C8.9020500@gmail.com>
References: <5321E3AC.8050600@redhat.com> <87siqmf1kc.fsf@tassilo.jf.intel.com> <5321FB46.5020003@redhat.com> <532C3562.1010706@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:60985 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbaCUOQ7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 21 Mar 2014 10:16:59 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so2459087pbb.40
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2014 07:16:58 -0700 (PDT)
In-Reply-To: <532C3562.1010706@codeaurora.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christopher Covington <cov@codeaurora.org>, William Cohen <wcohen@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On 3/21/14, 6:49 AM, Christopher Covington wrote:
> I don't know how useful a reference this is, but here's an out-of-tree
> "periodic" command with math flag support.
>
> https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/tools/perf/builtin-periodic.c?h=LNX.LA.3.6_rb1.1&id=4235d779be748291ed2ec5581dd64e7d1a529297

Minus the math part it seems like that command mirrors functionality in 
perf-stat, -I option.

David
