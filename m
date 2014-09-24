From: taeung <treeze.taeung@gmail.com>
Subject: Re: [PATCH] modify error code when perf_session__new() fail.
Date: Wed, 24 Sep 2014 10:39:32 +0900
Message-ID: <542220D4.5070404@gmail.com>
References: <1411452737-28188-1-git-send-email-treeze.taeung@gmail.com> <20140923120231.GD2979@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57740 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbaIXBjt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Sep 2014 21:39:49 -0400
Received: by mail-pa0-f43.google.com with SMTP id kx10so7735986pab.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2014 18:39:49 -0700 (PDT)
In-Reply-To: <20140923120231.GD2979@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org

hi,
Sorry for my wrong format.
According to what you tell me , I forwarded the patch, again.
Thank you for your advice.

Thanks,
Taeung

On 09/23/2014 09:02 PM, Jiri Olsa wrote:
> hi,
> subject should start with 'perf tools:'
>
> On Tue, Sep 23, 2014 at 03:12:17PM +0900, taeung wrote:
>> 	Because perf_session__new() could fail
>> 	for more reasons than just ENOMEM,
>> 	I modified error code(ENOMEM or EINVAL)
>> 	into -1.
> why the indent?
>
>> Signed-off-by: taeung <treeze.taeung@gmail.com>
> the log message needs some love, but the patch looks ok
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
