Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0791210C01;
	Wed, 16 Oct 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098763; cv=none; b=V8NiP8fT4tsKrDFtsmPiNyf/m2Y/YixjCEi1P1WeSjKguCL2Yqguv4+o5872Awu1m0p7blgOkLfpdWMjMjkJmRqBKU/U7WhzBVXFLzKgaYxJw/U9Ajuo4v4PUc6yI/N1hFdgDe4RbgWSNvt/v/jvn6gcz4e3cw34zU/XIkmaUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098763; c=relaxed/simple;
	bh=lFQPezS2i4B2u6KpoHCdXtTqSLsp8pf3GFF2tDZvQBM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kN70j1qF4uKBnjaBI/mRjsdprH+pEyN4lmBWVF1KDcTkUCZl4AS3yYkmlZQBDzzHsdol1EaiztTJq6AfE5fUJM7vn/mT6MsAY2Ouhd1nfO9qLNxnCRAFV4GawqERb3CAUXf7L8i/IBsTAMI0x/iEX/F/l7HcUhYRI2465OMQkTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqK7ac09; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqK7ac09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D1DC4CED1;
	Wed, 16 Oct 2024 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729098762;
	bh=lFQPezS2i4B2u6KpoHCdXtTqSLsp8pf3GFF2tDZvQBM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iqK7ac09qcSV2o14tzRzLMFQYHJObD2F5CMfcABKXEG+ztKVjK+zWnUM9b0r50X21
	 EYxWyQAahpkSnbXt1yRRyNkvOfnDoJakqNlMMYC3szdHarJlG+sDtlGCNRFc6bqXVO
	 Pyilw++3uUgzi92AN7ANjXCMUEBV/xmw3SA2Z9NIINo1OkWHjP40EEzNFr0I/4k8ty
	 KSTCOCmxkhN2DSDAiWbqzcXOLc24Io5bGPGt2BnFKGQ0hW8rflOhGFfnC1T79D/U5k
	 eNza3Z9NWohAR/H/bRMwbcpvvfw3+8QVvVukowwsY9yZWR/KqqyJ08PC8uZatxHUzm
	 4LDg5RPZkiQuw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com, 
 Tim Chen <tim.c.chen@linux.intel.com>, 
 linux-perf-users <linux-perf-users@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, 
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20241004170756.18064-1-vineethr@linux.ibm.com>
References: <20241004170756.18064-1-vineethr@linux.ibm.com>
Subject: Re: [PATCH v6] perf sched timehist: Add pre-migration wait time
 option
Message-Id: <172909876202.288721.13527604855301602409.b4-ty@kernel.org>
Date: Wed, 16 Oct 2024 10:12:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 04 Oct 2024 22:37:56 +0530, Madadi Vineeth Reddy wrote:

> pre-migration wait time is the time that a task unnecessarily spends
> on the runqueue of a CPU but doesn't get switched-in there. In terms
> of tracepoints, it is the time between sched:sched_wakeup and
> sched:sched_migrate_task.
> 
> Let's say a task woke up on CPU2, then it got migrated to CPU4 and
> then it's switched-in to CPU4. So, here pre-migration wait time is
> time that it was waiting on runqueue of CPU2 after it is woken up.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

