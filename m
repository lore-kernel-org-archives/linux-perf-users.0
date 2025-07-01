Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E82820AB;
	Tue,  1 Jul 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392516; cv=none; b=Jlob/Lvs6+XTO92YY6GOO/BZ5LIo9TL/ORNnTcj6kIwaKZgV5QGY+dxlMWlzMYBVsZ9LPMWVIz4wayfUTgtgmW04VtredFE9dmrhlHSkzMfJXHUbH7pJf13v/AG5MxUmYdc0ImQwfOFn0PR3b7Z6MHfD+4iREV0gw7CEUENC3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392516; c=relaxed/simple;
	bh=fQxoPSYs73iTSyX9yn+4UWbbrTgtSljBNrWOhhOVBpI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PN0KdNF30wq7gWwsQbNx2W/uYsDj7opsGTv3OGsxUni81Uc9budaIYaBuNwFenfyuHCdlGgtAxIGfkpzucdcwqLqzfMBTmAAeSJWMiUyJoaAgPKJo9FFVRVHf/zibHFc2+8sdnqxzFSCYKxgo4NjzWPgHpwgxRR9hPmpKfIo/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbQyUlnI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbQyUlnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BF0C4CEF6;
	Tue,  1 Jul 2025 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751392516;
	bh=fQxoPSYs73iTSyX9yn+4UWbbrTgtSljBNrWOhhOVBpI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QbQyUlnIrs4TspQWenfX0eXPB8e6JE9LImDio0/4of/4JLlQPCniWYrrFYex3vFmo
	 axfL7l71oA0Ios6qhW8WsQZDUZ8r8ApM5/q67PK3TUnCCw/mXOeilXVqN1xTWVYsRu
	 0jGWH4sud2fVRxbGpgNDlkLP+SMXA5O0p19J3ruZe9CMVnSIGWaHN640X9aqZ6VAHr
	 HaEqWMyxLehzTP6e6zVSXX5DlgcObGAxxByMo4iuRRLqlm2rIcqCRvkBLy6lsbOJ+F
	 2xlh4F7dkoVO/z2l2aatJmw9r+lGMnC2I+F6SqZezyuI3V5rRDvLyu0mVJPMfuE4C9
	 y4ldlPlckGWRA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 Collin Funk <collin.funk1@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <63491dbc8439edf2e949d80e264b9d22332fea61.1751082075.git.collin.funk1@gmail.com>
References: <f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
 <63491dbc8439edf2e949d80e264b9d22332fea61.1751082075.git.collin.funk1@gmail.com>
Subject: Re: [PATCH v4] perf build: Specify that shellcheck should use the
 bash dialect.
Message-Id: <175139251571.738306.7065497308002625311.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 10:55:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 27 Jun 2025 20:41:25 -0700, Collin Funk wrote:
> When someone has a global shellcheckrc file, for example at
> ~/.config/shellcheckrc, with the directive 'shell=sh', building perf
> will fail with many shellcheck errors like:
> 
>     In tests/shell/base_probe/test_adding_kernel.sh line 294:
>     (( TEST_RESULT += $? ))
>     ^---------------------^ SC3006 (warning): In POSIX sh, standalone ((..)) is undefined.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


