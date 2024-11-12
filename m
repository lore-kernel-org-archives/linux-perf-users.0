Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A36215032;
	Tue, 12 Nov 2024 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439959; cv=none; b=L5QHdJAos4K2bUtkXh/EdH6EFwvatOtep4JX/RJzE4r8jFOW2IKDyZf6OZJuZ4v3vNQUlfI8CSoZv8Htc0RIjzCWUu2jZFpw9hqg2oPGKpoeQaOLxMYsDYJkFv3RtKJHTmhEZpLLE7IXonNB8XVBqSI3bfjmL/p/n5SlL42OfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439959; c=relaxed/simple;
	bh=3YRxWR3gMpFhcAUkpuvap94PCA2KNLu4RnrKuCc032Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRzo46Ivb6kLVZ0uRKT6P7/jXHUxzEmvH19iI8KFRRSRa3+yibH3QG5NWSVYWS4rYgaYxrsX+4HkJvp7rLcDeYWe+Hv5W38oXe9/x135p1kl9mcCWOrcJT8WbbiKWRnxciLbiGIRe96EBd0xwr3BspxcErTXY9qQ6oVMwk9c/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWE3d1cK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWE3d1cK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F02BC4CECD;
	Tue, 12 Nov 2024 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439958;
	bh=3YRxWR3gMpFhcAUkpuvap94PCA2KNLu4RnrKuCc032Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWE3d1cKVWs6/+BwqV5aF5ARHHv4gXKmRq2MGe/F++NuC5HH50DHA2HTsh8ueid7Q
	 6iA83Ohi+R8r5XVkV2CvTSr+Tmfvr2QrgoWitv42JXYRYlaBGU9JuHi27BdVuBzqQc
	 UuzgyZDgcQp95FWd3RE0r9qurLs9M0hiHZXI1ZZSywbmQyS25+QoxmvZVX2GPbC9Cf
	 qBoUJgsi+mzQpEADBgW67EwF+9amIpD9s4h9UUUgu5UZw7+NNdqZEBd5bWdzgVjoKc
	 bYngjJdyDjxAN4nV5F5KTm+Jb7BZSQHnzHknow8pyO5Ep0sMr0PCGubV3eh+nJfk1x
	 9GrDfMowz6FUA==
Date: Tue, 12 Nov 2024 16:32:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <ZzOtUMIT2s6sDDni@x1>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <ZzOg3Xlq2jsG85XQ@x1>
 <ZzOpvzN-OTLZPyFh@x1>
 <ZzOp_b3Wm_kM7b0V@x1>
 <ZzOqFTfgY_9CJfHb@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzOqFTfgY_9CJfHb@x1>

On Tue, Nov 12, 2024 at 04:18:45PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 12, 2024 at 04:18:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Nov 12, 2024 at 04:17:24PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Nov 12, 2024 at 03:39:25PM -0300, Arnaldo Carvalho de Melo wrote:
> > > make: *** [Makefile:119: install-bin] Error 2
> > > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > > ⬢ [acme@toolbox perf-tools-next]$
> > > 
> > > I squashed the patch below and I'm trying to apply the other patches to do some
> > > minimal testing on the feature itself, but the organization of the
> > > patches needs some work.
> > 
> > Fails a few patches later, trying to fix it.
> 
> Sorry, forgot to add it:
> 
> ⬢ [acme@toolbox perf-tools-next]$        git am ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
> Applying: perf evsel: Assemble offcpu samples
> Applying: perf record --off-cpu: Disable perf_event's callchain collection
> Applying: perf script: Display off-cpu samples correctly
> Applying: perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
> error: patch failed: tools/perf/util/bpf_off_cpu.c:61
> error: tools/perf/util/bpf_off_cpu.c: patch does not apply
> Patch failed at 0004 perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> ⬢ [acme@toolbox perf-tools-next]$

So now its just a fallout from the fix on a previous patch, I'm patching
it up:

⬢ [acme@toolbox perf-tools-next]$ vim ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
⬢ [acme@toolbox perf-tools-next]$ patch -p1 < ./v7_20241108_howardchu95_perf_record_off_cpu_dump_off_cpu_samples_directly.mbx
patching file tools/perf/util/bpf_off_cpu.c
Hunk #2 FAILED at 63.
Hunk #3 succeeded at 311 (offset 5 lines).
Hunk #4 succeeded at 351 (offset 5 lines).
1 out of 4 hunks FAILED -- saving rejects to file tools/perf/util/bpf_off_cpu.c.rej
⬢ [acme@toolbox perf-tools-next]$ 
⬢ [acme@toolbox perf-tools-next]$ vim tools/perf/util/bpf_off_cpu.c.rej
⬢ [acme@toolbox perf-tools-next]$ cat tools/perf/util/bpf_off_cpu.c.rej
--- tools/perf/util/bpf_off_cpu.c
+++ tools/perf/util/bpf_off_cpu.c
@@ -63,6 +65,9 @@ static int off_cpu_config(struct evlist *evlist)
 static void off_cpu_start(void *arg)
 {
 	struct evlist *evlist = arg;
+	struct evsel *evsel;
+	struct perf_cpu pcpu;
+	int i, err;
 
 	/* update task filter for the given workload */
 	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
⬢ [acme@toolbox perf-tools-next]$
