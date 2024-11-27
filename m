Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CD201003;
	Wed, 27 Nov 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732732073; cv=none; b=o1AJbgZq1sf8xpCF8H5aGoVvsBhue8WES0RqHHufaxN47v6oaMhOr/9hLsf3XinQ4G9nIrjooQ0JdV8+wDZdZsxgjsK1RQhSJytrm4R9BRW+pjocREyCrnDk3/8aHq2a6ozN4JCAaCruDiKzqi2gS+kHDNQAVUzQCGGh4+irx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732732073; c=relaxed/simple;
	bh=BpvoqJhPPGHU0/1lw3RKqOrqkdvi/kYie+4tI8dMyJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/Hi/zC+Yp0f1m8O0ZvzxvOchpnQfCzru9B9EVTstFqaylJ0xEMLX9C8fqFjBZ/OqPVpbsk0FbYL8BEGCprEj8g5YvAZ9J8PZghTML6r89/rOUmWKZJCkPEsV85nihZu20ZA5R13OHaof4aT7r+cpRzPWIFEcN35TYuqltdBGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqYQASw2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqYQASw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA73C4CECC;
	Wed, 27 Nov 2024 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732732073;
	bh=BpvoqJhPPGHU0/1lw3RKqOrqkdvi/kYie+4tI8dMyJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqYQASw23O0n3sC+TH1P5jQVv2bConIKIKGGotxs5lSba6/ktmn6iqqpJcjJDpiBr
	 io1umiO9rYx02R0sknjb32U8jB5hJxFa2OtWc/mT5BSRJDgVhzA4ckLDX3hWnI4U2G
	 TvUoQOzSY9XND+s054IF3z06Vi85gnRQf5uyBsUvAEezeiXDvE4P+iwUXlp+HCuS05
	 mocpttUAdQb2R8nKUn9ZcMuo2aBPjEmb1v/I7mxVpxWPzU1JYMLBBxRUP0QbQCwvq3
	 9ZEKd55VIKX96cdRsibP4jvHcDjMvUbgcxbozR0WkLblq1hMIcypFMpmnB1/hCWoIE
	 FOBC0gHdumxxg==
Date: Wed, 27 Nov 2024 10:27:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] perf-tools changes for v6.13
Message-ID: <Z0dkpqogjSCnJQec@google.com>
References: <20241125071653.1350621-1-namhyung@kernel.org>
 <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
 <Z0ZhDHXxHKoE2Nrl@google.com>
 <Z0ZvAB0vcL-D-a6f@x1>
 <Z0aRFFW9xMh3mqKB@google.com>
 <CAHk-=widREwanfzcQ3YUvqQ42xLmQHjK_asCFN2jTBM2OHY-Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=widREwanfzcQ3YUvqQ42xLmQHjK_asCFN2jTBM2OHY-Ow@mail.gmail.com>

On Wed, Nov 27, 2024 at 08:02:42AM -0800, Linus Torvalds wrote:
> On Tue, 26 Nov 2024 at 19:25, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I think it's a bug in perf record since v6.12.  I found the build-id
> > event in the header area is broken.  Can you verify if this works?
> 
> Ahh. And the reason I thought it was new to this release was simply
> because I was traveling during the 6.12 merge window and didn't do the
> tools build that I usually do, so I hadn't realized it was actually
> pre-existing.
> 
> Your patch indeed seems to fix it for me. Not hugely urgent (I just
> installed the fixed perf binaries and clearly nobody else has even hit
> the issue), so I'll leave this alone until the next perf tools fixes
> pull and we'll get it fixed then.

Good to hear it worked.  I'll add it to the perf-tools tree.

Thanks,
Namhyung

