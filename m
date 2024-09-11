Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8198F6C;
	Wed, 11 Sep 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064697; cv=none; b=nNq3YEMNF/b8M/PkscG1BH4ieDQ8Isc1dwHIzISPuuPg5qjcgNqvvA0tpqnPi1Tr8otbvnGbIHR18QJghmuahqetJAj1JfTbx+A76pts4f9SParJfZ9Y5d5rGhXW9L5bHCwu5YaolKjLq5ikcXo8UTVKBTDEc2yEdYctmzDXh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064697; c=relaxed/simple;
	bh=30Gh3tNWYgZEv0YbQvnDnmMbgp24wiIcONKTHghjEL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+ZzHOUPRJP227KhDkvoBLdOH0jjXbLbM3kn9FHqN3g5ORvIff7y9fGZXoG0NJbTAMtGCt59yRBiNziccL9a6tE9PLAvRoS96AQ5ZQjJ/D2b/v8UwMiryvOqPeHtuw7A9ClacNNedx+5FYb1q4BbPLnuNnvIvApqfbowv5EXy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvMolqD3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvMolqD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B09C4CEC0;
	Wed, 11 Sep 2024 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726064697;
	bh=30Gh3tNWYgZEv0YbQvnDnmMbgp24wiIcONKTHghjEL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvMolqD358BGsUx2trKPEVcwZTHOof1XB4gKxe72CuOGRh45j9z7Pbi1vpzvOIn5y
	 M7s6H2DqR5VwvBMtc+QeZQ1m84dIPRnACVlC8v7C6ER0O4kiO73ykjTzpCpqXAEL0D
	 eodz4xjtwcRsERrINLbue5wbUIMkQ09arHc7U0Mk0X6rZSdtYCaG3mqmTDY22BbUv0
	 g+egJbd4KnGZvWFs0xH9bShr7cLr+GBqCsG4b3F0hGz6r6Wpil2peuNZwafFA90Fck
	 LqlEOBwwbSt7h43hx48vKnUa2TRB87MPROcnJbCsGU23z6ewrGfY9q4DKRv+36Wz9P
	 k6ET2ouPuPc5A==
Date: Wed, 11 Sep 2024 11:24:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andrew Kreimer <algonell@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix a typo
Message-ID: <ZuGoNa0Kz6GNFLLn@x1>
References: <20240907131006.18510-1-algonell@gmail.com>
 <CAP-5=fUW1z++JdFHke8X8Ou-grBRK_8rYPgd+CNjVLB9iZ5csA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUW1z++JdFHke8X8Ou-grBRK_8rYPgd+CNjVLB9iZ5csA@mail.gmail.com>

On Sun, Sep 08, 2024 at 05:30:36PM -0700, Ian Rogers wrote:
> On Sat, Sep 7, 2024 at 6:10 AM Andrew Kreimer <algonell@gmail.com> wrote:
> >
> > Fix a typo in comments.
> >
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
