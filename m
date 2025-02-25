Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EF212B23;
	Tue, 25 Feb 2025 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520692; cv=none; b=JnHRgIurty6kzhK6GJP+/o/6bynZ6PDA2rs8GIhEV8Eq4vU9epnlfsop8wZoBouw/cDsvXFDDRaXAwMazdWjdBsLI7B/l4zHMGD7NA+Q6cj2NIi6hRNmsgKtdhOSGs00xSBYnlfmx6mhoG3v39fhirMRFjKxBsYxC3wXW+r0i1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520692; c=relaxed/simple;
	bh=E1yz8fImRp3CFvzcmAT4zotbx3IDjbmiRrxi57n9SRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rA94QvS5oXnaS+uTYHxBTdUyZUaebiVX2mMyyNoEPCWNY2gtwVFevs50HQSOaUiUjCbuZdAksTCmoT7uTgbbXp8pu+C6WDXCg0J/QcBV50MbXI3VOkwLFMQvPVoqA+5BoE4H+YCECbdXwb7KRDAcUZz3Xw5ywUkBBT/jOUYYhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn9UObfL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn9UObfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF32BC4CEEA;
	Tue, 25 Feb 2025 21:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740520692;
	bh=E1yz8fImRp3CFvzcmAT4zotbx3IDjbmiRrxi57n9SRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fn9UObfLAoI1kyeIypZkb6h8sUNRgnHgmNkWR3WcDnnzMdg1i6LzxF3cylaJTcK6O
	 k1zOi24oPl6mIlq7SveHtLF6+TA86Pm4V3Bw8jkWeQ1oEXdHSHbbvQaMnFMbK3ecHx
	 KZYnWlRSzXaUoXEALarkVqKHwMFmEssxJGKbxDwQbNfzKc/95LN6VaLw3z4xyUGsbr
	 r3uK4N8xfWpfwuaXWxnmdqhIY8FcbO+EuBKhVDkjO8TzJlZE399AXC6DNYqxfvUD2r
	 3AbOSGurSxRznBIOg/mOnUEGZGD/Kg3xeG7knllJEs6Q88e21K+XFVHliu0o7L2cqO
	 InLB1MPM2ou3Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250220045942.114965-1-thomas.falcon@intel.com>
References: <20250220045942.114965-1-thomas.falcon@intel.com>
Subject: Re: [PATCH v2] perf report: Fix sample number stats for branch
 entry mode
Message-Id: <174052069174.518612.379734848391631109.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 13:58:11 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Feb 2025 22:59:42 -0600, Thomas Falcon wrote:
> Currently, stats->nr_samples is incremented per entry in the branch stack
> instead of per sample taken. As a result, statistics of samples taken
> during perf record in --branch-filter or --branch-any mode does not
> seem correct. Instead call hists__inc_nr_samples() for each sample taken
> instead of for each entry in the branch stack.
> 
> Before:
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


