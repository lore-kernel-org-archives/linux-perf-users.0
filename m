From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: using perf lock
Date: Thu, 24 May 2012 09:28:09 +0900
Message-ID: <87fwaq1kyu.fsf@sejong.aot.lge.com>
References: <loom.20120523T174059-193@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:64143 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2EXAaI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 May 2012 20:30:08 -0400
In-Reply-To: <loom.20120523T174059-193@post.gmane.org> (Hank's message of
	"Wed, 23 May 2012 15:42:42 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hank <hankendi@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi,

On Wed, 23 May 2012 15:42:42 +0000 (UTC), Hank wrote:
> I've been trying to use perf lock command on my Ubuntu 12.04, but I'm getting
> this error:
>
> invalid or unsupported event: 'lock:lock_acquire'
>
> What might be the problem? Should I get the kernel source code? 
>

Maybe due to the kernel was built without CONFIG_LOCKDEP and/or
CONFIG_LOCK_STAT. You can grep it from /boot/config-$(uname -r).
If so, you need to rebuild the kernel.

Thanks,
Namhyung
