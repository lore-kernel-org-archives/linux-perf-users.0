Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D73254B0;
	Thu, 21 May 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374920; cv=none; b=ca+8XvyudesFv+BSb+TFUJpsAucU74DdTdIUxUAmcaWal1kFhZD/Vm3iM87Nw67qns5POxDlzB29P14gU8tX1ndE2rQ1zcgbUmZtAdwaBQdSqNLxW0kZ9WULsf/TLQhSpRx1aGEkx+5KZAQDVVawovQn3mYJ+yuB0kTM6g/+cyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374920; c=relaxed/simple;
	bh=7EBH2axdEYbA9/O7XeM4Z8N/2ZXxzKeaMR5uKoZ8UUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSYdWZ/ZlRIMTXul02C64ThA20R0e//5hjPZCDCvdeYgmJJykKnP5G8e90UzbclfbBaurbDYkn/Fypv+YD61x72p7V+Q9AxmDKs4UfojC8cxriUEZGXOYSB3ULtD+tDBLTsGPiWiFeQkbsksKp4UGJ34OS3wB/bN1PJZBgl20B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 51380161277;
	Thu, 21 May 2026 14:48:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 4EC5B2002B;
	Thu, 21 May 2026 14:48:35 +0000 (UTC)
Date: Thu, 21 May 2026 10:48:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ben Hutchings <benh@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Tomas Glozar <tglozar@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rtla: Fix output files in source tree
Message-ID: <20260521104856.3873230f@gandalf.local.home>
In-Reply-To: <ag8YLYKZTKOq0t4x@decadent.org.uk>
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
	<ag8YLYKZTKOq0t4x@decadent.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4EC5B2002B
X-Stat-Signature: dxio97bdia8r56ocxozihhxkwe59gfhr
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ekm7gLLKGWvTNvscC2nVRKnlWFhGQO1g=
X-HE-Tag: 1779374915-892623
X-HE-Meta: U2FsdGVkX1/XBJfa/2C385QLzQarStkU43WAletcG54GtUZoca9hcCv6S8SqFpg120QzCrhBzntxfBPrfsz7UXLjI786esqPyeh/FKiphNC8j5zHaRvwblt2rl59/yy0Xb25Pvnd2HK6QOfaxG2JRHq3yXGurm8V4qayDvtrQqJlUbtddUnrSRRos/J4OUdQ913m6lUlobt8WMGz7OCEAZZ/Jcac1M3C7MGyQths2KbwPFroz82KEPWQxzDYnNyxu+EBtOBcSqQohekxubkfYeIMbZG5w6OSLTrGc5O680UtTeag6WWds3hRsIGnLH0w/VUxqzetyjYuWpbq9B0y83Ju2d1Z/omI

On Thu, 21 May 2026 16:35:25 +0200
Ben Hutchings <benh@debian.org> wrote:

> Some output files (src/timerlat.bpf.o, src/timerlat.skel.h,
> example/timerlat_bpf_action.o, tests/bpf/bpf_action_map.o) are
> currently generated in the source tree, preventing a fully out-of-tree
> build.  To fix this:
> 
> - Add $(OUTPUT) to their filenames in the relevant Makefile rules, and
>   create subdirectories as needed
> - Add $(OUTPUT)src to the include path
> - Add ${OUTPUT} to the BPF object filename in tests/timerlat.t
> 
> Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
> Fixes: 0304a3b7ec9a ("rtla/timerlat: Add example for BPF action program")
> Fixes: 5525aebd4e0c ("rtla/tests: Test BPF action program")
> Signed-off-by: Ben Hutchings <benh@debian.org>

Hi Ben,

Can you send this as a separate patch. The rtla code is handled via a
different tree than the perf code. So these patches will not be going
together.

Thanks,

-- Steve
