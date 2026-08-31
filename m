Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495813A5E89;
	Mon, 31 Aug 2026 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195645; cv=none; b=sRH+6sOU8k+UwciGogqcpk0QicfAPH7M7rO8fJiJwBa3lGl5aHDyeWhtzwUOuxisb2r73HUATzRjWNxPCzZend++c5x04Stbs38Ju7g4B7QljSLHJxfIVdqLd8bxB1y3QVXu+oPb1GhmXkrw3lUETua3iRHRb1/d+Hy6gU1+V3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195645; c=relaxed/simple;
	bh=iXahD0twFxrsPC4xNEUZNmOuShlmcRsERnw5koF1RP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru4sf5fyUC7N/+MQ4rEQvx1dEWbG+HhWibXZWrPeiwE9iHBCQLIV8793sgkCCe6GQ9ZTumX3WKV/HjeIoPWP73UO6jcVOkJvnM1wKgFFZgWnhXvmL0aool+GmPxQVrbtK/IZW2q7AoDk6IiKvtroZJtkbxVLNf0OTXwHxp6WTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=6BqugJpz; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="6BqugJpz"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id AE6D8A373C;
	Mon, 31 Aug 2026 17:00:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 73DA02F;
	Mon, 31 Aug 2026 17:00:37 +0000 (UTC)
Date: Mon, 31 Aug 2026 13:01:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/probes: Fix anon_stack check for unnamed
 bitfields in btf_find_struct_member
Message-ID: <20260831130133.3018b81a@gandalf.local.home>
In-Reply-To: <178818876548.104360.13229872396750615226.stgit@devnote2>
References: <178818875393.104360.1469039168635349344.stgit@devnote2>
	<178818876548.104360.13229872396750615226.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 73DA02F
X-Stat-Signature: xmmuzzdbpm9jdq9bf6k9cxysirwfh6i9
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/cl9iYNiIKShFUdufTESmQMX5u9D0nFJM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=v9/PHUSS7Q4WIpCc40DdWGuXHA3SZrhDhmXgNoC2nEg=; b=6BqugJpzevbcWvx6n7uPaIUsuS9lyJRhAXKPm2n5NMJEOCY7A8pERmex1saDxM1OmEzu5Pb8W2pJ6TOluCrlrBO9gzKKYfabnYnOmlWj/fy69n80rlfNQp1qN8/rsvarhNiSqNOnYOLlHda+UlRDLSLJFTovf86NWEo1S4q7yoY=
X-HE-Tag: 1788195637-278297
X-HE-Meta: U2FsdGVkX1+0Rw05Z5fvWGSHQamMCwzBItP6rJNXN9UpS2zJBaxN2fvnOXtj9xsOKb3O1/tb4XcDs1GhRXRIxEGdrmhWQ98Z42HmAzBGhvpp4Nx7JFy1uhh7FlA1IdevYKm74yqM0KrDOXUnNTtMHzcZLtCxb55EkReE9rjYzftMFHP85evSWl03kh8d/vijPYXfJwyYLNP4MK/e0wcx8y5NvOp3FLqLwCm5PgBXXZUkkXn9+JvLbghLMIowTKzVbGBtfLvu4RRACCa3eszAbrOOaJEWzpBgXNNVsHwOzWazRhOzqiT3r/CUhX5vKHCiqjWdqIjIjs69cVCFFoEkRdxXtdOjR4i1uXKDDiWyUbA9HuBE9ppfCumjcWp387K2bIx4VVV38spvdZRLAd1GDg==

On Tue,  1 Sep 2026 00:06:05 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> btf_find_struct_member() traverses into nested anonymous structures
> and unions by pushing members with !member->name_off onto anon_stack.
> However, it does not consider the unnamed bitfields (e.g. `int : 5`
> or `unsigned int : 0`) which also have member->name_off == 0.
> 
> If such an unnamed bitfield is pushed to anon_stack, the
> btf_find_struct_member() return an error even if there are other
> valid entries in anon_stack.
> 
> To fix this, only push unnamed struct/union members to anon_stack.
> Also move the btf_type_is_struct() check to the entry of this function
> because now it is sure only struct/union are pushed to anon_stack.
> 

Should we add Reported-by and a link to the Sashiko report?

> Fixes: 302db0f5b3d8 ("tracing/probes: Add a function to search a member of a struct/union")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
