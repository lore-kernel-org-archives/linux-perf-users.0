Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BFB4C6C;
	Tue, 13 May 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169169; cv=none; b=dXsyCJN3nDFRG9LPSgQDxf2YNLONncRyMRlR5Cus/zhzd+FkCiY7ucuT0FPKlgyUkKOx+Mz/nFSqGevTlAyY4PPnzcdXCgjpz1GB0t2Cq6ouLXZ9vK1nBrEQ5P9A2fh4zn9fts9eRbdXpLRL6BS0w907Xfmgpf9DNI+BOy8s1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169169; c=relaxed/simple;
	bh=ubYU+l0kL5nMD9pFrExx7yGtf5Pd7t5tMbIcBj4Pqe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvvPkiPTtVz3g14DqXzrmDpkGPb1udIU53eHLr2npw+4lpagvf0qovvQCqcBhvAJOUTbfH8L14W/3/38XGRS2O8OGZx8NA6G2LUlCASSjNAOy7Jh2c8e/M63Gx+KPHuJ0v9Mgylp3rkuBm3FMc12JSa8GOT9AMK6D67Dnyeb4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUYFuV78; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUYFuV78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C3CC4CEEF;
	Tue, 13 May 2025 20:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747169168;
	bh=ubYU+l0kL5nMD9pFrExx7yGtf5Pd7t5tMbIcBj4Pqe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUYFuV78/gTEvEDwP6TxGnB+NcMvSLxW5dN3EZkbK21eox2wO6CKw8hqoFGWkQLN8
	 ODJNZUmt1gycJ88PQB5JmHIm9eIzRwo/KaHbC6Myhwe9mgRoDKm6TjRh2NAp5bxHA7
	 gYkigvLoI6X/hTNbZvUug6QE9YVsHgW6DUhGwP7+Wt8Nb+AtUGROhmJ4zEq6CYZd1e
	 CVmqF1cAo0IYrGRgaubBqvjvGJae7N7uuDjboDmiu/UwXofZSpWgPASBt5PDfZus6r
	 mxZDnGlvYTaxF+aSdGrxHSvH0ykZYXKdzOfof8Efx0LSHcCYVieI2TAVZc5EuzOg8D
	 EP+JSSzzwAI5A==
Date: Tue, 13 May 2025 17:46:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Update sysfs path for core PMU caps
Message-ID: <aCOvjWh0gzJEPp9K@x1>
References: <20250509213017.204343-1-namhyung@kernel.org>
 <20250509213017.204343-2-namhyung@kernel.org>
 <CAP-5=fWNtD5KfMCd5Fy7oKfVgXrgO=1jkhP2cxw204sKjyUxAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWNtD5KfMCd5Fy7oKfVgXrgO=1jkhP2cxw204sKjyUxAg@mail.gmail.com>

On Tue, May 13, 2025 at 07:58:40AM -0700, Ian Rogers wrote:
> On Fri, May 9, 2025 at 2:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > While cpu is a system device, it'd be better to use a path for
> > event_source devices when it checks PMU capability.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
