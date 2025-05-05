Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D91DE8B5;
	Mon,  5 May 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460593; cv=none; b=LqsXv3uObdu5hfhDGoVVHq6WRwogJT/LSRJ3tKYKD+ggCF00L1FTbMt8zxNj4xbupaloCmpT0KukjQ7J6VfmFPw+Rneu1G0DIl929hDGSQEs5AOitoipVW7LW5q7tA5umjYZBS70ARtrfJMd5LqSuykpe0aC3J631DWEksJmb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460593; c=relaxed/simple;
	bh=pDBCJl/YbnN01vLcFTw8VW8tG3TMy4Cm51zWIcQIeEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjLevnsYsu5JD5X3OW+0fEDIV+tPTpXwsBbNbjw+/kZV3FUc4KCaJKVsAm0hduzsMfFWwWBfBrX2qJuhLYDu2XOMi5W4FdpiqwB5hCy5f4RkeUhtjW9oAFlEu7oDEWUGG2iIBCsT3UwifAN9yo6mYkmoHjdVlFD3q/c5B+2Ykvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJbxH7ZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJbxH7ZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DAFC4CEE4;
	Mon,  5 May 2025 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746460592;
	bh=pDBCJl/YbnN01vLcFTw8VW8tG3TMy4Cm51zWIcQIeEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJbxH7ZRoJtTsRItNw5J1+3hTu11BiIm3l81QSazm7k2jiVs4/YTjTI6w+8PyjfJ8
	 08+O7cmCVG6C2oMUMCSsQZoir7JeehLw3u2dNkjyntdYn2YMh7/fVZBw9FVPCM96LL
	 BY89vGnCJrG1oHnx/5gPvHR7pw6hhTEZrlTy/MLphGUHEbBv4L8dKLIC3KnyXRKzcu
	 rmrVs8HqdoVWjrPvrc6T0toZyO+Xt1tc13/fNLVz0xLcf3TyOBU51xnxze3bFzJT6e
	 nChIrmKXMoXxv+kUZrw8RW432ZpZp24DrBNJgCLdYHrGM3bgFhSTLWMsPjCeTLvO+1
	 Ru+Sm9nKEVEkQ==
Date: Mon, 5 May 2025 12:56:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, gautam@linux.ibm.com
Subject: Re: [PATCH v16 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <aBjfrUqFe444h_CF@x1>
References: <20250501022809.449767-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>

On Wed, Apr 30, 2025 at 07:27:58PM -0700, Howard Chu wrote:
> Changes in v16:
>  - Add Tested-by from Gautam and Acked-by from Namhyung.
>  - Rebase on the perf-tools-next branch.
>  - Edit the commit message of patch 10.
>  - Fix a bug caused by the type change of struct perf_cpu.
>  - Rename test_offcpu_over_thresh() to test_offcpu_above_thresh().

Please take a look at the tmp.perf-tools-next branch at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

I added some Committer testing with some extra steps to describe how to
reproduce the results and there is one point that I have to retest,
where there is a FIXME in the Committer testing notes, perhaps I made a
mistake or that fix should be moved to after or before some patch,
unsure.

- Arnaldo
