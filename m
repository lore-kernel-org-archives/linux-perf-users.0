Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5849E3537FD;
	Sun,  6 Sep 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709406; cv=none; b=Gg+Dk7D8BrKH9EkU1zFDRJGBq709q8oJ0FhPCq/CtvnCj6PQcGbLrBLcT1Qs4/qZeqim6zeKG7pHzdzWvgwdfQoGLKhdEyF9taoysXOAP1syagN4q0i9jeAMXB6uYw9Lylfo2b2Kj0zK38zZEpSshS2Usq5hgJT9DCEG4fXFc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709406; c=relaxed/simple;
	bh=DYm0pav8hBYXXiKG7Shp3j+knBaUCszPeiWoYZ04vWE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SNWnF+6KXx5AdvvQhnH18LYCYUnQgVhDYj6idJL6sjgIxumhQVylpDHhDC+LhpEN+zE7QV1E/okcxsijSqENTe+nLJ7vyZeprkLzf4lAhiui8vlyMUUgsD4EJz3ZhUJSpsNtTiyIa0e1hrZrSSlHpRUKRfoKjXA9C0IDe8a0+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWXqEb1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWXqEb1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B113F1F00A3A;
	Sun,  6 Sep 2026 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788709405;
	bh=iOVQMX1Df4zzH9eFtmY3W2AAsO2R4v8sD453QkenLaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YWXqEb1Fp/9IBcq/g5fidA1VVirWfA8EeTuCNDWv8kbk+8b+K0uFwNwZq1YsQc4W0
	 kZ2sysPfqq855NdiCbQk3iVrqyfNYmS9HmSpm91voK7keJ+Azfold/h1g78tohhhei
	 EgGrr8VMbpF7Iug2fUkB9tsY8qUNtrX9Z2EjxttHjI/Cm5Z6GihBK4v0iw0uPyODLt
	 bw6CSJZNA+Ub1XDOF3RBEwMo1WAafFGIqSSYa1uQ42BDIOjj1vBOoFmysCpeoSPg7l
	 LQTz2hcBLnzFood8nsmrWZiUcXfEVNGVG1Y8S64frVE3HhrNWMSR6d9iq9ppxxoUnz
	 IQjKJRIL+RBPw==
Date: Mon, 7 Sep 2026 00:43:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v14 06/14] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Message-Id: <20260907004321.0c38b17c5163f018053ca9a2@kernel.org>
In-Reply-To: <20260830144056.EB6391F000E9@smtp.kernel.org>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
	<178810007699.64882.3789162690369937099.stgit@devnote2>
	<20260830144056.EB6391F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 14:40:56 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Lockless updates to `bp->attr.bp_addr` and `counter_arch_bp(bp)->address` lack `WRITE_ONCE()`, constituting a formal data race under the Linux Kernel Memory Model.

Ah, good catch! Let me add WRITE_ONCE() there.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
