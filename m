From: David Ahern <dsahern@gmail.com>
Subject: Re: Bug Report
Date: Mon, 11 May 2015 11:14:35 -0600
Message-ID: <5550E37B.8070209@gmail.com>
References: <CAPMERti9KnqyR7U3upPz0wh14CEO=W1T=0_cDQ61cBASdKH-yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35561 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbbEKROm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 May 2015 13:14:42 -0400
Received: by ieczm2 with SMTP id zm2so113481856iec.2
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2015 10:14:41 -0700 (PDT)
In-Reply-To: <CAPMERti9KnqyR7U3upPz0wh14CEO=W1T=0_cDQ61cBASdKH-yQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alex Newman <posix4e@gmail.com>, linux-perf-users@vger.kernel.org

On 5/11/15 10:57 AM, Alex Newman wrote:
> Hello mailing list friends,
>
> I am sorry if this is not the best place for this (where should I
> report improvements for perf).
>
> This command works when I have the correct permissions but if I don't
> rather than getting "bad permissions" I get
>
> posix4e@posix4e-P27GV2:~$ perf stat -e 'ext4:' -a

that's an invalid event list; it should never work. Did you mean -e 
'ext4:*'?

David
