Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8914FBF6;
	Fri, 24 Jan 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737838; cv=none; b=T40siM8sTGLcF9VneF+RugwpOyXdXrgDq4XSAWemJaBblbmLr5YW/p2D8ts4QjiL4Kq5emlj+S9L8PKWB4NOdBRc3CrWmivSEy/sGIDcaORrkQd3YbrxMnKjmgtWkB54VI0jzSGAYATFeNTp/GM2FIqF0bWSqjGoPMFM6QctFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737838; c=relaxed/simple;
	bh=ylHYzB0S3kjYA5jzC2tk2Pt6TRfSJsTdbvj0WpwwAtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvo98UsC1e7alG1ivkXESWpwyS2WGSPUYRDz1G5MgiYTQfqar/3U/kdTsjyQF96JfVtmiLYixYGHxxrRvUdRWZcMm522/19sU+XqD6tBkqfKasgClyaiwuO+4bKGpeU6qtgZz+5fv7wwqtrFPfU13hchZ0nY5+2chvBPGDvCTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq3DyDnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq3DyDnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C434C4CED2;
	Fri, 24 Jan 2025 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737737837;
	bh=ylHYzB0S3kjYA5jzC2tk2Pt6TRfSJsTdbvj0WpwwAtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jq3DyDnvlepAADkR/nd/XuRL/2FL5SuaTkN9ASituh4CaxLdwqWNfpxAuMqgGuQzo
	 hiOQnl033QTRbLPG8cIvGAL/irxPvLGtZgIfMDvt5VuxkN/X7nwn69nQcAnN102qpI
	 hU/NDsaIk2kCAAiN0WcZY/CUrpOkeI5S5WqDBDY5xS5wpCDLV0AB2MqNXA6Zlsxt1q
	 7hD7/phelhymJYdIockfXRRmCQoOW16dpK70ewBMcWXhGLcq9YC7eXPkVQ8QZlhRRm
	 gTXzmfnKc66okSB/QjNK4Nu6u1zZk2zspORUnfbm5lYpVa76xloc8BgnCo1Jj8xIYn
	 p56Mtl8z5HcQQ==
Date: Fri, 24 Jan 2025 08:57:14 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250124165714.irsxqqtww2qr6lya@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <30483278-c065-4851-b709-8d1dcfa1fe5e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30483278-c065-4851-b709-8d1dcfa1fe5e@linux.ibm.com>

On Fri, Jan 24, 2025 at 05:35:37PM +0100, Jens Remus wrote:
> On 22.01.2025 03:31, Josh Poimboeuf wrote:
> > +static inline void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) {}
> > +static inline int unwind_deferred_request(struct task_struct *task, struct unwind_work *work, u64 *cookie) { return -ENOSYS; }
> 
> static inline int unwind_deferred_request(struct unwind_work *work, u64 *cookie) { return -ENOSYS; }
> 
> Otherwise this does not compile on architectures that do not enable
> UNWIND_USER.

Yeah, bots have reported that also, thanks.

-- 
Josh
