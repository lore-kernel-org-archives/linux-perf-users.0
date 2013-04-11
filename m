From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: No tracepoint event in the perf list output
Date: Thu, 11 Apr 2013 21:20:22 +0900
Message-ID: <87zjx5s1h5.fsf@sejong.aot.lge.com>
References: <loom.20130408T113553-844@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:49008 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934711Ab3DKMUX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 11 Apr 2013 08:20:23 -0400
In-Reply-To: <loom.20130408T113553-844@post.gmane.org> (Donitta's message of
	"Mon, 8 Apr 2013 09:51:32 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Donitta <sabra_gr@yahoo.fr>
Cc: linux-perf-users@vger.kernel.org

Hi Donitta,

On Mon, 8 Apr 2013 09:51:32 +0000 (UTC), Donitta wrote:
> Hi,
>
>  According to the perf documentation, when running "perf list" command we 
> should have all pre-defined events that could be hardware, software, hardware 
> cache, raw hardware event descriptor, hardware breakpoint or tracepoint event.
> In my case, when I executed the perf list command I had all type of events 
> listed except the tracepoint event. 
> What does this mean?

Do you have CONFIG_EVENT_TRACING enabled on your kernel?

Thanks,
Namhyung
