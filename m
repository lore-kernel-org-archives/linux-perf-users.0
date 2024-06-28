Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71E1CCCDF
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599297; cv=none; b=ZLsWU+2tHS7/+eXGXvaZ3DWSVdxFVv3Q5PuIZX9NW8G3qcL85eVew25aN6j4jXF/BgPWFLjhE62U4bAai7exdhStTe28QEFG0eDyya59QygQPtn904KgZXsYIVIh9vWk+3hMwkxfN0zDRZVooTFBHjVPuDTrTqhob+HCrxXl3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599297; c=relaxed/simple;
	bh=jbIw7HZheOALV9J8lxPsSdODI5XzqVb4KKE5MS1Ifro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUdeMw5niQU28RTFzosptM6cTRAFY/5BMCLBLZpcXgdHEiaopN5pdQpJ6YPRY+PdYqy0+SMvE6n6VI0d63npMN8nlKv0urAHuf7nWyi57VTWwJ7Trhrt7/2399KmmH1x9yHrubzHBMP1OTdWirYQnctRNaQ9t8SYvRhjk4qVo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqPj61we; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqPj61we"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57598C116B1;
	Fri, 28 Jun 2024 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719599296;
	bh=jbIw7HZheOALV9J8lxPsSdODI5XzqVb4KKE5MS1Ifro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqPj61weuXr0h8vt9GJpkfK1qhd8uUt0Or5yWM2yG+spY/Cq2poBc/eiGOb3gsqzK
	 aUeRGPqSk/cdy0LM8+bPIGKEG4k8RiSae7pujCZjYBOjnA9N25hCYD1m1dPzdykyBp
	 B3F8hDgnr5oY2XJEOHXthVUrn4zj/jpHUVqlCA5zq0X29zlT1fYF1PDGl3g8yH1c2V
	 VhQBQwHkTnw2+3TqKc3Lh+HaU0e7BFicogHO+l6Nohfu1QG3Xd0Xdlhx1EFs8u6oEK
	 BAgp7wi49kNLfG0PGIoJ5BV+mkKRAN114kPVFScXi+KnxCK5+N9kkpSKOF8uX9y5LS
	 6EWz2ruTK3YEA==
Date: Fri, 28 Jun 2024 11:28:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Gupta <adityag@linux.ibm.com>, jolsa@kernel.org,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <Zn8AvuvyjXFGa90c@google.com>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1>
 <Zn7GsEKwLxn5bMyN@x1>
 <Zn7HtaJb3NL2k5YG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn7HtaJb3NL2k5YG@x1>

On Fri, Jun 28, 2024 at 11:24:53AM -0300, Arnaldo Carvalho de Melo wrote:

> And while looking at it:
> 
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> 
> This looks wrong, no? Or at least confusing, have to check the source
> code...

We have this in Makefile.config

ifndef NO_AUXTRACE
  ifeq ($(SRCARCH),x86)
    ifeq ($(feature-get_cpuid), 0)
      $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
      NO_AUXTRACE := 1
    endif
  endif

Thanks,
Namhyung

