Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126F212F83;
	Tue, 18 Mar 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320939; cv=none; b=OIkxY+YGHcnupkAqg5LbtCSjbK62pT8HZgu8h10liL0yv2zM5+2S8AlGcKcVBsBQRLt5XTo2+hlGloTZQ4iWdrGiT7gxKfMCCZd0+OdpfNdvbE4H4nJ5Mvu9I3swvh4FC35ElSTydlXwBm5EtwJR8j8LCL/3DlhGUmEqbHUcgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320939; c=relaxed/simple;
	bh=ArXXFEcIIUZWHFEwv16mQadEjgmXy3MQ1e0LOZgVY60=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BzZmYTMQ3bc7NGI5lAHn53lAY4nq7PFN4e426RHD4Xxsjmq1i1TAF9EzFI97DcLs4yGXuQY9sJNvXQTZOlgUP86Q8RbMK41eLGg+Q5UaS4A7mMom5wIL3fgX6EGDPN37sYcIxRgr+AfNHzstf5nmY44Rspoh3UyYJaSAOzfj6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhD0AKe/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhD0AKe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B8EC4CEF3;
	Tue, 18 Mar 2025 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320939;
	bh=ArXXFEcIIUZWHFEwv16mQadEjgmXy3MQ1e0LOZgVY60=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=XhD0AKe/Ax953VfGl7xzvsrt5mZlUcmSA352EjjUIHt/M5a8F3y1dFbBFo8fAUSR/
	 b4dk8mBbDQJrxw1NRfUeyEtvpO9leFmW4eQi+MtJLo3Ju0PQPNmlTxq0IDefpPTcc9
	 uAqSovRHfv3O+bsPVloFpbAn1q0jaJQkmWwqfNSXfvrde1S961kvjXziwnLJzZ2wBl
	 pSNWIGkVuYgu4zJvT6/dvEupOECNgUPGbc9ndVEnES9zDIN45wi+NNBSPOEFZKowYb
	 75p/myzS5XjPcq/MHLGFz4A591FS4tfaMK/OAuPvxPQ4gWUngUOzK44xzjRdA/ukA+
	 OvKjFZ5aUIi9w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>, 
 James Clark <james.clark@linaro.org>, Yunseong Kim <yskelg@gmail.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250318043151.137973-1-irogers@google.com>
References: <20250318043151.137973-1-irogers@google.com>
Subject: Re: [PATCH v2 0/3] dso__data asan and test fixes
Message-Id: <174232093858.2542685.4665922116149996453.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 11:02:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 17 Mar 2025 21:31:48 -0700, Ian Rogers wrote:
> The dso__data logic could deadlock with itself when build with asan or
> reference count checking due to trying to recurively take a
> non-recursive mutex. Use clang's thread safety analysis to find/fix
> the problem. Running the tests would fail with -F no-fork mode as a
> file descriptor wasn't cleaned up.
> 
> v2: Remove an unnecessary if as suggested by Namhyung.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


