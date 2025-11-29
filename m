Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302025524C;
	Sat, 29 Nov 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764445336; cv=none; b=MFXhsOuyFgKQwlYirA/VYhP+XEMi1xIbcidBokBpM4xWKZaDeA8blBB4TL/BL+0/71+kvpvGhvUqhok/H0qk07xMUlLtf/TH2HH49ib7n+LB4SKz4qCazbcl4UsDwfVBWy/Sn8FcHeJpH29jMTkNy/haj0eiJ34ksBMt5McisSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764445336; c=relaxed/simple;
	bh=l+R6HDt9TCClln/aw1T/L9wsbP0byCyAvxobv6iCi/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flCYmZIieqlGksB+EnzdPqSgxYW8vSbwv2pshce4Y2n/3GxUYKX7RlT6xnRL3HQy23BPNnzukE1yeraEB46KN98r2WeOVtu8TL7DpBOApVqSG4OfQQvW7AoAOH6wh6zMFHmrCXkLjtc4+KMD87+Vnsi7a0sVeu+Cj7TaJiX6PRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 8214B160AF6;
	Sat, 29 Nov 2025 19:42:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id DFE7235;
	Sat, 29 Nov 2025 19:42:03 +0000 (UTC)
Date: Sat, 29 Nov 2025 14:42:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, James Clark <james.clark@linaro.org>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Thomas
 Richter <tmricht@linux.ibm.com>, Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH] perf trace: Skip internal syscall arguments
Message-ID: <20251129144202.0567743b@robin>
In-Reply-To: <aStEaM9tcGlRclQ4@google.com>
References: <20251127044418.677379-1-namhyung@kernel.org>
	<20251127203052.12a6a163@robin>
	<aStEaM9tcGlRclQ4@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: DFE7235
X-Stat-Signature: b9ybkjh9twaffymrc3at8jhde8idft7g
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Q4F40BPAyZtekG8Fp2p+u1GCBS1HsY78=
X-HE-Tag: 1764445323-630923
X-HE-Meta: U2FsdGVkX1+PiMMoMVbfidEgR3vTYs9p1CNceNahYBOaPT0pkBTtUBhJdLq0SeObmoa+cVGTvURawizYqqW/MW/aNt7Tj6SpCEReI+4/278qZ+h7TMwuPvhMGcZkGSo/LF17kcnJCpJmxb/cT6r0BbSOZ96nNaBjGE68Uz+AYKP7Z1uAUbAm9+dzj/mA9byrtfOw7RplYO5C5x7qFzK/okl2IED2ZSdttsO85ndmCKbOEGOUXv8Q7oZyGCoIrNWrkYRl8rkxGHMuJskJgIYgtm1PdkzT7vDzS44tC6IjLYpN74fbafv59h7ukENMSBwI6T1i4VgnjHgqErRpRy38snXG95LWyIjaevUAsgggHX8Htywe0xIfczC1L30XSk2bd1cpz8dw1YSwW4oOWMlmVw==

On Sat, 29 Nov 2025 11:07:20 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> > Even with this patch applied, I still have a segfault with this command:
> > 
> > # ./perf trace -e syscalls:sys_enter_write   
> 
> What about this?
> 
>   # ./perf trace -e write

Yes that works. As long as it isn't considered a regression that the
sys_enter_write crashes, then I'm fine with;

 Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
