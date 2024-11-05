Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3F1E0B6F;
	Tue,  5 Nov 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828727; cv=none; b=X1QuIVEObTmHC+NzGAvH3FBJUf3DV4gQ7w5y4HhqbQOLmPsd5t8yuLXNB10qHNkrDvN/Z/jPMJ9IlGjpQXbJdXcHhYv3wB8EINWRw/uaYgjCF5pZn5iRs9eb1wbPNH3pHQvpYR3QB2BmfBHSbZujV9gAM0ZkFCLV+SnyfMjMHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828727; c=relaxed/simple;
	bh=j61s7ZrRf+akspgM/tlrH7VFgVv4qSqgyUrOcFbuZxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5+pplnZlcxQBxqzKlPE5qg1TAGIH0/N0HOhXvl4c/dXUC9DAFvnkXmJFBF3h8c+LGIzcJcYzcIQtY4zko72bu1X/roeY0bLckopg/aGl7QPz1fQ4pJ6T5v6IcHG0Zbb3igwh7CU8LxcD5770N4jIQ19um71c5V8fyNhSq/Kk5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A70C4CECF;
	Tue,  5 Nov 2024 17:45:24 +0000 (UTC)
Date: Tue, 5 Nov 2024 12:45:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Florian Weimer
 <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241105124525.03b835f3@gandalf.local.home>
In-Reply-To: <20241105124053.523e93dd@gandalf.local.home>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
	<20241105124053.523e93dd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 12:40:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 28 Oct 2024 14:47:56 -0700
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:

<linux-trace-kernel@vger.kerne.org>: Host or domain name not found. Name
    service error for name=vger.kerne.org type=AAAA: Host not found

Hmm, no wonder this didn't show up in patchwork :-/

Please fix on your next version.

Thanks,

-- Steve
