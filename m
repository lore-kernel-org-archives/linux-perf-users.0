Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB467E9;
	Fri,  7 Mar 2025 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385336; cv=none; b=Yhe1R6jYtQdL8hn3UWrtR2sthIixi6ReEqhrEjlMTNWQJPcQ9UPX3G2D9WLWPL/ZUIG1qZ9JOqjl3dXYBgdjhSQ/QIYgamggn7BKP3GIaMaEaOnqXxMtfci3jQehtyzg4Viq3Oqf4wr0nlFrjGfviAJP7OwW0KJv2Lb6LaHHoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385336; c=relaxed/simple;
	bh=+mgZ1t895PBSErsMqkYwRD3tya/jU3FhAT32/eqyqkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDMDGhaWEnA+VuYLgjECPOpwM778Xdee7Dnyqwo9lKxVXXZdIvPb8NxkmpuvGwwESkLLBs/GpBdonUFhzu+Y1GNnFdIjeZT/0ZKleJ8wk52UblNqKkENyqoYm3337vd8iFuJmy1V8aPaN0NKuF7Y88qoz8caLuOyYhs4FpB31Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3rBwhSm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3rBwhSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88938C4CED1;
	Fri,  7 Mar 2025 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741385335;
	bh=+mgZ1t895PBSErsMqkYwRD3tya/jU3FhAT32/eqyqkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3rBwhSmr6op5lzm/Eg5BQJIPI5ln8m2EynZ7s+KIxE6HdwPDvIa2JlNP7k/FhOVl
	 ANGrsXhuQB/gEiOVTbAwWH3C7Uh/gUhkoX7xl5hUoyZnVQYBQ8eHD0eSOUL6hfWJ1M
	 LlSQZdH6Mz7vghiVAxS2eF0Zneqekoql5QPUoJomDxA0uw+Z8C5JGZP7S4aGyp9SGZ
	 5ghm1fO5NXUbg+TfUaQToZR7WPKW28b1IFUY5vYMRdtX5ptI7nDGnlvi5Vj5O6zsWs
	 hNoJLRMMqluXen4D1aK5THDOI33QF/9srhno12Pnwghb48jLj58fax+8Zexi09aA+L
	 888+N2LLvPq6g==
Date: Fri, 7 Mar 2025 14:08:54 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] perf report: Use map_symbol__copy() when copying
 callchians
Message-ID: <Z8tudline_-qNJog@google.com>
References: <20250307061250.320849-1-namhyung@kernel.org>
 <2719d1d0-6e1c-48fd-b73e-42b78c51b201@web.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2719d1d0-6e1c-48fd-b73e-42b78c51b201@web.de>

Hello,

On Fri, Mar 07, 2025 at 07:55:25PM +0100, Markus Elfring wrote:
> * Please avoid a typo in the summary phrase.

Thanks for pointing this out, will fix.

> 
> * Can a cover letter be helpful for such a patch series?

It's just two patches and they are independent.  I don't think it needs
a cover letter.

Thanks,
Namhyung

