Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40E222597;
	Thu,  7 May 2026 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778134318; cv=none; b=pIjgoMdavZ2bhsuqazQosQ5TYYJsCOG6n6PnkSSX8R/VNSei7iTLokl1x/0CF880Fno/BtHH8lUzaHYz4YD7jzmuTTKz3+ADWyd3XgJTOQkyK0l4LwxIHCJSuDbzMWVorNZBuH6vaIg1u39flq1lD8EtAgE6dwz/u9qKu7zZ11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778134318; c=relaxed/simple;
	bh=8nh08DQM5nuK2IlQQk49tg4qnrJi04V+2g6j4Jc6bk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UexOrn6Sd+JC0XAOff8LjCZpPuokV8OzHpOTC0WghPcMRWrqzbkGrG/d7ayX9ElztSjBl3WPYTtCajJeLfIOIShQFgQB3qvGq5/+Hm0MGrraNRSIqD2Nf+Cz9eYSzISUkz6sb9oeyxiZiui2ajD8iDapnTNeiQ1bMNNkfh0GRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDjYz08U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDjYz08U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B346C2BCB8;
	Thu,  7 May 2026 06:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778134317;
	bh=8nh08DQM5nuK2IlQQk49tg4qnrJi04V+2g6j4Jc6bk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDjYz08UjCBzyN5C3cxH3h6wP/cc1wSUCdAnZHl3y32/tl8GNwQrCdRVQOYk1vUTz
	 zKVM6+tlcCE2Mro4j25xN6Hl8wVhcehIB277NTZYPMK1s0MfVYt3xR4G7Zuykiyib3
	 ohxiaHdSPWn37UPZ9NrUsb884x6p8P2CjY4NtYcOWpUGqs7D0UeHGjL+HTn0Td3mzt
	 alpl8qVL4LB/DAhw487WtmLc0FCjLoTXLiROXNcYDLl+OLG6SP2NWTA00Nz5gzNf2P
	 bA8n2+fbC5DpcHYsmnTr22wbkGUvxuF8wfDvMID0s5Hc2wez0n6QSkP9sKWx2ERPF9
	 Ua5U8ilGMYfvg==
Date: Wed, 6 May 2026 23:11:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] [PATCH v5 0/9] perf DWARF: Fix libdw API contract
 violations and crashes
Message-ID: <afwtK1L0joUL1oCC@z2>
References: <20260503171032.1559338-1-irogers@google.com>
 <20260504081227.2203848-1-irogers@google.com>
 <afqRNoxQXJCVPHZS@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afqRNoxQXJCVPHZS@x1>

On Tue, May 05, 2026 at 09:54:14PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 04, 2026 at 01:12:18AM -0700, Ian Rogers wrote:
> > This patch series addresses a number of DWARF/libdw error-handling
> > bugs and contract violations, preventing several real Userspace
> > segmentation faults and memory/FD leaks.
> 
> > In v5, the series has been extensively restructured and polished based on 
> > comprehensive review feedback on v4, focusing on history granularity, 
> > bisectability, and defensive styling:
> 
> Thanks, applied to perf-tools-next, for v7.2.

If it isn't too late,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

