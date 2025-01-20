Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39B1EF08D
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397614; cv=none; b=C+t0L39XvZWJiut1sifuh72wtZ+3o50c/EKaUzn0opTQre1p40q6DU3I/3eAGVHeexqps+pqjhdsXb/2Ff2XxWbAD2s/H4j4ID2//WUD4fQRIzCU6yaQzKFFfqghwzrQF2uiVEATbMoaRjCQwIa8tnTXEDz/0hQv1L4LuX8yYfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397614; c=relaxed/simple;
	bh=3Ec0q/3tdObVXJBG60rzWCKvQBWmVLyUV9dr8jd55QA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kmjS1T5tZ8EBx8JiG9/p3Mq+FNgd/TbOh3E9ZTw5qd3Lmaw6R72xCrGZn5xsMFLaHzjJpKNZPbfhrDOUjbHzOGRU9lLiislYFRleyj1BinX3E+62w0o9lHGMzJYZ28x+OwCwLn526yp9O0eBzrupzO44AmseW5+rKJhp8r6v640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR8a9K2U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR8a9K2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F0C4CEDD;
	Mon, 20 Jan 2025 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737397614;
	bh=3Ec0q/3tdObVXJBG60rzWCKvQBWmVLyUV9dr8jd55QA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CR8a9K2U2l/ty+sYOWLjiAlBF/YGotue1UZg5v7EN7AMmaJiK1WLbM/kH8eTGIpCU
	 UTcGHEi+cXR/Ebmg2s/9irOnRy1lP8GxzJ4Q8uJrJsh0HX+hIPXiFDfNYYttGXHTcx
	 4BYRvvvq1r5DCx4dY8rqRneRZxtxAlrXLCQPmKIfY3L5pIu1EvFQsrtN/wmmSFQo5A
	 MOFMl/UVEtPKT81uNZtBytYDujFkCM54cQa5B/zPZ1XQAIS0+LHiRMlyjb/K7iUQ3p
	 Eu8TcLalG5WAQ/x0mODE4ebVqk4AfaFG7HMRJ2W1E+NjcwWEeIRT8KtsXbl/Yk1H+X
	 qlwvOyVlZw6Rg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, ravi.bangoria@amd.com, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
 hbathini@linux.ibm.com, Tejas Manhas <Tejas.Manhas1@ibm.com>
In-Reply-To: <20250110094620.94976-1-atrajeev@linux.vnet.ibm.com>
References: <20250110094620.94976-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/perf/tests: Update event_groups test to use
 instructions as one of the sibling event for hw type
Message-Id: <173739761368.3950752.17907962905280799459.b4-ty@kernel.org>
Date: Mon, 20 Jan 2025 10:26:53 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 10 Jan 2025 15:16:20 +0530, Athira Rajeev wrote:

> In some of the powerpc platforms, event group testcase fails as below:
> 
>    # perf test -v 'Event groups'
>    69: Event groups                                                    :
>    --- start ---
>    test child forked, pid 9765
>    Using CPUID 0x00820200
>    Using hv_24x7 for uncore pmu event
>    0x0 0x0, 0x0 0x0, 0x0 0x0: Fail
>    0x0 0x0, 0x0 0x0, 0x1 0x3: Pass
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

