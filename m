Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937D1D89FC
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070154; cv=none; b=FMD2dWrT8bWqv3wLvdE7mtaGwv73WIOkWi86riwnfck7UUJMbqF0dzniBQ8+Vv+p7BH+lpMexpdrvECu3gotwjVpiZ9x5qhv5hND74+Axzfvaghw1/e/AU/IjqMzCkqBCWeZe8cC9+fyfUzmyGBGDsHLQ3mUxKf9b/5V4MswQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070154; c=relaxed/simple;
	bh=xjgGsWtqILpIRg5wq9/4p2CWsxX2nJK4VWmKB4OXYQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R0fOnPqnU42ZbkYzbeuKjtZCwB03+PPFJZkY8YZbi2JD7lNZ2Sh4EpYvMf6jkQciNrtUyeDxB9B/d4yUBQctqMlYsJmxiTJUMXfxstmex0gCjT8e6pe5C3YNuugRvftZ+z5iW0+Sh5xwivuFyGuxSUAFijjsSZ1Ckl/IJHafCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi9F37x4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi9F37x4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86479C4CEC6;
	Fri,  4 Oct 2024 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070153;
	bh=xjgGsWtqILpIRg5wq9/4p2CWsxX2nJK4VWmKB4OXYQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pi9F37x454LONAkQbFSO1l94aDXdBpFfIcydpKrQFch5SeaQjdOjfbbAjMMH+4ATk
	 6cf2gpMWNJ0bYg4asGjbggS/VBdET4D4L6KRJ8l7T+u2mssJ3VwHTyNXikAiciTR3b
	 mkI0cGCLh3egXsUKVo5caHy0UOKyff4RvhGSuyMXC50ZN9jGvCjc51irxzyi91NdXs
	 v3PPia9pGG3R/QqL3yPYKaVMAJAMXSbg3KePaQX51o27nu8sRd+OU6IE7gW1Wa86qN
	 meznj4FtF8BDqolHQSrjxWREzfNm/ic2/whXpHo24k7kIQTsIGhsycxUtJEyrxwoxh
	 hK/cAiGmwWb4Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, vmolnaro@redhat.com, 
 irogers@google.com, Michael Petlan <mpetlan@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com
In-Reply-To: <20240927151926.399474-1-mpetlan@redhat.com>
References: <20240927151926.399474-1-mpetlan@redhat.com>
Subject: Re: [PATCH] perf trace: Keep exited threads for summary
Message-Id: <172807015351.55364.9210322840431011833.b4-ty@kernel.org>
Date: Fri, 04 Oct 2024 12:29:13 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 27 Sep 2024 17:19:26 +0200, Michael Petlan wrote:

> Since 9ffa6c7512ca ("perf machine thread: Remove exited threads by
> default") perf cleans exited threads up, but as said, sometimes they
> are necessary to be kept. The mentioned commit does not cover all the
> cases, we also need the information to construct the summary table in
> perf-trace.
> 
> Before:
>     # perf trace -s true
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

