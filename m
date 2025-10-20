Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814822F16E;
	Mon, 20 Oct 2025 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926324; cv=none; b=ScmGJatFLVKGla2ZW/pLLfPtTIHXCgBlTTj4ogsddbixEBd+QBo44W5Av4fIONPnFIS6Hr6urmTnXsn79e8xhu2OSczs/BHLY0J2N4GMk/gwhww+4nOcEkWQoEkLJO7qnk8fy4bMvDEgXs4l62ekmy0vuSQOfN+gZRSgX/R2Pe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926324; c=relaxed/simple;
	bh=H7xYtioKAwN2ukIQqQhuiVR7ZlhAKwViyl3BipqF3/Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nXLGa0tYQ76ebbspXUqTkNUg1Q1Eho+pIUSkpv5uE1muRJVKRjFLc9lsvqYoRnRc3avla0+7OmworFcFhOTls4dEK9MUi+ZdPnGqAooNo3blmNyiK6GOC98Uqxc2/U/N9S8sz9f/9GDX+ahFFvPZhAM9Wc5hNkwUkUDe6u5fkdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grLJdnwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grLJdnwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0A4C4CEF1;
	Mon, 20 Oct 2025 02:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760926324;
	bh=H7xYtioKAwN2ukIQqQhuiVR7ZlhAKwViyl3BipqF3/Q=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=grLJdnwq79xsApmPsTflwrarVX0pOc7dS+zWzv6fJQaBJpXpkpmG/Pt/ziq1DrVgl
	 EMStfeFvEIEK2y0eF5zbrxIU5jpGcTxq1r0wjGyz7wG/YSTcePxiua+rh2nvolMnJl
	 TtkvoM/Xloqi46Uyz2AAGBRiWZEyQtVbMMj9BWq8ThnSzAItNnYsW9j0eWger/kQuj
	 VTiZKX4a9cbDmu4xExcR6aGS4JQRljLCvNhbti+cqi2c7NqtY0hCTvhlXxY0C6uvk3
	 1EJBfG9ALYdQBXunvhZG3IIBnEZiScERHyuKn6y0CFrl3DDDeI/lFYUBEVTlLe5jVx
	 ItkqiJCrjOJ6A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Howard Chu <howardchu95@gmail.com>, Gautam Menghani <gautam@linux.ibm.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251016222228.2926870-1-irogers@google.com>
References: <20251016222228.2926870-1-irogers@google.com>
Subject: Re: [PATCH v1 1/3] perf ilist: Don't display deprecated events
Message-Id: <176092632104.143093.4764121806345268425.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 11:12:01 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 16 Oct 2025 15:22:26 -0700, Ian Rogers wrote:

> Unsupported legacy events are flagged as deprecated. Don't display
> these events in ilist as they won't open and there are over 1,000
> legacy cache events.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

