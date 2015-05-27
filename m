From: Manuel Selva <selva.manuel@gmail.com>
Subject: What is the exact meaning of this parameter ?
Date: Wed, 27 May 2015 18:55:07 +0200
Message-ID: <5565F6EB.3090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34560 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbbE0QzL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 May 2015 12:55:11 -0400
Received: by wgv5 with SMTP id 5so15062509wgv.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2015 09:55:10 -0700 (PDT)
Received: from [134.214.61.243] (anyconnect243.insa-lyon.fr. [134.214.61.243])
        by mx.google.com with ESMTPSA id js3sm27757786wjc.5.2015.05.27.09.55.08
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 09:55:09 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi all,

I know that the perf_event_mlock_kb kernel parameter allows to limit the
amount of counters sampling memory that can be mmap'ed by an unprivileged
user.

Nevertheless, playing with the size I give to mmap some memory using the
file descriptor returned by perf_event_open I am not able to linkk with the
perf_event_mlock_kb parameter. Looking into kernel sources, it seems this
parameter is used in kernel/events/core.c where the perf mmap operation is
defined but I am not sure to understand the code there. So my question is
what is the exact meaning of this parameter ?


-- 
Manu
