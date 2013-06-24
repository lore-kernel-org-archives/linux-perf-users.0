From: Cody P Schafer <devel-lists@codyps.com>
Subject: Re: What does the "scaled from 66.58%" means?? What is scaled??
Date: Mon, 24 Jun 2013 16:36:06 -0700
Message-ID: <51C8D7E6.2040401@codyps.com>
References: <CAEuYUeq_fT+rz_hoMTqSX14EL0Z1CdAaEc8C5zyxXfgG=H7=bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56322 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3FXXgo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jun 2013 19:36:44 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so26579829iec.27
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2013 16:36:44 -0700 (PDT)
In-Reply-To: <CAEuYUeq_fT+rz_hoMTqSX14EL0Z1CdAaEc8C5zyxXfgG=H7=bg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On 06/24/2013 03:37 PM, Peipei Wang wrote:
> perf stat -B dd if=/dev/zero of=/dev/null count=1000000
>
> 1000000+0 records in
> 1000000+0 records out
> 512000000 bytes (512 MB) copied, 0.956217 s, 535 MB/s
>
>   Performance counter stats for 'dd if=/dev/zero of=/dev/null count=1000000':
>
>              5,099 cache-misses             #      0.005 M/sec (scaled
> from 66.58%)
>            235,384 cache-references         #      0.246 M/sec (scaled
> from 66.56%)
>          9,281,660 branch-misses            #      3.858 %     (scaled
> from 33.50%)
>        240,609,766 branches                 #    251.559 M/sec (scaled
> from 33.66%)
>      1,403,561,257 instructions             #      0.679 IPC   (scaled
> from 50.23%)
>      2,066,201,729 cycles                   #   2160.227 M/sec (scaled
> from 66.67%)
 > ...
> Can anyone explain to me the meaning of "scaled from", and from which
> get the 66.58% or 33.50%??

The scaling indicates that we had to time slice performance events 
because we couldn't enable them all at once.

The 33% indicates that that event was only active 33% of the time, so 
we've scaled it (multiplied by 3, in this case) with the assumption that 
it would show up with the same frequency during the times it was 
disabled. (Same for 66%).
