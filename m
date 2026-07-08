Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E137C900
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783538744; cv=none; b=km5N/Jq0OoiDjtw4NxwYl923NYOjLLrA1eqNJWcXqh5hLQgli0Acow+Dr2ETkTg3f2Hc8WkmMtck0q6kL+kycy0vNulIoF5Ng3vCbQ7bH2jMY87j5+qMkkxCHDJ2DZpy03y0iFizdevnvVZ+ntka96urydbPlZHslv07z5IPTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783538744; c=relaxed/simple;
	bh=6piyt5i8Ixcybl8fjjFPf+MEJVSZvrKECzuyziKDZvQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JRMQ3d8FSBtB68NdgAtSE/fT1A1cmoJ8TZbnDxmOOhaXO2ChFBF9T1Xm/4CA+89K7r76+CNF6vU0aOmsovlxsPXlSsFy8kHcJtJpmuPeBHe6+gKHZr0wwJk4lhFhtO+fwxeknNU54i1Qi9MUbJ/z51vnBh8dLM8MtZCkc8TsO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mULnlvx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mULnlvx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB31F00A3D;
	Wed,  8 Jul 2026 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783538743;
	bh=EE4vI/piTDLsoauUfA6gjJmO0J2gvrIIdPjhWXkf7NM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mULnlvx0Cqt+mQYewMLD8bqRaMo7PRiALU5WRJDaEEE1yAoKxTBi8Q8e0xLtgYN/L
	 UoWmwEkQ5zK9gzJxtH3Fi6wUYjxRPTPjB/1l2hQqBL/U+dz74edl16xhMQ3/gDCMGs
	 Vl70Gv1EUNURnRE5tZAd5qhWhtTCZM/VPOlYccRGsSfCM9PU5ycvmcJQLpvsZLQKyJ
	 vPwDsNYyfoVRywNYRpvAu6CRVb9DLhL0aQe7S3vBqV+qA+yOUjSEup7JeIsLnw/oTA
	 NrAaYUyulxRXuyzRVisyqp66zq9Kk4fpZiBtpClir2xtqq68/gEHy5+ZsSW6KwO/96
	 /4hJJrtNUzF8Q==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
 maddy@linux.ibm.com, irogers@google.com, 
 Tanushree Shah <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com, 
 Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
In-Reply-To: <20260604065519.112101-1-tshah@linux.ibm.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-Id: <178353874278.478719.17250628813855454145.b4-ty@kernel.org>
Date: Wed, 08 Jul 2026 12:25:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 04 Jun 2026 12:25:19 +0530, Tanushree Shah wrote:
> Unlike the in-kernel trace_seq which uses a statically allocated buffer,
> the userspace traceevent library's trace_seq uses a dynamically allocated
> one. Therefore, every trace_seq_init() call must be paired with a
> trace_seq_destroy(), otherwise it produces a memory leak.
> 
> In process_sample_event(), a trace_seq is initialized for each field when
> formatting tracepoint raw_data, but the matching trace_seq_destroy() is
> never called, leaking memory for every field of every sample processed.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


