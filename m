Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4B166F23;
	Fri, 27 Sep 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456447; cv=none; b=dMKJsT0zPQIzwMPyr609zHj5VI6jc/aSdTI2Wz+VRwHWpNF5SyBUiujjZ5I1kijsJk1wiBlp7f2/vEjQerqoB/BdWCGhqPoUcBqSXthPAaLyqegM3MARVYrLZ3cCjkxmAe8tzMHp+KxlBlIg1Mhld4WLULKOFJqDlIztWoWOfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456447; c=relaxed/simple;
	bh=HnRVvdl2aAbwT0oFFIOZ7w76FvQosjDiVk1tz/KPo58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eH373MblhN+UD30xpNjKlF7gy8iprTnk+EaabWeePY+nRVyJ9ZjVN/IHL9FoV0SzAuwlO+wVow5rY9Zc0a+uaJ+AXwLDylN1PCRnwrt60f/0dENJcBulIxZ9RHjByNcs/FSZuXM557XG088rs5P3elBCwmgWFEe2zX/jp91KAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRIRBYBR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRIRBYBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE16CC4CEC4;
	Fri, 27 Sep 2024 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727456447;
	bh=HnRVvdl2aAbwT0oFFIOZ7w76FvQosjDiVk1tz/KPo58=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PRIRBYBRHl9/xZPJ+5vkeFKD9l+iyl4k7W4jwems6/UIEoHFZkMYQwY4EzyvoXNZ+
	 80mp/9ERToeRe31yLFFm/1LOkxHg0cR9E8kGaMy5Yiu8V2D8w4GxQsaHI8Xn2olOQS
	 lPPgZSOrjGGVbieIlRBZDXr68czZGF3/IrHnc16T6m2bQEC6uC0etcrt7jbLvB3bqQ
	 w9voRFcrfJQr/rbWjImKrHKj2o17L5zFiH8+u9nms8byMgMY5S55ISmRXo9Dn2FAa4
	 sZJq2kMoRHW9Nj8nj6RBJZGAEd2MWt8nQO459g/Z+CBThjPll44JyZRSD662gGovBT
	 r9ME/aC4k8FFA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	acme@redhat.com,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH] perf sched replay: Remove unused parts of the code
Date: Fri, 27 Sep 2024 10:00:44 -0700
Message-ID: <172745643154.248797.14825087652419796856.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240917090100.42783-1-vineethr@linux.ibm.com>
References: <20240917090100.42783-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 17 Sep 2024 14:31:00 +0530, Madadi Vineeth Reddy wrote:

> The sleep_sem semaphore and the specific_wait field (member of sched_atom)
> are initialized but not used anywhere in the code, so this patch removes
> them.
> 
> The SCHED_EVENT_MIGRATION case in perf_sched__process_event() is currently
> not used and is also removed.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
