Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF449C4B5
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300414; cv=none; b=RB02Q7ub0rtpoEmpmG7ZNrmsWDTJIydiZXB2KTijQl/E7ybmaLJkmjXU2f3pg1taCquW4KOsgk6UzlXZ5erJ6i0pJaVro7eN+VPixTmL5Dm9hGqxM0S8pw54k9myDY7CUmwMhVS2isK2Ucny9ok1lBCDqus593inqREbkpjGb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300414; c=relaxed/simple;
	bh=RUKYT2VKWvphyw7tEOX/vrQJJn1kxHAXECL5CcmhWO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgvViZ/Oqn7BqzU4URL4M7IhwF6dO1BI/KJy0ApKVHz4ZVtEgjC9kZv4pYB0cmNRjg9jLoBZzILvuakUd4L4/fdr8SEKOB3cJvl1AHM5BFHm3NE9kN/PJq1bgoCJTf8Qn6Nu+Z7GREoGJiD3ih8DXIS4gfsOt947euBRyPIbJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRIJGJfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRIJGJfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DBF1F0089B;
	Tue,  6 Oct 2026 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791300412;
	bh=TPsKc637BlsXuR21zgYrEjyE3JQ6ozyI9spNS9Vop/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oRIJGJfsmv5nQJlVgYURkRVYlAFfnTSeJeJvclzRJkleZ5HtoF4hoLpAWd7kG1boQ
	 l5jqV7B8emcMhdZy+/bnqpqioRz5WhCoXeJZe6bEWFnUUIMVwTeENhGA/fapLBv/sP
	 nxbXQvicwPL7jT4gselGJx3ZMcWKOCFEIEp1fiORJZITjrHQSeZD3ml/3HdIEkVM0Z
	 k2BWws6D4c9GqZSjSvdSf95CKHL2W4aAKrCtZ+LHXb3pX8KkeLNAaaE6ALdF6YZCDY
	 8tdO9CvdppGhaXQcsx7zxbT3S0cqI63lAv9dl3ETM2mR0S2hAoUfFXDPOnVMzVu2wE
	 okgoIHlwnd/RA==
Date: Tue, 6 Oct 2026 17:26:48 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com,
	namhyung@kernel.org, acme@redhat.com
Subject: Re: [PATCH 2/2] perf test attr: Fix wrong size expectation for events
Message-ID: <asUTODqjJUH5MwSE@x2>
References: <20260924223027.799654-1-mpetlan@redhat.com>
 <20260924223027.799654-3-mpetlan@redhat.com>
 <asT4xQW9Vy492Yyl@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asT4xQW9Vy492Yyl@x2>

On Tue, Oct 06, 2026 at 03:33:57PM +0200, Arnaldo Carvalho de Melo wrote:
> The test is still failing tho, for some other reason:
 
> running '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-default'
> test limitation '!aarch64'
> excluded architecture list ['aarch64']
> running '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-default-aarch64'
> test limitation 'aarch64'
> skipped [x86_64] '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-default-aarch64'
> running '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-dwarf'
> expected sample_type=45359, got 12583
> FAILED '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-dwarf' - match failure
> ---- end(-1) ----
>  82: Perf attribute expectations test                                                                       : FAILED!

Some fixes for problems undetected because of the lack of error
propagation:

⬢ [acme@tb-x2-perf perf-tools-next]$ git log --oneline -5
027108ff3952e8ae (HEAD -> perf-tools-next) perf test attr: Fix legacy event encodings in group tests
12d947c0d8e7aac6 perf test attr: Fix record dwarf sample_type expectation
cec590f3de003895 perf test attr: Fix wrong size expectation for events
04a0a19ede01e771 perf test attr: Propagate the return value from the test to the wrapper
1dc462fc21490767 (perf-tools-next.korg/tmp.perf-tools-next, perf-tools-next.korg/perf-tools-next, five/perf-tools-next, acme.korg/tmp.perf-tools-next, acme.korg/perf-tools-next) perf test: Add a test for perf timechart --tui
⬢ [acme@tb-x2-perf perf-tools-next]$

Still working to see all gets fixed and that test passes again.

- Arnado
