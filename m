Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B62620F1;
	Wed, 30 Apr 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018394; cv=none; b=gbXGWkFVn0YZCeEepGARvsMuqLSfBG+VHtQP/++UjNE6csX/kUC1G4+ZYoNR0E7vAKMUiYvUD7gb2JjpzqUiHcJlCwkGfFxdmQv9uZo7bful+lEVbNe5r9+uWeJ92jW3QY/23Rbru2Wdlh2BRsK43q5leBbMwKj+y1Put1L6TjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018394; c=relaxed/simple;
	bh=B56c2X14qHZ4Yj3ML01q9Bz07Deisw0vJi8ciltC+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKAvi3ASrWNFCnzVYTsy+xGuGCuR5W+YkEcAGXgGPFqcUehXeGC0sBXl7WISmeMSEyvBJAZyP4imaXn+Inxpj0C/Paxop090nr6sO/iYs+1fq5SgmVwgBhMwY9l5X05kPWRMah6xl10Bd62Gj84oiyP6gjXKtGCkF4iYK1fiZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFFWjWM2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFFWjWM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE74C4CEE9;
	Wed, 30 Apr 2025 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746018393;
	bh=B56c2X14qHZ4Yj3ML01q9Bz07Deisw0vJi8ciltC+fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFFWjWM2K43mt1MkDa65QXGy8Q1/Szb7pMpXhfz3xIdsDcPZWRqKHpP9mcETAPdDe
	 AzeRYqXLbV8jpgMpk1EABYv0+eypHt9QjY9labRSvopXYaz9HHVVqXF9dAufcIqHWM
	 g0vbOpYZvDfvBz6JfzTuDQ2k+uxUNA2epN85jJ9VYW0Ss9Cfpj8VljFA6Rtl6QgsZ9
	 jb5lAIyV7cATurVAieNjL4MClcfcujBqSJFiL0AeK7MQxqyQLngLGtX0KpTT/Ata6h
	 CfnCdyQro9CZbsjvXz2mXuHRUbST0Tu7Bcf8bHNRwXcNuzdierzkI3Ht8sAvs7kSCw
	 VTNyTexUfmBPg==
Date: Wed, 30 Apr 2025 10:06:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Mario <jmario@redhat.com>,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
Message-ID: <aBIgVi90Zinz6Rl4@x1>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com>
 <aBE8raTOCVZLfw7J@x1>
 <aBF5UWrxvYgbnxde@x1>
 <aBF7ZarWJvzeDKqF@x1>
 <4bea7b8a-9ff5-4ae9-8154-57ec7377ee4e@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bea7b8a-9ff5-4ae9-8154-57ec7377ee4e@amd.com>

On Wed, Apr 30, 2025 at 02:32:12PM +0530, Ravi Bangoria wrote:
> On 30-Apr-25 6:52 AM, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 29, 2025 at 10:13:53PM -0300, Arnaldo Carvalho de Melo wrote:
> >> Adding the patch below cures it, still need to test on a Zen 5 system.

> >> These issues were just in the regression test.
 
> > BTW, all is at the tmp.perf-tools-next branch at:
 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

> I tested with few simple perf mem/c2c commands and it seems to be working
> fine.

Thanks for checking!

While testing it I noticed that locally built kernels using O= to
separate the build files from source are ending up with:

root@number:/home/acme/git/linux# readelf -wi ../build/v6.15.0-rc4+/vmlinux | grep -m1 DW_AT_comp_dir
    <17>   DW_AT_comp_dir    : (indirect line string, offset: 0): /home/acme/git/build/v6.15.0-rc4+
root@number:/home/acme/git/linux# readelf -wi ../build/v6.15.0-rc4+/vmlinux | grep DW_AT_comp_dir | cut -d: -f4 | sort | uniq -c
     49  /home/acme/git/build/v6.15.0-rc2+
   3104  /home/acme/git/build/v6.15.0-rc4+
root@number:/home/acme/git/linux#

I reused a previous build dir, something got reused, but then tools like
annotate, objdump -dS can't find the sources.

A distraction while testing your patches :-\

- Arnaldo
