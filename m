Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC9219A8E;
	Wed, 12 Nov 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954262; cv=none; b=e/jE43JHQJZeNde5UwJ3QhwNDoLjF5clEgic/6UNsipKB/jl0COZUkRVAS8U2jNoIYDQY6DcvH4xusVVHHUpxB+Ems2QF7N/lWKGfmoftqpzNCrYFq0nT7AlOXv3G1Jruv5ZnPudh6h/C1sWsoWTheyE8FQpgid+UhxRJk2gWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954262; c=relaxed/simple;
	bh=2poLlO9B5CBMuS1HOT8AsTBXsJggdrQRNTQdmucUiaY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I8V6w3P3v2q5D4Q2QFKkW3tD4anotFxwFsROno+tEvB2CG7d7QBtH188DP05VAWcDxpXoFYvLGQiNQaQNzosnAI3G8tji8IS02eneCaUUweM1kGS9OtPpUUX0N1x60RKy76jlAuSMo8PgtO/4g5dM3X+Pci6G8LJbtIC45ZuR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maQSL4In; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maQSL4In"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288BBC2BC86;
	Wed, 12 Nov 2025 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954261;
	bh=2poLlO9B5CBMuS1HOT8AsTBXsJggdrQRNTQdmucUiaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=maQSL4InaEIoWc7a6LxKSVC9E12GsXKu0YLReFJoP/Z9xYuRKa26yQ9AuXQwVgUBa
	 depJlEKBsRznRaKvsg7BBMhUfrSkQcANG+eY7v6M1pG1X7O75wIQF2CWJcaN//Dz4d
	 IjV8BqL/Zwf0Mlz3z+5768ooXXso+AOWFezZQqjvgSgU3Rh65rX0CjBK4WxyRNQQI4
	 d5C2+hEnPBM1Vyv9HRFbWQ8+kJwGTqnkAb7tZ80JiwtmO4pbf8RBb0Qnu3TboZUkLd
	 VViUWKIKBreX3gztlXzP8qaQqV6QkwXHj611I6ETvBipFWIPLSCUPT2yrcPFGKJUdS
	 LuW9dGN2at8VA==
Date: Wed, 12 Nov 2025 22:30:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20251112223054.6ae557a50f1d998c9b46861c@kernel.org>
In-Reply-To: <af8f3543-4af6-48d7-a55a-bab24b6c7c7a@sirena.org.uk>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
	<175859026716.374439.14852239332989324292.stgit@devnote2>
	<aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
	<20251027224347.4c887cc956df63602f377550@kernel.org>
	<20251028084222.a3c1ae97d125d9bd88fc565b@kernel.org>
	<20251028105549.ae94e8eeb42f4efc183d2807@kernel.org>
	<20251029004219.dc9cda0eb56ae46c55855844@kernel.org>
	<20251029114317.167b7d908533385c1c9e6782@kernel.org>
	<20251029172004.a0aca144735f20a6a59d2aa6@kernel.org>
	<20251030090952.befea7f0cecd5518c7fda02c@kernel.org>
	<af8f3543-4af6-48d7-a55a-bab24b6c7c7a@sirena.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 12:15:03 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Oct 30, 2025 at 09:09:52AM +0900, Masami Hiramatsu wrote:
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > There is a single step execution code but only for default overflow_handlers.
> > This is a bit strange becuase other users can not set it up outside of
> > the arch dependent code. Even if it can, it is simply redundant.
> 
> > So I made changes below which allow users to set its own custom handler is
> > compatible with perf default overflow handlers.
> > I confirmed this works on both arm and arm64.
> 
> I think everyone who knows this code is really snowed under at the
> minute - can I suggest posting this as a fix for now?  This is still
> broken on arm64, we'll need a fix (or to disable the feature on the
> affected arches) one way or another for v6.19.

Sorry, let me drop it from for-next soon.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
