Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA724AEE0;
	Tue, 29 Oct 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226228; cv=none; b=j90405/e3zZSvigzJPLWiv9uuKbUBT6QkZbRBeysVJERjGB2Y/SKvbVAbrJWwT8vQ8YM+rXcs/A0Oena40X0idSVTS3Ke7Ut3B52k+0nKgjnrXKU26CeoNafuoMZzloyjNlkQRWRIQmFCPF9GKdsRoW/SstTsZMVOJu6ARFxuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226228; c=relaxed/simple;
	bh=vfctqJoadOj4Uk/e3YVcbSo7RUdgyucoANUBHx7MvB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXNeHrM9ZqgStZiz2kwOQ1i37OtuRm5qTP4izg/Hf4jwy0ZktRt5ZXGzetPTc115iSserJcXf8CrzIXtx8nCxum+RE8ylp4ImCbLW/ylxUGxFGsjDPX/gCxBScWDJ5SMK24dyJhedIBSQbVpuYSUYMvKg8O340Z0KESQ022hDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPLO+D8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPLO+D8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D60C4CECD;
	Tue, 29 Oct 2024 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226227;
	bh=vfctqJoadOj4Uk/e3YVcbSo7RUdgyucoANUBHx7MvB0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SPLO+D8kRn6rgF4ee8+Rfi2PyoU2ANM5jdv09I/GWxRi3jpAXJdhxgYw43i0NUb3k
	 xAGEBjWf3Ii2nYR9xuCwRlxuk0+EyMdvzbCfQXBXMfsgMjImWQtTpb5Ge1xIm4forJ
	 Vp7eoLK2dTIZkoLKYBVBif05wWAIxggcYDaP7J+385KAw+MduCQaKPK5F21TSfyaUx
	 MGi/ZOMMwxqQpOzm8DYy/0rRCmVfwL0chh4o9GXq/LLdv/pe/5M0JvcRUDcv2/8sgU
	 wR8CNpgMrqSkHizivYf2NM7ahsU6LBVPmZ5lPf/EExAaG6JhToMWq0WESODkYrM3ky
	 MTPohAijV2+IA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v5 00/10] Run tests in parallel showing number of tests running
Date: Tue, 29 Oct 2024 11:23:43 -0700
Message-ID: <173022620957.677155.18320930793472494703.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
References: <20241025192109.132482-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 25 Oct 2024 12:20:59 -0700, Ian Rogers wrote:

> Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
> to read them for display. When running on a color terminal, display
> the number of running tests (1 if sequential). To avoid previous
> flicker, only delete and refresh the display line when it changes. An
> earlier version of this code is here:
> https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com/
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
