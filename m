From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: What is the exact meaning of this parameter ?
Date: Sat, 06 Jun 2015 09:20:48 +0200
Message-ID: <55729F50.4030308@gmail.com>
References: <5565F6EB.3090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33879 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbbFFHUw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 6 Jun 2015 03:20:52 -0400
Received: by wibut5 with SMTP id ut5so40062635wib.1
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2015 00:20:51 -0700 (PDT)
Received: from [192.168.0.10] (mut38-6-88-167-68-98.fbx.proxad.net. [88.167.68.98])
        by mx.google.com with ESMTPSA id a19sm1205678wiv.2.2015.06.06.00.20.49
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 00:20:49 -0700 (PDT)
In-Reply-To: <5565F6EB.3090406@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Any idea on that ?

Thanks,

----
Manu

On 05/27/2015 06:55 PM, Manuel Selva wrote:
> Hi all,
>
> I know that the perf_event_mlock_kb kernel parameter allows to limit the
> amount of counters sampling memory that can be mmap'ed by an unprivileged
> user.
>
> Nevertheless, playing with the size I give to mmap some memory using the
> file descriptor returned by perf_event_open I am not able to linkk with the
> perf_event_mlock_kb parameter. Looking into kernel sources, it seems this
> parameter is used in kernel/events/core.c where the perf mmap operation is
> defined but I am not sure to understand the code there. So my question is
> what is the exact meaning of this parameter ?
>
>
