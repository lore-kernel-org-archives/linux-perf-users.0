Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0711FC7F9;
	Thu,  6 Mar 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281249; cv=none; b=TCJNamGDCmAU0fdNeKbD7UkVNIQvBCTr2lexMjgfy2kyNu34AQTjzODXYn1GclhV3J8ggZarjf5dgmhr6P/7CHYAhUSBM0ZWdf5hwmih83MD9D0EB0m0zuwZMQ5LiXDcpkZanG+IEisPK+FUKXR6gqYzP8JKSy9Hv5PV5eHRo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281249; c=relaxed/simple;
	bh=8FqMUatwcHUIE5A7QHIqZJOIUQ60Ux51fUTgWzW51r8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P4rOGPS7wSgjfaVzOmaZMW+xN3SIz8L8MMTqwFziQwM7lCm08uds3s+41j61IrKXnHqR+6Y7RttvkwfgGByrFImYuKqkuN2insw9QOp8oGrqbFJVCBp/jIT2sr7ILB0MgqUcXZW4mGqE0yf+iloPFXDqlvEEYrIlDnkoCw7zzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM0jWPmL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM0jWPmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D48C4CEE0;
	Thu,  6 Mar 2025 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281248;
	bh=8FqMUatwcHUIE5A7QHIqZJOIUQ60Ux51fUTgWzW51r8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZM0jWPmL5sfQrMNtXbxOlftG/8LKfS2oi3p3rjGQAOyodREiehbOWVEyz8fWDkgs0
	 FeekZkABOS/EHE9XUhfPHw8IPhjNdSJ4YS26omOigoAbj2v6HmtDe+oV0n9cYa1ZNC
	 uDG/PPiomI6/ccpdDJIqN7x8D4UeUhL8qsYMWRChTQclZ4xnRyeQQP1L7/WWjwcHeR
	 mQ89chq0N1xi3NUu/aL3NKcNu4oi9sqWNIoCyYGPyEZvIinOT04iODFswKlxsyil6r
	 AvtUnSV5CF31mCyZ1rTKuM+35ZgVLw6keoGTFuJkvObDQQgdlNVAC7C8qU/VctKzPT
	 uOYBc0hIeKyaA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250304022837.1877845-1-namhyung@kernel.org>
References: <20250304022837.1877845-1-namhyung@kernel.org>
Subject: Re: [PATCH v2 0/6] perf test: Small improvements
Message-Id: <174128124849.3835280.13347713031855117168.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 09:14:08 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 03 Mar 2025 18:28:31 -0800, Namhyung Kim wrote:
> This is an assorted list of changes in the perf test.
> 
> I've added perf stat --metric-only test and perf trace record and replay.
> And other changes to skip privileged tests for non-root and simplify
> data symbol test.
> 
> v2 changes)
> * fix shellcheck errors
> * simplify datasym test with timeout
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


