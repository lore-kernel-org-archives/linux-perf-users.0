From: David Ahern <dsahern@gmail.com>
Subject: Re: what is the default frequency and default event period set in
 "perf record -TP"
Date: Wed, 06 Nov 2013 17:38:32 -0700
Message-ID: <527AE108.6020905@gmail.com>
References: <CAEuYUeqNq9jox_-j-P-XhSCxvK5o=F+UYutP-=3KPESuUDXgGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:46059 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3KGAif (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Nov 2013 19:38:35 -0500
Received: by mail-pb0-f54.google.com with SMTP id ro12so277314pbb.27
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2013 16:38:35 -0800 (PST)
In-Reply-To: <CAEuYUeqNq9jox_-j-P-XhSCxvK5o=F+UYutP-=3KPESuUDXgGA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>, perf group <linux-perf-users@vger.kernel.org>

On 11/6/13, 4:52 PM, Peipei Wang wrote:
> Hi all/David,
>
> I want to know the frequency in the following command:
>          perf record -e cycles -e cache-misses -e cache-references -TP
> -o abc.data command
>
> I looked up in the perfwiki, and it says the default value is 1000.
> However, when I specify this parameter in the above command,that is,
> "perf record -e cycles -e cache-misses -e cache-references -TP -F 1000
> -o abc.data command", I found a significant difference between the
> file data size.
>
> Using the first command, the size of "abc.data" is about 500MB, but
> the second command could generate the raw data size up to over 10GB.
>
>
> I could not figure out the reason. Is it might because sampling mode
> of cycles is based on frequency while the other two events are based
> on event period?


default frequency was bumped to 4000 about a year ago. Not sure how the 
-F is impacting the cache-xxxx events.

David
