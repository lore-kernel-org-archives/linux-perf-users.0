Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBB1CDFCA;
	Tue,  2 Dec 2025 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764648543; cv=none; b=gpgKFmrNhZBjBpdFch8/N8FliD6Z48sSGGQWFHP7vM+GNo1K2AquBImklKO827Xy8PBUIiCIhpsbA+/CttXimt7/TnhzOiGYvymV4sq9hPMMyhrSXPMpPbqMajiRfEJjOesYUSWFOfSaIzjts6CnCWR19DUXlBN2eYOwAbV8b9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764648543; c=relaxed/simple;
	bh=lJU4iAMBDJPly0fu2iYAMPafOxIswHhX2uqpoF2VWTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LKSWus/2x3QJA1ZRFOEdIVtJj7anPc2EIfR1onZubJreislnfgx9ttuCsC/QoSABrRmdZ6o5ldnnRQ8RkLusfkfZ0D6m3MQfMbr7zQRiqaAcWoyE0lpAZYQMZMZhuXG3Gf/BM3qYVV7cYizazoEHpeZZpEg907OiPmPh9rV7H9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYsgitdh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYsgitdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A2AC4CEF1;
	Tue,  2 Dec 2025 04:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764648543;
	bh=lJU4iAMBDJPly0fu2iYAMPafOxIswHhX2uqpoF2VWTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QYsgitdhDO+i6Sghn8do4DBPkWUzQF++m7kiEGYnhbaNVr/QoounXaKB8F3av45pY
	 Ne8MEszr5BA+umCUvAJZ1f84E37wGc8W94tjmLLcSiP8l5Uvs1Xc94uV2vGlpjFWGC
	 Plvj8e5ZNOrzgVM618eLm4qTxXmx6p4KciU8av4KG6LshzBkZa23Mbx9Ckysd10MB7
	 t2bc0uqY7IAydq7ICietjp8fJ5t9ADOh7QTX/gaQBB7KXJJ+QhO0a/m1xyTnzG5awa
	 DKOhZBMM483Cj2khq24zPqZe2pMVLx4zwfR+Qp5+Vps044jHkLYeIiy4a0V/Tb9oh3
	 DuY6cNkarRl3g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Thomas Richter <tmricht@linux.ibm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Howard Chu <howardchu95@gmail.com>
In-Reply-To: <20251127044418.677379-1-namhyung@kernel.org>
References: <20251127044418.677379-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf trace: Skip internal syscall arguments
Message-Id: <176464854211.2315719.6618938787898740617.b4-ty@kernel.org>
Date: Mon, 01 Dec 2025 20:09:02 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 26 Nov 2025 20:44:18 -0800, Namhyung Kim wrote:
> Recent changes in the linux-next kernel will add new field for syscalls
> to have contents in the userspace like below.
> 
>   # cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
>   name: sys_enter_write
>   ID: 758
>   format:
>           field:unsigned short common_type;       offset:0;       size:2; signed:0;
>           field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>           field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>           field:int common_pid;   offset:4;       size:4; signed:1;
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


