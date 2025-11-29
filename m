Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DA79CF;
	Sat, 29 Nov 2025 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764447784; cv=none; b=f8JhlsvhYNpJh7G4CY70l424M87b0lIcno+vGw5+bbUVrjXeiTJdZzKYvF6LjkJdFW7A2oJYogA1PVlbtzk/3hMlKSLIcW71zEFjLROnJyvBgGh8weDK3xU1I1+EirsGidlSgfc3xXfGrHAp+moReR6gU+0+vtq1uw0I/02mSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764447784; c=relaxed/simple;
	bh=ahi7DQV2W9rhxYeF8d9DIPigZ/nw1GhpEdl9ZGzD42k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKxrpRv+fXQGIM60CLa0ZHRgberut8jG4EMjXhZg1F4EQnmuv6v/7NuQqc7/S0H7PEgEqUPMBaj5JA2xhWmpXEDzSTKq/SIMAKxURwjUrqMFKo4htFuNhkABkY+IH2S2fCpbzgfNlmBxCrnPfSaa007v+xZx7IaKwOuduW4/wY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFYMgGrT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFYMgGrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D036C4CEF7;
	Sat, 29 Nov 2025 20:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764447783;
	bh=ahi7DQV2W9rhxYeF8d9DIPigZ/nw1GhpEdl9ZGzD42k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFYMgGrT7dnICW0QoBMZ+vVvtiY8Lz07EFzQY6fQYsJ8GOVhCQPqhAyIgQYx18ijx
	 /RMtUg8O+QctMqKew1CrAXK6zGRDnSFejrMXRyF0c4FGK+tm7h7ZIsCCyjYNObVJUz
	 1Wcf8nxjrf0l3RrWRP5/PkCMkzd8rV1F596nnDkpt3158VE9vZFA3p9qooH3/5rw9X
	 Iw3zqihxmG/q2SNEDLR2oWd34vHxec8FFjdSYBFFQc8HZqZaHxUiZNrjaCtgnFqo5U
	 h+VKtSBbpF0/FdVvmOEZktcTjikN3wt0jt7AV8OCcBVBW/0304d2GImfIdHmDY7V2/
	 iT2zJuJIe8Btg==
Date: Sat, 29 Nov 2025 12:23:01 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH] perf trace: Skip internal syscall arguments
Message-ID: <aStWJTF4WOVFkSG1@google.com>
References: <20251127044418.677379-1-namhyung@kernel.org>
 <20251127203052.12a6a163@robin>
 <aStEaM9tcGlRclQ4@google.com>
 <20251129144202.0567743b@robin>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251129144202.0567743b@robin>

On Sat, Nov 29, 2025 at 02:42:02PM -0500, Steven Rostedt wrote:
> On Sat, 29 Nov 2025 11:07:20 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > Even with this patch applied, I still have a segfault with this command:
> > > 
> > > # ./perf trace -e syscalls:sys_enter_write   
> > 
> > What about this?
> > 
> >   # ./perf trace -e write
> 
> Yes that works. As long as it isn't considered a regression that the
> sys_enter_write crashes, then I'm fine with;
> 
>  Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks, I think it's a separate issue.  Will take a look.

Namhyung

