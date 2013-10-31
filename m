From: David Ahern <dsahern@gmail.com>
Subject: Re: Information regarding the perf tool
Date: Thu, 31 Oct 2013 10:39:03 -0600
Message-ID: <527287A7.3050908@gmail.com>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com> <52727B0C.5040402@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:44969 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3JaQjH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 31 Oct 2013 12:39:07 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so2596814pdj.20
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2013 09:39:06 -0700 (PDT)
In-Reply-To: <52727B0C.5040402@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>, Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 10/31/13, 9:45 AM, Harald Servat wrote:
> Can anyone point me where and how is the timestamp calculated for every
> sample reported by perf?


See perf_clock() in kernel/events/core.c

David
