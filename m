Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF21E0B6F;
	Thu, 24 Oct 2024 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784963; cv=none; b=uPdrGwKJ4Ft6+TmIDjI7Hi/jG4BfootllNO9VnSUtALQCjcNiB4JDBPGZqJIZiv01WdSwzva5nL+W5+vvy3+RvEupTzhn6EadOmedLHoyV3TUdS0uRha4qMFe1JR4OLcIbVStpcTqlweb3XVYcTFG9mMvVkCdSeiHpxZahE8sc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784963; c=relaxed/simple;
	bh=tSDiaGs015fBwkfKHW/8d8S5f2RZnf7UcuNKNm0G8Pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a6a7nl8+qGF3Xxq+uXw6e6XtxP3TISM5yFhkyw5qkY/Lw3BYH/iuJMdylUQ5W22Oo8TdpG+bfL7Mi3Ce7XhYOvyvqgNyB0HJ9lRPIH6RuYwfyszDBQlAk6jb8Fr3FlGx+NPxe/8b/5pkFxMB9Cnk2WuluBw9jwlDhpL4BsG3eoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwobu3Wj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwobu3Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3DAC4CEC7;
	Thu, 24 Oct 2024 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729784963;
	bh=tSDiaGs015fBwkfKHW/8d8S5f2RZnf7UcuNKNm0G8Pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dwobu3WjL3catldbJQnLHn1GiD6TWxi15mKRZR+NgM0UbyHLhPLwWFh6ukQNwuENL
	 Wg6bprKDB6ENgrvxlrLDUD4b8nNyU/w+7SNOMCHJ0fz7AIV6C3ZZ5CIBFNORzikdl/
	 lewhP2cuaeZd7bVsob/M+0chzW9ibyxaXEhAM++KGRzAw6c0Btg5z6ICyneuyXLQ9t
	 7Y3sQwIWajrbo4AvrcYqVjbwFF4dwtiih007+ZVE83EZ5dWSPet9vLpmsz+QiUdlGK
	 yGretpLmJA571WFuf6c9uccFGXmeFhG4tYq7z+D/a3VAoYQscY20wDApeG8vXxt9wo
	 Er5Qi4M/FvYGQ==
From: Namhyung Kim <namhyung@kernel.org>
To: atrajeev@linux.vnet.ibm.com, Li Huafei <lihuafei1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 kjain@linux.ibm.com, sesse@google.com, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241019154157.282038-1-lihuafei1@huawei.com>
References: <20241019154157.282038-1-lihuafei1@huawei.com>
Subject: Re: [PATCH v2 1/3] perf disasm: Use disasm_line__free() to
 properly free disasm_line
Message-Id: <172978496264.1768468.6399631328468888557.b4-ty@kernel.org>
Date: Thu, 24 Oct 2024 08:49:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 19 Oct 2024 23:41:55 +0800, Li Huafei wrote:

> The structure disasm_line contains members that require dynamically
> allocated memory and need to be freed correctly using
> disasm_line__free().
> 
> This patch fixes the incorrect release in
> symbol__disassemble_capstone().
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

