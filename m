Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81900482CD;
	Wed, 12 Feb 2025 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324342; cv=none; b=f2gSFg3D6d50em7UcvO7on2G+QK9rddR4Kpjl24CGrd4lwK3BBaRfhtFjXj7zuK0NO6p46AKO1vLTfJ1WH6HrP2Qcjv7SpZGc6QGAdNiwm4fjfXyBJ66Lj/P9nhYaPMNLk3QEZfPSFdf0JZpm/7QUTvvsQ7TbiJQNx4FvtZnotE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324342; c=relaxed/simple;
	bh=0Ur8N3QKft5uRL9cE17RDqaL1JkZH1+vrIr9mtKlHAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ij7a2uZxqw2JhIj4ufqzH4A0xo+o1Or5SrYWuJSq5TxUUtxzRlc2qIFdZ4avydwf4IF6NdKsK8LxSLxM70dnyd/JJ+SfirGY2CYUz9zNq9z3yrqLG6yZ4VrzLCFHlfk4yRC0KFUHmVjv72xriVMBwUwD+HMan/yaw8ixld1J1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBj4RjM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBj4RjM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7099C4CEE8;
	Wed, 12 Feb 2025 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739324342;
	bh=0Ur8N3QKft5uRL9cE17RDqaL1JkZH1+vrIr9mtKlHAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sBj4RjM0656qaRERxWqUJlfkwVlkibNUcAVFUZvBSLWjX1pS7V8ubObE2vU68kEf4
	 1nSkjwGdu4wssOyQGz8bhAeFavTwPdsnJyLnVgD3ep/Y1cJKiyii6X6GxSCd3PoaTb
	 7B/ONwRUBH6Sb4JeG3vzKL/6KxXvsjBJat5Y5T5b9Gb+GTtnzpQz87tyTQqWvFfGdD
	 3IRxlvEPCdTG+oIFQ9T3+j4FLsZDHfV/i0Riiwh13XBhi3ALFCDdPKS7ZTGaKQFusJ
	 et5edmXkE1Dg2Lo0uwWfIcGoaTwHhuKzBaaIakChp9qf+C9d1ADhFNSGC5d7w2Tg/P
	 vpywD94FPm8Qw==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, peterz@infradead.org, mingo@redhat.com, 
 acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 linux@treblig.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204220545.456435-1-linux@treblig.org>
References: <20250204220545.456435-1-linux@treblig.org>
Subject: Re: [PATCH] perf: Deadcode removal
Message-Id: <173932434164.264355.7571195196642562862.b4-ty@kernel.org>
Date: Tue, 11 Feb 2025 17:39:01 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 04 Feb 2025 22:05:45 +0000, linux@treblig.org wrote:
> The last use of machine__fprintf_vmlinux_path() was removed in 2011 by
> commit ab81f3fd350c ("perf top: Reuse the 'report' hist_entry/hists
> classes")
> 
> mmap_cpu_mask__duplicate() was added in 2021 by
> commit 6bd006c6eb7f ("perf mmap: Introduce mmap_cpu_mask__duplicate()")
> but hasn't been used since.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


