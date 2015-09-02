From: David Ahern <dsahern@gmail.com>
Subject: Re: Understanding timestamps in perf.data
Date: Wed, 2 Sep 2015 07:43:21 -0600
Message-ID: <55E6FCF9.60403@gmail.com>
References: <55E6C120.3030504@kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32934 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbIBNnV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 09:43:21 -0400
Received: by igbkq10 with SMTP id kq10so25484151igb.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 06:43:20 -0700 (PDT)
In-Reply-To: <55E6C120.3030504@kit.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Dennis Gnad <dennis.gnad@kit.edu>, linux-perf-users@vger.kernel.org

On 9/2/15 3:28 AM, Dennis Gnad wrote:
> Hi,
>
> I am interested in timestamped performance counter data (with a
> specified sampling rate) as there is supposed to be saved in perf.data
> when I use "perf record -T".
>
> However, I don't understand the complete output of "perf report -D", and
> can't figure out which parts of it are the timestamps. Is there any
> documentation that I overlooked?
>
> Actually if it helps, I am only interested in the name/raw event, value,
> and timestamp, without any code/library information. Maybe the
> information on which CPU it is from (on a multicore) could be
> interesting as well.
>
> Do I need to start looking into the code? Any good place to start? I
> probably need to do this anyway, instead of parsing the really large
> perf report -D output.
>

Use 'perf script' instead of 'perf report -D' to dump the samples.
