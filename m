Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE782C69B;
	Wed,  4 Sep 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460220; cv=none; b=oeVGWano+eVZdA/USWZi5J79qiwrR3Eh+6+UKdbZs4+Z3RVVwi3y5elhPWSdxf+MdncGv8XWZvFOUY/fYGESkzv4vxEItk+Xg63GttQ4LYDOSGu3I30A7r1xS4x8ZLySVSPNY52dWBnV2L6jMMkOdnrCZ1fnikYMuN4QbshamZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460220; c=relaxed/simple;
	bh=sGDqeCF/9v4iitt9UrEra2iiQ4lLGL2Dbk06fch66ns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=opQC5lfhAM/JqpZEc+ZMMmhUmrlaHXV/T4qoaKO9oHDc88Z7Db8Tqx/yazDdbzyKS47ZQX1TyOvfkPFiSPKdkDwP9t89fGZrwwTd3KZqhs2UaRBzsE3OtWe/61+iOw4FqkCUpIwk9c16PGTArPEJNAzd9uWmdE1C0LTlJLobE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/261sAf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/261sAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CBFC4CEC2;
	Wed,  4 Sep 2024 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725460220;
	bh=sGDqeCF/9v4iitt9UrEra2iiQ4lLGL2Dbk06fch66ns=;
	h=Date:From:To:Cc:Subject:From;
	b=g/261sAfwcMeAGjqawlV4Eg4O/OuQEFNLZc4nQ65tp0LAICJwVFH8aEsL1JxWTLzE
	 uUivNt407VQYE0I6RNfea8csfvXMqXt0BH4TdJoUEhD23R7/jyntMkRawk5WMzsgmD
	 KICyNC3nDq2yCh0ZJbLE6w07QdNnCvPjmuGhVh+X5hTWggf3Paf4yO3/ZrIcJnNQxF
	 npCyqINT28qQ9cZY2UeTynm2G5ZDiCH+sTQYnzlscoZ6dzRVhEryqKxHK/Jl9tAs+N
	 FYt1iCDPGCzhybZ2xSIO62X8QEKDRJ9Vk6kogqRomkC5n0dQnXKXgyIalMegs53o7j
	 GVf66xA6u6c3g==
Date: Wed, 4 Sep 2024 11:30:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf mem record not getting the mem_load_aux events by default
Message-ID: <Zthu81fA3kLC2CS2@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Kan,

Recently I presented about 'perf mem record' and found that I had use
'perf record' directly as 'perf mem record' on a Intel Hybrid system
wasn't selecting the required aux event:

  http://vger.kernel.org/~acme/prez/lsfmm-bpf-2024/#/19

The previous slides show the problem and the one above shows what worked
for me.

I saw this while trying to fix that:

Author: Kan Liang <kan.liang@linux.intel.com>
commit abbdd79b786e036e60f01b7907977943ebe7a74d
Date:   Tue Jan 23 10:50:32 2024 -0800

    perf mem: Clean up perf_mem_events__name()
    
    Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
    one.
    
    The mem_load events may have a different format. Add ldlat and aux_event
    in the struct perf_mem_event to indicate the format and the extra aux
    event.
    
    Add perf_mem_events_intel_aux[] to support the extra mem_load_aux event.
    
    Rename perf_mem_events__name to perf_pmu__mem_events_name.

--------------------------´

So there are provisions for selecting the right events, but it doesn't
seem to be working when I tried, can you take a look at what I describe
on those slides and see what am I doing wrong?

Thanks,

- Arnaldo
