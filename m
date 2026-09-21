Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5746AA95;
	Mon, 21 Sep 2026 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982504; cv=none; b=D1NoE5VaOS6FtGVH7uI7/qmEfkCoGCXDfvIehSktf9+k5/8w3dsJx7XQkl25UAAHbKQ79SKCsBW8ipBnU0Lu2WLq3WWL53EoPkfRE/9ZdJyvdnGI2Pxv+YsQj+Mj0444HeD5WX64vVIHhunrkpVEfOFuLNbX8wTa8sS+ngSVsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982504; c=relaxed/simple;
	bh=6TXcVd6Q7vpkgS2k7WfA5h3gSaKVOaGLRqQoTQSMvQk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Kze0VGfxkV1bHM5j8aQV543JBOXwj/ygxZm9I9ltg7GAiq3TRXEpPLlM4iapF8/GGw1b346mpJr6d8frAnSDEhvYF2GTm6L0ctKeOF7J0BUlcGijHVgsWxBlSRg/l/eVYAO43ZFS+rX5peImodsXDvBJPqDDlbo9i0M2DBkCIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTpaMZy0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTpaMZy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E361F00899;
	Mon, 21 Sep 2026 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982503;
	bh=sbAQCh/iiIl8wM8S6UzeolT9aKBn1Y3lk+yQsVY3/qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fTpaMZy0a0En7sv3Bmy7pEMZwkJNLJM7DVu8dbUDe2G1qo6cEHhwpFBje7rrklyq/
	 0lYnTtmQvYk9HmlSEidrSD6CqG+FSiSrU2txwhEnI0iCyjZAW5yfObMondgJzFTedt
	 jgiQXAq7fVkuT47pvITGA7QnoohmYF0y24KS60DiRsLdlyvo6HmEaKZEVPLY4O/vjz
	 6+BPCIcKBCeWetRRlJqK79qb5xLfDJczOWCCZpnVF+AS5ovfqY6KoifNlJdlpvTUrG
	 zUUV+7Biipl7NCwAWAJLVl6Q7yjgBvwwtKxM7HHu8rMN9BuGDO6/VDK98Q3YiI8tlE
	 Eq9FLv2NgV3aw==
Date: Mon, 21 Sep 2026 18:21:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v16 08/13] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20260921182134.e21fc14f88cd4c5946d80fab@kernel.org>
In-Reply-To: <20260914143011.81BA81F000FF@smtp.kernel.org>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
	<178939027201.94750.11818590613347692117.stgit@devnote2>
	<20260914143011.81BA81F000FF@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 14:30:11 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unhandled error from `echo 1 > enable` causes false test failure under `set -e` when hardware watchpoints are unsupported.
> --
> 
> commit 70eb02867fbc0203498e0161a5c4b437b562d025
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> selftests: tracing: Add a basic testcase for wprobe
> 
> Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> tests adding and removing operations of the wprobe event.
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
> > new file mode 100644
> > index 0000000000000..647c37d5e4c84
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
> 
> [ ... ]
> 
> > +if [ ! -d events/wprobes/my_wprobe ]; then
> > +    echo "Failed to create wprobe event directory"
> > +    exit_fail
> > +fi
> > +
> > +echo 1 > events/wprobes/my_wprobe/enable
> 
> [Severity: Medium]
> Will this script falsely report a failure if hardware watchpoints are
> exhausted or unsupported on the platform?
> 
> Writing to the enable file triggers enable_trace_wprobe() and eventually
> register_wide_hw_breakpoint(), which allocates physical hardware debug
> registers. If this allocation fails (e.g., returning -ENOSPC or -EOPNOTSUPP),
> the echo command will return a non-zero exit status.
> 
> Because ftracetest runs test scripts with 'set -e' (errexit) active, this
> error will abort the script immediately and fail the test instead of safely
> skipping it.
> 
> Should this write be guarded with something like "|| exit_unsupported" to
> handle expected hardware limitations?

Hmm, this is not unsupported, but unresolved (environmental test
failure case).

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
