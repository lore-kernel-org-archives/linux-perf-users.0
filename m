Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF01DAC9C;
	Tue,  5 Nov 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824901; cv=none; b=cmdM4/1Xl2dNzjL+0fhoHsX0tw/d3OhIHFyN60D4kxuxdOENVgL2CiFdxIrWkxwNlxD5gPvwPmbBO20U4cDmgUFAjOtKbkaNHlJXMGeTNYQMd5a1wxaNPnQLf41Vh+y2iDoxrSGPxJxhLpdcSPFOelGy/pPRLCL755obUWT7hn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824901; c=relaxed/simple;
	bh=huzjT5JLAbdXJL39b8UFkSas8RwAXCriFRg4uuS1oQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BRwnID9Pq9OjjByA0ru2h7Qzeh1ortMTBp8zyVjwiKkjkwfGj/71XJ2iKI+m1dB4vbzqKHIhftRrvMcRfW5f6xQgedzFOBRFWlKEpkOQsGoQQxReuUor0OZeNyaThkvg3+ITiWjx0ZfWE8Vt5h7hQcAZpRWdDRjVJMEeF8SMBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVDlh7K2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVDlh7K2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BCDC4CED7;
	Tue,  5 Nov 2024 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824901;
	bh=huzjT5JLAbdXJL39b8UFkSas8RwAXCriFRg4uuS1oQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EVDlh7K2Bb9mlboDjyCCsLgGjdwRi6DsRyZNEozHIir6PN90CwaERe9JEsDCFBoHZ
	 84POk98VNrkRMxZvzVGao+DejphvhKT1bFodm/EQ+87fDpCBEuSYt1sjmpJerOAHoy
	 mM3fuIp5D7mIlgnmL5MAGSZSIeuFfXI/Bq5rLqxJKF0Qy/yMLAUm5oVMoeRz7/QVPZ
	 qGiMutcY4CrZyYlV2ISOnfihd6b6ko+l6t+1/SL2AHVeK8W4wwGoqB5hwSkskq2vio
	 Cg382KwU3ybmWlJdfJDOYZLGgurETUAbHV4lUcd82DQDpr0DlbASmP7ekDsV3GUIqT
	 /FfveTjlCEotA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104-shellcheck_gitignore-v1-1-ffc179f57dc9@rivosinc.com>
References: <20241104-shellcheck_gitignore-v1-1-ffc179f57dc9@rivosinc.com>
Subject: Re: [PATCH] perf: Add all shellcheck_log to gitignore
Message-Id: <173082490077.149345.18139380841551734980.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 08:41:40 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 04 Nov 2024 13:19:15 -0800, Charlie Jenkins wrote:

> Instead of adding specific shellcheck_log files to the gitignore, add
> all of them to prevent these files from cluttering the git status.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

