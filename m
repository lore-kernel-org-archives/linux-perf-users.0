Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8A31A69
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crQCcXv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2814DC433C8;
	Mon, 27 Nov 2023 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701096686;
	bh=DbMJ84gGLWhKNcAEejc7+WDGOGaKaXiOwyDIz2GZNzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crQCcXv6GxiJfsYXIrpMzBsXIAO2QE+D7SDlD9Be05MP+8d+OGEsQCIsvzqoUjGg1
	 kDcuDY5nGObGjUWKCpQ0+FT5aYIHu1S6OC4fuQay8eNxCgiRLSys8iUfLWAz5M8mzw
	 S31AAtg63HYCMuLIwbla64xPRrx5g3Daty9kWnxVys3rKiYpQz9XJ15veZv+06bokP
	 iAm7NHjhnSWrP4fuP6Vn5WgFJQCwTYJfdja1vd0alTCzlzylwg1Tx8AE3Hy+rgRZgx
	 7/9RoGofOV61ARmxEfe432pMZXG3FNXV1+GLVjGcxV1eIkQS6hTzcRZXLgzb5hYif2
	 G7HPzZJRO2gBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 085AA40094; Mon, 27 Nov 2023 11:51:23 -0300 (-03)
Date: Mon, 27 Nov 2023 11:51:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V4] tools/perf: Add perf binary dependent rule for
 shellcheck log in Makefile.perf
Message-ID: <ZWSs6zn1NqWqzoyC@kernel.org>
References: <20231123160232.94253-1-atrajeev@linux.vnet.ibm.com>
 <e8143e4d-d3ca-88c5-f1c8-b79f70ee5ffa@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8143e4d-d3ca-88c5-f1c8-b79f70ee5ffa@arm.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 27, 2023 at 11:12:57AM +0000, James Clark escreveu:
> On 23/11/2023 16:02, Athira Rajeev wrote:
> > Add rule in new Makefile "tests/Makefile.tests" for running
> > shellcheck on shell test scripts. This automates below shellcheck
> > into the build.

> Seems to work really well. I also tested it on Ubuntu, and checked
> NO_SHELLCHECK, cleaning and with and without shellcheck installed etc.
 
> Reviewed-by: James Clark <james.clark@arm.com>

Tested on Fedora 38, works as advertised, applied.
 
- Arnaldo
