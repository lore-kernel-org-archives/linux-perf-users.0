Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFF1993BD;
	Mon,  9 Dec 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776013; cv=none; b=AuCWV4dVSE5nK9KF0B7CferOx9h35gpUlf3nDci31Ahezo3huUSy895fzf5n4FXAxajetbQ/S4R6sHy6LTbFKd1ts6jp1SM44J3Hcg6gsL4euwgWWasTRkSTFLz4Pc7VrgVn9bsu3GkvgOmg1Ir1Dd2PBvv6pJI8q285AMj8PtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776013; c=relaxed/simple;
	bh=9l3tl4GaqnmyavTKUwBBk/QdWyo2NJ0PucScNMDRkhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbJsvmHdRdOL4kAKFU89uEGfQH8NBC9AnE4zN+tk9F9k3waN9rbKIM5kswn4yP+a4DQ8hcbwTJAl3yHgFiDXe8fKuDK9wNoVDPTxwJh8cx3z13kAeyXiOezguB0q6K1qZUqESmDsTx2K2nc6t4cIiG9zosKzvdCR7NKO0Rv5Zfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpVCDmpj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpVCDmpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0E3C4CED1;
	Mon,  9 Dec 2024 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776013;
	bh=9l3tl4GaqnmyavTKUwBBk/QdWyo2NJ0PucScNMDRkhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpVCDmpj37Uu7xG5rvT42sN0kSqc/gQjekM4UPdrQoBt9c3T1Dbhelox2bhxqjTGG
	 CC6atFfBP71fxOHtqKewqnHY9S4c4wHaHjcZ7zBRwkkq+mU7NaSZz+rBeGOSmnPePC
	 yCM+5CDWf30mGnBL4lZP6pyW+W0tTNkT56ChbxQ+y94C4Ez4597dI8yHjQkeBX1Ql+
	 oRm5LRESIbdSkINKPnpy2axSt2P3YXYGPQwtRNhYB8VvJdYIqfuo4PAUc3XPNecwkp
	 htQ3mhJ8P/oH5cHde0YY/8yssn1E1gnw0dX5NJCFoMnKNNuD15ZZ7P9XXmh7gmVvpA
	 3MG4ebU6erzLw==
Date: Mon, 9 Dec 2024 17:26:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, kan.liang@linux.intel.com,
	adrian.hunter@intel.com, jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] perf ftrace: Fix undefined behavior in cmp_profile_data()
Message-ID: <Z1dSimfbQ5FO7sjU@x1>
References: <20241209134226.1939163-1-visitorckw@gmail.com>
 <CAM9d7cgL-1rET97eVU2qpz5-V5XqeCX1N92wTwR5y2sp_4sjog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgL-1rET97eVU2qpz5-V5XqeCX1N92wTwR5y2sp_4sjog@mail.gmail.com>

On Mon, Dec 09, 2024 at 09:02:24AM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Dec 9, 2024 at 5:42 AM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > The comparison function cmp_profile_data() violates the C standard's
> > requirements for qsort() comparison functions, which mandate symmetry
> > and transitivity:
> >
> > * Symmetry: If x < y, then y > x.
> > * Transitivity: If x < y and y < z, then x < z.
> >
> > When v1 and v2 are equal, the function incorrectly returns 1, breaking
> > symmetry and transitivity. This causes undefined behavior, which can
> > lead to memory corruption in certain versions of glibc [1].
> >
> > Fix the issue by returning 0 when v1 and v2 are equal, ensuring
> > compliance with the C standard and preventing undefined behavior.
> >
> > Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> > Fixes: 0f223813edd0 ("perf ftrace: Add 'profile' command")
> > Fixes: 74ae366c37b7 ("perf ftrace profile: Add -s/--sort option")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

I'm assuming you'll pick this for perf-tools, ok?

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
