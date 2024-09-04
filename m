Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92B13AD1D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477310; cv=none; b=VBFSTzoom6zepEC6nURuJp3uSHPIKgB2mMYK8+3jTui4Xk7aIZKMHA1BdkoS9sg9e1S4lgA9ddVIXizBQ4es/yMguliJSzqpGAourEn7GWIK41qBMxVwpz4WWtrtkIcvFTakc3xYKgu0Iz8ELMosMwYUKQy9Shh8B6JpxLaVZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477310; c=relaxed/simple;
	bh=8ZWSVSGEDVSfeeFzj7EcaAGptbsIuiMjZebU2Prh7cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGEP1q0+LxQcTbLBiXQwpIOfc3+B4ry/evkGRLnQ4Kg3+Mon6/hCT6hdqrWdkXkqcqaz/xfxgVahMZnnRXRqjEVnpJN7p7LjNIQoUm5xQPkyc8o/OVrISDTPmC+oMWtg2q+EXzUoLd7P+0umkkCky6bNaKUw1m7+IJ5OsoJsHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbGTUwD8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbGTUwD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC46C4CEC2;
	Wed,  4 Sep 2024 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725477309;
	bh=8ZWSVSGEDVSfeeFzj7EcaAGptbsIuiMjZebU2Prh7cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbGTUwD8qBRvylMVZqOndk4sKO72mPG01YXJFC4w1D+wQxx4njBr3sDqRrsck5C56
	 tBK66q1ZZLvIhSw/7zyXQqkTGYfIFZwNb/FEz9wvJtCc9Cpr3O3OAijAOPqPHQqLCx
	 c0c7LvoABe+zsrYTKYJwK6tCtb4sfyAq6RioXov9Xwz6p5ZT2Nbygs8ig6WrAGbYHI
	 ZFAtsv4naDdLu3WRLISnvZ+SqQdRozgCpEWekgYV2uFOnCnyI/U+CoisGCPQKj3Faz
	 QFecxnJyyF/uKBhDbkHAF8V7QfJDGmZhtVcdk/3Hd0uvJ9sixBK6I+bLsI5528ALTN
	 i5jGxotxnRfMA==
Date: Wed, 4 Sep 2024 16:15:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v14 3/7] perf version: Update --build-options to use
 'supported_features' array
Message-ID: <ZtixtQiG20UFWEkd@x1>
References: <20240904061836.55873-1-adityag@linux.ibm.com>
 <20240904061836.55873-4-adityag@linux.ibm.com>
 <ZthbFDYPX3Opb8Ij@x1>
 <b48b172e-d465-4dc5-abd6-7da7a47e5c9c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b48b172e-d465-4dc5-abd6-7da7a47e5c9c@linux.ibm.com>

On Thu, Sep 05, 2024 at 12:36:21AM +0530, Aditya Gupta wrote:
> Hi Arnaldo,
> 
> On 04/09/24 18:35, Arnaldo Carvalho de Melo wrote:
> 
> > On Wed, Sep 04, 2024 at 11:48:32AM +0530, Aditya Gupta wrote:
> > > Now that the feature list has been duplicated in a global
> > > 'supported_features' array, use that array instead of manually checking
> > > status of built-in features.
> > > 
> > > This helps in being consistent with commands such as 'perf check feature',
> > > so commands can use the same array, and any new feature can be added at
> > > one place, in the 'supported_features' array
> > So I tested and applied the first two patches, but it is failing for
> > this 3rd, please rebase from what is in the tmp.perf-tools-next branch
> > at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> 
> Thank you !
> 
> I have rebased the patches in v15.
> 
> Patch #1 & #2, are same as already applied in tmp.perf-tools-next branch, so
> they can be ignored or even if applied git am should ignore them.

I dit it with:

[acme@toolbox perf-tools-next]$ b4 am -P3-7 -ctsl --cc-trailers 20240904190132.415212-1-adityag@linux.ibm.com
Grabbing thread from lore.kernel.org/all/20240904190132.415212-1-adityag@linux.ibm.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Nothing matching that query.
Analyzing 8 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v15 3/7] perf version: Update --build-options to use 'supported_features' array
    + Link: https://lore.kernel.org/r/20240904190132.415212-4-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v15 4/7] tools/perf/tests: Update test_task_analyzer.sh to use perf check feature
    + Link: https://lore.kernel.org/r/20240904190132.415212-5-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v15 5/7] tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
    + Link: https://lore.kernel.org/r/20240904190132.415212-6-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v15 6/7] perf: Fix inconsistencies in feature names
    + Link: https://lore.kernel.org/r/20240904190132.415212-7-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v15 7/7] perf: Add more features to supported_features list
    + Link: https://lore.kernel.org/r/20240904190132.415212-8-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/ibm.com (From: adityag@linux.ibm.com)
---
Total patches: 5 (cherrypicked: 3-7)
---
Cover: ./v15_20240905_adityag_introduce_perf_check_subcommand.cover
 Link: https://lore.kernel.org/r/20240904190132.415212-1-adityag@linux.ibm.com
 Base: not specified
       git am ./v15_20240905_adityag_introduce_perf_check_subcommand.mbx
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$        git am ./v15_20240905_adityag_introduce_perf_check_subcommand.mbx
Applying: perf version: Update --build-options to use 'supported_features' array
Applying: tools/perf/tests: Update test_task_analyzer.sh to use perf check feature
Applying: tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
Applying: perf: Fix inconsistencies in feature names
Applying: perf: Add more features to supported_features list
⬢[acme@toolbox perf-tools-next]$

Now test building it one after the other and then the container builds,
eventually will flow to perf-tools-next.

Thanks for persisting and collaborating!

- Arnaldo
