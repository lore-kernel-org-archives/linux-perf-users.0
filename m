From: Chris Freehill <cfreehill@gmail.com>
Subject: help with porting perf lkm to later kernel
Date: Thu, 29 Aug 2013 13:44:08 -0500
Message-ID: <CANFySvdskXzS3cP-EMm8o4zbkNqsMDwRAwA0rPvJ+59z7vuPEA@mail.gmail.com>
Reply-To: cfreehill@alumni.utexas.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:54250 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568Ab3H2SoK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Aug 2013 14:44:10 -0400
Received: by mail-wi0-f177.google.com with SMTP id hi5so906426wib.10
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2013 11:44:08 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

>> >>previously working functions should now be handled when built against later
>> >>kernels?
>
> # git show v3.0:kernel/events/core.c | grep EXPORT_SYMBOL
> EXPORT_SYMBOL_GPL(perf_event_release_kernel);
> EXPORT_SYMBOL_GPL(perf_event_read_value);
> EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
> EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
> EXPORT_SYMBOL_GPL(perf_swevent_get_recursion_context);
> EXPORT_SYMBOL_GPL(perf_tp_event);
> EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
>
> IOW. how can your module have ever used those functions in 3.0 ?
>
> Typically the answer to 'why did the export get removed' is simply
> 'because there are no users'.
>

Thanks Peter and David. You set me on the right path.

Your answer made me check...surely enough, the kernel I had been using
was (unexpectedly to me) patched to export those symbols. I realize in
hindsight I should have checked that first.

Thanks again,
Chris
