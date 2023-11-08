Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F07358A2
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvucthBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26D9C433C8;
	Wed,  8 Nov 2023 20:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699475881;
	bh=r/rgBWul9TKz/9RQBIANFTJP7LLteWn6RDHDicGjfd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvucthBH0ksB7fwkkr28pVIvJjcn+pdTAHNZKuN6bhCQC0yqWXS8fsNJ3KrajM1cM
	 3vKeEeVxk7/amJikhzZejFp9VuIRxqken0SBAA8+3WLRYUSwlml2C5OnhOc7uIvLEw
	 LPri22Cp9QgUQn2pUa7YzblfoAZNr7j7tMq0mIhCE+VxtqVQeiACCboDMzzlpdv5D6
	 mvQXpy0ewvNlW9d0vKgR3H48myN5AVgZiME+pkyn2kib8HFL2k133oJsucW4vXuhnO
	 Q664DIKMg7ddQjqxdL2s9KKGQx43YNSBlsMb1f+p2cWnAkKBPU5+o2Te1uA9Urt6B/
	 M5KZ5iJQvN/9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 80CD54035D; Wed,  8 Nov 2023 17:37:59 -0300 (-03)
Date: Wed, 8 Nov 2023 17:37:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, svens@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 PING] perf test: Adjust test case perf record offcpu
 profiling tests for s390
Message-ID: <ZUvxp2IgnS9VjNjR@kernel.org>
References: <20231106091627.2022530-1-tmricht@linux.ibm.com>
 <CAM9d7chpvhDCkTLiuPVqSKxoZdNYgJ0A2HvVdXbEgMvPZrv1Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chpvhDCkTLiuPVqSKxoZdNYgJ0A2HvVdXbEgMvPZrv1Eg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 06, 2023 at 07:21:35AM -0800, Namhyung Kim escreveu:
> On Mon, Nov 6, 2023 at 1:16 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > Lower the number of expected context switches to 400 to succeed on
> > s390.

> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Co-developed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

