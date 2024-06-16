Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADC33C0;
	Sun, 16 Jun 2024 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718513142; cv=none; b=WxRLTkgLrD1JXdSCw6T7u8kr6f/ANcyHdCYLeTDt8vSL1NzSYpOhQHaezGUPynidgZeqbo85+8I0D6KldfF/r31i8yHCDpQYeeaeZm0d3h0EkoN4wNsvmKwP9dQOjHDAe5gtCW+daS5MytRnbf9iIS+dnpxPVSMawL1F+w8uJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718513142; c=relaxed/simple;
	bh=y9FBf/cLkqyXE6NbECmzQZqoc60kHgjvTjgwH28Zzow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKhgGjz7kLP7V0Lj3kaPYdT0R5tT1lL+AkI9Fx1mjQRBOAgsGTPU0LyRIrULeWNA291txO3dGet0RoQNP+bCbwmIVs9+X3aJLHQD5LuTRpzzt9SuIboCD3h9NzW4rTuCi/Mu0HdBiYSXoBr53d+Fv6wgVBy1oksThWdtw/FguKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO938OLJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO938OLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F838C2BBFC;
	Sun, 16 Jun 2024 04:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718513140;
	bh=y9FBf/cLkqyXE6NbECmzQZqoc60kHgjvTjgwH28Zzow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MO938OLJzyBafwp2amZ8qk/cacYhelHw7qhs4NwoRgQMtZ3vAq2znisg0LdH1UOID
	 U/gGuGhQrJRAsDmAncXq6PJN1gDeRC3xuzuxlxKmguQZM5zpjP7kZEPwEMB2774pA0
	 nQTO3yp1QjyHfbjGFKwcAoACtW3iNwvh0cBpAEmwuWvjmhllIasLjcc244skYavUo3
	 ZmOfcGanQ6/97SiI6yXCZt0O0mpexIIcE484k+jTxPPUHX4abknJDJG0VAbpPG/NHT
	 F5iLhq28G+VHf29E0hmKYh91y2H5KC+iKM+ZLLc8DzJ5tCuBuKM9MVimVFnHh0b6EA
	 GQytbLIRFKvvA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf report: Omit dummy events in the output (v3)
Date: Sat, 15 Jun 2024 21:45:38 -0700
Message-ID: <171851312624.4149164.12595885460954386799.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240607202918.2357459-1-namhyung@kernel.org>
References: <20240607202918.2357459-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Jun 2024 13:29:14 -0700, Namhyung Kim wrote:

> This work is to make the output compact by removing dummy events in
> the output.  The dummy events are used to save side-band information
> like task creation or memory address space change using mmap(2).  But
> after collecting these, it's not used because it won't have any
> samples.
> 
>  v2 changes)
>  * just hide the (dummy) event instead of removing it from evlist
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
