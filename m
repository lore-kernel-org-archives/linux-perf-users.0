Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F793AB498;
	Tue,  1 Sep 2026 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267833; cv=none; b=TTDSvuN8JovoPpgJOdcUpayXwuo5sZ3uxrxdV3F3YVGZP4nXko/7UlbviicjLmmoJS16VNfNG14VkybNSB5k/j3VSo/DXnA4VeBHwgGSJpHIuIfEcOqELYH563dQIGWdqIlqo/zxlc14IOJdZatcOdtAdg+1WcwmKp3tYjedf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267833; c=relaxed/simple;
	bh=g/edq9CIMIkaGlggq0Mm7t/K3jMN9NX6cX0tclObFF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S183Xr4b4Zq2VgsW4YpAMrwubRbRJcs/zXqgSo+WkGW98T2lnM6bldmacO8PS3u7sqhZSxKRJew2PU3CBdOevX+O3tMX1NUc3bQaonLrV4rXoGGu82wrrF1I5Apod1YNESRk3OKQ3uVLXQagLc/+N+wePPODYH/XIM3L2kX+eSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=wdKFhZXA; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="wdKFhZXA"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2172F1A040D;
	Tue,  1 Sep 2026 13:03:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 9534020031;
	Tue,  1 Sep 2026 13:03:44 +0000 (UTC)
Date: Tue, 1 Sep 2026 09:04:42 -0400
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
Subject: Re: [PATCH v2 2/2] tracing/probes: Fix BTF kflag check for
 anonymous struct member access
Message-ID: <20260901090442.7cd378dc@gandalf.local.home>
In-Reply-To: <178822363712.115597.2744784023996949800.stgit@devnote2>
References: <178822361441.115597.11442662641658772793.stgit@devnote2>
	<178822363712.115597.2744784023996949800.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9534020031
X-Stat-Signature: eh657m8417ruhmjmn5b7kkw8ap4ap1g6
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+9tzIXs89QpA5STABLSZP1Qo+6aASfjP8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=QIBTnnsFougobwurkua5vQe58Feb4wnUHeW7htWdPAw=; b=wdKFhZXA+A7re0aBG/dkYZJBqCOyIboHMeGXJF5iReaARtJ40PhhxY/n86cNkwvRZmTgZoviZVroTnlZoerJrj2SONZOnERta+wCaIIXau7rz6Zi5zciRhgBIuZ562ubRAObeJBvcE3rgCUZ8/YK6YVI0lruYQLF4WSBRNFjZLI=
X-HE-Tag: 1788267824-78532
X-HE-Meta: U2FsdGVkX1+ofhSqsc8PNV3UfjxDpb9QKD/h4HYhVFcM+PJ2A54iXqwQgmphJVFeZM9tB5OxHT64knzAjOeUU3g+FCcWepNW9QTxqqra6n62Tx11KDPjZHOUzosNvnjl0/Xbg2IL/ElJW1AJu5caZalo0up3iYu8gmuXSktJOvFGOTiMemoQESqUpVwDQINOfraFTpIQb9TBaL1JfU/b+ipDgGc06G05XCEsX/Pj7GsHt7LL7L5d9lgdqoievpZtMIw9Vi6o1JE7hnuepBrg1w4VZsNbW5yfHibjL2RGl53bql1y095NXRie8VSnnUQXiASl2SJQ/qw6q5pW7alrVk7K15Z+AJiI9FRgtliLtCd0abTBJzuZK2my7lFMy3px

On Tue,  1 Sep 2026 09:47:17 +0900
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
> ---


> @@ -661,11 +662,11 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
>  			ctx->last_bitsize = 0;
>  		}
>  
> -			type = btf_type_skip_modifiers(btf, field->type, NULL);
> -			if (!type) {
> -				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> -				return -EINVAL;
> -			}
> +		type = btf_type_skip_modifiers(btf, field->type, NULL);
> +		if (!type) {
> +			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> +			return -EINVAL;
> +		}

Is this just to fix the indentation? If so, can you make this a separate
patch? We don't need it to be part of a patch that gets backported. It may
make it more difficult to do so.

-- Steve


>  
>  		if (next)
>  			ctx->offset += next - fieldname;

