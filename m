Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4F1C84DC;
	Wed,  1 Oct 2025 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322161; cv=none; b=T2kjsbYzvrOHw3IIlqmKBAVBPPB1JnI94L2HDKb775wsj6yGllga12ZYUYcB818cOx699+j1/8nzijlndgAQkS8+nunFQEVesvvpNpTOLQqLZWJK1wC4W2nAemsSsIAKFmCn7Y0wE/zGBQhpinf/cAIx0s2YVqYQOkMZNg/q+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322161; c=relaxed/simple;
	bh=luMbsfvYgcRNwaEqwffMzc3vxrQyc88kv00CV8qeq4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhYDYuFJgNOJNGKI/3AjGFTmRN2JIlHEmL6nfDF/qySinaLfDBg0304U9zDBCtqmY8sUaPKQDzV53MoI4pu/AgAMhcLujj3PjA394kHQdHztqCaKWzRYHIaFLkiZx46j+cNAXmw1Q4E9YYVPVcV8c4IwqYUs6An9IQ+REPe1GMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX5x9zG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX5x9zG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C2FC4CEF4;
	Wed,  1 Oct 2025 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759322160;
	bh=luMbsfvYgcRNwaEqwffMzc3vxrQyc88kv00CV8qeq4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MX5x9zG5BVHJXJ6rSShFSjTj2sMwZYsS74qK0PTxFI1hCXpGMRTDreiM9KpA84DtS
	 SGWDXHhQGALXGtAjzj+VFTKaIdowvyin9Gylz1oILITPtB67J578B1H9y8VFGOSyNt
	 lnB64GcNfmdwhYDfqhFUgF7BkwetEoj141qwYhUiZy22FM3ckKnnI/R+JUWC+gDiHq
	 xRB8WqUSBa6+X9fHuqWBPgi8Lm6BKP1cDJJGF/zrouKBzrwZmT0SuhyHVRBA2KP6qT
	 i9Niw1pkJBwH2gnjbc2S8LfflraA0ZXJ6FWlticXIfPGDGgc7rHjys67k9YAAU51Vk
	 wYfI2PQznZynw==
Date: Wed, 1 Oct 2025 09:35:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Markus Heidelberg <m.heidelberg@cab.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: fix duplicated words in documentation and comments
Message-ID: <aN0gLRFdaLCNuY7P@x1>
References: <20250925112614.78061-1-m.heidelberg@cab.de>
 <CAP-5=fX3rdL6zrZozPNS8LiTpD8S2vfMs_3QPDQYdxk49t2VWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX3rdL6zrZozPNS8LiTpD8S2vfMs_3QPDQYdxk49t2VWw@mail.gmail.com>

On Thu, Sep 25, 2025 at 08:18:58AM -0700, Ian Rogers wrote:
> On Thu, Sep 25, 2025 at 4:26 AM Markus Heidelberg <m.heidelberg@cab.de> wrote:
> >
> > - "the the"
> > - "in in"
> > - "a a"
> >
> > Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
