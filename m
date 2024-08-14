Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872F1B4C54
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649756; cv=none; b=ZmXjc8mIZIIvkPY5A8WtQPAkBO0HZSB2R3FBHFZbTtHBea5dDU+10gNjE3E/6LqzhKcdBul5EKY6CEckDpnCuS8KU1eIkNS1IXBmb6J7G5ujl+EUAypkFWD9oMR4IqnPEtRegGh85v34d4Y/3hiAOe4Rw1b64K2fUGxY3k3uQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649756; c=relaxed/simple;
	bh=lU4ilFcNy8RuoBY57DFb45lojL2+GsQSpFC95tedjVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7VvGEl+zdrFP4owlKVx7gEaM8vuOeXVXn6zYX1CZ9vfLhebR0p/8C9FEJHSJETROMwkmfL9AAEgjlptvVReHO1XGYjOWmNoH1r8Qaqwaj/2ZB0lurvjQbDoC4CpcydUaW1Ek5YNuwv1J8gzL0wZYC60/GKQjL4WqMQtkqPudZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED70q5zS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED70q5zS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D36C116B1;
	Wed, 14 Aug 2024 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723649755;
	bh=lU4ilFcNy8RuoBY57DFb45lojL2+GsQSpFC95tedjVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ED70q5zSGkgQGa72ar8GZ9uaNIuSuV1JDiGx9Xv0WHHGd07D/lUB/pYIsi/P/9cSv
	 X3/WQFzeiD8jTGNWttQdWim8KV9UgLs8iEWC6h90ph6yQ0ACXiEWC1dWxFcj+/Spa0
	 uY4nkxoN6pd4tTshIgtlvre8w9wmSFNMrSljnMIj6k7LaNVvp/VsfBZx6d3i1mdybF
	 RzVXHG3Ik1pT7pD2hz5d1SPUZofz+9jZordxZ/U0uTIwPUENC+4oh8WkNMctJSOPpv
	 tqOSTEZtNxEGI0J8xzM0MeFP5cg3xw1KjFcQhXjyK6rp9h+CmMYDgi/+6QXEr1RGCw
	 7rzBmsHjbhohw==
Date: Wed, 14 Aug 2024 12:35:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
	adrian.hunter@intel.com, atrajeev@linux.vnet.ibm.com,
	irogers@google.com, jolsa@kernel.org, kjain@linux.ibm.com,
	mpetlan@redhat.com, rstoyano@redhat.com
Subject: Re: [PATCH v3] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZrzO2T1s_tIpqizG@x1>
References: <20240814151734.15409-1-vmolnaro@redhat.com>
 <ZrzOFDmwl9Z8F8NP@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrzOFDmwl9Z8F8NP@x1>

On Wed, Aug 14, 2024 at 12:32:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Ok? I'm applying it with this change. Thanks,

So I added this to the log message:

Committer notes:

Instead of disabling ShellCheck warnings all the uses of 'uname -n',
i.e. those:

  In tests/shell/record.sh line 35:
  default_fd_limit=$(ulimit -Sn)
                            ^-^ SC3045 (warning): In POSIX sh, ulimit -S is undefined.

We can just switch from using '/bin/sh' to '/bin/bash' for this test, as
bash _has_ 'ulimit -n', so ShellCheck will not emit that warning.

There are dozens of 'perf test' shell tests that do just that,
'/bin/bash' is a reasonable expectation for those tests.

----------------------------------------------------------

Please let me know if you find any issues with this course of action,

Thanks,

- Arnaldo
