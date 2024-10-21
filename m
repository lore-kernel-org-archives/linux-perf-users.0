Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F211D5ABA;
	Mon, 21 Oct 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526505; cv=none; b=FNgDY+cxdje/jHFe+hN96pJf4fpwIGkNRByHm4D4Ei9tv6mKaP0PJDsToVJdxpsTDIGkxzN4Vu6FTGnlgnchdta8YIQJ8HY4boLTg5k2M6LRR2nG+qijtsmbik8SzIALLTIW4rY+0BtzusX+cj4OAdUYlf3EXM+akZPDsehSjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526505; c=relaxed/simple;
	bh=+mYM+Gz8k2rxf9vmX5CHZ927K8o2lDQPIO2MrE/TqoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CVDn3jkojJpLd8aqnd2GynlPUr9ZD2CUUJ5UOSBQtGJTHD+oMCg5Uxr+ur50Jt+bkOehKiWwPHB3hF7IPFHzw07PvtmqYsdGuzHx/azPcombmbhYg0YjHagUn9LHYcF9PQS3Hr6BG6XqYbIbxZVuz5811Qf1fQ1QQ7XiO37qAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeBkItyc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeBkItyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7971C4CEE6;
	Mon, 21 Oct 2024 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729526505;
	bh=+mYM+Gz8k2rxf9vmX5CHZ927K8o2lDQPIO2MrE/TqoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XeBkItyccQUt4LAe/wv5poScQk7AGpxffVT+QkJ9FCZEM8vJ3CR0tClnz3QztcFJx
	 TCphqMB/AjPBlPaBbk9PK4n7ScOrYHPk2+vFjsSFXE+2GzuGZw5tduv5sVmCRN4Cz5
	 btJx/3pbmDcyHjHoIXnvS9ne3MA0j8gEuk0Pc0Vyr/ZZaUNSwHe7dJnCT8gk/tE492
	 7BjI4Mf/P5ddbnI6divjTTvEv3JJiAUEtOfTVPlNsgErnbsalDEzLY/2DKXWmbFkU7
	 X+h66PoJDgExwNm3Li99LjJgkI4wo1CH7mG3q3HFsowluOV1xLelzi8fctpful6Z7x
	 pzZby5T9IDvnA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sandipan Das <sandipan.das@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, eranian@google.com, 
 ravi.bangoria@amd.com, ananth.narayan@amd.com
In-Reply-To: <cover.1729242778.git.sandipan.das@amd.com>
References: <cover.1729242778.git.sandipan.das@amd.com>
Subject: Re: [PATCH 0/3] perf vendor events amd: Add more Zen 5 events and
 metrics
Message-Id: <172952650471.3574386.17747155626378590525.b4-ty@kernel.org>
Date: Mon, 21 Oct 2024 09:01:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 18 Oct 2024 15:01:02 +0530, Sandipan Das wrote:

> Add data fabric events and metrics taken from the now released Processor
> Programming Reference (PPR) for AMD Family 1Ah Model 02h Revision C1
> Processors document available at the link below.
> https://bugzilla.kernel.org/attachment.cgi?id=307010
> 
> While at it, also update some missing or redundant data cache metrics.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

