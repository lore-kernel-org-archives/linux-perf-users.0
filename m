Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0014D718;
	Wed, 13 Nov 2024 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512714; cv=none; b=D+rc2m7LgreI6EyJIuVauEZo5mzFUr1C75ShvlH7F4WspTBieDsx7aOu20AAn2ILtld0jBi2s0rTZnDh07bQ705TAABWdA+BB1+44OxxukM4AVhug1JCSSVqsP2XsNs+Kbh2fTl8WUs6xOMSUk84Qixo2Qpu2CovBEh2hxBLS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512714; c=relaxed/simple;
	bh=2aeh3GySezuvY6aMxghlfwNJN1O5v37onB/vdckq5pk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iNtxdLaFhBYDu5yf+wq1UryCFNO0T50fCEAbJeRHRiV3h8uXJjsW2KYbfa3Lfth/zT+xoeS6uU8ZbfYq2AIpY7djcLuk4qePBoFTkx++az2jalyBeRjbx28XaVW2SJvMnlHaGcxb8WYt881O5quj0/W/WreX2dxi3pMQ/Cwz/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtrqN5pQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtrqN5pQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC986C4CEC3;
	Wed, 13 Nov 2024 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731512714;
	bh=2aeh3GySezuvY6aMxghlfwNJN1O5v37onB/vdckq5pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QtrqN5pQ2tZhuNfgQu4v4vGrh1alauIdodXY5K4iS4piaKkAJ9AmiTB1XBeuXSuqS
	 PoAdwQr155+FnDdUb1KBw/4kNyP866SR2T16ctChHZh9KUvilx4T/qJihrO83jU0Am
	 SPJyB/7Gs31WO8YTy4xM4CcJ6T1pnJZsziWahcXbgEf15GxSmh3GN2VO/+RNjjpNSl
	 zugWQ0ykb/yeu9qR6bS/65z2vmGRKEeLtqZyctk4LrqZaSabvoezKR6VwZZ7svcjMG
	 VTTKN8Ynn4vnBf5d1SuBdoDAhX9W1zDCiF1yZHPi715489jCytefS5Gy9gI6y4D98U
	 OW02ZLIlVypZQ==
Date: Thu, 14 Nov 2024 00:45:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
 <namhyung@kernel.org>, <mark.rutland@arm.com>,
 <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
 <irogers@google.com>, <adrian.hunter@intel.com>,
 <kan.liang@linux.intel.com>, <dima@secretsauce.net>,
 <aleksander.lobakin@intel.com>, <linux-perf-users@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf probe: Fix the incorrect line number display
 in 'perf probe -l'
Message-Id: <20241114004508.cdafc33a99e3a02d5b5a714e@kernel.org>
In-Reply-To: <fa59a868-b7cc-5402-9379-4f7f931e5813@huawei.com>
References: <20241108181909.3515716-1-lihuafei1@huawei.com>
	<20241108181909.3515716-2-lihuafei1@huawei.com>
	<20241111170549.e4d1ba7b65aee3d890889277@kernel.org>
	<20241111210559.055c990dc94e95666f6464a2@kernel.org>
	<4751058c-62e3-4b99-9568-283fdf52b055@huawei.com>
	<fa59a868-b7cc-5402-9379-4f7f931e5813@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Li,

On Wed, 13 Nov 2024 16:39:54 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> 
> 
> On 2024/11/12 11:09, Li Huafei wrote:
> > Hi Masami,
> > 
> > On 2024/11/11 20:05, Masami Hiramatsu (Google) wrote:
> >> Hi Li,
> >>
> >> On Mon, 11 Nov 2024 17:05:49 +0900
> >> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >>
> >>> Currently debuginfo__find_probe_point() does
> >>>
> >>>  (1) Get the line and file from CU's lineinfo
> >>>  (2) Get the real function(function instance) of the address
> >>>      (use this function's decl_line/decl_file as basement)
> >>>  (2-1) Search the inlined function scope in the real function
> >>>      for the given address.
> >>>  (2-2) if there is inlined function, update basement line/file.
> >>>  (2-3) verify the filename is same as basement filename.
> >>>  (3) calculate the relative line number from basement.
> >>>
> >>> The problem is in (1). Since we have no basement file/line info,
> >>> we can not verify that the file/line info from CU's lineinfo.
> >>> As Li shown above, the lineinfo may have several different lines
> >>> for one address. We need to find most appropriate one based on
> >>> the basement file/line.
> >>>
> >>> Thus what we need are
> >>>
> >>>  - Introduce cu_find_lineinfo_at() which gives basement file/line
> >>>    information so that it can choose correct one. (hopefully)
> >>>  - Swap the order of (1) and (2*) so that we can pass the basement
> >>>    file/line when searching lineinfo. (Also, (2-3) should be right
> >>>    before (3))
> >>>
> >>
> >> Can you check below change fixes your issue?
> >>
> > 
> > Thank you for the detailed explanation in your previous email. I tested
> > your patch, and the results are as follows:
> > 
> >   # perf probe -l
> >     probe:schedule       (on schedule:5@kernel/sched/core.c)
> > 
> 
> Sorry, I made a mistake. 5 is the offset from the function entry, not
> the line number. So your patch is ok.

Thanks for testing! OK, let me cleanup the patch.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
