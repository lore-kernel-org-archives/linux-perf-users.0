Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F7225797;
	Thu,  5 Dec 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424966; cv=none; b=V9GpObbE+a6r0gwr4ygOEMHYltJaAKPYABqIeQ9nZKJ8vgnKSqWdynP0IdBR/0OTJ3KF0zSu9L63OsobcUSNfLtcIiZbzRTlbsn3lYcb/K0UOw0RQUcRBJUy24o/7xDTQLUOWiRDy97rekIMog8UxDbY9uu+e4C2WLHdgQT3Hkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424966; c=relaxed/simple;
	bh=R0piUA6Ql4U7LuIdiU6vk6h/TjapFsHtz90WkvOjnUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rkr6PXlj8yHAXqss8c7z5lMBa9JSTrL1VuWKvwrgH/cIL3DIn0s1F1IVJzYOLsX0zhapB8q1I+JS17Crx4R+rBKH9OsnWXOKPLUStUErAMUEJKrXf4867l+F8LmI4GbkN7CxDouUIyzp8TCUiy0jUox2lVEZH6FIjx6YvsIpAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsEt50Nf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsEt50Nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801EAC4CED1;
	Thu,  5 Dec 2024 18:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733424965;
	bh=R0piUA6Ql4U7LuIdiU6vk6h/TjapFsHtz90WkvOjnUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qsEt50NfREElfAOSBKlCr3LNp277/m4KGKIeSCefbCk+ChEPlJTCWnBXqdf68JDc8
	 SA5811itnGjqujfUSDrK9Clg8ZvvQFp4WJ67TxXLkxt2a89beqzWhzKPjMvNDhQ3PM
	 4aTtTL0VCPgTerlDSEGEVvhjDu56hoyTl0VbZ6FMsfVLmNBG1vXbnyVN5ftmcFEzvE
	 1vjtjgVvaxyfJroh1/+YLO9zUBTXM6tlaJB+hsN9/XJL4Awap9FLd0vIUwsZWd0XTF
	 c2kIJ1u59n87zUNoxXsECoUyMGYjEbyWG73ecZLiJRxpXAJb24SxIB2OvLwYXkF3n7
	 WIYrMp6Dwp5Fg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
References: <20241203035349.1901262-1-namhyung@kernel.org>
Subject: Re: [PATCHSET 00/11] perf tools: Sync tools and kernel headers for
 v6.13
Message-Id: <173342496549.3925173.1989664809135399297.b4-ty@kernel.org>
Date: Thu, 05 Dec 2024 10:56:05 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 02 Dec 2024 19:53:38 -0800, Namhyung Kim wrote:

> I'll carry these changes on the perf tools tree to update perf tools to
> understand new syscalls and parameters.  You can refer to README file in
> the tools/include/uapi directory why it's needed.
> 
> Thanks,
> Namhyung
> 
> [...]

Applied to perf-tools, thanks!

Best regards,
Namhyung

