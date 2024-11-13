Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8B20515C;
	Wed, 13 Nov 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531042; cv=none; b=hadQibh6I33fbjuW2h4C1481VPPBS6XJSVqDT8mxDByL2LyLe10VcxtMvWGejVMK/jYfjp1VohLGrzFcLXyS/bGJTjS6HnczR8UkMoqXYFqmKhM4z/txIFB/ZqIsakcxZoxz/2wQokCm1ND/HXZRojRgLkFagZXdvxzipyFIk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531042; c=relaxed/simple;
	bh=QEz+6e+yvPv863V8p1VehSQrPJARnX6Sr3Zjmyn3ZxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFjlPY/n9DuZXasrbMOqSERtrggcMopwXlEzVWJxSn/AmfESIY4WZMdqLv6bWNTQ/OfkHnnIkpmSosoMlDuaH8DswQ0kSjFQQp2kJKQdYQvtO3iVGkdejIGQ5QaQtbnwzcZw9pUsGSz/ee5/KxM8JgomZXDPMDwL1zmDS7I2KTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B259C4CEC3;
	Wed, 13 Nov 2024 20:50:39 +0000 (UTC)
Date: Wed, 13 Nov 2024 15:50:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Indu Bhagat
 <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241113155058.5b15ea58@gandalf.local.home>
In-Reply-To: <23ff3782-c192-43eb-99c2-fe2746da7d4c@linux.ibm.com>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
	<23ff3782-c192-43eb-99c2-fe2746da7d4c@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 16:56:25 +0100
Jens Remus <jremus@linux.ibm.com> wrote:

> On 28.10.2024 22:47, Josh Poimboeuf wrote:
> 
> > diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c  
> 
> > @@ -68,7 +83,12 @@ int unwind_user_start(struct unwind_user_state *state)
> >   		return -EINVAL;
> >   	}
> >   
> > -	state->type = UNWIND_USER_TYPE_FP;
> > +	if (current_has_sframe())
> > +		state->type = UNWIND_USER_TYPE_SFRAME;
> > +	else if (IS_ENABLED(CONFIG_UNWIND_USER_FP))  
> 
> The test must be for CONFIG_HAVE_UNWIND_USER_FP. :-)

Yep, that too.

Thanks,

-- Steve

> 
> > +		state->type = UNWIND_USER_TYPE_FP;
> > +	else
> > +		state->type = UNWIND_USER_TYPE_NONE;
> >   
> >   	state->sp = user_stack_pointer(regs);
> >   	state->ip = instruction_pointer(regs);  
> 
> Regards,
> Jens

