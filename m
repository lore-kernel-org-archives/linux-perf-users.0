Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF816DEDF
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950419; cv=none; b=KIwc2J4Jsp4h9gdpkpofxcKzJkn87WX6/+cseSkXLi5mVevHScVxbkSEjlYKjOhk5AwdzG9P8rHJ1CEcY+hl8ZNQc/HtrzIMlJxQmFvNd/btrsRnuJHLcSsamHOSaRqGyUMoBl+prMXNWu1u/I5gUKhniiWROWdM7N9XVg4ZREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950419; c=relaxed/simple;
	bh=9edudUAko8TPwOAXX9QK2AF9uqRWayR2WNyxyfSgzFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG5QU19KVtHV3Fi/S9+INH+/7FRIDUiKSq+67j59TQ5OTVu4y+dV2PHwO04HyNlKXseoAVsrqNosyTAYuTrasqb946e5vqc1Mdhf+gbqOdgj41XIFb2T1t5WpOhSutYqpH/g9sdbWqvC3PqkM+K2KyScmU0EAguAVHr7zVMz2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TslArgC7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TslArgC7"
Date: Mon, 14 Oct 2024 17:00:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728950412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vh3jiunjWIwsOuFiNu4hKpvARjvNFqPFZ+Dwxoe0LFg=;
	b=TslArgC7lZohDr+TNPyhLdypH0ePq5iw1b4E7wfSig4Vl37bf5nG7rABIy9+6srd8pj65f
	0kklSPI/wFWx+MRVNVlcqBnajG57g0ninSKqeUSb6OXpZtoqdCDaIQ2bVwOXO6MHKXNJpo
	fp9u3PUw4JZMTMGJOOFEb0nfNnk6JME=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <tvugxgpjgxlospwa2evdsvyjr6k4dkijffrmtgw7rc2gbwrvjz@2nkwwnsmlaum>
References: <20241014235631.1229438-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014235631.1229438-1-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 04:56:31PM GMT, Andrii Nakryiko wrote:
> From memfd_secret(2) manpage:
> 
>   The memory areas backing the file created with memfd_secret(2) are
>   visible only to the processes that have access to the file descriptor.
>   The memory region is removed from the kernel page tables and only the
>   page tables of the processes holding the file descriptor map the
>   corresponding physical memory. (Thus, the pages in the region can't be
>   accessed by the kernel itself, so that, for example, pointers to the
>   region can't be passed to system calls.)
> 
> We need to handle this special case gracefully in build ID fetching
> code. Return -EACCESS whenever secretmem file is passed to build_id_parse()
> family of APIs. Original report and repro can be found in [0].
> 
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> 
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
