Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6D2022D0;
	Fri, 18 Oct 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264811; cv=none; b=ib3/q5YQ6dUAULgMg4YycPm6iOI5R8mGkgI5Mf2ZzVuW/SPt98ig9ubmAw36prt1gRte8St7glC4wn54zUTtYyADnsWqn0IQWqfhwDCX3SttGFYnR5IwYJg5OsGe/6d/A6rE3USK2mM4Zk6WiIWWiBsfOWMpH61JIPy0+w1WIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264811; c=relaxed/simple;
	bh=5n6NrDNHf6Ja8sTbODF5jff7HURktYBpYt6hKfs7cZM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fZOvL/SSKTq0qETl2PFb03khwSTTbav070UkQvVhNQUxvAEwjUAViERr3p03sFms26LR4xY/zP4c5u9a7y3pe03B1u8VG6SfN6IE3Yng32xdxwLUWyl1UaJpqTZbBJP+oV3wErVz265beqGLN+I4HtYT37BsoMhhPfWy3sfSzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8lIZRoM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8lIZRoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1BAC4CEC5;
	Fri, 18 Oct 2024 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264810;
	bh=5n6NrDNHf6Ja8sTbODF5jff7HURktYBpYt6hKfs7cZM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Z8lIZRoMqDCnFBuf7DrwoRyLaYcYzdMfOHxHFrW5jN9Nl2dcf+e7ixefZ5f++SH0F
	 mpItnfJI9mgIOhajZskcUT2wUld4Fh4SkYxyPo/oFZjPw3MIMYK0dVE8TAjrSs5OQW
	 p0P3+B+vRE/UzfoDg1mx2/oKLvQJ8uwQkIbcurxr+W8f9t53yMoLS/uJVtqzY1t2ES
	 1l5PodraAzc73PTSoogpr2zJc7C05witpCZNI3Ih9LNoIcObuYt5T/jfM6T1q2xDWq
	 BT+PxhQutUaW2gD4zoz/R9ZpgkC70bxywVIKuyeGlj/OY5QTqXMrJbcjdRt5tT19F7
	 ukLTZCX23DcFQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241012141432.877894-1-leo.yan@arm.com>
References: <20241012141432.877894-1-leo.yan@arm.com>
Subject: Re: [PATCH] perf probe: Correct demangled symbols in C++ program
Message-Id: <172926481029.1381973.12262352035936716485.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 08:20:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 12 Oct 2024 15:14:32 +0100, Leo Yan wrote:

> An issue can be observed when probe C++ demangled symbol with steps:
> 
>   # nm test_cpp_mangle | grep print_data
>     0000000000000c94 t _GLOBAL__sub_I__Z10print_datai
>     0000000000000afc T _Z10print_datai
>     0000000000000b38 T _Z10print_dataR5Point
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

