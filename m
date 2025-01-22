Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674FD212D6F;
	Wed, 22 Jan 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554238; cv=none; b=MPsEl8aFH1BULhOBRxsK7j/sFMJy+8L56qbPDcqwsvYmAZv3IGwdDzDWUmUwNFLG2ueV9i2+NLjLwkCWwL+ixEPgo9TPJqbzQ9gnyCZzNqS2Temi4KgwwNm5thnNqge3rlU3hCbHok7StbRh92o24IL9tfG8THBjKBoxd9S5/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554238; c=relaxed/simple;
	bh=BNs2Ohd4bUq54q3uMUrXCaxtEBi/Ix7hp9xIKcu0DlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D61G3QTSgpEbbRDbJp2a5uBzA3zGltudCmR+PTk3i7rANFqibupDpEGakHwi+7wUcyBl8A44e1W1j6arnQ4wePHfKEJAd/TE/0XSNDmi4vxAsfVkeA5XRQ51lGmHdzdsOv7D4ToeklDfwO8SQjNsQV6SDbmlZHeC8MG96x12Vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iCazwS5A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iCazwS5A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eg0flEOBkV0VBqIaZ/PZFHwFNlwtJnh8WHuO1tmjylQ=; b=iCazwS5ALLlCt4oX8hQL9P5REp
	nALjDXM8J7J3ee0n9g/iX/O734TINiqxrx1OINx148dGAYcJvaJtHG5XafR9rTZsIMEhLnpvBTbTC
	iWxJHaNM28tlm7SE1zQKrmYl4vWvE90cd4xKprvWUoyGtDPUFnjbZWOUxpiLW6UTQyEMCQa3Mvqna
	4BTiZ+fWin6K54EJrdAMr0FX5y4oaKxPHaVmO6uwAfyd215zerz9f3SzQW/rKKX+YqpjDqpK1fJ4+
	v/bf9kombTTcDrqPanA+YmII9u1KnxfDmEw/Qc6tvLP95+JfehsiYoHWJepO7D4IkPyHfmvZfYhOp
	msTXW3AQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tabE5-00000001Fu9-3XIX;
	Wed, 22 Jan 2025 13:57:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 135A7300599; Wed, 22 Jan 2025 14:57:01 +0100 (CET)
Date: Wed, 22 Jan 2025 14:57:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 29/39] unwind_user/deferred: Add unwind cache
Message-ID: <20250122135700.GS7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <51855c0902486060cd6e1ccc6b22fd092a2e676d.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51855c0902486060cd6e1ccc6b22fd092a2e676d.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:31:21PM -0800, Josh Poimboeuf wrote:
> Cache the results of the unwind to ensure the unwind is only performed
> once, even when called by multiple tracers.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/unwind_deferred_types.h |  8 +++++++-
>  kernel/unwind/deferred.c              | 26 ++++++++++++++++++++------
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index 9749824aea09..6f71a06329fb 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -2,8 +2,14 @@
>  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  
> -struct unwind_task_info {
> +struct unwind_cache {
>  	unsigned long		*entries;
> +	unsigned int		nr_entries;
> +	u64			cookie;
> +};

If you make the return to user path clear nr_entries you don't need a
second cookie field I think.
