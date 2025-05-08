Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D32E659;
	Thu,  8 May 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730470; cv=none; b=nHa8X30p6sV2LxIg2bAYGx/7FbU0eEsuv8S3SujeM/s2zUbbYWiLqrngVpvdyjafT6Jnd71Loc4GtedZ+0npYRgk80EDveX3cP4+IDOBc8TPNDr8MMiEHBnTUQQp32v7oPoKtqXTTRuEpkyRLPAUka9RqiDkIGtRCHSKFU3Y5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730470; c=relaxed/simple;
	bh=EcMVZiPFOCYEIl9Sly93auEjAjNjIVKq3NME9jr0WSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+Av4JhNMIYpP5tL4M/1xn3KNd1Nsoe5i9gbpesUOUuYZJ7lgcNfVkCr/oq1EkPjcxWg0eYlFYxQkVmCZfKUTTT4eJzSJYWZj+BKxG7pJ7qXH/3ySQmm0nIqQtgrmbGjXBx99lADBURGSS97ux/f09ZLVTt68r5X9UuD4lsDBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520BEC4CEE7;
	Thu,  8 May 2025 18:54:26 +0000 (UTC)
Date: Thu, 8 May 2025 14:54:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <20250508145439.4c6482b7@gandalf.local.home>
In-Reply-To: <89c62296-fbe4-4d9d-a2ec-19c4ca0c14b2@efficios.com>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.390748816@goodmis.org>
	<20250508120321.20677bc6@gandalf.local.home>
	<89c62296-fbe4-4d9d-a2ec-19c4ca0c14b2@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 14:49:59 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> AFAIR, the cookie method generates the cookie by combining the cpu
> number with a per-cpu count.
> 
> This ensures that there are not two cookies emitted at the same time
> from two CPUs that have the same value by accident.
> 
> How would the timestamp method prevent this ?

Do we care? It only needs to be unique per pid doesn't it?

-- Steve
