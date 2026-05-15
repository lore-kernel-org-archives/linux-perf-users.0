Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005931E82E;
	Fri, 15 May 2026 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887001; cv=none; b=rUB7GKQPDib94vQy9kDTulgKCAWNdfBHmZr2FjXRg71pUWmXI9R8ClbjD5whT4HLWTEVROmO9rV4LQ9qDpkIaJg3bofiS1H2ygUa2h+gF0VkBPYx509mi2jKHCdJ+pAkxM8TrzaA8YM9hq7V5TeHDewp6cUboiCkBI9NDTUWPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887001; c=relaxed/simple;
	bh=+irwJ3Om1qyAb+qmmQ5h/jnyTUHKJo9wu4T6k6KN060=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WztSNFTiY2EaOqwrwEsIaDJ/e3WkX9rw1mb8KJHM5So6wyB7zm9OoobJZT2XZhRqlvVM3zv6haLEC/Q8fG7Vr8aHGaho6cIf5K8JqGT+3MFw64DkaeTMWHgz27rpXvAgiDqtTsds31PiwKT94ICMtkQt0729edPSQoyz/oXDJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id CDB7C140275;
	Fri, 15 May 2026 23:16:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 0D0C46000E;
	Fri, 15 May 2026 23:16:31 +0000 (UTC)
Date: Fri, 15 May 2026 19:16:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 3/3] tracefs: make root directory world-traversable
Message-ID: <20260515191630.2276b241@fedora>
In-Reply-To: <20260515194010.93725-5-ashelat@redhat.com>
References: <20260515194010.93725-2-ashelat@redhat.com>
	<20260515194010.93725-5-ashelat@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6fwwxo3fr6raqbmugu3agsj555bc9jkk
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0D0C46000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/F4EzRsn/B3uDMumpeD+MZTewUy5t4Rlk=
X-HE-Tag: 1778886991-828779
X-HE-Meta: U2FsdGVkX1/oL62XGgudii9qqRDXSw8IoJpH5ncJxAqIDuGscZG6EYrT4JslXZJaLPcVjNkcN9ztKiFqMP4d3sucjQDY7vfpOcHPGxnOC7xAT3YlmM93mqpqpz/dqpjTF+5t7Uk3/84UO4BFrtJtQzWx54/QD8gk2We51MMUSoT+BO87ghpKFp12XdCslXKSgsISX0QvCXrY0yyAbZxG3k+XH2GGhtBi1FUGCPvax6WaslDEnXE/QEHNFiQlY9kkYP4kTmwxIE/guBYesbxuTvLSCQf3limSU2usgtULFzNjl8aTPGqbMBdAGEokrdGI1woY6NjrZHk8PK3MYRfmaQzhW3cUa7kjlRxO9Gyu8GYt66WVy09E5A==

On Fri, 15 May 2026 15:40:07 -0400
Anubhav Shelat <ashelat@redhat.com> wrote:

> Change the default tracefs mount mode from 0700 to 0755. This allows
> unprivileged users to access the eventfs directories underneath which
> already use 0755.
> 
> Tracing data files use mode 0440 and 0640 so they are not exposed by
> this change. Only the format and id files, which have been marked as
> work-readable, become accessible.
> 
> Directory listings of kprobes and uprobes, which contain functions or
> binaries, become visible to unprivileged users but do not contain kernel
> addresses. Admins using probes can restore the previous behavior with
> chmod or mount -o mode=700.
> 

I've been thinking about this and I believe a better approach is to
make a eventfs that is mounted at:

 /sys/kernel/events

and be the same directory structure as /sys/kernel/tracing/events but
only contain read only files like "id" and "format". This directory
would be mounted as 555 and readable by all.

-- Steve
