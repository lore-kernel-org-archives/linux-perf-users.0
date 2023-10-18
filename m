Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67047357
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDS/35HE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D64CC433C9;
	Wed, 18 Oct 2023 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697654184;
	bh=oj/Gxl+fLdGo+eNC3vzU8JrMSOEsF3xtOMPHWeR2b8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDS/35HE1wlbRoOT79gwPPsQBx0wqgyQhBy0Hcan4zMo5qPCmfw25XfjjKls/2Xkk
	 EAZOBYXqvAzHh6uJW9SPBR+WOsPggYnbYLF1dePQpuTlVO33yjej7CdDoMVRlythyd
	 0fKWbdPvmbXFyBIzBRP6wob1QWIXwMIt2AYvw9IUxP4+bbZqo4h/LDRc6KoqHTMH1n
	 gtIuZ+fx1PPI0htKRUpzbqKP4w1dz5k8O5v9UPMGKj5wh34rKjJlVY9l3rkKcrieyv
	 GY3uKs09ysVwji7pPkz9NUkuhDHux6K1Cdg0X5dTXJ3Mnkc26vQmK01S9HRRzSEhT0
	 qA2RGsb+F/JNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 4245340016; Wed, 18 Oct 2023 15:36:21 -0300 (-03)
Date: Wed, 18 Oct 2023 15:36:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Guilherme Amadio <amadio@gentoo.org>, linux-perf-users@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, robert.richter@amd.com
Subject: Re: NMI received for unknown reason when running perf with IBS on AMD
Message-ID: <ZTAlpUfk8zdg+EZc@kernel.org>
References: <ZS0l-k1MASK3547Q@gentoo.org>
 <ZS2vu8bSBS1/zseZ@kernel.org>
 <9d885140-f952-0018-304d-fbc1e15c33a7@amd.com>
 <ZS6Ds+rB2IwWmXML@kernel.org>
 <f48256a1-d165-de5b-06e8-29646218955a@amd.com>
 <ZS/k3CSP1g3T27NG@kernel.org>
 <1da634d1-9b2d-c982-a0bd-1b0d5677644a@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da634d1-9b2d-c982-a0bd-1b0d5677644a@amd.com>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 18, 2023 at 09:22:26PM +0530, Ravi Bangoria escreveu:
> >>>>> [root@five ~]# perf report --header-only | grep "cpu pmu capabilities"
> >>>>> # cpu pmu capabilities: max_precise=0
> >>> ...
> >>> If we can programatically detect that IBS is present we can add a note
> >>> right after that 'perf report --header-only' line with this information.
> >>
> >> This should be easy to implement.
> > 
> > Yeah, I took at stab at it, see the patch below:
> 
> Looks good. Thanks!
> 
> Ravi

Thanks for checking, I'll submit it properly and will have your Acked-by
there then,

- Arnaldo
