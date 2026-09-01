Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1B3C5546;
	Tue,  1 Sep 2026 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273395; cv=none; b=JZ+LuqzkvYUNwXQL8+YSX2kqkWfhUOCBKH6EqL7zBcxrhVAV9yuuvmmcLP2FrgKiI8ryhARZ91lrF+kjduoN0/AlvnThdn7p/rxKFoYO5HsCGKPnIN3onyO2Cl9j55V1MkWEoXUaYodp8R3sPm6anHjTmZQnaU4QDpPytKss3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273395; c=relaxed/simple;
	bh=3YLanuTVpasdBZJapHZStMzSmW4L3lHdk4tSlXuXC00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T12dk4zwSwpCG1gvzJPU5XqWvrFN8jlQRvAB8RDVh0NoEbPw8Qhw8cbb/3dgTAkr+W4cnwd+37QkgGhC74XBZGSG5bNRH67KQzeC2IX9vIVN2QSvmMXqzGx4TyK4+/07XCZfUJo/2cp6jPvnlFPtGDAFSICQnz4+z/tBYEKO/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=jj6kQnu2; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="jj6kQnu2"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 6F319A422E;
	Tue,  1 Sep 2026 14:36:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 2773520026;
	Tue,  1 Sep 2026 14:36:27 +0000 (UTC)
Date: Tue, 1 Sep 2026 10:37:25 -0400
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
Subject: Re: [PATCH v3 2/3] tracing/probes: Fix BTF kflag check for
 anonymous struct member access
Message-ID: <20260901103725.7ca9629f@gandalf.local.home>
In-Reply-To: <178827250904.123716.17452648791331881284.stgit@devnote2>
References: <178827248631.123716.2627172171811720261.stgit@devnote2>
	<178827250904.123716.17452648791331881284.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5h7qh9r56n8eesbf3unousyhyumu7fk1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2773520026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+xyj3NDZi5Ps/mYgvqFL5h8LUgXI/BQXs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=4JOrdTUbbbWijROTSSn5DPN83zN0OvI1ubKRqA68cUw=; b=jj6kQnu2FWanu+ov9aor7AMBKulAKsSqhmOAXCq151bntGYhxUR7Hzjpe8RBXmVQsY8uB0uYqzBQQ8rucMD1qFZrXqzGGUVZ0UHsDa8UXor7ULRTqPjXIwJ1ODUvjfPhpOAjweRMRPaeBhPOVhWZ4q6mut6WdFt364gFY/fxx04=
X-HE-Tag: 1788273387-243918
X-HE-Meta: U2FsdGVkX18SxC4yxLQ0LdRuJcw/9q4dtnSQZ0yIBLBfXaQJHia09tmSRbz5rrfeAxNFe34G9ysMDpRMtlOLtWt4Auxw9Mtz1nQIDKS7p+2x0acLhES0Rfql4OLZGoGRhQgyyVq6p97/TuVyWK5qH2FaN9MDdKN2xIpNLDMPDA0BoWHLq3hOKtv16m8I2UhLWYTITJWRpWfHdZUFlfuvJxRDmICv3RDncpi98E30gXvbKw9j9IZe50NUJGmL/iw9kfBT/tmUcotZmOihzmqGCruxRmdtMHBKN/xbsqUp8Scu7dfOuNH2rxU3kzr4yYtUcXKrzoyouwyqis+gMXywAIMr0lkg+lNa7XngUUktCzc3fvRUVsZu9NNMFW9lC9oTp3w1RxQeu3ZSHfwrV1viyA==

On Tue,  1 Sep 2026 23:21:49 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> btf_find_struct_member() traverses into nested anonymous structures and
> unions to find a struct member. However, get_bitoffset_of_field() in
> trace_probe.c checked btf_type_kflag(type) using the outer parent type
> instead of the actual anonymous structure/union that directly contains
> the found member.
> 
> If the parent structure and anonymous structure have mismatched kflags
> (e.g., the parent has kflag=0 while the anonymous structure has kflag=1
> because it contains bitfields), the bitfield size encoded in the upper
> 8 bits of member->offset is erroneously treated as part of the byte/bit
> offset, corrupting the resolved offset and failing to set last_bitsize.
> Similarly, btf_find_struct_member() pushed anonymous member offsets
> onto anon_stack without masking BTF_MEMBER_BIT_OFFSET() when kflag is set.
> 
> To fix this problem, update btf_find_struct_member() to return actual
> containing structure/union type via member_type, use appropriate
> __btf_member_bit_offset() to get bit offset, and use member_type for
> btf_type_kflag() in get_bitoffset_of_field().
> 
> Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kernel.org/
> Assisted-by: Antigravity:gemini-3.7-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
