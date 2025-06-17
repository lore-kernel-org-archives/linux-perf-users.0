Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E832E8E06;
	Tue, 17 Jun 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176651; cv=none; b=E9Lr5kEmO7qJNEd8JjDCcqCtakXYnsMyYFZPupvZ5fOENsg8XA0R/aJ19gXPBE9cdUldWuvQS7AdsObXSkgYPTBciOPKfUHGBKcKvy9DZNLB3G3xi9DdX8lMHGfNXrDX1dEfHnJRUsRppvLbFiL0HayJKgmSdbDB0tUgvAEmuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176651; c=relaxed/simple;
	bh=OVcsYY+4B7hzYliqbIpxiH5TIXbGLLveimkUzckFWuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CANhdC0MxIYctIr7M+6lM6OFmUwgZMlAXRJRiZlPuo2gjUELKqKkky7mrMXRUXjxmHuHUeYzhBYjy6HrBwGq65mkHz/DZDtMj7Ww2ICpUpaY6WYc0/cfSC5BUSoBfdX/d2rW7iGBXSv55huDStIRyP0RFL42HJHPNY6lFF+s22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3E0FA80625;
	Tue, 17 Jun 2025 16:10:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 2E65D80014;
	Tue, 17 Jun 2025 16:10:38 +0000 (UTC)
Date: Tue, 17 Jun 2025 12:10:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: duchangbin <changbin.du@huawei.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org"
 <namhyung@kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
 <linux-perf-users@vger.kernel.org>
Subject: Re: [Bug] Kernel BUG in function_graph tracer in linux kernel
 6.16.0-rc2+
Message-ID: <20250617121043.2b0488e5@gandalf.local.home>
In-Reply-To: <4ab1a7bdd0174ab09c7b0d68cdbff9a4@huawei.com>
References: <4ab1a7bdd0174ab09c7b0d68cdbff9a4@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cef3u6hnkehjceqmuftnx9ng69gkkzuc
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2E65D80014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+yHDBaY042U3DkE9xXdFAjcHVA0+ycoGI=
X-HE-Tag: 1750176638-940335
X-HE-Meta: U2FsdGVkX1/zTbpzPESjatpo6FvJBCa6GryLuCe06phW7qWrivh1vhdCCMRL1j9aIvryq0cfdX3HRbOeF1862b/GjLfxrYbrCSzUzvIwu/HCXdsYj9zD7K9T2rBNNNW9xZpAIsTzDCJUaMEKeBJx43yCT9C7vOFltIQpwIuwqCFj9fEqFA9CZyzBn7VrWaTZS3B5DQWrJX91YfsOaVr454BqNklKulrpVZNgE6KGAs3OfoDBOiON7s3G4Kp3XO4pt/w9NXBwcQXeRjS0KB98HI5TRl7uVgyiz6eW43ZpHe5CnLwVCCGcl9TCwSioULje4EOkXHIgYgxYypdZSbocNyUVmJmeXZd5O9KPljIdrGEAIAUR7M7Avw==

On Tue, 17 Jun 2025 10:58:09 +0000
duchangbin <changbin.du@huawei.com> wrote:

> Hello,
> This is a bug report for kernel function_graph tracer when enabling the
> 'funcgraph-args' option. It seems that the registration logic is not quite
> correct, but I haven't conducted an in-depth analysis of the issue yet.
> This problem has already existed since version 6.15 at least.
> 
> The following are the steps to reproduce the issue.
> 1. Enable CONFIG_FUNCTION_GRAPH_TRACER CONFIG_PROBE_EVENTS_BTF_ARGS
> 2. Trace a function using function_graph tracer and enable the 'funcgraph-args' option.
> # echo 1 > /sys/kernel/debug/tracing/options/funcgraph-args

FYI, please start using /sys/kernel/tracing directly. I want to deprecate
/sys/kernel/debug/tracing.

> # perf ftrace -G vfs_read

Thanks for the report, I posted the fix:

  https://lore.kernel.org/linux-trace-kernel/20250617120830.24fbdd62@gandalf.local.home/T/#u

-- Steve
