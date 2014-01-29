From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf not working for some commands?
Date: Wed, 29 Jan 2014 15:55:23 +0900
Message-ID: <874n4n5lb8.fsf@sejong.aot.lge.com>
References: <CACTzACVZLm00yVZag5Hf-c_u0tdH+cQT0=8B_XS8BrN5cT2mDA@mail.gmail.com>
	<20140128092203.GC1229@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:50884 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbaA2GzZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jan 2014 01:55:25 -0500
In-Reply-To: <20140128092203.GC1229@krava.brq.redhat.com> (Jiri Olsa's message
	of "Tue, 28 Jan 2014 10:22:03 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: David Li <android.wm.edu@gmail.com>, linux-perf-users@vger.kernel.org

Hi Jiri,

On Tue, 28 Jan 2014 10:22:03 +0100, Jiri Olsa wrote:
> [jolsa@krava perf]$ strace -fo out ./perf stat krava
> Workload failed: No such file or directory
> [jolsa@krava perf]$ cat out | grep exec

You can also use "strace -f -e execve ./perf stat krava" :)

Thanks,
Namhyung
