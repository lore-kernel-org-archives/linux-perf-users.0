From: David Ahern <dsahern@gmail.com>
Subject: Re: Issue perf attaching to processes creating many short-live
 threads
Date: Fri, 23 Oct 2015 12:56:53 -0600
Message-ID: <562A82F5.8090306@gmail.com>
References: <562A81ED.70900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33194 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbJWS44 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Oct 2015 14:56:56 -0400
Received: by pabrc13 with SMTP id rc13so125063049pab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2015 11:56:55 -0700 (PDT)
In-Reply-To: <562A81ED.70900@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: =?UTF-8?B?5aSn5bmz5oCc?= <rei.odaira@gmail.com>

On 10/23/15 12:52 PM, William Cohen wrote:
> Earlier this month Rei Odeira found that the oprofile tool operf would
> have problems attaching and monitoring a process that created many
> very short-lived threads.  It looks like the kernel's perf tool also
> has issues when attempting to attach and monitor a process that is
> creating many short-lived threads.

known a problem. If this is the problem I think it is you will find that 
strace shows perf stuck walking /proc directory.

David
