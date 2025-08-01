Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872E26CE37
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Aug 2025 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069078; cv=none; b=oDvp2rI7o1fnriDI3hw2PIeYvDVFtM6gyGetLfj9ADlbFnwM+hGeZl0MCdzp+2uXHBPqPZf/0sNLXtgzoewb6UJ/ID615EFCsJp1FzlnSZyqtF0pc6b42s05V7PlyORkNv3Tb5V/onCJIW+BDQbq8B6oyhmdger/HBewYgSUm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069078; c=relaxed/simple;
	bh=aTtO0FYF6UGM52izKPP1/dVH32CQjSK7J54mVJQVACU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fTJ1tEVxVMvJ0PB+/2YAypmZp/zw0fGbyGhyjhtp08nod8EQYzXCRiubBlQc44UTd9gbtvgSI0qL2pd9ByaXLUFLvqq4AH3EY9YrLtpbXJVx0wpC/HTmEVBKCIs0Dm4MOuBiSMtGdQKBa9ZiU0VNE3a6Q8vfyEjThRHjZjDRPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2n9OfAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2n9OfAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AF2C4CEF6;
	Fri,  1 Aug 2025 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754069077;
	bh=aTtO0FYF6UGM52izKPP1/dVH32CQjSK7J54mVJQVACU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H2n9OfAAkAsh1OakPea3fcaWzUN2IuxbcEYXsBSpC1n8pHf/hnoQwoymMqAR5+cUN
	 xehwbL7crBYkiRzodzJr4+9CzcBBbFXbrRpSM36HVV+D3nZXLkF/gZpG0cj/ZtQbFc
	 zvVf3MpS9RdGTzDGOCicVTKiZt12gfx6Xtlgt0mUeMytEqYbqMKkiMcO8huPzYCHJg
	 dgaLTVjEQFlecO8rWTl0NfSpEQjrcKixFUm2igQ89ROuMWRjhfJCwweGVimnxVuaye
	 kP9cj0AU6xJb960Q6GfYtGsYWEZM3GVaVAqAlzZrKob6Yy+Qi+8woMk5DpzsbgW2Eg
	 AduZEapkdeVEA==
From: Namhyung Kim <namhyung@kernel.org>
To: adrian.hunter@intel.com, irogers@google.com, tmricht@linux.ibm.com, 
 Jan Polensky <japo@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20250725170801.3176678-1-japo@linux.ibm.com>
References: <20250725170801.3176678-1-japo@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] perf test: Ensure lock contention using pipe
 mode
Message-Id: <175406907709.1475083.17801198661164581409.b4-ty@kernel.org>
Date: Fri, 01 Aug 2025 10:24:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 25 Jul 2025 19:08:01 +0200, Jan Polensky wrote:
> The 'kernel lock contention analysis test' requires reliable triggering
> of lock contention. On some systems, previous benchmark calls failed to
> generate sufficient contention due to low system activity or resource
> limits.
> 
> This patch adds the -p (pipe) option to all calls of perf bench sched
> messaging, ensuring consistent lock contention without relying on
> socket-based communication.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


