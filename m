Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46317C7DB
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342531; cv=none; b=PTdvpKHx0ws/mwTv4uAooJqnwz82NEWLS5KSNOt6Z6eYouTNy6uu5kjz818IVw5tZxoYmvruZUxo+dm9ITOiDxK5951sj+A04k2zXFRz4hh0VvWZruqhkC67Y5dMNNTXf1uh/+z5nco5/Z+oimiupFK7Ughl3pb833lWHyXwLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342531; c=relaxed/simple;
	bh=0CB9sQZnEgIrCc10IOON3JQTwzx1VOujsaYSwskhnqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkdXjxHcxbSDBJJJ+AgO3kboeDM7XMxt8xXDIh1zf30UF6MhYWjV1ziMTO4/TScJyroKxL1bHvpXx7Lfunf9TICCE3G+tOsG1xhsV3nGqkBSH7+5w4vLkAMG4ULhdrwcmeL7NIVQ12XUbtzuu/ISQyJRMFHcDn8oXLEWHLGhUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH7Gzrqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH7Gzrqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24613C32782;
	Tue, 25 Jun 2024 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719342531;
	bh=0CB9sQZnEgIrCc10IOON3JQTwzx1VOujsaYSwskhnqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UH7GzrqaU0dAPsMmY0FWI0Nia/W3rqz6ssgKGU2WaY3icWB+Cl9u5mjUi71C6jDkE
	 dGMquwQGyJPvbEsyu8/kvQMlqO/cLsKWtuwoU+fHKKKOa5sfgoyDJaSRowlWGf5hUc
	 NV+W/s2PmzgiXtIt/rpICC8m+OCyA5DxYoh+GjDJrhwwSPzNup8YyjOt4XN1x6e9e5
	 zTghhRzKXPcWcpEhQJT6p6l9Bm+/xCeT3Wy+UHx5oPo6w6T6Kvi2dqwT6xp8wB54o+
	 E8kAsXqd4wg2x6gswsSeM+BYxJP5TdDMdHaHpKlU0KTM5/+EMa5yJ0zOQSi3x3fEZP
	 rsHzoxGbq94TQ==
Date: Tue, 25 Jun 2024 12:08:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
	linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com
Subject: Re: [PATCH V3 10/10] perf test: Check output of the probe ...
 --funcs command
Message-ID: <ZnsVwdSUG4wkskqv@google.com>
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
 <20240601125946.1741414-11-ChaitanyaS.Prakash@arm.com>
 <ZnoBpxbuZ1shXBR7@google.com>
 <0b0fc9b5-9e64-49c1-8631-74aa79fcf01b@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b0fc9b5-9e64-49c1-8631-74aa79fcf01b@arm.com>

On Tue, Jun 25, 2024 at 01:40:57PM +0100, James Clark wrote:
> 
> 
> On 25/06/2024 00:30, Namhyung Kim wrote:
> > On Sat, Jun 01, 2024 at 06:29:46PM +0530, Chaitanya S Prakash wrote:
> >> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> >>
> >> Test "perf probe of function from different CU" only checks if the perf
> >> command has failed and doesn't test the --funcs output. In the issue
> >> reported in the previous commit, the garbage output of the --funcs
> >> command was being ignored by the test when it could have been caught.
> >>
> >> The script first makes use of --funcs option with the perf probe command
> >> to check if the function "foo" exists in the testfile before adding a
> >> probe to it in the next command. The output of probe...--funcs command
> >> is redirected to stdout, therefore, add '| grep "foo"' to validate the
> >> result.
> > 
> > Ok, I think this can be applied separately.
> > 
> 
> Yeah I think it can. There was a question from Arnaldo about this one on
> a previous version, but Chaitanya clarified about the stderr vs stdout
> thing:
> 
> https://lore.kernel.org/linux-perf-users/7d6330bd-5b0a-49d2-83bf-ac1ca11996d0@arm.com/#t

Thanks for the pointer.  I've also checked show_available_funcs() -
which is called for -F/--funcs option - uses the plain printf().

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/probe-event.c?h=perf-tools-next#n3801

Thanks,
Namhyung

