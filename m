Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259141A2389;
	Wed, 23 Apr 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441202; cv=none; b=tVmp8u5VVXz3K745P2uF1OYZOgm0OEEDWg4GDzHqI12CjyOuvOOFyntVS+7H/IEuD+5Vyho4na6Ny4SbLTLhj/Qbr6ty1aVrClCzZMoX5pq1ptUoZdKX3j3tn3QOlg2tDlF6iCiVa69Skw0qwek+q/IarioQCRDzzBKTUqsPDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441202; c=relaxed/simple;
	bh=IoHj0h5hlZiOLUVsZqvtZr3MiQxq7erpybqB+GSMXNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koQrhFzWauzP1FxVTv5XC7EQhPmpquRY00H8gO8Lmw+18gFWb+toR++a40sck/srthCorbi4j/045sgPnOJIWmFIV+fDgoZHZ44Nc5HiCj3GCKa/ANJJ6rf2mOlIOD13cuqWPMJIF8PdFuX7cs7i7v8IXSAQydCwHp4FdiZ47Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8EnpIoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8EnpIoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14132C4CEE2;
	Wed, 23 Apr 2025 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745441199;
	bh=IoHj0h5hlZiOLUVsZqvtZr3MiQxq7erpybqB+GSMXNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8EnpIoeAtRwuZEg/pPsDRY5ZxB5+VlM8mPKJ/10zNi9rfnzuJxO7bOtt4zn7QYCz
	 zglLXDaUjVrT7sxxzxjP9ZRkBfnhUGbd5y0BKl1o00lB7PLC35+1gQxZTh+BPYq+3P
	 foYIze2nSoFgtQcVF50NICBeaczuTC078Qo5xSE8wvzzyKS9r+gl3rQyAmcXk4SR3v
	 tgAkU/7rRNMq7Sd+mfCG3Sv4FeICykM/hLEyBmDi0vU867bjGAVFsYXMBCog70lFAs
	 45MOtARWIqJC4KE9IXHyykImor/D2mlpCGMkA27q6zNDY8oj5TIlnPRoRmGgCzYf8Y
	 8UddeegnRwnSQ==
Date: Wed, 23 Apr 2025 17:46:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf report: Support custom output fields in
 hierarchy mode
Message-ID: <aAlRrFyNFQNyFhA0@x1>
References: <20250331073722.4695-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331073722.4695-1-namhyung@kernel.org>

On Mon, Mar 31, 2025 at 12:37:18AM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is to remove arbitrary restrictions in the hierarchy mode.
> 
> The -F/--fields option is to specify output fields and sort keys in perf
> report exactly what users want.  It was not allowed in the hierarchy mode
> because it missed to handle the field correctly.
> 
> This patchset addresses that problem and allows the option.  It'd make
> the output more flexible.  For example, this is possible:
> 
>   $ perf report -F overhead,comm,dso -H

Thanks, tested and applied to perf-tools-next.

- Arnaldo
