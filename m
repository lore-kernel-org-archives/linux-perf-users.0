Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D602E62D4;
	Tue, 24 Jun 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787590; cv=none; b=JlIdv/bd/lQx4hLPdwDZBwoWsnwPl7CzJ4DA6SIm3r3AJ49MKVzIU7g1e22b3SWPrA/eTSWUN6Ra6SRwwAyCaxyp15PczHLxa4c35/S0Gzx2VgR+8tp8vmjebjhJmiOwqUypZQA7NBwribk0X+qjdOlS9B5o4Mqes0UqMMrI6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787590; c=relaxed/simple;
	bh=70BGUPIJfBa+GDWetpa3tSvN0kw12tKcdBuGqvGxeUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YMVkcSDp2rEZZdHcBA2VTnbFSX13AUzMYR7NXzK61ouA376KPtcCyRAHEg+ZNudeKQ08G7PxiuEv0OC0LN1lksej1Ix15WphdpuVbj4RE7o0uesOD1c3B1/wyknlrIPZmihf+Zaa8GYqWocXo7xC8tgyZ6rypze9DYzpW9QzFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzpA7gEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzpA7gEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0106BC4CEFA;
	Tue, 24 Jun 2025 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750787590;
	bh=70BGUPIJfBa+GDWetpa3tSvN0kw12tKcdBuGqvGxeUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gzpA7gEXs7/dYoALpC8j7zUB+1KBVBjW/K2bMjURUIGjyvBqAbpSNIn0FfWJ9DebU
	 rVhv4TlLBVLN3VA5iXMDNHlzUbB35z3Oz+/SeBlkE+bzBL05KlFFQToKzGMJWLtWOK
	 z2ZinwGoce2mbyKCCePR7/1XSlAdtdqM+UH9C6yezyJVM4C30Yxh1ylIqIoj6A9ViG
	 RlpqmF8s1Nw+stlfOxFy53iNFeO0/ZFrQ5+eFoP6kcZe0ZvcL4vWC4nTcdrZzbS5wE
	 NKS2GOS9B/LkdoEKzyznTfz1GqpoubBkX2UU9jSj0s2oOe82ZY1JUKZba2MQRAuV5n
	 rpq5E1tnU+jLg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Tianyou Li <tianyou.li@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, wangyang.guo@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250610040536.2390060-1-tianyou.li@intel.com>
References: <aEeIN_u4KpLZXDBx () google ! com>
 <20250610040536.2390060-1-tianyou.li@intel.com>
Subject: Re: [PATCH 1/2] Read perf data file header from the file user
 specified with -i option for perf script flamegraph
Message-Id: <175078758996.337518.10407598236638254580.b4-ty@kernel.org>
Date: Tue, 24 Jun 2025 10:53:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 10 Jun 2025 12:04:22 +0800, Tianyou Li wrote:
> If specify the perf data file with -i option, the script will try to read the header information
> regardless of the file name specified, instead it will try to access the perf.data. This simple
> patch use the file name from -i option for command perf report --header-only to read the header.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


