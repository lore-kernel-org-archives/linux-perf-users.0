Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC0319859;
	Fri, 15 Aug 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267005; cv=none; b=a/2aW1mP05QFsTxu1MLmWKYHIzku9ykZXldUwFueIdPcgXOlexOldZ3xyBVJopq0PhjzAJE0M7F/GRYbmQjkMAABCm1JnweQViUs8oHcHTSPRMtzXJeRy/W6/C46t95nS2gA5DP1/yq66R/QToTfdS23Npz2sq+mF1RJy8n0n+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267005; c=relaxed/simple;
	bh=YmKH84EwYlWyvglZ0E6KkIMMGOfXntho70s2uDfFmwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvwdDSZH9LXUfGiUhcLPS/l8CAfSFI4oZ6EwXD/Ns8KMYkcsRm6jnEf8hd59QoJpjFbl04akmleERKLPaRM3F6Iv+HbBTy5mJyjEY7jm8HeeljuuRH+xXRNCW6qfEWVyuuwb9ZWFJ9qK6FITdN+oPLy6QOa8v79ntM7sC5LW3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076C5C4CEEB;
	Fri, 15 Aug 2025 14:10:00 +0000 (UTC)
Date: Fri, 15 Aug 2025 15:09:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] uprobes: uprobe_warn should use passed task
Message-ID: <aJ8_tj3Y-nDh60_2@arm.com>
References: <20250811141010.741989-1-jeremy.linton@arm.com>
 <20250811141010.741989-8-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811141010.741989-8-jeremy.linton@arm.com>

On Mon, Aug 11, 2025 at 09:10:10AM -0500, Jeremy Linton wrote:
> uprobe_warn() is passed a task structure, yet its using current. For
> the most part this shouldn't matter, but since a task structure is
> provided, lets use it.
> 
> Fixes: 248d3a7b2f10 ("uprobes: Change uprobe_copy_process() to dup return_instances")
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
